// Hardened vests negate any and all projectile armor penetration, in exchange for having mid af bullet armor
/datum/armor/armor_sf_hardened
	melee = ARMOR_LEVEL_WEAK
	bullet = ARMOR_LEVEL_MID
	laser = ARMOR_LEVEL_WEAK
	energy = ARMOR_LEVEL_TINY
	bomb = ARMOR_LEVEL_WEAK
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_WEAK

/obj/item/clothing/suit/armor/sf_hardened
	name = "“城墙”硬化护甲背心"
	desc = "大型白色胸甲搭配由致密甲片组成的半柔性甲衣，覆盖整个躯干。\
		虽然直接阻挡子弹的表现并不出众，但这件背心特别擅长让子弹\
		在造成伤害之前丧失大部分穿甲能力。"
	icon = 'modular_skyrat/modules/specialist_armor/icons/armor.dmi'
	icon_state = "hardened_standard"
	worn_icon = 'modular_skyrat/modules/specialist_armor/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_sf_hardened
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/sf_hardened/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text, final_block_chance, damage, attack_type, damage_type)
	. = ..()

	if(istype(hitby, /obj/projectile))
		var/obj/projectile/incoming_projectile = hitby
		incoming_projectile.armour_penetration = 0
		playsound(owner, SFX_RICOCHET, BLOCK_SOUND_VOLUME, vary = TRUE)

/obj/item/clothing/suit/armor/sf_hardened/examine_more(mob/user)
	. = ..()

	. += "在穿甲技术日新月异的时代，如果你还不想变成尸体，\
		该怎么办？“城墙”型护甲为这个问题给出了相当成功的答案。\
		它采用先进材料、微尺度弹体阻尼场，以及一大堆\
		让某位倒霉的地球政府采购将军听到耳朵生茧的技术，\
		因此在对抗许多穿甲弹时具有独特优势。既然可以直接削弱子弹的穿透力，\
		用较薄的护甲就能保命，何必一味加厚装甲来阻挡它呢？\
		当然，有些人更希望子弹干脆被完全挡住，但在必须取舍时，许多人会选择\
		这种方案。"

	return .

/obj/item/clothing/suit/armor/sf_hardened/emt
	name = "“大天使”硬化护甲背心"
	desc = "带有一道红色条纹的大型白色胸甲，搭配由致密甲片组成、覆盖躯干的半柔性甲衣。\
		虽然直接阻挡子弹的表现并不出众，但这件背心特别擅长让子弹\
		在造成伤害之前丧失大部分穿甲能力。"
	icon_state = "hardened_emt"

/obj/item/clothing/head/helmet/toggleable/sf_hardened
	name = "“城墙”封闭头盔"
	desc = "正面厚实的头盔，带有可展开的全脸防护面罩。头盔的材料与几何结构\
		相互配合，让子弹在造成伤害前损失大部分穿甲能力，而不是直接穿透。"
	icon = 'modular_skyrat/modules/specialist_armor/icons/armor.dmi'
	icon_state = "enclosed_standard"
	worn_icon = 'modular_skyrat/modules/specialist_armor/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_sf_hardened
	toggle_message = "你展开了面罩，头盔是"
	alt_toggle_message = "你收起了面罩，头盔是"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES
	dog_fashion = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/helmet/toggleable/sf_hardened/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text, final_block_chance, damage, attack_type, damage_type)
	. = ..()

	if(istype(hitby, /obj/projectile))
		var/obj/projectile/incoming_projectile = hitby
		incoming_projectile.armour_penetration = 0
		playsound(src, SFX_RICOCHET, BLOCK_SOUND_VOLUME, vary = TRUE)

/obj/item/clothing/head/helmet/toggleable/sf_hardened/examine_more(mob/user)
	. = ..()

	. += "在穿甲技术日新月异的时代，如果你还不想变成尸体，\
		该怎么办？“城墙”型护甲为这个问题给出了相当成功的答案。\
		它采用先进材料、微尺度弹体阻尼场，以及一大堆\
		让某位倒霉的地球政府采购将军听到耳朵生茧的技术，\
		因此在对抗许多穿甲弹时具有独特优势。既然可以直接削弱子弹的穿透力，\
		用较薄的护甲就能保命，何必一味加厚装甲来阻挡它呢？\
		当然，有些人更希望子弹干脆被完全挡住，但在必须取舍时，许多人会选择\
		这种方案。"

	return .

/obj/item/clothing/head/helmet/toggleable/sf_hardened/emt
	name = "“大天使”封闭头盔"
	desc = "正面厚实的头盔，带有可展开的全脸防护面罩。头盔的材料与几何结构\
		相互配合，让子弹在造成伤害前损失大部分穿甲能力，而不是直接穿透。\
		这一顶正面带有一道红色条纹。"
	icon_state = "enclosed_emt"
