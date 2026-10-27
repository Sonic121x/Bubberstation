/*
 * Tier zero entries are unlocked at the start, and are for dna mutants that are:
 * - a roundstart race (felinid)
 * - something of equal power to a roundstart race (flyperson)
 * - mutants without a bonus, just bringing cosmetics (fox ears)
 * basically just meme, cosmetic, and base species entries
*/
/datum/infuser_entry/fly
	name = "Rejected"
	infuse_mob_name = "被排斥的生物"
	desc = "不知为何，身体排斥DNA时，这些DNA会恶化，最终变成某种类似苍蝇的混乱DNA。"
	threshold_desc = "混乱的DNA占据主导，你会完全变成苍蝇人。"
	qualities = list(
		"说话嗡嗡作响",
		"喝呕吐物",
		"无法辨认的器官",
		"这不是个好主意",
	)
	output_organs = list(
		/obj/item/organ/appendix/fly,
		/obj/item/organ/eyes/fly,
		/obj/item/organ/heart/fly,
		/obj/item/organ/lungs/fly,
		/obj/item/organ/stomach/fly,
		/obj/item/organ/tongue/fly,
	)
	infusion_desc = "像苍蝇"
	tier = DNA_MUTANT_TIER_ZERO

/datum/infuser_entry/vulpini
	name = "狐狸"
	infuse_mob_name = "狐族动物"
	desc = "由于2555年的‘狐耳’热潮，狐狸如今相当稀少。我的意思是，也因为我们这些太空旅行者很久以前就破坏了狐狸的自然栖息地，不过这对大多数动物都适用。"
	threshold_desc = DNA_INFUSION_NO_THRESHOLD
	qualities = list(
		"不是吧，你认真的？",
		"你让所有遗传学家蒙羞",
		"希望你觉得这值得",
	)
	input_obj_or_mob = list(
		/mob/living/basic/pet/fox,
	)
	output_organs = list(
		/obj/item/organ/ears/fox,
	)
	infusion_desc = "不可原谅"
	tier = DNA_MUTANT_TIER_ZERO

/datum/infuser_entry/mothroach
	name = "蛾蟑"
	infuse_mob_name = "鳞翅蜚蠊科生物"
	desc = "所以，他们先将飞蛾和蟑螂DNA混合，造出了蛾蟑，现在我们又把蛾蟑DNA与人形生物混合，造出蛾人混种？"
	threshold_desc = DNA_INFUSION_NO_THRESHOLD
	qualities = list(
		"眼睛怕强光",
		"说话时会扑动翅膀",
		"翅膀连你的体重都托不起来",
		"希望你觉得这值得",
	)
	input_obj_or_mob = list(
		/mob/living/basic/mothroach,
	)
	output_organs = list(
		/obj/item/organ/antennae,
		/obj/item/organ/wings/moth,
		/obj/item/organ/eyes/moth,
		/obj/item/organ/tongue/moth,
	)
	infusion_desc = "毛茸茸"
	tier = DNA_MUTANT_TIER_ZERO

/datum/infuser_entry/lizard
	name = "蜥蜴"
	infuse_mob_name = "蜥蜴类动物"
	desc = "事实证明，大多数人形生物融合蜥蜴DNA后，会出现与蜥蜴人极其相似的特征。真是奇妙的巧合。"
	threshold_desc = DNA_INFUSION_NO_THRESHOLD
	qualities = list(
		"长尾巴",
		"装饰性的角",
		"美观的吻部",
		"说实话，没多少别的",
	)
	input_obj_or_mob = list(
		/mob/living/basic/lizard,
	)
	output_organs = list(
		/obj/item/organ/horns,
		/obj/item/organ/frills,
		/obj/item/organ/snout,
		/obj/item/organ/tail/lizard,
		/obj/item/organ/tongue/lizard,
	)
	infusion_desc = "多鳞"
	tier = DNA_MUTANT_TIER_ZERO

/datum/infuser_entry/felinid
	name = "猫"
	infuse_mob_name = "猫科动物"
	desc = "大家冷静！这个条目没有任何暗示。猫人就是混入猫科DNA的人类，这有什么可惊讶的？"
	threshold_desc = DNA_INFUSION_NO_THRESHOLD
	qualities = list(
		"哦，让我猜猜，你很喜欢那些日本游客机器人吧",
	)
	input_obj_or_mob = list(
		/mob/living/basic/pet/cat,
	)
	output_organs = list(
		/obj/item/organ/ears/cat,
		/obj/item/organ/tail/cat,
	)
	infusion_desc = "温顺亲人"
	tier = DNA_MUTANT_TIER_ZERO

/datum/infuser_entry/penguin
	name = "企鹅"
	infuse_mob_name = "企鹅"
	desc = "说实话，除了走路很滑稽之外，从企鹅DNA里也找不出多少亮点。"
	threshold_desc = DNA_INFUSION_NO_THRESHOLD
	qualities = list(
		"走路时摇摇摆摆",
	)
	input_obj_or_mob = list(
		/mob/living/basic/pet/penguin,
	)
	output_organs = list(
		/obj/item/organ/ears/penguin,
	)
	infusion_desc = "摇摇摆摆"
	tier = DNA_MUTANT_TIER_ZERO

/datum/infuser_entry/plants
	name = "植物"
	infuse_mob_name = "植物混种"
	desc = "水培研究长期致力于将人类DNA拼接到植物DNA中，创造植物人。 \
		许多科学家不愿让那些嬉皮士抢先，便尝试反过来做——结果实在没什么意思。"
	threshold_desc = DNA_INFUSION_NO_THRESHOLD
	qualities = list(
		"给你漂亮的头发",
		"说实话，没多少别的",
	)
	input_obj_or_mob = list(
		/obj/item/food/grown,
		/obj/item/grown,
	)
	output_organs = list(
		/obj/item/organ/appendix/pod,
		/obj/item/organ/brain/pod,
		/obj/item/organ/ears/pod,
		/obj/item/organ/eyes/pod,
		/obj/item/organ/heart/pod,
		/obj/item/organ/liver/pod,
		/obj/item/organ/lungs/pod,
		/obj/item/organ/pod_hair,
		/obj/item/organ/stomach/pod,
		/obj/item/organ/tongue/pod,
	)
	infusion_desc = "像植物"
	tier = DNA_MUTANT_TIER_ZERO

/datum/infuser_entry/plants/get_output_organs(mob/living/carbon/human/target, atom/movable/infused_from)
	// Prioritize pod hair since it's the only thing that matters here
	if(!target.get_organ_by_type(/obj/item/organ/pod_hair))
		return list(/obj/item/organ/pod_hair)

	return ..()
