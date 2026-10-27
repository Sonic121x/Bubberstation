/// One of the potential shuttle loans you might receive.
/datum/shuttle_loan_situation
	/// Who sent the shuttle
	var/sender = "中央指挥部"
	/// What they said about it.
	var/announcement_text = "未设置的公告文本"
	/// What the shuttle says about it.
	var/shuttle_transit_text = "未设置的运输文本"
	/// Supply points earned for taking the deal.
	var/bonus_points = CARGO_CRATE_VALUE * 50
	/// Response for taking the deal.
	var/thanks_msg = "货运穿梭机应在五分钟后返回。这些补给点数算是对你辛苦的补偿。"
	/// Small description of the loan for easier log reading.
	var/logging_desc

/datum/shuttle_loan_situation/New()
	. = ..()
	if(!logging_desc)
		stack_trace("No logging blurb set for [src.type]!")
	if(HAS_TRAIT(SSstation, STATION_TRAIT_LOANER_SHUTTLE))
		bonus_points *= 1.15

/// Spawns paths added to `spawn_list`, and passes empty shuttle turfs so you can spawn more complicated things like dead bodies.
/datum/shuttle_loan_situation/proc/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	SHOULD_CALL_PARENT(FALSE)
	CRASH("Unimplemented get_spawned_items() on [src.type].")

/datum/shuttle_loan_situation/antidote
	sender = "中央指挥部科研计划处"
	announcement_text = "您的空间站被选中参与一项流行病学研究项目。请派出您的货运穿梭机来接收研究样本。"
	shuttle_transit_text = "病毒样本即将到达。"
	logging_desc = "病毒穿梭机"

/datum/shuttle_loan_situation/antidote/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/obj/effect/mob_spawn/corpse/human/assistant/infected_assistant = pick(list(
		/obj/effect/mob_spawn/corpse/human/assistant/beesease_infection,
		/obj/effect/mob_spawn/corpse/human/assistant/brainrot_infection,
		/obj/effect/mob_spawn/corpse/human/assistant/spanishflu_infection,
	))
	for(var/i in 1 to 10)
		if(prob(15))
			spawn_list.Add(/obj/item/reagent_containers/cup/bottle)
		else if(prob(15))
			spawn_list.Add(/obj/item/reagent_containers/syringe)
		else if(prob(25))
			spawn_list.Add(/obj/item/shard)
		var/turf/assistant_turf = pick_n_take(empty_shuttle_turfs)
		new infected_assistant(assistant_turf)
	spawn_list.Add(/obj/structure/closet/crate)
	spawn_list.Add(/obj/item/reagent_containers/cup/bottle/pierrot_throat)
	spawn_list.Add(/obj/item/reagent_containers/cup/bottle/magnitis)

/datum/shuttle_loan_situation/department_resupply
	sender = "中央指挥部后勤部"
	announcement_text = "看来我们本月订了双份的部门补给包。我们能把它送到您那里吗？"
	shuttle_transit_text = "部门补给即将到达。"
	thanks_msg = "货运穿梭机应在五分钟后返回。"
	bonus_points = 0
	logging_desc = "补给包"

/datum/shuttle_loan_situation/department_resupply/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/list/crate_types = list(
		/datum/supply_pack/emergency/equipment,
		/datum/supply_pack/security/supplies,
		/datum/supply_pack/organic/food,
		/datum/supply_pack/emergency/weedcontrol,
		/datum/supply_pack/engineering/tools,
		/datum/supply_pack/engineering/engiequipment,
		/datum/supply_pack/science/robotics,
		/datum/supply_pack/science/plasma,
		/datum/supply_pack/medical/supplies
		)
	for(var/crate in crate_types)
		var/datum/supply_pack/pack = SSshuttle.supply_packs[crate]
		pack.generate(pick_n_take(empty_shuttle_turfs))

	for(var/i in 1 to 5)
		var/decal = pick(/obj/effect/decal/cleanable/food/flour, /obj/effect/decal/cleanable/blood/gibs/robot_debris, /obj/effect/decal/cleanable/blood/oil)
		new decal(pick_n_take(empty_shuttle_turfs))

/datum/shuttle_loan_situation/syndiehijacking
	sender = "中央指挥部反情报处"
	announcement_text = "辛迪加正试图渗透您的空间站。如果您让他们劫持您的货运穿梭机，就能省去我们一番麻烦。"
	shuttle_transit_text = "辛迪加劫持小队即将到达。"
	logging_desc = "辛迪加登舰小队"

/datum/shuttle_loan_situation/syndiehijacking/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/datum/supply_pack/pack = SSshuttle.supply_packs[/datum/supply_pack/imports/specialops]
	pack.generate(pick_n_take(empty_shuttle_turfs))

	spawn_list.Add(/mob/living/basic/trooper/syndicate/ranged/infiltrator)
	spawn_list.Add(/mob/living/basic/trooper/syndicate/ranged/infiltrator)
	if(prob(75))
		spawn_list.Add(/mob/living/basic/trooper/syndicate/ranged/infiltrator)
	if(prob(50))
		spawn_list.Add(/mob/living/basic/trooper/syndicate/ranged/infiltrator)

/datum/shuttle_loan_situation/lots_of_bees
	sender = "中央指挥部清洁部"
	announcement_text = "我们一艘运送蜜蜂的货船遭到生态恐怖分子袭击。您能帮我们收拾残局吗？"
	shuttle_transit_text = "生物危害清理作业即将到达。"
	bonus_points = CARGO_CRATE_VALUE * 100 //Toxin bees can be unbeelievably lethal
	logging_desc = "满载蜜蜂的穿梭机"

/datum/shuttle_loan_situation/lots_of_bees/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/datum/supply_pack/pack = SSshuttle.supply_packs[/datum/supply_pack/organic/hydroponics/beekeeping_fullkit]
	pack.generate(pick_n_take(empty_shuttle_turfs))

	spawn_list.Add(/obj/effect/mob_spawn/corpse/human/bee_terrorist)
	spawn_list.Add(/obj/effect/mob_spawn/corpse/human/cargo_tech)
	spawn_list.Add(/obj/effect/mob_spawn/corpse/human/cargo_tech)
	spawn_list.Add(/obj/effect/mob_spawn/corpse/human/nanotrasensoldier)
	spawn_list.Add(/obj/item/gun/ballistic/automatic/pistol/no_mag)
	spawn_list.Add(/obj/item/gun/ballistic/automatic/pistol/m1911/no_mag)
	spawn_list.Add(/obj/item/honey_frame)
	spawn_list.Add(/obj/item/honey_frame)
	spawn_list.Add(/obj/item/honey_frame)
	spawn_list.Add(/obj/structure/beebox/unwrenched)
	spawn_list.Add(/obj/item/queen_bee/bought)
	spawn_list.Add(/obj/structure/closet/crate/hydroponics)

	for(var/i in 1 to 8)
		spawn_list.Add(/mob/living/basic/bee/toxin)

	for(var/i in 1 to 5)
		var/decal = pick(/obj/effect/decal/cleanable/blood, /obj/effect/decal/cleanable/insectguts)
		new decal(pick_n_take(empty_shuttle_turfs))

	for(var/i in 1 to 10)
		var/casing = /obj/item/ammo_casing/spent
		new casing(pick_n_take(empty_shuttle_turfs))

/datum/shuttle_loan_situation/jc_a_bomb
	sender = "中央指挥部安保部"
	announcement_text = "我们在贵宾穿梭机的燃料管线附近发现了一枚已激活的辛迪加炸弹。如果您愿意接手，我们会为拆除它向您付酬。"
	shuttle_transit_text = "实弹爆炸物即将到达。请极度小心。"
	thanks_msg = "实弹爆炸物即将由补给穿梭机送达。建议疏散货舱。"
	bonus_points = CARGO_CRATE_VALUE * 225 //If you mess up, people die and the shuttle gets turned into swiss cheese
	logging_desc = "载有定时炸弹的穿梭机"

/datum/shuttle_loan_situation/jc_a_bomb/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	spawn_list.Add(/obj/machinery/syndicatebomb/shuttle_loan)
	if(prob(95))
		spawn_list.Add(/obj/item/paper/fluff/cargo/bomb)
	else
		spawn_list.Add(/obj/item/paper/fluff/cargo/bomb/allyourbase)

/datum/shuttle_loan_situation/papers_please
	sender = "中央指挥部文书部"
	announcement_text = "邻近的空间站需要人帮忙处理一些文书。您能帮我们处理吗？"
	shuttle_transit_text = "文书即将到达。"
	thanks_msg = "货运穿梭机应在五分钟后返回。文书处理完毕并送回后即会支付报酬。"
	bonus_points = 0 //Payout is made when the stamped papers are returned
	logging_desc = "文书运送"

/datum/shuttle_loan_situation/papers_please/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	spawn_list += subtypesof(/obj/item/paperwork) - typesof(/obj/item/paperwork/photocopy) - typesof(/obj/item/paperwork/ancient)

/datum/shuttle_loan_situation/pizza_delivery
	sender = "中央指挥部太空披萨部"
	announcement_text = "看起来邻近的空间站不小心把他们的披萨送到了您那里。"
	shuttle_transit_text = "披萨外卖到！"
	thanks_msg = "货运穿梭机应在五分钟后返回。"
	bonus_points = 0
	logging_desc = "披萨外卖"

/datum/shuttle_loan_situation/pizza_delivery/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/naughtypizza = list(/obj/item/pizzabox/bomb, /obj/item/pizzabox/margherita/robo) //oh look another blacklist, for pizza nonetheless!
	var/nicepizza = list(/obj/item/pizzabox/margherita, /obj/item/pizzabox/meat, /obj/item/pizzabox/vegetable, /obj/item/pizzabox/mushroom)
	for(var/i in 1 to 6)
		spawn_list.Add(pick(prob(5) ? naughtypizza : nicepizza))

/datum/shuttle_loan_situation/russian_party
	sender = "中央指挥部俄罗斯外联项目"
	announcement_text = "一群愤怒的俄罗斯人想开个派对。您能把货运穿梭机送过去，再让他们消失吗？"
	shuttle_transit_text = "开派对的俄罗斯人即将到达。"
	logging_desc = "俄罗斯派对小队"

/datum/shuttle_loan_situation/russian_party/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/datum/supply_pack/pack = SSshuttle.supply_packs[/datum/supply_pack/service/party]
	pack.generate(pick_n_take(empty_shuttle_turfs))

	spawn_list.Add(/mob/living/basic/trooper/russian)
	spawn_list.Add(/mob/living/basic/trooper/russian/ranged) //drops a mateba
	spawn_list.Add(/mob/living/basic/bear/russian)
	if(prob(75))
		spawn_list.Add(/mob/living/basic/trooper/russian)
	if(prob(50))
		spawn_list.Add(/mob/living/basic/bear/russian)

/datum/shuttle_loan_situation/spider_gift
	sender = "中央指挥部外交使团"
	announcement_text = "蜘蛛氏族给我们送来了一份神秘礼物。我们能把它运到您那里看看里面是什么吗？"
	shuttle_transit_text = "蜘蛛氏族的礼物即将到达。"
	logging_desc = "满载蜘蛛的穿梭机"

/datum/shuttle_loan_situation/spider_gift/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/datum/supply_pack/pack = SSshuttle.supply_packs[/datum/supply_pack/imports/specialops]
	pack.generate(pick_n_take(empty_shuttle_turfs))

	spawn_list.Add(/mob/living/basic/spider/giant)
	spawn_list.Add(/mob/living/basic/spider/giant)
	spawn_list.Add(/mob/living/basic/spider/giant/nurse)
	if(prob(50))
		spawn_list.Add(/mob/living/basic/spider/giant/hunter)

	var/turf/victim_turf = pick_n_take(empty_shuttle_turfs)

	new /obj/effect/decal/remains/human(victim_turf)
	new /obj/item/clothing/shoes/jackboots/fast(victim_turf)
	new /obj/item/clothing/mask/balaclava(victim_turf)

	for(var/i in 1 to 5)
		var/turf/web_turf = pick_n_take(empty_shuttle_turfs)
		new /obj/structure/spider/stickyweb(web_turf)

#define DENT_WALL "dent"
#define CHANGE_WALL "change"
#define DISMANTLE_WALL "dismantle"

#define BREAK_TILE "break"
#define PLATING_TILE "plating"
#define RUST_TILE "rust"

/**
 * A special shuttle loan situation enabled by the 'mail blocked' station trait.
 * It sends back a lot of mail to the station, at the cost of wrecking the cargo shuttle a little.
 */
/datum/shuttle_loan_situation/mail_strike
	sender = "顺旋邮政工人工会"
	announcement_text = "邮政工人工会想借用您的货运穿梭机来实施“先进工会罢工战术”。报酬严格以邮件支付。"
	bonus_points = 0
	thanks_msg = "货运穿梭机应在五分钟后返回。"
	shuttle_transit_text = "什么都阻挡不了邮件。"
	logging_desc = "满载可疑邮件的穿梭机"

/datum/shuttle_loan_situation/mail_strike/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	for(var/i in 1 to rand(7, 12))
		var/turf/closed/wall/wall = pick_n_take(blocked_shutte_turfs)
		if(!istype(wall))
			continue
		var/static/list/wall_bad_stuff = list(DENT_WALL = 85, CHANGE_WALL = 13, DISMANTLE_WALL = 2)
		var/static/list/possible_new_walls = list(
			/turf/closed/wall/mineral/sandstone,
			/turf/closed/wall/mineral/wood,
			/turf/closed/wall/mineral/iron,
			/turf/closed/wall/metal_foam_base,
			/turf/closed/wall/r_wall,
		)
		var/damage_done = pick_weight(wall_bad_stuff)
		switch(damage_done)
			if(DENT_WALL)
				for(var/dent in 1 to rand(1, MAX_DENT_DECALS))
					wall.add_dent(prob(90) ? WALL_DENT_SHOT : WALL_DENT_HIT)
			if(CHANGE_WALL)
				wall.ChangeTurf(pick(possible_new_walls - wall.type))
				if(prob(25))
					for(var/dent in 1 to rand(1, MAX_DENT_DECALS))
						wall.add_dent(prob(90) ? WALL_DENT_SHOT : WALL_DENT_HIT)
			if(DISMANTLE_WALL)
				wall.dismantle_wall()

	for(var/i in 1 to rand(7, 12))
		var/turf/open/floor/floor = pick_n_take(empty_shuttle_turfs)
		if(!istype(floor))
			continue
		var/static/list/floor_bad_stuff = list(BREAK_TILE = 65, PLATING_TILE = 25, RUST_TILE = 10)
		var/damage_done = pick_weight(floor_bad_stuff)
		switch(damage_done)
			if(BREAK_TILE)
				if(prob(50))
					floor.break_tile()
				else
					floor.burn_tile()
			if(PLATING_TILE)
				if(prob(25))
					floor.remove_tile()
				else
					floor.make_plating()
			if(RUST_TILE)
				floor.ChangeTurf(/turf/open/floor/plating/rust)
	if(prob(25))
		spawn_list += pick(/obj/effect/gibspawner/robot, /obj/effect/gibspawner/human)

	for(var/i in 1 to rand(4, 7))
		spawn_list += /obj/structure/closet/crate/mail/full/mail_strike

#undef BREAK_TILE
#undef PLATING_TILE
#undef RUST_TILE

#undef DENT_WALL
#undef CHANGE_WALL
#undef DISMANTLE_WALL
