
/**
 * Enables an admin to upload a new titlescreen image.
 */
ADMIN_VERB(admin_change_title_screen, R_FUN, "标题画面：更换", "上传新的标题画面图片。", ADMIN_CATEGORY_FUN)
	log_admin("[key_name(user)] is changing the title screen.")
	message_admins("[key_name_admin(user)]正在更换标题画面。")

	switch(alert(usr, "请选择新的标题画面。", "标题画面", "更换", "重置", "取消"))
		if("更换")
			var/file = input(user) as icon|null
			if(!file)
				return
			SStitle.change_title_screen(file)
		if("重置")
			SStitle.change_title_screen()
		if("取消")
			return

/**
 * Sets a titlescreen notice, a big red text on the main screen.
 */
ADMIN_VERB(change_title_screen_notice, R_FUN, "标题画面：设置公告", "设置以红色大字显示在主画面上的公告。", ADMIN_CATEGORY_FUN)
	log_admin("[key_name(usr)] is setting the title screen notice.")
	message_admins("[key_name_admin(usr)]正在设置标题画面公告。")

	var/new_notice = input(usr, "请输入要在标题画面显示的公告：", "标题画面公告") as text|null
	SStitle.set_notice(new_notice)
	if(!new_notice)
		return
	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		to_chat(new_player, span_boldannounce("标题画面公告已更新：[new_notice]"))
		SEND_SOUND(new_player,  sound('modular_skyrat/modules/admin/sound/duckhonk.ogg'))

/**
 * Reloads the titlescreen if it is bugged for someone.
 */
ADMIN_VERB(fix_title_screen, R_ADMIN, "修复大厅画面", "大厅画面出问题了？点这里。", ADMIN_CATEGORY_MAIN)
	if(istype(user.mob, /mob/dead/new_player))
		var/mob/dead/new_player/new_player = user.mob
		new_player.show_title_screen()
	else
		winset(src, "title_browser", "is-disabled=true;is-visible=false")
		winset(src, "status_bar", "is-visible=true")

/**
 * An admin debug command that enables you to change the HTML on the go.
 */
ADMIN_VERB(change_title_screen_html, R_DEBUG, "标题画面：设置 HTML", "即时更改大厅画面的 HTML。", ADMIN_CATEGORY_FUN)
	log_admin("[key_name(user)] is setting the title screen HTML.")
	message_admins("[key_name_admin(user)]正在设置标题画面的 HTML。")

	var/new_html = input(usr, "请输入所需的 HTML（警告：可能导致画面损坏）", "危险：编辑标题画面 HTML") as message|null

	if(!new_html)
		return

	SStitle.title_html = new_html
	SStitle.show_title_screen()

	message_admins("[key_name_admin(user)]已更改标题画面的 HTML。")
