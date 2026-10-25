
ADMIN_VERB(requests, R_NONE, "请求管理器", "打开请求管理器面板，查看本回合内的所有请求", ADMIN_CATEGORY_GAME)
	GLOB.requests.ui_interact(usr)
	BLACKBOX_LOG_ADMIN_VERB("Request Manager")
