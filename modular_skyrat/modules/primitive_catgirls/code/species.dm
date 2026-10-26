/mob/living/carbon/human/species/felinid/primitive
	race = /datum/species/human/felinid/primitive

/datum/language_holder/primitive_felinid
	understood_languages = list(
		/datum/language/primitive_catgirl = list(LANGUAGE_ATOM),
		/datum/language/siiktajr = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/primitive_catgirl = list(LANGUAGE_ATOM),
		/datum/language/siiktajr = list(LANGUAGE_ATOM),
	)
	selected_language = /datum/language/primitive_catgirl

/datum/species/human/felinid/primitive
	name = "Hearthkin"
	plural_form = "Hearthkin"
	id = SPECIES_FELINE_PRIMITIVE

	mutantlungs = /obj/item/organ/lungs/icebox_adapted
	mutanteyes = /obj/item/organ/eyes/low_light_adapted
	mutanttongue = /obj/item/organ/tongue/cat/primitive

	species_language_holder = /datum/language_holder/primitive_felinid
	language_prefs_whitelist = list(/datum/language/primitive_catgirl)

	bodytemp_normal = 270 // If a normal human gets hugged by one its gonna feel cold
	bodytemp_heat_damage_limit = 283 // To them normal station atmos would be sweltering
	bodytemp_cold_damage_limit = 213 // Man up bro its not even that cold out here

	inherent_traits = list(
		TRAIT_VIRUSIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_USES_SKINTONES,
	)
	sort_bottom = TRUE //BUBBER EDIT ADDITION: We want to sort this to the bottom because it's a ghostrole only species.

	always_customizable = TRUE

/datum/species/human/felinid/primitive/get_default_mutant_bodyparts()
	return list(
		"legs" = list("Normal Legs", FALSE),
	)

/datum/species/human/felinid/primitive/on_species_gain(mob/living/carbon/new_primitive, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	var/mob/living/carbon/human/hearthkin = new_primitive
	if(!istype(hearthkin))
		return
	hearthkin.dna.add_mutation(/datum/mutation/olfaction, MUTATION_SOURCE_SPECIES)

/datum/species/human/felinid/primitive/on_species_loss(mob/living/carbon/former_primitive, datum/species/new_species, pref_load)
	. = ..()
	var/mob/living/carbon/human/hearthkin = former_primitive
	if(!istype(hearthkin))
		return
	hearthkin.dna.remove_mutation(/datum/mutation/olfaction, MUTATION_SOURCE_SPECIES)

/datum/species/human/felinid/primitive/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.hairstyle = "Slightly Messy"
	human_for_preview.hair_color = "#954535"
	human_for_preview.skin_tone = "albino"
	human_for_preview.set_eye_color("#6ca580")

	human_for_preview.dna.species.mutant_bodyparts[FEATURE_TAIL_GENERIC] = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list(human_for_preview.hair_color))
	human_for_preview.dna.mutant_bodyparts[FEATURE_EARS] = list(MUTANT_INDEX_NAME = "Lynx", MUTANT_INDEX_COLOR_LIST = list(human_for_preview.hair_color))

	regenerate_organs(human_for_preview, src, visual_only = TRUE)
	human_for_preview.update_body_parts()
	human_for_preview.update_body(is_creating = TRUE)

/datum/species/human/felinid/primitive/get_species_description()
	return list(
		"一种基因改造的人形生物，据信是数百年前、蓝空间航行时代之前一艘殖民船\
			乘员的后裔。仍保留至少部分人类特征，\
			与当今的猫人最为相似；大多数外貌特征很可能源自\
			冰月上众多动物的基因。"
	)

/datum/species/human/felinid/primitive/get_species_lore()
	return list(
		"炉裔的形态始终属于亚人：外貌近似普通人类，\
			却拥有狼、熊、猫科等极地动物的尾巴、耳朵和四肢。\
			他们适应了弗蕾亚寒冷的地表，却觉得纳米传讯空间站温和可控的室温酷热难耐。\
			炉裔是斯嘉恩德拉克号——也就是“星龙号”——上北欧基因改造者的后代。\
			这艘庞大的殖民船于四百年前在最终安息之地的轨道上发生了爆炸，\
			那里便是冰月弗蕾亚，爆炸原因不明。星龙号的大段舱体断裂并封闭，碎片散落于地表。\
			炉裔相信自己是最早到来的人，但事实是否如此，无人知晓。",

		"炉火本身神圣不可侵犯，由对外来者保持合理警惕的族人守护。炉裔是亚人，由氏族首领取名，\
			名字结合父母一方的名字与氏族赐予的称号，如“溺魂”或“雪眼”。\
			与灰行者不同，炉裔社会的技术更为先进，借助飞船残骸发展了锻造、吹玻璃等工艺。\
			然而出于种种原因，他们往往回避使用现代技术。但这并不意味着他们奉行孤立主义——\
			不少来历不明的人借炉裔的基因奇迹隐姓埋名，多年来与外族通婚也产生了包括银鳞裔在内的许多支系。",

		"星龙号解体后，医疗物资所剩无几，唯一没有被搜刮干净的，是一批用于水培的大地之血。\
			它治愈了致命伤，却付出惨重代价——他们的心智再也无法恢复。准殖民者的生活异常艰难，每一代都很短命，\
			多数技术知识在撞击或严寒中失传。尽管基因改造和原本对冰寒气候的适应有所帮助，\
			据说炉裔仍孤注一掷，集中所有资源，想永远保护自己免受弗蕾亚的侵袭。\
			纳米传讯测得的大气数据揭示，炉裔脚下存在一个巨大的热源。",

		"如今，炉裔已形成独特的文化。星龙号的许多原始舱段深埋冰雪之下，炉裔\
			建起许多居所掩藏它们。他们住在长屋中，睡在亲手挖出的	温暖隧道里，\
			猎捕当地动物，以及从通往冰月母星因德西菲瑞斯的传送门中出现的生物。对神灵的崇拜与献祭\
			使信仰愈发坚定。炉裔敬重先人，但很少有人记得他们原本的模样。",
	)
