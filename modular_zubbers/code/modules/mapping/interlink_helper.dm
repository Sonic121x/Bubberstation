/// A file to help with making it possible to load the Interlink *modularly* instead of leaving it stuck in Z-2 where station should be and spawning all manner of bad behaviour.
#define INIT_ANNOUNCE(X) to_chat(world, span_boldannounce("[X]")); log_world(X)

/datum/controller/subsystem/mapping/loadWorld()
	. = ..()
#ifndef ABSOLUTE_MINIMUM
	var/list/FailedZsRat = list()
	LoadGroup(FailedZsRat, "The Interlink", "map_files/generic", "CentCom_bubber_z2.dmm", default_traits = ZTRAITS_CENTCOM)
	if(LAZYLEN(FailedZsRat)) //but seriously, unless the server's filesystem is messed up this will never happen
		var/msg = "红色警报！以下地图文件加载失败：[FailedZsRat[1]]"
		if(FailedZsRat.len > 1)
			for(var/I in 2 to FailedZsRat.len)
				msg += ", [FailedZsRat[I]]"
		msg += "。去骂你的服务器主机商吧！"
		INIT_ANNOUNCE(msg)
#endif

#undef INIT_ANNOUNCE
