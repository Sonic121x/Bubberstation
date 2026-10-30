//reforming
/obj/item/ectoplasm/revenant
	name = "微光残渣"
	desc = "一堆细腻的蓝色尘埃。细细的紫色雾气在它周围盘旋。"
	icon = 'icons/effects/effects.dmi'
	icon_state = "revenantEctoplasm"
	w_class = WEIGHT_CLASS_SMALL
	// Can the revenant reform?
	var/inert = FALSE

/obj/item/ectoplasm/revenant/Initialize(mapload, revenant)
	. = ..()
	inert = !revenant
	if(revenant)
		AddComponent(/datum/component/revenant_prison, revenant = revenant)
		addtimer(CALLBACK(src, PROC_REF(reform)), 1 MINUTES)

/obj/item/ectoplasm/revenant/Destroy()
	return ..()

/obj/item/ectoplasm/revenant/attack_self(mob/user)
	if(inert)
		return ..()
	user.visible_message(
		span_notice("[user] 把 [src] 向四面八方撒开。"),
		span_notice("你把 [src] 撒满了这片区域。"),
	)
	user.dropItemToGround(src)
	SEND_SIGNAL(src, COMSIG_RESIDUE_DISPERSE)
	qdel(src)

/obj/item/ectoplasm/revenant/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(inert)
		return
	visible_message(span_notice("[src] 在撞击的瞬间碎成微粒，随即消散于虚无。"))
	SEND_SIGNAL(src, COMSIG_RESIDUE_DISPERSE)
	qdel(src)

/obj/item/ectoplasm/revenant/examine(mob/user)
	. = ..()
	if(inert)
		. += span_revennotice("它看起来已经失去了活性。")
	else
		. += span_revenwarning("它正在不停地变形、扭曲。最好把它毁掉。")

/obj/item/ectoplasm/revenant/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 正在吸入 [src]！看来是打算去暗影界走一趟了！"))
	qdel(src)
	return OXYLOSS

/// Actually moves the revenant out of ourself
/obj/item/ectoplasm/revenant/proc/reform()
	if(QDELETED(src) || inert)
		return
	if(!(SEND_SIGNAL(src, COMSIG_RESIDUE_REFORM) & COMPONENT_RESIDUE_REFORM_SUCCESS))
		inert = TRUE
		return
	message_admins("亡魂灵质被放置了一分钟仍未被摧毁，正在重塑为一名新的亡魂。")
	visible_message(span_revenboldnotice("[src] 突然升到空中，随后渐渐消散。"))
	qdel(src)
