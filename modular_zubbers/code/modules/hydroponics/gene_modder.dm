/obj/machinery/plantgenes
	name = "植物 DNA 操纵仪"
	desc = "一台用于操纵植物遗传构成的先进装置。"
	icon =  'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "dnamod"
	base_icon_state = "dnamod"
	var/working_state = "dnamod"
	var/nopower_state = "dnamod-off"
	density = TRUE
	circuit = /obj/item/circuitboard/machine/plantgenes
	pass_flags = PASSTABLE

	var/obj/item/seeds/seed
	var/obj/item/disk/computer/plantgene/disk

	var/list/core_genes = list()
	var/list/reagent_genes = list()
	var/list/trait_genes = list()

	var/datum/plant_gene/target
	var/operation = ""
	var/max_potency = 50 // See RefreshParts() for how these work
	var/max_yield = 2
	var/min_production = 12
	var/max_endurance = 10 // IMPT: ALSO AFFECTS LIFESPAN
	var/min_wchance = 67
	var/min_wrate = 10

/datum/plant_gene/reagent
	mutability_flags = PLANT_GENE_GRAFTABLE | PLANT_GENE_REMOVABLE

/obj/machinery/plantgenes/RefreshParts() // Comments represent the max you can set per tier, respectively. seeds.dm [219] clamps these for us but we don't want to mislead the viewer.
	. = ..()
	for(var/datum/stock_part/servo/M in component_parts)
		if(M.tier > 3)
			max_potency = 95
		else
			max_potency = initial(max_potency) + (M.tier**3) // 53,59,77,95 	 Clamps at 100

		max_yield = initial(max_yield) + (M.tier*2) // 4,6,8,10 	Clamps at 10

	for(var/datum/stock_part/scanning_module/SM in component_parts)
		if(SM.tier > 3) //If you create t5 parts I'm a step ahead mwahahaha!
			min_production = 1
		else
			min_production = 12 - (SM.tier * 3) //9,6,3,1. Requires if to avoid going below clamp [1]

		max_endurance = initial(max_endurance) + (SM.tier * 25) // 35,60,85,100	Clamps at 10min 100max

	for(var/datum/stock_part/micro_laser/ML in component_parts)
		var/wratemod = ML.tier * 2.5
		min_wrate = FLOOR(10-wratemod,1) // 7,5,2,0	Clamps at 0 and 10	You want this low
		min_wchance = 67-(ML.tier*16) // 48,35,19,3 	Clamps at 0 and 67	You want this low

	/* lets not add the snowflake editor for plant people rn
	for(var/obj/item/circuitboard/machine/plantgenes/vaultcheck in component_parts)
		if(istype(vaultcheck, /obj/item/circuitboard/machine/plantgenes/vault)) // TRAIT_DUMB BOTANY TUTS
			max_potency = 100
			max_yield = 10
			min_production = 1
			max_endurance = 100
			min_wchance = 0
			min_wrate = 0
	*/

/obj/machinery/plantgenes/update_icon_state()
	icon_state = "[(nopower_state && !powered()) ? nopower_state : base_icon_state]"
	return ..()

/obj/machinery/plantgenes/update_overlays()
	. = ..()
	if(seed)
		. += "dnamod-dna"
	if(panel_open)
		. += "dnamod-open"

/obj/machinery/plantgenes/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/plantgenes/attackby(obj/item/I, mob/user, params)
	if(default_unfasten_wrench(user, I))
		return
	if(default_deconstruction_crowbar(I))
		return
	if(iscyborg(user))
		return

	if(istype(I, /obj/item/seeds))
		if (operation)
			to_chat(user, "<span class='notice'>请先完成当前操作。</span>")
			return
		if(!user.transferItemToLoc(I, src))
			return
		eject_seed()
		insert_seed(I)
		to_chat(user, "<span class='notice'>你将 [I] 放入机器中。</span>")
		interact(user)
	else if(istype(I, /obj/item/disk/computer/plantgene))
		if (operation)
			to_chat(user, "<span class='notice'>请先完成当前操作。</span>")
			return
		if(!user.transferItemToLoc(I, src))
			return
		eject_disk()
		disk = I
		to_chat(user, "<span class='notice'>你将 [I] 放入机器中。</span>")
		interact(user)
	else
		..()

//? Eventually refactor this into TGUI?
/obj/machinery/plantgenes/ui_interact(mob/user)
	. = ..()
	if(!user)
		return

	var/datum/browser/popup = new(user, "plantdna", "植物 DNA 操纵仪", 450, 600)
	if(!(in_range(src, user) || issilicon(user)))
		popup.close()
		return

	var/dat = ""

	if(operation)
		if(!seed || (!target && operation != "insert"))
			operation = ""
			target = null
			interact(user)
			return
		if((operation == "replace" || operation == "insert") && (!disk || !disk.gene))
			operation = ""
			target = null
			interact(user)
			return

		dat += "<div class='line'><h3>确认操作</h3></div>"
		dat += "<div class='statusDisplay'>你确定要执行以下操作吗？<br>"
		switch(operation)
			if("remove")
				dat += "从 \the <span class='highlight'>[seed]</span> 上移除基因 <span class='highlight'>[target.get_name()]</span>？<br>"
			if("extract")
				dat += "从 \the <span class='highlight'>[seed]</span> 上提取基因 <span class='highlight'>[target.get_name()]</span>？<br>"
				dat += "<span class='bad'>样本将在处理过程中被销毁！</span>"
				if(istype(target, /datum/plant_gene/core))
					var/datum/plant_gene/core/gene = target
					if(istype(target, /datum/plant_gene/core/potency))
						if(gene.value > max_potency)
							dat += "<br><br>本装置的提取能力目前仅限 <span class='highlight'>[max_potency]</span> 点效力。 "
							dat += "提取时目标基因将降级为 <span class='highlight'>[max_potency]</span> 点效力。"
					else if(istype(target, /datum/plant_gene/core/lifespan))
						if(gene.value > max_endurance)
							dat += "<br><br>本装置的提取能力目前仅限 <span class='highlight'>[max_endurance]</span> 点寿命。 "
							dat += "提取时目标基因将降级为 <span class='highlight'>[max_endurance]</span> 点寿命。"
					else if(istype(target, /datum/plant_gene/core/endurance))
						if(gene.value > max_endurance)
							dat += "<br><br>本装置的提取能力目前仅限 <span class='highlight'>[max_endurance]</span> 点耐久。 "
							dat += "提取时目标基因将降级为 <span class='highlight'>[max_endurance]</span> 点耐久。"
					else if(istype(target, /datum/plant_gene/core/yield))
						if(gene.value > max_yield)
							dat += "<br><br>本装置的提取能力目前仅限 <span class='highlight'>[max_yield]</span> 点产量。 "
							dat += "提取时目标基因将降级为 <span class='highlight'>[max_yield]</span> 点产量。"
					else if(istype(target, /datum/plant_gene/core/production))
						if(gene.value < min_production)
							dat += "<br><br>本装置的提取能力目前仅限 <span class='highlight'>[min_production]</span> 点生产时间。 "
							dat += "提取时目标基因将降级为 <span class='highlight'>[min_production]</span> 点生产时间。"
					else if(istype(target, /datum/plant_gene/core/weed_rate))
						if(gene.value < min_wrate)
							dat += "<br><br>本装置的提取能力目前仅限 <span class='highlight'>[min_wrate]</span> 点杂草生长率。 "
							dat += "提取时目标基因将降级为 <span class='highlight'>[min_wrate]</span> 点杂草生长率。"
					else if(istype(target, /datum/plant_gene/core/weed_chance))
						if(gene.value < min_wchance)
							dat += "<br><br>本装置的提取能力目前仅限 <span class='highlight'>[min_wchance]</span> 点杂草易感度。 "
							dat += "提取时目标基因将降级为 <span class='highlight'>[min_wchance]</span> 点杂草易感度。"

			if("replace")
				dat += "将 <span class='highlight'>[target.get_name()]</span> 基因替换为 <span class='highlight'>[disk.gene.get_name()]</span>？<br>"
			if("insert")
				dat += "将 <span class='highlight'>[disk.gene.get_name()]</span> 基因插入 \the <span class='highlight'>[seed]</span>？<br>"
		dat += "</div><div class='line'><a href='byond://?src=[REF(src)];gene=[REF(target)];op=[operation]'>确认</a> "
		dat += "<a href='byond://?src=[REF(src)];abort=1'>取消</a></div>"
		popup.set_content(dat)
		popup.open()
		return

	dat+= "<div class='statusDisplay'>"

	dat += "<div class='line'><div class='statusLabel'>植物样本：</div><div class='statusValue'><a href='byond://?src=[REF(src)];eject_seed=1'>"
	dat += seed ? seed.name : "无"
	dat += "</a></div></div>"

	dat += "<div class='line'><div class='statusLabel'>数据磁盘：</div><div class='statusValue'><a href='byond://?src=[REF(src)];eject_disk=1'>"
	if(!disk)
		dat += "无"
	else if(!disk.gene)
		dat += "空白磁盘"
	else
		dat += disk.gene.get_name()
	if(disk && disk.read_only)
		dat += "（只读）"
	dat += "</a></div></div>"

	dat += "<br></div>"

	if(seed)
		var/can_insert = disk && disk.gene && disk.gene.can_add(seed)
		var/can_extract = disk && !disk.read_only

		dat += "<div class='line'><h3>核心基因</h3></div><div class='statusDisplay'><table>"
		for(var/a in core_genes)
			var/datum/plant_gene/G = a
			if(!G)
				continue
			dat += "<tr><td width='260px'>[G.get_name()]</td><td>"
			if(can_extract && G.mutability_flags & PLANT_GENE_GRAFTABLE)
				dat += "<a href='byond://?src=[REF(src)];gene=[REF(G)];op=extract'>提取</a>"
			if(can_insert && istype(disk.gene, G.type) && G.mutability_flags & PLANT_GENE_REMOVABLE)
				dat += "<a href='byond://?src=[REF(src)];gene=[REF(G)];op=replace'>替换</a>"
			dat += "</td></tr>"
		dat += "</table></div>"

		if(seed.yield != -1)
			dat += "<div class='line'><h3>内容基因</h3></div><div class='statusDisplay'>"
			if(reagent_genes.len)
				dat += "<table>"
				for(var/a in reagent_genes)
					var/datum/plant_gene/G = a
					dat += "<tr><td width='260px'>[G.get_name()]</td><td>"
					if(can_extract && G.mutability_flags & PLANT_GENE_GRAFTABLE)
						dat += "<a href='byond://?src=[REF(src)];gene=[REF(G)];op=extract'>提取</a>"
					if(G.mutability_flags & PLANT_GENE_REMOVABLE)
						dat += "<a href='byond://?src=[REF(src)];gene=[REF(G)];op=remove'>移除</a>"
					dat += "</td></tr>"
				dat += "</table>"
			else
				dat += "样本中未检测到与内容相关的基因。<br>"
			dat += "</div>"
			if(can_insert && istype(disk.gene, /datum/plant_gene/reagent))
				dat += "<a href='byond://?src=[REF(src)];op=insert'>插入：[disk.gene.get_name()]</a>"

			dat += "<div class='line'><h3>性状基因</h3></div><div class='statusDisplay'>"
			if(trait_genes.len)
				dat += "<table>"
				for(var/a in trait_genes)
					var/datum/plant_gene/G = a
					dat += "<tr><td width='260px'>[G.get_name()]</td><td>"
					if(can_extract && G.mutability_flags & PLANT_GENE_GRAFTABLE)
						dat += "<a href='byond://?src=[REF(src)];gene=[REF(G)];op=extract'>提取</a>"
					if(G.mutability_flags & PLANT_GENE_REMOVABLE)
						dat += "<a href='byond://?src=[REF(src)];gene=[REF(G)];op=remove'>移除</a>"
					dat += "</td></tr>"
				dat += "</table>"
			else
				dat += "样本中未检测到与性状相关的基因。<br>"
			if(can_insert && istype(disk.gene, /datum/plant_gene/trait))
				dat += "<a href='byond://?src=[REF(src)];op=insert'>插入：[disk.gene.get_name()]</a>"
			dat += "</div>"
	else
		dat += "<br>未找到样本。<br><span class='highlight'>请插入植物样本以使用本装置。</span>"
	popup.set_content(dat)
	popup.open()


/obj/machinery/plantgenes/Topic(href, list/href_list)
	if(..())
		return
//	usr.set_machine(src)

	if(href_list["eject_seed"] && !operation)
		var/obj/item/I = usr.get_active_held_item()
		if(istype(I, /obj/item/seeds))
			if(!usr.transferItemToLoc(I, src))
				return
			eject_seed()
			insert_seed(I)
			to_chat(usr, "<span class='notice'>你将 [I] 放入机器中。</span>")
		else
			eject_seed()
	else if(href_list["eject_disk"] && !operation)
		var/obj/item/I = usr.get_active_held_item()
		if(istype(I, /obj/item/disk/computer/plantgene))
			if(!usr.transferItemToLoc(I, src))
				return
			eject_disk()
			disk = I
			to_chat(usr, "<span class='notice'>你将 [I] 放入机器中。</span>")
		else
			eject_disk()
	else if(href_list["op"] == "insert" && disk && disk.gene && seed)
		if(!operation) // Wait for confirmation
			operation = "insert"
		else
			if(!istype(disk.gene, /datum/plant_gene/core) && disk.gene.can_add(seed))
				seed.genes += disk.gene.Copy()
				if(istype(disk.gene, /datum/plant_gene/reagent))
					seed.reagents_from_genes()
			update_genes()
			repaint_seed()
			operation = ""
			target = null

	else if(href_list["gene"] && seed)
		var/datum/plant_gene/G = seed.get_gene(href_list["gene"])
		if(!G || !href_list["op"] || !(href_list["op"] in list("remove", "extract", "replace")))
			interact(usr)
			return

		if(!operation || target != G) // Wait for confirmation
			target = G
			operation = href_list["op"]

		else if(operation == href_list["op"] && target == G)
			switch(href_list["op"])
				if("remove")
					if(!istype(G, /datum/plant_gene/core))
						seed.genes -= G
						if(istype(G, /datum/plant_gene/reagent))
							seed.reagents_from_genes()
					repaint_seed()
				if("extract")
					if(disk && !disk.read_only)
						seed.genes -= G
						var/datum/plant_gene/core/gene = G
						if(istype(G, /datum/plant_gene/core))
							if(istype(G, /datum/plant_gene/core/potency))
								gene.value = min(gene.value, max_potency)
							else if(istype(G, /datum/plant_gene/core/lifespan))
								gene.value = min(gene.value, max_endurance) //INTENDED
							else if(istype(G, /datum/plant_gene/core/endurance))
								gene.value = min(gene.value, max_endurance)
							else if(istype(G, /datum/plant_gene/core/production))
								gene.value = max(gene.value, min_production)
							else if(istype(G, /datum/plant_gene/core/yield))
								gene.value = min(gene.value, max_yield)
							else if(istype(G, /datum/plant_gene/core/weed_rate))
								gene.value = max(gene.value, min_wrate)
							else if(istype(G, /datum/plant_gene/core/weed_chance))
								gene.value = max(gene.value, min_wchance)
						disk.gene = gene
						to_chat(usr, "<span class='notice'>你将 [gene] 写入磁盘。</span>")
						disk.update_disk_name()
						qdel(seed)
						seed = null
						update_icon()
				if("replace")
					if(disk && disk.gene && istype(disk.gene, G.type) && istype(G, /datum/plant_gene/core))
						seed.genes -= G
						var/datum/plant_gene/core/C = disk.gene.Copy()
						seed.genes += C
						C.apply_stat(seed)
						repaint_seed()
				if("insert")
					if(disk && disk.gene && !istype(disk.gene, /datum/plant_gene/core) && disk.gene.can_add(seed))
						seed.genes += disk.gene.Copy()
						if(istype(disk.gene, /datum/plant_gene/reagent))
							seed.reagents_from_genes()
						disk.gene.apply_vars(seed)
						repaint_seed()


			update_genes()
			operation = ""
			target = null
	else if(href_list["abort"])
		operation = ""
		target = null

	interact(usr)

/obj/machinery/plantgenes/proc/insert_seed(obj/item/seeds/S)
	if(!istype(S) || seed)
		return
	S.forceMove(src)
	seed = S
	update_genes()
	update_icon()

/obj/machinery/plantgenes/proc/eject_disk()
	if (disk && !operation)
		if(Adjacent(usr))
			if (!usr.put_in_hands(disk))
				disk.forceMove(drop_location())
		else
			disk.forceMove(drop_location())
		disk = null
		update_genes()

/obj/machinery/plantgenes/proc/eject_seed()
	if (seed && !operation)
		if(Adjacent(usr))
			if (!usr.put_in_hands(seed))
				seed.forceMove(drop_location())
		else
			seed.forceMove(drop_location())
		seed = null
		update_genes()

/obj/machinery/plantgenes/proc/update_genes()
	core_genes = list()
	reagent_genes = list()
	trait_genes = list()

	if(seed)
		var/gene_paths = list(
			/datum/plant_gene/core/potency,
			/datum/plant_gene/core/yield,
			/datum/plant_gene/core/production,
			/datum/plant_gene/core/endurance,
			/datum/plant_gene/core/lifespan,
			/datum/plant_gene/core/weed_rate,
			/datum/plant_gene/core/weed_chance
			)
		for(var/a in gene_paths)
			core_genes += seed.get_gene(a)

		for(var/datum/plant_gene/reagent/G in seed.genes)
			reagent_genes += G

		for(var/datum/plant_gene/trait/G in seed.genes)
			trait_genes += G

/obj/machinery/plantgenes/proc/repaint_seed()
	if(!seed)
		return
	if(copytext(seed.name, 1, 13) == "experimental" || findtext(seed.name, "实验型 ") == 1)//13 == length("experimental") + 1
		return // Already modded name and icon
	seed.name = "实验型 " + seed.name
	seed.icon_state = "seed-x"

/* Not adding this right now
// Gene modder for seed vault ship, built with high tech alien parts.
/obj/machinery/plantgenes/seedvault
	circuit = /obj/item/circuitboard/machine/plantgenes/vault

*/

/*
 *  Plant DNA disk
 */

/obj/item/disk/computer/plantgene
	name = "植物数据磁盘"
	desc = "一张用于储存植物遗传数据的磁盘。"
	icon_state = "datadisk4"
	custom_materials = list(/datum/material/iron=30, /datum/material/glass=10)
	var/datum/plant_gene/gene
	read_only = FALSE //Well, it's still a floppy disk
	obj_flags = UNIQUE_RENAME

/obj/item/disk/computer/plantgene/Initialize(mapload)
	. = ..()
	set_sticker_icon_state("o_dna1")
	src.pixel_x = rand(-5, 5)
	src.pixel_y = rand(-5, 5)

/obj/item/disk/computer/plantgene/proc/update_disk_name()
	if(gene)
		name = "[gene.get_name()]（植物数据磁盘）"
	else
		name = "植物数据磁盘"

/obj/item/disk/computer/plantgene/attack_self(mob/user)
	read_only = !read_only
	to_chat(user, "<span class='notice'>你将写保护开关拨到 [src.read_only ? "保护" : "未保护"]。</span>")

/obj/item/disk/computer/plantgene/examine(mob/user)
	. = ..()
	if(gene && (istype(gene, /datum/plant_gene/core/potency)))
		. += "<span class='notice'>百分比是相对于效力而言的，与植物的最大体积无关。</span>"
	. += "写保护开关当前处于 [src.read_only ? "保护" : "未保护"] 状态。"
