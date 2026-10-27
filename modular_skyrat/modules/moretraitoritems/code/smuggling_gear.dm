///syndicate prototype for smuggling missions
/obj/item/gun/syringe/syndicate/prototype
	name = "原型飞镖手枪"
	desc = "赛博太阳工业的原型飞镖手枪。用更小的武器以同样的\
	速度发射注射器，事实证明是项出奇复杂的任务。"
	syringes = list()

///syndicate prototype for smuggling missions
/obj/item/pen/edagger/prototype
	name = "古怪的笔"
	desc = "一支不寻常的黑色墨水笔，上面伸出奇怪的金属块……"
	hidden_name = "原型硬光匕首"
	hidden_desc = "华夫公司研发部门的能量匕首原型。硬光或许不及\
	能量武器，但仍有惊人的杀伤力。"
	hidden_icon = "eprototypedagger"

//smuggling container
/obj/item/reagent_containers/cup/bottle/ritual_wine
	name = "仪式酒瓶"
	desc = "内装效力极强的混合物，由多种致幻剂、草药提取物和烈性毒品调制。\
	猛虎合作社将其赞颂为通往至高力量的纽带，但无论如何，\
	这东西都不该喝下去。"
	volume = 50
	list_reagents = list(
		//changeling adrenals part
		/datum/reagent/drug/methamphetamine = 5,
		//hallucinations part
		/datum/reagent/drug/mushroomhallucinogen = 35,
		//alcoholic part, plus more hallucinations lel
		/datum/reagent/consumable/ethanol/ritual_wine = 10,
	)
