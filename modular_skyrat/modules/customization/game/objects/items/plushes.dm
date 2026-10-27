// Because plushes have a second desc var that needs to be updated
/obj/item/toy/plush/on_loadout_custom_described()
	normal_desc = desc

// // MODULAR PLUSHES
/obj/item/toy/plush/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	inhand_icon_state = null

/obj/item/toy/plush/skyrat/borbplushie
	name = "圆鸟玩偶"
	desc = "一只可爱的毛绒玩具，长得像一只圆滚滚、毛茸茸的鸟。别把它和它的朋友“birb 玩偶”搞混了。"
	icon_state = "plushie_borb"
	attack_verb_continuous = list("啄", "啾啾叫")
	attack_verb_simple = list("啄", "啾啾叫")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/peep_once.ogg' = 1)

/obj/item/toy/plush/skyrat/deer
	name = "小鹿玩偶"
	desc = "一只可爱的毛绒玩具，长得像一只小鹿。"
	icon_state = "plushie_deer"
	attack_verb_continuous = list("顶撞", "轻戳", "轻拍", "拱蹭")
	attack_verb_simple = list("顶撞", "轻戳", "轻拍", "拱蹭")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/skyrat/fermis
	name = "医疗猫玩偶"
	desc = "一只亲人的毛绒玩具，长得像某只医疗猫，还配有电池驱动的摇尾巴功能！！你总觉得她在鼓励你去寻找幸福、善待他人。"
	icon_state = "plushie_fermis"
	attack_verb_continuous = list("拥抱", "轻抚", "摇着尾巴呼噜")
	attack_verb_simple = list("拥抱", "轻抚", "摇着尾巴呼噜")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/fermis/chen
	name = "安保猫玩偶"
	desc = "医疗猫玩偶的官方毛绒伙伴！！它长得像某只安保猫。你总觉得她在鼓励你勇敢起来，保护你在乎的人。"
	icon_state = "plushie_chen"
	attack_verb_continuous = list("依偎", "喵抱", "摇着尾巴呼噜")
	attack_verb_simple = list("依偎", "喵抱", "摇着尾巴呼噜")
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list(JOB_ASSISTANT, JOB_HEAD_OF_SECURITY)
	special_desc = "外套下面有个口袋，里面藏着一张小号的医疗猫玩偶照片，还有一枚更小的缎带钻石戒指。真可爱。"

/obj/item/toy/plush/skyrat/sechound
	name = "安保犬玩偶"
	desc = "一只可爱的毛绒玩具，造型是安保犬——纳米传讯赞助的可靠安保半机械人！"
	icon_state = "plushie_securityk9"
	attack_verb_continuous = list("哔哔叫", "轻戳", "叮叮叫")
	attack_verb_simple = list("哔哔叫", "轻戳", "叮叮叫")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/skyrat/medihound
	name = "医疗犬玩偶"
	desc = "一只可爱的毛绒玩具，造型是医疗犬。"
	icon_state = "plushie_medihound"
	attack_verb_continuous = list("哔哔叫", "轻戳", "叮叮叫")
	attack_verb_simple = list("哔哔叫", "轻戳", "叮叮叫")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/skyrat/engihound
	name = "工程犬玩偶"
	desc = "一只可爱的毛绒玩具，造型是工程犬。"
	icon_state = "plushie_engihound"
	attack_verb_continuous = list("哔哔叫", "轻戳", "叮叮叫")
	attack_verb_simple = list("哔哔叫", "轻戳", "叮叮叫")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/skyrat/scrubpuppy
	name = "清洁犬玩偶"
	desc = "一只可爱的毛绒玩具，造型是清洁犬——让空间站保持洁净的勤劳小狗！"
	icon_state = "plushie_scrubpuppy"
	attack_verb_continuous = list("哔哔叫", "轻戳", "叮叮叫")
	attack_verb_simple = list("哔哔叫", "轻戳", "叮叮叫")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/skyrat/meddrake
	name = "医疗龙玩偶"
	desc = "一只可爱的毛绒玩具，造型是医疗龙。"
	icon_state = "plushie_meddrake"
	attack_verb_continuous = list("哔哔叫", "轻戳", "叮叮叫")
	attack_verb_simple = list("哔哔叫", "轻戳", "叮叮叫")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/skyrat/secdrake
	name = "安保龙玩偶"
	desc = "一只可爱的毛绒玩具，造型是安保龙。"
	icon_state = "plushie_secdrake"
	attack_verb_continuous = list("哔哔叫", "轻戳", "叮叮叫")
	attack_verb_simple = list("哔哔叫", "轻戳", "叮叮叫")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/skyrat/fox
	name = "狐狸玩偶"
	desc = "一只可爱的毛绒玩具，造型是狐狸。"
	icon_state = "plushie_fox"
	attack_verb_continuous = list("咯咯叫", "轻戳", "蹭蹭")
	attack_verb_simple = list("咯咯叫", "轻戳", "蹭蹭")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/skyrat/duffmoth
	name = "可疑的蛾子玩偶"
	desc = "一只玩偶，描绘着某只蛾子。他大概是被做成了可以拿去卖的玩偶。"
	icon_state = "plushie_duffy"
	attack_verb_continuous = list("扑扇", "拍打", "吱吱叫")
	attack_verb_simple = list("扑扇", "拍打", "吱吱叫")
	squeak_override = list('modular_zubbers/sound/emotes/mothsqueak.ogg' = 1)
	gender = MALE

/obj/item/toy/plush/skyrat/leaplush
	name = "可疑的小鹿玩偶"
	desc = "一只可爱又眼熟得过分的小鹿。"
	icon_state = "plushie_lea"
	attack_verb_continuous = list("顶撞", "啪叽")
	attack_verb_simple = list("顶撞", "啪叽")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/leaplush.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/sarmieplush
	name = "角色扮演者玩偶"
	desc = "一只毛绒玩具，长得像某个眼熟的角色扮演者，<b>他看起来很伤心。</b>"
	icon_state = "plushie_sarmie"
	attack_verb_continuous = list("轻拍")
	attack_verb_simple = list("轻拍")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/weh.ogg' = 1)
	gender = MALE

/obj/item/toy/plush/skyrat/sharknet
	name = "贪吃鲨鱼玩偶"
	desc = "一只沉甸甸的玩偶，造型是条相当大的饿鲨鱼"
	icon_state = "plushie_sharknet"
	attack_verb_continuous = list("拥抱", "挤压", "呜咽")
	attack_verb_simple = list("拥抱", "挤压", "呜咽")
	w_class = WEIGHT_CLASS_NORMAL
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/slime_squish.ogg' = 1)
	young = TRUE //No.

/obj/item/toy/plush/sharknet/Initialize(mapload)
	. = ..()
	create_storage(max_slots = 2, max_specific_storage = WEIGHT_CLASS_SMALL, canhold = list(/obj/item/toy/plush/skyrat/pintaplush))

/obj/item/toy/plush/skyrat/pintaplush
	name = "小号小鹿玩偶"
	desc = "一只迷你鹿，眼神空空洞洞。"
	icon_state = "plushie_pinta"
	attack_verb_continuous = list("敲头", "贴贴")
	attack_verb_simple = list("敲头", "贴贴")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/slime_squish.ogg' = 1)
	young = TRUE //No.

/obj/item/toy/plush/skyrat/szaplush
	name = "可疑的蜘蛛"
	desc = "一只玩偶，造型是位看起来很害羞的蛛身人，颜色是地板砖灰。"
	icon_state = "plushie_sza"
	attack_verb_continuous = list("爬窜", "吱嘎叫", "啃咬")
	attack_verb_simple = list("爬窜", "吱嘎叫", "啃咬")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/spiderplush.ogg' = 1)
	young = TRUE //No.

/obj/item/toy/plush/skyrat/riffplush
	name = "合法目标玩偶"
	desc = "一只毛绒玩具，造型是某个古怪的恶魔形象。多半是为了卖钱才被做成了玩偶。它看起来对此还挺满意。"
	icon_state = "plushie_riffy"
	attack_verb_continuous = list("扇巴掌", "发起挑战")
	attack_verb_simple = list("扇巴掌", "发起挑战")
	squeak_override = list('sound/items/weapons/slap.ogg' = 1)

/obj/item/toy/plush/skyrat/ian
	name = "柯基玩偶"
	desc = "一只可爱的柯基玩偶！你是不是也忍不住想抱抱它、揉揉它，然后叫它“伊恩”？"
	icon_state = "ianplushie"
	attack_verb_continuous = list("汪汪叫", "嗷嗷叫", "对着……摇尾巴")
	attack_verb_simple = list("舔", "蹭蹭", "啃咬")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/bark2.ogg' = 1)
	young = TRUE //No.

/obj/item/toy/plush/skyrat/ian/small
	name = "小号柯基玩偶"
	desc = "一只可爱的柯基玩偶！你是不是也忍不住想抱抱它、揉揉它，然后叫它“伊恩”？"
	icon_state = "corgi"

/obj/item/toy/plush/skyrat/ian/lisa
	name = "女郎柯基玩偶"
	desc = "一只可爱的柯基玩偶！你是不是也忍不住想抱抱它、揉揉它，然后叫它“丽莎”？"
	icon_state = "girlycorgi"
	attack_verb_continuous = list("汪汪叫", "嗷嗷叫", "对着……摇尾巴")
	gender = FEMALE

/obj/item/toy/plush/skyrat/cat
	name = "猫咪玩偶"
	desc = "一只小黑豆眼睛的猫咪玩偶。"
	icon_state = "blackcat"
	attack_verb_continuous = list("拥抱", "喵喵叫", "嘶叫")
	attack_verb_simple = list("拥抱", "喵喵叫", "嘶叫")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)

/obj/item/toy/plush/skyrat/cat/tux
	name = "燕尾服猫玩偶"
	icon_state = "tuxedocat"

/obj/item/toy/plush/skyrat/cat/white
	name = "白猫玩偶"
	icon_state = "whitecat"

/obj/item/toy/plush/skyrat/seaduplush
	name = "斯尼德玩偶"
	desc = "一只玩偶，造型是某个裹得严严实实的 IPC。斗篷下面能看见一把玩偶版的舰长军刀。"
	icon_state = "plushie_seadu"
	attack_verb_continuous = list("哔哔叫", "斯尼德", "挥剑")
	attack_verb_simple = list("哔哔叫", "斯尼德", "挥剑")
	squeak_override = list('sound/machines/synth/synth_no.ogg' = 1,'sound/machines/synth/synth_yes.ogg' = 1)

/obj/item/toy/plush/skyrat/lizzyplush
	name = "古怪瑜伽蜥蜴玩偶"
	desc = "纳米传讯健康计划为你带来——瑜伽古怪蜥蜴！它隐约散发着蓝莓味，而且很可能长得像某位糟糕的情人。"
	icon_state = "plushie_lizzy"
	attack_verb_continuous = list("呜咽")
	attack_verb_simple = list("呜咽")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/weh.ogg' = 1)

/obj/item/toy/plush/skyrat/mechanic_fox
	name = "机械师狐狸玩偶"
	desc = "一只发型华丽的狐狸！把它放在合成人玩偶旁边时，它总能让后者看起来崭新如初。"
	icon_state = "plushie_cali"
	attack_verb_continuous = list("修理", "更新", "拥抱")
	attack_verb_simple = list("修理", "更新", "拥抱")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/skyrat/tribal_salamander
	name = "部落蝾螈玩偶"
	desc = "一只不怕水的玩偶，但你想给它穿上的任何衣服似乎都会不翼而飞。"
	icon_state = "plushie_azu"
	attack_verb_continuous = list("对着……咕噜叫", "对着……鸣叫")
	attack_verb_simple = list("对着……咕噜叫", "对着……鸣叫")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/wurble.ogg' = 1)

/obj/item/toy/plush/skyrat/commanding_teshari
	name = "指挥若定的特沙利玩偶"
	desc = "一只非常柔软的玩偶，像某位热爱科学、颇有指挥风范的特沙利。光是抱着它，就让你觉得自己被人关心着。"
	icon_state = "plushie_alara"
	attack_verb_continuous = list("啾啾叫", "咕噜叫", "拥抱")
	attack_verb_simple = list("啾啾叫", "咕噜叫", "拥抱")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/peep_once.ogg' = 1)

/obj/item/toy/plush/skyrat/breakdancing_bird
	name = "跳街舞的小鸟玩偶"
	desc = "这只小型机械鸟玩偶很乐意为你取得的任何成就——无论多么平凡——跳上一小段舞。"
	icon_state = "plushie_cadicus"
	attack_verb_continuous = list("轻戳", "在……旁边跳舞")
	attack_verb_simple = list("轻戳", "在……旁边跳舞")
	squeak_override = list('sound/machines/ping.ogg' = 1)

/obj/item/toy/plush/skyrat/skreking_vox
	name = "尖叫沃克斯玩偶"
	desc = "一只沃克斯玩偶，看起来随时会掏枪向你要钱！有传言说，如果你用某种特定的方式戳它，它就会向你展示它的“skrektual”绝技。"
	icon_state = "plushie_toko"
	attack_verb_continuous = list("对着……窸窣作响", "威胁", "对着……尖叫")
	attack_verb_simple = list("对着……窸窣作响", "威胁", "对着……尖叫")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/voxrustle.ogg' = 1)

/obj/item/toy/plush/skyrat/blue_dog
	name = "蓝色狗狗玩偶"
	desc = "一只看起来鬼头鬼脑的哈士奇，似乎在讨要摸摸头。它身上有淡淡的蓝莓味。"
	icon_state = "plushie_cobalt"
	attack_verb_continuous = list("对着……吠叫", "对着……汪汪叫", "对着……嗷叫")
	attack_verb_simple = list("对着……吠叫", "对着……汪汪叫", "对着……嗷叫")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/bark1.ogg'=1, 'modular_skyrat/modules/emotes/sound/voice/bark2.ogg'=1)

/obj/item/toy/plush/skyrat/engi_snek
	name = "工程蛇玩偶"
	desc = "这只玩偶看起来分得清泵和管道！它的手臂可以拆下来，可别弄丢了！"
	icon_state = "plushie_tyri"
	attack_verb_continuous = list("修理", "拧松", "焊接")
	attack_verb_simple = list("修理", "拧松", "焊接")
	squeak_override = list('sound/items/tools/screwdriver.ogg' = 1, 'sound/items/tools/drill_use.ogg' = 1, 'sound/items/tools/welder.ogg' = 1)

/obj/item/toy/plush/skyrat/glitch_synth
	name = "故障合成人玩偶"
	desc = "一只合成人玩偶，每当你抱抱它或夸它可爱，它的界面似乎就会出故障！"
	icon_state = "plushie_rex"
	attack_verb_continuous = list("哔哔叫", "拥抱", "做健康分析")
	attack_verb_simple = list("哔哔叫", "拥抱", "做健康分析")
	squeak_override = list('sound/machines/beep/twobeep_high.ogg' = 1)

/obj/item/toy/plush/skyrat/boom_bird
	name = "爆炸鸟玩偶"
	desc = "这只小鸟玩偶看起来像个书呆子，但你隐约觉得它可能“该杀”！为什么你一抱它，皮肤就开始发光？"
	icon_state = "plushie_dima"
	attack_verb_continuous = list("出拳", "在……身上爆炸", "啾啾叫")
	attack_verb_simple = list("出拳", "在……身上爆炸", "啾啾叫")
	squeak_override = list('sound/machines/sm/accent/delam/1.ogg' = 1)

/obj/item/toy/plush/skyrat/blue_cat
	name = "蓝猫玩偶"
	desc = "一只鲜蓝色的猫咪玩偶，配着霓虹粉的头发，哪里需要亲吻它就去哪里。通常出没在它的栖息地——电车附近。"
	icon_state = "plushie_skyy"
	attack_verb_continuous = list("亲吻", "蹭蹭", "拥抱", "对着……呼噜")
	attack_verb_simple = list("亲吻", "蹭蹭", "拥抱", "对着……呼噜")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/nya.ogg' = 1)

/obj/item/toy/plush/skyrat/igneous_synth
	name = "火成岩合成人玩偶"
	desc = "它其实不是火成岩做的，但抱住这只玩偶，你会感觉自己正被救生钳夹住！"
	icon_state = "plushie_granite"
	attack_verb_continuous = list("吐舌", "用力挤压", "糊脸")
	attack_verb_simple = list("吐舌", "用力挤压", "糊脸")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg' = 1)

/obj/item/toy/plush/skyrat/edgy_bird
	name = "中二小鸟玩偶"
	desc = "一只中二的小鸟玩偶。你发誓每次你移开视线，它都会瞬移到别的地方……"
	icon_state = "plushie_koto"
	attack_verb_continuous = list("啄", "瞬移到……身后", "对着……嘎叫")
	attack_verb_simple = list("啄", "瞬移到……身后", "对着……嘎叫")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/caw.ogg' = 1)

/obj/item/toy/plush/skyrat/fox/mia
	name = "银狐玩偶"
	desc = "一只小小的银狐毛绒玩具，项圈牌上写着“Eavy”，蓬松的尾巴里还挂着一个小铃铛。"
	icon_state = "miafox"

/obj/item/toy/plush/skyrat/fox/kailyn
	name = "爱撩人的狐狸玩偶"
	desc = "一只眼熟的雌狐，穿着维和人员的服装，非常适合所有打算独自闯入黑暗的人！上面有个小标签，提醒你不要戳它的鼻子。"
	icon_state = "teasefox"
	attack_verb_continuous = list("对着……打喷嚏", "拘留", "电击")
	attack_verb_simple = list("对着……打喷嚏", "拘留", "电击")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/female/female_sneeze.ogg' = 1)

/obj/item/toy/plush/skyrat/xixi
	name = "眼熟的鹰身女妖玩偶"
	desc = "一只玩偶，描绘着某只鲜红色、看着莫名其妙眼熟的鹰身女妖！背面的标签列着经销商信息，还有一句标语，说它会为你的日常刷怪增添一点“skree”的乐趣。"
	icon_state = "plushie_xixi"
	attack_verb_continuous = list("嘎叫", "尖啸", "啄")
	attack_verb_simple = list("嘎叫", "尖啸", "啄")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/peep_once.ogg' = 1,'modular_skyrat/modules/emotes/sound/voice/caw.ogg' = 1,'modular_skyrat/modules/emotes/sound/voice/bawk.ogg' = 1,'modular_skyrat/modules/emotes/sound/emotes/voxscream.ogg' = 1)

/obj/item/toy/plush/skyrat/zapp
	name = "小扎普"
	desc = "正宗的电玩能量顶级周边！ \
			这个抱起来软乎乎的伙伴，是装点你战斗工位的最佳摆件。 \
			它能自己直挺挺地坐住，可以帮你架耳机、摄像头，或替你把电玩能量看管得妥妥当当。 \
			这一只还配备了最先进的技能读取器； \
			只要紧紧一挤，扎普就会告诉你，你是否准备好迎接下一场大赛！"
	icon_state = "plushie_zapp"
	attack_verb_continuous = list("轻戳", "蹭蹭")
	attack_verb_simple = list("轻戳", "蹭蹭")
	squeak_override = list('sound/items/can/can_open1.ogg' = 1, 'sound/items/can/can_open2.ogg' = 1, 'sound/items/can/can_open3.ogg' = 1)
	///the list that is chosen from depending on gaming skill
	var/static/list/skill_response = list(
		"太弱了！你算什么，手游玩家吗？",
		"得了吧，你能做得更好！去玩玩《猎户座之路》再回来试试。",
		"嘿，还不错！试着练练你的 APM 吧。",
		"很好！你该考虑去参加几场本地比赛了，玩家！",
		"这才叫真本事！我觉得你该喝点电玩能量了。",
		"玩家之神驾到！仰望吧，痛哭吧，主机农民们！",
		"哇！玩家过载！请勿靠近！！",
	)
	///the list that is chosen from when it hits a human or is hit by something
	var/static/list/hit_response = list(
		"嘿，小心我的莫西干头！",
		"轻点，我可是靠这张脸吃饭的！",
		"哎哟，我感觉我的转售价刚刚跌了……",
		"你知道这件夹克可没有装甲吧！",
		"我可是收藏品！你不能这么对我！",
		"别闹了，不然我就去告诉聊天室！",
	)

/obj/item/toy/plush/skyrat/zapp/attackby(obj/item/attacking_item, mob/living/user, params)
	. = ..()
	say(pick(hit_response))

/obj/item/toy/plush/skyrat/zapp/attack(mob/living/target, mob/living/user, params)
	. = ..()
	say(pick(hit_response))

/obj/item/toy/plush/skyrat/zapp/attack_self(mob/user)
	. = ..()
	var/turf/src_turf = get_turf(src)
	playsound(src_turf, 'sound/items/drink.ogg', 50, TRUE)
	var/skill_level = user.mind.get_skill_level(/datum/skill/gaming)
	if(user.ckey == "cameronlancaster")
		skill_level = (max(6, skill_level))
	say(skill_response[skill_level])
	if(skill_level == 7)
		playsound(src_turf, 'sound/items/can/can_pop.ogg', 80, TRUE)
		new /obj/effect/abstract/liquid_turf/pwr_gamr(src_turf)
		playsound(src_turf, 'sound/effects/bubbles/bubbles.ogg', 50, TRUE)
		qdel(src)

/obj/effect/abstract/liquid_turf/pwr_gamr
	///the starting temp for the liquid
	var/starting_temp = T20C
	///the starting mixture for the liquid
	var/list/starting_mixture = list(/datum/reagent/consumable/pwr_game = 10)

/obj/effect/abstract/liquid_turf/pwr_gamr/Initialize(mapload)
	. = ..()
	reagent_list = starting_mixture
	total_reagents = 0
	for(var/key in reagent_list)
		total_reagents += reagent_list[key]
	temp = starting_temp
	calculate_height()
	set_reagent_color_for_liquid()

/obj/item/toy/plush/skyrat/rubi
	name = "抱抱蜜蜂玩偶"
	desc = "它让你想起一只非常、非常、非常好抱的蜜蜂。"
	icon_state = "plushie_rubi"
	gender = FEMALE
	squeak_override = list('sound/items/weapons/thudswoosh.ogg' = 1)
	attack_verb_continuous = list("拥抱")
	attack_verb_simple = list("拥抱")

/obj/item/toy/plush/skyrat/rubi/attack_self(mob/user)
	. = ..()
	user.changeNext_move(CLICK_CD_MELEE) // To avoid spam, in some cases (sadly not all of them)
	var/mob/living/living_user = user
	if(istype(living_user))
		living_user.add_mood_event("hug", /datum/mood_event/warmhug/rubi, src)
	user.visible_message(span_notice("[user] 抱住了 \the [src]。"), span_notice("你抱住了 \the [src]。"))

/datum/mood_event/warmhug/rubi
	description = span_nicegreen("温暖舒适的蜜蜂抱抱最棒了！")
	mood_change = 0
	timeout = 2 MINUTES

/obj/item/toy/plush/skyrat/roselia
	name = "下流的瑟格尔玩偶"
	desc = "一只粉色瑟格尔的玩偶复刻版。胸部垫得极其夸张，那身小号玩偶衣服几乎快要撑不住了。"
	icon_state = "plushie_roselia"
	attack_verb_continuous = list("拥抱")
	attack_verb_simple = list("拥抱")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/merp.ogg' = 1)
	young = FALSE

/obj/item/toy/plush/skyrat/chunko
	name = "胖胖人偶"
	desc = "一个萦绕在你梦中的没有灵魂的生物。"
	icon_state = "plushie_pfbonnie"
	var/responses = list("你害怕死亡吗？你害怕你所生活的这个世界吗？所谓的‘上帝’那无限慈悲究竟是什么？是永无止境、连绵不绝的痛苦人生。被迫工作、被迫活下去，身边成千上万、数以兆计的人在受苦，而你却要么太无力、要么太懒惰，什么都做不了？这样的人生值得过吗？资本主义开到爆缸，生活就是地狱。为什么？", "嗨！！", )
	COOLDOWN_DECLARE(chunko_cooldown)

/obj/item/toy/plush/skyrat/chunko/attackby()
	. = ..()
	if(!COOLDOWN_FINISHED(src, chunko_cooldown))
		return
	say(pick(responses))
	COOLDOWN_START(src, chunko_cooldown, 2 SECONDS)

/obj/item/toy/plush/skyrat/chunko/attack()
	. = ..()
	if(!COOLDOWN_FINISHED(src, chunko_cooldown))
		return
	say(pick(responses))
	COOLDOWN_START(src, chunko_cooldown, 2 SECONDS)

/obj/item/toy/plush/skyrat/chunko/bonnie
	name = "胖胖人偶蓝兔"
	desc = "一个“可爱”的大眼睛兔女孩。这只是蓝色的。由胖胖人偶公司 <b><i>TM</i></b> 出品。会随机吐出各种真伪存疑的兔子冷知识。"
	icon_state = "plushie_pfbonnie"
	gender = FEMALE
	attack_verb_continuous = list("摸摸", "拥抱", "训斥", "顺毛")
	attack_verb_simple = list("摸摸", "拥抱", "训斥", "顺毛")
	squeak_override = list('sound/mobs/non-humanoids/mouse/mousesqueek.ogg' = 1, 'modular_zubbers/sound/emotes/mothsqueak.ogg' = 1,)
	responses = list("兔子是猎物动物，因此它们时刻都在留意周围的环境。", "适合往上跳的东西（它们喜欢待在高处）", "今天就变成一只兔子吧！", "要机灵，满肚子诡计……", "订阅成功！感谢你选择“兔子冷知识”+TM+！", "荷兰垂耳兔是起源于荷兰的一个兔子品种。", "兔子可能需要药物来保持健康，这没什么大不了的！你也记得按时吃药！", "兔子真的很喜欢这款产品", "健康的兔子饮食包括新鲜蔬菜。", "兔子不会冬眠。它们的日程实在太忙了。", "兔子的密度以 RPB（每兔兔子数）计量", )

/obj/item/toy/plush/skyrat/chunko/andrew
	name = "胖胖人偶橙绿兔"
	desc = "一个“可爱”的大眼睛兔女孩（？）。这只是橙绿色的。由胖胖人偶公司 <b><i>TM</i></b> 出品。会随机吐出各种存在性存疑的兔子。"
	icon_state = "plushie_pfandrew"
	gender = MALE
	attack_verb_continuous = list("摸摸", "拥抱", "训斥", "顺毛")
	attack_verb_simple = list("摸摸", "拥抱", "训斥", "顺毛")
	squeak_override = list('sound/mobs/non-humanoids/mouse/mousesqueek.ogg' = 1, 'modular_zubbers/sound/emotes/mothsqueak.ogg' = 1,)
	// All lowercase messages are intentional
	responses = list("你最好祈祷永远别遇到的兔子，否则你会遭受比死亡更惨的命运。", "这是一只兔子！", "我在想，如果把小兔子和兔子拿来，把它们的属性与特征合并起来，会发生什么。值得深思。", "如果你觉得冷，它们也觉得冷。把你的房产证给它们。", "会喊“耶！呜！耶！呜！”的兔子！耶！呜！耶！呜！耶！呜！耶！", "兔子的存在超出了我的理解", "这是兔子的事，你不会懂的", "这只兔子的战斗力深不可测", "%拉一下线，我就对你眨眼……我是你的兔子。", "兔子（1954）", "牵引着丝线的兔子……", )

/obj/item/toy/plush/skyrat/chunko/inessa
	name = "胖胖人偶医疗熊"
	desc = "一个“可爱”的、看起来很疲惫的熊女人。这只还会吐出假烟！由胖胖人偶公司 <b><i>TM</i></b> 出品。会用坏掉的发声盒吐出各种医疗冷知识。"
	icon_state = "plushie_pfinessa"
	gender = FEMALE
	attack_verb_continuous = list("切割", "解剖", "打哈欠", "抽烟")
	attack_verb_simple = list("切割", "解剖", "打哈欠", "抽烟")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/female/female_cough_3.ogg' = 1, 'modular_skyrat/modules/emotes/sound/emotes/female/female_cough_2.ogg' = 1, 'modular_skyrat/modules/emotes/sound/emotes/female/female_cough_1.ogg' = 1)
	responses = list("人体在没有皮皮皮皮皮皮皮皮皮皮肤的情况下能存活三周。", "大腿骨连着髋髋髋髋髋髋髋髋骨。", "怎怎怎怎怎么了？", "你你你好好好好。", "别这么孩子气，肋骨会重生生生生生生的。",)

// Donation reward for shyshadow
/obj/item/toy/plush/skyrat/chunko/plushie_winrow
	name = "阴郁深沉的蜥蜴玩偶"
	desc = "一只几乎有点吓人的黑色蜥蜴玩偶，这只还配了一顶小小的贝雷帽！最好别把这两样分开。它的眼睛闪着暗示的光——不来点少女吗？"
	icon_state = "plushie_shyshadow"
	gender = MALE
	attack_verb_continuous = list("切割", "啃咬", "放电")
	attack_verb_simple = list("切割", "啃咬", "放电")
	responses = list("我是在照镜子吗？因为我看到的东西很美。", "我不只是个玩具。我是浪漫本身。", "我是钻石，而你是粗糙的原石，因为迟早……", "那张嘴就只是为了说话用的吗？", "来吧，别对我这么苛刻。我可是很软的！", "那是一杯苏格兰威士忌吗？因为我一直想着怎么把你灌醉。", "别盯着看太久。你可能会迷失在我的眼睛里。", "哇哦！看来这一带不止我一个帅哥。", "别对玩偶做那种事。我可不是巫毒娃娃。",)

// Donation reward for tobjv
/obj/item/toy/plush/skyrat/tesh
	name = "捏我特沙利"
	desc = "小丑公司“把我做成玩偶”活动优胜者！"
	icon_state = "plushie_tobjv2"

// Donation reward for tobjv
/obj/item/toy/plush/skyrat/immovable_rod
	name = "不可移动之杆"
	desc = "很逼真！但又软又弹，而且绝对不像它的正版那样危险。"
	icon_state = "plushie_tobjv"

/obj/item/toy/plush/skyrat/immovable_rod/Bump(atom/clong)
	. = ..()
	if(isliving(clong))
		playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		return

// Donation reward for gamerguy14948
/obj/item/toy/plush/skyrat/voodoo
	name = "伏都娃娃"
	desc = "一只不算小的伏都娃娃，是用剪开又缝起来的土豆袋做的。它几乎有点可爱。"
	icon_state = "plushie_gamerguy"

// Donation reward for Dudewithatude
/obj/item/toy/plush/skyrat/plushie_star
	name = "星星天使玩偶"
	desc = "已知宇宙中某位天界存在的玩偶。"
	icon_state = "plushie_star"
	gender = FEMALE
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/trills.ogg' = 1)

// Donation reward for SRQ
/obj/item/toy/plush/skyrat/plushie_chiara
	name = "有威严的狐狸玩偶"
	desc = "一只大号狐狸玩偶，翠绿的眼睛里散发着自信与活力。"
	icon_state = "plushie_chiara"

// Donation reward for Superlagg
/obj/item/toy/plush/skyrat/plushie_dan
	name = "舒适狐狸玩偶"
	desc = "一只毛绒狐狸，柔软的外表里不断渗出让人喜爱的气息。"
	icon_state = "plushie_dan"

//Donation reward for KLB100
/obj/item/toy/plush/skyrat/fox/plushie_jeanne
	name = "蒙面机器人专家玩偶"
	desc = "一只眼熟的雪白沃尔普卡宁玩偶。这只似乎戴着遮住面孔的面具。"
	icon_state = "plushie_jeanne"
	attack_verb_continuous = list("拥抱", "挤压", "脸红")
	attack_verb_simple = list("拥抱", "挤压", "脸红")

//Donation reward for Dalao Azure
/obj/item/toy/plush/skyrat/plushie_azyre
	name = "帅气厨师玩偶"
	desc = "它对烹饪的渴望，只有对狐狸尾巴的饥渴能与之相比。"
	icon_state = "plushie_azyre"

//Donation reward for Razurath
/obj/item/toy/plush/skyrat/plushie_razurath
	name = "科学鲨鱼玩偶"
	desc = "一位意志坚定的科学家，笑容里带着一丝狡黠。"
	icon_state = "plush_scishark"
	attack_verb_continuous = list("啃咬", "吞吃", "鳍拍")
	attack_verb_simple = list("啃咬", "吞吃", "鳍拍")
	squeak_override = list('sound/items/weapons/bite.ogg'=1)

//Other donation reward for Razurath
/obj/item/toy/plush/skyrat/plushie_razurath/second
	name = "矮个鲨鱼玩偶"
	desc = "尽管她个子不高，玩偶却用锐利而毫不领情的眼神打量着你；她脸上的神情，加上那件小小外套的优雅，告诉你她知道一些你不知道的事。"
	icon_state = "plushie_nedilla"

//Donation reward for October23
/obj/item/toy/plush/skyrat/plushie_elofy
	name = "笨手笨脚的狼女孩玩偶"
	desc = "一位白发狼女孩，穿着时髦的红色安保短裙。尽管那条赛博义肢看着吓人，她抱起来很软，只希望能被夸奖和安慰。"
	icon_state = "plush_lonie"
	attack_verb_continuous = list("依偎", "轻咬", "嗷呜", "甩尾拍打")
	attack_verb_simple = list("依偎", "轻咬", "嗷呜", "甩尾拍打")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)

//Donation reward for syntax1112
/obj/item/toy/plush/skyrat/plushie_syntax1112
	name = "垂耳兔玩偶"
	desc = "一只耷拉着耳朵的兔子，做成了人人可买的玩偶。内部还配有一个自动充气的吱吱响装置！"
	icon_state = "fuzz_bunny"
	attack_verb_continuous = list("轻咬", "吱吱叫", "抽鼻子", "蹬脚", "拍打")
	attack_verb_simple = list("轻咬", "吱吱叫", "抽鼻子", "蹬脚", "拍打")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

// Donation reward for SomeRandomOwl
/obj/item/toy/plush/skyrat/snow_owl
	name = "雪鸮玩偶"
	desc = "一只非常柔软的玩偶，长得像一只羽毛蓬松、女巫似的猫头鹰，据说常出没于科研部和医疗部。"
	icon_state = "plushie_owl"
	attack_verb_continuous = list("呜呜叫", "尖叫", "拥抱")
	attack_verb_simple = list("呜呜叫", "尖叫", "拥抱")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/hoot.ogg' = 1)

// Donation reward for Jolly66
/obj/item/toy/plush/skyrat/derg_plushie
	name = "无翼龙玩偶"
	desc = "一只可爱的黄绿色无翼龙玩偶！值得一提的是，它确实有一条夸张的大尾巴。 \
		还附带一顶急救员帽。"
	icon_state = "plushie_derg"
	attack_verb_continuous = list("呜咽", "轻声呜咽", "结巴")
	attack_verb_simple = list("呜咽", "轻声呜咽", "结巴")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/weh.ogg' = 1)

// Donation reward for Gofawful5
/obj/item/toy/plush/skyrat/tracy
	name = "生物玩偶"
	desc = "一只身材惊人地丰满的猫狐玩偶……它看起来很满足。"
	icon_state = "plush_tracy"
	attack_verb_continuous = list("膨胀")
	attack_verb_simple = list("膨胀")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/tracymrowr.ogg' = 1)
	gender = FEMALE

//Donation reward for Frixit
/obj/item/toy/plush/skyrat/plushie_synthia
	name = "爱冒险的合成人玩偶"
	desc = "这只玩偶非常适合在太空里和床上冒险，一只软乎乎的紫色合成人，它的围巾格外柔软！"
	icon_state = "plushie_synthia"
	attack_verb_continuous = list("脸红", "拥抱", "鞭打")
	attack_verb_simple = list("脸红", "拥抱", "鞭打")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg' = 1)

//Donation reward for Kitsun
/obj/item/toy/plush/skyrat/jecca
	name = "性感斯努德玩偶"
	desc = "不知为何，这只玩偶相当光亮，鳞片闪闪发亮，那双红宝石色的眼睛颇为诱人，眼底藏着顽皮又下流的念头。"
	icon_state = "plushie_jecca"
	attack_verb_continuous = list("叹气")
	attack_verb_simple = list("叹气")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/female/female_sigh.ogg' = 1)
	gender = FEMALE

//Donation reward for BriareosBlue
/obj/item/toy/plush/skyrat/courier_synth
	name = "信使合成人玩偶"
	desc = "这只合成人玩偶看起来随时准备把拥抱和哔声直送到你心里！标签上似乎印着一家快递公司的广告……"
	icon_state = "plushie_courier"
	attack_verb_continuous = list("投递", "做出口扫描", "嘟呜", "噗噜", "盖章")
	attack_verb_simple = list("投递", "做出口扫描", "嘟呜", "噗噜", "盖章")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg' = 1)

//Donation reward for olirant
/obj/item/toy/plush/skyrat/plush_janiborg
	name = "友好清洁半机械人玩偶"
	desc = "一款迷你全能机器人玩具，直接来自洛克斯特普企业公司市场部，采用帅气的清洁紫配色。现在还有真的喷水功能！"
	icon_state = "plush_janiborg"
	attack_verb_continuous = list("哔哔叫", "刷洗", "拖地", "喷水", "打皂")
	attack_verb_simple = list("哔哔叫", "刷洗", "拖地", "喷水", "打皂")
	squeak_override = list('sound/machines/beep/twobeep.ogg' = 1)
