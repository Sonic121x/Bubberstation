// SKYRAT GOOD TRAITS

/datum/quirk/hard_soles
	name = "Hardened Soles"
	desc = "你习惯赤脚行走，不会受到这样做带来的负面影响。"
	value = 2
	mob_trait = TRAIT_HARD_SOLES
	gain_text = span_notice("地面不再让你的脚感到粗糙难受。")
	lose_text = span_danger("你开始感觉到地面上的棱角和凹凸。")
	medical_record_text = "患者脚部更能承受摩擦。"
	icon = FA_ICON_SHAPES

/datum/quirk/linguist
	name = "Linguist"
	desc = "你研习过多种语言，拥有额外一个语言点。"
	value = 2
	mob_trait = TRAIT_LINGUIST
	gain_text = span_notice("你的大脑似乎更擅长理解不同的交流方式了。")
	lose_text = span_danger("你对龙语习语中微妙含义的理解逐渐消失了。")
	medical_record_text = "患者在语言学习方面表现出很高的脑部可塑性。"
	icon = FA_ICON_BOOK_ATLAS

/datum/quirk/sharpclaws
	name = "Sharp Claws"
	desc = "无论是猎食者的天生构造，还是你在柔术课前坚决不肯剪指甲，你的徒手攻击都更加锐利，能让人流血。"
	value = 2
	gain_text = span_notice("尖锐的指甲让你的手掌有些刺痛。")
	lose_text = span_danger("指甲变钝让你觉得少了些什么；现在挠痒可没那么方便了。")
	medical_record_text = "患者抓破了检查台的软垫；建议修剪爪子。"
	icon = FA_ICON_LINES_LEANING

/datum/quirk/sharpclaws/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!istype(human_holder))
		return FALSE

	var/obj/item/bodypart/arm/left/left_arm = human_holder.get_bodypart(BODY_ZONE_L_ARM)
	if(left_arm)
		left_arm.unarmed_attack_verbs = list("抓挠")
		left_arm.unarmed_attack_effect = ATTACK_EFFECT_CLAW
		left_arm.unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
		left_arm.unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'
		left_arm.unarmed_sharpness = SHARP_EDGED

	var/obj/item/bodypart/arm/right/right_arm = human_holder.get_bodypart(BODY_ZONE_R_ARM)
	if(right_arm)
		right_arm.unarmed_attack_verbs = list("抓挠")
		right_arm.unarmed_attack_effect = ATTACK_EFFECT_CLAW
		right_arm.unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
		right_arm.unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'
		right_arm.unarmed_sharpness = SHARP_EDGED

/datum/quirk/sharpclaws/remove(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/bodypart/arm/left/left_arm = human_holder.get_bodypart(BODY_ZONE_L_ARM)
	if(left_arm)
		left_arm.unarmed_attack_verbs = list("拳击")
		left_arm.unarmed_attack_effect = initial(left_arm.unarmed_attack_effect)
		left_arm.unarmed_attack_sound = initial(left_arm.unarmed_attack_sound)
		left_arm.unarmed_miss_sound = initial(left_arm.unarmed_miss_sound)
		left_arm.unarmed_sharpness = initial(left_arm.unarmed_sharpness)

	var/obj/item/bodypart/arm/right/right_arm = human_holder.get_bodypart(BODY_ZONE_R_ARM)
	if(right_arm)
		right_arm.unarmed_attack_verbs = list("拳击")
		right_arm.unarmed_attack_effect = initial(right_arm.unarmed_attack_effect)
		right_arm.unarmed_attack_sound = initial(right_arm.unarmed_attack_sound)
		right_arm.unarmed_miss_sound = initial(right_arm.unarmed_miss_sound)
		right_arm.unarmed_sharpness = initial(right_arm.unarmed_sharpness)

/datum/quirk/water_breathing
	name = "Water breathing"
	desc = "你能够在水下呼吸！"
	value = 2
	mob_trait = TRAIT_NODROWN
	gain_text = span_notice("你清晰地感受到肺部和空气中的水分，感觉很舒服。")
	lose_text = span_danger("你突然发现肺里的水分让你感觉<i>非常奇怪</i>，差点因此呛住！")
	medical_record_text = "患者的生理构造适合水下呼吸。"
	icon = FA_ICON_FISH

// AdditionalEmotes *turf quirks
/datum/quirk/water_aspect
	name = "Water aspect (Emotes)"
	desc = "（水生生物天赋）水下社会就是你的家，太空也没什么不同。（说 *turf 来施展）"
	value = 0
	mob_trait = TRAIT_WATER_ASPECT
	gain_text = span_notice("你觉得自己能够控制水。")
	lose_text = span_danger("不知为何，你失去了控制水的能力！")
	medical_record_text = "患者体内有一组用于合成水的纳米机器人。"
	icon = FA_ICON_WATER

/datum/quirk/webbing_aspect
	name = "Webbing aspect (Emotes)"
	desc = "（昆虫天赋）能够织网的虫族早已习惯那些没有天生 3D 打印机的人投来的羡慕目光。（说 *turf 来施展）"
	value = 0
	mob_trait = TRAIT_WEBBING_ASPECT
	gain_text = span_notice("你能轻松地织出一张网。")
	lose_text = span_danger("不知为何，你失去了织网的能力。")
	medical_record_text = "患者能够用自身合成的丝织网。"
	icon = FA_ICON_STICKY_NOTE

/datum/quirk/floral_aspect
	name = "Floral aspect (Emotes)"
	desc = "（豆荚人天赋）葛藤研究并非毫无意义，快速光合作用技术已经到来！（说 *turf 来施展）"
	value = 0
	mob_trait = TRAIT_FLORAL_ASPECT
	gain_text = span_notice("你觉得自己能催生藤蔓。")
	lose_text = span_danger("不知为何，你失去了快速进行光合作用的能力。")
	medical_record_text = "患者能够通过快速光合作用催生藤蔓。"
	icon = FA_ICON_PLANT_WILT

/datum/quirk/ash_aspect
	name = "Ash aspect (Emotes)"
	desc = "（蜥蜴人天赋）制造灰烬和火焰的强大力量——却大多被用来表演。（说 *turf 来施展）"
	value = 0
	mob_trait = TRAIT_ASH_ASPECT
	gain_text = span_notice("你的体内仿佛有一座熏燃的熔炉。")
	lose_text = span_danger("不知为何，你失去了喷火的能力。")
	medical_record_text = "患者具有蜥蜴人常见的喷火腺体。"
	icon = FA_ICON_FIRE_ALT

/datum/quirk/sparkle_aspect
	name = "Sparkle aspect (Emotes)"
	desc = "（蛾人天赋）像蛾翼的鳞粉一样闪闪发亮，又像廉价红灯区约会中的亮片。（说 *turf 来施展）"
	value = 0
	mob_trait = TRAIT_SPARKLE_ASPECT
	gain_text = span_notice("你浑身沾满了闪亮的粉尘！")
	lose_text = span_danger("不知为何，你身上的闪粉已经彻底消失了……")
	medical_record_text = "患者看起来光彩照人。"
	icon = FA_ICON_HAND_SPARKLES

/datum/quirk/no_appendix
	name = "Appendicitis Survivor"
	desc = "你曾患过阑尾炎，现在已经没有阑尾了。"
	icon = FA_ICON_NOTES_MEDICAL
	value = 2
	gain_text = span_notice("你已经没有阑尾了。")
	lose_text = span_danger("你的阑尾竟然奇迹般地……重新长出来了？")
	medical_record_text = "患者曾患阑尾炎，阑尾已通过手术切除。"
	/// The mob's original appendix
	var/obj/item/organ/appendix/old_appendix

/datum/quirk/no_appendix/post_add()
	var/mob/living/carbon/carbon_quirk_holder = quirk_holder
	old_appendix = carbon_quirk_holder.get_organ_slot(ORGAN_SLOT_APPENDIX)

	if(isnull(old_appendix))
		return

	old_appendix.Remove(carbon_quirk_holder, special = TRUE)
	old_appendix.moveToNullspace()

	STOP_PROCESSING(SSobj, old_appendix)

/datum/quirk/no_appendix/remove()
	var/mob/living/carbon/carbon_quirk_holder = quirk_holder

	if(isnull(old_appendix))
		return

	var/obj/item/organ/appendix/current_appendix = carbon_quirk_holder.get_organ_slot(ORGAN_SLOT_APPENDIX)

	// if we have not gained an appendix already, put the old one back
	if(isnull(current_appendix))
		old_appendix.Insert(carbon_quirk_holder, special = TRUE)
	else
		qdel(old_appendix)

	old_appendix = null
