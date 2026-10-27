#define US_EAST_RELAY_ADDR "byond://useast.bubberstation.org:3000"
#define US_WEST_RELAY_ADDR "byond://uswest.bubberstation.org:3000"
#define SYDNEY_RELAY_ADDR "byond://sydney.bubberstation.org:3000"
#define SINGAPORE_RELAY_ADDR "byond://singapore.bubberstation.org:3000"
#define EU_RELAY_ADDR "byond://germany.bubberstation.org:3000"
#define NO_RELAY_ADDR "byond://direct.bubberstation.org:3000"

#define US_EAST_RELAY "连接至美国东部（弗吉尼亚）"
#define US_WEST_RELAY "连接至美国西部（俄勒冈）"
#define SYDNEY_RELAY "连接至澳大利亚（悉尼）"
#define SINGAPORE_RELAY "连接至新加坡"
#define EU_RELAY "连接至德国（法兰克福）"
#define NO_RELAY "不使用中继（直接连接）"

/client/verb/go2relay()
	var/static/list/relays = list(
		US_EAST_RELAY,
		US_WEST_RELAY,
		SYDNEY_RELAY,
		EU_RELAY,
		NO_RELAY,
	)
	var/choice = tgui_input_list(usr, "你想使用哪个中继服务器？", "选择中继", relays)
	var/destination
	switch(choice)
		if(US_EAST_RELAY)
			destination = US_EAST_RELAY_ADDR
		if(US_WEST_RELAY)
			destination = US_WEST_RELAY_ADDR
		if(SYDNEY_RELAY)
			destination = SYDNEY_RELAY_ADDR
		if(SINGAPORE_RELAY)
			destination = SINGAPORE_RELAY_ADDR
		if(EU_RELAY)
			destination = EU_RELAY_ADDR
		if(NO_RELAY)
			destination = NO_RELAY_ADDR
	if(destination)
		usr << link(destination)
		sleep(1 SECONDS)
		winset(usr, null, "command=.quit")
	else
		usr << "你没有选择中继服务器。"

#undef US_EAST_RELAY_ADDR
#undef US_WEST_RELAY_ADDR
#undef SYDNEY_RELAY_ADDR
#undef SINGAPORE_RELAY_ADDR
#undef EU_RELAY_ADDR
#undef NO_RELAY_ADDR

#undef US_EAST_RELAY
#undef US_WEST_RELAY
#undef SYDNEY_RELAY
#undef SINGAPORE_RELAY
#undef EU_RELAY
#undef NO_RELAY
