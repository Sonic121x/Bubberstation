GLOBAL_VAR_INIT(DNR_trait_overlay, generate_DNR_trait_overlay())

/// Instantiates GLOB.DNR_trait_overlay by creating a new mutable_appearance instance of the overlay.
/proc/generate_DNR_trait_overlay()
	RETURN_TYPE(/mutable_appearance)

	var/mutable_appearance/DNR_trait_overlay = mutable_appearance('modular_skyrat/modules/indicators/icons/DNR_trait_overlay.dmi', "DNR", FLY_LAYER)
	DNR_trait_overlay.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	return DNR_trait_overlay


// SKYRAT NEUTRAL TRAITS
/datum/quirk/excitable
	name = "Excitable!"
	desc = "摸摸头就能让你摇起尾巴！你特别容易兴奋！摇啊摇。"
	gain_text = span_notice("你好想被摸摸头！")
	lose_text = span_notice("你不再那么在意摸头了。")
	medical_record_text = "患者似乎很容易兴奋。"
	value = 0
	mob_trait = TRAIT_EXCITABLE
	icon = FA_ICON_LAUGH_BEAM

/datum/quirk/affectionaversion
	name = "Affection Aversion"
	desc = "你拒绝被四足半机械人舔舐或用鼻子蹭。"
	gain_text = span_notice("你已被加入禁止舔舐和鼻蹭的名单。")
	lose_text = span_notice("你已从禁止舔舐和鼻蹭的名单中移除。")
	medical_record_text = "患者在禁止舔舐和鼻蹭的名单上。"
	value = 0
	mob_trait = TRAIT_AFFECTION_AVERSION
	icon = FA_ICON_CIRCLE_EXCLAMATION

/datum/quirk/personalspace
	name = "Personal Space"
	desc = "你希望别人别把手放到你的屁股上。"
	gain_text = span_notice("你希望别人别碰你的屁股。")
	lose_text = span_notice("你不再那么介意别人触碰你的屁股。")
	medical_record_text = "患者的臀部受到触碰时会表现出反感。"
	value = 0
	mob_trait = TRAIT_PERSONALSPACE
	icon = FA_ICON_HAND_PAPER

/datum/quirk/dnr
	name = "Do Not Revive"
	desc = "出于某种原因，你无法通过任何方式复活。"
	gain_text = span_notice("你的灵魂伤痕累累，已无法接受复活。")
	lose_text = span_notice("你感觉自己的灵魂正在重新愈合。")
	medical_record_text = "患者具有禁止复苏标记，无法通过任何方式复活。"
	value = 0
	mob_trait = TRAIT_DNR
	icon = FA_ICON_SKULL_CROSSBONES

/datum/quirk/dnr/add(client/client_source)
	. = ..()

	quirk_holder.update_dnr_hud()

/datum/quirk/dnr/remove()
	var/mob/living/old_holder = quirk_holder

	. = ..()

	old_holder.update_dnr_hud()

/mob/living/prepare_data_huds()
	. = ..()

	update_dnr_hud()

/// Adds the DNR HUD element if src has TRAIT_DNR. Removes it otherwise.
/mob/living/proc/update_dnr_hud()
	var/image/dnr_holder = hud_list?[DNR_HUD]
	if(isnull(dnr_holder))
		return

	var/icon/temporary_icon = icon(icon, icon_state, dir)
	dnr_holder.pixel_y = temporary_icon.Height() - world.icon_size

	if(HAS_TRAIT(src, TRAIT_DNR))
		set_hud_image_active(DNR_HUD)
		dnr_holder.icon_state = "hud_dnr"
	else
		set_hud_image_inactive(DNR_HUD)

/mob/living/carbon/human/examine(mob/user)
	. = ..()

	if(stat != DEAD && HAS_TRAIT(src, TRAIT_DNR) && (HAS_TRAIT(user, TRAIT_SECURITY_HUD) || HAS_TRAIT(user, TRAIT_MEDICAL_HUD)))
		. += "\n[span_boldwarning("此人无法复活，一旦死亡便可能永久离世！")]"

/datum/atom_hud/data/human/dnr
	hud_icons = list(DNR_HUD)

// uncontrollable laughter
/datum/quirk/item_quirk/joker
	name = "Pseudobulbar Affect"
	desc = "你会不时突然发出无法控制的大笑。"
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_PROCESSES
	medical_record_text = "患者会突然发出无法控制的大笑。"
	var/pcooldown = 0
	var/pcooldown_time = 60 SECONDS
	icon = FA_ICON_GRIN_TEARS

/datum/quirk/item_quirk/joker/add_unique(client/client_source)
	give_item_to_holder(/obj/item/paper/joker, list(LOCATION_BACKPACK, LOCATION_HANDS))

/datum/quirk/item_quirk/joker/process()
	if(pcooldown > world.time)
		return
	pcooldown = world.time + pcooldown_time
	var/mob/living/carbon/human/user = quirk_holder
	if(user && istype(user))
		if(!IS_UNCONSCIOUS(user))
			if(prob(20))
				user.emote("laugh")
				addtimer(CALLBACK(user, /mob/proc/emote, "laugh"), 5 SECONDS)
				addtimer(CALLBACK(user, /mob/proc/emote, "laugh"), 10 SECONDS)

/obj/item/paper/joker
	name = "病情说明卡"
	icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	icon_state = "joker"
	desc = "即使心如刀绞，也请保持微笑。"
	default_raw_text = "<i>\
			<div style='border-style:solid;text-align:center;border-width:5px;margin: 20px;margin-bottom:0px'>\
			<div style='margin-top:20px;margin-bottom:20px;font-size:150%;'>\
			请原谅我的笑声：<br>\
			我患有一种疾病。\
			</div>\
			</div>\
			</i>\
			<br>\
			<center>\
			<b>\
			详情见背面\
			</b>\
			</center>"
	/// Whether or not the card is currently flipped.
	var/flipped = FALSE
	/// The flipped version of default_raw_text.
	var/flipside_default_raw_text = "<i>\
			<div style='border-style:solid;text-align:center;border-width:5px;margin: 20px;margin-bottom:0px'>\
			<div style='margin-top:20px;margin-bottom:20px;font-size:100%;'>\
			<b>\
			这种疾病会导致患者突然、<br>\
			频繁且无法控制地大笑，<br>\
			这与其实际感受并不相符。<br>\
			脑损伤患者或某些神经系统<br>\
			疾病患者可能出现这种症状。<br>\
			</b>\
			</div>\
			</div>\
			</i>\
			<br>\
			<center>\
			<b>\
			请归还此卡\
			</b>\
			</center>"
	/// Flipside version of raw_text_inputs.
	var/list/datum/paper_input/flipside_raw_text_inputs
	/// Flipside version of raw_stamp_data.
	var/list/datum/paper_stamp/flipside_raw_stamp_data
	/// Flipside version of raw_field_input_data.
	var/list/datum/paper_field/flipside_raw_field_input_data
	/// Flipside version of input_field_count
	var/flipside_input_field_count = 0


/obj/item/paper/joker/Initialize(mapload)
	. = ..()
	if(flipside_default_raw_text)
		add_flipside_raw_text(flipside_default_raw_text)


/**
 * This is an unironic copy-paste of add_raw_text(), meant to have the same functionalities, but for the flipside.
 *
 * This simple helper adds the supplied raw text to the flipside of the paper, appending to the end of any existing contents.
 *
 * This a God proc that does not care about paper max length and expects sanity checking beforehand if you want to respect it.
 *
 * The caller is expected to handle updating icons and appearance after adding text, to allow for more efficient batch adding loops.
 * * Arguments:
 * * text - The text to append to the paper.
 * * font - The font to use.
 * * color - The font color to use.
 * * bold - Whether this text should be rendered completely bold.
 */
/obj/item/paper/joker/proc/add_flipside_raw_text(text, font, color, bold)
	var/new_input_datum = new /datum/paper_input(
		text,
		font,
		color,
		bold,
	)

	flipside_input_field_count += get_input_field_count(text)

	LAZYADD(flipside_raw_text_inputs, new_input_datum)


/obj/item/paper/joker/update_icon()
	..()
	icon_state = "joker"

/obj/item/paper/joker/click_alt(mob/user)
	var/list/datum/paper_input/old_raw_text_inputs = raw_text_inputs
	var/list/datum/paper_stamp/old_raw_stamp_data = raw_stamp_data
	var/list/datum/paper_stamp/old_raw_field_input_data = raw_field_input_data
	var/old_input_field_count = input_field_count

	raw_text_inputs = flipside_raw_text_inputs
	raw_stamp_data = flipside_raw_stamp_data
	raw_field_input_data = flipside_raw_field_input_data
	input_field_count = flipside_input_field_count

	flipside_raw_text_inputs = old_raw_text_inputs
	flipside_raw_stamp_data = old_raw_stamp_data
	flipside_raw_field_input_data = old_raw_field_input_data
	flipside_input_field_count = old_input_field_count

	flipped = !flipped
	update_static_data()

	balloon_alert(user, "已翻转卡片")
	return CLICK_ACTION_SUCCESS

/datum/quirk/felinid_aspect
	name = "Felinid Traits"
	desc = "出于某种原因，你的行为像猫人一样。这会替换其他与舌头有关的特质。"
	gain_text = span_notice("喵，现在真想来点猫薄荷……")
	lose_text = span_notice("激光对你的吸引力减弱了。")
	medical_record_text = "患者的行为似乎与猫人十分相似。"
	mob_trait = TRAIT_FELINID
	icon = FA_ICON_CAT

/datum/quirk/felinid_aspect/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/cat/new_tongue = new(get_turf(human_holder))

	new_tongue.copy_traits_from(human_holder.get_organ_slot(ORGAN_SLOT_TONGUE))
	new_tongue.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/quirk/item_quirk/canine
	name = "Canidae Traits"
	desc = "汪。出于某种原因，你的行为像犬类一样。这会替换大部分与舌头有关的说话特质。"
	mob_trait = TRAIT_CANINE
	icon = FA_ICON_DOG
	value = 0
	medical_record_text = "曾看到患者翻找垃圾桶。请多加留意。"

/datum/quirk/item_quirk/canine/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/dog/new_tongue = new(get_turf(human_holder))

	new_tongue.copy_traits_from(human_holder.get_organ_slot(ORGAN_SLOT_TONGUE))
	new_tongue.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/quirk/item_quirk/avian
	name = "Avian Traits"
	desc = "你是个鸟脑袋，或者真的长着鸟类的大脑。这会替换大部分与舌头有关的说话特质。"
	mob_trait = TRAIT_AVIAN
	icon = FA_ICON_KIWI_BIRD
	value = 0
	medical_record_text = "患者表现出类似鸟类的举止。"

/datum/quirk/item_quirk/avian/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/avian/new_tongue = new(get_turf(human_holder))

	new_tongue.copy_traits_from(human_holder.get_organ_slot(ORGAN_SLOT_TONGUE))
	new_tongue.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/quirk/item_quirk/bovine
	name = "Bovine Traits"
	desc = "哞。出于某种原因，你的行为像牛类一样。这会替换大部分与舌头有关的说话特质。"
	mob_trait = TRAIT_BOVINE
	icon = FA_ICON_COW
	value = 0
	medical_record_text = "患者表现出类似牛类的举止。"

/datum/quirk/item_quirk/bovine/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/bovine/new_tongue = new(get_turf(human_holder))

	new_tongue.copy_traits_from(human_holder.get_organ_slot(ORGAN_SLOT_TONGUE))
	new_tongue.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

///Start of Mouse Traits
/datum/quirk/item_quirk/mouse
	name = "Muridae Traits"
	desc = "你一直觉得那些笑话奶酪味十足。这会替换大部分与舌头有关的说话特质。"
	mob_trait = TRAIT_MURIDAE
	icon = FA_ICON_CHEESE
	value = 0
	medical_record_text = "患者对乳制品和糟糕的双关笑话有着难以满足的热爱。"
	var/datum/action/cooldown/spell/sniff/sniff_food

/datum/quirk/item_quirk/mouse/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/mouse/new_tongue = new(get_turf(human_holder))
	human_holder.add_faction(FACTION_RAT)
	human_holder.gain_trauma(new /datum/brain_trauma/mild/phobia/mousetraps, TRAUMA_RESILIENCE_ABSOLUTE)

	new_tongue.copy_traits_from(human_holder.get_organ_slot(ORGAN_SLOT_TONGUE))
	new_tongue.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/quirk/item_quirk/mouse/add(client/client_source)
	. = ..()

	sniff_food = new()
	sniff_food.Grant(quirk_holder)

/datum/quirk/item_quirk/mouse/remove()
	. = ..()

	if(QDELETED(quirk_holder))
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.cure_trauma_type(/datum/brain_trauma/mild/phobia/mousetraps, TRAUMA_RESILIENCE_ABSOLUTE)
	QDEL_NULL(sniff_food)

/datum/action/cooldown/spell/sniff
	name = "嗅闻食物"
	desc = "人人都能下厨！"
	button_icon_state = "food_french"
	button_icon = 'icons/hud/screen_alert.dmi'
	cooldown_time = 10 SECONDS
	spell_requirements = NONE
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_INCAPACITATED

/datum/action/cooldown/spell/sniff/cast(mob/living/caster)
	. = ..()
	try_sniff_item(caster)

// tries to check if the obj is valid to sniff
/datum/action/cooldown/spell/sniff/proc/can_sniff(obj/item/food/potential_food, mob/living/caster)
	if(potential_food.food_flags & ABSTRACT)
		return FALSE
	return TRUE

// tries to sniff item in hand
/datum/action/cooldown/spell/sniff/proc/try_sniff_item(mob/living/caster)
	var/obj/item/food/potential_food = caster.get_active_held_item()
	if(!istype(potential_food))
		if(caster.get_inactive_held_item())
			to_chat(caster, span_warning("你必须拿着食物！"))
		else
			to_chat(caster, span_warning("你手里没有任何能用作食材的东西！"))
		return FALSE
	if(!can_sniff(potential_food, caster))
		return FALSE
	caster.balloon_alert_to_viewers("正在嗅闻……")
	to_chat(caster, span_notice("你开始判断 [potential_food] 有哪些烹饪用途……"))
	if(!do_after(caster, 5 SECONDS, potential_food))
		to_chat(caster, span_notice("你还没闻清 [potential_food] 的气味。"))
		return FALSE
	check_recipes(potential_food)
	return TRUE

// checks recipes related to held item
/datum/action/cooldown/spell/sniff/proc/check_recipes(obj/item/food/potential_food)
	var/list/type_recipe_list = list()
	var/food_type = potential_food.type
	for(var/datum/crafting_recipe/recipe as anything in GLOB.cooking_recipes)
		if(food_type in recipe.reqs)
			type_recipe_list += recipe.result
	if(length(type_recipe_list) == 0)
		to_chat(owner, span_notice("这东西无法再做成其他食物。"))
		return FALSE
	var/datum/crafting_recipe/chosen = pick(type_recipe_list)
	to_chat(owner, span_notice("[potential_food] 或许可以用来制作 [chosen::name]。"))
///End of Mouse Traits

/datum/quirk/sensitivesnout
	name = "Sensitive Snout"
	desc = "你的脸一直很敏感，被人戳到时会非常疼！"
	gain_text = span_notice("你的脸异常敏感。")
	lose_text = span_notice("你的脸感觉麻木了。")
	medical_record_text = "患者鼻尖似乎聚集了大量神经，建议避免直接触碰。"
	value = 0
	mob_trait = TRAIT_SENSITIVESNOUT
	icon = FA_ICON_FINGERPRINT

/datum/quirk/overweight
	name = "Overweight"
	desc = "你的体重比相同体型的普通人更重，不过你早已习惯。"
	gain_text = span_notice("你觉得身体沉甸甸的。")
	lose_text = span_notice("你突然感觉轻快了！")
	value = 0
	icon = FA_ICON_HAMBURGER // I'm very hungry. Give me the burger!
	medical_record_text = "患者体重高于平均水平。"
	mob_trait = TRAIT_FAT

/datum/quirk/overweight/add(client/client_source)
	quirk_holder.add_movespeed_modifier(/datum/movespeed_modifier/overweight)

/datum/quirk/overweight/remove()
	quirk_holder.remove_movespeed_modifier(/datum/movespeed_modifier/overweight)

/datum/movespeed_modifier/overweight
	multiplicative_slowdown = 0.5 //Around that of a dufflebag, enough to be impactful but not debilitating.

/datum/mood_event/fat/can_effect_mob(datum/mood/home, mob/living/target, ...)
	. = ..()

	if(HAS_TRAIT_FROM(target, TRAIT_FAT, QUIRK_TRAIT))
		mood_change = 0 // They are probably used to it, no reason to be viscerally upset about it.
		description = "<b>我很胖。</b>"
	return TRUE
