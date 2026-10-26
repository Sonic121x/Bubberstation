#define KNIFE_HITSOUND 'sound/items/weapons/bladeslice.ogg'
#define KNIFE_USESOUND 'sound/items/weapons/bladeslice.ogg'
#define KNIFE_ATTACK_VERB_CONTINUOUS list("劈砍", "撕扯", "切片", "撕扯", "划裂", "撕裂", "切丁", "割开", "撕碎")
#define KNIFE_ATTACK_VERB_SIMPLE list("劈砍", "撕扯", "切片", "撕扯", "划裂", "撕裂", "切丁", "割开", "撕碎")
#define KNIFE_SHARPNESS SHARP_EDGED
#define KNIFE_EXPOSED_WOUND_BONUS 15
#define CUTTER_HITSOUND 'sound/items/tools/wirecutter.ogg'
#define CUTTER_USESOUND 'sound/items/tools/wirecutter.ogg'
#define CUTTER_ATTACK_VERB_CONTINUOUS list("猛砸", "猛击", "重敲", "乱打", "敲击")
#define CUTTER_ATTACK_VERB_SIMPLE list("猛砸", "猛击", "重敲", "乱打", "敲击")
#define CUTTER_FORCE 6
#define CUTTER_WOUND_BONUS 0
#define ENHANCED_KNIFE_FORCE 15
#define ENHANCED_KNIFE_WOUND_BONUS 15
#define ENHANCED_KNIFE_ARMOR_PENETRATION 10

/obj/item/melee/implantarmblade
	name = "植入式臂刃"
	desc = "一柄植入手臂的长而锋利的螳螂式刀刃。劈开血肉如同切开格外结实的黄油。"
	icon = 'modular_skyrat/modules/implants/icons/implanted_blade.dmi'
	righthand_file = 'modular_skyrat/modules/implants/icons/implanted_blade_righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/implants/icons/implanted_blade_lefthand.dmi'
	icon_state = "mantis_blade"
	w_class = WEIGHT_CLASS_BULKY
	obj_flags = CONDUCTS_ELECTRICITY
	sharpness = SHARP_EDGED
	force = 20
	armour_penetration = 20
	item_flags = NEEDS_PERMIT //Beepers gets angry if you get caught with this.
	hitsound = 'modular_skyrat/master_files/sound/weapons/bloodyslice.ogg'

/obj/item/melee/implantarmblade/energy
	name = "能量臂刃"
	desc = "一柄完全由灼热能量构成的长螳螂式刀刃。时髦又格外致命！"
	icon_state = "energy_mantis_blade"
	force = 30
	armour_penetration = 10 //Energy isn't as good at going through armor as it is through flesh alone.
	hitsound = 'sound/items/weapons/blade1.ogg'

/obj/item/organ/cyberimp/arm/toolkit/armblade
	name = "臂刃植入体"
	desc = "一种设计用于植入受术者手臂的集成式刀刃植入体。时髦而致命；不过，没有正规许可就带着它被发现，肯定会引来不必要的注意。"
	items_to_create = list(/obj/item/melee/implantarmblade)
	icon = 'modular_skyrat/modules/implants/icons/implanted_blade.dmi'
	icon_state = "mantis_blade"

/obj/item/organ/cyberimp/arm/toolkit/armblade/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	to_chat(usr, span_notice("你解锁了 [src] 的集成式能量臂刃！你这个疯子！"))
	items_list += WEAKREF(new /obj/item/melee/implantarmblade/energy(src))
	obj_flags |= EMAGGED
	return TRUE

/obj/item/knife/razor_claws
	name = "植入式剃刀利爪"
	desc = "一套嵌入指尖的锋利可伸缩利爪，五片双刃刀片足以把人剁成肉酱。可切换为“精准”模式，功能类似于钢丝钳。"
	icon = 'modular_skyrat/modules/implants/icons/razorclaws.dmi'
	righthand_file = 'modular_skyrat/modules/implants/icons/razorclaws_righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/implants/icons/razorclaws_lefthand.dmi'
	icon_state = "wolverine"
	inhand_icon_state = "wolverine"
	var/knife_force = 10
	w_class = WEIGHT_CLASS_BULKY
	var/knife_wound_bonus = 5
	var/cutter_force = CUTTER_FORCE
	var/cutter_wound_bonus = CUTTER_WOUND_BONUS
	var/cutter_exposed_wound_bonus = CUTTER_WOUND_BONUS
	tool_behaviour = TOOL_KNIFE
	toolspeed = 1
	item_flags = NEEDS_PERMIT //Beepers gets angry if you get caught with this.

/obj/item/knife/razor_claws/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/tools/change_drill.ogg', 50, TRUE)
	if(tool_behaviour != TOOL_WIRECUTTER)
		tool_behaviour = TOOL_WIRECUTTER
		to_chat(user, span_notice("你将 [src] 切换为精准模式，用于剪线。"))
		icon_state = "precision_wolverine"
		inhand_icon_state = "precision_wolverine"
		force = cutter_force
		wound_bonus = cutter_wound_bonus
		exposed_wound_bonus = cutter_exposed_wound_bonus
		sharpness = NONE
		hitsound = CUTTER_HITSOUND
		usesound = CUTTER_USESOUND
		attack_verb_continuous = CUTTER_ATTACK_VERB_CONTINUOUS
		attack_verb_simple = CUTTER_ATTACK_VERB_SIMPLE
	else
		tool_behaviour = TOOL_KNIFE
		to_chat(user, span_notice("你将 [src] 切换为杀戮模式，用于切割。"))
		icon_state = "wolverine"
		inhand_icon_state = "wolverine"
		force = knife_force
		sharpness = KNIFE_SHARPNESS
		wound_bonus = knife_wound_bonus
		exposed_wound_bonus = KNIFE_EXPOSED_WOUND_BONUS
		hitsound = KNIFE_HITSOUND
		usesound = KNIFE_USESOUND
		attack_verb_continuous = KNIFE_ATTACK_VERB_CONTINUOUS
		attack_verb_simple = KNIFE_ATTACK_VERB_SIMPLE

/obj/item/knife/razor_claws/attackby(obj/item/stone, mob/user, param)
	if(!istype(stone, /obj/item/scratching_stone))
		return ..()

	knife_force = ENHANCED_KNIFE_FORCE
	knife_wound_bonus = ENHANCED_KNIFE_WOUND_BONUS
	armour_penetration = ENHANCED_KNIFE_ARMOR_PENETRATION //Let's give them some AP for the trouble.

	if(tool_behaviour == TOOL_KNIFE)
		force = knife_force
		wound_bonus = knife_wound_bonus

	name = "强化剃刀利爪"
	desc += span_warning("\n\n它们经历了特殊的研磨工艺，杀人速度比以往更快了。")
	user.visible_message(span_warning("[user] 磨利了 [src]，[stone] 随之崩解！"), span_warning("你磨利了 [src]，使它比以往更加致命，但 [stone] 在压力下崩解了。"))
	playsound(src, 'sound/items/unsheath.ogg', 25, TRUE)
	qdel(stone)
	return ..()

/obj/item/organ/cyberimp/arm/toolkit/razor_claws
	name = "剃刀利爪植入体"
	desc = "一套隐藏在指尖的可伸缩刀刃；半机械人雇佣兵认证。"
	items_to_create = list(/obj/item/knife/razor_claws)
	actions_types = list(/datum/action/item_action/organ_action/toggle/razor_claws)
	icon = 'modular_skyrat/modules/implants/icons/razorclaws.dmi'
	icon_state = "wolverine"
	extend_sound = 'sound/items/unsheath.ogg'
	retract_sound = 'sound/items/sheath.ogg'

/// bespoke subtypes for augs menu since it's a bit wonky
/obj/item/organ/cyberimp/arm/toolkit/razor_claws/right_arm
	zone = BODY_ZONE_R_ARM
	slot = ORGAN_SLOT_RIGHT_ARM_AUG

/obj/item/organ/cyberimp/arm/toolkit/razor_claws/left_arm
	zone = BODY_ZONE_L_ARM
	slot = ORGAN_SLOT_LEFT_ARM_AUG


/datum/action/item_action/organ_action/toggle/razor_claws
	name = "伸出利爪"
	desc = "你也可以激活手中的利爪来切换其模式。"
	button_icon = 'modular_skyrat/master_files/icons/hud/actions.dmi'
	button_icon_state = "wolverine"

/obj/item/organ/cyberimp/arm/toolkit/hacker
	name = "黑客手臂植入体"
	desc = "一种小型手臂植入体，内含高级螺丝刀、钢丝钳与多功能工具，专为工程师与现场机械改造而设计。虽然名字容易让人误解，但它其实完全合法。"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "toolkit_engiborg_multitool"
	items_to_create = list(/obj/item/screwdriver/cyborg, /obj/item/wirecutters/cyborg, /obj/item/multitool/abductor/implant)

/obj/item/organ/cyberimp/arm/toolkit/botany
	name = "园艺手臂植入体"
	desc = "一种相当简单的手臂植入体，内含园艺与植物学研究所需的工具。"
	items_to_create = list(/obj/item/cultivator, /obj/item/shovel/spade, /obj/item/hatchet, /obj/item/gun/energy/floragun, /obj/item/plant_analyzer, /obj/item/geneshears, /obj/item/secateurs, /obj/item/storage/bag/plants, /obj/item/storage/bag/plants/portaseeder)

/obj/item/implant_mounted_chainsaw
	name = "集成式链锯"
	desc = "一把藏在你手臂内部的链锯。"
	icon = 'icons/obj/weapons/chainsaw.dmi'
	icon_state = "chainsaw_on"
	inhand_icon_state = "mounted_chainsaw"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	force = 24
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("锯切", "撕扯", "划裂", "割开", "劈砍", "切丁")
	attack_verb_simple = list("锯切", "撕扯", "划裂", "割开", "劈砍", "切丁")
	hitsound = 'sound/items/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 1

/obj/item/organ/cyberimp/arm/toolkit/botany/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	to_chat(usr, span_notice("你解锁了 [src] 的豪华园林设备！"))
	items_list += WEAKREF(new /obj/item/implant_mounted_chainsaw(src)) //time to landscape the station
	obj_flags |= EMAGGED
	return TRUE

/obj/item/multitool/abductor/implant
	name = "多功能工具"
	desc = "一款经过优化、高度先进且精简的多功能工具，与电子设备的交互能力远超其标准型号。"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "toolkit_engiborg_multitool"

/obj/item/organ/cyberimp/arm/toolkit/janitor
	name = "清洁工具植入体"
	desc = "一套安装在受术者手臂上的清洁工具。"
	items_to_create = list(/obj/item/lightreplacer, /obj/item/holosign_creator, /obj/item/soap/nanotrasen, /obj/item/reagent_containers/spray/cyborg_drying, /obj/item/mop/advanced, /obj/item/pushbroom/advanced/augment, /obj/item/paint/paint_remover, /obj/item/reagent_containers/cup/beaker/large, /obj/item/reagent_containers/spray/cleaner) //Beaker if for refilling sprays

/obj/item/organ/cyberimp/arm/toolkit/janitor/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	to_chat(usr, span_notice("你解锁了 [src] 的集成式豪华清洁用品！"))
	items_list += WEAKREF(new /obj/item/soap/syndie(src)) //We add not replace.
	items_list += WEAKREF(new /obj/item/reagent_containers/spray/cyborg_lube(src))
	obj_flags |= EMAGGED
	return TRUE

/obj/item/organ/cyberimp/arm/toolkit/lighter
	name = "打火机植入体"
	desc = "一个……植入式打火机。毫无用处。"
	items_to_create = list(/obj/item/lighter/greyscale) //Hilariously useless.

/obj/item/organ/cyberimp/arm/toolkit/lighter/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	to_chat(usr, span_notice("你解锁了 [src] 的集成式 Zippo 打火机！终于能体面地抽烟了！"))
	items_list += WEAKREF(new /obj/item/lighter(src)) //Now you can choose between bad and worse!
	obj_flags |= EMAGGED
	return TRUE

#undef KNIFE_HITSOUND
#undef KNIFE_USESOUND
#undef KNIFE_ATTACK_VERB_CONTINUOUS
#undef KNIFE_ATTACK_VERB_SIMPLE
#undef KNIFE_SHARPNESS
#undef KNIFE_EXPOSED_WOUND_BONUS
#undef CUTTER_HITSOUND
#undef CUTTER_USESOUND
#undef CUTTER_ATTACK_VERB_CONTINUOUS
#undef CUTTER_ATTACK_VERB_SIMPLE
#undef CUTTER_FORCE
#undef CUTTER_WOUND_BONUS
#undef ENHANCED_KNIFE_FORCE
#undef ENHANCED_KNIFE_WOUND_BONUS
#undef ENHANCED_KNIFE_ARMOR_PENETRATION
