
///apply a bunch of fire immunity effect to clothing
/datum/religion_rites/fireproof/proc/apply_fireproof(obj/item/clothing/fireproofed)
	fireproofed.name = "不融的[fireproofed.name]"
	fireproofed.max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	fireproofed.heat_protection = chosen_clothing.body_parts_covered
	fireproofed.resistance_flags |= FIRE_PROOF

/datum/religion_rites/fireproof
	name = "不融守护"
	desc = "使任意一件衣物获得火焰免疫。"
	ritual_length = 12 SECONDS
	ritual_invocations = list("因此，为了护佑永燃蜡烛的持有者……",
	"……请允许这件不配的衣物为你效力……",
	"……让它坚固到足以承受千百次焚烧……")
	invoke_msg = "……以全新形态现身，融入唯一真焰那不融的蜡中！"
	favor_cost = 700
///the piece of clothing that will be fireproofed, only one per rite
	var/obj/item/clothing/chosen_clothing

/datum/religion_rites/fireproof/perform_rite(mob/living/user, atom/religious_tool)
	for(var/obj/item/clothing/apparel in get_turf(religious_tool))
		if(apparel.max_heat_protection_temperature >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
			continue //we ignore anything that is already fireproof
		chosen_clothing = apparel //the apparel has been chosen by our lord and savior
		return ..()
	return FALSE

/datum/religion_rites/fireproof/invoke_effect(mob/living/user, atom/religious_tool)
	..()
	if(!QDELETED(chosen_clothing) && get_turf(religious_tool) == chosen_clothing.loc) //check if the same clothing is still there
		if(istype(chosen_clothing,/obj/item/clothing/suit/hooded))
			for(var/obj/item/clothing/head/integrated_helmet in chosen_clothing.contents) //check if the clothing has a hood/helmet integrated and fireproof it if there is one.
				apply_fireproof(integrated_helmet)
		apply_fireproof(chosen_clothing)
		playsound(get_turf(religious_tool), 'sound/effects/magic/fireball.ogg', 50, TRUE)
		chosen_clothing = null //our lord and savior no longer cares about this apparel
		return TRUE
	chosen_clothing = null
	to_chat(user, span_warning("被选为仪式对象的衣物已不在祭坛上！"))
	return FALSE


/datum/religion_rites/burning_sacrifice
	name = "燃烧献祭"
	desc = "献祭一具被绑缚的燃烧中或已成焦尸的尸体以换取恩宠。尸体的烧伤越重，获得的恩宠越多。"
	ritual_length = 15 SECONDS
	ritual_invocations = list("燃烧的躯体……",
	"……经火焰净化……",
	"……我们皆由火而生……",
	"……也终将归于它……")
	invoke_msg = "……我们回归！ "
///the burning corpse chosen for the sacrifice of the rite
	var/mob/living/carbon/chosen_sacrifice

/datum/religion_rites/burning_sacrifice/perform_rite(mob/living/user, atom/religious_tool)
	if(!ismovable(religious_tool))
		to_chat(user, span_warning("此仪式需要一件可将人绑缚其上的宗教器具。"))
		return FALSE
	var/atom/movable/movable_reltool = religious_tool
	if(!movable_reltool)
		return FALSE
	if(!LAZYLEN(movable_reltool.buckled_mobs))
		to_chat(user, span_warning("祭坛上没有绑缚任何东西！"))
		return FALSE
	for(var/corpse in movable_reltool.buckled_mobs)
		if(!iscarbon(corpse))// only works with carbon corpse since most normal mobs can't be set on fire.
			to_chat(user, span_warning("只有碳基生命体才能被妥善燃烧献祭！"))
			return FALSE
		chosen_sacrifice = corpse
		if(chosen_sacrifice.stat != DEAD)
			to_chat(user, span_warning("你只能献祭尸体，这具还活着！"))
			return FALSE
		if(!chosen_sacrifice.on_fire && !HAS_TRAIT_FROM(chosen_sacrifice, TRAIT_HUSK, BURN))
			to_chat(user, span_warning("这具尸体需要正在燃烧或已成焦尸才能献祭！"))
			return FALSE
		return ..()

/datum/religion_rites/burning_sacrifice/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	if(!(chosen_sacrifice in religious_tool.buckled_mobs)) //checks one last time if the right corpse is still buckled
		to_chat(user, span_warning("正确的祭品已不在祭坛上！"))
		chosen_sacrifice = null
		return FALSE
	if(!chosen_sacrifice.on_fire && !HAS_TRAIT_FROM(chosen_sacrifice, TRAIT_HUSK, BURN))
		to_chat(user, span_warning("祭品必须在燃烧或已成焦尸，才能完成仪式！"))
		chosen_sacrifice = null
		return FALSE
	if(chosen_sacrifice.stat != DEAD)
		to_chat(user, span_warning("祭品必须保持死亡，仪式才能生效！"))
		chosen_sacrifice = null
		return FALSE
	var/favor_gained = 100 + round(chosen_sacrifice.get_fire_loss())
	GLOB.religious_sect.adjust_favor(favor_gained, user)
	to_chat(user, span_notice("[GLOB.deity] 吸收了焦黑的尸体以及其上所有火焰的痕迹。[GLOB.deity] 赐予你 [favor_gained] 点恩宠。"))
	chosen_sacrifice.dust(force = TRUE)
	playsound(get_turf(religious_tool), 'sound/effects/supermatter.ogg', 50, TRUE)
	chosen_sacrifice = null
	return TRUE

/datum/religion_rites/infinite_candle
	name = "不灭蜡烛"
	desc = "创造五根永不熄灭、蜡也用不完的蜡烛。"
	ritual_length = 10 SECONDS
	invoke_msg = "燃烧吧，小蜡烛，因为你们只会随宇宙一同熄灭。"
	favor_cost = 200

/datum/religion_rites/infinite_candle/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/altar_turf = get_turf(religious_tool)
	for(var/i in 1 to 5)
		new /obj/item/flashlight/flare/candle/infinite(altar_turf)
	playsound(altar_turf, 'sound/effects/magic/fireball.ogg', 50, TRUE)
	return TRUE

/datum/religion_rites/blazing_star
	name = "炽焰之星"
	desc = "为一支神圣箭矢附魔，使其命中时点燃目标；若目标已在燃烧……注意，这会消耗箭矢。"
	ritual_length = 15 SECONDS
	ritual_invocations = list(
		"因此，为了守护永燃蜡烛……",
		"……请赐福于这支微弱的箭矢……",
		"……让它明亮燃烧……",
	)
	invoke_msg = "……一颗炽焰之星诞生了！"
	favor_cost = 1500
	///arrow to enchant
	var/obj/item/ammo_casing/arrow/holy/enchant_target

/datum/religion_rites/blazing_star/perform_rite(mob/living/user, atom/religious_tool)
	for(var/obj/item/ammo_casing/arrow/holy/can_enchant in get_turf(religious_tool))
		if(istype(can_enchant, /obj/item/ammo_casing/arrow/holy/blazing))
			continue
		enchant_target = can_enchant
		return ..()
	to_chat(user, span_warning("你需要把一支神圣箭矢放在 [religious_tool] 上才能这么做！"))
	return FALSE

/datum/religion_rites/blazing_star/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/obj/item/ammo_casing/arrow/holy/enchanting = enchant_target
	var/turf/tool_turf = get_turf(religious_tool)
	enchant_target = null
	if(QDELETED(enchanting) || !(tool_turf == enchanting.loc)) //check if the arrow is still there
		to_chat(user, span_warning("你的目标离开了祭坛！"))
		return FALSE
	enchanting.visible_message(span_notice("箭矢受到神圣之火的祝福！"))
	playsound(tool_turf, 'sound/effects/pray.ogg', 50, TRUE)
	new /obj/item/ammo_casing/arrow/holy/blazing(tool_turf)
	qdel(enchanting)
	return TRUE
