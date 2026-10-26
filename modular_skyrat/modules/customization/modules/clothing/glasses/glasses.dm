/obj/item/clothing/glasses	//Code to let you switch the side your eyepatch is on! Woo! Just an explanation, this is added to the base glasses so it works on eyepatch-huds too
	var/can_switch_eye = FALSE	//Having this default to false means that its easy to make sure this doesnt apply to any pre-existing items


/obj/item/clothing/glasses/examine(mob/user)
	. = ..()
	if(can_switch_eye)
		. += "在手中使用可把它戴在[icon_state == base_icon_state ? "左" : "右"]眼上。"


/* ---------- Items Below ----------*/

/obj/item/clothing/glasses/eyepatch	//Re-defined here for ease with the left/right switch
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "eyepatch"
	base_icon_state = "eyepatch"
	can_switch_eye = TRUE

/obj/item/clothing/glasses/eyepatch/wrap
	name = "眼部绷带"
	desc = "一条堪称华丽的绷带。至少这一条真的是为你的脑袋做的……"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "eyewrap"
	base_icon_state = "eyewrap"

/obj/item/clothing/glasses/eyepatch/white
	name = "白色眼罩"
	desc = "这就是海盗拿到博士学位后的样子。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "eyepatch_white"
	base_icon_state = "eyepatch_white"

///GLASSSES
/obj/item/clothing/glasses/thin
	name = "细框眼镜"
	desc = "常被人看到正低头盯着某个拿书的人。"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	icon_state = "glasses_thin"
	inhand_icon_state = "glasses"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/regular/betterunshit
	name = "现代眼镜"
	desc = "在书呆子公司因逃税与入侵而破产后，他们被笨蛋公司收购，后者重塑了他们的经典设计。"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	icon_state = "glasses_alt"
	inhand_icon_state = "glasses"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/kim
	name = "四眼仔镜片"
	desc = "时髦的圆镜片，带有微妙的遮光效果，既保护你，又让罪犯不舒服。"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	icon_state = "binoclard_lenses"
	inhand_icon_state = "glasses"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/trickblindfold/hamburg
	name = "窃贼面甲"
	desc = "最适合从无辜的跨国资本主义垄断企业手里偷汉堡。"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	icon_state = "thiefmask"

///GOGGLES
/obj/item/clothing/glasses/biker
	name = "摩托车护目镜"
	desc = "棕色皮革骑行装备。你可以走，把汽油留给我们。"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	icon_state = "biker"
	inhand_icon_state = "welding-g"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

// Like sunglasses, but without any protection
/obj/item/clothing/glasses/fake_sunglasses
	name = "低紫外线太阳镜"
	desc = "一个价格更便宜、防紫外线等级低得多的太阳镜品牌。对强光毫无防护作用。"
	icon_state = "sun"
	inhand_icon_state = "sunglasses"
