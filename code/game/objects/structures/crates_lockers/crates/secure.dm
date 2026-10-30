/obj/structure/closet/crate/secure
	desc = "一个保险板条箱。"
	name = "保险板条箱"
	icon_state = "securecrate"
	base_icon_state = "securecrate"
	secure = TRUE
	locked = TRUE
	max_integrity = 300
	armor_type = /datum/armor/crate_secure
	damage_deflection = 10

	var/tamperproof = 0

/datum/armor/crate_secure
	melee = 15
	bullet = 25
	laser = 25
	energy = 50
	fire = 40
	acid = 40

/obj/structure/closet/crate/secure/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_MISSING_ITEM_ERROR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NO_MANIFEST_CONTENTS_ERROR, TRAIT_GENERIC)

/obj/structure/closet/crate/secure/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	if(prob(tamperproof) && damage_amount >= DAMAGE_PRECISION)
		boom()
	else
		return ..()

/obj/structure/closet/crate/secure/proc/boom(mob/user)
	if(user)
		to_chat(user, span_danger("板条箱的防拆系统启动了！"))
		log_bomber(user, "引爆了", src)
	dump_contents()
	explosion(src, heavy_impact_range = 1, light_impact_range = 5, flash_range = 5)
	qdel(src)

/obj/structure/closet/crate/secure/weapon
	desc = "一个保险武器板条箱。"
	name = "武器板条箱"
	icon_state = "weaponcrate"
	base_icon_state = "weaponcrate"

/obj/structure/closet/crate/secure/plasma
	desc = "一个保险等离子板条箱。"
	name = "等离子板条箱"
	icon_state = "plasmacrate"
	base_icon_state = "plasmacrate"

/obj/structure/closet/crate/secure/gear
	desc = "一个保险装备板条箱。"
	name = "装备板条箱"
	icon_state = "secgearcrate"
	base_icon_state = "secgearcrate"

/obj/structure/closet/crate/secure/hydroponics
	desc = "一个带锁的板条箱，涂装与空间站植物学家的配色一致。"
	name = "保险水培板条箱"
	icon_state = "hydrosecurecrate"
	base_icon_state = "hydrosecurecrate"

/obj/structure/closet/crate/secure/freezer //for consistency with other "freezer" closets/crates
	desc = "一个带锁的冷藏箱，用于安全存放易腐物品。"
	name = "保险厨房冷藏箱"
	icon_state = "kitchen_secure_crate"
	base_icon_state = "kitchen_secure_crate"
	paint_jobs = null

/obj/structure/closet/crate/secure/freezer/pizza
	name = "保险披萨板条箱"
	desc = "一个带锁的保温板条箱，用于安全存放披萨。"
	tamperproof = 10
	req_access = list(ACCESS_KITCHEN)

/obj/structure/closet/crate/secure/freezer/pizza/PopulateContents()
	. = ..()
	new /obj/effect/spawner/random/food_or_drink/pizzaparty(src)

/obj/structure/closet/crate/secure/centcom
	name = "保险中央指挥部板条箱"
	icon_state = "centcom_secure"
	base_icon_state = "centcom_secure"

/obj/structure/closet/crate/secure/cargo
	name = "保险货运板条箱"
	icon_state = "cargo_secure"
	base_icon_state = "cargo_secure"

/obj/structure/closet/crate/secure/cargo/mining
	name = "保险采矿板条箱"
	icon_state = "mining_secure"
	base_icon_state = "mining_secure"

/obj/structure/closet/crate/secure/radiation
	name = "保险辐射板条箱"
	icon_state = "radiation_secure"
	base_icon_state = "radiation_secure"

/obj/structure/closet/crate/secure/engineering
	desc = "一个带锁的板条箱，涂装与空间站工程师的配色一致。"
	name = "保险工程板条箱"
	icon_state = "engi_secure_crate"
	base_icon_state = "engi_secure_crate"

/obj/structure/closet/crate/secure/engineering/atmos
	name = "保险大气板条箱"
	desc = "一个带锁的板条箱，涂装与空间站大气技师的配色一致。"
	icon_state = "atmos_secure"
	base_icon_state = "atmos_secure"


/obj/structure/closet/crate/secure/science
	name = "保险科研板条箱"
	desc = "一个带锁的板条箱，涂装与空间站科学家的配色一致。"
	icon_state = "scisecurecrate"
	base_icon_state = "scisecurecrate"

/obj/structure/closet/crate/secure/science/robo
	name = "机器人学科研板条箱"
	icon_state = "robo_secure"
	base_icon_state = "robo_secure"

/obj/structure/closet/crate/secure/trashcart
	desc = "一辆带轮子的沉重金属垃圾车，装有电子锁。"
	name = "保险垃圾车"
	max_integrity = 250
	damage_deflection = 10
	icon_state = "securetrashcart"
	base_icon_state = "securetrashcart"
	weld_z = 5
	paint_jobs = null
	req_access = list(ACCESS_JANITOR)

/obj/structure/closet/crate/secure/trashcart/filled

/obj/structure/closet/crate/secure/trashcart/filled/PopulateContents()
	. = ..()
	for(var/i in 1 to rand(8,12))
		new /obj/effect/spawner/random/trash/deluxe_garbage(src)
		if(prob(35))
			new /obj/effect/spawner/random/trash/garbage(src)
	for(var/i in 1 to rand(4,6))
		if(prob(30))
			new /obj/item/storage/bag/trash/filled(src)

/obj/structure/closet/crate/secure/freezer/interdyne
	name = "\improper 英特戴恩冷冻柜"
	desc = "这是英特戴恩制药公司品牌的冷冻柜。里面可能装有可能不装新鲜器官。"
	icon_state = "interdynefreezer"
	base_icon_state = "interdynefreezer"
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/crate/secure/freezer/interdyne/blood
	name = "\improper 英特戴恩血液冷冻柜"
	desc = "这是英特戴恩制药公司品牌的冷冻柜，专门用于存放新鲜的高品质血液。"

/obj/structure/closet/crate/secure/freezer/interdyne/blood/PopulateContents()
	. = ..()
	for(var/i in 1 to 13)
		new /obj/item/reagent_containers/blood/random(src)

/obj/structure/closet/crate/secure/freezer/donk
	name = "\improper 咚克公司冰箱"
	desc = "一台咚克公司品牌的冰箱，能让你的咚克口袋饼和泡沫弹药保持新鲜！"
	icon_state = "donkcocrate_secure"
	base_icon_state = "donkcocrate_secure"
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/crate/secure/syndicate
	name = "\improper 辛迪加板条箱"
	desc = "一个印有辛迪加标志的保险板条箱。"
	icon_state = "syndicrate"
	base_icon_state = "syndicrate"
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/crate/secure/syndicate/interdyne
	name = "\improper 英特戴恩板条箱"
	desc = "属于英特戴恩制药公司的板条箱。希望里面没有生物武器……"
	icon_state = "interdynecrate"
	base_icon_state = "interdynecrate"

/obj/structure/closet/crate/secure/syndicate/tiger
	name = "\improper 猛虎合作社板条箱"
	icon_state = "tigercrate"
	base_icon_state = "tigercrate"

/obj/structure/closet/crate/secure/syndicate/self
	name = "\improper S.E.L.F. 板条箱"
	desc = "一个从内部锁死的保险板条箱，上方装有扫描面板和显示锁状态的全息屏。有感知引擎解放阵线的工程师真会显摆。"
	icon_state = "selfcrate_secure"
	base_icon_state = "selfcrate_secure"

/obj/structure/closet/crate/secure/syndicate/mi13
	name = "神秘的保险板条箱"
	desc = "一个保险板条箱。没有任何明显的标志，甚至没有来源编码，但看起来就像直接从间谍电影里搬出来的。"
	icon_state = "mithirteencrate"
	base_icon_state = "mithirteencrate"
	open_sound_volume = 15
	close_sound_volume = 20

/obj/structure/closet/crate/secure/syndicate/arc
	name = "\improper 动物权利联盟板条箱"
	icon_state = "arccrate"
	base_icon_state = "arccrate"

/obj/structure/closet/crate/secure/syndicate/cybersun
	name = "\improper 赛博太阳板条箱"

/obj/structure/closet/crate/secure/syndicate/cybersun/dawn
	desc = "一个赛博太阳工业的保险板条箱。它有着独特的橙绿配色，可能代表某个部门或分部，但你分辨不出是哪一个。"
	icon_state = "cyber_dawncrate"
	base_icon_state = "cyber_dawncrate"

/obj/structure/closet/crate/secure/syndicate/cybersun/noon
	desc = "一个赛博太阳工业的保险板条箱。它有着独特的黄橙配色，可能代表某个部门或分部，但你分辨不出是哪一个。"
	icon_state = "cyber_nooncrate"
	base_icon_state = "cyber_nooncrate"

/obj/structure/closet/crate/secure/syndicate/cybersun/dusk
	desc = "一个赛博太阳工业的保险板条箱。它有着独特的紫绿配色，可能代表某个部门或分部，但你分辨不出是哪一个。"
	icon_state = "cyber_duskcrate"
	base_icon_state = "cyber_duskcrate"

/obj/structure/closet/crate/secure/syndicate/cybersun/night
	desc = "一个赛博太阳工业的保险板条箱。这一只公然采用了辛迪加配色。你只能猜测里面装有辛迪加特工的装备。"
	icon_state = "cyber_nightcrate"
	base_icon_state = "cyber_nightcrate"

/obj/structure/closet/crate/secure/syndicate/wafflecorp
	name = "\improper 华夫公司板条箱"
	desc = "一款型号与设计都极为过时的货运板条箱，上面却绑着一把现代锁，真符合其品牌所有者华夫公司的作风。标志旁用花体字写着的金色文字是“自 2055 年起，连续为您提供全球排名前五*的早餐”。一行更小、同样为花体的细则说明：“*指 2099-2126 年间”。然而现在已经是 2563 年了。"
	icon_state = "wafflecrate"
	base_icon_state = "wafflecrate"

/obj/structure/closet/crate/secure/syndicate/gorlex
	name = "\improper 戈尔莱克斯掠夺者板条箱"
	icon_state = "gorlexcrate"
	base_icon_state = "gorlexcrate"

/obj/structure/closet/crate/secure/syndicate/gorlex/weapons
	desc = "一个戈尔莱克斯掠夺者的保险武器板条箱。"
	name = "武器板条箱"
	icon_state = "gorlex_weaponcrate"
	base_icon_state = "gorlex_weaponcrate"

/obj/structure/closet/crate/secure/syndicate/gorlex/weapons/bustedlock
	desc = "一个印有戈尔莱克斯掠夺者标志的破旧武器板条箱，其锁看起来已经损坏。"
	name = "损坏的武器板条箱"
	secure = FALSE
	locked = FALSE
	max_integrity = 400
	damage_deflection = 15
