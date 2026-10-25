/client/proc/cmd_show_hiddenprints(atom/victim)
	if(!check_rights(R_ADMIN))
		return

	var/interface = "所有接触过[victim]的玩家日志，按最后接触时间排序。<br><br><ol>"
	var/victim_hiddenprints = GET_ATOM_HIDDENPRINTS(victim)

	if(!islist(victim_hiddenprints))
		victim_hiddenprints = list()

	var/list/hiddenprints = assoc_to_values(victim_hiddenprints)
	list_clear_nulls(hiddenprints)

	if(!length(hiddenprints))
		hiddenprints = list("目前还没有人接触过！")

	hiddenprints = sort_list(hiddenprints, GLOBAL_PROC_REF(cmp_hiddenprint_lasttime_dsc))
	for(var/record in hiddenprints)
		interface += "<li>[record]</li><br>"

	interface += "</ol>"

	var/datum/browser/hiddenprint_view = new(usr, "view_hiddenprints_[REF(victim)]", "[victim]的隐藏指纹", 450, 760)
	hiddenprint_view.set_content(interface)
	hiddenprint_view.open()

/proc/cmp_hiddenprint_lasttime_dsc(a, b)
	var/last_a = copytext(a, findtext(a, "\nLast: "))
	var/last_b = copytext(b, findtext(b, "\nLast: "))
	return cmp_text_dsc(last_a, last_b)
