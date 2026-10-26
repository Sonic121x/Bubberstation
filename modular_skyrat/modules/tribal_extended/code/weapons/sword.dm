/obj/item/claymore/bone
	name = "骨剑"
	desc = "锯齿状骨片绑在一根看起来像歌利亚股骨的骨头上。"
	icon = 'modular_skyrat/modules/tribal_extended/icons/items_and_weapons.dmi'
	lefthand_file = 'modular_skyrat/modules/tribal_extended/icons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/tribal_extended/icons/swords_righthand.dmi'
	worn_icon = 'modular_skyrat/modules/tribal_extended/icons/back.dmi'
	icon_state = "bone_sword"
	inhand_icon_state = "bone_sword"
	worn_icon_state = "bone_sword"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	force = 20
	throwforce = 10
	armour_penetration = 10
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("攻击", "劈砍", "刺击", "切割", "撕裂", "扯裂", "剁砍", "割伤")
	block_chance = 0
	armor_type = /datum/armor/claymore_bone
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 2)

/datum/armor/claymore_bone
	fire = 100
	acid = 50
