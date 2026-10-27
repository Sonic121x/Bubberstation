/obj/item/heretic_labyrinth_handbook/examine(mob/user)
	. = ..()

	. += span_notice("可用于生成无法穿透的屏障。持续8秒，同时拥有5次充能。")

/datum/heretic_knowledge_tree_column/lock
	description = list(
		"启锁之道侧重于通行权限、区域封锁、盗窃和各种工具。",
		"如果你初次游玩异教徒，或希望少些正面对抗、更喜欢四处钻空子，就选择这条道路。",
	)

/obj/effect/lock_portal/Initialize(mapload, target, invert = FALSE)
	. = ..()

	RegisterSignal(src, COMSIG_ATOM_HOLYATTACK, PROC_REF(on_holy_attack))

/obj/effect/lock_portal/examine(mob/user)
	. = ..()

	. += span_notice("非侍徒穿过这扇门时会被随机传送；侍徒则会被传送到另一处配对的传送门。")
	. += span_notice("可用反魔法武器（圣西瓜或虚无之杖）驱散，也可通过拆除气闸将其清除。")

/obj/effect/lock_portal/proc/on_holy_attack(datum/source, obj/item/weapon)
	SIGNAL_HANDLER

	visible_message(span_warning("[weapon]驱散了[src]！"))
	qdel(src)

/datum/status_effect/caretaker_refuge
	duration = 60 SECONDS

/datum/action/cooldown/spell/caretaker
	name = "看守者的最后庇护"
	desc = "将你移入看守者的庇护所，使你半透明且没有实体。\
		在庇护所中可以自由移动，但无法使用双手或施放任何法术。\
		附近有其他有意识的生物时，无法进入庇护所；\
		接触反魔法物品会将你逐出。\
		持续一分钟。"

/datum/action/cooldown/spell/pointed/burglar_finesse/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return

	var/turf/in_LOS = get_hearers_in_LOS(cast_range, owner)
	if (!(cast_on in in_LOS))
		owner.balloon_alert(owner, "必须看得到目标！")
		return SPELL_CANCEL_CAST
