//Basically the assistant suit
/obj/item/clothing/under/plasmaman
	name = "等离子体环境防护服"
	desc = "一件特殊的封闭防护服，能让等离子体生命体在含氧环境中安全存在，并能在危急时自动将其身上的火焰扑灭。尽管完全密封，它并不适合太空作业。"
	icon_state = "plasmaman"
	inhand_icon_state = "plasmaman"
	icon = 'icons/obj/clothing/under/plasmaman.dmi'
	worn_icon = 'icons/mob/clothing/under/plasmaman.dmi'
	clothing_flags = PLASMAMAN_PREVENT_IGNITION | NO_ZONE_DISABLING
	armor_type = /datum/armor/clothing_under/plasmaman
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	can_adjust = FALSE
	strip_delay = 8 SECONDS
	resistance_flags = FIRE_PROOF
	COOLDOWN_DECLARE(extinguish_timer)
	var/extinguish_cooldown = 100
	var/extinguishes_left = 5

/datum/armor/clothing_under/plasmaman
	bio = 100
	fire = 95
	acid = 95

/obj/item/clothing/under/plasmaman/examine(mob/user)
	. = ..()
	. += span_notice("这件防护服内还剩 [extinguishes_left] 次灭火剂。")

/obj/item/clothing/under/plasmaman/equipped(mob/living/user, slot)
	. = ..()
	if (slot & ITEM_SLOT_ICLOTHING)
		RegisterSignals(user, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_LIVING_IGNITED, SIGNAL_ADDTRAIT(TRAIT_HEAD_ATMOS_SEALED)), PROC_REF(check_fire_state))
		check_fire_state()

/obj/item/clothing/under/plasmaman/dropped(mob/living/user)
	. = ..()
	UnregisterSignal(user, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_LIVING_IGNITED, SIGNAL_ADDTRAIT(TRAIT_HEAD_ATMOS_SEALED)))

/obj/item/clothing/under/plasmaman/proc/check_fire_state(datum/source)
	SIGNAL_HANDLER

	if (!ishuman(loc))
		return

	// This is weird but basically we're calling this proc once the cooldown ends in case our wearer gets set on fire again during said cooldown
	// This is why we're ignoring source and instead checking by loc
	var/mob/living/carbon/human/owner = loc
	if (!owner.on_fire || !owner.is_atmos_sealed(additional_flags = PLASMAMAN_PREVENT_IGNITION, check_hands = TRUE))
		return

	if (!extinguishes_left || !COOLDOWN_FINISHED(src, extinguish_timer))
		return

	extinguishes_left -= 1
	COOLDOWN_START(src, extinguish_timer, extinguish_cooldown)
	// Check if our (possibly other) wearer is on fire once the cooldown ends
	addtimer(CALLBACK(src, PROC_REF(check_fire_state)), extinguish_cooldown)
	owner.visible_message(span_warning("[owner] 的防护服自动扑灭了其身上的火！"), span_warning("你的防护服自动为你扑灭了火焰。"))
	owner.extinguish_mob()
	new /obj/effect/particle_effect/water(get_turf(owner))

/obj/item/clothing/under/plasmaman/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if (!istype(tool, /obj/item/extinguisher_refill))
		return ..()

	if (extinguishes_left == 5)
		to_chat(user, span_notice("内置灭火器已满。"))
		return ITEM_INTERACT_BLOCKING

	extinguishes_left = 5
	to_chat(user, span_notice("你为防护服补充了内置灭火器，用掉了这支气罐。"))
	check_fire_state()
	qdel(tool)
	return ITEM_INTERACT_SUCCESS

/obj/item/extinguisher_refill
	name = "环境防护服灭火气罐"
	desc = "一支装有压缩灭火混合物的气罐，用于为等离子体环境防护服补充自动灭火剂。"
	icon_state = "plasmarefill"
	icon = 'icons/obj/canisters.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/clothing/under/plasmaman/cargo
	name = "货运等离子体环境防护服"
	desc = "一种由等离子体人货运主管与货运技师共用的防护服，因为仅凭裤腿长度来区分这两者实在太麻烦。"
	icon_state = "cargo_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/mining
	name = "采矿等离子体环境防护服"
	desc = "一件气密的卡其色防护服，专为等离子体人在熔岩地作业而设计。"
	icon_state = "explorer_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/chef
	name = "厨师等离子体环境防护服"
	desc = "一件专为烹饪工作设计的白色等离子体人环境防护服。有人可能会问，一个不需要进食的物种的成员为什么要当厨师。"
	icon_state = "chef_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/enviroslacks
	name = "环境便裤"
	desc = "这是一位格外讲究的等离子体人的私人爱好项目，这套定制服装很快被纳米传讯拿去给自家律师和调酒师使用。"
	icon_state = "enviroslacks"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/chaplain
	name = "牧师等离子体环境防护服"
	desc = "专为最虔诚的等离子体人设计的防护服。"
	icon_state = "chap_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/curator
	name = "馆长等离子体环境防护服"
	desc = "这套防护服由改装过的太空服制成，是纳米传讯为解决雇用等离子体人带来的*后勤问题*而给出的第一个方案。由于经过改装，它已不再适合太空作业。尽管有诸多局限，历史学家和老派等离子体人仍在穿着这类防护服。"
	icon_state = "prototype_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/janitor
	name = "清洁工等离子体环境防护服"
	desc = "一件灰紫色的环境防护服，配发给等离子体人清洁工。"
	icon_state = "janitor_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/botany
	name = "植物学环境防护服"
	desc = "一件绿蓝相间的环境防护服，用于保护等离子体人免受轻微的植物伤害。"
	icon_state = "botany_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/mime
	name = "哑剧演员环境防护服"
	desc = "它不太鲜艳。"
	icon_state = "mime_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/clown
	name = "小丑环境防护服"
	desc = "<i>‘HONK！’</i>"
	icon_state = "clown_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/bitrunner
	name = "比特潜行者环境防护服"
	desc = "专为姿势不良的等离子体人设计的防护服。"
	icon_state = "bitrunner_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/clown/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CLOWN, CELL_VIRUS_TABLE_GENERIC, rand(2,3), 0)

/obj/item/clothing/under/plasmaman/prisoner
	name = "囚犯环境防护服"
	desc = "一件橙色的环境防护服，用于标识并保护等离子体人罪犯。它的服装传感器卡在“全开”位置。"
	icon_state = "prisoner_envirosuit"
	inhand_icon_state = null
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/plasmaman/clown/check_fire_state(datum/source, datum/status_effect/fire_handler/status_effect)
	if (!ishuman(loc))
		return

	// This is weird but basically we're calling this proc once the cooldown ends in case our wearer gets set on fire again during said cooldown
	// This is why we're ignoring source and instead checking by loc
	var/mob/living/carbon/human/owner = loc
	if (!owner.on_fire || !owner.is_atmos_sealed(additional_flags = PLASMAMAN_PREVENT_IGNITION, check_hands = TRUE))
		return

	if (!extinguishes_left || !COOLDOWN_FINISHED(src, extinguish_timer))
		return

	extinguishes_left -= 1
	COOLDOWN_START(src, extinguish_timer, extinguish_cooldown)
	// Check if our (possibly other) wearer is on fire once the cooldown ends
	addtimer(CALLBACK(src, PROC_REF(check_fire_state)), extinguish_cooldown)
	owner.visible_message(span_warning("[owner] 的防护服到处喷出太空润滑剂！"), span_warning("你的防护服到处喷出太空润滑剂！"))
	owner.extinguish_mob()
	do_foam(4, src, get_turf(owner), /datum/reagent/lube, 15)
