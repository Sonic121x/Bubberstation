
//lava hermit

//Malfunctioning cryostasis sleepers: Spawns in makeshift shelters in lavaland. Ghosts become hermits with knowledge of how they got to where they are now.
/obj/effect/mob_spawn/ghost_role/human/hermit
	name = "故障的低温休眠舱"
	desc = "一台嗡嗡作响的休眠舱，里面有一个轮廓模糊的乘员。它的停滞功能已经损坏，多半被当作床在用。"
	prompt_name = "一名被困的隐士"
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	outfit = /datum/outfit/hermit
	you_are_text = "你被困在这颗毫无神明的囚笼般的星球上，久到你已经记不清了。"
	flavour_text = "你每天都只是勉强糊口，而在临时住所的恶劣条件、\
	充满敌意的生物，以及从无云天空中俯冲而下的灰烬龙的夹击之下，你唯一渴望的，就是脚趾间柔软青草的感觉，\
	还有地球的新鲜空气。可这些念头总会被又一次“你是怎么来到这里的”回忆所驱散…… "
	spawner_job_path = /datum/job/hermit
	allow_custom_character = ALL
	quirks_enabled = TRUE // SKYRAT EDIT ADDITION - ghost role loadouts
	random_appearance = FALSE // SKYRAT EDIT ADDITION

/obj/effect/mob_spawn/ghost_role/human/hermit/Initialize(mapload)
	. = ..()
	outfit = new outfit //who cares equip outfit works with outfit as a path or an instance
	var/arrpee = rand(1,4)
	switch(arrpee)
		if(1)
			flavour_text += "你曾是距此数个星区的一座小型贸易站上某位[pick("军火商", "船匠", "对接管理员")]的助手。劫掠者来袭，你赶到逃生舱区时只剩\
			一个救生舱。你独自登上它并发射出去，当舱体引擎轰鸣着\
			把你送往这地狱时，挤在气闸门口那一群惊恐的面孔永远烙印在你的记忆里。"
			outfit.uniform = /obj/item/clothing/under/misc/assistantformal
		if(2)
			flavour_text += "你是猛虎合作社的流放者。他们的技术狂热让你开始质疑“外部派”的权力与信念，他们便视你为异端，对你施以数小时的可怕酷刑。\
			就在处决前几小时，你在合作社的一位高层朋友设法为你弄到了一个救生舱，打乱了它的目的地坐标，\
			然后将其发射。你着陆后从停滞中醒来，从此一直仅仅勉强维生。"
			outfit.uniform = /obj/item/clothing/under/rank/prisoner
			outfit.shoes = /obj/item/clothing/shoes/sneakers/orange
		if(3)
			flavour_text += "你曾是纳米传讯某座空间站上的一名医生，但你抛下了那该死的公司的暴政以及它所代表的一切。从一个喻义上的地狱\
			来到字面意义上的地狱，你发现自己竟然还会怀念身后那循环空气与温暖地板……不过你仍然宁愿待在这里，而不是那里。"
			outfit.uniform = /obj/item/clothing/under/rank/medical/doctor
			outfit.suit = /obj/item/clothing/suit/toggle/labcoat
			outfit.back = /obj/item/storage/backpack/medic
		if(4)
			flavour_text += "你的朋友们总爱拿你开涮，好意地说你“脑子少了几根弦”。看来他们说得没错——\
			在一次参观纳米传讯某座顶尖研究设施时，你独自待在一个逃生舱里，看到了那个红色按钮。\
			它又大又亮，一下子吸引了你的目光。你按了下去，在惊心动魄地飞了几天之后，你降落到了这里。此后你有的是时间变得聪明些，你觉得你的老朋友现在大概笑不出来了。"

/obj/effect/mob_spawn/ghost_role/human/hermit/Destroy()
	new/obj/structure/fluff/empty_cryostasis_sleeper(get_turf(src))
	return ..()

/datum/outfit/hermit
	name = "Lavaland Hermit"
	uniform = /obj/item/clothing/under/color/grey/ancient
	back = /obj/item/storage/backpack
	mask = /obj/item/clothing/mask/breath
	shoes = /obj/item/clothing/shoes/sneakers/black
	l_pocket = /obj/item/tank/internals/emergency_oxygen
	r_pocket = /obj/item/flashlight/glowstick

//Icebox version of hermit
/obj/effect/mob_spawn/ghost_role/human/hermit/icemoon
	name = "低温休眠床"
	desc = "一台嗡嗡作响的休眠舱，里面有一个轮廓模糊的乘员。它的停滞功能已经损坏，多半被当作床在用。"
	prompt_name = "一个脾气暴躁的老头"
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	outfit = /datum/outfit/hermit
	you_are_text = "你猎捕北极熊已经有 40 年了！这些“纳米传讯”的新来者到底想干什么？"
	flavour_text = "你本来一个人在这里猎北极熊、驯狼过得好好的，\
		可现在周围来了些公司走狗，你可得留心脚下。 "
	spawner_job_path = /datum/job/hermit

//beach dome

/obj/effect/mob_spawn/ghost_role/human/beach
	prompt_name = "一名海滩浪人"
	name = "海滩浪人休眠舱"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "你，呃，就是个十足的哥们儿，兄弟。"
	flavour_text = "那当然。你是趁着春假，呃，来这儿的，指望泡上几个火辣妹子，懂吧？"
	spawner_job_path = /datum/job/beach_bum
	outfit = /datum/outfit/beachbum
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE
	quirks_enabled = TRUE // SKYRAT EDIT ADDITION - ghost role loadouts
	random_appearance = FALSE // SKYRAT EDIT ADDITION

/obj/effect/mob_spawn/ghost_role/human/beach/lifeguard
	you_are_text = "你是个活力十足的救生员！"
	flavour_text = "确保没人溺水，也没人被鲨鱼什么的吃掉，就靠你了。"
	name = "救生员休眠舱"
	outfit = /datum/outfit/beachbum/lifeguard
	allow_custom_character = NONE

/obj/effect/mob_spawn/ghost_role/human/beach/lifeguard/special(mob/living/carbon/human/lifeguard, mob/mob_possessor, apply_prefs)
	. = ..()
	lifeguard.gender = FEMALE
	lifeguard.update_body()

/datum/outfit/beachbum
	name = "Beach Bum"
	id = /obj/item/card/id/advanced
	uniform = /obj/item/clothing/under/pants/jeans
	glasses = /obj/item/clothing/glasses/sunglasses
	l_pocket = /obj/item/food/pizzaslice/dank
	r_pocket = /obj/item/storage/wallet/random

/datum/outfit/beachbum/post_equip(mob/living/carbon/human/bum, visuals_only = FALSE)
	. = ..()
	if(visuals_only)
		return
	bum.dna.add_mutation(/datum/mutation/stoner, MUTATION_SOURCE_GHOST_ROLE)

/datum/outfit/beachbum/lifeguard
	name = "Beach Lifeguard"
	id_trim = /datum/id_trim/lifeguard
	uniform = /obj/item/clothing/under/shorts/red

/obj/effect/mob_spawn/ghost_role/human/bartender
	name = "酒保休眠舱"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "一名太空酒保"
	you_are_text = "你是一名太空酒保！"
	flavour_text = "该调酒、改变人生了。抽点太空毒品，会让你更容易听懂客人们古怪的方言。"
	spawner_job_path = /datum/job/space_bartender
	outfit = /datum/outfit/spacebartender
	allow_custom_character = ALL
	random_appearance = FALSE // SKYRAT EDIT ADDITION

/datum/outfit/spacebartender
	name = "Space Bartender"
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/space_bartender
	neck = /obj/item/clothing/neck/bowtie
	uniform = /obj/item/clothing/under/costume/buttondown/slacks/service
	suit = /obj/item/clothing/suit/armor/vest
	back = /obj/item/storage/backpack
	glasses = /obj/item/clothing/glasses/sunglasses/reagent
	shoes = /obj/item/clothing/shoes/sneakers/black

/datum/outfit/spacebartender/post_equip(mob/living/carbon/human/bartender, visuals_only = FALSE)
	. = ..()
	var/obj/item/card/id/id_card = bartender.wear_id
	if(bartender.age < AGE_MINOR)
		id_card.registered_age = AGE_MINOR
		to_chat(bartender, span_notice("严格来说你还没到可以接触或供应酒精的年龄，但你的 ID 已被悄悄修改为显示 [AGE_MINOR] 岁。尽量保守这个秘密！"))

//Preserved terrarium/seed vault: Spawns in seed vault structures in lavaland. Ghosts become plantpeople and are advised to begin growing plants in the room near them.
/obj/effect/mob_spawn/ghost_role/human/seed_vault
	name = "保存完好的生态箱"
	desc = "一台古老的机器，似乎用于储存植物物质。玻璃被一层藤蔓遮住了。"
	prompt_name = "生命使者"
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "terrarium"
	density = TRUE
	mob_species = /datum/species/pod
	you_are_text = "你是一个有感知的生态系统，是你创造者掌控生命之技艺的范例。"
	flavour_text = "你的主人虽然仁慈，却创造了数不清的种子库，把它们散布到\
	宇宙中每一颗他们能标注的星球上。你就在这样一座种子库中。\
	你的目标是保护分配给你的种子库，培育传给你们的种子，\
	最终为这颗荒芜的星球带来生命，同时等待与你的创造者取得联系。\
	预计上次联系的时刻：部署时，5000 个千年前。"
	spawner_job_path = /datum/job/lifebringer
	restricted_species = list(/datum/species/pod) //SKYRAT EDIT ADDITION
	random_appearance = FALSE // SKYRAT EDIT ADDITION
	allow_custom_character = ALL // BUBBER EDIT ADDITION

/obj/effect/mob_spawn/ghost_role/human/seed_vault/Initialize(mapload)
	. = ..()
	mob_name = pick("番茄", "土豆", "西兰花", "胡萝卜", "仙草", "南瓜", "常春藤", "葛藤", "香蕉", "苔藓", "花朵", "绽放", "根", "树皮", "荧光菇", "花瓣", "叶子", \
	"维纳斯", "新芽", "可可", "草莓", "柑橘", "橡树", "仙人掌", "辣椒", "杜松")

/obj/effect/mob_spawn/ghost_role/human/seed_vault/Destroy()
	new/obj/structure/fluff/empty_terrarium(get_turf(src))
	return ..()

//Ash walker eggs: Spawns in ash walker dens in lavaland. Ghosts become unbreathing lizards that worship the Necropolis and are advised to retrieve corpses to create more ash walkers.

/obj/structure/ash_walker_eggshell
	name = "灰行者蛋"
	desc = "一枚人形大小的黄色蛋，由某种难以理解的生物产下。里面隐约有一个人形轮廓。蛋壳看起来耐温，但其他方面相当脆弱。"
	icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	icon_state = "large_egg"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | FREEZE_PROOF
	max_integrity = 80
	var/obj/effect/mob_spawn/ghost_role/human/ash_walker/egg

/obj/structure/ash_walker_eggshell/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0) //lifted from xeno eggs
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/effects/blob/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/items/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(loc, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/structure/ash_walker_eggshell/attack_ghost(mob/user) //Pass on ghost clicks to the mob spawner
	if(egg)
		egg.attack_ghost(user)
	. = ..()

/obj/structure/ash_walker_eggshell/Destroy()
	if(!egg)
		return ..()
	var/mob/living/carbon/human/yolk = new(get_turf(src), /datum/species/lizard/ashwalker)
	yolk.fully_replace_character_name(null, yolk.generate_random_mob_name(TRUE))
	yolk.underwear = "Nude"
	yolk.equipOutfit(/datum/outfit/ashwalker)//this is an authentic mess we're making
	yolk.update_body()
	yolk.gib(DROP_ALL_REMAINS)
	QDEL_NULL(egg)
	return ..()

/obj/effect/mob_spawn/ghost_role/human/ash_walker
	name = "灰行者蛋"
	desc = "一枚人形大小的黄色蛋，由某种难以理解的生物产下。里面隐约有一个人形轮廓。"
	prompt_name = "死灵之都灰行者"
	icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	icon_state = "large_egg"
	mob_species = /datum/species/lizard/ashwalker
	outfit = /datum/outfit/ashwalker
	move_resist = MOVE_FORCE_NORMAL
	density = FALSE
	you_are_text = "你是一名灰行者。你的部族崇拜死灵之都。"
	flavour_text = "荒原是神圣的土地，其中的怪物是受祝福的恩赐。\
	你看见远处有灯光……它们预示着外来者的到来，那些人想要拆毁死灵之都及其领地。\
	为你的巢穴带来新鲜的祭品吧。"
	spawner_job_path = /datum/job/ash_walker
	var/datum/team/ashwalkers/team
	var/obj/structure/ash_walker_eggshell/eggshell
	restricted_species = list(/datum/species/lizard/ashwalker) //SKYRAT EDIT ADDITION
	random_appearance = FALSE // SKYRAT EDIT ADDITION
	allow_custom_character = GHOSTROLE_TAKE_PREFS_SPECIES // BUBBER EDIT ADDITION

/obj/effect/mob_spawn/ghost_role/human/ash_walker/Destroy()
	eggshell = null
	return ..()

/obj/effect/mob_spawn/ghost_role/human/ash_walker/allow_spawn(mob/user, silent = FALSE)
	if(isnull(team))
		return FALSE
	if(!(user.ckey in team.players_spawned))//one per person unless you get a bonus spawn
		return TRUE
	if(!silent)
		to_chat(user, span_warning("你对死灵之都的用处已经耗尽了。"))
	return FALSE

/obj/effect/mob_spawn/ghost_role/human/ash_walker/special(mob/living/carbon/human/spawned_human, mob/mob_possessor, apply_prefs)
	// SKYRAT EDIT ADDITION BEGIN
	spawned_human.fully_replace_character_name(null, spawned_human.generate_random_mob_name(TRUE)) // SKYRAT EDIT MOVE - Moving before parent call prevents char name randomization
	quirks_enabled = TRUE // ghost role quirks
	// SKYRAT EDIT ADDITION END
	. = ..()
	spawned_human.fully_replace_character_name(null, spawned_human.generate_random_mob_name(TRUE))
	to_chat(spawned_human, "<b>把人兽的尸体拖回你的巢穴。巢穴会吸收它们，孕育出更多你的同类。必要时可以入侵外来者那奇怪的建筑。不要造成不必要的破坏，因为用丑陋的残骸弄脏荒原绝不会为你赢得眷顾。死灵之都万岁！</b>")

	spawned_human.mind.add_antag_datum(/datum/antagonist/ashwalker, team)

	spawned_human.remove_language(/datum/language/common)
	team.players_spawned += (spawned_human.ckey)
	eggshell.egg = null
	QDEL_NULL(eggshell)

/obj/effect/mob_spawn/ghost_role/human/ash_walker/Initialize(mapload, datum/team/ashwalkers/ashteam)
	. = ..()
	var/area/spawner_area = get_area(src)
	team = ashteam
	eggshell = new /obj/structure/ash_walker_eggshell(get_turf(loc))
	eggshell.egg = src
	src.forceMove(eggshell)
	if(spawner_area)
		notify_ghosts(
			"一枚灰行者蛋已在 \the [spawner_area.name] 中准备孵化。",
			source = src,
			header = "灰行者蛋",
			click_interact = TRUE,
			ignore_key = POLL_IGNORE_ASHWALKER,
			notify_flags = NOTIFY_CATEGORY_NOFLASH,
		)

/datum/outfit/ashwalker
	name = "Ash Walker"
	head = /obj/item/clothing/head/helmet/gladiator
	uniform = /obj/item/clothing/under/costume/gladiator/ash_walker

/datum/outfit/ashwalker/spear
	name = "Ash Walker - Spear"
	back = /obj/item/spear/bonespear

///Syndicate Listening Post

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate
	name = "辛迪加生化武器科学家"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "一名辛迪加科学技术员"
	you_are_text = "你是一名辛迪加科学技术员，受雇于一座研发生物武器的绝密研究设施。"
	flavour_text = "不幸的是，你们憎恶的敌人纳米传讯已开始在这一星区采矿。尽力继续你的研究，并尽量保持低调。"
	important_text = "基地内布满了炸药，绝不要弃守，也绝不要让它落入敌手！"
	outfit = /datum/outfit/lavaland_syndicate
	spawner_job_path = /datum/job/lavaland_syndicate
	loadout_enabled = TRUE // SKYRAT EDIT ADDITION - ghost role loadouts
	quirks_enabled = TRUE // SKYRAT EDIT ADDITION - ghost role loadouts
	random_appearance = FALSE // SKYRAT EDIT ADDITION
	deletes_on_zero_uses_left = FALSE
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/special(mob/living/new_spawn, mob/mob_possessor, apply_prefs)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER) // SKYRAT EDIT CHANGE - ORIGINAL: new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_MIND)

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms
	name = "辛迪加通讯特工"
	prompt_name = "一名辛迪加通讯特工"
	you_are_text = "你是一名辛迪加通讯特工，受雇于一座研发生物武器的绝密研究设施。"
	flavour_text = "不幸的是，你们憎恶的敌人纳米传讯已开始在这一星区采矿。尽力监视敌方动向，并尽量保持低调。利用通讯设备为任何外勤特工提供支援，并散布虚假情报，让纳米传讯摸不清你的踪迹。不要让基地落入敌手！"
	important_text = "绝不要弃守基地。"
	outfit = /datum/outfit/lavaland_syndicate/comms

/datum/outfit/lavaland_syndicate
	name = "Lavaland Syndicate Agent"
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/toggle/labcoat
	back = /obj/item/storage/backpack
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/syndicate/alt
	shoes = /obj/item/clothing/shoes/combat
	r_pocket = /obj/item/gun/ballistic/automatic/pistol
	// r_hand = /obj/item/gun/ballistic/rifle/sniper_rifle //Bubberstation Edit
	belt = /obj/item/storage/belt/utility/full
	glasses = /obj/item/clothing/glasses/welding/up

	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/skyrat/interdyne //SKYRAT EDIT

/datum/outfit/lavaland_syndicate/post_equip(mob/living/carbon/human/syndicate, visuals_only = FALSE)
	syndicate.add_faction(ROLE_SYNDICATE)

/datum/outfit/lavaland_syndicate/comms
	name = "Lavaland Syndicate Comms Agent"
	suit = /obj/item/clothing/suit/armor/vest
	mask = /obj/item/clothing/mask/chameleon/gps
	r_hand = /obj/item/melee/energy/sword/saber
	belt = /obj/item/storage/belt/utility/full
	glasses = /obj/item/clothing/glasses/welding/up

/datum/outfit/lavaland_syndicate/comms/icemoon
	name = "Icemoon Syndicate Comms Agent"
	mask = /obj/item/clothing/mask/chameleon
	shoes = /obj/item/clothing/shoes/winterboots/ice_boots/eva

/obj/item/clothing/mask/chameleon/gps/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, "加密信号")

///Icemoon Syndicate Comms Agent

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/icemoon
	name = "冰月通讯特工"
	prompt_name = "一名辛迪加通讯特工"
	you_are_text = "你是一名辛迪加通讯特工，被派驻在敌方设施附近的一座地下秘密监听站。"
	flavour_text = "不幸的是，你们憎恶的敌人纳米传讯已开始在这一星区采矿。尽力监视敌方动向，并尽量保持低调。利用通讯设备为任何外勤特工提供支援，并散布虚假情报，让纳米传讯摸不清你的踪迹。不要让前哨站落入敌手！"
	important_text = "绝不要让前哨站落入敌手"
	outfit = /datum/outfit/lavaland_syndicate/comms/icemoon
