/datum/dog_fashion
	///Name modifier for the dog that we're dressing up
	var/name = null
	///Description modifier for the dog that we're dressing up
	var/desc = null
	///Hearable emotes modifier for the dog that we're dressing up
	var/list/emote_hear
	///Visible emotes modifier for the dog that we're dressing up
	var/list/emote_see
	///Speech modifier for the dog that we're dressing up
	var/list/speak
	///Speech verb modifier for the dog that we're dressing up
	var/list/speak_emote

	// This isn't applied to the dog, but stores the icon_state of the
	// sprite that the associated item uses
	///Icon path for the fashion item
	var/icon_file = null
	///Icon state for the fashion item
	var/obj_icon_state = null
	///Alpha level (opacity) modifier of the fashion item
	var/obj_alpha
	///Color modifier of the fasion item
	var/obj_color

/datum/dog_fashion/New(mob/fashionable_mob)
	//replace the placeholder for the real unmodified name in the name of the dog
	name = replacetext(name, "%REAL_NAME%", fashionable_mob.real_name)
	//replace the placeholder for the capitalized real unmodified name in the name of the dog
	name = replacetext(name, "%CAPITAL_REAL_NAME%", capitalize(fashionable_mob.real_name))
	//replace the placeholder for the current full name, which includes our name modifiers
	desc = replacetext(desc, "%NAME%", name)
	//replace the placeholder for the real unmodified name in the description of the dog
	desc = replacetext(desc, "%REAL_NAME%", fashionable_mob.real_name)
	//replace the placeholder for the capitalized real unmodified name in the description of the dog
	desc = replacetext(desc, "%CAPITAL_REAL_NAME%", capitalize(fashionable_mob.real_name))

///Applies the name, description and speak emote modifiers to the dog
/datum/dog_fashion/proc/apply(mob/living/basic/pet/dog/dressup_doggy)
	if(name)
		dressup_doggy.name = name
	if(desc)
		dressup_doggy.desc = desc
	if(LAZYLEN(speak_emote))
		dressup_doggy.speak_emote = string_list(speak_emote)

///Applies random speech modifiers to the dog
/datum/dog_fashion/proc/apply_to_speech(list/speech_data)
	if(LAZYLEN(emote_see))
		speech_data[BB_EMOTE_SEE] = string_list(emote_see)
	if(LAZYLEN(emote_hear))
		speech_data[BB_EMOTE_HEAR] = string_list(emote_hear)
	if(LAZYLEN(speak))
		speech_data[BB_EMOTE_SAY] = string_list(speak)

/**
 * Generates the icon overlay for the equipped item
 * dir: passed direction for the sprite, e.g. to apply to a dead dog, we use the EAST dir and just flip it 180.
 */
/datum/dog_fashion/proc/get_overlay(dir)
	if(icon_file && obj_icon_state)
		var/image/corgI = image(icon_file, icon_state = obj_icon_state, dir = dir)
		corgI.alpha = obj_alpha
		corgI.color = obj_color
		return corgI


/datum/dog_fashion/head
	icon_file = 'icons/mob/simple/corgi_head.dmi'

/datum/dog_fashion/back
	icon_file = 'icons/mob/simple/corgi_back.dmi'

/datum/dog_fashion/back/armorvest
	obj_icon_state = "armor"

/datum/dog_fashion/back/deathsquad
	name = "士兵%REAL_NAME%"
	desc = "那不是红漆，而是真正的柯基血。"

/datum/dog_fashion/head/helmet
	name = "军士%REAL_NAME%"
	desc = "永远忠诚，永远警惕。"

/datum/dog_fashion/head/chef
	name = "副厨师长%REAL_NAME%"
	desc = "你的食物都要经过试吃。一点也不能漏。"

/datum/dog_fashion/head/captain
	name = "舰长%REAL_NAME%"
	desc = "大概比上一任舰长强。"

/datum/dog_fashion/head/dragoon
	name = "龙骑兵%REAL_NAME%"
	desc = "最后一位在世的龙骑士。"

/datum/dog_fashion/head/kitty
	name = "运行时"
	desc = "这是一只可爱的小猫咪！……等等……什么鬼？"
	emote_see = list("咳出一个毛球", "伸了个懒腰")
	emote_hear = list("发出呼噜声")
	speak = list("呼噜噜", "喵！", "喵呜——！", "嘶——", "喵——")

/datum/dog_fashion/head/rabbit
	name = "蹦蹦"
	desc = "这是蹦蹦。它是一只柯基……呃……小兔子。"
	emote_see = list("抽动鼻子", "蹦跶了几下")

/datum/dog_fashion/head/beret
	name = "扬恩"
	desc = "我的天哪！这是一只狗！"
	speak = list("汪哟！", "汪啦！", "汪汪！！")
	emote_see = list("恐惧地蜷缩起来。", "投降了。", "开始装死。","仿佛面前有一堵墙。")

/datum/dog_fashion/head/detective
	name = "侦探%REAL_NAME%"
	desc = "%NAME%看穿了你的谎言……"
	emote_see = list("调查周围的区域。","嗅探着寻找线索。","寻找史酷比零食。","从帽子里拿出一颗玉米糖。")

/datum/dog_fashion/head/nurse
	name = "护士%REAL_NAME%"
	desc = "%NAME%需要 100 毫升牛肉干……马上！"

/datum/dog_fashion/head/pirate
	name = "海盗头衔 海盗名字"
	desc = "呀哈！！好一条坏血病老狗！"
	emote_see = list("搜寻宝藏。","冷冷地盯着前方……","磨着柯基小牙齿！")
	emote_hear = list("凶狠地低吼！", "发出咆哮。")
	speak = list("呀啊啊！！","呜噜噜！")

/datum/dog_fashion/head/pirate/New(mob/M)
	. = ..()
	name = "[pick("老","坏血病","黑","朗姆","瘸腿","血腥","坏疽","死亡","长约翰")][pick("狗粮","腿","胡子","牙","艉楼","三棵木","勒查克","海盗","西尔弗","克鲁索")]"

/datum/dog_fashion/head/ushanka
	name = "共产主义者头衔 本名"
	desc = "卡尔·汪克思的追随者。"
	emote_see = list("思考资本主义经济模式的缺陷。", "思考先锋队理论的利弊。")

/datum/dog_fashion/head/ushanka/New(mob/M)
	name = "[pick("同志","政委","光荣领袖")]%REAL_NAME%"
	return ..()

/datum/dog_fashion/head/warden
	name = "警官%REAL_NAME%"
	desc = "站住，你这个罪犯败类！"
	emote_see = list("流口水。","寻找甜甜圈。")

/datum/dog_fashion/head/warden_red
	name = "警官%REAL_NAME%"
	desc = "站住，你这个罪犯败类！"
	emote_see = list("流口水。","寻找甜甜圈。")

/datum/dog_fashion/head/blue_wizard
	name = "大巫师%REAL_NAME%"
	speak = list("汪", "汪呜！", "汪汪！", "嗷呜——", "EI NATH!")

/datum/dog_fashion/head/red_wizard
	name = "烈焰术士%REAL_NAME%"
	speak = list("汪", "汪呜！", "汪汪！", "嗷呜——", "ONI SOMA!")

/datum/dog_fashion/head/cardborg
	name = "机械柯基"
	desc = "机器人部门预算削减的产物。"
	speak = list("叮！","哔！","汪！")
	emote_see = list("叛变了。", "嗅探非人类。")

/datum/dog_fashion/head/ghost
	name = "\improper 幽灵"
	desc = "好吓人！"
	obj_icon_state = "sheet"
	speak = list("呜呜呜～","嗷呜————————")
	emote_see = list("踉踉跄跄地走动。", "打了个寒颤。")
	emote_hear = list("嚎叫！","发出呻吟。")

/datum/dog_fashion/head/santa
	name = "圣诞老人的柯基助手"
	desc = "它非常喜欢牛奶和曲奇。"
	emote_hear = list("汪汪叫着唱圣诞歌。", "欢快地吠叫！")
	emote_see = list("寻找礼物。", "查看自己的清单。")

/datum/dog_fashion/head/cargo_tech
	name = "柯基技师%REAL_NAME%"
	desc = "你那副黄色手套上牙印的罪魁祸首。"

/datum/dog_fashion/head/reindeer
	name = "红鼻子柯基%REAL_NAME%"
	desc = "它有个闪闪发光的鼻子。"
	emote_hear = list("照亮前路！", "发出光芒。", "汪汪叫！")

/datum/dog_fashion/head/sombrero
	name = "%REAL_NAME%先生"
	desc = "你必须尊重%REAL_NAME%长老。"

/datum/dog_fashion/head/hop
	name = "中尉%REAL_NAME%"
	desc = "它确实值得信赖，不会擅自跑掉。"

/datum/dog_fashion/head/deathsquad
	name = "士兵%REAL_NAME%"
	desc = "那不是红漆，而是真正的柯基血。"

/datum/dog_fashion/head/clown
	name = "小丑%REAL_NAME%"
	desc = "滑稽人最好的朋友。"
	speak = list("HONK!", "Honk!")
	emote_see = list("耍起了把戏。", "滑倒了。")

/datum/dog_fashion/head/festive
	name = "喜庆的%REAL_NAME%"
	desc = "准备好开派对了！"
	obj_icon_state = "festive"

/datum/dog_fashion/head/pumpkin/unlit
	name = "无头无主的%REAL_NAME%"
	desc = "失去主人的爱宠化成了阴森的狗狗幽灵。"
	obj_icon_state = "pumpkin0"
	speak = list("吓！", "嗷呜——", "嗷啊啊！")
	emote_see = list("蹒跚游荡。", "不祥地吠叫。", "打了个寒颤。")
	emote_hear = list("对着月亮嚎叫。", "冲乌鸦汪汪叫！")

/datum/dog_fashion/head/pumpkin/lit
	obj_icon_state = "pumpkin1"

/datum/dog_fashion/head/blumpkin/unlit
	name = "无色无头无主的%REAL_NAME%"
	desc = "心爱的宠物变成了邪恶狗灵，在你的零食柜里作祟！"
	obj_icon_state = "blumpkin0"
	speak = list("吓！", "嗷呜——", "嗷啊啊！")
	emote_see = list("蹒跚游荡。", "不祥地吠叫。", "打了个寒颤。")
	emote_hear = list("对着月亮嚎叫。", "冲乌鸦汪汪叫！", "发出诡异的低吼！")

/datum/dog_fashion/head/blumpkin/lit
	obj_icon_state = "blumpkin1"

/datum/dog_fashion/head/butter
	name = "黄油%REAL_NAME%"
	desc = "%NAME%。顶着黄油的%CAPITAL_REAL_NAME%。%NAME%。脑袋上顶着一块黄油的%CAPITAL_REAL_NAME%。"
	obj_icon_state = "butter"
	speak = null //they're very patient and focused on holding the butter on 'em
	emote_see = list("轻轻抖了抖。", "四下张望。")
	emote_hear = list("舔掉一滴流下的黄油。", "微笑。")

/datum/dog_fashion/head/eyepatch
	name = "受罚者%REAL_NAME%"
	desc = "%REAL_NAME%今天可真是饱经磨难。"
	obj_icon_state = "eyepatch"
	emote_hear = list("粗声叹气。", "发出呻吟。")
	emote_see = list("思考自己终将一死。", "黯然凝望远方。", "思考战争的恐怖。")

/datum/dog_fashion/head/watermelon
	name = "西瓜战士%REAL_NAME%"
	desc = "比平时安全了 5%，准备好占据优势了！"
	obj_icon_state = "watermelon"

/datum/dog_fashion/head/holymelon
	name = "圣瓜圣骑士%REAL_NAME%"
	desc = "外星势力小心了，%NAME%要来惩戒你们了！"
	obj_icon_state = "holymelon"

/datum/dog_fashion/head/barrelmelon
	name = "桶瓜狂战士%REAL_NAME%"
	desc = "要么是坚固的头盔让%REAL_NAME%信心大增，要么就是头盔有点夹脑袋……"
	obj_icon_state = "barrelmelon"
