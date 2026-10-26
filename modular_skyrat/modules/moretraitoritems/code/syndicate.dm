/obj/item/uplink/old_radio
	name = "旧收音机"
	desc = "一台落满灰尘、看起来很旧的收音机。"

/obj/item/uplink/old_radio/Initialize(mapload, owner, tc_amount = 0)
	. = ..()
	var/datum/component/uplink/hidden_uplink = GetComponent(/datum/component/uplink)
	hidden_uplink.name = "旧收音机"

//Unrestricted MODs
/obj/item/mod/control/pre_equipped/elite/unrestricted
	req_access = null

//Syndie wep charger kit
/obj/item/storage/box/syndie_kit/recharger
	name = "盒装充电器套件"
	desc = "一个简洁坚固的盒子，装有建造武器充电器所需的全部零件。"
	icon_state = "syndiebox"

/obj/item/storage/box/syndie_kit/recharger/PopulateContents()
	new /obj/item/circuitboard/machine/recharger(src)
	new /obj/item/stock_parts/capacitor/quadratic(src)
	new /obj/item/stack/sheet/iron/five(src)
	new /obj/item/stack/cable_coil/five(src)
	new /obj/item/screwdriver/nuke(src)
	new /obj/item/wrench(src)

//Back-up space suit
/obj/item/storage/box/syndie_kit/space_suit
	name = "盒装太空服与头盔"
	desc = "一个简洁坚固的盒子，用于存放应急太空服。"
	icon_state = "syndiebox"
	illustration = "syndiesuit"

/obj/item/storage/box/syndie_kit/space_suit/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_BULKY
	atom_storage.max_slots = 2
	atom_storage.set_holdable(list(
		/obj/item/clothing/head/helmet/space/syndicate,
		/obj/item/clothing/suit/space/syndicate,
		))

/obj/item/storage/box/syndie_kit/space_suit/PopulateContents()
	switch(pick(list("red", "green", "dgreen", "blue", "orange", "black")))
		if("green")
			new /obj/item/clothing/head/helmet/space/syndicate/green(src)
			new /obj/item/clothing/suit/space/syndicate/green(src)
		if("dgreen")
			new /obj/item/clothing/head/helmet/space/syndicate/green/dark(src)
			new /obj/item/clothing/suit/space/syndicate/green/dark(src)
		if("blue")
			new /obj/item/clothing/head/helmet/space/syndicate/blue(src)
			new /obj/item/clothing/suit/space/syndicate/blue(src)
		if("red")
			new /obj/item/clothing/head/helmet/space/syndicate(src)
			new /obj/item/clothing/suit/space/syndicate(src)
		if("orange")
			new /obj/item/clothing/head/helmet/space/syndicate/orange(src)
			new /obj/item/clothing/suit/space/syndicate/orange(src)
		if("black")
			new /obj/item/clothing/head/helmet/space/syndicate/black(src)
			new /obj/item/clothing/suit/space/syndicate/black(src)

//Spy
/obj/item/clothing/suit/jacket/det_suit/noir/armoured
	armor_type = /datum/armor/heister

/obj/item/clothing/head/frenchberet/armoured
	armor_type = /datum/armor/cosmetic_sec

/obj/item/clothing/under/suit/black/armoured
	armor_type = /datum/armor/clothing_under/syndicate

/obj/item/clothing/under/suit/black/skirt/armoured
	armor_type = /datum/armor/clothing_under/syndicate

/obj/item/storage/belt/holster/detective/dark
	name = "深色皮革枪套"
	icon_state = "syndicate_holster"

//Robohand
/obj/item/storage/backpack/duffelbag/syndie/robohand/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/robohand(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/clothing/under/pants/track/robohand(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/glasses/sunglasses/robohand(src)
	new /obj/item/clothing/suit/toggle/jacket/trenchcoat/gunman(src)
	new /obj/item/autosurgeon/bodypart/r_arm_robotic(src)
	new /obj/item/autosurgeon/syndicate/esword_arm(src)
	new /obj/item/autosurgeon/syndicate/nodrop(src)


/obj/item/storage/box/syndie_kit/gunman_outfit
	name = "枪手服装套装"
	desc = "一盒时髦的防护服装，适合有志成为枪手的人。"

/obj/item/clothing/suit/toggle/jacket/trenchcoat/gunman
	name = "皮革大衣"
	desc = "一件带护甲的皮革大衣，是每位有志枪手的首选。"
	body_parts_covered = CHEST|GROIN|ARMS
	armor_type = /datum/armor/leather_gunman

/datum/armor/leather_gunman
	melee = 45
	bullet = 40
	laser = 40
	energy = 50
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/under/pants/track/robohand
	name = "硬汉长裤"
	desc = "一条奇妙地兼具硬挺与柔软的黑色长裤，似乎装有护甲衬垫以增强防护。"
	armor_type = /datum/armor/clothing_under/robohand

/datum/armor/clothing_under/robohand
	melee = 20
	bullet = 20
	laser = 20
	energy = 20
	bomb = 20

/obj/item/clothing/glasses/sunglasses/robohand
	name = "硬汉墨镜"
	desc = "一种古老得出奇的技术，提供基本眼部防护。强化遮光层可阻挡闪光。这副似乎还防弹？"
	body_parts_covered = HEAD //What do you mean glasses don't protect your head? Of course they do. Cyberpunk has flying cars(mostly intentional)!
	armor_type = /datum/armor/sunglasses_robohand

/datum/armor/sunglasses_robohand
	melee = 20
	bullet = 60
	laser = 20
	energy = 20
	bomb = 20
	wound = 5

//More items
/obj/item/guardian_creator/tech/choose/traitor/opfor
	allow_changeling = TRUE

/obj/item/codeword_granter
	name = "暗号手册"
	desc = "一本黑色手册，封面上的红色S由工厂最精良的印刷机悉心印制。"
	icon = 'modular_skyrat/modules/opposing_force/icons/items.dmi'
	icon_state = "codeword_book"
	/// Number of charges the book has, limits the number of times it can be used.
	var/charges = 1


/obj/item/codeword_granter/attack_self(mob/living/user)
	if(!isliving(user))
		return

	to_chat(user, span_boldannounce("你开始翻阅[src]，突然领悟了以下暗号："))

	user.AddComponent(/datum/component/codeword_hearing, SStraitor.syndicate_code_phrase_regex, "blue", src)
	user.AddComponent(/datum/component/codeword_hearing, SStraitor.syndicate_code_response_regex, "red", src)
	to_chat(user, "<b>暗语</b>：[jointext(SStraitor.syndicate_code_phrase, ", ")]")
	to_chat(user, "<b>回应</b>：[span_red("[jointext(SStraitor.syndicate_code_response, ", ")]")]")

	use_charge(user)


/obj/item/codeword_granter/attack(mob/living/attacked_mob, mob/living/user)
	if(!istype(attacked_mob) || !istype(user))
		return

	if(attacked_mob == user)
		attack_self(user)
		return

	playsound(loc, SFX_PUNCH, 25, TRUE, -1)

	if(attacked_mob.stat == DEAD)
		attacked_mob.visible_message(span_danger("[user]用[src]拍打[attacked_mob]毫无生气的尸体。"), span_userdanger("[user]用[src]拍打你毫无生气的尸体。"), span_hear("你听见拍打声。"))
	else
		attacked_mob.visible_message(span_notice("[user]用[src]敲打[attacked_mob]的头来传授知识！"), span_boldnotice("当[user]用[src]敲打你时，你突然领悟了一些[span_red("特定词语")]。"), span_hear("你听见拍打声。"))
		attacked_mob.AddComponent(/datum/component/codeword_hearing, SStraitor.syndicate_code_phrase_regex, "blue", src)
		attacked_mob.AddComponent(/datum/component/codeword_hearing, SStraitor.syndicate_code_response_regex, "red", src)
		to_chat(attacked_mob, span_boldnotice("你突然领悟了以下暗号："))
		to_chat(attacked_mob, "<b>暗语</b>：[span_blue("[jointext(SStraitor.syndicate_code_phrase, ", ")]")]")
		to_chat(attacked_mob, "<b>回应</b>：[span_red("[jointext(SStraitor.syndicate_code_response, ", ")]")]")
		use_charge(user)


/obj/item/codeword_granter/proc/use_charge(mob/user)
	charges--

	if(!charges)
		var/turf/src_turf = get_turf(src)
		src_turf.visible_message(span_warning("[src]的封面和内容开始变换！它从你的手中滑落！"))
		new /obj/item/book/manual/random(src_turf)
		qdel(src)


/obj/item/antag_granter
	icon = 'modular_skyrat/modules/opposing_force/icons/items.dmi'
	/// What antag datum to give
	var/antag_datum = /datum/antagonist/traitor
	/// What to tell the user when they use the granter
	var/user_message = ""


/obj/item/antag_granter/attack(mob/living/target_mob, mob/living/user, params)
	. = ..()

	if(target_mob != user) // As long as you're attacking yourself it counts.
		return
	attack_self(user)


/obj/item/antag_granter/attack_self(mob/user, modifiers)
	. = ..()
	if(!isliving(user) || !user.mind)
		return FALSE

	to_chat(user, span_notice(user_message))
	user.mind.add_antag_datum(antag_datum)
	qdel(src)
	return TRUE

/obj/item/antag_granter/changeling
	name = "病毒注射器"
	desc = "一支蓝色注射器，装着黏稠的红色物质。除了粗大针头附近的橙色警示条纹外，没有任何标记。"
	icon_state = "changeling_injector"
	antag_datum = /datum/antagonist/changeling
	user_message = "当你将这种物质注入体内时，你开始感觉……<span class='red'><b>更好了</b></span>。"


/obj/item/antag_granter/heretic
	name = "奇怪的书"
	desc = "一本紫色的书，封面上有一只绿色眼睛。你敢肯定它正在看着你……"
	icon_state = "heretic_granter"
	antag_datum = /datum/antagonist/heretic
	user_message = "当你翻开书时，眼前闪过一道强光，<span class='hypnophrase'>世界在你眼中变得无比清晰</span>。"

/obj/item/antag_granter/clock_cultist
	name = "黄铜机关"
	desc = "一个齿轮形状的黄铜装置，中央悬浮着一片玻璃透镜。"
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi'
	icon_state = "vanguard_cogwheel"
	antag_datum = /datum/antagonist/clock_cultist/solo
	user_message = "嗡鸣声充斥双耳，<span class='brass'>圣上的知识涌入你的脑海</span>。"

/obj/item/antag_granter/clock_cultist/attack_self(mob/user, modifiers)
	. = ..()
	if(!.)
		return FALSE

	var/obj/item/clockwork/clockwork_slab/slab = new
	user.put_in_hands(slab, FALSE)
