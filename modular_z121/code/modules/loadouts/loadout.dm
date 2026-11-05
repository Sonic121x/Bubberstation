/*
/datum/loadout_item/pocket_items/chicken
	name = "鸡儿枪"
	item_path = /obj/item/pneumatic_cannon/pie/egg
	ckeywhitelist = list("Chicken")

#define LOADOUT_SUBCATEGORY_BACKPACK_COIN 	"Coin"

/datum/loadout_item/pocket_items/coin
	category = LOADOUT_SUBCATEGORY_BACKPACK_COIN

/datum/loadout_item/pocket_items/coin/iron
	name = "钢铁纪念币"
	item_path = /obj/item/coin/comm/iron

/datum/loadout_item/pocket_items/coin/gold
	name = "黄金纪念币"
	item_path = /obj/item/coin/comm/gold

/datum/loadout_item/pocket_items/coin/silver
	name = "白银纪念币"
	item_path = /obj/item/coin/comm/silver

/datum/loadout_item/pocket_items/coin/diamond
	name = "钻石纪念币"
	item_path = /obj/item/coin/comm/diamond

/datum/loadout_item/pocket_items/coin/plasma
	name = "离紫纪念币"
	item_path = /obj/item/coin/comm/plasma

/datum/loadout_item/pocket_items/coin/uranium
	name = "绿铀纪念币"
	item_path = /obj/item/coin/comm/uranium

/datum/loadout_item/pocket_items/coin/bananium
	name = "香蕉纪念币"
	item_path = /obj/item/coin/comm/bananium

/datum/loadout_item/pocket_items/coin/adamantine
	name = "精金纪念币"
	item_path = /obj/item/coin/comm/adamantine

/datum/loadout_item/pocket_items/coin/mythril
	name = "秘银纪念币"
	item_path = /obj/item/coin/comm/mythril

/datum/loadout_item/neck/hos
	name = "head of security's fancy cloak"
	path = /obj/item/clothing/neck/cloak/hos/cit
	restricted_roles = list("Head of Security")

/datum/loadout_item/neck/qm
	name = "quartermaster's fancy cloak"
	path = /obj/item/clothing/neck/cloak/qm/cit
	restricted_roles = list("Quartermaster")

/datum/loadout_item/neck/cmo
	name = "chief medical officer's fancy cloak"
	path = /obj/item/clothing/neck/cloak/cmo/cit
	restricted_roles = list("Chief Medical Officer")

/datum/loadout_item/neck/ce
	name = "chief engineer's fancy cloak"
	path = /obj/item/clothing/neck/cloak/ce/cit
	restricted_roles = list("Chief Engineer")

/datum/loadout_item/neck/rd
	name = "research director's fancy cloak"
	path = /obj/item/clothing/neck/cloak/rd/cit
	restricted_roles = list("Research Director")

/datum/loadout_item/neck/cap
	name = "captain's fancy cloak"
	path = /obj/item/clothing/neck/cloak/cap/cit
	restricted_roles = list("Captain")
*/
/datum/loadout_item/head/ran
	name = "御神帽"
	item_path = /obj/item/clothing/head/ran

/datum/loadout_item/suit/ran
	name = "御神装"
	item_path = /obj/item/clothing/suit/ran

/datum/loadout_item/head/shrine
	name = "巫女假发"
	item_path = /obj/item/clothing/head/costume/shrine_wig

/datum/loadout_item/suit/shrine
	name = "巫女服"
	item_path = /obj/item/clothing/suit/costume/shrine_maiden

/datum/loadout_item/inhand/gohei
	name = "御币"
	item_path = /obj/item/gohei

/datum/loadout_item/uniform/jumpsuit/capfemformal
	name = "舰长女士礼服"
	item_path = /obj/item/clothing/under/rank/captain/femformal
	restricted_roles = list("Captain")
/*
/datum/loadout_item/pocket_items/greenpride
	name = "掉色绿徽章"
	item_path = /obj/item/clothing/accessory/green_pin_fake
*/
/datum/loadout_item/pocket_items/donatepet
	name = "宠物召唤信标"
	item_path = /obj/item/summon_beacon/donatepet/hamster
	donator_only = TRUE
	ckeywhitelist = list("Lamian")

/datum/loadout_item/pocket_items/wallet/tailbag
	name = "尾包"
	item_path = /obj/item/storage/wallet/tailbag

/datum/loadout_item/toys/lanxueplush
	name = "外星小龙玩偶"
	item_path =/obj/item/toy/plush/skyrat/lanxue
	//ckeywhitelist = list("lanxue")

/datum/loadout_item/weapons/multifunction_gun
	name = "多功能枪械（基础形态）"
	group = "多功能装备"
	item_path = /obj/item/gun/energy/cell_loaded/multifunction
	ckeywhitelist = list("lanxue")

/datum/loadout_item/toys/chen
	name = "橙Fumo"
	item_path =/obj/item/toy/plush/skyrat/chen

/datum/loadout_item/toys/lemonavali
	name = "柠檬小鸟玩偶"
	item_path =/obj/item/toy/plush/skyrat/lemonavali

/datum/loadout_item/toys/oreocat
	name = "奥利奥猫玩偶"
	item_path =/obj/item/toy/plush/skyrat/oreocat

/datum/loadout_item/toys/tianshen
	name = "合成龙人毛绒玩偶"
	item_path =/obj/item/toy/plush/skyrat/tianshen

/datum/loadout_item/toys/hornet
	name = "漫游猎手玩偶"
	item_path =/obj/item/toy/plush/skyrat/hornet

/datum/loadout_item/toys/lancaster
	name = "狐狸海军军娘玩偶"
	item_path =/obj/item/toy/plush/skyrat/lancaster

/datum/loadout_item/toys/histoire
	name = "伊丝特娲儿玩偶"
	item_path =/obj/item/toy/plush/skyrat/histoire

/datum/loadout_item/toys/ydeer
	name = "Y鹿玩偶"
	item_path =/obj/item/toy/plush/skyrat/ydeer
	ckeywhitelist = list("YelmakTheDeer", "Nakoneko_uwu", "KZXZB", "Sonic121x", "Yuusatsuki", "pumpkin_pillow")

/datum/loadout_item/toys/pumpkindog
	name = "南瓜狗抱枕"
	item_path =/obj/item/toy/plush/skyrat/pumpkindog
	ckeywhitelist = list("pumpkin_pillow")

/datum/loadout_item/toys/safetydove
	name = "安全鸽玩偶"
	item_path =/obj/item/toy/plush/skyrat/safetydove
	ckeywhitelist = list("Sarcoma_is_cum")

/datum/loadout_item/toys/mary
	name = "以什玛丽玩偶"
	item_path =/obj/item/toy/plush/skyrat/mary

/datum/loadout_item/toys/nannan
	name = "楠楠玩偶"
	item_path =/obj/item/toy/plush/nannan

/datum/loadout_item/toys/fumomarisa
	name = "魔理沙Fumo"
	item_path =/obj/item/toy/plush/skyrat/fumo

/datum/loadout_item/toys/fumoastolfo
	name = "阿斯托尔福fumo"
	item_path = /obj/item/toy/plush/skyrat/fumo/astolfo

/datum/loadout_item/toys/fumocirno
	name = "琪露诺Fumo"
	item_path = /obj/item/toy/plush/skyrat/fumo/cirno

/datum/loadout_item/toys/fumobocchi
	name = "波奇Fumo"
	item_path =/obj/item/toy/plush/skyrat/fumo/bocchi

/datum/loadout_item/head/magiprotector
	name = "守护巫师帽"
	item_path =/obj/item/clothing/head/wizard/marisa/magiprotector/fake

/datum/loadout_item/suit/magiprotector
	name = "守护巫师连身服"
	item_path =/obj/item/clothing/suit/wizrobe/marisa/magiprotector/fake

/datum/loadout_item/gloves/magiprotector
	name = "守护巫师手套"
	item_path =/obj/item/clothing/gloves/magiprotector

/datum/loadout_item/shoes/magiprotector
	name = "守护巫师靴子"
	item_path =/obj/item/clothing/shoes/jackboots/magiprotector
/*
//兔耳头带
/datum/loadout_item/head/playbunnyearsgreyscale
	name = "可染色兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/greyscale

/datum/loadout_item/head/playbunnyearssyndicate
	name = "伪辛迪加兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/syndicate

/datum/loadout_item/head/playbunnyearscentcom
	name = "Centcom兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/centcom
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/head/playbunnyearsbritish
	name = "英式兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/british

/datum/loadout_item/head/playbunnyearscommunist
	name = "红色兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/communist

/datum/loadout_item/head/playbunnyearsusa
	name = "美式兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/usa

/datum/loadout_item/head/playbunnyearsbunnyears_captain
	name = "舰长兔耳头带"
	item_path = /obj/item/clothing/head/hats/caphat/bunnyears_captain
	restricted_roles = list(JOB_CAPTAIN)

/datum/loadout_item/head/playbunnyearsquartermaster
	name = "军需官兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/quartermaster
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/head/playbunnyearscargo
	name = "货仓兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/cargo

/datum/loadout_item/head/playbunnyearsminer
	name = "矿工兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/miner

/datum/loadout_item/head/playbunnyearsmailman
	name = "邮差兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/mailman

/datum/loadout_item/head/playbunnyearsbitrunner
	name = "潜网员兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/bitrunner

/datum/loadout_item/head/playbunnyearsengineer
	name = "工程师兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/engineer

/datum/loadout_item/head/playbunnyearsatmos_tech
	name = "大气技术员兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/atmos_tech

/datum/loadout_item/head/playbunnyearsce
	name = "工程部长兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/ce
	restricted_roles = list(JOB_CHIEF_ENGINEER)

/datum/loadout_item/head/playbunnyearsdoctor
	name = "医生兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/doctor

/datum/loadout_item/head/playbunnyearsparamedic
	name = "急救员兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/paramedic

/datum/loadout_item/head/playbunnyearschemist
	name = "化学家兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/chemist

/datum/loadout_item/head/playbunnyearspathologist
	name = "病毒学家兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/pathologist

/datum/loadout_item/head/playbunnyearscoroner
	name = "验尸官兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/coroner

/datum/loadout_item/head/playbunnyearscmo
	name = "医疗部长兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/cmo
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/head/playbunnyearsscientist
	name = "科学家兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/scientist

/datum/loadout_item/head/playbunnyearsroboticist
	name = "机械学家兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/roboticist

/datum/loadout_item/head/playbunnyearsgeneticist
	name = "基因学家兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/geneticist

/datum/loadout_item/head/playbunnyearsrd
	name = "科研部长兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/rd
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/head/playbunnyearssecurity
	name = "安保兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/head/playbunnyearssecurity/assistant
	name = "安保助手兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/security/assistant
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/head/playbunnyearswarden
	name = "典狱长兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/warden
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/head/playbunnyearsbrig_phys
	name = "监狱医师兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/brig_phys
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/head/playbunnyearsdetective
	name = "侦探兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/detective
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/head/playbunnyearsdetective/noir
	name = "黑色侦探兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/detective/noir
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/head/playbunnyearsprisoner
	name = "囚犯兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/prisoner

/datum/loadout_item/head/playbunnyearshos
	name = "安保部长兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/hos
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/head/playbunnyearshop
	name = "人事部长兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/hop
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL)

/datum/loadout_item/head/playbunnyearsjanitor
	name = "清洁工兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/janitor

/datum/loadout_item/head/playbunnyearsbartender
	name = "酒保兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/bartender

/datum/loadout_item/head/playbunnyearscook
	name = "厨师兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/cook

/datum/loadout_item/head/playbunnyearsbotanist
	name = "植物学家兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/botanist

/datum/loadout_item/head/playbunnyearsclown
	name = "小丑兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/clown
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/head/playbunnyearsmime
	name = "默剧兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/mime
	restricted_roles = list(JOB_MIME)

/datum/loadout_item/head/playbunnyearschaplain
	name = "牧师兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/chaplain

/datum/loadout_item/head/playbunnyearscurator_red
	name = "红色策展人兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/curator_red

/datum/loadout_item/head/playbunnyearscurator_green
	name = "绿色策展人兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/curator_green

/datum/loadout_item/head/playbunnyearscurator_teal
	name = "青绿策展人兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/curator_teal

/datum/loadout_item/head/playbunnyearslawyer_black
	name = "黑色律师兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/lawyer_black

/datum/loadout_item/head/playbunnyearslawyer_blue
	name = "蓝色律师兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/lawyer_blue

/datum/loadout_item/head/playbunnyearslawyer_red
	name = "红色律师兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/lawyer_red

/datum/loadout_item/head/playbunnyearslawyer_good
	name = "正义律师兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/lawyer_good

/datum/loadout_item/head/playbunnyearspsychologist
	name = "心理学家兔耳头带"
	item_path = /obj/item/clothing/head/playbunnyears/psychologist

//领圈

/datum/loadout_item/neck/bunnytiegreyscale
	name = "可染色领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/greyscale

/datum/loadout_item/neck/bunnytiesyndicate
	name = "伪辛迪加领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/syndicate

/datum/loadout_item/neck/bunnytiemagician
	name = "魔术师领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/magician

/datum/loadout_item/neck/bunnytiecentcom
	name = "Centcom领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/centcom
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/neck/bunnytiecommunist
	name = "红色领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/communist

/datum/loadout_item/neck/bunnytieblue
	name = "蓝色领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/blue

/datum/loadout_item/neck/bunnytiebunnyears_captain
	name = "舰长领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/captain
	restricted_roles = list(JOB_CAPTAIN)

/datum/loadout_item/neck/bunnytiecargo
	name = "货仓领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/cargo

/datum/loadout_item/neck/bunnytieminer
	name = "矿工领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/miner

/datum/loadout_item/neck/bunnytiemailman
	name = "邮差领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/mailman

/datum/loadout_item/neck/bunnytiebitrunner
	name = "潜网员领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/bitrunner

/datum/loadout_item/neck/bunnytieengineer
	name = "工程师领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/engineer

/datum/loadout_item/neck/bunnytieatmos_tech
	name = "大气技术员领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/atmos_tech

/datum/loadout_item/neck/bunnytiece
	name = "工程部长领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/ce
	restricted_roles = list(JOB_CHIEF_ENGINEER)

/datum/loadout_item/neck/bunnytiedoctor
	name = "医生领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/doctor

/datum/loadout_item/neck/bunnytieparamedic
	name = "急救员领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/paramedic

/datum/loadout_item/neck/bunnytiechemist
	name = "化学家领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/chemist

/datum/loadout_item/neck/bunnytiepathologist
	name = "病毒学家领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/pathologist

/datum/loadout_item/neck/bunnytiecoroner
	name = "验尸官领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/coroner

/datum/loadout_item/neck/bunnytiecmo
	name = "医疗部长领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/cmo
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/neck/bunnytiescientist
	name = "科学家领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/scientist

/datum/loadout_item/neck/bunnytieroboticist
	name = "机械学家领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/roboticist

/datum/loadout_item/neck/bunnytie/geneticist
	name = "基因学家领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/geneticist

/datum/loadout_item/neck/bunnytierd
	name = "科研部长领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/rd
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/neck/bunnytiesecurity
	name = "安保领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/neck/bunnytiesecurity/assistant
	name = "安保助手领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/security_assistant
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/neck/bunnytiebrig_phys
	name = "监狱医师领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/brig_phys
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/neck/bunnytiedetective
	name = "侦探领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/detective
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/neck/bunnytieprisoner
	name = "囚犯领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/prisoner

/datum/loadout_item/neck/bunnytiehop
	name = "人事部长领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/hop
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL)

/datum/loadout_item/neck/bunnytiejanitor
	name = "清洁工领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/janitor

/datum/loadout_item/neck/bunnytiebartender
	name = "酒保领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/bartender

/datum/loadout_item/neck/bunnytiecook
	name = "厨师领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/cook

/datum/loadout_item/neck/bunnytiebotanist
	name = "植物学家领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/botanist

/datum/loadout_item/neck/bunnytieclown
	name = "小丑领圈"
	item_path = /obj/item/clothing/neck/bunny/clown
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/neck/bunnytiechaplain
	name = "兔子牧师坠饰"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/lawyer_black

/datum/loadout_item/neck/bunnytielawyer_black
	name = "黑色律师领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/lawyer_black

/datum/loadout_item/neck/bunnytielawyer_blue
	name = "蓝色律师领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/lawyer_blue

/datum/loadout_item/neck/bunnytielawyer_red
	name = "红色律师领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/lawyer_red

/datum/loadout_item/neck/bunnytielawyer_good
	name = "正义律师领圈"
	item_path = /obj/item/clothing/neck/bunny/bunnytie/lawyer_good

//燕尾服

/datum/loadout_item/suit/tailcoatgreyscale
	name = "可染色燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/greyscale

/datum/loadout_item/suit/tailcoatsyndicate
	name = "伪辛迪加燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/syndicate

/datum/loadout_item/suit/tailcoatmagician
	name = "魔术师燕尾服"
	item_path = /obj/item/clothing/suit/wizrobe/magician

/datum/loadout_item/suit/tailcoatcentcom
	name = "Centcom燕尾服"
	item_path = /obj/item/clothing/suit/armor/security_tailcoat/centcom
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/suit/tailcoatbritish
	name = "英式燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/british

/datum/loadout_item/suit/tailcoatcommunist
	name = "红色燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/communist

/datum/loadout_item/suit/tailcoatusa
	name = "美式燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/usa

/datum/loadout_item/suit/tailcoatplasmaman
	name = "等离子燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/plasmaman

/datum/loadout_item/suit/tailcoatbunnyears_captain
	name = "舰长燕尾服"
	item_path = /obj/item/clothing/suit/armor/vest/capcarapace/tailcoat_captain
	restricted_roles = list(JOB_CAPTAIN)

/datum/loadout_item/suit/tailcoatquartermaster
	name = "军需官燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/quartermaster
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/suit/tailcoatcargo
	name = "货仓燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/cargo

/datum/loadout_item/suit/tailcoatminer
	name = "矿工燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/miner

/datum/loadout_item/suit/tailcoatbitrunner
	name = "潜网员燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/bitrunner

/datum/loadout_item/suit/tailcoatengineer
	name = "工程师燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/engineer

/datum/loadout_item/suit/tailcoatatmos_tech
	name = "大气技术员燕尾服"
	item_path = /obj/item/clothing/suit/utility/fire/atmos_tech_tailcoat

/datum/loadout_item/suit/tailcoatce
	name = "工程部长燕尾服"
	item_path = /obj/item/clothing/suit/utility/fire/ce_tailcoat
	restricted_roles = list(JOB_CHIEF_ENGINEER)

/datum/loadout_item/suit/tailcoatdoctor
	name = "医生燕尾服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat

/datum/loadout_item/suit/tailcoatparamedic
	name = "急救员燕尾服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/paramedic

/datum/loadout_item/suit/tailcoatchemist
	name = "化学家燕尾服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/chemist

/datum/loadout_item/suit/tailcoatpathologist
	name = "病毒学家燕尾服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/pathologist

/datum/loadout_item/suit/tailcoatcoroner
	name = "验尸官燕尾服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/coroner

/datum/loadout_item/suit/tailcoatcmo
	name = "医疗部长燕尾服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/cmo
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/suit/tailcoatscientist
	name = "科学家燕尾服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/science

/datum/loadout_item/suit/tailcoatroboticist
	name = "机械学家燕尾服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/science/robotics

/datum/loadout_item/suit/tailcoatgeneticist
	name = "基因学家燕尾服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/science/genetics

/datum/loadout_item/suit/tailcoatrd
	name = "科研部长燕尾服"
	item_path = /obj/item/clothing/suit/jacket/research_director/tailcoat
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/suit/tailcoatsecurity
	name = "安保燕尾服"
	item_path = /obj/item/clothing/suit/armor/security_tailcoat
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/suit/tailcoatsecurity/assistant
	name = "安保助手燕尾服"
	item_path = /obj/item/clothing/suit/armor/security_tailcoat/assistant
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/suit/tailcoatwarden
	name = "典狱长燕尾服"
	item_path = /obj/item/clothing/suit/armor/security_tailcoat/warden
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/suit/tailcoatbrig_phys
	name = "监狱医师燕尾服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/sec
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/suit/tailcoatdetective
	name = "侦探燕尾服"
	item_path =/obj/item/clothing/suit/jacket/det_suit/tailcoat
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/suit/tailcoatdetective/noir
	name = "黑色侦探燕尾服"
	item_path = /obj/item/clothing/suit/jacket/det_suit/tailcoat/noir
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/suit/tailcoathos
	name = "安保部长燕尾服"
	item_path = /obj/item/clothing/suit/armor/hos_tailcoat
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/suit/tailcoathop
	name = "人事部长燕尾服"
	item_path = /obj/item/clothing/suit/armor/hop_tailcoat
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL)

/datum/loadout_item/suit/tailcoatjanitor
	name = "清洁工燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/janitor

/datum/loadout_item/suit/tailcoatbartender
	name = "酒保燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/bartender

/datum/loadout_item/suit/tailcoatcook
	name = "厨师燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/cook

/datum/loadout_item/suit/tailcoatbotanist
	name = "植物学家燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/botanist

/datum/loadout_item/suit/tailcoatclown
	name = "小丑燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/clown
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/suit/tailcoatmime
	name = "默剧燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/mime
	restricted_roles = list(JOB_MIME)

/datum/loadout_item/suit/tailcoatchaplain
	name = "牧师燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/chaplain

/datum/loadout_item/suit/tailcoatcurator_red
	name = "红色策展人燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/curator_red

/datum/loadout_item/suit/tailcoatcurator_green
	name = "绿色策展人燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/curator_green

/datum/loadout_item/suit/tailcoatcurator_teal
	name = "青绿策展人燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/curator_teal

/datum/loadout_item/suit/tailcoatlawyer_black
	name = "黑色律师燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/lawyer_black

/datum/loadout_item/suit/tailcoatlawyer_blue
	name = "蓝色律师燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/lawyer_blue

/datum/loadout_item/suit/tailcoatlawyer_red
	name = "红色律师燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/lawyer_red

/datum/loadout_item/suit/tailcoatlawyer_good
	name = "正义律师燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/lawyer_good

/datum/loadout_item/suit/tailcoatpsychologist
	name = "心理学家燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat/psychologist

//紧身衣

/datum/loadout_item/under/playbunnysuitgreyscale
	name = "可染色兔尾紧身衣"
	item_path = /obj/item/clothing/under/costume/playbunnysuit/greyscale

/datum/loadout_item/under/playbunnysuitsyndicate
	name = "伪辛迪加兔尾紧身衣"
	item_path = /obj/item/clothing/under/syndicate/syndibunny/fake

/datum/loadout_item/under/magician
	name = "魔术师兔尾紧身衣"
	item_path = /obj/item/clothing/under/costume/playbunny/magician

/datum/loadout_item/under/playbunnysuitcentcom
	name = "Centcom兔尾紧身衣"
	item_path = /obj/item/clothing/under/costume/playbunny/centcom
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/under/playbunnysuitbritish
	name = "英式兔尾紧身衣"
	item_path = /obj/item/clothing/under/costume/playbunny/british

/datum/loadout_item/under/playbunnysuitcommunist
	name = "红色兔尾紧身衣"
	item_path = /obj/item/clothing/under/costume/playbunny/communist

/datum/loadout_item/under/playbunnysuitusa
	name = "美式兔尾紧身衣"
	item_path = /obj/item/clothing/under/costume/playbunny/usa

/datum/loadout_item/under/playbunnysuitbunnyears_captain
	name = "舰长兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/captain/bunnysuit
	restricted_roles = list(JOB_CAPTAIN)

/datum/loadout_item/under/playbunnysuitquartermaster
	name = "军需官兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/cargo/quartermaster_bunnysuit
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/under/playbunnysuitcargo
	name = "货仓兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/cargo/cargo_bunnysuit

/datum/loadout_item/under/playbunnysuitminer
	name = "矿工兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/cargo/miner/bunnysuit

/datum/loadout_item/under/playbunnysuitmailman
	name = "邮差兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/cargo/mailman_bunnysuit

/datum/loadout_item/under/playbunnysuitbitrunner
	name = "潜网员兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/cargo/bitrunner/bunnysuit

/datum/loadout_item/under/playbunnysuitengineer
	name = "工程师兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/engineering/engineer_bunnysuit

/datum/loadout_item/under/playbunnysuitatmos_tech
	name = "大气技术员兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/engineering/atmos_tech_bunnysuit

/datum/loadout_item/under/playbunnysuitce
	name = "工程部长兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/engineering/chief_engineer/bunnysuit
	restricted_roles = list(JOB_CHIEF_ENGINEER)

/datum/loadout_item/under/playbunnysuitdoctor
	name = "医生兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/medical/doctor_bunnysuit

/datum/loadout_item/under/playbunnysuitparamedic
	name = "急救员兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/medical/paramedic_bunnysuit

/datum/loadout_item/under/playbunnysuitchemist
	name = "化学家兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/medical/chemist/bunnysuit

/datum/loadout_item/under/playbunnysuitpathologist
	name = "病毒学家兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/medical/pathologist_bunnysuit

/datum/loadout_item/under/playbunnysuitcoroner
	name = "验尸官兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/medical/coroner_bunnysuit

/datum/loadout_item/under/playbunnysuitcmo
	name = "医疗部长兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/medical/cmo_bunnysuit
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/under/playbunnysuitscientist
	name = "科学家兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/rnd/scientist/bunnysuit

/datum/loadout_item/under/playbunnysuitroboticist
	name = "机械学家兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/rnd/scientist/roboticist_bunnysuit

/datum/loadout_item/under/playbunnysuitgeneticist
	name = "基因学家兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/rnd/geneticist/bunnysuit

/datum/loadout_item/under/playbunnysuitrd
	name = "科研部长兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/rnd/research_director/bunnysuit
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/under/playbunnysuitsecurity
	name = "安保兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/security/security_bunnysuit
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/under/playbunnysuitsecurity/assistant
	name = "安保助手兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/security/security_assistant_bunnysuit
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/under/playbunnysuitwarden
	name = "典狱长兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/security/warden_bunnysuit
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/under/playbunnysuitbrig_phys
	name = "监狱医师兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/security/brig_phys_bunnysuit
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/under/playbunnysuitdetective
	name = "侦探兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/security/detective_bunnysuit
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/under/playbunnysuitdetective/noir
	name = "黑色侦探兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/security/detective_bunnysuit/noir
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/under/playbunnysuitprisoner
	name = "囚犯兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/security/prisoner_bunnysuit

/datum/loadout_item/under/playbunnysuithos
	name = "安保部长兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/security/head_of_security/bunnysuit
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/under/playbunnysuithop
	name = "人事部长兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/hop_bunnysuit
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL)

/datum/loadout_item/under/playbunnysuitjanitor
	name = "清洁工兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/janitor/bunnysuit

/datum/loadout_item/under/playbunnysuitbartender
	name = "酒保兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/bartender_bunnysuit

/datum/loadout_item/under/playbunnysuitcook
	name = "厨师兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/cook_bunnysuit

/datum/loadout_item/under/playbunnysuitbotanist
	name = "植物学家兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/hydroponics/bunnysuit

/datum/loadout_item/under/playbunnysuitclown
	name = "小丑兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/clown/clown_bunnysuit
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/under/playbunnysuitmime
	name = "默剧兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/mime_bunnysuit
	restricted_roles = list(JOB_MIME)

/datum/loadout_item/under/playbunnysuitchaplain
	name = "牧师兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/chaplain_bunnysuit

/datum/loadout_item/under/playbunnysuitcurator_red
	name = "红色策展人兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/curator_bunnysuit_red

/datum/loadout_item/under/playbunnysuitcurator_green
	name = "绿色策展人兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/curator_bunnysuit_green

/datum/loadout_item/under/playbunnysuitcurator_teal
	name = "青绿策展人兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/curator_bunnysuit_teal

/datum/loadout_item/under/playbunnysuitlawyer_black
	name = "黑色律师兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_black

/datum/loadout_item/under/playbunnysuitlawyer_blue
	name = "蓝色律师兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_blue

/datum/loadout_item/under/playbunnysuitlawyer_red
	name = "红色律师兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_red

/datum/loadout_item/under/playbunnysuitlawyer_good
	name = "正义律师兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_good

/datum/loadout_item/under/playbunnysuitpsychologist
	name = "心理学家兔尾紧身衣"
	item_path = /obj/item/clothing/under/rank/civilian/psychologist_bunnysuit

*/
/*
/datum/loadout_item/shoes/fancy_heels/cc
	name = "Centcom高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/cc

/datum/loadout_item/shoes/fancy_heels/syndi
	name = "伪辛迪加高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/fakesyndi

/datum/loadout_item/shoes/fancy_heels/wizard
	name = "魔术师高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/wizard

/datum/loadout_item/shoes/fancy_heels/red
	name = "红高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/red

/datum/loadout_item/shoes/fancy_heels/blue
	name = "蓝高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/blue

/datum/loadout_item/shoes/fancy_heels/lightgrey
	name = "淡灰高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/lightgrey

/datum/loadout_item/shoes/fancy_heels/mining
	name = "矿工高跟鞋"
	item_path = /obj/item/clothing/shoes/workboots/mining/heeled

/datum/loadout_item/shoes/fancy_heels/navyblue
	name = "藏青高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/navyblue

/datum/loadout_item/shoes/fancy_heels/workboots
	name = "高跟工作鞋"
	item_path = /obj/item/clothing/shoes/workboots/heeled

/datum/loadout_item/shoes/fancy_heels/white
	name = "白高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/white

/datum/loadout_item/shoes/fancy_heels/darkblue
	name = "深蓝高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/darkblue

/datum/loadout_item/shoes/fancy_heels/black
	name = "黑高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/black

/datum/loadout_item/shoes/fancy_heels/purple
	name = "紫高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/purple

/datum/loadout_item/shoes/fancy_heels/red
	name = "红高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/red

/datum/loadout_item/shoes/fancy_heels/grey
	name = "灰高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/grey

/datum/loadout_item/shoes/fancy_heels/brown
	name = "棕高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/brown

/datum/loadout_item/shoes/fancy_heels/orange
	name = "橙高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/orange

/datum/loadout_item/shoes/fancy_heels/gogo_boots
	name = "战术戈戈舞靴"
	item_path = /obj/item/clothing/shoes/jackboots/gogo_boots

/datum/loadout_item/shoes/fancy_heels/lightblue
	name = "淡蓝高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/lightblue

/datum/loadout_item/shoes/fancy_heels/galoshes
	name = "高跟套鞋"
	item_path = /obj/item/clothing/shoes/galoshes/heeled

/datum/loadout_item/shoes/fancy_heels/green
	name = "绿高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/green

/datum/loadout_item/shoes/fancy_heels/clown_shoes
	name = "小丑高跟鞋"
	item_path = /obj/item/clothing/shoes/clown_shoes/heeled

/datum/loadout_item/shoes/fancy_heels/darkgreen
	name = "深绿高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/darkgreen

/datum/loadout_item/shoes/fancy_heels/teal
	name = "鸭绿高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/teal

/datum/loadout_item/shoes/fancy_heels/mutedblack
	name = "哑黑高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/mutedblack

/datum/loadout_item/shoes/fancy_heels/mutedblue
	name = "哑蓝高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/mutedblue

/datum/loadout_item/shoes/fancy_heels/beige
	name = "米色高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/beige

/datum/loadout_item/shoes/fancy_heels/darkgrey
	name = "暗灰高跟鞋"
	item_path = /obj/item/clothing/shoes/fancy_heels/darkgrey

//Ballistic Glasses
/datum/loadout_item/glasses/delingar_glasses_redsec
	donator_only = FALSE

/datum/loadout_item/glasses/delingar_glasses_meson
	donator_only = FALSE

/datum/loadout_item/glasses/delingar_glasses_medic
	donator_only = FALSE

/datum/loadout_item/glasses/delingar_glasses_science
	donator_only = FALSE

/datum/loadout_item/glasses/delingar_glasses_diagnostic
	donator_only = FALSE

/datum/loadout_item/glasses/delingar_glasses_common
	donator_only = FALSE
*/

/datum/loadout_item/neck/ascot
	name = "阿斯科特领巾"
	item_path = /obj/item/clothing/neck/ascot

/datum/loadout_item/suit/ozzieysuit
	name = "圣洁之铠仿品"
	item_path = /obj/item/clothing/suit/ozziey
	donator_only = TRUE
	ckeywhitelist = list("ozziey")

/datum/loadout_item/head/ozzieyhelm
	name = "圣洁之盔仿品"
	item_path = /obj/item/clothing/head/ozziey
	donator_only = TRUE
	ckeywhitelist = list("ozziey")

/datum/loadout_item/suit/security_medic
	name = "安保军医背心"
	item_path = /obj/item/clothing/suit/armor/vest/peacekeeper/security_medic
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/suit/security_medic_blue
	name = "维和军医背心"
	item_path = /obj/item/clothing/suit/hazardvest/security_medic/blue
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/suit/security_medic_blue_coat
	name = "安保军医夹克"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/suit/security_medic_blue_coat
	name = "维和军医夹克"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/blue
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/under/security_medic
	name = "安保军医毛衣"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/security_medic
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/under/security_medic_skirt
	name = "安保军医毛衣裙"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/security_medic/skirt
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/augment_item/organ/heart/rat
    name = "变异鼠心脏"
    path = /obj/item/organ/heart/rat
    cost = 3

/datum/augment_item/organ/stomach/rat
    name = "变异鼠胃"
    path = /obj/item/organ/stomach/rat

/datum/augment_item/organ/eyes/night_vision/rat
    name = "变异鼠眼睛"
    path = /obj/item/organ/eyes/night_vision/rat
    cost = 3

/datum/augment_item/organ/tongue/rat
    name = "变异鼠舌头"
    path = /obj/item/organ/tongue/rat

/datum/loadout_item/neck/USSRredscarf
	name = "红领巾"
	item_path = /obj/item/clothing/neck/USSRredscarf

/datum/loadout_item/uniform/ussrschooluniform
	name = "苏联女学生校服"
	item_path = /obj/item/clothing/under/ussrschooluniform

/datum/loadout_item/shoes/ussrschoolshoe
	name = "苏联学生系带皮鞋"
	item_path = /obj/item/clothing/shoes/ussrschoolshoe
/*
/datum/loadout_item/inhand/cylb
	name = "共青团徽章"
	item_path = /obj/item/clothing/accessory/cylb

/datum/loadout_item/uniform/pla65
	name = "65军装"
	item_path = /obj/item/clothing/under/pla65

/datum/loadout_item/shoes/pla65
	name = "解放鞋"
	item_path = /obj/item/clothing/shoes/pla65

/datum/loadout_item/inhand/satchelpla65
	name = "65式军用挎包"
	item_path = /obj/item/storage/backpack/satchel/pla65

/datum/loadout_item/inhand/pla65
	name = "主席胸章"
	item_path = /obj/item/clothing/accessory/pla65

/datum/loadout_item/ears/headset_frontier_colonist
	name = "frontier radio headset"
	item_path =  /obj/item/radio/headset/headset_frontier_colonist
*/
//ScarL
/datum/loadout_item/uniform/scarl
	name = "SCAR-L的制服"
	item_path = /obj/item/clothing/under/scarl
	group = "戏服"

/datum/loadout_item/suit/scarl
	name = "SCAR-L的外套"
	item_path = /obj/item/clothing/suit/armor/scarl/unarmored
	group = "戏服"

/datum/loadout_item/belts/scarl
	name = "SCAR-L的斜挎包"
	item_path = /obj/item/storage/belt/military/scarl

/datum/loadout_item/head/scarl
	name = "SCAR-L的针织帽"
	item_path = /obj/item/clothing/head/scarl/unarmored
	group = "戏服"

/datum/loadout_item/shoes/scarl
	name = "SCAR-L的靴子"
	item_path = /obj/item/clothing/shoes/jackboots/scarl
	group = "戏服"

/datum/loadout_item/neck/scarl
	name = "SCAR-L的围巾"
	item_path = /obj/item/clothing/neck/scarl

/datum/loadout_item/neck/duketabard
	name = "修士战袍"
	item_path = /obj/item/clothing/neck/padded/duketabard
	donator_only = TRUE
	ckeywhitelist = list("DeleteWarri05")
