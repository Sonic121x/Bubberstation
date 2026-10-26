/datum/loadout_item/toys/plush/miafoxplush
	name = "银狐毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/fox/mia
	//ckeywhitelist = list("fuzlet")

/datum/loadout_item/toys/plush/teasefoxplush
	name = "撩人狐狸毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/fox/kailyn
	//ckeywhitelist = list("ratraus")

/datum/loadout_item/toys/art
	group = "美术用品"
	abstract_type = /datum/loadout_item/toys/art

/datum/loadout_item/toys/art/drawingtablet
	name = "数位板"
	item_path = /obj/item/canvas/drawingtablet
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/suit/furcoat
	name = "带毛皮的皮大衣"
	item_path = /obj/item/clothing/suit/furcoat
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/uniform/black_turtleneck
	name = "黑色高领衫"
	item_path = /obj/item/clothing/under/syndicate/tacticool/black
	// This variant has its own icon file. The skins it inherits from tacticool point at states in the
	// parent's file, so applying one breaks its sprite.
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_RESKIN
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/suit/ryddid
	name = "里迪德"
	item_path = /obj/item/clothing/suit/jacket/ryddid
	//ckeywhitelist = list("grunnyyy")

/datum/loadout_item/uniform/draculass
	name = "德古拉小姐连衣裙"
	item_path = /obj/item/clothing/under/costume/draculass
	//ckeywhitelist = list("grunnyyy", "joe_duhan")

/datum/loadout_item/neck/grunnyyycloak
	name = "黑红斗篷"
	item_path = /obj/item/clothing/neck/cloak/grunnyyy
	//ckeywhitelist = list("grunnyyy")

/datum/loadout_item/suit/rax_peacekeeper_jacket
	name = "维和者夹克"
	item_path = /obj/item/clothing/suit/armor/vest/warden/rax
	//ckeywhitelist = list("raxraus")
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/uniform/rax_banded_uniform
	name = "束带制服"
	item_path = /obj/item/clothing/under/rank/security/rax
	//ckeywhitelist = list("raxraus")
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/head/goldengoggles
	name = "蒸汽朋克护目镜"
	item_path = /obj/item/clothing/glasses/welding/steampunk_goggles
	//ckeywhitelist = list("goldenalpharex")

/datum/loadout_item/uniform/plasmaman_jax
	name = "舒拉公司生物危害内衬服"
	item_path = /obj/item/clothing/under/plasmaman/jax2
	//ckeywhitelist = list("candlejax")
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_SCIENCE_GUARD, JOB_GENETICIST)

/datum/loadout_item/head/emissionhelm
	name = "伊米申头盔"
	item_path = /obj/item/clothing/head/helmet/space/plasmaman/candlejax
	//ckeywhitelist = list("candlejax")

/datum/loadout_item/head/anahelm
	name = "阿祖莱亚环境头盔"
	item_path = /obj/item/clothing/head/helmet/space/plasmaman/candlejax2
//	ckeywhitelist = list("candlejax")

/datum/loadout_item/uniform/emissionsuit
	name = "伊米申套装"
	item_path = /obj/item/clothing/under/plasmaman/candlejax
	//ckeywhitelist = list("candlejax")

/datum/loadout_item/uniform/anasuit
	name = "阿祖莱亚环境服"
	item_path = /obj/item/clothing/under/plasmaman/candlejax2
//	ckeywhitelist = list("candlejax")

/datum/loadout_item/suit/jacket/cherno
	name = "银蓝大衣"
	item_path = /obj/item/clothing/suit/jacket/cherno
	//ckeywhitelist = list("cherno00")

/datum/loadout_item/head/avipilot
	name = "走私者飞行帽"
	item_path = /obj/item/clothing/head/avipilot
	//ckeywhitelist = list("slippyjoe")

/datum/loadout_item/uniform/britches_dress
	name = "布里奇斯连衣裙"
	item_path = /obj/item/clothing/under/rank/civilian/clown/britches
	//ckeywhitelist = list("bloodrite")
/datum/loadout_item/head/caligram_cap_tan
	name = "黑潮棕褐软帽"
	item_path = /obj/item/clothing/head/caligram_cap_tan
//	ckeywhitelist = list("farsightednightlight", "raxraus", "1ceres", "marcoalbaredaa", "itzshift_yt", "drifter7371", "AvianAviator", "Katty Kat", "Investigator77", "Dalao Azure", "Socialistion", "ChillyLobster", "Sylvara", "AmZee", "Tf4", "rb303", "Kay_Nite", "whataboutism", "taac", "Halkyon", "Lupo_di_rosa", "Merek2", "lowpowermia", "RyeanBread", "Jesterz7", "Saund_Minah", "Ruediger4")

/datum/loadout_item/uniform/caligram_fatigues_tan
	name = "黑潮棕褐作战服"
	item_path = /obj/item/clothing/under/jumpsuit/caligram_fatigues_tan
//	ckeywhitelist = list("farsightednightlight", "raxraus", "1ceres", "marcoalbaredaa", "itzshift_yt", "drifter7371", "AvianAviator", "Katty Kat", "Investigator77", "Dalao Azure", "Socialistion", "ChillyLobster", "Sylvara", "AmZee", "Tf4", "rb303", "Kay_Nite", "whataboutism", "taac", "Halkyon", "Lupo_di_rosa", "Merek2", "lowpowermia", "RyeanBread", "Jesterz7", "Saund_Minah", "Ruediger4")

/datum/loadout_item/suit/caligram_parka_tan
	name = "黑潮棕褐大衣"
	item_path = /obj/item/clothing/suit/jacket/caligram_parka_tan
//	ckeywhitelist = list("farsightednightlight", "raxraus", "1ceres", "marcoalbaredaa", "itzshift_yt", "drifter7371", "AvianAviator", "Katty Kat", "Investigator77", "Dalao Azure", "Socialistion", "ChillyLobster", "Sylvara", "AmZee", "Tf4", "rb303", "Kay_Nite", "whataboutism", "taac", "Halkyon", "Lupo_di_rosa", "Merek2", "lowpowermia", "RyeanBread", "Jesterz7", "Saund_Minah", "Ruediger4")

/datum/loadout_item/suit/caligram_parka_vest_tan
	name = "黑潮装甲大衣"
	item_path = /obj/item/clothing/suit/armor/vest/caligram_parka_vest_tan
//	ckeywhitelist = list("farsightednightlight", "raxraus", "1ceres", "marcoalbaredaa", "itzshift_yt", "drifter7371", "AvianAviator", "Katty Kat", "Investigator77", "Dalao Azure", "Socialistion", "ChillyLobster", "Sylvara", "AmZee", "Tf4", "rb303", "Kay_Nite", "whataboutism", "taac", "Halkyon", "Lupo_di_rosa", "Merek2", "lowpowermia", "RyeanBread", "Jesterz7", "Saund_Minah", "Ruediger4")
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/suit/brasspriest
	name = "黄铜祭司大衣"
	item_path = /obj/item/clothing/suit/jacket/brasspriest
//	ckeywhitelist = list("ChillyLobster")

/datum/loadout_item/suit/hydrogenrobes
	name = "金属氢长袍"
	item_path = /obj/item/clothing/suit/jacket/hydrogenrobes
//	ckeywhitelist = list("ChillyLobster")

/datum/loadout_item/suit/wetsuit_norm
	name = "合身潜水服"
	item_path = /obj/item/clothing/under/wetsuit_norm
	ckeywhitelist = list("ChillyLobster")

/datum/loadout_item/head/drake_skull
	name = "灰烬龙颅骨"
	item_path = /obj/item/clothing/head/drake_skull
	//ckeywhitelist = list("random516")

/datum/loadout_item/suit/blutigen_kimono
	name = "布卢蒂根和服"
	item_path = /obj/item/clothing/suit/blutigen_kimono
	//ckeywhitelist = list("random516")

/datum/loadout_item/uniform/blutigen_undergarment
	name = "龙形内衣"
	item_path = /obj/item/clothing/under/custom/blutigen_undergarment
	//ckeywhitelist = list("random516")

/datum/loadout_item/uniform/captain_dress
	name = "舰长礼服"
	item_path = /obj/item/clothing/under/rank/captain/dress
	//ckeywhitelist = list("netrakyram")
	restricted_roles = list(JOB_CAPTAIN)

/datum/loadout_item/uniform/netra_dress
	name = "黑银装甲连衣裙"
	item_path = /obj/item/clothing/under/rank/blueshield/netra
	//ckeywhitelist = list("netrakyram")
	restricted_roles = list(JOB_CAPTAIN, JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/neck/kiaracloak
	name = "琪亚拉的斗篷"
	item_path = /obj/item/clothing/neck/cloak/inferno
	//ckeywhitelist = list("inferno707")

/datum/loadout_item/neck/kiaracollar
	name = "琪亚拉的项圈"
	item_path = /obj/item/clothing/neck/inferno_collar
	//ckeywhitelist = list("inferno707")

/datum/loadout_item/toys/darksabre
	name = "暗黑军刀"
	item_path = /obj/item/toy/darksabre
	//ckeywhitelist = list("inferno707")

/datum/loadout_item/pocket_items/darkarmor
	name = "暗黑护甲"
	item_path = /obj/item/clothing/suit/armor/vest/darkcarapace
	//ckeywhitelist = list("inferno707")

/datum/loadout_item/neck/zuliecloak
	name = "项目：祖尔-E"
	item_path = /obj/item/clothing/suit/hooded/cloak/zuliecloak
	//ckeywhitelist = list("asky")

/datum/loadout_item/pocket_items/brightcosmos
	name = "明亮宇宙雪茄"
	item_path = /obj/item/holocigarette/cigar
	ckeywhitelist = list("lyricalpaws")

/datum/loadout_item/uniform/lannese
	name = "兰尼斯连衣裙"
	item_path = /obj/item/clothing/under/custom/lannese
	//ckeywhitelist = list("kathrinbailey")

/datum/loadout_item/uniform/lannese/vambrace
	name = "兰尼斯连衣裙（带护臂）"
	item_path = /obj/item/clothing/under/custom/lannese/vambrace
	//ckeywhitelist = list("kathrinbailey")

/datum/loadout_item/suit/scraparmour
	name = "废铁护甲"
	item_path = /obj/item/clothing/suit/scraparmour
	//ckeywhitelist = list("hackertdog")

/datum/loadout_item/uniform/mechanic
	name = "机械师工装裤"
	item_path = /obj/item/clothing/under/misc/skyrat/mechanic
	//ckeywhitelist = list("cypressb")

/datum/loadout_item/uniform/mikubikini
	name = "星光歌手比基尼"
	item_path = /obj/item/clothing/under/mikubikini
	//ckeywhitelist = list("grandvegeta")

/datum/loadout_item/suit/mikujacket
	name = "星光歌手夹克"
	item_path = /obj/item/clothing/suit/mikujacket
	//ckeywhitelist = list("grandvegeta")

/datum/loadout_item/head/mikuhair
	name = "星光歌手发型"
	item_path = /obj/item/clothing/head/mikuhair
	//ckeywhitelist = list("grandvegeta")

/datum/loadout_item/suit/delta_coat
	name = "灰色冬季连帽衫"
	item_path = /obj/item/clothing/suit/jacket/delta
	//ckeywhitelist = list("deltatri")

/datum/loadout_item/head/hubertcc
	name = "中央指挥部少尉帽"
	item_path = /obj/item/clothing/head/nanotrasen_consultant/hubert
	//ckeywhitelist = list("hackertdog")
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/suit/hubertcc
	name = "中央指挥部少尉装甲背心"
	item_path = /obj/item/clothing/suit/armor/vest/nanotrasen_consultant/hubert
	//ckeywhitelist = list("hackertdog")
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/uniform/hubertcc
	name = "中央指挥部少尉制服"
	item_path = /obj/item/clothing/under/rank/nanotrasen_consultant/hubert
	//ckeywhitelist = list("hackertdog")
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/head/frostyushanka
	name = "蓝色护耳帽"
	item_path = /obj/item/clothing/head/costume/ushanka/frosty
	//ckeywhitelist = list("cherno00")

/datum/loadout_item/neck/silvercross
	name = "银色十字架"
	item_path = /obj/item/clothing/neck/cross
	//ckeywhitelist = list("m97screwsyourparents")

/datum/loadout_item/suit/occult_coat
	name = "神秘学收藏家大衣"
	item_path = /obj/item/clothing/suit/hooded/occult
	//ckeywhitelist = list("gamerguy14948")

/datum/loadout_item/uniform/occult_outfit
	name = "神秘学收藏家套装"
	item_path = /obj/item/clothing/under/occult
	//ckeywhitelist = list("gamerguy14948")

/datum/loadout_item/toys/plush/voodooplush
	name = "巫毒娃娃"
	item_path = /obj/item/toy/plush/skyrat/voodoo
	//ckeywhitelist = list("gamerguy14948")

/datum/loadout_item/pocket_items/fuzzy_huglicense
	name = "拥抱许可证"
	item_path = /obj/item/card/fuzzy_license
	//ckeywhitelist = list("fuzlet")

/datum/loadout_item/suit/gorlex_harness
	name = "引擎技术员背带"
	item_path = /obj/item/clothing/suit/jacket/gorlex_harness
	//ckeywhitelist = list("1ceres")

/datum/loadout_item/pocket_items/korpstech_poster
	name = "Korpstech 海报"
	item_path = /obj/item/poster/korpstech
	//ckeywhitelist = list("1ceres")

/datum/loadout_item/suit/tenrai_coat
	name = "天雷大衣"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/tenrai
	//ckeywhitelist = list("cimika")

/datum/loadout_item/neck/fluffycloak
	name = "蓬松斗篷"
	item_path = /obj/item/clothing/neck/cloak/fluffycloak
	//ckeywhitelist = list("realwinterfrost")

/datum/loadout_item/toys/plush/zappplush
	name = "小扎普毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/zapp
	donator_only = TRUE

/datum/loadout_item/pocket_items/tacticalbrush
	name = "战术发刷"
	item_path = /obj/item/hairbrush/tactical
	//ckeywhitelist = list("weredoggo")

/datum/loadout_item/neck/fishpendant
	name = "鱼形吊坠"
	item_path = /obj/item/clothing/neck/fishpendant
	//ckeywhitelist = list("cimika")

/datum/loadout_item/toys/plush/immovable_rod_plush
	name = "不可移动之杆毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/immovable_rod
	//ckeywhitelist = list("tobjv")

/datum/loadout_item/toys/plush/tesh_plush
	name = "捏特沙毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/tesh
	//ckeywhitelist = list("tobjv")

/datum/loadout_item/uniform/redhosneck
	name = "黑红高领衫"
	item_path = /obj/item/clothing/under/rank/security/head_of_security/alt/roselia
	//ckeywhitelist = list("ultimarifox")
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/toys/plush/roselia_plush
	name = "低俗瑟格尔毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/roselia
	//ckeywhitelist = list("ultimarifox")

/datum/loadout_item/toys/plush/plushe_winrow
	name = "阴郁蜥蜴毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/chunko/plushie_winrow

/datum/loadout_item/toys/plush/plushie_star
	name = "星辰天使毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/plushie_star

/datum/loadout_item/suit/rainbowcoat
	name = "彩虹大衣"
	item_path = /obj/item/clothing/suit/toggle/rainbowcoat
	//ckeywhitelist = list("dudewithatude")

/datum/loadout_item/head/recruiter_cap
	name = "招募官帽"
	item_path = /obj/item/clothing/head/recruiter_cap
	//ckeywhitelist = list("m97screwsyourparents")

/datum/loadout_item/suit/recruiter_jacket
	name = "招募官夹克"
	item_path = /obj/item/clothing/suit/toggle/recruiter_jacket
	//ckeywhitelist = list("m97screwsyourparents")

/datum/loadout_item/uniform/recruiter_uniform
	name = "招募官制服"
	item_path = /obj/item/clothing/under/recruiter_uniform
	//ckeywhitelist = list("m97screwsyourparents")

/datum/loadout_item/pocket_items/hypno_watch
	name = "怀表"
	item_path = /obj/item/clothing/accessory/hypno_watch
	ckeywhitelist = list("slippyjoe")

/datum/loadout_item/uniform/nt_idol
	name = "纳米传讯偶像短裙"
	item_path = /obj/item/clothing/under/nt_idol_skirt
	//ckeywhitelist = list("tetrako")
	restricted_roles = list(JOB_NT_REP)

//Chunko Fops were donated by SlippyJoe, who requested they are usable by everyone

/datum/loadout_item/toys/plush/CFBonnie
	name = "胖绅士：蓝兔毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/chunko/bonnie
//	donator_only = TRUE

/datum/loadout_item/toys/plush/CFAndrew
	name = "胖绅士：绿兔毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/chunko/andrew
//	donator_only = TRUE

/datum/loadout_item/toys/plush/CFInessa
	name = "胖绅士：医疗熊毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/chunko/inessa
//	donator_only = TRUE

/datum/loadout_item/toys/plush/plushie_chiara
	name = "指挥者狐狸毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/plushie_chiara
	//ckeywhitelist = list("srq", "superlagg")

/datum/loadout_item/toys/plush/plushie_dan
	name = "舒适狐狸毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/plushie_dan
	//ckeywhitelist = list("srq", "superlagg")

/datum/loadout_item/uniform/bubbly_clown
	name = "活泼小丑连衣裙"
	item_path = /obj/item/clothing/under/bubbly_clown/skirt
	restricted_roles = list(JOB_CLOWN)
	//ckeywhitelist = list("boisterousbeebz", "aether217")

/datum/loadout_item/pocket_items/marsoc_coin
	name = "MARSOC 挑战币"
	item_path = /obj/item/coin/donator/marsoc
	//ckeywhitelist = list("sweetsoulbrother")

/datum/loadout_item/toys/plush/plushie_jeanne
	name = "蒙面机器人学家毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/fox/plushie_jeanne
	//ckeywhitelist = list("klb100") // Asked it to be public.

/datum/loadout_item/uniform/tactichill
	name = "战术休闲夹克"
	item_path = /obj/item/clothing/under/tactichill
	//ckeywhitelist = list("kaynite")

/datum/loadout_item/suit/techpriest
	name = "科技祭司长袍"
	item_path = /obj/item/clothing/suit/hooded/techpriest
	//ckeywhitelist = list("imthinkingarbys")

/datum/loadout_item/toys/plush/plushie_azyre
	name = "英俊厨师毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/plushie_azyre
	//ckeywhitelist = list("dalaoazure")

/datum/loadout_item/pocket_items/khicigs
	name = "橘花奇点香烟"
	item_path = /obj/item/storage/fancy/cigarettes/khi
	//ckeywhitelist = list("ultimarifox")

/datum/loadout_item/uniform/bimpcap
	name = "哑光黑舰长礼服"
	item_path = /obj/item/clothing/under/bimpcap
	restricted_roles = list(JOB_CAPTAIN)
	//ckeywhitelist = list("razurath")

/datum/loadout_item/toys/plush/plushie_razurath
	name = "科研鲨鱼毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/plushie_razurath
	//ckeywhitelist = list("razurath")

/datum/loadout_item/toys/plush/plushie_razurath/second
	name = "矮鲨毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/plushie_razurath/second
//	ckeywhitelist = list("razurath")

/datum/loadout_item/toys/plush/plushie_elofy
	name = "笨拙狼女毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/plushie_elofy
	//ckeywhitelist = list("october23") // Asked it to be public.

/datum/loadout_item/suit/elofy
	name = "太阳上将大衣"
	item_path = /obj/item/clothing/suit/armor/hos/elofy
//	ckeywhitelist = list("october23")
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/head/elofy
	name = "太阳上将帽"
	item_path = /obj/item/clothing/head/hats/hos/elofy
	ckeywhitelist = list("october23")
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/pocket_items/transponder
	name = "损坏的赫利安应答器"
	item_path = /obj/item/donator/transponder
//	ckeywhitelist = list("glacii")

/datum/loadout_item/uniform/caged_dress
	name = "笼式紫色连衣裙"
	item_path = /obj/item/clothing/under/caged_dress/skirt
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/suit/shortcoat
	name = "短款紫色大衣"
	item_path = /obj/item/clothing/suit/short_coat
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/neck/flowercollar
	name = "花朵项圈"
	item_path = /obj/item/clothing/neck/flower_collar
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/uniform/goldenkimono
	name = "短袖和服"
	item_path = /obj/item/clothing/under/costume/skyrat/kimono/sigmar
	//ckeywhitelist = list("sigmaralkahest")

/datum/loadout_item/suit/blackraincoat
	name = "黑色开脸雨衣"
	item_path = /obj/item/clothing/suit/hooded/sigmarcoat
	//ckeywhitelist = list("sigmaralkahest")

/datum/loadout_item/toys/plush/plushy_syntax1112
	name = "垂耳兔毛绒玩具"
	item_path = /obj/item/toy/plush/skyrat/plushie_syntax1112
	//ckeywhitelist = list("syntax1112")

/datum/loadout_item/head/somerandomowl
	name = "星空女巫帽"
	item_path = /obj/item/clothing/head/costume/strigihat
	//ckeywhitelist = list("somerandomowl")

/datum/loadout_item/head/razurathhat
	name = "金色纳米传讯军官帽"
	item_path = /obj/item/clothing/head/razurathhat
	//ckeywhitelist = list("razurath")

/datum/loadout_item/suit/razurathcoat
	name = "金色纳米传讯军官大衣"
	item_path = /obj/item/clothing/suit/razurathcoat
	//ckeywhitelist = list("razurath")

/datum/loadout_item/suit/digicoat_glitched
	name = "故障数码大衣"
	item_path = /obj/item/clothing/suit/toggle/digicoat/glitched
	//ckeywhitelist = list("razurath")

/datum/loadout_item/pocket_items/masvedishcigar
	name = "全息雪茄"
	item_path = /obj/item/holocigarette/masvedishcigar
	// Asked it to be public, and as such has no whitelist.

/datum/loadout_item/suit/lt3_armor
	name = "银色夹克 Mk II"
	item_path = /obj/item/clothing/suit/armor/skyy
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_NT_REP)

/datum/loadout_item/suit/lt3_jacket
	name = "银色夹克"
	item_path = /obj/item/clothing/suit/jacket/skyy

/datum/loadout_item/uniform/miscellaneous/lt3_jeans
	name = "银色牛仔裤"
	item_path = /obj/item/clothing/under/pants/skyy

/datum/loadout_item/toys/switchcomb
	name = "弹簧刀梳"
	item_path = /obj/item/hairbrush/switchblade
	//ckeywhitelist = list("stonetear")

/datum/loadout_item/suit/colorblockhoodie
	name = "撞色连帽衫"
	item_path = /obj/item/clothing/suit/hooded/colorblockhoodie
//	ckeywhitelist = list("lolpopomg101")

/datum/loadout_item/inhand/officialcat
	name = "官方猫咪印章"
	item_path = /obj/item/stamp/cat
//	ckeywhitelist = list("kathrinbailey")

/datum/loadout_item/inhand/hardlight_wheelchair
	name = "硬光轮椅投影器"
	item_path = /obj/item/holosign_creator/hardlight_wheelchair
//	ckeywhitelist = list("sqnztb")

/datum/loadout_item/uniform/noble_gambeson
	name = "贵族武装衣"
	item_path = /obj/item/clothing/under/rank/civilian/chaplain/divine_archer/noble
//	ckeywhitelist = list("grasshand")

/datum/loadout_item/suit/nobility_dresscoat
	name = "贵族礼服大衣"
	item_path = /obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator
//	ckeywhitelist = list("nikotheguydude")

/datum/loadout_item/head/anubite_headpiece
	name = "阿努比斯头饰"
	item_path = /obj/item/clothing/head/anubite
	//ckeywhitelist = list("vexcint")

/datum/loadout_item/uniform/formal/dragon_maid
	name = "龙女仆制服"
	item_path = /obj/item/clothing/under/costume/dragon_maid
	//ckeywhitelist = list("sigmaralkahest")

/datum/loadout_item/head/catear_headphone
	name = "猫耳耳机"
	item_path = /obj/item/instrument/piano_synth/headphones/catear_headphone
	//ckeywhitelist = list("dtfe")

/datum/loadout_item/uniform/old_qm_jumpskirt
	name = "旧款货运主管连体裙"
	item_path = /obj/item/clothing/under/rank/cargo/qm/skirt/old
//	ckeywhitelist = list("jasohavents")

/datum/loadout_item/pocket_items/toaster_implant
	name = "烤面包机植入体"
	item_path = /obj/item/implanter/toaster
//	ckeywhitelist = list("jasohavents")
