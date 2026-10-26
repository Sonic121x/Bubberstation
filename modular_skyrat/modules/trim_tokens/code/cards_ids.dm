// Proc to use a trim token on an ID
/obj/item/card/id/proc/apply_token(obj/item/trim_token/token, mob/user)
	if(token.has_required_trim)
		if(!(src.trim in token.valid_trims))
			to_chat(user, span_warning("你的 ID 卡饰边不适用此饰边令牌。"))
			return
	if(token.uses == 0)
		to_chat(user, span_warning("你将[token.name]按在 ID 卡上时，它便解体了。它剩余的电量恐怕仅够维持形状！"))
		qdel(token)
		return

	// Just to make sure to give feedback if it requires a better card to grant the trim.
	if(SSid_access.apply_trim_to_card(src, token.token_trim, copy_access = token.force_access))
		playsound(src, token.usesound, 40)
		to_chat(user, span_notice("[token.name]与你的 ID 卡融为一体，将其饰边替换为[chinese_job_display(token.assignment)]饰边！"))
		if(token.uses > 0)
			token.uses -= 1
		if(token.uses == 0)
			qdel(token)
			return
		to_chat(user, span_notice("成功替换 ID 卡饰边后，[token.name]在你眼前重新凝成一枚实体令牌。真不错。"))
		return
	else
		to_chat(user, span_warning("你的 ID 卡稀有度不足，无法进行这项饰边升级！"))
