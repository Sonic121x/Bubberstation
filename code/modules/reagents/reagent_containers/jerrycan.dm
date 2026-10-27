#define LABEL_TEXT "text"
#define LABEL_TEXT_OLD "old"
#define LABEL_INFLAMMABLE "inflammable"
#define LABEL_NT "nt"
#define LABEL_NT_MINI "nt_mini"
#define LABEL_SUSPICIOUS "sus"
#define LABEL_SUSPICIOUS_BLACK "sus_black"
#define LABEL_SUSPICIOUS_MINI "sus_mini"
#define LABEL_SUSPICIOUS_MINI_BLACK "sus_mini_black"
#define LABEL_EZ_NUTRIENT "ez"
#define LABEL_ROBUST_HARVEST "robust"
#define LABEL_LEFT_4_ZED "l4z"
#define LABEL_SPACE_CLEANER "space_cleaner"
#define LABEL_CONCRETE "concrete"
#define LABEL_HEXACRETE "hexacrete"

#define CAP_BLACK "black"
#define CAP_WHITE "white"
#define CAP_RED "red"
#define CAP_GREEN "green"
#define CAP_BLUE "blue"

/**
* The jerrycan is not only a flavourful, setting appropriate way to store reagents, it offers several design benefits due to its unique combination of high roundstart capacity and bulky size.

* It prevents one coworker from hogging a shared reagent container.

* The high volume eases grinding and mixing without enabling big grenade creation.

* It allows reagents to be stolen or borrowed due to being stored outside the safety of an inventory.

* The highly visible inhand sprite allows you to see who is holding or transporting reagents.

* The smart cap flag allows you to throw the container without spilling.

* It reduces the tedium associated with dispensing and throwing away botany nutrient bottles, encouraging refilling.

* Bulky size prevent players from looting the can unless it is something they really want.

* Comes with a large number of visual customization options for coders who with to add new variants.
**/
/obj/item/reagent_containers/cup/jerrycan
	name = "塑料油桶"
	desc = "由最优质的高密度聚乙烯制成的大容量容器。\n\n现在集成了 Smart Cap™ 智能盖技术，处理工业液体时可防止代价高昂的泼洒。"
	icon = 'icons/obj/medical/chemical.dmi'
	righthand_file = 'icons/mob/inhands/items/chemistry_righthand.dmi'
	lefthand_file = 'icons/mob/inhands/items/chemistry_lefthand.dmi'
	icon_state = "jerrycan"
	inhand_icon_state = "jerrycan"
	base_icon_state = "jerrycan"
	custom_materials = list(/datum/material/plastic=SHEET_MATERIAL_AMOUNT*2)
	w_class = WEIGHT_CLASS_BULKY
	volume = 200
	obj_flags = UNIQUE_RENAME
	initial_reagent_flags = OPENCONTAINER | NO_SPLASH
	fill_icon_thresholds = list(0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200)
	possible_transfer_amounts = list(5, 10, 15, 30, 50, 100, 200)
	adjust_color_contrast = TRUE
	/**
	* If we want the can to have a label. Use the defines at the top, add new ones if you add new labels.

	* WARNING: How good any particular label looks is highly dependent on the colour of the reagent in the can.

	* Exercise good judgement and choose a label with enough contrast for the intended contents.
	**/
	var/label_type
	///Different cap colours.
	var/cap_type
	///You can use this var to tone down the strength of the highlight for less shiny types of plastic.
	var/highlight_strenght = 1.0

/obj/item/reagent_containers/cup/jerrycan/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item)
	update_appearance()

/obj/item/reagent_containers/cup/jerrycan/update_overlays()
	. = ..()

	var/mutable_appearance/highlight = mutable_appearance(icon, "[base_icon_state]_highlight")
	highlight.opacity = highlight.opacity * highlight_strenght
	. += highlight

	if(label_type)
		. += mutable_appearance(icon, "[base_icon_state]_label_[label_type]")

	if(cap_type)
		. += mutable_appearance(icon, "[base_icon_state]_cap_[cap_type]")

/obj/item/reagent_containers/cup/jerrycan/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		return
	if(fill_icon_thresholds && reagents.total_volume)
		var/mutable_appearance/inhand_reagent_filling = mutable_appearance(icon_file, "[inhand_icon_state]_reagent_filling")
		inhand_reagent_filling.color = mix_color_from_reagents(reagents.reagent_list)
		. += inhand_reagent_filling
	if(cap_type)
		. += mutable_appearance(icon_file, "[base_icon_state]_cap_[cap_type]")

/obj/item/reagent_containers/cup/jerrycan/opaque
	fill_icon_thresholds = null
	initial_reagent_flags = parent_type::initial_reagent_flags & ~TRANSPARENT
	highlight_strenght = 0.75

/obj/item/reagent_containers/cup/jerrycan/opaque/yellow
	icon_state = "jerrycan_yellow"
	inhand_icon_state = "jerrycan_yellow"

/obj/item/reagent_containers/cup/jerrycan/eznutriment
	name = "易滋营养剂™ 大桶"
	desc = "一个大容器，按理说装满了“易滋营养剂”牌植物营养剂。没有比这更省事的了。"
	label_type = LABEL_EZ_NUTRIENT
	list_reagents = list(/datum/reagent/plantnutriment/eznutriment = 200)
	custom_price = PAYCHECK_CREW * 1

/obj/item/reagent_containers/cup/jerrycan/left4zed
	name = "求生之路 4™ 大桶"
	desc = "一个大容器，标着“求生之路 4”植物营养剂。买不到更强效的东西时，这是个不错的选择。"
	label_type = LABEL_LEFT_4_ZED
	cap_type = CAP_GREEN
	list_reagents = list(/datum/reagent/plantnutriment/left4zednutriment = 200)
	custom_price = PAYCHECK_CREW * 1.2

/obj/item/reagent_containers/cup/jerrycan/robustharvest
	name = "强劲丰收™ 大桶"
	desc = "一个大容器，标着“强劲丰收”植物营养剂。想要强劲的收成，就只信赖“强劲丰收”。"
	label_type = LABEL_ROBUST_HARVEST
	list_reagents = list(/datum/reagent/plantnutriment/robustharvestnutriment = 200)
	custom_price = PAYCHECK_CREW * 1.5

/obj/item/reagent_containers/cup/jerrycan/ammonia
	name = "NT-AG 氨水桶"
	desc = "一个大容器，标着“NT-AG”无水氨。警告标签上写着：请与含氯清洁产品分开存放！"
	label_type = LABEL_TEXT
	cap_type = CAP_BLUE
	list_reagents = list(/datum/reagent/ammonia = 200)

/obj/item/reagent_containers/cup/jerrycan/diethylamine
	name = "NT-AG 二乙胺桶"
	label_type = LABEL_TEXT_OLD
	cap_type = CAP_GREEN
	desc = "一个大容器，标着“NT-AG”二乙胺。一行粗体免责声明写着：仅限农业用途。禁止转售。"
	list_reagents = list(/datum/reagent/diethylamine = 200)

/obj/item/reagent_containers/cup/jerrycan/sus
	name = "咚克公司超值燃素桶"
	label_type = LABEL_SUSPICIOUS_BLACK
	desc = "一大桶燃素，名义上是用来清除生产线上干结的咚克口袋饼™ 馅料的。"
	list_reagents = list(/datum/reagent/phlogiston = 200)

/obj/item/reagent_containers/cup/jerrycan/oil
	name = "机油桶"
	label_type = LABEL_INFLAMMABLE
	cap_type = CAP_RED
	desc = "一大桶合成润滑油。"
	list_reagents = list(/datum/reagent/fuel/oil = 200)

/obj/item/reagent_containers/cup/jerrycan/space_cleaner
	name = "BLAM!™ 牌无泡太空清洁剂桶"
	label_type = LABEL_SPACE_CLEANER
	cap_type = CAP_RED
	desc = "顽固污渍、油垢和积灰把你逼到墙角了？有 BLAM!™ 在手，你无需退缩！\nBLAM!™——华夫公司出品。"
	list_reagents = list(/datum/reagent/space_cleaner = 200)

/obj/item/reagent_containers/cup/jerrycan/milk
	name = "牛奶壶"
	label_type = LABEL_NT_MINI
	cap_type = CAP_BLUE
	desc = "一壶最纯正的牛奶。"
	list_reagents = list(/datum/reagent/consumable/milk = 200)

/obj/item/reagent_containers/cup/jerrycan/concrete_mix
	name = "混凝土混合料桶"
	label_type = LABEL_CONCRETE
	cap_type = CAP_BLACK
	desc = "一大桶即用型混凝土混合料。只需加水。"
	list_reagents = list(/datum/reagent/concrete_mix = 200)

/obj/item/reagent_containers/cup/jerrycan/hexacrete
	name = "六角混凝土桶"
	label_type = LABEL_HEXACRETE
	cap_type = CAP_RED
	desc = "一大桶六角混凝土。"
	list_reagents = list(/datum/reagent/concrete/hexacrete = 200)

#undef LABEL_TEXT
#undef LABEL_TEXT_OLD
#undef LABEL_INFLAMMABLE
#undef LABEL_NT
#undef LABEL_NT_MINI
#undef LABEL_SUSPICIOUS
#undef LABEL_SUSPICIOUS_BLACK
#undef LABEL_SUSPICIOUS_MINI
#undef LABEL_SUSPICIOUS_MINI_BLACK
#undef LABEL_EZ_NUTRIENT
#undef LABEL_ROBUST_HARVEST
#undef LABEL_LEFT_4_ZED
#undef LABEL_SPACE_CLEANER
#undef LABEL_CONCRETE
#undef LABEL_HEXACRETE
#undef CAP_BLACK
#undef CAP_WHITE
#undef CAP_RED
#undef CAP_GREEN
#undef CAP_BLUE
