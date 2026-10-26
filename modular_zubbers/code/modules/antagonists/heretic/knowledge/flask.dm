/obj/item/reagent_containers/cup/beaker/eldritch/examine(mob/user)
	. = ..()

	. += span_notice("这只烧瓶通常装着[EXAMINE_HINT("邪异精华")]，对非侍徒而言是剧毒，\
	对与漫宿相通者却是强效疗药。不言而喻，持有它的人可能是一名侍徒。")
