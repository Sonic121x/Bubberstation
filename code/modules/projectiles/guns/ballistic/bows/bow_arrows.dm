///base arrow
/obj/item/ammo_casing/arrow
	name = "箭"
	desc = "刺刺侠！"
	icon = 'icons/obj/weapons/bows/arrows.dmi'
	icon_state = "arrow"
	base_icon_state = "arrow"
	inhand_icon_state = "arrow"
	projectile_type = /obj/projectile/bullet/arrow
	flags_1 = NONE
	throwforce = 1
	firing_effect_type = null
	caliber = CALIBER_ARROW
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT, /datum/material/iron = SHEET_MATERIAL_AMOUNT)
	///Whether the bullet type spawns another casing of the same type or not.
	var/reusable = TRUE

/obj/item/ammo_casing/arrow/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/envenomable_casing)
	AddElement(/datum/element/caseless, reusable)

/obj/item/ammo_casing/arrow/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]" //SKYRAT EDIT: Original: icon_state = "[base_icon_state]"

///base arrow projectile
/obj/projectile/bullet/arrow
	name = "箭"
	desc = "哎哟！快把它从我身上弄出去！"
	icon = 'icons/obj/weapons/bows/arrows.dmi'
	icon_state = "arrow_projectile"
	damage = 50
	speed = 1
	range = 25
	shrapnel_type = null
	embed_type = /datum/embedding/arrow

/datum/embedding/arrow
	embed_chance = 90
	fall_chance = 2
	jostle_chance = 2
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.5
	pain_mult = 3
	jostle_pain_mult = 3
	rip_time = 1 SECONDS

/// sticky arrows
/obj/item/ammo_casing/arrow/sticky
	name = "黏性箭"
	desc = "一支黏性箭。箭头并不锋利，但一旦被射中，想自己拔下来会相当困难、相当疼。"
	icon_state = "sticky_arrow"
	inhand_icon_state = "sticky_arrow"
	base_icon_state = "sticky_arrow"
	projectile_type = /obj/projectile/bullet/arrow/sticky

///sticky arrow projectile
/obj/projectile/bullet/arrow/sticky
	name = "黏性箭"
	desc = "真是棘手的局面……"
	icon_state = "sticky_arrow_projectile"
	damage = 30
	speed = 1.3
	range = 20
	embed_type = /datum/embedding/arrow/sticky

/datum/embedding/arrow/sticky
	embed_chance = 99
	fall_chance = 0
	jostle_chance = 1
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.7
	pain_mult = 3
	jostle_pain_mult = 3
	rip_time = 8 SECONDS

/// poison arrows
/obj/item/ammo_casing/arrow/poison
	name = "毒箭"
	desc = "一支毒箭。"
	icon_state = "poison_arrow"
	inhand_icon_state = "poison_arrow"
	base_icon_state = "poison_arrow"
	projectile_type = /obj/projectile/bullet/arrow/poison

/// poison arrow projctile
/obj/projectile/bullet/arrow/poison
	name = "毒箭"
	desc = "最好别被这东西射中！"
	icon_state = "poison_arrow_projectile"
	damage = 40
	embed_type = /datum/embedding/arrow

/obj/projectile/bullet/arrow/poison/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(!ishuman(target))
		return

	target.reagents?.add_reagent(/datum/reagent/toxin/cyanide, 8)
	target.reagents?.add_reagent(/datum/reagent/toxin/staminatoxin, 1)

/// holy arrows
/obj/item/ammo_casing/arrow/holy
	name = "圣箭"
	desc = "一支追寻目标的圣洁之箭。"
	icon_state = "holy_arrow"
	inhand_icon_state = "holy_arrow"
	base_icon_state = "holy_arrow"
	projectile_type = /obj/projectile/bullet/arrow/holy

/// holy arrow projectile
/obj/projectile/bullet/arrow/holy
	name = "圣箭"
	desc = "来了，邪教徒渣滓！"
	icon_state = "holy_arrow_projectile"

/obj/projectile/bullet/arrow/holy/Initialize(mapload)
	. = ..()
	// 50 damage to revenants
	AddComponent(/datum/component/bane, affected_biotypes = MOB_SPIRIT, added_damage = 30)

/// plastic arrows
// completely dogshit quality and they break when they hit something.
/obj/item/ammo_casing/arrow/plastic
	name = "塑料箭"
	desc = "顺旋星区最早的采矿队是现代定居者那些颇为壮实的祖先。这些队伍 \
		常常发现自己挖出的优质材料全被运往外地，自己反倒无缘用来维护设备。 \
		选择所剩无几，又需要在顺旋星区恶劣的工作环境中保护自己，他们只好转向 \
		手上唯一充足的那种材料。"
	icon_state = "plastic_arrow"
	base_icon_state = "plastic_arrow"
	projectile_type = /obj/projectile/bullet/arrow/plastic
	reusable = FALSE //cheap shit
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)

/// plastic arrow projectile
/obj/projectile/bullet/arrow/plastic
	name = "塑料箭"
	desc = "如果这东西就要了你的命，你真该感到由衷的耻辱。"
	damage = 5
	stamina = 50
	weak_against_armour = TRUE
	icon_state = "plastic_arrow_projectile"

/// special pyre sect arrow
/obj/item/ammo_casing/arrow/holy/blazing
	name = "炽星箭"
	desc = "一支受火焰祝福、追寻目标的圣洁之箭。命中时它会燃起并烧毁箭矢。但要是射中一个已经在燃烧的目标……？"
	icon_state = "flaming_arrow"
	inhand_icon_state = "flaming_arrow"
	base_icon_state = "flaming_arrow"
	projectile_type = /obj/projectile/bullet/arrow/blazing
	reusable = FALSE

/obj/projectile/bullet/arrow/blazing
	name = "炽燃箭"
	desc = "无与伦比的太阳之力"
	icon_state = "flaming_arrow_projectile"
	damage_type = BURN
	embed_type = null

/obj/projectile/bullet/arrow/blazing/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/human_target = target
	if(!human_target.on_fire)
		to_chat(human_target, span_danger("[src] 爆燃成一团火焰，迅速将你吞没！"))
		human_target.adjust_fire_stacks(2)
		human_target.ignite_mob()
		return
	to_chat(human_target, span_danger("[src] 与你身上的火焰发生了反应！我靠！"))
	explosion(src, light_impact_range = 1, flame_range = 2) //ow

/// Ashen arrows
/obj/item/ammo_casing/arrow/ashen
	name = "灰烬箭"
	desc = "用守望者的筋腱与骨骼制成的箭。对制成它的那些生物似乎有着异常的杀伤力。"
	icon_state = "ashen_arrow"
	inhand_icon_state = "ashen_arrow"
	base_icon_state = "ashen_arrow"
	projectile_type = /obj/projectile/bullet/arrow/ashen
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

/// ashen arrow projectile
/obj/projectile/bullet/arrow/ashen
	name = "灰烬箭"
	icon_state = "ashen_arrow_projectile"

/obj/projectile/bullet/arrow/ashen/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bane, affected_biotypes = MOB_MINING, added_damage = 40)
