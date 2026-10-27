/datum/augment_item/implant
	category = AUGMENT_CATEGORY_IMPLANTS

/datum/augment_item/implant/apply(mob/living/carbon/human/H, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup)
		return
	var/obj/item/organ/new_organ = new path()
	new_organ.Insert(H,FALSE,FALSE)

//BRAIN IMPLANTS
/datum/augment_item/implant/brain
	slot = AUGMENT_SLOT_BRAIN_IMPLANT

/datum/augment_item/implant/brain/wound_scanner
	name = "内置创伤分析器"
	cost = 1
	path = /obj/item/organ/cyberimp/brain/wound_scanner

//CHEST IMPLANTS
/datum/augment_item/implant/chest
	slot = AUGMENT_SLOT_CHEST_IMPLANT

/datum/augment_item/implant/chest/nutrimentpump
	name = "标准营养泵" // The STANDARD pump. Only gets you to 35% nutrition. You still need to eat ACTUAL food to be rid of the negative moodlet
	cost = 2
	path = /obj/item/organ/cyberimp/chest/nutriment

//LEFT ARM IMPLANTS
/datum/augment_item/implant/l_arm
	slot = AUGMENT_SLOT_LEFT_ARM_IMPLANT

/datum/augment_item/implant/l_arm/power_cord
	name = "左臂合成人接口硬件"
	path = /obj/item/organ/cyberimp/arm/toolkit/power_cord/left_arm

/datum/augment_item/implant/l_arm/razor_claws
	name = "左臂剃刀爪"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/razor_claws/left_arm

/datum/augment_item/implant/l_arm/rope
	name = "左臂攀爬钩"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/rope/left_arm

/datum/augment_item/implant/l_arm/toolkit/lighter
	name = "左臂打火机植入体"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/lighter/left_arm

/datum/augment_item/implant/l_arm/toolkit/seclite
	name = "左臂安保手电筒"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/seclite/left_arm

/datum/augment_item/implant/l_arm/toolkit/penfour
	name = "左臂四色笔"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/penfour/left_arm

/datum/augment_item/implant/l_arm/toolkit/tape_recorder
	name = "左臂录音机"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/tape_recorder/left_arm

//RIGHT ARM IMPLANTS
/datum/augment_item/implant/r_arm
	slot = AUGMENT_SLOT_RIGHT_ARM_IMPLANT

/datum/augment_item/implant/r_arm/power_cord
	name = "右臂合成人接口硬件"
	path = /obj/item/organ/cyberimp/arm/toolkit/power_cord/right_arm

/datum/augment_item/implant/r_arm/razor_claws
	name = "右臂剃刀爪"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/razor_claws/right_arm

/datum/augment_item/implant/r_arm/rope
	name = "右臂攀爬钩"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/rope/right_arm

/datum/augment_item/implant/r_arm/toolkit/lighter
	name = "右臂打火机植入体"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/lighter/right_arm

/datum/augment_item/implant/r_arm/toolkit/seclite
	name = "右臂安保手电筒"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/seclite/right_arm

/datum/augment_item/implant/r_arm/toolkit/penfour
	name = "右臂四色笔"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/penfour/right_arm

/datum/augment_item/implant/r_arm/toolkit/tape_recorder
	name = "右臂录音机"
	cost = 1
	path = /obj/item/organ/cyberimp/arm/toolkit/tape_recorder/right_arm

//EYES IMPLANTS
/datum/augment_item/implant/eyes
	slot = AUGMENT_SLOT_EYES_IMPLANT

/datum/augment_item/implant/eyes/civhud
	name = "民用 HUD 植入体"
	cost = 2
	path = /obj/item/organ/cyberimp/eyes/hud/civilian

/datum/augment_item/implant/eyes/civhudinvis
	name = "民用 HUD 植入体（隐形）"
	cost = 2
	path = /obj/item/organ/cyberimp/eyes/hud/civilian/invisible

//MOUTH IMPLANTS
/datum/augment_item/implant/mouth
	slot = AUGMENT_SLOT_MOUTH_IMPLANT

/datum/augment_item/implant/mouth/breathing_tube
	name = "呼吸管"
	cost = 2
	path = /obj/item/organ/cyberimp/mouth/breathing_tube
