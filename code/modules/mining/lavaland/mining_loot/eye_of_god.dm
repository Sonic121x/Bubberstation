/obj/item/clothing/glasses/godeye
	name = "神之眼"
	desc = "一只奇特的眼睛，据说是从一头曾游荡于荒原的全知生物身上撕下来的。"
	icon_state = "godeye"
	inhand_icon_state = null
	vision_flags = SEE_TURFS
	clothing_traits = list(TRAIT_MADNESS_IMMUNE)
	// Blue, light blue
	color_cutoffs = list(15, 30, 40)
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	custom_materials = null
	var/datum/action/cooldown/spell/pointed/scan/scan_ability

/obj/item/clothing/glasses/godeye/Initialize(mapload)
	. = ..()
	scan_ability = new(src)

/obj/item/clothing/glasses/godeye/Destroy()
	QDEL_NULL(scan_ability)
	return ..()

/obj/item/clothing/glasses/godeye/equipped(mob/living/user, slot)
	. = ..()
	if(ishuman(user) && (slot & ITEM_SLOT_EYES))
		ADD_TRAIT(src, TRAIT_NODROP, EYE_OF_GOD_TRAIT)
		pain(user)
		scan_ability.Grant(user)

/obj/item/clothing/glasses/godeye/dropped(mob/living/user)
	. = ..()
	// Behead someone, their "glasses" drop on the floor
	// and thus, the god eye should no longer be sticky
	REMOVE_TRAIT(src, TRAIT_NODROP, EYE_OF_GOD_TRAIT)
	// And remove the scan ability, note that if we're being called from Destroy
	// that this may already be nulled and removed
	scan_ability?.Remove(user)

/obj/item/clothing/glasses/godeye/proc/pain(mob/living/victim)
	to_chat(victim, span_userdanger("当 [src] 钻进你的头骨时，你感到一阵致盲的剧痛。"))
	victim.emote("scream")
	victim.flash_act()

/datum/action/cooldown/spell/pointed/scan
	name = "扫描"
	desc = "扫描一名敌人，获取其位置并加以斥责，延长他们的攻击间隔。"
	background_icon_state = "bg_clock"
	overlay_icon_state = "bg_clock_border"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "scan"
	school = SCHOOL_HOLY
	cooldown_time = 35 SECONDS
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	antimagic_flags = MAGIC_RESISTANCE_MIND //Even god cannot penetrate the tin foil hat

	ranged_mousepointer = 'icons/effects/mouse_pointers/scan_target.dmi'

/datum/action/cooldown/spell/pointed/scan/is_valid_target(atom/cast_on)
	if(!isliving(cast_on))
		owner.balloon_alert(owner, "目标无效！")
		return FALSE
	var/mob/living/living_cast_on = cast_on
	if(living_cast_on.stat == DEAD)
		owner.balloon_alert(owner, "目标已死亡！")
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/scan/cast(mob/living/cast_on)
	. = ..()

	if(cast_on.can_block_magic(MAGIC_RESISTANCE_MIND, charge_cost = 0))
		to_chat(owner, span_warning("当我们施展剖析之视时，它被骤然截断。 \
			他们拥有某种神秘的精神防御。看来我们被挫败了。"))
		return

	if(cast_on == owner)
		to_chat(owner, span_warning("上一次有神明过于专注地凝视自己的倒影时，他们就此永远定住了。别让我们也变成那样。"))
		return

	var/mob/living/living_owner = owner
	var/mob/living/living_scanned = cast_on
	living_scanned.apply_status_effect(/datum/status_effect/rebuked)
	var/datum/status_effect/agent_pinpointer/scan_pinpointer = living_owner.apply_status_effect(/datum/status_effect/agent_pinpointer/scan)
	scan_pinpointer.scan_target = living_scanned

	to_chat(living_scanned, span_warning("你短暂地瞥见 [living_owner] 的面容，随即被一股无形的力量震得失去平衡！"))
	living_scanned.add_filter("scan", 2, list("type" = "outline", "color" = COLOR_RED, "size" = 1))
	addtimer(CALLBACK(living_scanned, TYPE_PROC_REF(/datum, remove_filter), "scan"), 30 SECONDS)

	healthscan(living_owner, living_scanned, SCANNER_VERBOSE, SCANPOWER_ADVANCED)

	owner.playsound_local(get_turf(owner), 'sound/effects/magic/smoke.ogg', 50, TRUE)
	owner.balloon_alert(owner, "已扫描 [living_scanned]")
	addtimer(CALLBACK(src, PROC_REF(send_cooldown_end_message), cooldown_time))

/datum/action/cooldown/spell/pointed/scan/proc/send_cooldown_end_message()
	owner?.balloon_alert(owner, "扫描已充能")

/datum/status_effect/agent_pinpointer/scan
	duration = 15 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/agent_pinpointer/scan
	tick_interval = 2 SECONDS
	range_fuzz_factor = 0
	minimum_range = 1
	range_mid = 5
	range_far = 15

/datum/status_effect/agent_pinpointer/scan/scan_for_target()
	return

/atom/movable/screen/alert/status_effect/agent_pinpointer/scan
	name = "扫描目标"
	desc = "目标可能近在咫尺，也可能并非如此。"
