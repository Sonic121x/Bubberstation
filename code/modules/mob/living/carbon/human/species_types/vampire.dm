
///how many vampires exist in each house
#define VAMPIRES_PER_HOUSE 5
///maximum a vampire will drain, they will drain less if they hit their cap
#define VAMP_DRAIN_AMOUNT 50

/datum/species/human/vampire
	name = "吸血鬼"
	id = SPECIES_VAMPIRE
	examine_limb_id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_BLOOD_CLANS,
		TRAIT_USES_SKINTONES,
		TRAIT_NO_MIRROR_REFLECTION,
		TRAIT_UNHOLY_BANEABLE, //still baned by silver even if they get a different heart
	)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | MIRROR_PRIDE | WABBAJACK | ERT_SPAWN
	exotic_bloodtype = BLOOD_TYPE_VAMPIRE
	blood_deficiency_drain_rate = BLOOD_DEFICIENCY_MODIFIER // vampires already passively lose blood, so this just makes them lose it slightly more quickly when they have blood deficiency.
	mutantheart = /obj/item/organ/heart/vampire
	mutanttongue = /obj/item/organ/tongue/vampire
	///some starter text sent to the vampire initially, because vampires have shit to do to stay alive
	var/info_text = "你是一名<span class='danger'>吸血鬼</span>。在棺材外时，你会缓慢但持续地失血。待在棺材里时，你会缓慢痊愈。你可以抓住活着的受害者并使用吸血能力来补充血液。"

/datum/species/human/vampire/check_roundstart_eligible()
	if(check_holidays(HALLOWEEN))
		return TRUE
	return ..()

/datum/species/human/vampire/on_species_gain(mob/living/carbon/human/new_vampire, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	to_chat(new_vampire, "[info_text]")
	new_vampire.skin_tone = "albino"
	RegisterSignal(new_vampire, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))
	RegisterSignal(new_vampire, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	if(new_vampire.hud_used)
		on_hud_created(new_vampire)

/datum/species/human/vampire/on_species_loss(mob/living/carbon/human/old_vampire, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(old_vampire, list(
		COMSIG_MOB_HUD_CREATED,
		COMSIG_LIVING_LIFE,
	))
	old_vampire.hud_used?.remove_screen_object(HUD_MOB_BLOOD_LEVEL)

/datum/species/human/vampire/proc/on_life(mob/living/carbon/human/vampire, seconds_per_tick)
	SIGNAL_HANDLER
	if(istype(vampire.loc, /obj/structure/closet/crate/coffin))
		var/need_mob_update = FALSE
		need_mob_update += vampire.heal_overall_damage(brute = 2 * seconds_per_tick, burn = 2 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
		need_mob_update += vampire.adjust_tox_loss(-2 * seconds_per_tick, updating_health = FALSE,)
		need_mob_update += vampire.adjust_oxy_loss(-2 * seconds_per_tick, updating_health = FALSE,)
		if(need_mob_update)
			vampire.updatehealth()
		return
	vampire.adjust_blood_volume(-0.125 * seconds_per_tick)
	if(vampire.get_blood_volume(apply_modifiers = TRUE) <= BLOOD_VOLUME_SURVIVE)
		to_chat(vampire, span_danger("你的血液耗尽了！"))
		vampire.investigate_log("因失血而化为灰烬（吸血鬼）。", INVESTIGATE_DEATHS)
		vampire.dust()
	var/area/A = get_area(vampire)
	if(istype(A, /area/station/service/chapel))
		to_chat(vampire, span_warning("这里不是你应该来的地方！"))
		vampire.adjust_fire_loss(10 * seconds_per_tick)
		vampire.adjust_fire_stacks(3 * seconds_per_tick)
		vampire.ignite_mob()

///Gives the blood HUD to the vampire so they always know how much blood they have.
/datum/species/human/vampire/proc/on_hud_created(mob/source)
	SIGNAL_HANDLER
	source.hud_used.add_screen_object(/atom/movable/screen/blood_level, HUD_MOB_BLOOD_LEVEL, HUD_GROUP_INFO, update_screen = TRUE)

/datum/species/human/vampire/get_physical_attributes()
	return "吸血鬼饱受“渴血”之苦，必须吸取其他生物的血来缓解。不过，他们无需正常呼吸或进食。\
		一旦血液耗尽或进入神圣区域，他们会立刻化为灰烬。不过，棺材能稳定并治愈他们，而且他们还能变成蝙蝠！"

/datum/species/human/vampire/get_species_description()
	return "一位优雅的吸血鬼！他们每年都会降临十三号空间站，吓唬船员们！“Bleeg！！”"

/datum/species/human/vampire/get_species_lore()
	return list(
		"吸血鬼是受“渴血”祝福与诅咒的邪恶存在。\
		“渴血”迫使他们以血液为食才能存活，作为回报，也赋予他们许多增益。\
		正因如此，吸血鬼分裂为两个氏族，一个将其力量视为祝福而欣然接受，另一个则予以拒绝。",
	)

/datum/species/human/vampire/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bed",
			SPECIES_PERK_NAME = "棺中沉思",
			SPECIES_PERK_DESC = "吸血鬼可以通过在棺材中休息来延缓“渴血”并治愈自身。原来他们那样做是这个原因！",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "book-dead",
			SPECIES_PERK_NAME = "吸血鬼氏族",
			SPECIES_PERK_DESC = "吸血鬼属于两个氏族之一——受礼者与弃族。弃族 \
				不遵循许多吸血鬼传统，而受礼者则拥有独特的名字与风味。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "cross",
			SPECIES_PERK_NAME = "逆神悖理",
			SPECIES_PERK_DESC = "几乎所有更高存在都厌恶 \
				吸血鬼的存在，进入教堂无异于自杀。千万别这么做！",
		),
	)

	return to_add

// Vampire blood is special, so it needs to be handled with its own entry.
/datum/species/human/vampire/create_pref_blood_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "tint",
		SPECIES_PERK_NAME = "渴血",
		SPECIES_PERK_DESC = "吸血鬼不进食，而是饱受“渴血”之苦。\
			渴的是什么？血！他们的舌头能抓住他人并 \
			吸食血液，若血液耗尽便会死亡。需要说明的是，喝下谁的 \
			血都无所谓，被吸收后都会转化为你的血 \
			型。",
	))

	return to_add

// There isn't a "Minor Undead" biotype, so we have to explain it in an override (see: dullahans)
/datum/species/human/vampire/create_pref_biotypes_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "skull",
		SPECIES_PERK_NAME = "次级亡灵",
		SPECIES_PERK_DESC = "[name]属于次级亡灵。\
			次级亡灵享有部分死者特权，比如 \
			无需呼吸或进食，但无法获得完全亡灵所拥有的 \
			许多环境免疫。",
	))

	return to_add

/obj/item/organ/tongue/vampire
	name = "吸血鬼牙齿"
	desc = "这是唯一能让你理直气壮说出“我要把你吸干！”的东西。"
	icon_state = "tongue_vampire"
	actions_types = list(/datum/action/item_action/organ_action/vampire)
	organ_traits = list(
		TRAIT_DRINKS_BLOOD,
		// future todo : tie nobreath and nohunger to a vampire organ set bonus
		TRAIT_NOBREATH,
		TRAIT_NOHUNGER,
	)
	COOLDOWN_DECLARE(drain_cooldown)

/obj/item/organ/tongue/vampire/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	RegisterSignal(receiver, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(stab_bloodbag))

/obj/item/organ/tongue/vampire/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(organ_owner, COMSIG_ATOM_ITEM_INTERACTION)

/obj/item/organ/tongue/vampire/proc/stab_bloodbag(mob/living/source, mob/living/user,  obj/item/used_item, list/modifiers)
	SIGNAL_HANDLER

	if(user != source)
		return NONE
	if(!istype(used_item, /obj/item/reagent_containers/blood))
		return NONE
	if(used_item.reagents?.total_volume <= 0)
		to_chat(user, span_warning("[src] 是空的！"))
		return ITEM_INTERACT_BLOCKING

	user.visible_message(
		span_notice("[user] 用锋利的牙齿刺入 [used_item] 并吸干其中的内容物！"),
		span_notice("你用锋利的牙齿刺入 [used_item] 并吸干其中的内容物！"),
		span_hear("你听到刺入的声音！……接着是吸吮声？"),
		COMBAT_MESSAGE_RANGE,
	)
	INVOKE_ASYNC(src, PROC_REF(async_stab_bloodbag), user, used_item)
	return ITEM_INTERACT_BLOCKING

/obj/item/organ/tongue/vampire/proc/async_stab_bloodbag(mob/living/carbon/user, obj/item/reagent_containers/blood/bloodbag, time = 0.5 SECONDS)
	if(!do_after(user, time, bloodbag))
		return

	to_chat(user, span_notice("你吞下了一大口 [src]。"))
	playsound(bloodbag, 'sound/items/drink.ogg', 50, TRUE) //slurp
	bloodbag.reagents.trans_to(user, bloodbag.reagents.maximum_volume * 0.05, transferred_by = user, methods = INGEST)
	if(bloodbag.reagents.total_volume > 0)
		async_stab_bloodbag(user, bloodbag, 1 SECONDS)

/datum/action/item_action/organ_action/vampire
	name = "吸取受害者"
	desc = "从你正被动抓取的任何碳基受害者身上吸取血液。"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "drain_victim"
	background_icon_state = "bg_vampire"

/datum/action/item_action/organ_action/vampire/do_effect(trigger_flags)
	if(!iscarbon(owner))
		return FALSE

	var/mob/living/carbon/user = owner
	var/obj/item/organ/tongue/vampire/licker_drinker = target
	if(!COOLDOWN_FINISHED(licker_drinker, drain_cooldown))
		to_chat(user, span_warning("你刚刚吸过血，等几秒钟！"))
		return FALSE

	if(!iscarbon(user.pulling))
		return FALSE

	var/mob/living/carbon/victim = user.pulling
	if(user.get_blood_volume() >= BLOOD_VOLUME_MAXIMUM)
		to_chat(user, span_warning("你已经饱了！"))
		return FALSE
	if(victim.stat == DEAD)
		to_chat(user, span_warning("你需要一个活着的受害者！"))
		return FALSE
	var/blood_name = LOWER_TEXT(user.get_bloodtype()?.get_blood_name())
	if(!victim.get_blood_volume() || victim.get_blood_reagent() != user.get_blood_reagent())
		if (blood_name)
			to_chat(user, span_warning("[victim] 没有 [blood_name]！"))
		else
			to_chat(user, span_warning("[victim] 体内没有你能咽得下去的东西！"))
		return FALSE
	COOLDOWN_START(licker_drinker, drain_cooldown, 3 SECONDS)
	if(victim.can_block_magic(MAGIC_RESISTANCE_HOLY, charge_cost = 0))
		victim.show_message(span_warning("[user] 试图咬你，但在碰到你之前停了下来！"))
		to_chat(user, span_warning("[victim] 受到祝福！你及时收手，才没有着火。"))
		return FALSE
	if(victim.has_reagent(/datum/reagent/consumable/garlic))
		victim.show_message(span_warning("[user] 试图咬你，却厌恶地缩了回去！"))
		to_chat(user, span_warning("[victim] 身上一股大蒜味！你实在下不了口去吸这样被污染的血。"))
		return FALSE
	if(!do_after(user, 3 SECONDS, target = victim, cog_icon = null))
		return FALSE

	victim.show_message(span_danger("[user] 正在吸取你的血液！"))
	to_chat(user, span_notice("你吸到了一些血液！"))
	playsound(user, 'sound/items/drink.ogg', 30, TRUE, -2)

	// Since we adjust the user first, we need to take the victim's blood volume into account.
	var/amount_drained = min(VAMP_DRAIN_AMOUNT, victim.get_blood_volume())

	// Takes into account how much blood the vampire can take.
	amount_drained = user.adjust_blood_volume(amount_drained)

	victim.adjust_blood_volume(-amount_drained)

	if(!victim.get_blood_volume())
		to_chat(user, span_notice("你吸干了 [victim] 最后的 [blood_name]。"))
	return TRUE

/obj/item/organ/heart/vampire
	name = "吸血鬼心脏"
	icon_state = "heart_vampire"
	desc = "六千年前有个人捅了自己的兄弟，所以你现在有了这个。"
	organ_traits = list(TRAIT_UNHOLY_BANEABLE)

#undef VAMPIRES_PER_HOUSE
#undef VAMP_DRAIN_AMOUNT
