ADMIN_VERB(toggle_bsa, R_ADMIN, "切换 BSA 控制权限", "开启或关闭 BSA 控制锁定。", ADMIN_CATEGORY_FUN)
	GLOB.bsa_unlock = !GLOB.bsa_unlock
	minor_announce("蓝空间火炮开火协议已[GLOB.bsa_unlock? "解锁" : "锁定"]", "武器系统更新：")

	message_admins("[ADMIN_LOOKUPFLW(usr)] [GLOB.bsa_unlock? "解锁" : "锁定"]了 BSA 开火协议。")
	log_admin("[key_name(user)] [GLOB.bsa_unlock? "解锁" : "锁定"]了 BSA 开火协议。")
