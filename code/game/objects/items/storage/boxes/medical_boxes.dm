// This file contains all boxes used by the Medical department, or otherwise associated with the task of mob interactions.

/obj/item/storage/box/syringes
	name = "注射器盒"
	desc = "装满注射器的盒子。"
	illustration = "syringe"

/obj/item/storage/box/syringes/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/syringe(src)

/obj/item/storage/box/syringes/variety
	name = "混合注射器盒"

/obj/item/storage/box/syringes/variety/PopulateContents()
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/reagent_containers/syringe/lethal(src)
	new /obj/item/reagent_containers/syringe/piercing(src)
	new /obj/item/reagent_containers/syringe/bluespace(src)

/obj/item/storage/box/medipens
	name = "自动注射笔盒"
	desc = "装满肾上腺素自动注射笔的盒子。"
	illustration = "epipen"

/obj/item/storage/box/medipens/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/hypospray/medipen(src)

/obj/item/storage/box/medipens/utility
	name = "兴奋剂实惠套装"
	desc = "装有数支兴奋剂自动注射笔的盒子，适合精打细算的矿工。"
	illustration = "epipen"

/obj/item/storage/box/medipens/utility/PopulateContents()
	..() // includes regular medipens.
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/hypospray/medipen/stimpack(src)

/obj/item/storage/box/beakers
	name = "烧杯盒"
	illustration = "beaker"

/obj/item/storage/box/beakers/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/cup/beaker( src )

/obj/item/storage/box/beakers/big
	name = "大烧杯盒"
	illustration = "beaker"

/obj/item/storage/box/beakers/big/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/cup/beaker/large(src)

/obj/item/storage/box/beakers/bluespace
	name = "蓝空间烧杯盒"
	illustration = "beaker"

/obj/item/storage/box/beakers/bluespace/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/cup/beaker/bluespace(src)

/obj/item/storage/box/beakers/variety
	name = "混合烧杯盒"

/obj/item/storage/box/beakers/variety/PopulateContents()
	new /obj/item/reagent_containers/cup/beaker(src)
	new /obj/item/reagent_containers/cup/beaker/bluespace(src)
	new /obj/item/reagent_containers/cup/beaker/large(src)
	new /obj/item/reagent_containers/cup/beaker/meta(src)
	new /obj/item/reagent_containers/cup/beaker/noreact(src)
	new /obj/item/reagent_containers/cup/beaker/plastic(src)

/obj/item/storage/box/medigels
	name = "医疗凝胶盒"
	desc = "装满医疗凝胶涂抹器的盒子，配有可拧开的盖子和精密喷雾头。"
	illustration = "medgel"

/obj/item/storage/box/medigels/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/medigel( src )

/obj/item/storage/box/injectors
	name = "DNA 注射器盒"
	desc = "这个盒子里似乎装着注射器。"
	illustration = "dna"

/obj/item/storage/box/injectors/PopulateContents()
	var/list/items_inside = list(
		/obj/item/dnainjector/h2m = 3,
		/obj/item/dnainjector/m2h = 3,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/bodybags
	name = "尸袋"
	desc = "标签表明里面装着尸袋。"
	illustration = "bodybags"

/obj/item/storage/box/bodybags/PopulateContents()
	..()
	for(var/i in 1 to 7)
		new /obj/item/bodybag(src)

/obj/item/storage/box/pillbottles
	name = "药瓶盒"
	desc = "正面印着药瓶的图案。"
	illustration = "pillbox"

/obj/item/storage/box/pillbottles/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/storage/pill_bottle(src)

/obj/item/storage/box/plumbing/PopulateContents()
	var/list/items_inside = list(
		/obj/item/stock_parts/water_recycler = 2,
		/obj/item/stack/ducts/fifty = 1,
		/obj/item/stack/sheet/iron/ten = 1,
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/box/evilmeds
	name = "高级药品盒"
	desc = "内含大量装满高级医疗用品的烧杯，直接来自英特戴恩制药公司！"
	icon_state = "syndiebox"
	illustration = "beaker"

/obj/item/storage/box/evilmeds/PopulateContents()
	var/list/items_inside = list(
		/obj/item/reagent_containers/cup/beaker/meta/omnizine = 1,
		/obj/item/reagent_containers/cup/beaker/meta/sal_acid = 1,
		/obj/item/reagent_containers/cup/beaker/meta/oxandrolone = 1,
		/obj/item/reagent_containers/cup/beaker/meta/pen_acid = 1,
		/obj/item/reagent_containers/cup/beaker/meta/atropine = 1,
		/obj/item/reagent_containers/cup/beaker/meta/salbutamol = 1,
		/obj/item/reagent_containers/cup/beaker/meta/rezadone = 1,
	)
	generate_items_inside(items_inside, src)

/obj/item/storage/box/bandages
	name = "绷带盒"
	desc = "一盒德福雷斯特品牌的凝胶绷带，用于治疗钝器伤。"
	icon = 'icons/obj/storage/box.dmi' // SKYRAT EDIT CHANGE
	icon_state = "brutebox"
	base_icon_state = "brutebox"
	inhand_icon_state = "brutebox"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	drop_sound = 'sound/items/handling/matchbox_drop.ogg'
	pickup_sound = 'sound/items/handling/matchbox_pickup.ogg'
	illustration = null
	w_class = WEIGHT_CLASS_SMALL
	custom_price = PAYCHECK_CREW * 1.75
	storage_type = /datum/storage/box/bandages

/obj/item/storage/box/bandages/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/stack/medical/bandage(src)

/obj/item/storage/box/bandages/update_icon_state()
	. = ..()
	switch(length(contents))
		if(5)
			icon_state = "[base_icon_state]_f"
		if(3 to 4)
			icon_state = "[base_icon_state]_almostfull"
		if(1 to 2)
			icon_state = "[base_icon_state]_almostempty"
		if(0)
			icon_state = base_icon_state

// The actual box
/obj/item/storage/box/triage_cards
	name = "分诊卡盒"
	desc = "装满分诊卡的盒子，用于快速评估患者的伤情严重程度。"
	custom_price = PAYCHECK_CREW

/obj/item/storage/box/triage_cards/PopulateContents()
	new /obj/item/paper_bin/triage/minor(src)
	new /obj/item/paper_bin/triage/major(src)
	new /obj/item/paper_bin/triage/critical(src)
	new /obj/item/paper_bin/triage/dead(src)
	new /obj/item/pen(src)

// The triage cards themselves
#define SEVERITY_MINIMAL "轻微"
#define SEVERITY_DELAYED "延迟"
#define SEVERITY_IMMEDIATE "立即"
#define SEVERITY_DEAD "期待 / 已死亡"

/obj/item/paper/triage
	name = "分诊卡"
	desc = "一张可一眼判断患者伤情严重程度的卡片。"
	default_raw_text = "彻底完了" // filler text
	var/severity = "none"

/obj/item/paper/triage/Initialize(mapload)
	name = "「[severity]」[name]"
	default_raw_text = {"
		<center>
			<h2>标签 - 分诊</h2>
		</center>
		<b>姓名：</b><br>
		\[______________________________\]<br>
		<center>
			<h3>- [uppertext(severity)] -<h3>
			<h4>[severity_to_subtitle()]</h4>
		</center>
		<b>伤情：</b><br>
		\[________________________________________\]<br>
		\[________________________________________\]<br>
		\[________________________________________\]<br>
		\[________________________________________\]<br>
		\[________________________________________\]<br>
	"}
	return ..()

/obj/item/paper/triage/proc/severity_to_subtitle()
	switch(severity)
		if(SEVERITY_DEAD)
			return "无呼吸"
		if(SEVERITY_IMMEDIATE)
			return "危及生命"
		if(SEVERITY_DELAYED)
			return "重伤——不危及生命"
		if(SEVERITY_MINIMAL)
			return "轻伤——可行走伤员"
	return "未知"

/obj/item/paper/triage/examine(mob/user)
	. = ..()
	switch(severity)
		if(SEVERITY_DEAD)
			. += span_notice("这张卡表示患者已经死亡，或预计无法存活。")
		if(SEVERITY_IMMEDIATE)
			. += span_notice("这张卡表示患者情况危急，需要立即处理。")
		if(SEVERITY_DELAYED)
			. += span_notice("这张卡表示患者伤势严重，但没有直接危险。")
		if(SEVERITY_MINIMAL)
			. += span_notice("这张卡表示患者只受了轻伤。")

	. += span_smallnoticeital("如果你<i>仔细查看</i>，可以看到卡片背面印有分诊指南。")

/obj/item/paper/triage/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>[src]的背面印有分诊操作指南：</i>")
	. += "&bull; “伤者能否行走，并回应简单指令？”若是，标记为<b>轻微</b>。"
	. += "&bull; “伤者是否已完全停止呼吸（甚至连喘息都没有）？”若是，标记为<b>期待 / 已死亡</b>。"
	. += "&bull; “伤者是否出血、无法遵从简单指令、没有脉搏、呼吸困难？”若是，标记为<b>立即</b>。"
	. += "&bull; 否则，标记为<b>延迟</b>。"

/obj/item/paper/triage/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE

	var/px = text2num(LAZYACCESS(modifiers, ICON_X))
	var/py = text2num(LAZYACCESS(modifiers, ICON_Y))

	if(isnull(px) || isnull(py))
		return NONE

	user.do_attack_animation(interacting_with, used_item = src)
	interacting_with.balloon_alert(user, "卡片已贴上")
	interacting_with.AddComponent(/datum/component/sticker, src, get_dir(interacting_with, src), px, py)
	return ITEM_INTERACT_SUCCESS

/obj/item/paper/triage/minor
	color = COLOR_ASSEMBLY_GREEN
	severity = SEVERITY_MINIMAL

/obj/item/paper/triage/major
	color = COLOR_ASSEMBLY_YELLOW
	severity = SEVERITY_DELAYED

/obj/item/paper/triage/critical
	color = COLOR_ASSEMBLY_RED
	severity = SEVERITY_IMMEDIATE

/obj/item/paper/triage/dead
	color = COLOR_ASSEMBLY_BLACK
	severity = SEVERITY_DEAD

// Paper bin to store a lot of triage cards. Goes away when empty.
/obj/item/paper_bin/triage
	name = "分诊卡叠"
	desc = "一叠分诊卡，用于快速评估患者的伤情严重程度。"
	icon_state = ""
	bin_overlay_string = ""
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	inhand_icon_state = "paper"
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	drop_sound = 'sound/items/handling/paper_drop.ogg'
	pickup_sound = 'sound/items/handling/paper_pickup.ogg'
	total_paper = 20

/obj/item/paper_bin/triage/fire_act(exposed_temperature, exposed_volume)
	total_paper -= round(exposed_volume / 25, 1)
	if(total_paper <= 0)
		qdel(src)
	else
		update_appearance()

/obj/item/paper_bin/triage/dump_contents(atom/droppoint, collapse = FALSE)
	. = ..()
	if(total_paper <= 0)
		qdel(src)

/obj/item/paper_bin/triage/remove_paper(amount)
	. = ..()
	if(total_paper <= 0)
		qdel(src)

/obj/item/paper_bin/triage/Exited(atom/movable/gone, direction)
	. = ..()
	if(total_paper <= 0 && !QDELING(src))
		qdel(src)

/obj/item/paper_bin/triage/minor
	papertype = /obj/item/paper/triage/minor

/obj/item/paper_bin/triage/major
	papertype = /obj/item/paper/triage/major

/obj/item/paper_bin/triage/critical
	papertype = /obj/item/paper/triage/critical

/obj/item/paper_bin/triage/dead
	papertype = /obj/item/paper/triage/dead

#undef SEVERITY_MINIMAL
#undef SEVERITY_DELAYED
#undef SEVERITY_IMMEDIATE
#undef SEVERITY_DEAD
