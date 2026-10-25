// IF you have linked your account, this will trigger a verify of the user
GAME_VERB_DESC(/client, verify_in_discord, "验证 Discord 账号", "用你的 BYOND 账号验证你的 Discord 账号", "OOC")

	// Safety checks
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(src, span_warning("此功能需要 SQL 后端正在运行。"))
		return

	// Why this would ever be unset, who knows
	var/prefix = CONFIG_GET(string/discordbotcommandprefix)
	if(!prefix)
		to_chat(src, span_warning("此功能已被禁用。"))
		return

	if(!SSdiscord || !SSdiscord.reverify_cache)
		to_chat(src, span_warning("请等待 Discord 子系统完成初始化"))
		return
	var/message = ""
	// Simple sanity check to prevent a user doing this too often
	var/cached_one_time_token = SSdiscord.reverify_cache[usr.ckey]
	if(cached_one_time_token && cached_one_time_token != "")
		message = "你已经生成过一次性令牌了，它是 [cached_one_time_token]。如果你需要新的令牌，必须等到本回合结束，或切换到其他服务器；你可以尝试在 Discord 上自行验证，复制这条命令：<span class='code user-select'>[prefix]verify [cached_one_time_token]</span> 并粘贴到验证频道中。"


	else
		// Will generate one if an expired one doesn't exist already, otherwise will grab existing token
		var/one_time_token = SSdiscord.get_or_generate_one_time_token_for_ckey(ckey)
		SSdiscord.reverify_cache[usr.ckey] = one_time_token
		message = "你的一次性令牌是：[one_time_token]。假设你已满足游戏内所需的在线分钟数，现在你可以在 Discord 上使用这条命令完成验证：<span class='code user-select'>[prefix]verify [one_time_token]</span>"

	//Now give them a browse window so they can't miss whatever we told them
	var/datum/browser/window = new /datum/browser(usr, "discordverification", "Discord 验证")
	window.set_content("<div>[message]</div>")
	window.open()


