/datum/loadout_category/shoes
	category_name = "鞋类"
	category_ui_icon = FA_ICON_SHOE_PRINTS
	type_to_generate = /datum/loadout_item/shoes
	tab_order = /datum/loadout_category/head::tab_order + 11

/datum/loadout_item/shoes
	abstract_type = /datum/loadout_item/shoes

/datum/loadout_item/shoes/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.shoes)
		LAZYADD(outfit.backpack_contents, outfit.shoes)
	outfit.shoes = item_path

/*
*	JACKBOOTS
*/

/datum/loadout_item/shoes/boots
	group = "靴子"
	abstract_type = /datum/loadout_item/shoes/boots

/datum/loadout_item/shoes/boots/jackboots
	name = "长筒军靴"
	item_path = /obj/item/clothing/shoes/jackboots

/datum/loadout_item/shoes/boots/jackboots/recolorable
	name = "长筒军靴（可染色）"
	item_path = /obj/item/clothing/shoes/jackboots/recolorable

/datum/loadout_item/shoes/boots/metra_boots
	name = "擦亮的长筒军靴"
	item_path = /obj/item/clothing/shoes/jackboots/netra
	//ckeywhitelist = list("netrakyram")

/datum/loadout_item/shoes/boots/jackboots/sec
	name = "安保长筒军靴"
	item_path = /obj/item/clothing/shoes/jackboots/sec
	restricted_roles = list(ALL_JOBS_SEC)

// Thedragmeme's donator reward, they've decided to make them available to everybody.
/datum/loadout_item/shoes/boots/jackboots/heel
	name = "高跟长筒军靴"
	item_path = /obj/item/clothing/shoes/jackboots/heel

/datum/loadout_item/shoes/boots/jackboots/rax_armadyne_boots
	name = "战术靴"
	item_path = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne/rax
	//ckeywhitelist = list("raxraus")
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/shoes/boots/jackboots/kneeboots
	name = "及膝长靴"
	item_path = /obj/item/clothing/shoes/jackboots/knee

/datum/loadout_item/shoes/boots/jackboots/peacekeeper
	name = "阿玛达因战斗靴"
	item_path = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/shoes/boots/jackboots/gogo_boots
	name = "战术及膝长靴"
	item_path = /obj/item/clothing/shoes/jackboots/gogo_boots
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/shoes/boots/diesel_m
	name = "男式柴油靴"
	item_path = /obj/item/clothing/shoes/jackboots/diesel_m

/datum/loadout_item/shoes/boots/diesel_f
	name = "女式柴油靴"
	item_path = /obj/item/clothing/shoes/jackboots/diesel_f

/datum/loadout_item/shoes/boots/frontier_colonist
	name = "边疆靴"
	item_path = /obj/item/clothing/shoes/jackboots/frontier_colonist/loadout

/datum/loadout_item/shoes/boots/jackboots/toeless
	name = "露趾长筒军靴"
	item_path = /obj/item/clothing/shoes/jackboots/toeless

/datum/loadout_item/shoes/boots/kim
	name = "航空靴"
	item_path = /obj/item/clothing/shoes/jackboots/kim

/datum/loadout_item/shoes/boots/jackboots/black
	name = "黑色长筒军靴"
	item_path = /obj/item/clothing/shoes/jackboots/black

/datum/loadout_item/shoes/boots/elofy
	name = "太阳上将靴"
	item_path = /obj/item/clothing/shoes/jackboots/elofy
//	ckeywhitelist = list("october23")

/datum/loadout_item/shoes/boots/jackboots/colonial_boots
	name = "殖民地半靴"
	item_path = /obj/item/clothing/shoes/jackboots/colonial

/*
*	MISC BOOTS
*/

/datum/loadout_item/shoes/boots/jackboots/timbs
	name = "时髦靴子"
	item_path = /obj/item/clothing/shoes/jackboots/timbs

/datum/loadout_item/shoes/boots/jackboots/jungle
	name = "丛林靴"
	item_path = /obj/item/clothing/shoes/jungleboots

/datum/loadout_item/shoes/boots/winter_boots
	name = "冬靴"
	item_path = /obj/item/clothing/shoes/winterboots

/datum/loadout_item/shoes/boots/work_boots
	name = "工作靴"
	item_path = /obj/item/clothing/shoes/workboots

/datum/loadout_item/shoes/boots/work_boots/heeled
	name = "高跟工作靴"
	item_path = /obj/item/clothing/shoes/workboots/heeled

/datum/loadout_item/shoes/boots/work_boots/old
	name = "工作靴（旧）"
	item_path = /obj/item/clothing/shoes/workboots/old

/datum/loadout_item/shoes/boots/mining_boots
	name = "采矿靴"
	item_path = /obj/item/clothing/shoes/workboots/mining

/datum/loadout_item/shoes/boots/mining_boots/heeled
	name = "高跟采矿靴"
	item_path = /obj/item/clothing/shoes/workboots/mining/heeled

/datum/loadout_item/shoes/boots/russian_boots
	name = "俄罗斯靴"
	item_path = /obj/item/clothing/shoes/russian

/datum/loadout_item/shoes/boots/pirate_boots
	name = "海盗靴"
	item_path = /obj/item/clothing/shoes/pirate

/datum/loadout_item/shoes/boots/work_boots/toeless
	name = "露趾工作靴"
	item_path = /obj/item/clothing/shoes/workboots/toeless

/datum/loadout_item/shoes/boots/noble_boots
	name = "贵族靴"
	item_path = /obj/item/clothing/shoes/jackboots/noble
	//ckeywhitelist = list("grasshand")

/*
*	COWBOY
*/

/datum/loadout_item/shoes/cowboy
	group = "牛仔靴"
	abstract_type = /datum/loadout_item/shoes/cowboy

/datum/loadout_item/shoes/cowboy/cowboyboots
	name = "牛仔靴（棕色）"
	item_path = /obj/item/clothing/shoes/cowboyboots

/datum/loadout_item/shoes/cowboy/boots_black
	name = "牛仔靴（黑色）"
	item_path = /obj/item/clothing/shoes/cowboyboots/black


/*
*	LEG WRAPS
*/

/datum/loadout_item/shoes/tribal
	group = "部落鞋履"
	abstract_type = /datum/loadout_item/shoes/tribal

/datum/loadout_item/shoes/tribal/gildedcuffs
	name = "鎏金绑腿"
	item_path = /obj/item/clothing/shoes/wraps

/datum/loadout_item/shoes/tribal/silvercuffs
	name = "银色绑腿"
	item_path = /obj/item/clothing/shoes/wraps/silver

/datum/loadout_item/shoes/tribal/redcuffs
	name = "红色绑腿"
	item_path = /obj/item/clothing/shoes/wraps/red

/datum/loadout_item/shoes/tribal/bluecuffs
	name = "蓝色绑腿"
	item_path = /obj/item/clothing/shoes/wraps/blue

/datum/loadout_item/shoes/tribal/cuffs/colourable
	name = "可调色绑腿"
	item_path = /obj/item/clothing/shoes/wraps/colourable

/datum/loadout_item/shoes/tribal/clothwrap
	name = "可调色布绑腿"
	item_path = /obj/item/clothing/shoes/wraps/cloth

/datum/loadout_item/shoes/tribal/clearcuffs
	name = "透明绑腿"
	item_path = /obj/item/clothing/shoes/wraps/clear

/*
*	FORMAL
*/

/datum/loadout_item/shoes/formal
	group = "正装鞋"
	abstract_type = /datum/loadout_item/shoes/formal

/datum/loadout_item/shoes/formal/laceups/recolorable
	name = "系带皮鞋（可染色）"
	item_path = /obj/item/clothing/shoes/colorable_laceups

/datum/loadout_item/shoes/formal/dominaheels
	name = "支配高跟鞋"
	item_path = /obj/item/clothing/shoes/latex_heels/domina_heels
	erp_item = TRUE

/datum/loadout_item/shoes/formal/high_heels
	name = "高跟鞋"
	item_path = /obj/item/clothing/shoes/high_heels

/datum/loadout_item/shoes/formal/disco
	name = "绿色蛇皮皮鞋"
	item_path = /obj/item/clothing/shoes/discoshoes

/datum/loadout_item/shoes/formal/dragheels
	name = "华丽高跟鞋（dragmeme）"
	item_path = /obj/item/clothing/shoes/fancy_heels/drag
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/shoes/formal/bubber/clown/pink/mute //Less silly = Unrestricted
	name = "粉色高跟鞋"
	item_path = /obj/item/clothing/shoes/latex_heels/bubber/clussy/mute

/datum/loadout_item/shoes/formal/latex_heels
	name = "乳胶高跟鞋"
	item_path = /obj/item/clothing/shoes/latex_heels

/datum/loadout_item/shoes/formal/latex_heels/ballet_heels
	name = "芭蕾高跟靴"
	item_path = /obj/item/clothing/shoes/latex_heels/ballet_heels

//Casual

/datum/loadout_item/shoes/casual
	group = "休闲鞋"
	abstract_type = /datum/loadout_item/shoes/casual

/datum/loadout_item/shoes/casual/sneakers/black_sneakers
	name = "运动鞋（可染色）"
	item_path = /obj/item/clothing/shoes/sneakers/black

/datum/loadout_item/shoes/casual/sandals
	name = "凉鞋"
	item_path = /obj/item/clothing/shoes/sandal

/datum/loadout_item/shoes/casual/sandals/recolorable
	name = "凉鞋（可染色）"
	item_path = /obj/item/clothing/shoes/colorable_sandals

/datum/loadout_item/shoes/casual/sportshoes
	name = "竞技运动鞋"
	item_path = /obj/item/clothing/shoes/sports

/datum/loadout_item/shoes/casual/rainbow
	name = "彩虹帆布鞋"
	item_path = /obj/item/clothing/shoes/sneakers/rainbow

//Fun
/datum/loadout_item/shoes/fun
	group = "戏服与其他搞怪鞋"
	abstract_type = /datum/loadout_item/shoes/fun

/datum/loadout_item/shoes/fun/mikulegging
	name = "星光歌手比基尼"
	item_path = /obj/item/clothing/shoes/sneakers/mikuleggings
	//ckeywhitelist = list("grandvegeta")

/datum/loadout_item/shoes/fun/rollerskates
	name = "轮滑鞋"
	item_path = /obj/item/clothing/shoes/wheelys/rollerskates

/datum/loadout_item/shoes/fun/jingleshoes
	name = "弄臣鞋"
	item_path = /obj/item/clothing/shoes/jester_shoes

/datum/loadout_item/shoes/fun/griffin
	name = "狮鹫靴"
	item_path = /obj/item/clothing/shoes/griffin

/datum/loadout_item/shoes/fun/wheely
	name = "轮滑高跟鞋"
	item_path = /obj/item/clothing/shoes/wheelys

/datum/loadout_item/shoes/fun/horseshoes
	name = "马蹄铁"
	item_path = /obj/item/clothing/shoes/horseshoe

/datum/loadout_item/shoes/fun/romans
	name = "罗马凉鞋"
	item_path = /obj/item/clothing/shoes/roman

/datum/loadout_item/shoes/fun/saints
	name = "圣徒运动鞋"
	item_path = /obj/item/clothing/shoes/saints

/datum/loadout_item/shoes/fun/jackfrost
	name = "冰霜靴"
	item_path = /obj/item/clothing/shoes/jackbros

/datum/loadout_item/shoes/fun/latex_socks
	name = "乳胶袜"
	item_path = /obj/item/clothing/shoes/latex_socks

/*
*	SEASONAL
*/

/datum/loadout_item/shoes/fun/christmas
	name = "红色圣诞靴"
	item_path = /obj/item/clothing/shoes/winterboots/christmas

/datum/loadout_item/shoes/fun/christmas/green
	name = "绿色圣诞靴"
	item_path = /obj/item/clothing/shoes/winterboots/christmas/green


/*
*	JOB-RESTRICTED
*/

/datum/loadout_item/shoes/fun/jester
	name = "小丑的弄臣鞋"
	item_path = /obj/item/clothing/shoes/clown_shoes/jester
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/fun/clown_shoes/pink
	name = "粉色小丑鞋"
	item_path = /obj/item/clothing/shoes/clown_shoes/pink
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/fun/britches_shoes
	name = "布里奇斯之鞋"
	item_path = /obj/item/clothing/shoes/clown_shoes/britches
	restricted_roles = list(JOB_CLOWN)
	//ckeywhitelist = list("bloodrite")

/datum/loadout_item/shoes/ba_cheerleader
	name = "NT 啦啦队运动鞋"
	item_path = /obj/item/clothing/shoes/sneakers/ba_cheerleader

/datum/loadout_item/shoes/ba_cheerleader_command
	name = "NT 指挥啦啦队运动鞋"
	item_path = /obj/item/clothing/shoes/sneakers/ba_cheerleader/command
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_ENGINEER, JOB_CHIEF_MEDICAL_OFFICER, JOB_QUARTERMASTER, JOB_NT_REP)

/datum/loadout_item/shoes/fun/bubber/clown/pink/squeak //Unlike the rest, these make noise. Job locked.
	name = "粉色小丑高跟鞋"
	item_path = /obj/item/clothing/shoes/clown_shoes/bubber/clussy
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/fun/bubber/clown/jester/amazing
	name = "条纹弄臣鞋"
	item_path = /obj/item/clothing/shoes/clown_shoes/bubber/jester
	restricted_roles = list(JOB_CLOWN)

