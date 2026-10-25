
GLOBAL_DATUM_INIT(AdminProcCallHandler, /mob/proccall_handler, new())
GLOBAL_PROTECT(AdminProcCallHandler)

/// Used to handle proccalls called indirectly by an admin (e.g. tgs, circuits).
/// Has to be a mob because IsAdminAdvancedProcCall() checks usr, which is a mob variable.
/// So usr is set to this for any proccalls that don't have any usr mob/client to refer to.
/mob/proccall_handler
	name = "进程调用处理器"
	desc = "如果你看到这个，请告诉程序员。"

	var/list/callers = list()

	invisibility = INVISIBILITY_ABSTRACT
	density = FALSE

/// Adds a caller.
/mob/proccall_handler/proc/add_caller(caller_name)
	callers += caller_name
	name = "[initial(name)] ([callers.Join(") (")])"

/// Removes a caller.
/mob/proccall_handler/proc/remove_caller(caller_name)
	callers -= caller_name
	name = "[initial(name)] ([callers.Join(") (")])"

/mob/proccall_handler/Initialize(mapload)
	. = ..()
	if(GLOB.AdminProcCallHandler && GLOB.AdminProcCallHandler != src)
		return INITIALIZE_HINT_QDEL
	GLOB.AdminProcCallHandler = src

/mob/proccall_handler/vv_edit_var(var_name, var_value)
	if(GLOB.AdminProcCallHandler != src)
		return ..()
	return FALSE

/mob/proccall_handler/vv_do_topic(list/href_list)
	if(GLOB.AdminProcCallHandler != src)
		return ..()
	return FALSE

/mob/proccall_handler/CanProcCall(procname)
	if(GLOB.AdminProcCallHandler != src)
		return ..()
	return FALSE

// Shit will break if this is allowed to be deleted
/mob/proccall_handler/Destroy(force)
	if(GLOB.AdminProcCallHandler != src)
		return ..()
	if(!force)
		stack_trace("Attempted deletion on [type] - [name], aborting.")
		return QDEL_HINT_LETMELIVE
	return ..()

/**
 * Handles a userless proccall, used by circuits.
 *
 * Arguments:
 * * user - a string used to identify the user
 * * target - the target to proccall on
 * * proc - the proc to call
 * * arguments - any arguments
 */
/proc/HandleUserlessProcCall(user, datum/target, procname, list/arguments)
	if(IsAdminAdvancedProcCall())
		return
	var/mob/proccall_handler/handler = GLOB.AdminProcCallHandler
	handler.add_caller(user)
	var/lastusr = usr
	usr = handler
	. = WrapAdminProcCall(target, procname, arguments)
	usr = lastusr
	handler.remove_caller(user)

/**
 * Handles a userless sdql, used by circuits and tgs.
 *
 * Arguments:
 * * user - a string used to identify the user
 * * query_text - the query text
 */
/proc/HandleUserlessSDQL(user, query_text)
	if(IsAdminAdvancedProcCall())
		return
	var/mob/proccall_handler/handler = GLOB.AdminProcCallHandler
	handler.add_caller(user)
	var/lastusr = usr
	usr = handler
	. = world.SDQL2_query(query_text, user, user)
	usr = lastusr
	handler.remove_caller(user)

ADMIN_VERB(advanced_proc_call, R_DEBUG, "高级进程调用", "在服务器中的任意数据对象上调用进程。", ADMIN_CATEGORY_DEBUG)
	user.callproc_blocking()

/client/proc/callproc_blocking(list/get_retval)
	if(!check_rights(R_DEBUG))
		return

	var/datum/target
	var/targetselected = FALSE
	var/returnval

	switch(tgui_alert(usr,"该进程有所有者吗？",,list("Yes","No")))
		if("Yes")
			targetselected = TRUE
			var/list/value = vv_get_value(default_class = VV_ATOM_REFERENCE, classes = list(VV_ATOM_REFERENCE, VV_DATUM_REFERENCE, VV_MOB_REFERENCE, VV_CLIENT, VV_MARKED_DATUM, VV_TEXT_LOCATE, VV_PROCCALL_RETVAL))
			if (!value["class"] || !value["value"])
				return
			target = value["value"]
			if(!istype(target))
				to_chat(usr, span_danger("无效的目标。"), confidential = TRUE)
				return
		if("No")
			target = null
			targetselected = FALSE

	var/procpath = input("进程路径，例如：/proc/fake_blood","路径：", null) as text|null
	if(!procpath)
		return

	//strip away everything but the proc name
	var/list/proclist = splittext(procpath, "/")
	if (!length(proclist))
		return

	var/procname = proclist[proclist.len]
	var/proctype = ("verb" in proclist) ? "verb" :"proc"

	if(targetselected)
		if(!hascall(target, procname))
			to_chat(usr, span_warning("错误：callproc()：[target.type] 类型没有名为 [procpath] 的 [proctype]。"), confidential = TRUE)
			return
	else
		procpath = "/[proctype]/[procname]"
		if(!text2path(procpath))
			to_chat(usr, span_warning("错误：callproc()：[procpath] 不存在。"), confidential = TRUE)
			return

	var/list/lst = get_callproc_args()
	if(!lst)
		return

	if(targetselected)
		if(!target)
			to_chat(usr, "<font color='red'>错误：callproc()：该进程的所有者已不存在。</font>", confidential = TRUE)
			return
		var/msg = "[key_name(src)] 调用了 [target] 的 [procname]()，[lst.len ? "参数为 [list2params(lst)]":"无参数"]。"
		log_admin(msg)
		message_admins(msg) //Proccall announce removed.
		admin_ticket_log(target, msg)
		returnval = WrapAdminProcCall(target, procname, lst) // Pass the lst as an argument list to the proc
	else
		//this currently has no hascall protection. wasn't able to get it working.
		log_admin("[key_name(src)] 调用了 [procname]()，[lst.len ? "参数为 [list2params(lst)]":"无参数"]。")
		message_admins("[key_name(src)] 调用了 [procname]()，[lst.len ? "参数为 [list2params(lst)]":"无参数"]。") //Proccall announce removed.
		returnval = WrapAdminProcCall(GLOBAL_PROC, procname, lst) // Pass the lst as an argument list to the proc
	BLACKBOX_LOG_ADMIN_VERB("Advanced ProcCall")
	if(get_retval)
		if (islist(returnval))
			get_retval += list(returnval) // Wrap to stop BYOND from concat-ing the lists
		else
			get_retval += returnval
	. = get_callproc_returnval(returnval, procname)
	if(.)
		to_chat(usr, ., confidential = TRUE)

GLOBAL_VAR(AdminProcCaller)
GLOBAL_PROTECT(AdminProcCaller)
GLOBAL_VAR_INIT(AdminProcCallCount, 0)
GLOBAL_PROTECT(AdminProcCallCount)
GLOBAL_VAR(LastAdminCalledTargetRef)
GLOBAL_PROTECT(LastAdminCalledTargetRef)
GLOBAL_VAR(LastAdminCalledTarget)
GLOBAL_PROTECT(LastAdminCalledTarget)
GLOBAL_VAR(LastAdminCalledProc)
GLOBAL_PROTECT(LastAdminCalledProc)

/// Wrapper for proccalls where the datum is flagged as vareditted
/proc/WrapAdminProcCall(datum/target, procname, list/arguments)
	if(target && procname == "Del")
		to_chat(usr, "不允许调用 Del()", confidential = TRUE)
		return

	if(target != GLOBAL_PROC && !target.CanProcCall(procname))
		to_chat(usr, "不允许对 [target.type]/proc/[procname] 进行进程调用！", confidential = TRUE)
		return
	var/current_caller = GLOB.AdminProcCaller
	var/user_identifier = usr ? usr.client?.ckey : GLOB.AdminProcCaller
	var/is_remote_handler = usr == GLOB.AdminProcCallHandler
	if(is_remote_handler)
		user_identifier = GLOB.AdminProcCallHandler.name

	if(!user_identifier)
		CRASH("WrapAdminProcCall with no ckey: [target] [procname] [english_list(arguments)]")

	if(!is_remote_handler && current_caller && current_caller != user_identifier)
		to_chat(usr, span_adminnotice("另一组管理员调用的进程仍在运行。请稍后再试。"), confidential = TRUE)
		return

	GLOB.LastAdminCalledProc = procname
	if(target != GLOBAL_PROC)
		GLOB.LastAdminCalledTargetRef = REF(target)

	if(!is_remote_handler)
		GLOB.AdminProcCaller = user_identifier //if this runtimes, too bad for you
		++GLOB.AdminProcCallCount
		. = world.WrapAdminProcCall(target, procname, arguments)
		GLOB.AdminProcCallCount--
		if(GLOB.AdminProcCallCount == 0)
			GLOB.AdminProcCaller = null
	else
		. = world.WrapAdminProcCall(target, procname, arguments)

//adv proc call this, ya nerds
/world/proc/WrapAdminProcCall(datum/target, procname, list/arguments)
	if(target == GLOBAL_PROC)
		return call("/proc/[procname]")(arglist(arguments))
	else if(target != world)
		return call(target, procname)(arglist(arguments))
	else
		log_admin("[key_name(usr)] 试图以以下参数调用 world/proc/[procname]：[english_list(arguments)]")

/proc/IsAdminAdvancedProcCall()
#ifdef TESTING
	return FALSE
#else
	return (GLOB.AdminProcCaller && GLOB.AdminProcCaller == usr?.client?.ckey) || (GLOB.AdminProcCallHandler && usr == GLOB.AdminProcCallHandler)
#endif

ADMIN_VERB_ONLY_CONTEXT_MENU(call_proc_datum, R_DEBUG, "原子进程调用", /datum)
	VERB_ARG_TYPED(thing, VERB_ARG_TYPE_AREA | VERB_ARG_TYPE_OBJ | VERB_ARG_TYPE_TURF | VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /datum)
	var/procname = input(user, "进程名称，例如：fake_blood","进程：", null) as text|null
	if(!procname)
		return
	if(!hascall(thing, procname))
		to_chat(user, "<font color='red'>错误：callproc_datum()：[thing.type] 类型没有名为 [procname] 的进程。</font>", confidential = TRUE)
		return
	var/list/lst = user.get_callproc_args()
	if(!lst)
		return

	if(!thing || !is_valid_src(thing))
		to_chat(user, span_warning("错误：callproc_datum()：该进程的所有者已不存在。"), confidential = TRUE)
		return
	log_admin("[key_name(user)] 调用了 [thing] 的 [procname]()，[lst.len ? "参数为 [list2params(lst)]":"无参数"]。")
	var/msg = "[key_name(user)] 调用了 [thing] 的 [procname]()，[lst.len ? "参数为 [list2params(lst)]":"无参数"]。"
	message_admins(msg)
	admin_ticket_log(thing, msg)
	BLACKBOX_LOG_ADMIN_VERB("Atom ProcCall")

	var/returnval = WrapAdminProcCall(thing, procname, lst) // Pass the lst as an argument list to the proc
	. = user.get_callproc_returnval(returnval,procname)
	if(.)
		to_chat(user, ., confidential = TRUE)

/client/proc/get_callproc_args()
	var/argnum = input("参数数量","数量：",0) as num|null
	if(isnull(argnum))
		return

	. = list()
	var/list/named_args = list()
	while(argnum--)
		var/named_arg = input("留空则作为位置参数。位置参数将被视为最先添加的参数。", "命名参数") as text|null
		var/value = vv_get_value(restricted_classes = list(VV_RESTORE_DEFAULT))
		if (!value["class"])
			return
		if(named_arg)
			named_args[named_arg] = value["value"]
		else
			. += LIST_VALUE_WRAP_LISTS(value["value"])
	if(LAZYLEN(named_args))
		. += named_args

/client/proc/get_callproc_returnval(returnval,procname)
	. = ""
	if(islist(returnval))
		var/list/returnedlist = returnval
		. = "<font color='blue'>"
		if(returnedlist.len)
			var/assoc_check = returnedlist[1]
			if(istext(assoc_check) && (returnedlist[assoc_check] != null))
				. += "[procname] 返回了一个关联列表："
				for(var/key in returnedlist)
					. += "\n[key] = [returnedlist[key]]"

			else
				. += "[procname] 返回了一个列表："
				for(var/elem in returnedlist)
					. += "\n[elem]"
		else
			. = "[procname] 返回了一个空列表"
		. += "</font>"

	else
		. = "<font color='blue'>[procname] 返回：[!isnull(returnval) ? html_encode(returnval) : "空值"]</font>"
