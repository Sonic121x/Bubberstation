/obj/item/storage/backpack/duffelbag
	name = "行李袋"
	desc = "一个大号行李袋，用于存放额外物品。"
	icon_state = "duffel"
	inhand_icon_state = "duffel"
	actions_types = list(/datum/action/item_action/zipper)
	storage_type = /datum/storage/duffel
	// How much to slow you down if your bag isn't zipped up
	var/zip_slowdown = 1
	/// If this bag is zipped (contents hidden) up or not
	/// Starts enabled so you're forced to interact with it to "get" it
	var/zipped_up = TRUE
	// How much time it takes to zip up (close) the duffelbag
	var/zip_up_duration = 0.5 SECONDS
	// Audio played during zipup
	var/zip_up_sfx = 'sound/items/zip/zip_up.ogg'
	// How much time it takes to unzip the duffel
	var/unzip_duration = 2.1 SECONDS
	// Audio played during unzip
	var/unzip_sfx = 'sound/items/zip/un_zip.ogg'

/obj/item/storage/backpack/duffelbag/Initialize(mapload)
	. = ..()
	slowdown += zip_slowdown
	set_zipper(TRUE)
	RegisterSignal(src, COMSIG_SPEED_POTION_APPLIED, PROC_REF(on_speed_potioned))

/obj/item/storage/backpack/duffelbag/examine(mob/user)
	. = ..()
	. += "[zipped_up ? "拉链已拉上，你无法取出其中的物品。" : "拉链已拉开，行动起来更迟缓。"]"

/obj/item/storage/backpack/duffelbag/attack_self(mob/user, modifiers)
	if(loc != user) // God fuck TK
		return ..()
	if(zipped_up)
		return attack_hand(user, modifiers)
	else
		return attack_hand_secondary(user, modifiers)

/obj/item/storage/backpack/duffelbag/attack_self_secondary(mob/user, modifiers)
	attack_self(user, modifiers)
	return ..()

// If we're zipped, click to unzip
/obj/item/storage/backpack/duffelbag/attack_hand(mob/user, list/modifiers)
	if(loc != user)
		// Hacky, but please don't be cringe yeah?
		atom_storage.silent = TRUE
		. = ..()
		atom_storage.silent = initial(atom_storage.silent)
		return
	if(!zipped_up)
		return ..()

	balloon_alert(user, "正在拉开拉链……")
	playsound(src, unzip_sfx, 100, FALSE)
	var/datum/callback/can_unzip = CALLBACK(src, PROC_REF(zipper_matches), TRUE)
	if(!do_after(user, unzip_duration, src, extra_checks = can_unzip))
		user.balloon_alert(user, "拉开拉链失败！")
		return
	balloon_alert(user, "已拉开拉链")
	set_zipper(FALSE)
	return TRUE

// Vis versa
/obj/item/storage/backpack/duffelbag/attack_hand_secondary(mob/user, list/modifiers)
	if(loc != user)
		return ..()
	if(zipped_up)
		return SECONDARY_ATTACK_CALL_NORMAL

	balloon_alert(user, "正在拉上拉链……")
	playsound(src, zip_up_sfx, 100, FALSE)
	var/datum/callback/can_zip = CALLBACK(src, PROC_REF(zipper_matches), FALSE)
	if(!do_after(user, zip_up_duration, src, extra_checks = can_zip))
		user.balloon_alert(user, "拉上拉链失败！")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	balloon_alert(user, "已拉上拉链")
	set_zipper(TRUE)
	return SECONDARY_ATTACK_CONTINUE_CHAIN

/// Checks to see if the zipper matches the passed in state
/// Returns true if so, false otherwise
/obj/item/storage/backpack/duffelbag/proc/zipper_matches(matching_value)
	return zipped_up == matching_value

/obj/item/storage/backpack/duffelbag/proc/set_zipper(new_zip)
	zipped_up = new_zip
	SEND_SIGNAL(src, COMSIG_DUFFEL_ZIP_CHANGE, new_zip)
	if(zipped_up)
		slowdown -= zip_slowdown
		atom_storage.set_locked(STORAGE_SOFT_LOCKED)
		atom_storage.display_contents = FALSE
	else
		slowdown += zip_slowdown
		atom_storage.set_locked(STORAGE_NOT_LOCKED)
		atom_storage.display_contents = TRUE

	if(isliving(loc))
		var/mob/living/wearer = loc
		wearer.update_equipment_speed_mods()

/// Signal handler for [COMSIG_SPEED_POTION_APPLIED]. Speed potion removes the unzipped slowdown
/obj/item/storage/backpack/duffelbag/proc/on_speed_potioned(datum/source)
	SIGNAL_HANDLER
	// Don't need to touch the actual slowdown here, since the speed potion does it for us
	zip_slowdown = 0

/obj/item/storage/backpack/duffelbag/cursed
	name = "活化行李袋"
	desc = "一只被诅咒的小丑行李袋，渴望任何种类的食物。警告标签提示它会吃掉里面的食物。\
		如果那些食物是糟糕透顶的废料、被厨师从微波炉里丢出来的残渣，或以某种方式被下了毒，\
		那它可能会对袋子产生负面效果……"
	icon_state = "duffel-curse"
	inhand_icon_state = "duffel-curse"
	zip_slowdown = 2
	max_integrity = 100

/obj/item/storage/backpack/duffelbag/cursed/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/curse_of_hunger, add_dropdel = TRUE)

/obj/item/storage/backpack/duffelbag/captain
	name = "舰长行李袋"
	desc = "一个大号行李袋，用于存放舰长的额外物品。"
	icon_state = "duffel-captain"
	inhand_icon_state = "duffel-captain"

/obj/item/storage/backpack/duffelbag/med
	name = "医疗行李袋"
	desc = "一个大号行李袋，用于存放额外的医疗用品。"
	icon_state = "duffel-medical"
	inhand_icon_state = "duffel-med"

/obj/item/storage/backpack/duffelbag/chief_medic
	name = "首席医疗官行李袋"
	desc = "一个大号行李袋，可一次性承担整个医疗部的职责。"
	icon_state = "duffel-chiefmedical"
	inhand_icon_state = "duffel-med"

/obj/item/storage/backpack/duffelbag/coroner
	name = "验尸官行李袋"
	desc = "一个大号行李袋，可一次性存放大量器官。"
	icon_state = "duffel-coroner"
	inhand_icon_state = "duffel-coroner"

/obj/item/storage/backpack/duffelbag/explorer
	name = "探险家行李袋"
	desc = "一个大号行李袋，用于存放额外的异域珍宝。"
	icon_state = "duffel-explorer"
	inhand_icon_state = "duffel-explorer"

/obj/item/storage/backpack/duffelbag/hydroponics
	name = "水培行李袋"
	desc = "一个大号行李袋，用于存放额外的园艺工具。"
	icon_state = "duffel-hydroponics"
	inhand_icon_state = "duffel-hydroponics"

/obj/item/storage/backpack/duffelbag/chemistry
	name = "化学行李袋"
	desc = "一个大号行李袋，用于存放额外的化学物质。"
	icon_state = "duffel-chemistry"
	inhand_icon_state = "duffel-chemistry"

/obj/item/storage/backpack/duffelbag/genetics
	name = "基因学家行李袋"
	desc = "一个大号行李袋，用于存放额外的基因突变。"
	icon_state = "duffel-genetics"
	inhand_icon_state = "duffel-genetics"

/obj/item/storage/backpack/duffelbag/science
	name = "科学家行李袋"
	desc = "一个大号行李袋，用于存放额外的科研组件。"
	icon_state = "duffel-science"
	inhand_icon_state = "duffel-sci"

/obj/item/storage/backpack/duffelbag/virology
	name = "病毒学家行李袋"
	desc = "一个大号行李袋，用于存放额外的病毒瓶。"
	icon_state = "duffel-virology"
	inhand_icon_state = "duffel-virology"

/obj/item/storage/backpack/duffelbag/sec
	name = "安保行李袋"
	desc = "一个大号行李袋，用于存放额外的安保用品与弹药。"
	icon_state = "duffel-security"
	inhand_icon_state = "duffel-sec"

/obj/item/storage/backpack/duffelbag/sec/surgery
	name = "手术行李袋"
	desc = "一个大号行李袋，用于存放额外用品——这一款内嵌衬层，可放置各种锋利的工具。"

/obj/item/storage/backpack/duffelbag/sec/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/circular_saw(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/cautery(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/clothing/suit/toggle/labcoat/hospitalgown(src)	//SKYRAT EDIT ADDITION
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/blood_filter(src)

/obj/item/storage/backpack/duffelbag/engineering
	name = "工业行李袋"
	desc = "一个大号行李袋，用于存放额外的工具和用品。"
	icon_state = "duffel-engineering"
	inhand_icon_state = "duffel-eng"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/duffelbag/drone
	name = "无人机行李袋"
	desc = "一个大号行李袋，用于存放工具和帽子。"
	icon_state = "duffel-drone"
	inhand_icon_state = "duffel-drone"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/duffelbag/drone/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)

/obj/item/storage/backpack/duffelbag/clown
	name = "小丑行李袋"
	desc = "一个大号行李袋，用于存放许多搞笑道具！"
	icon_state = "duffel-clown"
	inhand_icon_state = "duffel-clown"

/obj/item/storage/backpack/duffelbag/clown/cream_pie/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/food/pie/cream(src)

/obj/item/storage/backpack/fireproof
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/duffelbag/syndie
	name = "战术行李袋" // BUBBER EDIT CHANGE: Just a normal bag. Original: name = "suspicious looking duffel bag"
	desc = "一个大号行李袋，用于存放额外的战术补给。" // BUBBER EDIT CHANGE: Just a normal bag. Original: desc = "A large duffel bag for holding extra tactical supplies. It contains an oiled plastitanium zipper for maximum speed tactical zipping, and is better balanced on your back than an average duffelbag. Can hold two bulky items!"
	icon_state = "duffel-syndie"
	inhand_icon_state = "duffel-syndieammo"
	storage_type = /datum/storage/duffel/syndicate
	resistance_flags = FIRE_PROOF
	// Less slowdown while unzipped. Still bulky, but it won't halve your movement speed in an active combat situation.
	zip_slowdown = 0.3
	// Faster unzipping. Utilizes the same noise as zipping up to fit the unzip duration.
	unzip_duration = 0.5 SECONDS
	unzip_sfx = 'sound/items/zip/zip_up.ogg'

	// BUBBER EDIT ADDITION BEGIN: Just a normal bag.
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "这只行李袋内侧缝有辛迪加标志。它似乎由更轻却更坚固的材料制成，并配有上油的塑钛拉链，以便以最快速度完成战术拉链操作。"
	// BUBBER EDIT ADDITION END: Just a normal bag.

/obj/item/storage/backpack/duffelbag/syndie/hitman
	desc = "一个大号行李袋，用于存放额外物品。背面印有纳米传讯标志。"
	icon_state = "duffel-syndieammo"
	inhand_icon_state = "duffel-syndieammo"

/obj/item/storage/backpack/duffelbag/syndie/hitman/PopulateContents()
	new /obj/item/clothing/under/costume/buttondown/slacks/service(src)
	new /obj/item/clothing/neck/tie/red/hitman(src)
	new /obj/item/clothing/accessory/waistcoat(src)
	new /obj/item/clothing/suit/toggle/lawyer/black(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/head/fedora(src)

/obj/item/storage/backpack/duffelbag/syndie/med
	name = "医疗行李袋"
	desc = "一个大号行李袋，用于存放额外的战术医疗用品。"
	icon_state = "duffel-syndiemed"
	inhand_icon_state = "duffel-syndiemed"

/obj/item/storage/backpack/duffelbag/syndie/surgery
	name = "手术行李袋"
	desc = "一个大号行李袋，用于存放额外用品——这一款内嵌衬层，可放置各种锋利的工具。" // BUBBER EDIT CHANGE: Just a normal bag. Original: desc = "A suspicious looking duffel bag for holding surgery tools."
	icon_state = "duffel-syndiemed"
	inhand_icon_state = "duffel-syndiemed"

	// BUBBER EDIT ADDITION BEGIN: Just a normal bag.
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "这只行李袋内侧缝有辛迪加标志。它似乎由更轻却更坚固的材料制成。"
	// BUBBER EDIT ADDITION END: Just a normal bag.

/obj/item/storage/backpack/duffelbag/syndie/surgery/PopulateContents()
	new /obj/item/scalpel/advanced(src)
	new /obj/item/retractor/advanced(src)
	new /obj/item/cautery/advanced(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/reagent_containers/medigel/sterilizine(src)
	new /obj/item/bonesetter(src)
	new /obj/item/blood_filter(src)
	new /obj/item/stack/medical/bone_gel(src)
	new /obj/item/stack/medical/wrap/sticky_tape/surgical(src)
	new /obj/item/emergency_bed(src)
	new /obj/item/clothing/suit/jacket/straight_jacket(src)
	new /obj/item/clothing/mask/muzzle(src)
	new /obj/item/brain_processor/organic/syndie(src)

/obj/item/storage/backpack/duffelbag/syndie/ammo
	name = "弹药行李袋"
	desc = "一个大号行李袋，用于存放额外的武器弹药与补给。"
	icon_state = "duffel-syndieammo"
	inhand_icon_state = "duffel-syndieammo"

/obj/item/storage/backpack/duffelbag/syndie/ammo/darkgygax
	name = "\improper 暗黑吉盖克斯弹药行李袋"
	desc = "一个大号行李袋，塞满了供外骨骼霰弹武器使用的弹药，适合为暗黑吉盖克斯的标准配置提供补给。"

/obj/item/storage/backpack/duffelbag/syndie/ammo/darkgygax/PopulateContents()
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/storage/belt/utility/syndicate(src)

/obj/item/storage/backpack/duffelbag/syndie/ammo/mauler
	name = "\improper 蹂躏者弹药行李袋"
	desc = "一个大号行李袋，塞满了各种外骨骼弹药，适合为暗黑吉盖克斯的标准配置提供补给。"

/obj/item/storage/backpack/duffelbag/syndie/ammo/mauler/PopulateContents()
	new /obj/item/mecha_ammo/lmg(src)
	new /obj/item/mecha_ammo/lmg(src)
	new /obj/item/mecha_ammo/lmg(src)
	new /obj/item/mecha_ammo/missiles_srm(src)
	new /obj/item/mecha_ammo/missiles_srm(src)
	new /obj/item/mecha_ammo/missiles_srm(src)
	new /obj/item/storage/belt/utility/syndicate(src)

/obj/item/storage/backpack/duffelbag/syndie/med/medicalbundle
	desc = "一个大号行李袋，内含一套医疗设备、一挺咚克软弹轻机枪、一大盒防暴飞镖，以及一个磁力靴 MOD 外骨骼模块。"

/obj/item/storage/backpack/duffelbag/syndie/med/medicalbundle/PopulateContents()
	new /obj/item/mod/module/magboot(src)
	new /obj/item/storage/medkit/tactical/premium(src)
	new /obj/item/gun/ballistic/automatic/l6_saw/toy(src)
	new /obj/item/ammo_box/foambox/riot(src)

/obj/item/storage/backpack/duffelbag/syndie/med/bioterrorbundle
	desc = "一个大号行李袋，内含致命化学品、一把手持化学喷雾器、一枚生物恐怖泡沫手榴弹、一把咚克软弹突击步枪、一盒防暴级飞镖、一把飞镖手枪和一盒注射器。"

/obj/item/storage/backpack/duffelbag/syndie/med/bioterrorbundle/PopulateContents()
	new /obj/item/reagent_containers/spray/chemsprayer/bioterror(src)
	new /obj/item/storage/box/syndie_kit/chemical(src)
	new /obj/item/gun/syringe/syndicate(src)
	new /obj/item/gun/ballistic/automatic/c20r/toy(src)
	new /obj/item/storage/box/syringes(src)
	new /obj/item/ammo_box/foambox/riot(src)
	new /obj/item/grenade/chem_grenade/bioterrorfoam(src)
	if(prob(5))
		new /obj/item/food/pizza/pineapple(src)

/obj/item/storage/backpack/duffelbag/syndie/c4/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/grenade/c4(src)

/obj/item/storage/backpack/duffelbag/syndie/x4/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/grenade/c4/x4(src)

/obj/item/storage/backpack/duffelbag/syndie/firestarter
	desc = "一个大号行李袋，内含新俄罗斯喷火背包喷射器、精英 MOD 外骨骼、一把斯捷奇金 APS 手枪、迷你炸弹、弹药及其他装备。"

/obj/item/storage/backpack/duffelbag/syndie/firestarter/PopulateContents()
	new /obj/item/clothing/under/syndicate/soviet(src)
	new /obj/item/mod/control/pre_equipped/elite/flamethrower(src)
	new /obj/item/gun/ballistic/automatic/pistol/aps(src)
	new /obj/item/ammo_box/magazine/m9mm_aps/fire(src)
	new /obj/item/ammo_box/magazine/m9mm_aps/fire(src)
	new /obj/item/reagent_containers/cup/glass/bottle/vodka/badminka(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimulants(src)
	new /obj/item/grenade/syndieminibomb(src)

// For ClownOps.
/obj/item/storage/backpack/duffelbag/clown/syndie
	storage_type = /datum/storage/duffel/syndicate

/obj/item/storage/backpack/duffelbag/clown/syndie/PopulateContents()
	new /obj/item/modular_computer/pda/crew/clown(src)
	new /obj/item/clothing/under/rank/civilian/clown(src)
	new /obj/item/clothing/shoes/clown_shoes(src)
	new /obj/item/clothing/mask/gas/clown_hat(src)
	new /obj/item/bikehorn(src)
	new /obj/item/implanter/sad_trombone(src)

/obj/item/storage/backpack/henchmen
	name = "翅膀"
	desc = "授予配得上的喽啰。这大概不包括你。"
	icon_state = "henchmen"
	inhand_icon_state = null

/obj/item/storage/backpack/duffelbag/cops
	name = "警用包"
	desc = "一个大号行李袋，用于存放额外的警用装备。"

/obj/item/storage/backpack/duffelbag/mining_conscript
	name = "采矿征召套件"
	desc = "一个行李袋，内含船员在野外支援竖井矿工所需的一切。"
	icon_state = "duffel-explorer"
	inhand_icon_state = "duffel-explorer"

/obj/item/storage/backpack/duffelbag/mining_conscript/PopulateContents()
	new /obj/item/clothing/glasses/meson(src)
	new /obj/item/t_scanner/adv_mining_scanner/lesser(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/clothing/suit/hooded/explorer(src)
	new /obj/item/encryptionkey/headset_mining(src)
	new /obj/item/clothing/mask/gas/explorer(src)
	new /obj/item/card/id/advanced/mining(src)
	new /obj/item/gun/energy/recharge/kinetic_accelerator(src)
	new /obj/item/knife/combat/survival(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/stack/candela_beacon/thirty(src)
