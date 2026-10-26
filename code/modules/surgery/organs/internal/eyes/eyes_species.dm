/obj/item/organ/eyes/night_vision/mushroom
	name = "真菌眼"
	desc = "虽然从外表看它们呆滞如死物，但蘑菇人的眼睛其实非常先进。"
	low_light_cutoff = list(0, 15, 20)
	medium_light_cutoff = list(0, 20, 35)
	high_light_cutoff = list(0, 40, 50)
	pupils_name = "photosensory openings"
	penlight_message = "长在菌柄上"

/obj/item/organ/eyes/zombie
	name = "亡灵眼"
	desc = "有些违反直觉的是，这双半腐烂的眼睛视力其实比活人还好。"
	color_cutoffs = list(25, 35, 5)
	penlight_message = "已经腐烂败坏了！"

/obj/item/organ/eyes/zombie/penlight_examine(mob/living/viewer, obj/item/examtool)
	return span_danger("[owner]的眼睛[penlight_message]")

/obj/item/organ/eyes/alien
	name = "异形眼"
	desc = "结果它们居然真的有眼睛！"
	sight_flags = SEE_MOBS
	color_cutoffs = list(25, 5, 42)

/obj/item/organ/eyes/golem
	name = "共鸣水晶"
	desc = "魔像不知怎地能用这块灵敏的矿物晶格测量外界光照强度，并探测附近的矿石。"
	icon_state = "adamantine_cords"
	eye_icon_state = null
	blink_animation = FALSE
	iris_overlay = null
	color = COLOR_GOLEM_GRAY
	visual = FALSE
	organ_flags = ORGAN_MINERAL
	color_cutoffs = list(10, 15, 5)
	actions_types = list(/datum/action/cooldown/golem_ore_sight)
	penlight_message = "微微闪光，其晶体结构将光线折射进内部"
	pupils_name = "lensing gems" // Given it says these are a "mineral lattice" that collects light i assume they work like artifical ruby laser foci

/// Send an ore detection pulse on a cooldown
/datum/action/cooldown/golem_ore_sight
	name = "矿石共鸣"
	desc = "使附近的矿石振动，从而显露它们的位置。"
	button_icon = 'icons/obj/devices/scanner.dmi'
	button_icon_state = "manual_mining"
	check_flags = AB_CHECK_CONSCIOUS
	cooldown_time = 10 SECONDS

/datum/action/cooldown/golem_ore_sight/Activate(atom/target)
	. = ..()
	mineral_scan_pulse(get_turf(target), scanner = target)

/obj/item/organ/eyes/moth
	name = "蛾眼"
	desc = "这双眼睛似乎对强光更加敏感，而弱光下的视力并未得到改善。"
	icon_state = "eyes_moth"
	eye_icon_state = "motheyes"
	blink_animation = FALSE
	iris_overlay = null
	flash_protect = FLASH_PROTECTION_SENSITIVE
	pupils_name = "ommatidia" //yes i know compound eyes have no pupils shut up
	penlight_message = "呈球状，带有昆虫特征"

/obj/item/organ/eyes/ghost
	name = "幽灵眼"
	desc = "虽然没有瞳孔，这双眼睛的视力却相当不错。"
	icon_state = "eyes-ghost"
	blink_animation = FALSE
	movement_type = PHASING
	organ_flags = parent_type::organ_flags | ORGAN_GHOST

/obj/item/organ/eyes/snail
	name = "蜗牛眼"
	desc = "这双眼睛的视野似乎很广，但戴眼镜时可能会很碍事。"
	icon_state = "eyes_snail"
	eye_icon_state = "snail_eyes"
	blink_animation = FALSE
	pupils_name = "eyestalks" //many species of snails can retract their eyes into their face! (my lame science excuse for not having better writing here)
	penlight_message = "长在可伸缩的触角上"

/obj/item/organ/eyes/jelly
	name = "果冻眼"
	desc = "这双眼睛由柔软的果冻构成。不过与其他所有眼睛不同，它们一共有三只。"
	icon_state = "eyes_jelly"
	eye_icon_state = "jelleyes"
	blink_animation = FALSE
	iris_overlay = null
	pupils_name = "lensing bubbles" //imagine a water lens physics demo but with goo. thats how these work.
	penlight_message = "是三个折射光线的果冻泡"

/obj/item/organ/eyes/lizard
	name = "爬行动物眼"
	desc = "一对爬行动物的眼睛，瞳孔是细长的竖缝。"
	icon_state = "lizard_eyes"
	synchronized_blinking = TRUE //BUBBERSTATION CHANGE: FALSE TO TRUE
	pupils_name = "slit pupils"
	penlight_message = "有着垂直的竖瞳与带色素的眼白"

/obj/item/organ/eyes/pod
	name = "豆荚眼"
	desc = "你见过的最奇怪的沙拉。"
	icon_state = "eyes_pod"
	// BUBBER EDIT - REMOVAL - START
	/*
	eye_color_left = "#375846"
	eye_color_right = "#375846"
	iris_overlay = null
	*/
	// BUBBER EDIT - REMOVAL - END
	foodtype_flags = PODPERSON_ORGAN_FOODTYPES
	penlight_message = "呈绿色，一副植物模样"

/obj/item/organ/eyes/felinid
	name = "猫人族眼"
	desc = "一对高度反光的眼睛，瞳孔是竖缝，就像猫的一样。"
	pupils_name = "slit pupils"
	penlight_message = "在珍珠般的光下闪闪发亮"
