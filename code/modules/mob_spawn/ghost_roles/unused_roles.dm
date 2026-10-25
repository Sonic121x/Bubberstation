
//i couldn't find any map that uses these, so they're delegated to admin events for now.

/obj/effect/mob_spawn/ghost_role/human/prisoner_transport
	name = "囚犯收容休眠舱"
	desc = "一台旨在使乘员陷入深度昏迷的休眠舱，在休眠舱关闭之前无法解除。这一台的玻璃已经裂了，你能看到一张苍白的、沉睡的面孔正朝外望着。"
	prompt_name = "一名逃犯"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/lavalandprisoner
	you_are_text = "你是一名囚犯，被判处到纳米传讯的某处劳改营从事苦役，但看来命运\
	对你另有安排。"
	flavour_text = "很好。看来你的飞船坠毁了。你记得自己被判犯有"
	spawner_job_path = /datum/job/escaped_prisoner
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE

/obj/effect/mob_spawn/ghost_role/human/prisoner_transport/Initialize(mapload)
	. = ..()
	var/list/crimes = list("谋杀", "盗窃", "贪污", "组织工会", "玩忽职守", "绑架", "严重无能", "重大盗窃", "与辛迪加勾结", \
	"崇拜禁忌神祇", "跨物种关系", "哗变")
	flavour_text += "[pick(crimes)]。但不管怎样，现在看来你的罪名已经无关紧要了。你不知道自己身在何处，但你清楚这里想要你的命，而你绝不会\
	放过这个机会。想办法从这个烂摊子里脱身，回到你本该属于的地方——你的[pick("家", "公寓", "飞船", "空间站")]。"

/obj/effect/mob_spawn/ghost_role/human/prisoner_transport/Destroy()
	new /obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	return ..()

/obj/effect/mob_spawn/ghost_role/human/prisoner_transport/special(mob/living/carbon/human/spawned_human, mob/mob_possessor, apply_prefs)
	. = ..()
	spawned_human.fully_replace_character_name(null, "NTP #LL-0[rand(111,999)]") //Nanotrasen Prisoner #Lavaland-(numbers)

/datum/outfit/lavalandprisoner
	name = "Lavaland Prisoner"
	uniform = /obj/item/clothing/under/rank/prisoner
	mask = /obj/item/clothing/mask/breath
	shoes = /obj/item/clothing/shoes/sneakers/orange
	r_pocket = /obj/item/tank/internals/emergency_oxygen


//spawners for the space hotel, which isn't currently in the code but heyoo secret away missions or something

//Space Hotel Staff
/obj/effect/mob_spawn/ghost_role/human/hotel_staff //not free antag u little shits
	name = "员工休眠舱"
	desc = "一种专为客人来访间隙进行长期静滞而设计的休眠舱。"
	prompt_name = "一名酒店员工"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/hotelstaff
	you_are_text = "你是顶级太空酒店的一名员工！"
	flavour_text = "与其他员工一起招待来访的客人，为酒店做宣传，并确保经理不会解雇你。记住，顾客永远是对的！"
	important_text = "绝对不要离开酒店，否则会被视为违约并终止合同。"
	spawner_job_path = /datum/job/hotel_staff
	allow_custom_character = ALL

/datum/outfit/hotelstaff
	name = "Hotel Staff"
	uniform = /obj/item/clothing/under/misc/assistantformal
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/radio/off

	implants = list(
		/obj/item/implant/exile/noteleport,
		/obj/item/implant/mindshield,
	)

/obj/effect/mob_spawn/ghost_role/human/hotel_staff/security
	name = "酒店安保休眠舱"
	prompt_name = "一名酒店安保人员"
	outfit = /datum/outfit/hotelstaff/security
	you_are_text = "你是一名治安官。"
	flavour_text = "你被派往这家酒店，负责在维护客人与员工之间和平的同时，保护\
		公司的利益。"
	important_text = "绝对不要离开酒店，否则会被视为违约并终止合同。"

/datum/outfit/hotelstaff/security
	name = "Hotel Security"
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	back = /obj/item/storage/backpack/security
	belt = /obj/item/storage/belt/security/full
	head = /obj/item/clothing/head/helmet/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots

/obj/effect/mob_spawn/ghost_role/human/hotel_staff/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	return ..()

/obj/effect/mob_spawn/ghost_role/human/syndicate
	name = "辛迪加特工"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "一名辛迪加特工"
	you_are_text = "你是一名辛迪加特工。"
	flavour_text = "你在没有接到任何指令的情况下醒来。纳米传讯必须死！如果周围有什么线索能说明你该做什么，最好照着做。"
	outfit = /datum/outfit/syndicate_empty
	spawner_job_path = /datum/job/space_syndicate
	allow_custom_character = ALL

/datum/outfit/syndicate_empty
	name = "Syndicate Operative Empty"
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative
	uniform = /obj/item/clothing/under/syndicate
	back = /obj/item/storage/backpack
	ears = /obj/item/radio/headset/syndicate/alt
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	shoes = /obj/item/clothing/shoes/combat

	implants = list(/obj/item/implant/weapons_auth)

/datum/outfit/syndicate_empty/post_equip(mob/living/carbon/human/H)
	H.add_faction(ROLE_SYNDICATE)

//For ghost bar.
/obj/effect/mob_spawn/ghost_role/human/space_bar_patron
	name = "酒吧低温休眠舱"
	uses = INFINITY
	prompt_name = "一名太空酒吧顾客"
	you_are_text = "你是一名顾客！"
	flavour_text = "在酒吧里消磨时间，和朋友们聊天。聊完了随时可以回到低温休眠舱。"
	outfit = /datum/outfit/cryobartender
	spawner_job_path = /datum/job/space_bar_patron
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/space_bar_patron/attack_hand(mob/user, list/modifiers)
	var/despawn = tgui_alert(usr, "返回低温休眠？（警告：你的角色将被删除！）", null, list("Yes", "No"))
	if(despawn == "No" || !loc || !Adjacent(user))
		return
	user.visible_message(span_notice("[user.name] 爬回了低温休眠舱……"))
	qdel(user)

/datum/outfit/cryobartender
	name = "Cryogenic Bartender"
	neck = /obj/item/clothing/neck/bowtie
	uniform = /obj/item/clothing/under/costume/buttondown/slacks/service
	suit = /obj/item/clothing/suit/armor/vest
	back = /obj/item/storage/backpack
	glasses = /obj/item/clothing/glasses/sunglasses/reagent
	shoes = /obj/item/clothing/shoes/sneakers/black

//Timeless prisons: Spawns in Wish Granter prisons in lavaland. Ghosts become age-old users of the Wish Granter and are advised to seek repentance for their past.
/obj/effect/mob_spawn/ghost_role/human/exile
	name = "永恒牢狱"
	desc = "这个静滞舱虽然看起来像是医疗设备，但似乎是为了将某种东西保存极长时间而设计的。"
	prompt_name = "一名忏悔的流放者"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/shadow
	you_are_text = "你被诅咒了。"
	flavour_text = "多年前，你牺牲了挚友们的性命和自己的人性，只为抵达许愿者。虽然你\
	做到了，但代价也随之而来：你的身体排斥光明，注定要在这片可怕的荒原上无尽徘徊。"
	spawner_job_path = /datum/job/exile

/obj/effect/mob_spawn/ghost_role/human/exile/Destroy()
	new/obj/structure/fluff/empty_sleeper(get_turf(src))
	return ..()

/obj/effect/mob_spawn/ghost_role/human/exile/special(mob/living/new_spawn, mob/mob_possessor, apply_prefs)
	. = ..()
	new_spawn.fully_replace_character_name(null,"许愿者的受害者（[rand(1,999)]）")
	var/wish = rand(1,4)
	var/message = ""
	switch(wish)
		if(1)
			message = "<b>你许愿要杀戮，而你也确实这么做了。你已经数不清杀了多少人，但杀戮曾带给你的兴奋火花早已熄灭。你只感到悔恨。</b>"
		if(2)
			message = "<b>你许愿要无尽的财富，但再多的钱也不值得换来这样的处境。也许行善能救赎你的灵魂？</b>"
		if(3)
			message = "<b>你许愿要权力。可这没给你带来什么好处，你被逐出了光明。你是一个没有臣民的地狱的[gender == MALE ? "国王" : "女王"]。你只感到悔恨。</b>"
		if(4)
			message = "<b>你许愿要永生，哪怕你的朋友们正在你身后死去。无论你多少次投身熔岩，几天后你又会在这间屋子里醒来。无路可逃。</b>"
	to_chat(new_spawn, span_infoplain("[message]"))

/obj/effect/mob_spawn/ghost_role/human/nanotrasensoldier
	name = "休眠舱"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	faction = list(FACTION_NANOTRASEN_PRIVATE)
	prompt_name = "一名私人安保官"
	you_are_text = "你是纳米传讯的一名私人安保官！"
	flavour_text = "如果上级指挥部给你派了任务，最好照办。否则，就杀光辛迪加。"
	outfit = /datum/outfit/nanotrasensoldier
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/commander
	name = "休眠舱"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "一名纳米传讯指挥官"
	you_are_text = "你是纳米传讯的指挥官！"
	flavour_text = "纳米传讯的上层人物。你理应得到应有的尊重。"
	outfit = /datum/outfit/nanotrasencommander
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE

//space doctor, a rat with cancer, and bessie from an old removed lavaland ruin.

/obj/effect/mob_spawn/ghost_role/human/doctor
	name = "休眠舱"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "一名太空医生"
	you_are_text = "你是一名太空医生！"
	flavour_text = "作为医生，你的工作——不，你的职责，就是照料并治愈需要帮助的人。"
	outfit = /datum/outfit/job/doctor
	spawner_job_path = /datum/job/space_doctor
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/doctor/alive/equip(mob/living/carbon/human/doctor)
	. = ..()
	// Remove radio and PDA so they wouldn't annoy station crew.
	var/list/del_types = list(/obj/item/modular_computer/pda, /obj/item/radio/headset)
	for(var/del_type in del_types)
		var/obj/item/unwanted_item = locate(del_type) in doctor
		qdel(unwanted_item)

/obj/effect/mob_spawn/ghost_role/mouse
	name = "休眠舱"
	mob_type = /mob/living/basic/mouse
	prompt_name = "一只老鼠"
	you_are_text = "你是一只老鼠！"
	flavour_text = "呃……没错！吱吱，混蛋。"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/ghost_role/cow
	name = "休眠舱"
	mob_name = "贝茜"
	mob_type = /mob/living/basic/cow
	prompt_name = "一头奶牛"
	you_are_text = "你是一头奶牛！"
	flavour_text = "去啃点草吧，臭家伙。"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/cow/special(mob/living/spawned_mob, mob/mob_possessor, apply_prefs)
	. = ..()
	gender = FEMALE

// snow operatives on snowdin - unfortunately seemingly removed in a map remake womp womp

/obj/effect/mob_spawn/ghost_role/human/snow_operative
	name = "休眠舱"
	prompt_name = "一名雪地特工"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	faction = list(ROLE_SYNDICATE)
	outfit = /datum/outfit/snowsyndie
	you_are_text = "你是一名刚从地下前哨的低温休眠中醒来的辛迪加特工。"
	flavour_text = "监视纳米传讯的通讯并记录情报。任何入侵者都应被迅速\
	处理掉，以确保已收集的情报不会被窃取或丢失。尽量不要离前哨太远，因为\
	即便对像你这样训练有素的特工来说，这里的洞穴也可能是致命之地。"
	allow_custom_character = ALL

/datum/outfit/snowsyndie
	name = "Syndicate Snow Operative"
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative
	uniform = /obj/item/clothing/under/syndicate/coldres
	ears = /obj/item/radio/headset/syndicate/alt
	shoes = /obj/item/clothing/shoes/combat/coldres
	r_pocket = /obj/item/gun/ballistic/automatic/pistol

	implants = list(/obj/item/implant/exile)

//Forgotten syndicate ship

/obj/effect/mob_spawn/ghost_role/human/syndicatespace
	name = "辛迪加船舰船员"
	show_flavor = FALSE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "赛博太阳船员"
	you_are_text = "你是一名辛迪加特工，身处一艘困在敌对星域的老旧船舰上。"
	flavour_text = "在敌对星域某处停留许久后，你的船舰因报告故障而停靠。你被困在这里，附近还有一座纳米传讯空间站。修好船舰，想办法给它供电，并服从舰长的命令。"
	important_text = "服从舰长下达的命令。绝对不要让船舰落入敌手。"
	outfit = /datum/outfit/syndicatespace/syndicrew
	spawner_job_path = /datum/job/syndicate_cybersun
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/syndicatespace/special(mob/living/new_spawn, mob/mob_possessor, apply_prefs)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER) // SKYRAT EDIT CHANGE - ORIGINAL: new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_MIND)
	var/datum/job/spawn_job = SSjob.get_job_type(spawner_job_path)
	var/policy = get_policy(spawn_job.policy_index)
	if(policy)
		to_chat(new_spawn, span_bold("[policy]"))

/obj/effect/mob_spawn/ghost_role/human/syndicatespace/captain
	name = "辛迪加船舰舰长"
	prompt_name = "一名赛博太阳舰长"
	you_are_text = "你是一艘困在敌对星域的老旧船舰的舰长。"
	flavour_text = "在敌对星域某处停留许久后，你的船舰因报告故障而停靠。你被困在这里，附近还有一座纳米传讯空间站。指挥你的船员，把船舰变成戒备最森严的堡垒。"
	important_text = "用自己的生命保护船舰和你背包里的机密文件。"
	outfit = /datum/outfit/syndicatespace/syndicaptain
	spawner_job_path = /datum/job/syndicate_cybersun_captain
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/syndicatespace/captain/Destroy()
	new /obj/structure/fluff/empty_sleeper/syndicate/captain(get_turf(src))
	return ..()

/datum/outfit/syndicatespace
	name = "Syndicate Ship Base"
	id = /obj/item/card/id/advanced/black/syndicate_command/crew_id
	uniform = /obj/item/clothing/under/syndicate/combat
	back = /obj/item/storage/backpack
	belt = /obj/item/storage/belt/military/assault
	ears = /obj/item/radio/headset/syndicate/alt
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/combat

	implants = list(/obj/item/implant/weapons_auth)

/datum/outfit/syndicatespace/post_equip(mob/living/carbon/human/syndie_scum)
	syndie_scum.add_faction(ROLE_SYNDICATE)

/datum/outfit/syndicatespace/syndicrew
	name = "Syndicate Ship Crew Member"
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/syndicate
	l_pocket = /obj/item/gun/ballistic/automatic/pistol
	r_pocket = /obj/item/knife/combat/survival

/datum/outfit/syndicatespace/syndicaptain
	name = "Syndicate Ship Captain"
	id = /obj/item/card/id/advanced/black/syndicate_command/captain_id
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	ears = /obj/item/radio/headset/syndicate/alt/leader
	head = /obj/item/clothing/head/hats/hos/beret/syndicate
	r_pocket = /obj/item/knife/combat/survival
	backpack_contents = list(
		/obj/item/documents/syndicate/red,
		/obj/item/gun/ballistic/automatic/pistol/aps,
		/obj/item/paper/fluff/ruins/forgottenship/password,
	)
