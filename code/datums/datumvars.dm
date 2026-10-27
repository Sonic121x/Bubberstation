/datum/proc/CanProcCall(procname)
	return TRUE

/// Items in this list will not show up in VV
GLOBAL_LIST_INIT(vv_var_blacklist, list(
	"faction" = TRUE,
))
/datum/proc/can_vv_get(var_name)
	if(var_name == NAMEOF(src, vars))
		return FALSE
	if(var_name in GLOB.vv_var_blacklist)
		return FALSE
	return TRUE

/// Called when a var is edited with the new value to change to
/datum/proc/vv_edit_var(var_name, var_value)
	if(var_name == NAMEOF(src, vars))
		return FALSE
	vars[var_name] = var_value
	datum_flags |= DF_VAR_EDITED
	return TRUE

/datum/proc/vv_get_var(var_name)
	switch(var_name)
		if (NAMEOF(src, vars))
			return debug_variable(var_name, list(), 0, src)
	return debug_variable(var_name, vars[var_name], 0, src)

/datum/proc/can_vv_mark()
	return TRUE

/**
 * Gets all the dropdown options in the vv menu.
 * When overriding, make sure to call . = ..() first and append to the result, that way parent items are always at the top and child items are further down.
 * Add separators by doing VV_DROPDOWN_OPTION("", "---")
 */
/datum/proc/vv_get_dropdown()
	SHOULD_CALL_PARENT(TRUE)

	. = list()
	VV_DROPDOWN_OPTION(VV_HK_CALLPROC, "调用过程")
	VV_DROPDOWN_OPTION(VV_HK_MARK, "标记对象")
	VV_DROPDOWN_OPTION(VV_HK_TAG, "为数据对象设置标签")
	VV_DROPDOWN_OPTION(VV_HK_DELETE, "删除")
	VV_DROPDOWN_OPTION(VV_HK_EXPOSE, "向玩家展示变量查看器")
	VV_DROPDOWN_OPTION(VV_HK_ADDCOMPONENT, "添加组件/元素")
	VV_DROPDOWN_OPTION(VV_HK_REMOVECOMPONENT, "移除组件/元素")
	VV_DROPDOWN_OPTION(VV_HK_MASS_REMOVECOMPONENT, "批量移除组件/元素")
	VV_DROPDOWN_OPTION(VV_HK_MODIFY_TRAITS, "修改特质")

/**
 * This proc is only called if everything topic-wise is verified. The only verifications that should happen here is things like permission checks!
 * href_list is a reference, modifying it in these procs WILL change the rest of the proc in topic.dm of admin/view_variables!
 * This proc is for "high level" actions like admin heal/set species/etc/etc. The low level debugging things should go in admin/view_variables/topic_basic.dm in case this runtimes.
 */
/datum/proc/vv_do_topic(list/href_list)
	if(!usr || !usr.client || !usr.client.holder || !check_rights(R_VAREDIT))
		return FALSE //This is VV, not to be called by anything else.
	if(SEND_SIGNAL(src, COMSIG_VV_TOPIC, usr, href_list) & COMPONENT_VV_HANDLED)
		return FALSE
	if(href_list[VV_HK_MODIFY_TRAITS])
		usr.client.holder.modify_traits(src)
	if(href_list[VV_HK_DEBUG_APPEARANCE]) // On base datum as it is shared by atoms and mutable_appearance/image VVs
		usr.client.holder.appearance_debug.set_target(src)
		usr.client.holder.appearance_debug.ui_interact(usr)
	return TRUE

/datum/proc/vv_get_header()
	. = list()
	if(("name" in vars) && !isatom(src))
		. += "<b>[vars["name"]]</b><br>"
