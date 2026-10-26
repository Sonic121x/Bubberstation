/obj/item/nullrod/papal_staff
	name = "教宗权杖"
	desc = "传统主教和教宗使用的权杖。"
	icon = 'modular_zubbers/icons/obj/items_and_weapons.dmi'
	icon_state = "papal_staff"
	inhand_icon_state = "papal_staff"
	inside_belt_icon_state = "baguette"
	worn_icon_state = "baguette"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("拍打", "击中", "敲打", "殴打", "净化")
	attack_verb_simple = list("拍打", "击中", "敲打", "殴打", "净化")

/obj/item/clothing/head/mitre
	name = "教宗礼冠"
	desc = "传统基督教中主教和教宗佩戴的礼冠。"
	icon = 'modular_zubbers/icons/mob/clothing/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/32x48_head.dmi'
	icon_state = "mitre"

/obj/item/clothing/suit/chaplainsuit/armor/papal
	name = "教宗长袍"
	desc = "传统基督教中主教和教宗穿着的服饰，在法衣外披着一件短斗篷。"
	icon = 'modular_zubbers/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits.dmi'
	icon_state = "papalrobe"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/storage/box/holy/papal
	name = "教宗套装"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/papal

/obj/item/storage/box/holy/papal/PopulateContents()
	new /obj/item/clothing/head/mitre(src)
	new /obj/item/clothing/suit/chaplainsuit/armor/papal(src)

///////////////////////////////
//// HYPEREUTACTIC BLADE /////
/////////////////////////////
/obj/item/dualsaber/chaplain
	// Original from Citadel by Sishen1542
	icon = 'modular_zubbers/icons/obj/weapons/1x2.dmi'
	icon_state = "hypereutactic"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	inhand_icon_state = "hypereutactic"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	name = "神圣光刃"
	desc = "由明亮圣光构成的巨刃，据说能轻易斩除邪恶。"
	obj_flags = UNIQUE_RENAME
	slot_flags = ITEM_SLOT_BELT
	item_flags = NO_BLOOD_ON_ITEM | SLOWS_WHILE_IN_HAND | IMMUTABLE_SLOW
	force = 5
	armour_penetration = 0
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	attack_verb_continuous = list("攻击", "劈砍", "刺击", "切割", "摧毁", "撕裂", "重创", "撕碎")
	attack_verb_simple = list("攻击", "劈砍", "刺击", "切割", "摧毁", "撕裂", "重创", "撕碎")
	block_chance = 30
	block_sound = 'modular_zubbers/sound/weapons/nebblock.ogg'
	two_hand_force = 20
	slowdown = 0
	var/chaplain_spawnable = TRUE
	var/menu_description = "一柄能够格挡弹丸的巨型能量刃，但十分笨重，\
开启时必须谨慎移动。可以放入口袋，关闭时也能挂在腰带上。"
	var/list/cultists_slain

/obj/item/dualsaber/chaplain/Initialize(mapload) //HEAVENLY FATHER I CRAVE COMPONENTS
	. = ..()
	AddComponent(/datum/component/two_handed, \
		force_unwielded = force, \
		force_wielded = two_hand_force, \
		wieldsound = 'modular_zubbers/sound/weapons/nebon.ogg', \
		unwieldsound = 'modular_zubbers/sound/weapons/neboff.ogg', \
		wield_callback = CALLBACK(src, PROC_REF(on_wield)), \
		unwield_callback = CALLBACK(src, PROC_REF(on_unwield)), \
	)
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE,)
	AddComponent(/datum/component/effect_remover, \
		success_feedback = "你用%THEWEAPON破除了%THEEFFECT的魔力。", \
		success_forcesay = "滚开，污秽的邪术！！", \
		tip_text = "清除符文", \
		on_clear_callback = CALLBACK(src, PROC_REF(on_cult_rune_removed)), \
		effects_we_clear = list(/obj/effect/rune, /obj/effect/heretic_rune, /obj/effect/cosmic_rune), \
	)
	AddComponent(/datum/component/bane, affected_biotypes = MOB_SPIRIT, added_damage = 30)

/obj/item/dualsaber/chaplain/proc/on_cult_rune_removed(obj/effect/target, mob/living/user)
	if(!istype(target, /obj/effect/rune))
		return

/obj/item/dualsaber/chaplain/on_wield()
	.=..()
	slowdown = 1

/obj/item/dualsaber/chaplain/on_unwield()
	.=..()
	slowdown = 0

/obj/item/dualsaber/chaplain/attack(mob/living/target_mob, mob/living/user, params)
	if(!user.mind?.holy_role)
		return ..()
	if(!IS_CULTIST(target_mob) || istype(target_mob, /mob/living/carbon/human/cult_ghost))
		return ..()

	var/old_stat = target_mob.stat
	. = ..()
	if(old_stat < target_mob.stat)
		LAZYOR(cultists_slain, REF(target_mob))
	return .

/obj/item/dualsaber/chaplain/update_icon_state()
	.=..()
	icon_state = inhand_icon_state = "hypereutactic"
	return

/obj/item/dualsaber/chaplain/update_overlays()
	. = ..()
	var/mutable_appearance/blade_overlay = mutable_appearance(icon, "hypereutactic_blade")
	var/mutable_appearance/gem_overlay = mutable_appearance(icon, "hypereutactic_gem")

	if(light_color)
		blade_overlay.color = light_color
		gem_overlay.color = light_color

	. += gem_overlay

	if(HAS_TRAIT(src, TRAIT_WIELDED))
		. += blade_overlay

/obj/item/dualsaber/chaplain/click_alt(mob/user)
	. = ..()
	if(!user.can_perform_action(src, SILENT_ADJACENCY) || hacked)
		return
	if(user.incapacitated || !istype(user))
		to_chat(user, "<span class='warning'>你现在无法这样做！</span>")
		return
	if(alert("确定要重新为光刃着色吗？", "确认改色", "是", "否") == "是")
		var/energy_color_input = tgui_color_picker(usr,"","选择能量颜色",light_color) // BUBBERSTATION EDIT: TGUI COLOR PICKER
		if(!energy_color_input || !user.can_perform_action(src, SILENT_ADJACENCY) || hacked)
			return
		set_light_color(energy_color_input)
		update_icon()
		update_overlays(UPDATE_OVERLAYS)
	return TRUE

/obj/item/dualsaber/chaplain/process()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		if(hacked)
			set_light_color(light_color)
		open_flame()
	else
		return PROCESS_KILL

/obj/item/dualsaber/chaplain/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(isinhands)
		var/mutable_appearance/gem_inhand = mutable_appearance(icon_file, "hypereutactic_gem")
		gem_inhand.color = light_color
		. += gem_inhand
		if(HAS_TRAIT(src, TRAIT_WIELDED))
			var/mutable_appearance/blade_inhand = mutable_appearance(icon_file, "hypereutactic_blade")
			blade_inhand.color = light_color
			. += blade_inhand

/obj/item/dualsaber/chaplain/examine(mob/user)
	. = ..()
	. += "<span class='notice'>按住 Alt 点击即可改色。</span>"
	if (!IS_CULTIST(user) || !GET_ATOM_BLOOD_DNA_LENGTH(src))
		return

	var/num_slain = LAZYLEN(cultists_slain)
	. += span_cult_italic("它沾染了 [num_slain] 名死去血教徒的鲜血。\
		将其<b>献祭</b>给纳尔西，就能将它变成一件[num_slain >= 3 ? "强大的" : "普通的"]血教武器。")
