/obj/item/organ/empowered_borer_egg
	name = "奇怪的卵"
	desc = "黏糊糊的，恶心极了。"
	icon_state = "innards" // not like you'll be seeing this anyway
	visual = TRUE
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_PARASITE_EGG
	/// How long it takes to burst from a corpse
	var/burst_time = 3 MINUTES
	/// What generation the egg will be
	var/generation = 1

/obj/item/organ/empowered_borer_egg/on_find(mob/living/finder)
	..()
	to_chat(finder, span_warning("你在 [owner] 的 [zone] 里发现了一枚未知的卵！"))

/obj/item/organ/empowered_borer_egg/Initialize(mapload)
	. = ..()
	if(iscarbon(loc))
		Insert(loc)

/obj/item/organ/empowered_borer_egg/on_mob_insert(mob/living/carbon/M, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	..()
	addtimer(CALLBACK(src, PROC_REF(try_burst)), burst_time)

/obj/item/organ/empowered_borer_egg/on_mob_remove(mob/living/carbon/M, special = FALSE, movement_flags)
	. = ..()
	visible_message(span_warning(span_italics("当 [src] 被从 [M] 体内切出时，它迅速颤动并碎裂，只留下一滩黏液！")))
	new/obj/effect/decal/cleanable/food/egg_smudge(get_turf(src))
	qdel(src)

/obj/item/organ/empowered_borer_egg/proc/try_burst()
	if(!owner)
		qdel(src)
		return
	if(owner.stat != DEAD)
		qdel(src)
		return
	var/list/candidates = SSpolling.poll_ghost_candidates("你想作为一只从 [owner.name] 体内爆出的强化皮层钻虫生成吗？", role = ROLE_PAI, check_jobban = FALSE, poll_time = 10 SECONDS, ignore_category = POLL_IGNORE_CORTICAL_BORER)
	if(!length(candidates))
		var/obj/effect/mob_spawn/ghost_role/borer_egg/empowered/borer_egg = new(get_turf(owner))
		borer_egg.generation = generation
		var/obj/item/bodypart/chest/chest = owner.get_bodypart(BODY_ZONE_CHEST)
		chest.dismember()
		owner.visible_message(span_danger("一枚卵从 [owner] 的胸膛爆出，血肉四处飞溅！"), span_danger("一枚卵从你的胸膛爆出，内脏四处飞溅！"))
		return
	var/mob/dead/observer/new_borer = pick(candidates)
	var/mob/living/basic/cortical_borer/empowered/spawned_cb = new(get_turf(owner))
	var/obj/item/bodypart/chest/chest = owner.get_bodypart(BODY_ZONE_CHEST)
	chest.dismember()
	owner.visible_message(span_danger("[spawned_cb] 从 [owner] 的胸膛爆出，血肉四处飞溅！"), span_danger("[spawned_cb] 从你的胸膛爆出，内脏四处飞溅！"))
	spawned_cb.generation = generation
	spawned_cb.ckey = new_borer.ckey
	spawned_cb.mind.add_antag_datum(/datum/antagonist/cortical_borer)
