/obj/item/toy/plush/attack_self(mob/user)
	. = ..()
	if(stuffed)
		if(HAS_TRAIT(user, TRAIT_MONOPHOBIA))
			to_chat(user, span_notice("你感到心里暖暖的……你不再那么孤单了。"))

	else
		if(HAS_TRAIT(user, TRAIT_MONOPHOBIA))
			to_chat(user, span_warning("你想起了，即使是缝制的伙伴，也无法阻止孤独在心中累积……"))

/obj/item/toy/plush/chaotic_toaster
	name = "混乱烤面包机"
	desc = "你不确定这只毛绒玩偶是想要拥抱，还是想摘取你的器官，或者两者都想。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "chaotic_toaster"
	attack_verb_simple = list("嘀嘀叫", "轻碰", "叮叮叫")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/Synth
	name = "合成人毛绒玩偶"
	desc = "一只可爱的毛绒玩偶，模仿了一名非常开心的合成人。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "plushie_synth"

/obj/item/toy/plush/mal0
	name = "Mal0毛绒玩偶"
	desc = "一只可爱的毛绒玩偶，看起来像是你在PDA上下载的某个东西。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "plushie_mal0"

/obj/item/toy/plush/nobl
	name = "经典蓬松斯科格毛绒玩偶"
	desc = "它似乎是一只小犬科动物，未必像你莫名猜测的那样由乳胶制成，但非常柔软。这是一款已经停产的限量版旧款毛绒玩偶。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "nobl"
	squeak_override = list('modular_zubbers/sound/misc/dog_toy.ogg' = 1)

/obj/item/toy/plush/chirp_plush
	name = "啾鸣合成人毛绒玩偶"
	desc = "摸起来暖暖的。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "chirp"//Sprited by Kan3/kaylexi
	attack_verb_continuous = list("啾鸣", "鸣响")
	attack_verb_simple = list("啾鸣")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/bigdeer
	name = "大鹿毛绒玩偶"
	desc = "一只圆滚滚的鹿毛绒玩偶。看来它在吃点心时吃了太多浆果。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "bigdeer" //sprited by Gavla
	attack_verb_simple = list("鼓起", "捂住")
	squeak_override = list('modular_zubbers/sound/misc/squeakle.ogg' = 1)
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_righthand.dmi'
	inhand_icon_state = "bigdeer"

/obj/item/toy/plush/bubbledragon
	name = "泡泡龙毛绒玩偶"
	desc = "这只威仪十足的龙毛绒玩偶似乎能清洁接触到的每个表面。抱住它时，它会吱吱叫并吹出泡泡！是TamaGoSlep睡觉时的绝佳伴侣。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "bubbledragon"
	squeak_override = list('modular_zubbers/sound/misc/squeakle.ogg' = 1)

/obj/item/toy/plush/bubbledragon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cleaner, 3 SECONDS, pre_clean_callback=CALLBACK(src, PROC_REF(should_clean)))

/obj/item/toy/plush/bubbledragon/proc/should_clean(datum/cleaning_source, atom/atom_to_clean, mob/living/cleaner)
	return (src in cleaner)

/obj/item/toy/plush/headcrab
	name = "猎头蟹毛绒玩偶"
	desc = "来自边境世界异星的小型寄生外星生物，不过这只是假货。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "headcrab"

/obj/item/toy/plush/bellybird
	name = "大肚鸟毛绒玩偶"
	desc = "背后的标签写着：‘看过歌剧了吗？带上全新的大肚鸟毛绒玩偶，准备迎接电影上映吧！羽之家专利设计结合人造羽毛、光滑鳞片、夜光眼睛和可供枕头休息的圆肚皮，让它几乎栩栩如生，更别提还附带名叫秋叶的蛇尾！这条灵活的尾巴会张嘴咬合，向对手发出逼真的嘶声，让你亲眼见识秋叶的身手。现在订购，只需分两期支付19.95！’"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "bellybird"
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/hiss.ogg' = 1)

/obj/item/toy/plush/tiredtesh
	name = "困倦特沙利毛绒玩偶"
	desc = "他看起来困极了。背后的标签写着：‘生日快乐，大个子。’"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "tiredtesh"
	squeak_override = list('modular_zubbers/sound/emotes/nose_boop.ogg' = 1)

/obj/item/toy/plush/xenoplush
	name = "异形毛绒玩偶"
	desc = "臭名昭著的异形的可爱版本。填充物呈酸绿色。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "xenoplush"
	squeak_override = list('sound/mobs/non-humanoids/hiss/hiss6.ogg' = 1)
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_righthand.dmi'
	inhand_icon_state = "xenoplush"
	attack_verb_continuous = list("嘶叫", "咬", "啃", "啃咬", "尾刺")
	attack_verb_simple = list("嘶叫", "咬", "啃", "啃咬", "尾刺")

/obj/item/toy/plush/xenoplush/xenomaidplush
	name = "异形女仆毛绒玩偶"
	desc = "臭名昭著的异形的可爱版本，还穿着女仆装。它迫不及待地想帮你打扫空间站。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "xenomaidplush"
	attack_verb_continuous = list("擦亮", "清洁", "整理", "清洗")
	attack_verb_simple = list("擦亮", "清洁", "整理", "清洗")

/obj/item/toy/plush/skyrat/jecca
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_righthand.dmi'

/obj/item/toy/plush/largeredslime
	name = "大型红色史莱姆毛绒玩偶" //Donator item exclusive for Blovy. Sprited by Casey/Keila.
	desc = "这只毛绒玩偶摸起来软乎乎的，散发着浓郁的草莓香。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "blovyplushie"
	attack_verb_continuous = list("咕噜", "黏住", "吸收")
	attack_verb_simple = list("咕噜", "黏住", "吸收")
	squeak_override = list('sound/effects/blob/blobattack.ogg' = 1)

/obj/item/toy/plush/tunafish
	name = "鱼形拍板" //Donator plush for Astroturf, sprited by Crumpaloo
	desc = "用途可不止做刺身。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "tunafish"
	attack_verb_continuous = list("拍打", "猛敲")
	attack_verb_simple = list("拍打", "猛敲")
	squeak_override = list('sound/items/weapons/slap.ogg' = 1)
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_righthand.dmi'
	inhand_icon_state = "tunafish"

/obj/item/toy/plush/secoff
	name = "银河联邦安保员毛绒玩偶"
	desc = "以一名人气年轻安保员为原型的柔软玩偶，象征银河联邦与纳米传讯的联盟。他的工作靴底写着‘安迪’。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "secoff"
	attack_verb_continuous = list("射击（却没打中）", "警棍敲打", "骚扰", "警棍殴打", "清空弹匣")
	attack_verb_simple = list("射击（却没打中）", "警棍敲打", "骚扰", "警棍殴打", "清空弹匣")
	squeak_override = list('sound/items/weapons/gun/general/bolt_rack.ogg' = 1)

/obj/item/toy/plush/cescrewsplush
	name = "螺丝总工毛绒玩偶" //Plush for Steals The Screwdriver/SteamStucKobold, sprited by stickygoat. and Amorbis
	desc = "一只可爱的蓝色蜥蜴毛绒玩偶，穿着总工程师制服和火箭靴，戴着介子护目镜。它下方有个奇怪的硅胶口袋……"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "cescrewsplush"
	attack_verb_continuous = list("拍打", "啪啪拍打", "涂抹")
	attack_verb_simple = list("拍打", "啪啪拍打", "涂抹")
	gender = FEMALE
	squeak_override = list('sound/misc/soggy.ogg'=1)

/obj/item/toy/plush/cescrewsplush/examine(mob/user)
	. = ..()
	. += span_notice("Alt点击查看她的裙底。")

/obj/item/toy/plush/cescrewsplush/click_alt(mob/user)
	user.visible_message(span_notice("[user]翻转[src]，露出下方的孔洞。"), span_notice("你翻转[src]，露出一个润滑过的紧致孔洞。"))
	playsound(user, 'sound/effects/blob/blobattack.ogg', 50, TRUE)
	var/obj/item/toy/plush/fleshlight/screws/toy = new(null)
	qdel(src)
	user.put_in_hands(toy)
	return TRUE

/obj/item/toy/plush/internshiba
	name = "柴犬实习生毛绒玩偶" //Plush for Kazumi Hasegawa/sprited by Amorbis
	desc = "一只可爱的柴犬毛绒玩偶，以一名知名的犬类实习生为原型。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "internshiba"
	attack_verb_continuous = list("轻拍", "爪拍", "爪挠")
	attack_verb_simple = list("轻拍", "爪拍", "爪挠")
	gender = MALE
	squeak_override = list('sound/mobs/non-humanoids/dog/growl2.ogg' = 1)

/obj/item/toy/plush/bottomsynf
	name = "中央指挥部合成狐毛绒玩偶"
	desc = "一只喜欢身居指挥层高位的合成狐毛绒玩偶。至少看起来如此。它穿着最喜欢的中央指挥部礼服外套。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "bottomsynf"
	attack_verb_continuous = list("电磁破解", "入侵", "狐叫")
	attack_verb_simple = list("嘀嘀叫", "轻碰", "叮叮叫", "狐叫")
	gender = MALE
	squeak_override = list('sound/machines/terminal_alert_short.ogg' = 1)

// Silly plush for kurzaen, sprited and coded by Waterpig
// Spontaneously combusts when touched by other plushies
/obj/item/toy/plush/cat_annoying
	name = "\improper 烦人猫毛绒玩偶"
	desc = "这只玩偶散发着浓烈的青苹果气味，极其讨厌肢体亲昵。你能感觉到它正用挑剔的目光盯着你……"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "annoyingcat"
	gender = MALE
	squeak_override = list(
		'modular_skyrat/modules/emotes/sound/voice/scream_m1.ogg' = 1,
		'modular_skyrat/modules/emotes/sound/voice/scream_m2.ogg' = 1,
	)

/obj/item/toy/plush/cat_annoying/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/toy/plush))
		combust()
	return ..()

/obj/item/toy/plush/cat_annoying/pre_attack(atom/A, mob/living/user, params)
	if(istype(A, /obj/item/toy/plush))
		combust()
	return ..()

/obj/item/toy/plush/cat_annoying/proc/combust()
	src.fire_act(5000)
	src.visible_message(span_notice("[src.name]因肢体亲昵而自燃了！"))
	addtimer(CALLBACK(src, PROC_REF(ash)), 2 SECONDS)

/obj/item/toy/plush/cat_annoying/proc/ash()
	new /obj/effect/decal/cleanable/ash(get_turf(src))
	src.visible_message(span_warning("[src.name]化成了灰！"))
	qdel(src)

// Plush for Vanilla
/obj/item/toy/plush/suspicious_protogen
	name = "\improper 可疑原型兽毛绒玩偶"
	desc = "一只看起来可疑的粉色原型兽毛绒玩偶，原型经常在空间站各处游荡，\
			当你因某事烦心时，最适合抱着它。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "pinkproot"
	gender = FEMALE
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/dwoop.ogg' = 1)
	var/lewd = FALSE

/obj/item/toy/plush/suspicious_protogen/Initialize(mapload)
	. = ..()
	update_plush_state()

/obj/item/toy/plush/suspicious_protogen/proc/update_plush_state()
	if(lewd)
		name = "\improper 格外可疑的原型兽毛绒玩偶"
		icon_state = "pinkproot"
		hitsound = null
	else
		name = "\improper 可疑原型兽毛绒玩偶"
		icon_state = "pinkproot"
		hitsound = initial(hitsound)
	inhand_icon_state = null
	update_appearance()
	update_inhand_icon()

/obj/item/toy/plush/suspicious_protogen/examine(mob/user)
	. = ..()
	if(lewd)
		. += span_purple("她胯部的拉链敞开着，露出玩偶内部隐藏的自慰套。")

/obj/item/toy/plush/suspicious_protogen/update_desc()
	..()
	if(lewd)
		desc = "一只看起来十分可疑的粉色原型兽毛绒玩偶，下方有个充分润滑的紧致孔洞，非常适合寻欢和解压。"
	else
		desc = "一只看起来可疑的粉色原型兽毛绒玩偶，原型经常在空间站各处游荡，当你因某事烦心时，最适合抱着它。"

/obj/item/toy/plush/suspicious_protogen/click_ctrl_shift(mob/user)
	lewd = !lewd
	if(lewd)
		user.visible_message(span_notice("[user]拉开了[src]的拉链。"), span_notice("你拉开[src]的拉链，露出玩偶内隐藏的孔洞。"))
		playsound(user, 'sound/items/zip/zip.ogg', 50, TRUE)
	else
		user.visible_message(span_notice("[user]重新拉好了[src]的拉链。"), span_notice("你拉好[src]的拉链，藏起她的秘密孔洞。"))
		playsound(user, 'sound/items/zip/zip_up.ogg', 50, TRUE)
	update_plush_state()
	return TRUE

/obj/item/toy/plush/suspicious_protogen/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(!lewd)
		return ..()
	var/obj/item/clothing/sextoy/fleshlight/proxy = new(loc)
	proxy.name = name
	proxy.desc = desc
	proxy.icon = icon
	proxy.icon_state = icon_state
	. = proxy.attack(target, user)
	playsound(user, 'modular_skyrat/modules/emotes/sound/emotes/dwoop.ogg', 50, TRUE)
	qdel(proxy)

// Plush for ZeferwasnttakenFR
/obj/item/toy/plush/foxy_plush
	name = "小淘气狐毛绒玩偶"
	desc = "一只以某位爱恶作剧的狐狸为原型的毛绒玩偶。不出所料，它闻起来也有海风和温暖锻炉的气息。\ 塑料手臂所需电池须另购！"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "FoxyPlush"
	gender = MALE
	squeak_override = list('modular_zubbers/sound/emotes/claponce1.ogg' = 1)

// Rin/Yayyay007's plush
/obj/item/toy/plush/squeaky_toy
	name = "吱吱鼠毛绒玩偶"
	desc = "以某只啮齿动物为原型定制的毛绒玩偶。闻起来像个糟糕的情人。\ 一张小贴纸写着：拉我的耳朵！"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "squeaky_toy"
	gender = MALE
	squeak_override = list('sound/mobs/non-humanoids/mouse/mousesqueek.ogg' = 1)

// Sophie/Cydia's plush
/obj/item/toy/plush/androiddog
	name = "仿生犬毛绒玩偶"
	desc = "一只褪色的仿生犬毛绒玩偶。不会咬人。\ 手上的小爱心处有张贴纸，写着‘按我！’。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "androiddog"
	gender = FEMALE
	squeak_override = list('modular_zubbers/sound/emotes/arf.ogg' = 1)

// xPokee's plush
/obj/item/toy/plush/ghoul
	name = "食尸鬼实习生毛绒玩偶"
	desc = "就连这东西的商品毛绒玩偶都极其吓人。至少抱起来很舒服……"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "johnghoul"
	attack_verb_continuous = list("食尸鬼式袭击")
	attack_verb_simple = list("食尸鬼式袭击")

// plushie for BeoTheKobold
// sprite by Cepha, code by Mitryll
/obj/item/toy/plush/mold_kobold
	name = "嗜血者认知宣传狗头人玩偶"
	desc = "一只适合拥抱的狗头人毛绒玩偶，由纳米传讯以一名嗜血者员工为原型制作；\
			焦点小组认为，与上一款‘卑劣寄生虫格罗格领主’相比，\
			这种设计较少迎合针对嗜血者的刻板印象。左腿标签写着，收益的10%将捐给血库！"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "themold"
	attack_verb_continuous = list("咬", "诅咒", "吸取")
	attack_verb_simple = list("咬", "祈咒", "爪挠")
	gender = FEMALE

// Plushie for Decinomics
/obj/item/toy/plush/sinvox
	name = "阴险沃克斯毛绒玩偶"
	desc = "一只看起来邪恶的玩偶。它的沃克斯鸟喙像昆虫口器一样裂开；\
		尾巴看起来像是从异形玩偶上粗劣仿制并缝上去的。\
		所有权及版权归沃克斯工作室所有……"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "sinvox"
	attack_verb_continuous = list("嘶叫", "咬", "撕咬", "羽刺", "尾刺")
	attack_verb_simple = list("嘶叫", "咬", "撕咬", "羽刺", "尾刺")
	gender = MALE
	squeak_override = list(
		'sound/mobs/non-humanoids/hiss/hiss2.ogg' = 1,
		'modular_skyrat/modules/emotes/sound/emotes/voxrustle.ogg' = 1,
	)

/obj/item/toy/plush/mothroach_plush
	name = "蛾蟑毛绒玩偶"
	desc = "以大家最喜爱的、从基因怪胎变为空间站宠物的生物为原型制作的玩偶。请勿泡在牛奶里再往墙上扔。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "mothroach"
	attack_verb_continuous = list("蛾蟑式扑击", "蛾扑", "蟑撞")
	attack_verb_simple = list("蛾蟑式扑击", "蛾扑", "蟑撞")
	gender = MALE
	squeak_override = list( 'sound/mobs/humanoids/moth/scream_moth.ogg' = 1, )

/obj/item/toy/plush/moth/lovers
	name = "恋人蛾人毛绒玩偶"
	desc = "一只可爱的蛾人毛绒玩偶。真是惹人喜爱的虫子！"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "moffplush_lovers"

/obj/item/toy/plush/lazy_synth
	name = "懒惰合成人毛绒玩偶"
	desc = "一只极度懒惰的合成人软绵绵玩偶。可能会在各种地方趴着偷懒。"
	attack_verb_continuous = list("挤压", "趴伏", "枕着睡", "砸蛋")
	attack_verb_simple = list("挤压", "趴伏", "枕着睡", "砸蛋")
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "lazy_synth"
	squeak_override = list('modular_zubbers/sound/misc/squeakle.ogg' = 1)

/obj/item/toy/plush/goatplushie
	name = "奇怪山羊毛绒玩偶"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "goat"
	desc = "尽管看起来很适合拥抱，而且是毛绒玩偶，它还是会照样揍你。山羊本性难移。"
	squeak_override = list('sound/items/weapons/punch1.ogg'=1)
	/// Whether or not this goat is currently taking in a monsterous doink
	var/going_hard = FALSE
	/// Whether or not this goat has been flattened like a funny pancake
	var/splat = FALSE

/obj/item/toy/plush/goatplushie/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_TURF_INDUSTRIAL_LIFT_ENTER = PROC_REF(splat),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/toy/plush/goatplushie/attackby(obj/item/cigarette/rollie/fat_dart, mob/user, list/modifiers, list/attack_modifiers)
	if(!istype(fat_dart))
		return ..()
	if(splat)
		to_chat(user, span_notice("[src]现在似乎没法尽情嗨了。"))
		return
	if(going_hard)
		to_chat(user, span_notice("[src]已经嗨过头了！"))
		return
	if(!fat_dart.lit)
		to_chat(user, span_notice("你得先把它点燃！"))
		return
	to_chat(user, span_notice("你把[fat_dart]塞进[src]嘴里。"))
	qdel(fat_dart)
	going_hard = TRUE
	update_icon(UPDATE_OVERLAYS)

/obj/item/toy/plush/goatplushie/proc/splat(datum/source)
	SIGNAL_HANDLER
	if(splat)
		return
	if(going_hard)
		going_hard = FALSE
		update_icon(UPDATE_OVERLAYS)
	icon_state = "goat_splat"
	playsound(src, SFX_DESECRATION, 50, TRUE)
	visible_message(span_danger("[src]被彻底压扁了！"))
	splat = TRUE

/obj/item/toy/plush/goatplushie/examine()
	. = ..()
	if(splat)
		. += span_notice("[src]可能需要医疗救助。")
	if(going_hard)
		. += span_notice("[src]嗨得不得了，尽管拍照吧。")

/obj/item/toy/plush/goatplushie/update_overlays()
	. = ..()
	if(going_hard)
		. += "goat_dart"

/obj/item/toy/plush/sunny_plush
	name = "加重牛鼬毛绒玩偶"
	desc = "一只柔软的加重牛鼬毛绒玩偶。抱着或让它趴在身上都很舒服。闻起来有鲜奶香。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "sunny_plush"
	squeak_override = list(
		'modular_skyrat/modules/emotes/sound/voice/moo.ogg' = 1,
		'sound/mobs/non-humanoids/stoat/stoat_sounds.ogg' = 1,
	)

//Plushie for and by Lazhannya
//Original Design by Cepha
/obj/item/toy/plush/amber_shadekin_plush
	name = "软乎乎的影裔毛绒玩偶"
	desc = "以某位自称疯狂天才的影裔为原型的毛绒玩偶。带着淡淡的肉桂香。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "amberalert"
	attack_verb_continuous = list("玛叫", "咬", "啃咬", "爪拍", "扑腾", "玛玛叫")
	attack_verb_simple = list("玛叫", "咬", "啃咬", "爪拍", "扑腾", "玛玛叫")
	gender = FEMALE
	squeak_override = list('modular_zubbers/sound/emotes/sound_voice_mar.ogg' = 1)

//Marketable Plushie of Vega VI, made by Ssalty
/obj/item/toy/plush/ethereal
	name = "以太人商人毛绒玩偶"
	desc = "一只成功以太人士的毛绒玩偶，旨在提高萌芽族及其文化的知名度，还有3%的收益将捐给慈善机构！拉动鞋带就能启动发声器，播放真实的以太人声音！"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "ethereal"
	attack_verb_continuous = list("名片拍脸", "理财教育", "威胁起诉", "电击", "滋滋叫", "嗡鸣")
	attack_verb_simple = list("名片拍脸", "理财教育", "威胁起诉", "电击", "滋滋叫", "嗡鸣")
	squeak_override = list('sound/effects/sparks/sparks1.ogg' = 98, 'sound/mobs/non-humanoids/hygienebot/cutarteries.ogg' = 1, 'sound/items/dump_it.ogg' = 1)

//Plushie for Roxy, of Cellophane
/obj/item/toy/plush/cello_plush
	var/shirt = TRUE
	name = "大得离谱的海种龙毛绒玩偶"
	desc = "一只丝般柔软的大型海种龙毛绒玩偶。抱着它时，无论怎么努力都无法用双臂将它环抱住。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_righthand.dmi'
	icon_state = "celloplush"
	inhand_icon_state = "celloplush-shirt"
	attack_verb_continuous = list("挤压", "捂住", "拍打", "欺负", "压成饼", "扑倒", "涂抹", "撞凹")
	attack_verb_simple = list("挤压", "捂住", "拍打", "欺负", "压成饼", "扑倒", "涂抹", "撞凹")
	gender = FEMALE
	squeak_override = list(
		'sound/mobs/non-humanoids/fish/fish_slap1.ogg' = 1, 'sound/mobs/non-humanoids/fish/fish_slap2.ogg' = 1,
		)

/obj/item/toy/plush/cello_plush/click_alt(mob/user)
	shirt = !shirt
	if(!shirt)
		balloon_alert(user, "肚皮露出来了……")
		icon_state = "celloplush-alt"
		inhand_icon_state = "celloplush-alt"

	else
		balloon_alert(user, "肚皮藏起来了……")
		icon_state = "celloplush"
		inhand_icon_state = "celloplush-shirt"

	update_inhand_icon()
	return ..()

//Plushie for / of MyrThel
/obj/item/toy/plush/myrthel_plush
	var/myrfire = TRUE
	light_system = COMPLEX_LIGHT
	light_range = 2
	light_power = 1.4
	light_color = COLOR_LIGHT_ORANGE
	light_on = FALSE
	name = "超火热蛾人毛绒玩偶"
	desc = "一只蛾人工程师的活动毛绒玩偶。附带适合全家欣赏的自燃功能！不可用作热源或火源。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_righthand.dmi'
	icon_state = "myrthel-plush"
	inhand_icon_state = "myrthelplush"
	attack_verb_continuous = list("拍打", "砸头", "噗击", "嗡鸣", "撞凹")
	attack_verb_simple = list("拍打", "砸头", "噗击", "嗡鸣", "撞凹")
	gender = MALE
	squeak_override = list(
		'sound/mobs/humanoids/moth/moth_death.ogg' = 3,
		'sound/mobs/humanoids/moth/moth_chitter.ogg' = 3,
		'sound/mobs/humanoids/moth/moth_flutter.ogg' = 3,
		'sound/mobs/humanoids/moth/moth_squeak.ogg' = 3,
		'sound/items/weapons/emitter.ogg' = 1,
		'sound/items/weapons/emitter2.ogg' = 1,
		'sound/effects/sparks/sparks4.ogg' = 1,
		)

/obj/item/toy/plush/myrthel_plush/click_alt(mob/user)
	myrfire = !myrfire
	if(!myrfire)
		set_light_on(TRUE)
		playsound(src, 'sound/effects/fire_puff.ogg', 20, TRUE)
		playsound(src, 'sound/mobs/humanoids/moth/scream_moth.ogg', 20, TRUE)
		icon_state = "myrthel-plush-fire"
	else
		set_light_on(FALSE)
		playsound(src, 'sound/effects/wounds/sizzle2.ogg', 10, TRUE)
		icon_state = "myrthel-plush"
	update_light()
	return ..()

// Plushie coded and sprited by Mathilde.
// Props to Seijan-Etroix for helping with the design!
/obj/item/toy/plush/tian_plush
	name = "山羊官僚毛绒玩偶"
	desc = "一只山羊鲤鱼官僚的巨型加重毛绒玩偶，似乎对文书（纸张）饥渴难耐。几乎不可能用双臂将她环抱住。<br><br><span style=color:#6685F5><i>背后的标签写着：‘经官方授权提供舒适体验。’</i></span>"
	attack_verb_continuous = list("踩踏", "捂住", "掩埋", "挤压", "轻咬", "啮咬", "压扁", "猛揍", "啃咬")
	attack_verb_simple = list("踩踏", "捂住", "掩埋", "挤压", "轻咬", "啮咬", "压扁", "猛揍", "啃咬")
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "tianplush"
	gender = FEMALE
	squeak_override = list('modular_zubbers/sound/misc/meatybaa.ogg'=1)
	var/shirt = TRUE

	var/bg_color = "#9b2e8c"
	var/static/list/folder_insertables = typecacheof(list(
		/obj/item/paper,
		/obj/item/photo,
		/obj/item/documents,
		/obj/item/paperwork,
	))

/obj/item/toy/plush/tian_plush/interact(mob/user)
	return

/obj/item/toy/plush/tian_plush/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if(.)
		return
	add_fingerprint(user)
	ui_interact(user)
	return TRUE

/obj/item/toy/plush/tian_plush/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	add_fingerprint(user)
	ui_interact(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

//Plot armour
/obj/item/toy/plush/tian_plush/attackby(obj/item/I, mob/living/user, list/modifiers, list/attack_modifiers)
	if(I.get_sharpness())
		to_chat(user, span_notice("[I]直接被弹开了！"))
		return
	return ..()

//The plushie works exactly like a folder
/obj/item/toy/plush/tian_plush/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(is_type_in_typecache(tool, folder_insertables))
		if(!user.transferItemToLoc(tool, src, silent = FALSE))
			return ITEM_INTERACT_BLOCKING
		balloon_alert(user, "啊呜！")
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/toy/plush/tian_plush/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!is_type_in_typecache(interacting_with, folder_insertables))
		return NONE
	var/obj/item/item_to_insert = interacting_with
	if(item_to_insert.loc == user)
		if(!user.transferItemToLoc(item_to_insert, src, silent = TRUE))
			return ITEM_INTERACT_BLOCKING
	else
		item_to_insert.do_pickup_animation(src)
		item_to_insert.forceMove(src)
	playsound(src, item_to_insert.pickup_sound, PICKUP_SOUND_VOLUME, item_to_insert.sound_vary, ignore_walls = FALSE)
	balloon_alert(user, "啊呜！")
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/plush/tian_plush/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Folder")
		ui.open()

/obj/item/toy/plush/tian_plush/ui_data(mob/user)
	var/list/data = list()
	data["bg_color"] = "[bg_color]"
	data["folder_name"] = "[name]"

	data["contents"] = list()
	data["contents_ref"] = list()
	for(var/Content in src)
		data["contents"] += "[Content]"
		data["contents_ref"] += "[REF(Content)]"

	return data

/obj/item/toy/plush/tian_plush/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(!IS_UNCONSCIOUS_OR_CRIT(usr) || HAS_TRAIT(usr, TRAIT_HANDS_BLOCKED))
		return

	switch(action)
		if("remove")
			var/obj/item/Item = locate(params["ref"]) in src
			if(istype(Item))
				Item.forceMove(usr.loc)
				usr.put_in_hands(Item)
				to_chat(usr, span_notice("你从[src]中取出了[Item]。"))
				. = TRUE
		if("examine")
			var/obj/item/Item = locate(params["ref"]) in src
			if(istype(Item))
				usr.examinate(Item)
				. = TRUE
//Belly
/obj/item/toy/plush/tian_plush/click_alt(mob/user)
	shirt = !shirt
	if(!shirt)
		balloon_alert(user, "肚皮露出来了……")
		icon_state = "tianplush-alt"

	else
		balloon_alert(user, "肚皮藏起来了……")
		icon_state = "tianplush"
	return ..()

// Plushling, used when plushnium reactions fail
/obj/item/toy/plush/plushling
	name = "古怪毛绒玩偶"
	desc = "一只可爱的毛绒玩偶——等等，它刚才是不是动了？"
	/// Cooldown ticks between absorbs
	var/absorb_cooldown = 100
	/// When can it absorb another plushie
	var/next_absorb = 0
	var/check_interval = 20
	var/next_check = 0

/obj/item/toy/plush/plushling/attack_self(mob/user)
	if(!user)
		return
	to_chat(user, span_warning("你想摸摸玩偶，却被它咬住手，疼得缩了回来！哎哟！"))
	var/mob/living/carbon/human/human_user = user
	if(!human_user)
		return
	human_user.add_mood_event("plush_bite", /datum/mood_event/plush_bite)
	human_user.apply_damage(5, BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
	addtimer(CALLBACK(human_user, TYPE_PROC_REF(/mob/living/carbon/human, dropItemToGround), src, TRUE), 1)

/obj/item/toy/plush/plushling/New()
	var/initial_state = pick("mothroach", "moffplush_lovers", "johnghoul")
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = initial_state
	START_PROCESSING(SSobj, src)
	return ..()

/obj/item/toy/plush/plushling/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/toy/plush/plushling/process()
	if(world.time < next_absorb || world.time < next_check)
		return
	next_check = world.time + check_interval
	var/obj/item/toy/plush/target
	for(var/obj/item/toy/plush/possible_target in loc) //First, it tries to get anything in its same location, be it a tile or a backpack
		if(possible_target == src || istype(possible_target, /obj/item/toy/plush/plushling))
			continue
		target = possible_target
		break
	if(!target)
		if(!isturf(loc))
			return
		for(var/obj/item/toy/plush/adjacent_plush in oview(1, src)) //If that doesn't work, it hunts for plushies adjacent to its own tile
			if(istype(adjacent_plush, /obj/item/toy/plush/plushling)) //These do not hunt their own kind
				continue
			src.throw_at(adjacent_plush, 1, 2)
			visible_message(span_danger("[src]扑向[adjacent_plush]！"))
			break
		return
	if(istype(target, /obj/item/toy/plush/plushling)) //These do not consume their own.
		return
	next_absorb = world.time + absorb_cooldown
	plushie_absorb(target)

/obj/item/toy/plush/plushling/proc/plushie_absorb(obj/item/toy/plush/victim)
	if(!victim)
		return
	visible_message(span_warning("[src]残忍地撕碎了[victim]，只剩下一堆粉尘！"))
	name = victim.name
	desc = victim.desc + " 等等，它刚才是不是动了……？"
	icon_state = victim.icon_state
	squeak_override = victim.squeak_override
	new /obj/effect/decal/cleanable/ash(get_turf(victim))
	qdel(victim)

/obj/item/toy/plush/plushling/love(obj/item/toy/plush/kisser, mob/living/user) //You shouldn't have come here, poor plush.
	if(!kisser)
		return
	plushie_absorb(kisser)

/obj/item/toy/plush/aeri
	name = "跨维度恐怖分子毛绒玩偶"
	desc = "以那位臭名昭著的同名人物为原型制作、极具争议的硅胶‘毛绒玩偶’。在引发猛烈的公众反对后，多数商店已将其下架，现在主要由灰色市场转售商供货。据说少数限量款还附带能用的手持轨道炮。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "aeri"
	inhand_icon_state = null
	attack_verb_continuous = list("依偎", "吱叫", "拥抱", "抚摸")
	attack_verb_simple = list("依偎", "吱叫", "拥抱", "抚摸")
	squeak_override = list(
		'modular_zubbers/sound/lewd/rubber1.ogg' = 1,
		'modular_zubbers/sound/lewd/rubber2.ogg' = 1,
		'modular_zubbers/sound/lewd/rubber3.ogg' = 1
	)
	var/clothed = TRUE

/obj/item/toy/plush/aeri/Initialize(mapload)
	. = ..()
	update_plush_state()

/obj/item/toy/plush/aeri/proc/update_plush_state()
	if(clothed)
		name = "跨维度恐怖分子毛绒玩偶"
		desc = "以那位臭名昭著的同名人物为原型制作、极具争议的硅胶‘毛绒玩偶’。在引发猛烈的公众反对后，多数商店已将其下架，现在主要由灰色市场转售商供货。据说少数限量款还附带能用的手持轨道炮。"
		icon_state = "aeri"
		//probably not necessary to put the verb and squeak override once again here but it kinda bugs out if I don't
		attack_verb_continuous = list("依偎", "吱叫", "拥抱", "抚摸")
		attack_verb_simple = list("依偎", "吱叫", "拥抱", "抚摸")
		squeak_override = list(
			'modular_zubbers/sound/lewd/rubber1.ogg' = 1,
			'modular_zubbers/sound/lewd/rubber2.ogg' = 1,
			'modular_zubbers/sound/lewd/rubber3.ogg' = 1
		)
		hitsound = initial(hitsound)
	else
		name = "跨维度恐怖分子人偶"
		desc = "脱下服装后，很难再将它称作‘毛绒玩偶’。衣物下是一层光滑、有弹性的硅胶外壳，带有纹理的孔洞和乳房，被专家形容为‘可以拿来性交’。"
		icon_state = "aeri-alt"
		attack_verb_continuous = list("依偎", "吱叫", "拥抱", "抚摸")
		attack_verb_simple = list("依偎", "吱叫", "拥抱", "抚摸")
		squeak_override = list(
			'modular_zubbers/sound/lewd/rubber1.ogg' = 1,
			'modular_zubbers/sound/lewd/rubber2.ogg' = 1,
			'modular_zubbers/sound/lewd/rubber3.ogg' = 1
		)
		hitsound = null
	inhand_icon_state = null
	update_appearance()
	update_inhand_icon()

/obj/item/toy/plush/aeri/update_desc()
	..()
	if(clothed)
		desc = "以那位臭名昭著的同名人物为原型制作、极具争议的硅胶‘毛绒玩偶’。在引发猛烈的公众反对后，多数商店已将其下架，现在主要由灰色市场转售商供货。据说少数限量款还附带能用的手持轨道炮。"
	else
		desc = "脱下服装后，很难再将它称作‘毛绒玩偶’。衣物下是一层光滑、有弹性的硅胶外壳，带有纹理的孔洞和乳房，被专家形容为‘可以拿来性交’。"

/obj/item/toy/plush/aeri/examine(mob/user)
	. = ..()
	if(clothed)
		. += span_purple("Alt点击脱下玩偶的衣服。")
	else
		. += span_purple("Alt点击为人偶重新穿好衣服。")

/obj/item/toy/plush/aeri/click_alt(mob/user)
	clothed = !clothed
	if(clothed)
		to_chat(user, span_notice("你为[src]重新穿好了衣服。"))
	else
		to_chat(user, span_notice("你脱下了[src]的衣服。"))
	playsound(user, 'modular_zubbers/sound/lewd/rubber1.ogg', 50, TRUE)
	update_plush_state()
	return TRUE

/obj/item/toy/plush/aeri/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(clothed)
		return ..()
	var/obj/item/toy/plush/fleshlight/proxy = new(loc)
	proxy.name = name
	proxy.desc = desc
	proxy.icon = icon
	proxy.icon_state = icon_state
	. = proxy.attack(target, user)
	qdel(proxy)

//If you suicide with this toy it just summons a BSA smite on you
/obj/item/toy/plush/aeri/suicide_act(mob/living/carbon/human/user)
	user.visible_message(span_suicide("[user]激怒了玩偶！天啊，它正在用蓝空间火炮锁定[user]！看来[user]想自杀！"))
	var/datum/smite/bsa/bluespace_smite = new()
	bluespace_smite.effect(user.client, user)
	return BRUTELOSS

//Sprite from SS14 Main. Sprited by Orsoniks (rivey0 on discord)
/obj/item/toy/plush/expie
	name = "实验体毛绒玩偶"
	icon_state = "expie"
	slot_flags = ITEM_SLOT_HEAD
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	worn_icon_state = "expie"
	desc = "某种犬科动物的毛绒玩偶。它渴望在地雷上被炸飞。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	attack_verb_simple = list("吠叫", "低吼", "呜咽")
	squeak_override = list('modular_zubbers/sound/misc/plushie.ogg' = 1)
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_righthand.dmi'
	inhand_icon_state = "expie"

/obj/item/toy/plush/expie/worn_overlays(mutable_appearance/standing, isinhands, icon_file) //emissive glow when worn on head.
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_BLOOM)

/obj/item/toy/plush/expie/item_interaction(mob/living/feeder, obj/item/reagent_containers/applicator/pill/enom, list/modifiers)
	if(!istype(enom))
		return ..()
	enom.forceMove(src) // pill go into the expie stummy
	to_chat(feeder, span_notice("你把[enom]喂给[src]，看着它吃了下去……"))
	playsound(src, 'modular_zubbers/sound/misc/eatcrunch.ogg', 75, TRUE)
	addtimer(CALLBACK(src, PROC_REF(eat), feeder, enom), 3 SECONDS)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/plush/expie/proc/eat(mob/living/feeder, obj/item/reagent_containers/applicator/pill/enom)
	if(istype(enom, /obj/item/reagent_containers/applicator/pill))
		SpinAnimation(speed = 0.3 SECONDS, loops = 3)
	qdel(enom)
	return

//expie reacts to being splashed
/obj/item/toy/plush/expie/proc/splash_reagents()
	SIGNAL_HANDLER
	playsound(src, 'modular_zubbers/sound/misc/dogshake.ogg', 75)
	spasm_animation(2 SECONDS)
	visible_message(span_warning("[src]被浸湿了，抖了抖身子甩掉液体！"))

/obj/item/toy/plush/expie/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_SPLASHED, PROC_REF(splash_reagents))

/datum/reagent/consumable/milk/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE) //spill milk on the expie to make it milky
	. = ..()
	if(!istype(exposed_obj, /obj/item/toy/plush/expie))
		return

	var/obj/item/toy/plush/expie/milked = exposed_obj
	milked.name = /obj/item/toy/plush/expie/milky::name
	milked.desc = /obj/item/toy/plush/expie/milky::desc
	milked.worn_icon_state = /obj/item/toy/plush/expie/milky::worn_icon_state
	milked.icon_state = /obj/item/toy/plush/expie/milky::icon_state
	milked.inhand_icon_state = /obj/item/toy/plush/expie/milky::inhand_icon_state

/obj/item/toy/plush/expie/milky
	name = "奶白毛绒玩偶"
	desc = "一只雪白毛茸茸的犬科动物玩偶。也许它会和你交换点什么？"
	worn_icon_state = "milky"
	icon_state = "milky"
	inhand_icon_state = "milky"

/obj/item/toy/plush/fox_protogen
	name = "\improper 傻气原型兽毛绒玩偶"
	desc = "一只看起来傻乎乎的狐狸原型兽玩偶，特意做得极其柔软，尾巴可以折叠，里面比外面还蓬松，似乎与可疑原型兽毛绒玩偶十分般配。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "foxproot"
	gender = FEMALE
	squeak_override = list('modular_zubbers/code/modules/emotes/sound/voice/foxgecker.ogg' = 1)

//Plush for Slicerv
/obj/item/toy/plush/tangerine
	name = "\improper 柑橘特沙利毛绒玩偶"
	desc = "一个交通锥，不，等等……这是一只披着斗篷、可爱又毛茸茸的橙色特沙利，闻起来像橘子。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "tangie" //sprited by BitSynergy
	attack_verb_simple = list("蓬松蹭", "啾鸣", "啄")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/peep_once.ogg' = 1)
	gender = MALE

/obj/item/toy/plush/tangerine/interact(mob/user)
	playsound(user, 'modular_skyrat/modules/emotes/sound/voice/trills.ogg', 50, TRUE)

// Updated plush for Noble
/obj/item/toy/plush/noble	// Updated version of item/toy/plush/nobl
	name = "\improper 医疗骷髅犬毛绒玩偶"
	desc = "一只穿着小小急救员外套的蓬松骷髅犬玩偶，身形小巧，软得不得了。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "nobl2"
	squeak_override = list('modular_zubbers/sound/misc/dog_toy.ogg' = 1)
	var/clothed = TRUE

/obj/item/toy/plush/noble/Initialize(mapload)
	. = ..()
	update_plush_state()

/obj/item/toy/plush/noble/proc/update_plush_state()
	if(clothed)
		name = "\improper 医疗骷髅犬毛绒玩偶"
		icon_state = "nobl2" //sprited by BitSynergy
		squeak_override = list('modular_zubbers/sound/misc/dog_toy.ogg' = 1)
		hitsound = initial(hitsound)
	else
		name = "\improper 蓬松骷髅犬毛绒玩偶"
		icon_state = "nobl2-alt"
		squeak_override = list('modular_zubbers/sound/misc/dog_toy.ogg' = 1)
		hitsound = null
	inhand_icon_state = null
	update_appearance()
	update_inhand_icon()

/obj/item/toy/plush/noble/examine(mob/user)
	. = ..()
	if(clothed)
		. += span_purple("Alt点击脱下这只玩偶的衣服。")
	else
		. += span_purple("Alt点击为这只玩偶重新穿好衣服。")

/obj/item/toy/plush/noble/update_desc() // update_plush_state() doesn't update the description properly but this worked for me
	..()
	if(clothed)
		desc = "一只穿着小小急救员外套的蓬松骷髅犬玩偶，身形小巧，软得不得了。"
	else
		desc = "一只小巧而蓬松的……天啊，他没穿衣服！这只光溜溜、软乎乎的骷髅犬玩偶经过改造，你注意到它下方恰好开了个孔。"

/obj/item/toy/plush/noble/click_alt(mob/user)
	clothed = !clothed
	if(clothed)
		user.visible_message(span_notice("[user]为[src]重新穿好了衣服。"), span_notice("你为[src]重新穿好了衣服。"))
		playsound(user, 'sound/items/zip/zip_up.ogg', 50, TRUE)
	else
		user.visible_message(span_notice("[user]脱下了[src]的衣服，真是有伤风化！"), span_notice("你脱下了[src]的衣服，发现玩偶下方有个紧致的孔洞……"))
		playsound(user, 'sound/items/zip/zip.ogg', 50, TRUE)
	update_plush_state()
	return TRUE

/obj/item/toy/plush/noble/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(clothed)
		return ..()
	var/obj/item/clothing/sextoy/fleshlight/proxy = new(loc)
	proxy.name = name
	proxy.desc = desc
	proxy.icon = icon
	proxy.icon_state = icon_state
	. = proxy.attack(target, user)
	playsound(user, 'modular_zubbers/sound/misc/dog_toy.ogg', 50, TRUE)
	qdel(proxy)

// Plush for Bit_Synergy
/obj/item/toy/plush/blue_synth
	name = "\improper 蓝色合成人毛绒玩偶"
	desc = "一只看起来闷闷不乐的实验型合成人玩偶，面无表情地盯着远方，有着漂亮、蓬松又发光的光纤鬃毛。\
	它被胶带粗略修补过，面罩似乎时不时会故障，但抱起来仍和以前一样舒服。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "bluesynth" //sprited by BitSynergy
	attack_verb_continuous = list("嘀嘀叫")
	attack_verb_simple = list("嘀嘀叫")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg' = 1)
	gender = MALE

/obj/item/toy/plush/blue_synth/examine(mob/user)
	. = ..()
	. += span_warning("警告标签：禁止放入微波炉")

/obj/item/toy/plush/blue_synth/microwave_act(obj/machinery/microwave/microwave_source, mob/microwaver, randomize_pixel_offset)
	..()
	microwave_source.spark()
	explosion(src, heavy_impact_range = 1, light_impact_range = 2)

/obj/item/toy/plush/protective_protogen
	name = "\improper 守护型原型兽毛绒玩偶"
	desc = "一只粉色的守护型原型兽玩偶，慷慨又富有保护欲，\
		这样的小家伙大概会一直陪在身边，安慰你，为你打气。\
		原型不在身边时，它就是你需要的情感支柱，最适合倾诉心事与烦恼，而且软得让人舍不得放手……"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "dominic_new"
	gender = MALE
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/dwoop.ogg' = 1)
	var/obj/item/inserted_item = null
	var/static/list/contained_item = list(
		/obj/item/clothing/sextoy/dildo,
	)

/obj/item/toy/plush/protective_protogen/Initialize(mapload)
	. = ..()
	if(inserted_item)
		inserted_item = new inserted_item(src)

/obj/item/toy/plush/protective_protogen/Destroy()
	if(istype(inserted_item))
		QDEL_NULL(inserted_item)
	return ..()

/obj/item/toy/plush/protective_protogen/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(.)
		return .
	if(!is_type_in_list(tool, contained_item))
		return NONE
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	else
		balloon_alert(user, "已装上[tool]")
		inserted_item = tool
		playsound(src, 'modular_zubbers/sound/lewd/rubber3.ogg', 50, TRUE)
		update_plush_state()
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/plush/protective_protogen/proc/remove_item(mob/user)
	if(inserted_item)
		balloon_alert(user, "已取下[inserted_item]")
		user.put_in_hands(inserted_item)
		inserted_item = null
		playsound(src, 'modular_zubbers/sound/lewd/rubber2.ogg', 50, TRUE)
		update_plush_state()

/obj/item/toy/plush/protective_protogen/click_alt(mob/user)
	remove_item(user)
	return CLICK_ACTION_SUCCESS

/obj/item/toy/plush/protective_protogen/proc/update_plush_state()
	if(!inserted_item)
		name = "\improper 守护型原型兽毛绒玩偶"
		icon_state = "dominic_new"
		hitsound = initial(hitsound)
	else
		icon_state = "dominic_dildo"
		hitsound = null
	inhand_icon_state = null
	update_appearance()
	update_inhand_icon()

/obj/item/toy/plush/protective_protogen/examine(mob/user)
	. = ..()
	if(!inserted_item)
		. += span_purple("你可以给这只玩偶装上假阴茎。")
	else
		. += span_purple("Alt点击取下假阴茎。")

/obj/item/toy/plush/protective_protogen/update_desc()
	..()
	if(!inserted_item)
		desc = "一只粉色的守护型原型兽玩偶，慷慨又富有保护欲，\
		这样的小家伙大概会一直陪在身边，安慰你，为你打气。\
		原型不在身边时，它就是你需要的情感支柱，最适合倾诉心事与烦恼，而且软得让人舍不得放手……"
	else
		desc = "一只粉色的守护型原型兽玩偶，慷慨又富有保护欲，\
		这样的小家伙大概会一直陪在身边，安慰你，为你打气。\
		原型不在身边时，它就是你需要的情感支柱，最适合倾诉心事与烦恼，而且软得让人舍不得放手……\
		装上的假阴茎似乎变成了青色的带结阴茎，配着一对硕大的睾丸，看起来和摸起来都过分逼真……"

/obj/item/toy/plush/protective_protogen/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(!inserted_item)
		return ..()
	var/obj/item/clothing/sextoy/dildo/proxy = new(loc)
	proxy.name = name
	proxy.desc = desc
	proxy.icon = icon
	proxy.icon_state = icon_state
	. = proxy.attack(target, user)
	playsound(user, 'modular_skyrat/modules/emotes/sound/emotes/dwoop.ogg', 50, TRUE)
	qdel(proxy)
