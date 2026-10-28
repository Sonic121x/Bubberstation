/mob/living/silicon/get_silicon_flavortext()
	. = ..()
	if(!CONFIG_GET(flag/check_vetted))
		return
	if(!client || !SSplayer_ranks.initialized)
		return
	if(SSplayer_ranks.is_vetted(client, admin_bypass = FALSE))
		. += span_greenannounce("该玩家已由工作人员认证为 18+ 玩家。")

/mob/living/carbon/human/examine(mob/user)
	. = ..()
	if(!CONFIG_GET(flag/check_vetted))
		return
	if(!client || !SSplayer_ranks.initialized)
		return
	if(SSplayer_ranks.is_vetted(client, admin_bypass = FALSE))
		. += span_greenannounce("该玩家已由工作人员认证为 18+ 玩家。")
