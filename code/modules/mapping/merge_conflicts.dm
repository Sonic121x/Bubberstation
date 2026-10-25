// Used by mapmerge2 to denote the existence of a merge conflict (or when it has to complete a "best intent" merge where it dumps the movable contents of an old key and a new key on the same tile).
// We define it explicitly here to ensure that it shows up on the highest possible plane (while giving off a verbose icon) to aide mappers in resolving these conflicts.
// DO NOT USE THIS IN NORMAL MAPPING!!! Linters WILL fail.

/obj/merge_conflict_marker
	name = "合并冲突标记 - 请勿使用"
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "merge_conflict_marker"
	desc = "如果你在游戏里看到这个：有人真的、真的、真的搞砸了。他们居然把合并冲突标记给实际画进地图里了。搞什么鬼。"
	plane = POINT_PLANE

///We REALLY do not want un-addressed merge conflicts in maps for an inexhaustible list of reasons. This should help ensure that this will not be missed in case linters fail to catch it for any reason what-so-ever.
/obj/merge_conflict_marker/Initialize(mapload)
	. = ..()
	var/msg = "喂，听着！！！在 [AREACOORD(src)] 检测到合并冲突标记！请手动处理所有潜在的合并冲突！！！"
	log_mapping(msg)
	to_chat(world, span_boldannounce("[msg]"))
	warning(msg)
