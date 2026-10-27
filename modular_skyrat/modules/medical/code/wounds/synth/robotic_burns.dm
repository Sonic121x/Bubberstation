#define OVERHEAT_ON_STASIS_HEAT_MULT 0.25

/datum/wound_pregen_data/burnt_metal
	abstract = TRUE
	required_limb_biostate = BIO_METAL
	required_wounding_type = WOUND_BURN
	wound_series = WOUND_SERIES_METAL_BURN_OVERHEAT

/datum/wound_pregen_data/burnt_metal/generate_scar_priorities()
	return list("[BIO_METAL]")

/datum/wound/burn/robotic/overheat
	treat_text = "引入低温环境或降低体温。"
	treat_text_short = "用低温化学物质给患者降温，或把患者放到淋浴下。"
	simple_desc = "金属过热，显著增加受到的伤害并升高体温！"
	simple_treat_text = "最好使用<b>低温医疗舱</b>，但任何能降低<b>体温</b>的方式都可行。用<b>喷雾瓶/灭火器/淋浴</b>喷洒\
	能迅速冷却肢体，但会<b>造成损伤</b>。<b>赫库里</b>在快速降温方面<b>尤其有效</b>。\
	<b>衣物</b>会减少到达金属的水/赫库里，而<b>纱布</b>能将其束缚住并<b>减少</b>受到的<b>损伤</b>。"
	homemade_treat_text = "你也可以往上面泼<b>任何液体</b>，作为相当<b>低效</b>且<b>会造成损伤</b>的冷却方式！"

	default_scar_file = METAL_SCAR_FILE

	wound_flags = (ACCEPTS_GAUZE|SPLINT_OVERLAY|CAN_BE_GRASPED) // gauze binds the metal and makes it resistant to thermal shock

	processes = TRUE

	/// The virtual temperature of the chassis. Crucial for many things, like our severity, the temp we transfer, our cooling damage, etc.
	var/chassis_temperature

	/// The lower bound of the chassis_temperature we can start with.
	var/starting_temperature_min = (BODYTEMP_NORMAL + 200)
	/// The upper bound of the chassis_temperature we can start with.
	var/starting_temperature_max = (BODYTEMP_NORMAL + 250)

	/// If [chassis_temperature] goes below this, we reduce in severity.
	var/cooling_threshold = (BODYTEMP_NORMAL + 3)
	/// If [chassis_temperature] goes above this, we increase in severity.
	var/heating_threshold = (BODYTEMP_NORMAL + 300)

	/// The buffer in kelvin we will subtract from the chassis_temperature of a wound we demote to.
	var/cooling_demote_buffer = 60
	/// The buffer in kelvin we will add to the chassis_temperature of a wound we promote to.
	var/heating_promote_buffer = 60

	/// The coefficient of heat transfer we will use when shifting our temp to the victim's.
	var/bodytemp_coeff = 0.04
	/// For every degree below normal bodytemp, we will multiply our incoming temperature by 1 + degrees * this. Allows incentivization of freezing yourself instead of just waiting.
	var/bodytemp_difference_expose_bonus_ratio = 0.035
	/// The coefficient of heat transfer we will use when shifting our victim's temp to ours.
	var/outgoing_bodytemp_coeff = 0
	/// The mult applied to heat output when we are on a important limb, e.g. head/torso.
	var/important_outgoing_mult = 1.2
	/// The coefficient of heat transfer we will use when shifting our temp to a turf.
	var/turf_coeff = 0.02

	/// The maximum temperature we can cause by heating our victim.
	var/max_outgoing_temperature = BODYTEMP_HEAT_WOUND_LIMIT - 1

	/// If we are hit with burn damage, the damage will be multiplied against this to determine the effective heat we get.
	var/incoming_damage_heat_coeff = 3

	/// The coefficient of heat transfer we will use when receiving heat from reagent contact.
	var/base_reagent_temp_coefficient = 0.02

	/// The ratio of temp shift -> brute damage. Careful with this value, it can make stuff really really nasty.
	var/heat_shock_delta_to_damage_ratio = 0.12
	/// The minimum heat difference we must have on reagent contact to cause heat shock damage.
	var/heat_shock_minimum_delta = 5

	/// If we are sprayed with a extinguisher/shower with obscuring clothing on (think clothing that prevents surgery), the effect is multiplied against this.
	var/sprayed_with_reagent_clothed_mult = 0.15

	/// The wound we demote to when we go below cooling threshold. If null, removes us.
	var/datum/wound/burn/robotic/demotes_to
	/// The wound we promote to when we go above heating threshold.
	var/datum/wound/burn/robotic/promotes_to

	/// The color of the light we will generate.
	var/light_color
	/// The power of the light we will generate.
	var/light_power
	/// The range of the light we will generate.
	var/light_range

	/// The glow we have attached to our victim, to simulate our limb glowing.
	var/obj/effect/dummy/lighting_obj/moblight/mob_glow

	/// A bad system I'm using to track the worst scar we earned (since we can demote, we want the biggest our wound has been, not what it was when it was cured (probably moderate))
	var/datum/scar/highest_scar

	/// A assoc list of (reagent typepath -> cooling), where cooling is how much its presence will reduce the effective temperature of a reagent spray for cooling us.
	var/static/list/reagent_types_to_extra_cooling = list(
		/datum/reagent/medicine/c2/hercuri = 60,
		/datum/reagent/dinitrogen_plasmide = 50,
	)

	/// A assoc list of (reagent typepath -> damage mult), where the mult will be multiplied against the thermal shock damage.
	var/static/list/reagent_types_to_thermal_shock_mult = list(
		/datum/reagent/medicine/c2/hercuri = 0.3,
		/datum/reagent/dinitrogen_plasmide = 0.6,
	)

/datum/wound/burn/robotic/overheat/New(temperature)
	chassis_temperature = (isnull(temperature) ? get_random_starting_temperature() : temperature)

	return ..()

/datum/wound/burn/robotic/overheat/wound_injury(datum/wound/old_wound, attack_direction)
	. = ..()

	if (old_wound && old_wound.severity > severity && istype(old_wound, /datum/wound/burn/robotic/overheat))
		var/datum/wound/burn/robotic/overheat/overheat_wound = old_wound
		if (overheat_wound.highest_scar)
			set_highest_scar(overheat_wound.highest_scar)
			overheat_wound.clear_highest_scar()

	if (!highest_scar && can_scar)
		var/datum/scar/new_scar = new
		set_highest_scar(new_scar)
		new_scar.generate(limb, src, add_to_scars = FALSE)

/datum/wound/burn/robotic/overheat/proc/set_highest_scar(datum/scar/new_scar)
	if (highest_scar)
		UnregisterSignal(highest_scar, COMSIG_QDELETING)
	if (new_scar)
		RegisterSignal(new_scar, COMSIG_QDELETING, PROC_REF(clear_highest_scar))
	highest_scar = new_scar

/datum/wound/burn/robotic/overheat/proc/clear_highest_scar(datum/source)
	SIGNAL_HANDLER

	set_highest_scar(null)

/datum/wound/burn/robotic/overheat/remove_wound(ignore_limb, replaced, destroying)
	if (!replaced && highest_scar)
		already_scarred = TRUE
		highest_scar.lazy_attach(limb)
	return ..()

/datum/wound/burn/robotic/overheat/Destroy()
	QDEL_NULL(mob_glow)

	highest_scar = null
	return ..()

/datum/wound/burn/robotic/overheat/set_victim(mob/living/new_victim)
	if (victim)
		QDEL_NULL(mob_glow)
		UnregisterSignal(victim, COMSIG_MOB_AFTER_APPLY_DAMAGE)
		UnregisterSignal(victim, COMSIG_ATOM_EXPOSE_REAGENTS)
	if (new_victim)
		mob_glow = new_victim.mob_light(light_range, light_power, light_color)
		mob_glow.set_light_on(TRUE)
		RegisterSignal(new_victim, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(victim_attacked))
		RegisterSignal(new_victim, COMSIG_ATOM_EXPOSE_REAGENTS, PROC_REF(victim_exposed_to_reagents))

	return ..()

/datum/wound/burn/robotic/overheat/proc/get_random_starting_temperature()
	return LERP(starting_temperature_min, starting_temperature_max, rand()) // LERP since we deal with decimals

/datum/wound/burn/robotic/get_limb_examine_description()
	return span_warning("这条肢体上的金属正发出明亮的光。")

/datum/wound/burn/robotic/overheat/handle_process(seconds_per_tick)
	if (isnull(victim))
		var/turf/our_turf = get_turf(limb)
		if (!isnull(our_turf))
			expose_temperature(our_turf.GetTemperature(), (turf_coeff * seconds_per_tick))
		return
	if (outgoing_bodytemp_coeff <= 0)
		return
	var/statis_mult = 1
	if (HAS_TRAIT(victim, TRAIT_STASIS)) // stasis heavily reduces the ingoing and outgoing transfer of heat
		statis_mult *= OVERHEAT_ON_STASIS_HEAT_MULT

	var/difference_from_average = max((BODYTEMP_NORMAL - victim.bodytemperature), 0)
	var/difference_mult = 1 + (difference_from_average * bodytemp_difference_expose_bonus_ratio)
	if (expose_temperature(victim.bodytemperature, (bodytemp_coeff * seconds_per_tick * statis_mult * difference_mult)))
		return
	var/mult = outgoing_bodytemp_coeff
	if (limb_essential())
		mult *= important_outgoing_mult
	var/adjustment_allowed = max((max_outgoing_temperature - victim.bodytemperature), 0)
	var/amount_to_adjust = min((((chassis_temperature - victim.bodytemperature) * mult) * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick * statis_mult), adjustment_allowed)
	victim.adjust_bodytemperature(amount_to_adjust)

/// Signal proc for when our victim is externally attacked. Increases chassis temp based on burn damage received.
/datum/wound/burn/robotic/overheat/proc/victim_attacked(datum/source, damage, damagetype, def_zone, blocked, wound_bonus, exposed_wound_bonus, sharpness, attack_direction, attacking_item)
	SIGNAL_HANDLER

	if (def_zone != limb.body_zone) // use this proc since receive damage can also be called for like, chems and shit
		return

	if (!victim)
		return

	if (damagetype != BURN)
		return

	if (wound_bonus == CANT_WOUND)
		return

	var/effective_damage = (damage - blocked)
	if (effective_damage <= 0)
		return

	expose_temperature((chassis_temperature + effective_damage), incoming_damage_heat_coeff)

/**
 * Signal proc for when our victim is exposed to reagents, obviously.
 *
 * Equalizes temp to the reagent temp, but also causes thermal shock. Basically, does damage based on the temp differential.
 * Clothes reduce the effects massively. Hercuri reduces the thermal shock and gets a special temp buff.
 */
/datum/wound/burn/robotic/overheat/proc/victim_exposed_to_reagents(datum/signal_source, list/reagents, datum/reagents/source, methods, volume_modifier, show_message)
	SIGNAL_HANDLER

	var/reagent_coeff = base_reagent_temp_coefficient
	if(!victim.is_location_accessible(limb.body_zone))
		if (ishuman(victim))
			// hi! it's niko! small rant
			// this proc has no goddamn reason to be on human, it could so easily just have used a proc on carbon that would get the required bodyparts to check
			// but no. it had to hardcode the list in the proc itself so it's impossible to modularly fix this
			// so instead we just say fuck it and hope to god only human subtypes get this wound
			// tldr; ryll why
			var/mob/living/carbon/human/human_victim = victim
			for (var/obj/item/clothing/iter_clothing as anything in human_victim.get_clothing_on_part(limb))
				if (iter_clothing.clothing_flags & THICKMATERIAL)
					return

		reagent_coeff *= sprayed_with_reagent_clothed_mult

	if (istype(source.my_atom, /obj/effect/particle_effect/water/extinguisher)) // this used to be a lot, lot more modular, but sadly reagent temps/volumes and shit are horribly inconsistant
		expose_temperature(source.chem_temp, (2.55 * reagent_coeff), TRUE)
		return

	if (istype(source.my_atom, /obj/machinery/shower))
		expose_temperature(source.chem_temp, (15 * volume_modifier * reagent_coeff), TRUE)
		return

	var/total_reagent_amount = 0
	var/chem_temp_increment = 0
	var/thermal_shock_mult = 1
	// imperfect, this means you can microdose hercuri/plasmide in a huge tank of water and have the entire effect.
	// really not a big deal, though, they arent really limited by availability
	for (var/datum/reagent/iterated_reagent as anything in reagents)
		total_reagent_amount += reagents[iterated_reagent]
		chem_temp_increment += reagent_types_to_extra_cooling[iterated_reagent.type]
		thermal_shock_mult *= reagent_types_to_thermal_shock_mult[iterated_reagent.type]

	var/local_chem_temp = max(source.chem_temp - chem_temp_increment, 0)

	expose_temperature(local_chem_temp, (reagent_coeff * volume_modifier * total_reagent_amount), TRUE, heat_shock_damage_mult = thermal_shock_mult)

/// Adjusts chassis_temperature by the delta between temperature and itself, multiplied by coeff.
/// If heat_shock is TRUE, limb will receive brute damage based on the delta.
/datum/wound/burn/robotic/overheat/proc/expose_temperature(temperature, coeff = 0.02, heat_shock = FALSE, heat_shock_damage_mult = 1)
	var/temp_delta = (temperature - chassis_temperature) * coeff

	var/unclamped_new_temperature = (chassis_temperature + temp_delta)
	var/clamped_new_temperature
	var/heat_adjustment_used

	if (temp_delta > 0)
		clamped_new_temperature = min(min(chassis_temperature + max(temp_delta, 1), temperature), heating_threshold)
		heat_adjustment_used = (clamped_new_temperature / unclamped_new_temperature)
	else
		clamped_new_temperature = max(max(chassis_temperature + min(temp_delta, -1), temperature), cooling_threshold)
		heat_adjustment_used = (unclamped_new_temperature / clamped_new_temperature)

	if (heat_shock && abs(temp_delta) > heat_shock_minimum_delta)
		var/gauze_mult = 1
		var/obj/item/stack/medical/wrap/gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
		if (gauze)
			gauze_mult *= (gauze.splint_factor) * 0.4 // very very effective

		if (limb.grasped_by)
			gauze_mult *= 0.7 // hold it down yourself

		if (victim)
			var/gauze_or_not = (!isnull(gauze) ? "，不过 [gauze] 能帮忙把它固定住" : "")
			var/clothing_text = (!victim.is_location_accessible(limb.body_zone) ? "，其衣物吸收了一部分液体" : "")
			victim.visible_message(span_warning("[victim] 的[chinese_body_zone_display(limb.plaintext_zone)]因热冲击而绷紧[clothing_text][gauze_or_not]！"))
			playsound(victim, 'sound/items/tools/welder.ogg', 25)

		var/damage = (((abs(temp_delta) * heat_shock_delta_to_damage_ratio) * gauze_mult) * heat_shock_damage_mult) * heat_adjustment_used
		limb.receive_damage(brute = damage, wound_bonus = CANT_WOUND)

	chassis_temperature = clamped_new_temperature // can only be decimal or 1, so it can only reduce the intensity of the adjustment

	return check_temperature()

/// Removes, demotes, or promotes ourselves to a new wound type if our temperature is past a heating/cooling threshold.
/datum/wound/burn/robotic/overheat/proc/check_temperature()
	if (chassis_temperature <= cooling_threshold)
		if (demotes_to)
			victim.visible_message(span_green("[victim] 的[chinese_body_zone_display(limb.plaintext_zone)]在稍微冷却后变成了更悦目的热色……"), span_green("你的[chinese_body_zone_display(limb.plaintext_zone)]似乎稍微冷却了一点！"))
			replace_wound(new demotes_to(cooling_threshold - cooling_demote_buffer))
			return TRUE
		else
			victim.visible_message(span_green("[victim] 的[chinese_body_zone_display(limb.plaintext_zone)]轻轻降温，恢复了原本的颜色！"), span_green("你的[chinese_body_zone_display(limb.plaintext_zone)]轻轻降温，恢复了原本的颜色！"))
			remove_wound()
			return TRUE
	else if (promotes_to && chassis_temperature >= heating_threshold)
		victim.visible_message(span_danger("[victim] 的[chinese_body_zone_display(limb.plaintext_zone)]因进一步过热而变得更亮！"), span_userdanger("你的[chinese_body_zone_display(limb.plaintext_zone)]因进一步过热而嘶嘶作响、越来越亮！"))
		replace_wound(new promotes_to(heating_threshold + heating_promote_buffer))
		return TRUE

/// Returns a string with our temperature and heating/cooling thresholds, for use in health analyzers.
/datum/wound/burn/robotic/overheat/proc/get_wound_status_info()
	var/current_temp_celcius = round(chassis_temperature - T0C, 0.1)
	var/current_temp_fahrenheit = round(chassis_temperature * 1.8-459.67, 0.1)

	var/cool_celcius = round(cooling_threshold - T0C, 0.1)
	var/cool_fahrenheit = round(cooling_threshold * 1.8-459.67, 0.1)

	var/heat_celcius = round(heating_threshold - T0C, 0.1)
	var/heat_fahrenheit = round(heating_threshold * 1.8-459.67, 0.1)

	return "它当前温度为 [span_blue("[current_temp_celcius ] &deg;C（[current_temp_fahrenheit] &deg;F）")]，\
	需要冷却到 [span_nicegreen("[cool_celcius] &deg;C（[cool_fahrenheit] &deg;F）")]，但\
	若加热到 [span_purple("[heat_celcius] &deg;C（[heat_fahrenheit] &deg;F）")] 则会恶化。"

/datum/wound/burn/robotic/overheat/get_scanner_description(mob/user)
	. = ..()

	. += "\n伤口状态：[get_wound_status_info()]"

/datum/wound/burn/robotic/overheat/get_simple_scanner_description(mob/user)
	. = ..()

	. += "\n伤口状态：[get_wound_status_info()]"

// this wound is unaffected by cryoxadone and pyroxadone
/datum/wound/burn/robotic/overheat/on_xadone(power)
	return

/datum/wound/burn/robotic/overheat/moderate
	name = "暂时性过热"
	desc = "外层金属已超出热力下限并失去部分结构完整性，使得受到的伤害增加，\
		也更容易承受额外伤口。"
	occur_text = "随着它变成暗热红色，发出轻微的呻吟声"
	examine_desc = "泛着暗热红光并散发出热量"
	treat_text = "降低体温以加速被动散热——或者，若愿意冒热冲击的风险，可使用灭火器/淋浴。"
	treat_text_short = "在向伤口喷洒冷却剂前先包扎纱布或抓住肢体，或降低体温，或等待。"
	severity = WOUND_SEVERITY_MODERATE

	damage_multiplier_penalty = 1.15 //1.15x damage taken

	starting_temperature_min = (BODYTEMP_NORMAL + 350)
	starting_temperature_max = (BODYTEMP_NORMAL + 400)

	cooling_threshold = (BODYTEMP_NORMAL + 100)
	heating_threshold = (BODYTEMP_NORMAL + 500)

	cooling_demote_buffer = 60
	heating_promote_buffer = 100

	a_or_from = "from"

	// easy to get
	threshold_penalty = 30

	status_effect_type = /datum/status_effect/wound/burn/robotic/moderate

	sound_volume = 20

	outgoing_bodytemp_coeff = 0.0056
	bodytemp_coeff = 0.006

	base_reagent_temp_coefficient = 0.03
	heat_shock_delta_to_damage_ratio = 0.2

	promotes_to = /datum/wound/burn/robotic/overheat/severe

	light_color = COLOR_RED
	light_power = 0.1
	light_range = 0.5

	can_scar = FALSE

/datum/wound_pregen_data/burnt_metal/transient_overheat
	abstract = FALSE

	wound_path_to_generate = /datum/wound/burn/robotic/overheat/moderate

	threshold_minimum = 30

/datum/wound/burn/robotic/overheat/severe
	name = "热过载"
	desc = "外层护板已超过临界热水平，导致结构完整性严重失效，内部系统过热。"
	occur_text = "发出嘶嘶声，外层变成暗橙色"
	examine_desc = "表面变色斑驳，部分区域泛着暗橙色光"
	treat_text = "隔离物理危险源，并配合被动散热——可以使用主动冷却，但温差会显著\
		提高热冲击的风险。"
	treat_text_short = "在向伤口喷洒冷却剂前先包扎纱布并抓住肢体，或降低体温并等待。"
	severity = WOUND_SEVERITY_SEVERE

	a_or_from = "from"

	threshold_penalty = 65

	status_effect_type = /datum/status_effect/wound/burn/robotic/severe
	damage_multiplier_penalty = 1.25 // 1.25x damage taken

	starting_temperature_min = (BODYTEMP_NORMAL + 550)
	starting_temperature_max = (BODYTEMP_NORMAL + 600)

	heating_promote_buffer = 150

	cooling_threshold = (BODYTEMP_NORMAL + 375)
	heating_threshold = (BODYTEMP_NORMAL + 800)

	outgoing_bodytemp_coeff = 0.0053
	bodytemp_coeff = 0.004

	base_reagent_temp_coefficient = 0.03
	heat_shock_delta_to_damage_ratio = 0.2

	demotes_to = /datum/wound/burn/robotic/overheat/moderate
	promotes_to = /datum/wound/burn/robotic/overheat/critical

	light_color = COLOR_BRIGHT_ORANGE
	light_power = 0.8
	light_range = 0.5

	scar_keyword = "burnsevere"

/datum/wound_pregen_data/burnt_metal/severe
	abstract = FALSE
	wound_path_to_generate = /datum/wound/burn/robotic/overheat/severe
	threshold_minimum = 80

/datum/wound/burn/robotic/overheat/critical
	name = "内热失控"
	desc = "外壳已超过熔点，导致结构完整性灾难性失效，并使对象体温大幅升高。"
	occur_text = "随着它嘶嘶作响并熔化，变成刺眼的白亮色"
	examine_desc = "白得刺眼，几乎要被高温熔化"
	treat_text = "立即送入低温医疗舱，否则可能发生急速过热和躯体脆弱。不建议主动冷却，\
		因为在如此巨大的温差下，热冲击可能致命。"
	treat_text_short = "使用低温医疗舱，或在不让其直接接触冷液体的前提下降低体温。"
	severity = WOUND_SEVERITY_CRITICAL

	a_or_from = "from"

	sound_effect = 'sound/effects/wounds/sizzle2.ogg'

	threshold_penalty = 100

	status_effect_type = /datum/status_effect/wound/burn/robotic/critical

	damage_multiplier_penalty = 1.5 //1.5x damage taken

	starting_temperature_min = (BODYTEMP_NORMAL + 1050)
	starting_temperature_max = (BODYTEMP_NORMAL + 1100)

	cooling_demote_buffer = 100

	cooling_threshold = (BODYTEMP_NORMAL + 775)
	heating_threshold = INFINITY

	outgoing_bodytemp_coeff = 0.0055 // burn... BURN...
	bodytemp_coeff = 0.0025

	base_reagent_temp_coefficient = 0.03
	heat_shock_delta_to_damage_ratio = 0.2

	max_outgoing_temperature = BODYTEMP_HEAT_WOUND_LIMIT // critical CAN cause wounds, but only barely

	demotes_to = /datum/wound/burn/robotic/overheat/severe

	wound_flags = (MANGLES_EXTERIOR|ACCEPTS_GAUZE|SPLINT_OVERLAY|CAN_BE_GRASPED)

	light_color = COLOR_VERY_SOFT_YELLOW
	light_power = 1.3
	light_range = 1.5

	scar_keyword = "burncritical"

/datum/wound_pregen_data/burnt_metal/critical
	abstract = FALSE
	wound_path_to_generate = /datum/wound/burn/robotic/overheat/critical
	threshold_minimum = 140

#undef OVERHEAT_ON_STASIS_HEAT_MULT
