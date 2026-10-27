/mob/living/silicon/ai/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	if(stat != DEAD)
		if(lacks_power() && apc_override) //Placing this in Login() in case the AI doesn't have this link for whatever reason.
			to_chat(usr, "[span_warning("主电源不可用，正在使用备用电源。诊断扫描完成。")] <A href='byond://?src=[REF(src)];emergencyAPC=[TRUE]'>本地 APC 已准备好连接。</A>")
	set_eyeobj_visible(TRUE)
	if(multicam_on)
		end_multicam()
	view_core()
