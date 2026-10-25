
//Ancient cryogenic sleepers. Players become NT crewmen from a hundred year old space station, now on the verge of collapse.
/obj/effect/mob_spawn/ghost_role/human/oldstation
	name = "旧式低温休眠舱"
	desc = "一台嗡嗡作响的低温休眠舱。厚重的冰层下勉强能辨认出制服的轮廓。机器正试图唤醒它的乘员。"
	prompt_name = "一名古代船员"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "你是为纳米传讯工作的船员，驻扎在一座顶尖研究空间站上。"
	flavour_text = "你隐约记得，因为一场即将来袭的辐射风暴，你冲进了一台低温休眠舱。\
	你最后记得的是空间站的人工智能程序告诉你，你只会沉睡八个小时。当你睁开\
	眼睛时，一切似乎都已锈蚀破损，一股阴暗的感觉在你爬出休眠舱时涌上心头。"
	important_text = "与你的幸存者同伴团结协作，不要抛弃他们。"
	outfit = /datum/outfit/oldeng
	spawner_job_path = /datum/job/ancient_crew
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE

/obj/effect/mob_spawn/ghost_role/human/oldstation/Destroy()
	new /obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()


/obj/effect/mob_spawn/ghost_role/human/oldstation/sec
	desc = "一台嗡嗡作响的低温休眠舱。厚重的冰层下勉强能辨认出安保制服的轮廓。机器正试图唤醒它的乘员。"
	prompt_name = "一名安保官"
	you_are_text = "你是为纳米传讯工作的安保官，驻扎在一座顶尖研究空间站上。"
	outfit = /datum/outfit/oldsec

/datum/outfit/oldsec
	name = "Ancient Security"
	id = /obj/item/card/id/away/old/sec
	uniform = /obj/item/clothing/under/rank/security/officer
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/assembly/flash/handheld
	r_pocket = /obj/item/restraints/handcuffs

/obj/effect/mob_spawn/ghost_role/human/oldstation/eng
	desc = "一台嗡嗡作响的低温休眠舱。厚重的冰层下勉强能辨认出工程制服的轮廓。机器正试图唤醒它的乘员。"
	prompt_name = "一名工程师"
	you_are_text = "你是为纳米传讯工作的工程师，驻扎在一座顶尖研究空间站上。"
	outfit = /datum/outfit/oldeng

/datum/outfit/oldeng
	name = "Ancient Engineer"
	id = /obj/item/card/id/away/old/eng
	uniform = /obj/item/clothing/under/rank/engineering/engineer
	gloves = /obj/item/clothing/gloves/color/fyellow/old
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/tank/internals/emergency_oxygen

/datum/outfit/oldeng/mod
	name = "Ancient Engineer (MODsuit)"
	suit_store = /obj/item/tank/internals/oxygen
	back = /obj/item/mod/control/pre_equipped/prototype
	mask = /obj/item/clothing/mask/breath
	internals_slot = ITEM_SLOT_SUITSTORE

/obj/effect/mob_spawn/ghost_role/human/oldstation/sci
	desc = "一台嗡嗡作响的低温休眠舱。厚重的冰层下勉强能辨认出科研制服的轮廓。机器正试图唤醒它的乘员。"
	prompt_name = "一名科学家"
	you_are_text = "你是为纳米传讯工作的科学家，驻扎在一座顶尖研究空间站上。"
	outfit = /datum/outfit/oldsci

/datum/outfit/oldsci
	name = "Ancient Scientist"
	id = /obj/item/card/id/away/old/sci
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/stack/medical/bruise_pack

///asteroid comms agent

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space
	you_are_text = "你是一名辛迪加特工，被派往一座小型监听站，它紧邻你痛恨的敌人的绝密研究设施：空间站 13。"
	flavour_text = "尽可能监视敌方活动，并尽量保持低调。利用通讯设备为任何外勤特工提供支援，并散布假情报以甩开纳米传讯的追踪。不要让基地落入敌手！"
	important_text = "绝对不要放弃基地。"

/* BUBBER EDIT REMOVAL BEGIN - It's already a rare spawn. It doesn't need to be rarer.
/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space/Initialize(mapload)
	. = ..()
	if(prob(85)) //only has a 15% chance of existing, otherwise it'll just be a NPC syndie.
		new /mob/living/basic/trooper/syndicate/ranged(get_turf(src))
		return INITIALIZE_HINT_QDEL
BUBBER EDIT REMOVAL END */

///battlecruiser stuff

/obj/effect/mob_spawn/ghost_role/human/syndicate/battlecruiser
	name = "辛迪加战列巡洋舰船员"
	you_are_text = "你是辛迪加旗舰 SBC 星怒号上的一名船员。"
	flavour_text = "你的职责是服从舰长的命令、维护舰船，并保证电力供应。"
	important_text = "军械库不是糖果店，你的职责也不是直接进攻空间站，把那种活留给突击特工。"
	prompt_name = "一名战列巡洋舰船员"
	outfit = /datum/outfit/syndicate_empty/battlecruiser
	spawner_job_path = /datum/job/battlecruiser_crew
	uses = 4
	allow_custom_character = ALL

	/// The antag team to apply the player to
	var/datum/team/antag_team
	/// The antag datum to give to the player spawned
	var/antag_datum_to_give = /datum/antagonist/battlecruiser

/obj/effect/mob_spawn/ghost_role/human/syndicate/battlecruiser/allow_spawn(mob/user, silent = FALSE)
	if(!(user.ckey in antag_team.players_spawned))
		return TRUE
	if(!silent)
		to_chat(user, span_boldwarning("你已经用掉了抽取战列巡洋舰角色的机会。"))
	return FALSE

/obj/effect/mob_spawn/ghost_role/human/syndicate/battlecruiser/special(mob/living/spawned_mob, mob/possesser)
	. = ..()
	if(!spawned_mob.mind)
		spawned_mob.mind_initialize()
	var/datum/mind/mob_mind = spawned_mob.mind
	mob_mind.add_antag_datum(antag_datum_to_give, antag_team)
	antag_team.players_spawned += (spawned_mob.ckey)

/datum/outfit/syndicate_empty/battlecruiser
	name = "Syndicate Battlecruiser Ship Operative"
	belt = /obj/item/storage/belt/military/assault
	l_pocket = /obj/item/gun/ballistic/automatic/pistol/clandestine
	r_pocket = /obj/item/knife/combat/survival

	box = /obj/item/storage/box/survival/syndie

/obj/effect/mob_spawn/ghost_role/human/syndicate/battlecruiser/assault
	name = "辛迪加战列巡洋舰突击特工"
	you_are_text = "你是辛迪加旗舰 SBC 星怒号上的一名突击特工。"
	flavour_text = "你的职责是服从舰长的命令、阻止入侵者登舰，并进攻空间站 13。舰上有军械库、多艘突击舰和光束炮可供你攻打空间站。"
	important_text = "与你的同伴特工协同作战，制定进攻计划。如果被压制，就撤回你的舰船！"
	prompt_name = "一名战列巡洋舰特工"
	outfit = /datum/outfit/syndicate_empty/battlecruiser/assault
	uses = 8

/datum/outfit/syndicate_empty/battlecruiser/assault
	name = "Syndicate Battlecruiser Assault Operative"
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/vest
	suit_store = /obj/item/gun/ballistic/automatic/pistol/clandestine
	back = /obj/item/storage/backpack
	belt = /obj/item/storage/belt/military
	mask = /obj/item/clothing/mask/gas/syndicate
	l_pocket = /obj/item/uplink/nuclear
	r_pocket = /obj/item/modular_computer/pda/nukeops

	skillchips = list(/obj/item/skillchip/disk_verifier)

/obj/effect/mob_spawn/ghost_role/human/syndicate/battlecruiser/captain
	name = "辛迪加战列巡洋舰舰长"
	you_are_text = "你是辛迪加旗舰 SBC 星怒号上的舰长。"
	flavour_text = "你的职责是统率船员、保卫舰船，并摧毁空间站 13。舰上配有军械库、多艘舰船、光束炮以及多名船员来完成这一目标。"
	important_text = "作为舰长，整个行动都压在你的肩上。协助你的突击特工在空间站上引爆核弹。"
	prompt_name = "一名战列巡洋舰舰长"
	outfit = /datum/outfit/syndicate_empty/battlecruiser/assault/captain
	spawner_job_path = /datum/job/battlecruiser_captain
	antag_datum_to_give = /datum/antagonist/battlecruiser/captain
	uses = 1

/datum/outfit/syndicate_empty/battlecruiser/assault/captain
	name = "Syndicate Battlecruiser Captain"
	id = /obj/item/card/id/advanced/black/syndicate_command/captain_id
	id_trim = /datum/id_trim/battlecruiser/captain
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	suit_store = /obj/item/gun/ballistic/revolver/mateba
	back = /obj/item/storage/backpack/satchel/leather
	ears = /obj/item/radio/headset/syndicate/alt/leader
	glasses = /obj/item/clothing/glasses/thermal/eyepatch
	head = /obj/item/clothing/head/hats/hos/cap/syndicate
	mask = /obj/item/cigarette/cigar/havana
	l_pocket = /obj/item/melee/energy/sword/saber/red
	r_pocket = /obj/item/melee/baton/telescopic

//film studio space ruins, actors and such.
/obj/effect/mob_spawn/ghost_role/human/actor
	name = "低温休眠舱"
	desc = "一台嗡嗡作响的低温休眠舱。你能认出里面的人是当地的某位名人。"
	prompt_name = "一名演员"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "你是为索弗罗尼娅广播公司工作的演员，驻扎在当地的电视演播室里。"
	flavour_text = "你最后记得的是公司不知为何让所有人都去低温休眠，其他人都去哪了？"
	important_text = "与你的演员同伴和导演齐心协力，为大众创作娱乐节目。"
	outfit = /datum/outfit/actor
	spawner_job_path = /datum/job/ghost_role
	allow_custom_character = ALL

/datum/outfit/actor
	name = "Actor"
	id = /obj/item/card/id/away/filmstudio
	id_trim= /datum/id_trim/away/actor
	ears = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/suit/charcoal
	back = /obj/item/storage/backpack/satchel
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/clothing/mask/chameleon
	r_pocket = /obj/item/card/id/advanced/chameleon

/obj/effect/mob_spawn/ghost_role/human/director
	name = "低温休眠舱"
	desc = "一台嗡嗡作响的低温休眠舱。你能认出里面的人是当地的某位名人。"
	prompt_name = "一名导演"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "你是为索弗罗尼娅广播公司工作的导演，驻扎在当地的电视演播室里。"
	flavour_text = "你刚被聘来为当地一家电视演播室执导节目和娱乐内容，带领你的团队干出点成绩吧！"
	important_text = "与你的演员同伴和导演齐心协力，为大众创作娱乐节目。"
	outfit = /datum/outfit/actor/director
	spawner_job_path = /datum/job/ghost_role
	allow_custom_character = ALL

/datum/outfit/actor/director
	name = "Director"
	id_trim = /datum/id_trim/away/director
	uniform = /obj/item/clothing/under/suit/red
	head = /obj/item/clothing/head/beret/frenchberet
