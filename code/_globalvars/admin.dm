GLOBAL_LIST_EMPTY(stickybanadminexemptions) //stores a list of ckeys exempted from a stickyban (workaround for a bug)
GLOBAL_LIST_EMPTY(stickybanadmintexts) //stores the entire stickyban list temporarily
GLOBAL_VAR(stickbanadminexemptiontimerid) //stores the timerid of the callback that restores all stickybans after an admin joins

/proc/init_smites()
	var/list/smites = list()
	for (var/_smite_path in subtypesof(/datum/smite))
		var/datum/smite/smite_path = _smite_path
		smites[initial(smite_path.name)] = smite_path
	return smites

GLOBAL_LIST_INIT_TYPED(smites, /datum/smite, init_smites())

GLOBAL_VAR_INIT(admin_notice, "") // Admin notice that all clients see when joining the server

// A list of all the special byond lists that need to be handled different by vv
GLOBAL_LIST_INIT(vv_special_lists, init_special_list_names())

// Stores the value set for the AFK timer callback
GLOBAL_VAR(logout_timer_set)

/proc/init_special_list_names()
	var/list/output = list()
	var/obj/sacrifice = new
	for(var/varname in sacrifice.vars)
		var/value = sacrifice.vars[varname]
		if(!islist(value))
			if(!isdatum(value) && hascall(value, "Cut"))
				output += varname
			continue
		if(isnull(locate(REF(value))))
			output += varname
	return output

///A giant associative list of span names, and the associated key to create the text span. Used for narrate verbs.
GLOBAL_LIST_INIT(spanname_to_formatting, list(
	"绑架者" = "abductor",
	"管理员" = "admin",
	"管理员求助" = "adminhelp",
	"管理员通知" = "adminnotice",
	"管理员观察者 OOC" = "adminobserverooc",
	"管理员 OOC" = "adminooc",
	"管理员聊天" = "adminsay",
	"AI 私人无线电" = "aiprivradio",
	"警报" = "alert",
	"异形警报" = "alertalien",
	"辛迪加警报" = "alertsyndie",
	"警报警告" = "alertwarning",
	"异形" = "alien",
	"一般" = "average",
	"负面" = "bad",
	"大号" = "big",
	"二进制聊天" = "binarysay",
	"变形菌" = "blob",
	"变形菌公告" = "blobannounce",
	"蓝色" = "blue",
	"蓝队无线电" = "blueteamradio",
	"粗体" = "bold",
	"粗体公告" = "boldannounce",
	"粗体危险" = "bolddanger",
	"粗斜体" = "bolditalic",
	"粗体柔和绿色" = "boldnicegreen",
	"粗体通知" = "boldnotice",
	"粗体警告" = "boldwarning",
	"大号粗体" = "big bold",
	"舰长广播" = "captaincast",
	"中央指挥部无线电" = "centcomradio",
	"变形怪" = "changeling",
	"小丑" = "clown",
	"巨像" = "colossus",
	"指挥耳机" = "command_headset",
	"血神教" = "cult",
	"血神教粗体" = "cult_bold",
	"血神教粗斜体" = "cult_bold_italic",
	"血神教斜体" = "cult_italic",
	"血神教大号" = "cult_large",
	"危险" = "danger",
	"亡者聊天" = "deadsay",
	"解除皈依消息" = "deconversion_message",
	"无人机无线电" = "drone",
	"工程无线电" = "engradio",
	"极大号" = "extremelybig",
	"娱乐无线电" = "enteradio",
	"游戏聊天" = "game say",
	"幽灵警报" = "ghostalert",
	"绿色" = "green",
	"绿色公告" = "greenannounce",
	"绿队无线电" = "greenteamradio",
	"绿色文本" = "greentext",
	"灰色" = "grey",
	"圣职者" = "hierophant",
	"圣职者警告" = "hierophant_warning",
	"高亮" = "highlight",
	"圣恩" = "his_grace",
	"全息寄生体" = "holoparasite",
	"全息寄生体粗体" = "holoparasite bold",
	"催眠" = "hypnophrase",
	"图标" = "icon",
	"信息" = "info",
	"普通信息" = "infoplain",
	"界面" = "interface",
	"本地 OOC" = "looc",
	"勋章" = "medal",
	"医疗无线电" = "medradio",
	"消息" = "message",
	"心灵控制" = "mind_control",
	"猴子" = "monkey",
	"纳尔西" = "narsie",
	"纳尔西小号" = "narsiesmall",
	"柔和绿色" = "nicegreen",
	"通知" = "notice",
	"异形通知" = "noticealien",
	"OOC" = "ooc",
	"Papyrus 字体" = "papyrus",
	"恐惧症" = "phobia",
	"前缀" = "prefix",
	"紫色" = "purple",
	"无线电" = "radio",
	"特大号" = "reallybig",
	"红色" = "red",
	"红队无线电" = "redteamradio",
	"红色文本" = "redtext",
	"魔像共鸣" = "resonate",
	"亡魂大号通知" = "revenbignotice",
	"亡魂粗体通知" = "revenboldnotice",
	"亡魂危险" = "revendanger",
	"亡魂次要消息" = "revenminor",
	"亡魂通知" = "revennotice",
	"亡魂警告" = "revenwarning",
	"机器人" = "robot",
	"玫瑰色" = "rose",
	"Comic Sans 字体" = "sans",
	"科研无线电" = "sciradio",
	"安保无线电" = "secradio",
	"服务无线电" = "servradio",
	"歌唱" = "singing",
	"史莱姆" = "slime",
	"小号" = "small",
	"小号通知" = "smallnotice",
	"小号斜体通知" = "smallnoticeital",
	"育母蜘蛛" = "spiderbroodmother",
	"侦察蜘蛛" = "spiderscout",
	"破障蜘蛛" = "spiderbreacher",
	"自杀" = "suicide",
	"货运无线电" = "suppradio",
	"辛迪加无线电" = "syndradio",
	"录音机" = "tape_recorder",
	"微小号通知" = "tinynotice",
	"微小号斜体通知" = "tinynoticeital",
	"微小号危险" = "tinydanger",
	"微小号柔和绿色" = "tinynicegreen",
	"昏迷" = "unconscious",
	"自身危险" = "userdanger",
	"警告" = "warning",
	"喊叫" = "yell",
	"黄队无线电" = "yellowteamradio",
	))
