/obj/effect/immovablerod/Bump(atom/clong)
	var/should_self_destroy = FALSE
	if(istype(clong, /obj/machinery/rodstopper))
		should_self_destroy = TRUE
	. = ..()
	if(should_self_destroy)
		visible_message(span_boldwarning("铁棒伴随着撕裂现实的尖啸，撞进了铁棒拦截器！"))
		playsound(src.loc,'sound/effects/supermatter.ogg', 200, TRUE)
		visible_message(span_boldwarning("局部现实将在五秒后坍缩，立即远离！"))
		new/obj/reality_tear(src.loc)
		qdel(src)
