ADMIN_VERB(debug_maintenance_loot, R_DEBUG, "调试维护区战利品", "列出游戏中所有未包含在维护区战利品表中的物品", ADMIN_CATEGORY_DEBUG)

	var/confirm = input(user,"确定要调试维护区战利品吗？此过程会占用大量服务器资源。","调试维护区战利品","取消") as null|anything in list("是","否","取消")
	if(confirm != "是")
		return

	log_admin("[key_name(user)]开始调试维护区战利品。")

	var/list/every_single_maintenance_item = list()
	for(var/loot_list in GLOB.maintenance_loot)
		for(var/loot_object in loot_list)
			if(islist(loot_object))
				for(var/k in loot_object)
					every_single_maintenance_item[k] = TRUE
			else
				every_single_maintenance_item[loot_object] = TRUE

	var/returning_data = "<h1>未包含在维护区战利品表中的物品：</h1><br>"
	for(var/k in subtypesof(/obj/item/))
		if(!every_single_maintenance_item[k])
			returning_data = "[returning_data]<br>[k]"

	user << browse(returning_data, "window=maintenace_report")

ADMIN_VERB(simulate_maintenance_loot, R_DEBUG, "模拟维护区战利品", "模拟100次维护区战利品生成。不应用特殊特性修正。", ADMIN_CATEGORY_DEBUG)

	var/confirm = input(user,"确定要模拟维护区战利品吗？此过程会占用大量服务器资源。","模拟维护区战利品","取消") as null|anything in list("是","否","取消")
	if(confirm != "是")
		return

	var/list/current_loot_counts = list() //Assoc list. path = count

	var/missing_count = 0
	for(var/i=1,i<=500,i++)
		var/atom/movable/M = pick_weight_recursive(GLOB.maintenance_loot)
		if(!M) //wat
			missing_count++
			continue
		if(!current_loot_counts[M])
			current_loot_counts[M] = 1
		else
			current_loot_counts[M] += 1

	sortTim(current_loot_counts, cmp=/proc/cmp_numeric_dsc, associative = TRUE)

	var/returning_data = "<h1>500次模拟维护区战利品生成结果：</h1><br>"
	var/confirmation_count = 0
	var/different_path_count = 0
	for(var/atom_path in current_loot_counts)
		returning_data = "[returning_data]<br>[atom_path]: [current_loot_counts[atom_path]] ([round(current_loot_counts[atom_path]/5,0.01)]%)"
		confirmation_count += current_loot_counts[atom_path]
		different_path_count += 1

	returning_data = "[returning_data]<br>列出了[different_path_count]种不同物品，共[confirmation_count]件，缺失[missing_count]件。"

	user << browse(returning_data, "window=maintenace_report")

ADMIN_VERB(find_nullspaced_objects, R_DEBUG, "查找空空间对象", "弹出所有loc为null的对象列表", ADMIN_CATEGORY_DEBUG)
	var/list/nullspaced_objects = list()
	for(var/atom/object as anything)
		if(!isnull(object.loc))
			continue
		if(!istype(object))
			continue
		nullspaced_objects += object
		CHECK_TICK

	var/no_duplicates = list()
	for(var/atom/object as anything in nullspaced_objects)
		var/refcount = refcount(object)
		if(no_duplicates[object.type] && no_duplicates[object.type]["refcount"] == refcount)
			no_duplicates[object.type]["priority"] += 1
			continue
		no_duplicates[object.type] = list("priority" = 1, "refcount" = refcount, "object" = object)
		CHECK_TICK

	sortTim(no_duplicates, GLOBAL_PROC_REF(cmp_filter_data_priority), TRUE)

	var/list/nullspace_tagged_objects = list()
	var/list/strings = list()
	for(var/object_type in no_duplicates)
		var/list/sub_list = no_duplicates[object_type]
		var/atom/object = sub_list["object"]
		var/refcount = sub_list["refcount"]
		var/count = sub_list["priority"]
		if(isnull(object))
			continue
		if(!object.tag)
			nullspace_tagged_objects += object
		strings += "名称：[object]，\
			类型：[object_type]，\
			引用数：[refcount]，\
			实例数：[count]，\
			正在删除：[QDELING(object) ? "是" : "否"] \
			[ADMIN_VV(object)]"
		CHECK_TICK

	var/title = "<h1>所有loc为null的对象列表：</h1><br>"
	user << browse(HTML_SKELETON_TITLE(title, "[jointext(strings, "<br>")]"), "window=maintenace_report")

ADMIN_VERB(toggle_tgui_fallback, R_DEBUG, "全局切换旧版TGUI", "仅在TGUI损坏时使用。这将为所有人切换界面。", ADMIN_CATEGORY_DEBUG)
	if(isnull(GLOB.tgui_fallback_enabled))
		GLOB.tgui_fallback_enabled = FALSE

	GLOB.tgui_fallback_enabled = !GLOB.tgui_fallback_enabled

	if(GLOB.tgui_fallback_enabled)
		log_admin("[key_name(usr)]全局启用了旧版界面。")
		message_admins("已全局启用旧版界面。")
		for(var/client/connected_clients in GLOB.clients)
			winset(connected_clients, "output_selector.legacy_output_selector", "left=output_legacy")
	else
		log_admin("[key_name(usr)]全局禁用了旧版界面。")
		message_admins("已全局禁用旧版界面。")
		for(var/client/connected_clients in GLOB.clients)
			winset(connected_clients, "output_selector.output", "left=output")
