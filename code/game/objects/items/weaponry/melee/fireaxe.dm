GLOBAL_DATUM(bridge_axe, /obj/item/fireaxe)

/*
 * Fireaxe
 */
/obj/item/fireaxe  // DEM AXES MAN, marker -Agouri
	name = "消防斧"
	desc = "真正属于疯子的武器。谁会想到用斧头去扑火呢？"
	icon = 'icons/obj/weapons/fireaxe.dmi'
	icon_state = "fireaxe0"
	base_icon_state = "fireaxe"
	lefthand_file = 'icons/mob/inhands/weapons/axes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/axes_righthand.dmi'
	force = 5
	throwforce = 15
	demolition_mod = 1.25
	w_class = WEIGHT_CLASS_BULKY
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("攻击", "劈砍", "斩击", "撕裂", "割裂", "切割")
	attack_verb_simple = list("攻击", "劈砍", "斩击", "撕裂", "割裂", "切割")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	armor_type = /datum/armor/item_fireaxe
	resistance_flags = FIRE_PROOF
	wound_bonus = -15
	exposed_wound_bonus = 20
	/// How much damage to do unwielded
	var/force_unwielded = 5
	/// How much damage to do wielded
	var/force_wielded = 24

/datum/armor/item_fireaxe
	fire = 100
	acid = 30

/obj/item/fireaxe/Initialize(mapload)
	. = ..()
	if(!GLOB.bridge_axe && istype(get_area(src), /area/station/command))
		GLOB.bridge_axe = src

	AddComponent(/datum/component/butchering, \
		speed = 10 SECONDS, \
		effectiveness = 80, \
		bonus_modifier = 0 , \
		butcher_sound = hitsound, \
	)
	//axes are not known for being precision butchering tools
	AddComponent(/datum/component/two_handed, force_unwielded=force_unwielded, force_wielded=force_wielded, icon_wielded="[base_icon_state]1")

/obj/item/fireaxe/Destroy()
	if(GLOB.bridge_axe == src)
		GLOB.bridge_axe = null
	return ..()

/obj/item/fireaxe/get_demolition_modifier(obj/target)
	return HAS_TRAIT(src, TRAIT_WIELDED) ? demolition_mod : 0.8

/obj/item/fireaxe/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/item/fireaxe/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]从头到脚把自己劈成了两半！看来是想自杀！"))
	return BRUTELOSS

/obj/item/fireaxe/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(!HAS_TRAIT(src, TRAIT_WIELDED)) //destroys windows and grilles in one hit
		return
	if(target.resistance_flags & INDESTRUCTIBLE)
		return
	if(QDELETED(target))
		return
	if(istype(target, /obj/structure/window) || istype(target, /obj/structure/grille))
		target.atom_destruction("fireaxe")

/*
 * Bone Axe
 */
/obj/item/fireaxe/boneaxe  // Blatant imitation of the fireaxe, but made out of bone.
	name = "骨斧"
	desc = "一把由数块磨尖的骨板粗略捆扎而成的大型凶恶斧头。以怪物为材，靠杀戮怪物制成，用于杀戮怪物。"
	icon_state = "bone_axe0"
	base_icon_state = "bone_axe"
	icon_angle = 180
	force_unwielded = 5
	force_wielded = 23
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 6)

/*
 * Metal Hydrogen Axe
 */
/obj/item/fireaxe/metal_h2_axe
	name = "金属氢斧"
	desc = "一把轻量撬棍，前端接有极其锋利的消防斧头。它舍弃了作为武器的分量，换取更便于挂在宇航服上携带而无需占用背包。"
	icon_state = "metalh2_axe0"
	base_icon_state = "metalh2_axe"
	icon_angle = -45
	force_unwielded = 5
	force_wielded = 15
	demolition_mod = 2
	tool_behaviour = TOOL_CROWBAR
	toolspeed = 1
	usesound = 'sound/items/tools/crowbar.ogg'

//boarding axe
/obj/item/fireaxe/boardingaxe
	name = "登舰斧"
	desc = "一柄沉重的劈砍利器，光是看着就让人感到累赘。似乎非常擅长把窗户、气闸、路障乃至人劈成两半。"
	icon_state = "boarding_axe0"
	base_icon_state = "boarding_axe"
	force_unwielded = 5
	force_wielded = 30
	demolition_mod = 3
