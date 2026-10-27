///A pinata that has a chance to drop candy items when struck with a melee weapon that deals at least 10 damage
/obj/structure/pinata
	name = "柯基皮纳塔"
	desc = "用纸浆做的柯基犬造型皮纳塔，里面装满了各种甜食。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "pinata_placed"
	base_icon_state = "pinata_placed"
	max_integrity = 300 //20 hits from a baseball bat
	anchored = TRUE
	///What sort of candy the pinata will contain
	var/candy_options = list(
		/obj/item/food/bubblegum,
		/obj/item/food/candy,
		/obj/item/food/chocolatebar,
		/obj/item/food/gumball,
		/obj/item/food/lollipop/cyborg,
	)
	///How much candy is dropped when the pinata is destroyed
	var/destruction_loot = 5
	///Debris dropped when the pinata is destroyed
	var/debris = /obj/effect/decal/cleanable/wrapping/pinata

/obj/structure/pinata/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/pinata, candy = candy_options, death_drop = destruction_loot)

/obj/structure/pinata/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	. = ..()
	if(get_integrity() < (max_integrity/2))
		icon_state = "[base_icon_state]_damaged"
	if(damage_amount >= 10) // Swing means minimum damage threshold for dropping candy is met.
		flick("[icon_state]_swing", src)

/obj/structure/pinata/play_attack_sound(damage_amount, damage_type, damage_flag)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/items/weapons/slash.ogg', 50, TRUE)
			else
				playsound(src, 'sound/items/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/structure/pinata/atom_deconstruct(disassembled)
	new debris(get_turf(src))

///An item that when used inhand spawns an immovable pinata
/obj/item/pinata
	name = "皮纳塔组装套件"
	desc = "用纸浆做的柯基犬造型皮纳塔，内装各种糖果，得先组装好才能砸开。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "pinata"
	///The pinata that is created when this is placed.
	var/pinata_type = /obj/structure/pinata

/obj/item/pinata/attack_self(mob/user)
	var/turf/player_turf = get_turf(user)
	if(player_turf?.is_blocked_turf(TRUE))
		return FALSE
	balloon_alert_to_viewers("正在组装皮纳塔……")
	if(!do_after(user, 4 SECONDS, target = get_turf(user)))
		balloon_alert(user, "已取消！")
	new pinata_type(get_turf(user))
	balloon_alert(user, "皮纳塔组装完成")
	qdel(src)

/obj/structure/pinata/syndie
	name = "辛迪加柯基皮纳塔"
	desc = "用纸浆做的柯基犬造型皮纳塔，里面装着各种“劲爆”的玩意儿。"
	icon_state = "pinata_syndie_placed"
	base_icon_state = "pinata_syndie_placed"
	destruction_loot = 2
	debris = /obj/effect/decal/cleanable/wrapping/pinata/syndie
	candy_options = list(
		/obj/item/food/bubblegum,
		/obj/item/food/candy,
		/obj/item/food/chocolatebar,
		/obj/item/food/gumball,
		/obj/item/food/lollipop,
		/obj/item/grenade/c4,
		/obj/item/grenade/clusterbuster/soap,
		/obj/item/grenade/empgrenade,
		/obj/item/grenade/frag,
		/obj/item/grenade/syndieminibomb,
	) //Candy items at the top, explosives at the bottom to be easier to read instead of fully alphabetized.

/obj/item/pinata/syndie
	name = "军用级皮纳塔组装套件"
	desc = "用纸浆做的柯基犬造型皮纳塔，内装各种糖果和爆炸物，得先组装好才能砸开。"
	icon_state = "pinata_syndie"
	pinata_type = /obj/structure/pinata/syndie

/obj/structure/pinata/donk
	name = "咚克柯基皮纳塔"
	desc = "用纸浆做的柯基犬造型皮纳塔，里面装着各种咸香零食。"
	icon_state = "pinata_donk_placed"
	base_icon_state = "pinata_donk_placed"
	debris = /obj/effect/decal/cleanable/wrapping/pinata/donk
	candy_options = list(
		/obj/item/food/donkpocket/warm,
		/obj/item/food/donkpocket/warm/pizza,
		/obj/item/food/donkpocket/warm/honk,
		/obj/item/food/donkpocket/warm/berry,
		/obj/item/food/donkpocket/warm,
		/obj/item/food/tatortot,
		/obj/item/gun/ballistic/automatic/pistol/toy,
		/obj/item/hot_potato/harmless/toy,
		/obj/item/storage/box/donkpockets,
		/obj/item/toy/plush/donkpocket,
	)

/obj/item/pinata/donk
	name = "\improper 咚克公司皮纳塔组装套件"
	desc = "用纸浆做的柯基犬造型皮纳塔，内装各种食物和玩具，得先组装好才能砸开。"
	icon_state = "pinata_donk"
	pinata_type = /obj/structure/pinata/donk
