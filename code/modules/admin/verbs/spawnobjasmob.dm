ADMIN_VERB(spawn_obj_as_mob, R_SPAWN, "生成物体怪物", "将一个物体生成为活物。", ADMIN_CATEGORY_DEBUG)
	VERB_ARG(object, VERB_ARG_TYPE_TYPEPATH, VERB_ARG_SOURCE_INPUT)
	var/chosen = pick_closest_path(object, make_types_fancy(subtypesof(/obj)))

	if (!chosen)
		return

	var/mob/living/basic/mimic/copy/basemob = /mob/living/basic/mimic/copy

	var/obj/chosen_obj = text2path(chosen)

	var/list/settings = list("mainsettings" = list(
		"name" = list(
			"desc" = "名称",
			"type" = "string",
			"value" = "Bob",
		),
		"maxhealth" = list(
			"desc" = "最大生命值",
			"type" = "number",
			"value" = 100,
		),
		"access" = list(
			"desc" = "权限 ID",
			"type" = "datum",
			"path" = "/obj/item/card/id",
			"value" = "Default",
		),
		"objtype" = list(
			"desc" = "基础物体类型",
			"type" = "datum",
			"path" = "/obj",
			"value" = "[chosen]",
		),
		"googlyeyes" = list(
			"desc" = "活动眼珠",
			"type" = "boolean",
			"value" = "No",
		),
		"disableai" = list(
			"desc" = "禁用 AI",
			"type" = "boolean",
			"value" = "Yes",
		),
		"idledamage" = list(
			"desc" = "闲置时受伤",
			"type" = "boolean",
			"value" = "No",
		),
		"dropitem" = list(
			"desc" = "死亡时掉落物体",
			"type" = "boolean",
			"value" = "Yes",
		),
		"mobtype" = list(
			"desc" = "基础生物类型",
			"type" = "datum",
			"path" = "/mob/living/basic/mimic/copy",
			"value" = "/mob/living/basic/mimic/copy",
		),
		"ckey" = list(
			"desc" = "ckey",
			"type" = "ckey",
			"value" = "none",
		),
	))

	var/list/pref_return = present_pref_like_picker(user.mob, "自定义生物", "自定义生物", width = 450, timeout = 0, settings = settings)
	if (pref_return["button"] != 1)
		return

	settings = pref_return["settings"]
	var/mainsettings = settings["mainsettings"]
	chosen_obj = text2path(mainsettings["objtype"]["value"])

	basemob = text2path(mainsettings["mobtype"]["value"])
	if (!ispath(basemob, /mob/living/basic/mimic/copy) || !ispath(chosen_obj, /obj))
		to_chat(user.mob, "生物或物体路径无效。", confidential = TRUE)

	basemob = new basemob(get_turf(user.mob), new chosen_obj(get_turf(user.mob)), user.mob, mainsettings["dropitem"]["value"] == "Yes" ? FALSE : TRUE, (mainsettings["googlyeyes"]["value"] == "Yes" ? FALSE : TRUE))

	if (mainsettings["disableai"]["value"] == "Yes")
		qdel(basemob.ai_controller)
		basemob.ai_controller = null

	if (mainsettings["idledamage"]["value"] == "No")
		basemob.idledamage = FALSE

	if (mainsettings["access"])
		var/newaccess = text2path(mainsettings["access"]["value"])
		if (ispath(newaccess))
			var/obj/item/card/id/id = new newaccess //cant do initial on lists
			basemob.AddComponent(/datum/component/simple_access, id.access)
			qdel(id)

	if (mainsettings["maxhealth"]["value"])
		if (!isnum(mainsettings["maxhealth"]["value"]))
			mainsettings["maxhealth"]["value"] = text2num(mainsettings["maxhealth"]["value"])
		if (mainsettings["maxhealth"]["value"] > 0)
			basemob.maxHealth = basemob.maxHealth = mainsettings["maxhealth"]["value"]

	if (mainsettings["name"]["value"])
		basemob.name = basemob.real_name = html_decode(mainsettings["name"]["value"])

	if (mainsettings["ckey"]["value"] != "none")
		basemob.ckey = mainsettings["ckey"]["value"]


	log_admin("[key_name(user.mob)] spawned a sentient object-mob [basemob] from [chosen_obj] at [AREACOORD(user.mob)]")
	BLACKBOX_LOG_ADMIN_VERB("Spawn object-mob")
