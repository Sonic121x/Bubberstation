
/obj/item/book/granter/crafting_recipe/fletching
	name = "削木问箭：现代太空人制箭指南"
	desc = "介绍如何制作与维护木弓、给箭装羽，以及……制作小提琴的实用指南？"
	crafting_recipe_types = list(
		/datum/crafting_recipe/arrow,
		/datum/crafting_recipe/blunted_arrow,// BUBBER EDIT ADDITION - Nonlethal arrows
		/datum/crafting_recipe/taser_arrow,// BUBBER EDIT ADDITION - Nonlethal arrows
		/datum/crafting_recipe/plastic_arrow,
		/datum/crafting_recipe/shortbow,
		/datum/crafting_recipe/holy_arrow,
		// /datum/crafting_recipe/arrow_quiver, // SKYRAT EDIT REMOVAL: public-knowledge quiver
		/datum/crafting_recipe/violin,
	)
	icon_state = "book4"
	uses = INFINITY
	remarks = list(
		"好吧，木材质量确实有些影响。",
		"小提琴那一章肯定是放进来开玩笑的吧……",
		"作者似乎莫名地为自己在‘这一带’打猎多年的经历感到骄傲……",
		"真希望作者别再说那些婚姻双关了……",
		"我需要会员资格？哪里的会员？",
		"好了，我想我已经明白要点了……",
	)
