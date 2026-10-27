
/*
 * Pill Bottles
 */
/obj/item/storage/pill_bottle
	name = "药瓶"
	desc = "一个用于存放药品的气密容器。"
	icon_state = "pill_canister"
	icon = 'icons/obj/medical/chemical.dmi'
	inhand_icon_state = "contsolid"
	worn_icon_state = "nothing"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	pickup_sound = 'sound/items/handling/pill_bottle_pickup.ogg'
	drop_sound = 'sound/items/handling/pill_bottle_place.ogg'
	storage_type = /datum/storage/pillbottle
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.2)

	///Number of pills to spawn
	VAR_PROTECTED/spawn_count
	///Pill type to spawn
	VAR_PROTECTED/obj/item/reagent_containers/applicator/pill/spawn_type

/obj/item/storage/pill_bottle/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正试图拧开[src]的盖子！看起来是想自杀！"))
	return TOXLOSS

/obj/item/storage/pill_bottle/PopulateContents()
	SHOULD_NOT_OVERRIDE(TRUE)

	if(!spawn_count)
		return

	for(var/i in 1 to spawn_count)
		new spawn_type(src)

/obj/item/storage/pill_bottle/multiver
	name = "多价药片瓶"
	desc = "内含用于对抗毒素的药片。"
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/multiver

/obj/item/storage/pill_bottle/multiver/less
	spawn_count = 3

/obj/item/storage/pill_bottle/epinephrine
	name = "肾上腺素药片瓶"
	desc = "内含用于稳定病人状态的药片。"
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/epinephrine

/obj/item/storage/pill_bottle/mutadone
	name = "去突变药片瓶"
	desc = "内含用于治疗基因异常的药片。"
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/mutadone

/obj/item/storage/pill_bottle/potassiodide
	name = "碘化钾药片瓶"
	desc = "内含用于减轻辐射损伤的药片。"
	spawn_count = 3
	spawn_type = /obj/item/reagent_containers/applicator/pill/potassiodide

/obj/item/storage/pill_bottle/probital
	name = "普罗比妥药片瓶"
	desc = "内含用于治疗钝击伤害的药片。瓶内标签写着“服用前请先进食，可能引起疲劳”。"
	spawn_count = 4
	spawn_type = /obj/item/reagent_containers/applicator/pill/probital

/obj/item/storage/pill_bottle/iron
	name = "补铁药片瓶"
	desc = "内含可缓慢减少失血的药片。瓶内标签写着“每五分钟仅可服用一片”。"
	spawn_count = 4
	spawn_type = /obj/item/reagent_containers/applicator/pill/iron

/obj/item/storage/pill_bottle/mannitol
	name = "甘露醇药片瓶"
	desc = "内含用于治疗脑损伤的药片。"
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/mannitol

//Contains 4 pills instead of 7, and 5u pills instead of 50u (50u pills heal 250 brain damage, 5u pills heal 25)
/obj/item/storage/pill_bottle/mannitol/braintumor
	desc = "内含稀释药片，用于治疗脑肿瘤症状。感到头晕时服用一片。"
	spawn_count = 4
	spawn_type = /obj/item/reagent_containers/applicator/pill/mannitol/braintumor

/obj/item/storage/pill_bottle/stimulant
	name = "兴奋剂药片瓶"
	desc = "保证能在漫长的班次中为你额外注入一股能量！"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/stimulant

/obj/item/storage/pill_bottle/sansufentanyl
	name = "实验性药物瓶"
	desc = "由英特戴恩制药公司研发的一瓶药片，用于治疗遗传性流形病。"
	spawn_count = 6
	spawn_type = /obj/item/reagent_containers/applicator/pill/sansufentanyl

/obj/item/storage/pill_bottle/mining
	name = "贴片瓶"
	desc = "内含用于治疗钝击与烧伤的贴片。"
	spawn_count = 3
	spawn_type = /obj/item/reagent_containers/applicator/patch/libital

/obj/item/storage/pill_bottle/zoom
	name = "可疑的药瓶"
	desc = "标签相当陈旧，几乎无法辨认，你认出了其中几种化合物。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/zoom

/obj/item/storage/pill_bottle/happy
	name = "可疑的药瓶"
	desc = "瓶盖上画着一个笑脸。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/happy

/obj/item/storage/pill_bottle/lsd
	name = "可疑的药瓶"
	desc = "上面有一幅粗糙的涂鸦，看起来既像蘑菇，又像变形的月亮。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/lsd

/obj/item/storage/pill_bottle/aranesp
	name = "可疑的药瓶"
	desc = "标签上用黑色记号笔潦草地写着“去他妈的禁用器”。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/aranesp

/obj/item/storage/pill_bottle/psicodine
	name = "心定宁药片瓶"
	desc = "内含用于治疗精神痛苦与创伤的药片。"
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/psicodine

/obj/item/storage/pill_bottle/penacid
	name = "喷替酸药片瓶"
	desc = "内含用于清除辐射与毒素的药片。"
	spawn_count = 3
	spawn_type = /obj/item/reagent_containers/applicator/pill/penacid

/obj/item/storage/pill_bottle/neurine
	name = "神经碱药片瓶"
	desc = "内含用于治疗非重度精神创伤的药片。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/neurine

/obj/item/storage/pill_bottle/maintenance_pill
	name = "维护区药片瓶"
	desc = "一个陈旧的药瓶，闻起来有股霉味。"
	spawn_type = /obj/item/reagent_containers/applicator/pill/maintenance

/obj/item/storage/pill_bottle/maintenance_pill/Initialize(mapload)
	if(!spawn_count)
		spawn_count = rand(1,7)
	. = ..()
	var/obj/item/reagent_containers/applicator/pill/P = locate() in src
	name = "一瓶[P.name]"

/obj/item/storage/pill_bottle/maintenance_pill/full
	spawn_count = 7

///////////////////////////////////////// Psychologist inventory pillbottles
/obj/item/storage/pill_bottle/happinesspsych
	name = "幸福药片"
	desc = "内含作为最后手段、用于暂时稳定抑郁与焦虑的药片。警告：副作用可能包括言语不清、流涎以及严重成瘾。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/happinesspsych

/obj/item/storage/pill_bottle/lsdpsych
	name = "心智破坏毒素药片"
	desc = "！仅限治疗用途！内含用于缓解现实解离综合征症状的药片。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/lsdpsych

/obj/item/storage/pill_bottle/paxpsych
	name = "帕克斯药片"
	desc = "内含用于暂时镇静被认为会伤害自己或他人的患者的药片。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/paxpsych

/obj/item/storage/pill_bottle/naturalbait
	name = "保鲜罐"
	desc = "装满天然鱼饵。"
	spawn_count = 7
	spawn_type = /obj/item/food/bait/natural

/obj/item/storage/pill_bottle/ondansetron
	name = "昂丹司琼贴片"
	desc = "一瓶含有昂丹司琼的贴片，这种药物用于治疗恶心与呕吐。可能引起嗜睡。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/patch/ondansetron

/obj/item/storage/pill_bottle/immunodeficiency
	name = "免疫增强剂瓶"
	desc = "内含免疫系统增强剂，用于控制慢性免疫缺陷。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/spaceacillin

/obj/item/storage/pill_bottle/prescription_stimulant
	name = "处方兴奋剂药片瓶"
	desc = "一瓶温和且获药用许可的兴奋剂，用于帮助防止嗜睡。 \n\
		成分清单如下：含 3u 莫达非尼、5u 突触碱与 5u 葡萄糖。 \n\
		警告标签上写着：<b>请适量服用</b>。"
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/prescription_stimulant

/obj/item/storage/pill_bottle/sepsisillin
	name = "脓毒西林药片瓶"
	desc = "内含免疫系统抑制剂，用于辅助病毒学研究。请勿与太空青霉素混淆。"
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/sepsisillin
