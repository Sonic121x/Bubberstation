/obj/machinery/biogenerator/food_replicator
	name = "\improper 34 型“殖民地补给核心”"
	desc = "34 型“殖民地补给核心”，俗称“基因箱/CSC”，是一种古老而方正的机型，最早由先驱殖民者\
		投入使用，他们便是如今所称的 NRI 的前身。基因箱的核心是一台物质重排序器，即生物发生器的一个高度专用亚型，可利用有机化合物\
		——通常来自大规模作物或废弃物——完成某种转化。只要供给充足，这台机器就能制造出各式各样的物资，\
	从衣物、食物到急救医疗用品。"
	icon = 'modular_skyrat/modules/food_replicator/icons/biogenerator.dmi'
	circuit = /obj/item/circuitboard/machine/biogenerator/food_replicator
	efficiency = 0.75
	productivity = 0.75
	show_categories = list(
		RND_CATEGORY_NRI_FOOD,
		RND_CATEGORY_NRI_MEDICAL,
		RND_CATEGORY_NRI_CLOTHING,
	)

/obj/item/circuitboard/machine/biogenerator/food_replicator
	name = "殖民地补给核心"
	build_path = /obj/machinery/biogenerator/food_replicator
