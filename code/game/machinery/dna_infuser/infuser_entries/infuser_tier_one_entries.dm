/*
 * Tier one entries are unlocked at the start, and are for dna mutants that are:
 * - easy to acquire (rats)
 * - have a bonus for getting past a threshold
 * - might serve a job purpose for others (goliath) and thus should be gainable early enough
*/
/datum/infuser_entry/goliath
	name = "歌利亚"
	infuse_mob_name = "歌利亚"
	desc = "那个说‘与怪物战斗的人，应当小心自己也变成怪物’的家伙，显然没见过歌利亚矿工的本事！"
	threshold_desc = "你可以在岩浆上行走！"
	qualities = list(
		"能呼吸空间站和熔岩地带的空气，但要小心纯氧",
		"免疫灰烬风暴",
		"双眼能够在黑暗中视物",
		"触须手能轻松凿穿玄武岩并消灭敌对生物，不过你再也戴不了手套了……",
	)
	input_obj_or_mob = list(
		/mob/living/basic/mining/goliath,
	)
	output_organs = list(
		/obj/item/organ/brain/goliath,
		/obj/item/organ/eyes/night_vision/goliath,
		/obj/item/organ/heart/goliath,
		/obj/item/organ/lungs/lavaland/goliath,
	)
	infusion_desc = "像带甲的触须生物"
	tier = DNA_MUTANT_TIER_ONE
	status_effect_type = /datum/status_effect/organ_set_bonus/goliath

/datum/infuser_entry/carp
	name = "鲤鱼"
	infuse_mob_name = "太空鲤科生物"
	desc = "鲤鱼变种人十分适合长期深空探索。事实上，不去探索反而会让他们难以忍受！"
	threshold_desc = "你学会了在太空中自行推进，就像鱼一样！"
	qualities = list(
		"大嘴巴，大牙齿",
		"在太空中游动，毫无问题",
		"一回空间站，各种问题都来了",
		"总想四处漫游",
	)
	input_obj_or_mob = list(
		/mob/living/basic/carp,
	)
	output_organs = list(
		/obj/item/organ/brain/carp,
		/obj/item/organ/fangs/carp,
		/obj/item/organ/heart/carp,
		/obj/item/organ/lungs/carp,
		/obj/item/organ/tongue/carp,
	)
	infusion_desc = "爱好漫游"
	tier = DNA_MUTANT_TIER_ONE
	status_effect_type = /datum/status_effect/organ_set_bonus/carp

/datum/infuser_entry/rat
	name = "老鼠"
	infuse_mob_name = "啮齿动物"
	desc = "脆弱、娇小，带着满腔‘芝’气面对世界。把自己塞满老鼠DNA很容易，但这或许不是最佳选择？"
	threshold_desc = "你的身体变得足够灵活，可以爬过通风管道。"
	qualities = list(
		"满嘴奶酪味的俏皮话",
		"什么都吃",
		"总想不停地吃东西",
		"脆弱但敏捷",
	)
	input_obj_or_mob = list(
		/obj/item/food/deadmouse,
	)
	output_organs = list(
		/obj/item/organ/eyes/night_vision/rat,
		/obj/item/organ/heart/rat,
		/obj/item/organ/stomach/rat,
		/obj/item/organ/tongue/rat,
	)
	infusion_desc = "胆小易惊"
	tier = DNA_MUTANT_TIER_ONE
	status_effect_type = /datum/status_effect/organ_set_bonus/rat

/datum/infuser_entry/roach
	name = "蟑螂"
	infuse_mob_name = "蟑螂"
	desc = "你对这个条目感兴趣，看来是古典文学的爱好者。放心，将蟑螂DNA融入你的基因组 \
		不会让你变得连床都下不了。人类难以承受的许多事物，对这些生物而言 \
		都不算什么，我们可以利用这一点！谁不想在核爆中生还呢？ \
		注意：显而易见，踩扁的蟑螂不能用于融合器。试试喷些植物培育室的杀虫剂吧！"
	threshold_desc = "你不再会被爆炸炸成碎块，并获得极强的病毒和辐射抗性。"
	qualities = list(
		"更能抵御来自背后的攻击",
		"更健康的器官",
		"很快摆脱恶心感",
		"能在核末日中生存",
		"跌倒后更难爬起来",
		"务必远离毒素",
		"随时乐意找点零食",
	)
	input_obj_or_mob = list(
		/mob/living/basic/cockroach,
	)
	output_organs = list(
		/obj/item/organ/heart/roach,
		/obj/item/organ/stomach/roach,
		/obj/item/organ/liver/roach,
		/obj/item/organ/appendix/roach,
	)
	infusion_desc = "有卡夫卡式的荒诞感" // Gregor Samsa !!
	tier = DNA_MUTANT_TIER_ONE
	status_effect_type = /datum/status_effect/organ_set_bonus/roach

/datum/infuser_entry/fish
	name = "鱼"
	infuse_mob_name = "鱼类"
	desc = "水生生物有多种形态。渔夫可以告诉你更多，不过这不是重点。 \
		这种融合有许多好处，但鱼类突变肺可能成为一个重大缺点； \
		其他器官则取决于用于融合的鱼的特征。"
	threshold_desc = "潮湿时，你会稍微更坚韧、免疫滑倒，爬行时也更滑溜、更快。 \
		喝水和淋浴会治疗你，身体也更难干燥，但干燥时你会更虚弱。 \
		最后，你能抵御高压，而且更擅长钓鱼。"
	qualities = list(
		"在水中更快",
		"抵抗食源性疾病",
		"喜欢吃生鱼",
		"扑腾着摇摆行走",
		"钓鱼更容易",
		"需要水，迫切需要！",
		"可能还有更多",
	)
	input_obj_or_mob = list(
		/obj/item/fish,
	)
	output_organs = list(
		/obj/item/organ/lungs/fish,
		/obj/item/organ/stomach/fish,
		/obj/item/organ/tail/fish,
	)
	infusion_desc = "像鱼"
	tier = DNA_MUTANT_TIER_ONE
	status_effect_type = /datum/status_effect/organ_set_bonus/fish

/datum/infuser_entry/fish/get_output_organs(mob/living/carbon/human/target, obj/item/fish/infused_from)
	if(!istype(infused_from))
		return ..()

	///Get a list of possible alternatives to the standard fish infusion. We prioritize special infusions over it.
	var/list/possible_alt_infusions = list()
	for(var/type in infused_from.fish_traits)
		var/datum/fish_trait/trait = GLOB.fish_traits[type]
		if(!trait.infusion_entry)
			continue
		var/datum/infuser_entry/entry = GLOB.infuser_entries[trait.infusion_entry]
		for(var/organ in entry.output_organs)
			if(!target.get_organ_by_type(organ))
				possible_alt_infusions |= entry
				break

	if(length(possible_alt_infusions))
		var/datum/infuser_entry/chosen = pick(possible_alt_infusions)
		return chosen.get_output_organs(target, infused_from)

	var/list/organs = ..()
	if(infused_from.required_fluid_type == AQUARIUM_FLUID_AIR || HAS_TRAIT(infused_from, TRAIT_FISH_AMPHIBIOUS))
		organs -= /obj/item/organ/lungs/fish
	return organs


/datum/infuser_entry/squid
	name = "产墨能力"
	infuse_mob_name = "产墨海洋生物"
	desc = "乌贼、鱿鱼和章鱼等海洋软体动物遇到威胁时会释放墨汁，作为逃跑的烟幕。 \
		这种融合会强化唾液腺，产生大量墨汁，之后可喷出使敌人失明。"
	threshold_desc = DNA_INFUSION_NO_THRESHOLD
	qualities = list(
		"喷出墨汁使敌人失明",
	)
	output_organs = list(
		/obj/item/organ/tongue/inky
	)
	tier = DNA_MUTANT_TIER_ONE

/datum/infuser_entry/ttx_healing
	name = "河豚毒素治疗"
	infuse_mob_name = "鲀形目鱼类"
	desc = "鲀形目鱼类（如河豚）以体内剧毒的河豚毒素（TTX）而闻名。 \
		提取它们的DNA，可以反过来利用这种毒素进行治疗，也能改善酒精代谢。"
	threshold_desc = DNA_INFUSION_NO_THRESHOLD
	qualities = list(
		"河豚毒素治疗",
		"海量饮酒",
	)
	output_organs = list(
		/obj/item/organ/liver/fish
	)
	tier = DNA_MUTANT_TIER_ONE
	unreachable_effect = TRUE
	status_effect_type = /datum/status_effect/organ_set_bonus/fish

/datum/infuser_entry/amphibious
	name = "两栖能力"
	infuse_mob_name = "半水生动物"
	desc = "有的动物呼吸空气，有的在水中呼吸，也有少数两者皆可，虽然至少在地球上，没有动物能在太空中呼吸。"
	threshold_desc = DNA_INFUSION_NO_THRESHOLD
	qualities = list(
		"潮湿时无需呼吸",
		"可以呼吸水蒸气",
	)
	input_obj_or_mob = list(
		/mob/living/basic/frog,
		/mob/living/basic/axolotl,
		/mob/living/basic/crab,
	)
	output_organs = list(
		/obj/item/organ/lungs/fish/amphibious,
	)
	infusion_desc = "适应半水生生活"
	tier = DNA_MUTANT_TIER_ONE
	unreachable_effect = TRUE
	status_effect_type = /datum/status_effect/organ_set_bonus/fish

/datum/infuser_entry/stoat
	name = "白鼬"
	infuse_mob_name = "白鼬"
	desc = "看着白鼬正面捕猎比自己大得多的动物，我们开始钦佩它无所畏惧的天性。 \
		在公司里往上爬，需要的正是这种胆量。"
	threshold_desc = "变得无所畏惧，能闪避更大对手的攻击"
	qualities = list(
		"长出吻部！",
		"长得很高",
		"感官更敏锐，器官更脆弱",
		"本能地渴望独处",
		"凶猛的撕咬，尤其擅长在擒抱时使用",
		"啮齿动物和蛋看起来非常美味……植物则毫无吸引力",
	)
	input_obj_or_mob = list(
		/mob/living/basic/stoat,
	)
	output_organs = list(
		/obj/item/organ/eyes/stoat,
		/obj/item/organ/ears/stoat,
		/obj/item/organ/fangs/stoat,
		/obj/item/organ/heart/stoat,
		/obj/item/organ/tongue/stoat,
		/obj/item/organ/snout/stoat,
	)
	infusion_desc = "像白鼬"
	tier = DNA_MUTANT_TIER_ONE
	status_effect_type = /datum/status_effect/organ_set_bonus/stoat

/datum/infuser_entry/stoat/get_output_organs(mob/living/carbon/human/target, atom/movable/infused_from)
	// eyes and ears are low priority, infuse them last
	var/datum/status_effect/organ_set_bonus/stoat/organ_tracker = target.has_status_effect(__IMPLIED_TYPE__)
	if(organ_tracker?.organs < 3)
		return list(
			/obj/item/organ/heart/stoat,
			/obj/item/organ/tongue/stoat,
			/obj/item/organ/snout/stoat,
		)

	return ..()
