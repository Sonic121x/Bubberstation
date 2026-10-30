/obj/item/clothing/head/costume/foilhat
	name = "锡箔帽"
	desc = "思想控制射线、精神电子扫描。别管那个，我戴着自己做的这顶帽子，所以有防护。"
	icon_state = "foilhat"
	inhand_icon_state = null
	armor_type = /datum/armor/costume_foilhat
	equip_delay_other = 14 SECONDS
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5)
	clothing_traits = list(TRAIT_DONT_HEAR_PRAYERS) //stops you from hearing prayers as well, yes
	// var/datum/brain_trauma/mild/phobia/conspiracies/paranoia BUBBERSTATION CHANGE, REMOVES PARANOIA
	var/warped = FALSE
	interaction_flags_mouse_drop = NEED_HANDS
	emp_protection = EMP_PROTECTION_MODERATE

/datum/armor/costume_foilhat
	laser = -5
	energy = -15

/obj/item/clothing/head/costume/foilhat/Initialize(mapload)
	. = ..()
	if(warped)
		warp_up()
		return

	AddComponent(
		/datum/component/anti_magic, \
		antimagic_flags = MAGIC_RESISTANCE_MIND, \
		inventory_flags = ITEM_SLOT_HEAD, \
		charges = 6, \
		block_magic = CALLBACK(src, PROC_REF(drain_antimagic)), \
		expiration = CALLBACK(src, PROC_REF(warp_up)) \
	) //BUBBERSTATION CHANGE: NEAR-INFINITE CHARGES (6 TO 1000)


/obj/item/clothing/head/costume/foilhat/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_HEAD) || warped)
		return
	/* BUBBERSTATION CHANGE START: REMOVES PARANOIA
	if(paranoia)
		QDEL_NULL(paranoia)
	paranoia = new()
	BUBBERSTATION CHANGE END: REMOVES PARANOIA */

	RegisterSignal(user, COMSIG_LIVING_SUICIDE_ACT, PROC_REF(call_suicide))

	// user.gain_trauma(paranoia, TRAUMA_RESILIENCE_MAGIC ) BUBBERSTATION CHANGE: REMOVES PARANOIA
	to_chat(user, span_warning("当你戴上这顶锡箔帽时，一整个阴谋论与看似疯狂想法的世界突然涌入你的脑海。你曾认为难以置信的事，忽然变得……无可辩驳。万物皆有联系，没有什么是偶然发生的。你知道得太多了，现在他们要来抓你了。 "))

/obj/item/clothing/head/costume/foilhat/mouse_drop_dragged(atom/over_object, mob/user)
	//God Im sorry
	if(!warped && user.get_item_by_slot(ITEM_SLOT_HEAD) == src)
		to_chat(user, span_userdanger("你为什么要摘下它？你想让他们进入你的大脑吗？！"))
		return
	return ..()

/obj/item/clothing/head/costume/foilhat/dropped(mob/user)
	. = ..()
	/* BUBBERSTATION CHANGE START: REMOVES PARANOIA
	if(paranoia)
		QDEL_NULL(paranoia)
	*/
	UnregisterSignal(user, COMSIG_LIVING_SUICIDE_ACT)

/// When the foilhat is drained an anti-magic charge.
/obj/item/clothing/head/costume/foilhat/proc/drain_antimagic(mob/user)
	to_chat(user, span_warning("[src] 微微皱缩。有什么东西正试图钻进你的脑海！"))

/obj/item/clothing/head/costume/foilhat/proc/warp_up()
	name = "烧焦的锡箔帽"
	desc = "一顶严重变形的帽子。对于它过去能抵挡的那些虚构或真实的危险，这顶帽子恐怕已经无能为力了。"
	warped = TRUE
	if(!isliving(loc)) //BUBBERSTATION CHANGE, REMOVES PARANOIA
		return
	var/mob/living/target = loc
	UnregisterSignal(target, COMSIG_LIVING_SUICIDE_ACT)
	if(target.get_item_by_slot(ITEM_SLOT_HEAD) != src)
		return
	// QDEL_NULL(paranoia) BUBBERSTATION CHANGE, REMOVES PARANOIA
	if(!IS_UNCONSCIOUS(target))
		to_chat(target, span_warning("随着头上那顶帽子扭曲成一团废料，你狂热的阴谋论信仰迅速消散。那些理论听起来不过是荒唐的吹奏。"))

/obj/item/clothing/head/costume/foilhat/can_throw_equip(atom/hit_atom)
	return warped

/obj/item/clothing/head/costume/foilhat/attack_hand(mob/user, list/modifiers)
	if(!warped && user.get_item_by_slot(ITEM_SLOT_HEAD) == src)
		to_chat(user, span_userdanger("你为什么要摘下它？你想让他们进入你的大脑吗？！"))
		return
	return ..()

/obj/item/clothing/head/costume/foilhat/microwave_act(obj/machinery/microwave/microwave_source, mob/microwaver, randomize_pixel_offset)
	. = ..()
	if(warped)
		return

	warp_up()
	return . | COMPONENT_MICROWAVE_SUCCESS

/obj/item/clothing/head/costume/foilhat/proc/call_suicide(datum/source)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(suicide_act), source) //SIGNAL_HANDLER doesn't like things waiting; INVOKE_ASYNC bypasses that
	return OXYLOSS

/obj/item/clothing/head/costume/foilhat/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 眼中露出疯狂的神色！亲眼目睹真相的 [user] 正试图自杀！"))
	var/static/list/conspiracy_line = list(
		";他们在天花板里藏了摄像头！我们做的一切都被他们看着！！",
		";我怎么能活在一个由一小撮人决定我命运和存在的世界里？！！",
		";他们在玩弄你们所有人的心智，把你们当成实验品！！",
		";他们招助理的时候连背景调查都不做！！",
		";我们住在一个动物园里，而我们才是被观察的对象！！",
		";我们每天重复着同样的生活，却不再追问！！"
	)
	user.say(pick(conspiracy_line), forced=type)
	var/obj/item/organ/brain/brain = user.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(brain)
		brain.set_organ_damage(BRAIN_DAMAGE_DEATH)
	return OXYLOSS
