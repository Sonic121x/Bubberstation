// Bottle of painkiller pills
/obj/item/storage/pill_bottle/painkiller
	name = "阿莫林药瓶"
	desc = "一个用于存放药物的密封容器。这一瓶通体白色，标签表明里面装的是阿莫林——矿工药膏与利多卡因的混合物。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "painkiller_bottle"
	custom_price = PAYCHECK_CREW * 1.5
	spawn_type = /obj/item/reagent_containers/applicator/pill/amollin
	spawn_count = 7

/obj/item/reagent_containers/applicator/pill/amollin
	name = "阿莫林药片"
	desc = "可中和许多常见的疼痛与不适。由矿工药膏与利多卡因混合而成。"
	icon_state = "pill9"
	layers_remaining = 1
	list_reagents = list(
		/datum/reagent/medicine/mine_salve = 10,
		/datum/reagent/medicine/lidocaine = 5,
		/datum/reagent/consumable/sugar = 5,
	)

// Narcolepsy quirk medicines
/obj/item/storage/pill_bottle/prescription_stimulant
	name = "阿利非药瓶"
	desc = "一种特殊的小型药瓶，内部插片形似左轮弹巢，专为“民防”级外壳医疗包的内部空间而设计。可装五片阿利非药片，且只接受其专用的德福雷斯特(tm) 形状。侧面贴着一张醒目的大号黄色警告标签：“请遵照剂量说明”。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "painkiller_bottle"
	w_class = WEIGHT_CLASS_TINY // this is fine because we hard limit what can go in this thing
	spawn_type = /obj/item/reagent_containers/applicator/pill/prescription_stimulant
	spawn_count = 5

/obj/item/storage/pill_bottle/prescription_stimulant/Initialize(mapload)
	. = ..()
	// Make sure we can only hold alifil pills since this is nested inside a symptom support kit
	atom_storage.max_slots = 5
	atom_storage.set_holdable(list(
		/obj/item/reagent_containers/applicator/pill/prescription_stimulant,
	))

/obj/item/reagent_containers/applicator/pill/prescription_stimulant
	name = "阿利非药片"
	desc = "用于治疗嗜睡和突发性意识丧失的症状。含有糖、突触嗪和莫达非尼的混合物。警告标签写道：<b>请适量服用</b>。"
	icon_state = "pill15"
	list_reagents = list(
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/medicine/synaptizine = 5,
		/datum/reagent/medicine/modafinil = 3
	)

// Pre-packed civil defense medkit, with items to heal low damages inside
/obj/item/storage/medkit/civil_defense
	name = "民防医疗包"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "poisoning_kit"
	lefthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_righthand.dmi'
	inhand_icon_state = "poisoning_kit"
	desc = "一个小型医疗包，里面只能装自动注射器；通常配有处理轻度伤害的补给。"
	w_class = WEIGHT_CLASS_SMALL
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound = 'sound/items/handling/ammobox_pickup.ogg'
	custom_price = PAYCHECK_COMMAND * 3

/obj/item/storage/medkit/civil_defense/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 4
	atom_storage.set_holdable(list(
		/obj/item/reagent_containers/hypospray/medipen,
		/obj/item/storage/pill_bottle/prescription_stimulant,
	))

/obj/item/storage/medkit/civil_defense/stocked

/obj/item/storage/medkit/civil_defense/stocked/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/meridine = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lipital = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/calopine = 1,
	)
	generate_items_inside(items_inside,src)

// Variant on the civil defense medkit for spacer planetside personnel (or other people suffering from chronic illnesses)
/obj/item/storage/medkit/civil_defense/comfort
	name = "民防症状缓解包"
	desc = "一个小巧、可放进口袋的包，里面通常只能装自动注射器。这一经典“奶酪”民防包的变体装有补给，用于缓解常见慢性疾病或适应综合征（如重力病）所带来的症状负担。"
	icon_state = "symptom_kit"

/obj/item/storage/medkit/civil_defense/comfort/stocked

/obj/item/storage/medkit/civil_defense/comfort/stocked/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/psifinil = 3,
		/obj/item/storage/pill_bottle/prescription_stimulant = 1,
	)
	generate_items_inside(items_inside, src)

// Pre-packed frontier medkit, with supplies to repair most common frontier health issues
/obj/item/storage/medkit/frontier
	name = "边疆医疗包"
	desc = "一种便捷的卷顶式防水医疗包，在前沿地区医疗支援不够理想时常能见到。 \
		它带有一个可挂在腰带上的夹扣，很方便！"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "frontier"
	lefthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_righthand.dmi'
	inhand_icon_state = "frontier"
	worn_icon = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn_teshari.dmi'
	pickup_sound = SFX_CLOTH_PICKUP
	drop_sound = SFX_CLOTH_DROP
	slot_flags = ITEM_SLOT_BELT

/obj/item/storage/medkit/frontier/stocked

/obj/item/storage/medkit/frontier/stocked/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/meridine = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/morpital = 1,
		/obj/item/stack/medical/ointment = 1,
		/obj/item/stack/medical/suture = 1,
		/obj/item/stack/medical/suture/coagulant = 1,
		/obj/item/stack/medical/wrap/gauze/sterilized = 1,
		/obj/item/storage/pill_bottle/painkiller = 1,
	)
	generate_items_inside(items_inside,src)

// Pre-packed combat surgeon medkit, with items for fixing more specific injuries and wounds
/obj/item/storage/medkit/combat_surgeon
	name = "战地外科医疗包"
	desc = "一个可折叠的医疗包，理想情况下装有外科工具与针对许多较难处理伤口的专门治疗方案。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "surgeon"
	lefthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_righthand.dmi'
	inhand_icon_state = "surgeon"
	worn_icon = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn_teshari.dmi'
	worn_icon_state = "frontier"
	pickup_sound = SFX_CLOTH_PICKUP
	drop_sound = SFX_CLOTH_DROP

/obj/item/storage/medkit/combat_surgeon/stocked/PopulateContents()
	var/static/items_inside = list(
		/obj/item/bonesetter = 1,
		/obj/item/hemostat = 1,
		/obj/item/cautery = 1,
		/obj/item/stack/medical/wound_recovery = 1,
		/obj/item/stack/medical/wound_recovery/rapid_coagulant = 1,
		/obj/item/stack/medical/wrap/gauze/sterilized = 1,
		/obj/item/healthanalyzer/simple = 1,
	)
	generate_items_inside(items_inside,src)

// Big medical kit that can be worn like a bag, holds a LOT of medical items but works like a duffelbag
/obj/item/storage/backpack/duffelbag/deforest_medkit
	name = "挎包式医疗包"
	desc = "一个橙色大挎包，几乎能装下你能想到的任何小型医疗设备，甚至还能背在背上或挂在腰带上！"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "satchel"
	lefthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_righthand.dmi'
	inhand_icon_state = "satchel"
	worn_icon = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn_teshari.dmi'
	equip_sound = 'sound/items/equip/jumpsuit_equip.ogg'
	pickup_sound = SFX_CLOTH_PICKUP
	drop_sound = SFX_CLOTH_DROP
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	storage_type = /datum/storage/duffel/deforest_medkit
	zip_slowdown = 0.25 // Most won't notice normally but it'll hurt you if you're a paramedic or in combat
	unzip_duration = 1.2 SECONDS

/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked

/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/morpital = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lipital = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/meridine = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/calopine = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = 1,
		/obj/item/bonesetter = 1,
		/obj/item/hemostat = 1,
		/obj/item/cautery = 1,
		/obj/item/stack/medical/wound_recovery = 1,
		/obj/item/stack/medical/wound_recovery/rapid_coagulant = 1,
		/obj/item/stack/medical/suture/coagulant = 1,
		/obj/item/stack/medical/suture/bloody = 2,
		/obj/item/stack/medical/mesh = 2,
		/obj/item/stack/medical/wrap/gauze/sterilized = 1,
		/obj/item/stack/medical/wrap/gauze = 1,
		/obj/item/stack/medical/ointment/red_sun = 1,
		/obj/item/storage/pill_bottle/painkiller = 1,
		/obj/item/healthanalyzer/simple = 1,
	)
	generate_items_inside(items_inside,src)

/datum/storage/duffel/deforest_medkit
	max_specific_storage = WEIGHT_CLASS_SMALL
	max_total_storage = 21 * WEIGHT_CLASS_SMALL
	max_slots = 21

/datum/storage/duffel/deforest_medkit/New()
	. = ..()

	can_hold = typecacheof(list(
		/obj/item/bonesetter,
		/obj/item/blood_scanner,
		/obj/item/cautery,
		/obj/item/clothing/neck/stethoscope,
		/obj/item/clothing/mask/breath,
		/obj/item/clothing/mask/muzzle,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/suit/toggle/labcoat/hospitalgown,
		/obj/item/dnainjector,
		/obj/item/extinguisher/mini,
		/obj/item/flashlight/pen,
		/obj/item/flesh_shears/medical,
		/obj/item/geiger_counter,
		/obj/item/healthanalyzer,
		/obj/item/hemostat,
		/obj/item/holosign_creator/medical,
		/obj/item/hypospray,
		/obj/item/implant,
		/obj/item/implantcase,
		/obj/item/implanter,
		/obj/item/lazarus_injector,
		/obj/item/lighter,
		/obj/item/pinpointer/crew,
		/obj/item/reagent_containers/blood,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/vial,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/applicator/patch/,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/syringe,
		/obj/item/reflexhammer,
		/obj/item/stack/medical,
		/obj/item/stack/medical/wrap/sticky_tape,
		/obj/item/sensor_device,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/hypospraykit,
		/obj/item/storage/pill_bottle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tourniquet,
		/obj/item/storage/box/bandages,
		/obj/item/bodybag,
	))

// Big surgical kit that can be worn like a bag, holds 14 normal items (more than what a backpack can do!) but works like a duffelbag
/obj/item/storage/backpack/duffelbag/deforest_surgical
	name = "急救外科医疗包"
	desc = "一个大包，能装下你能想到的所有外科工具和急救治疗设备，甚至还能穿戴在身上！"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "super_surgery"
	lefthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_righthand.dmi'
	inhand_icon_state = "super_surgery"
	worn_icon = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn_teshari.dmi'
	equip_sound = 'sound/items/equip/jumpsuit_equip.ogg'
	pickup_sound = SFX_CLOTH_PICKUP
	drop_sound = SFX_CLOTH_DROP
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	storage_type = /datum/storage/duffel/deforest_big_surgery
	zip_slowdown = 0.5 // Its a bulkier bag and thus slows you down a little more when unzipped
	unzip_duration = 1.2 SECONDS

/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked

/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked/PopulateContents()
	var/static/items_inside = list(
		/obj/item/scalpel = 1,
		/obj/item/hemostat = 1,
		/obj/item/retractor = 1,
		/obj/item/circular_saw = 1,
		/obj/item/bonesetter = 1,
		/obj/item/cautery = 1,
		/obj/item/surgical_drapes = 1,
		/obj/item/blood_filter = 1,
		/obj/item/emergency_bed = 1,
		/obj/item/stack/medical/wrap/gauze = 1,
		/obj/item/stack/medical/wrap/gauze/sterilized = 1,
		/obj/item/reagent_containers/medigel/sterilizine = 1,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 1,
		/obj/item/storage/pill_bottle/painkiller = 1,
	)
	generate_items_inside(items_inside,src)

/datum/storage/duffel/deforest_big_surgery
	max_total_storage = 14 * WEIGHT_CLASS_NORMAL
	max_slots = 14

/datum/storage/duffel/deforest_big_surgery/New()
	. = ..()

	can_hold = typecacheof(list(
		/obj/item/autopsy_scanner,
		/obj/item/blood_filter,
		/obj/item/blood_scanner,
		/obj/item/bonesetter,
		/obj/item/cautery,
		/obj/item/circular_saw,
		/obj/item/clothing/glasses,
		/obj/item/clothing/gloves,
		/obj/item/clothing/neck/stethoscope,
		/obj/item/clothing/mask/breath,
		/obj/item/clothing/mask/muzzle,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/suit/toggle/labcoat/hospitalgown,
		/obj/item/construction/plumbing,
		/obj/item/dnainjector,
		/obj/item/extinguisher/mini,
		/obj/item/flashlight/pen,
		/obj/item/flesh_shears/medical,
		/obj/item/geiger_counter,
		/obj/item/gun/syringe/syndicate,
		/obj/item/healthanalyzer,
		/obj/item/hemostat,
		/obj/item/holosign_creator/medical,
		/obj/item/hypospray,
		/obj/item/implant,
		/obj/item/implantcase,
		/obj/item/implanter,
		/obj/item/lazarus_injector,
		/obj/item/lighter,
		/obj/item/pinpointer/crew,
		/obj/item/plunger,
		/obj/item/radio,
		/obj/item/reagent_containers/blood,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/vial,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/applicator/patch/,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/syringe,
		/obj/item/reflexhammer,
		/obj/item/retractor,
		/obj/item/scalpel,
		/obj/item/shears,
		/obj/item/stack/medical,
		/obj/item/stack/medical/wrap/sticky_tape,
		/obj/item/stamp,
		/obj/item/sensor_device,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/hypospraykit,
		/obj/item/storage/pill_bottle,
		/obj/item/surgical_drapes,
		/obj/item/surgical_processor,
		/obj/item/surgicaldrill,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tourniquet,
		/obj/item/weaponcell/medical,
		/obj/item/handheld_soulcatcher,
		/obj/item/wrench/medical,
		/obj/item/emergency_bed,
		/obj/item/storage/box/bandages,
		/obj/item/bodybag,
	))

// Midrange bag for paramedics, hypospray and more flexible item wise than surgical, but restricted to small items only
/obj/item/storage/backpack/duffelbag/deforest_paramedic
	name = "医疗技术员医疗包"
	desc = "一套可挂在腰带上的医疗装备包。与其同类的急救外科医疗包相比，这一款为四处巡诊的急救员配备了无针注射器。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "technician"
	lefthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_righthand.dmi'
	inhand_icon_state = "technician"
	worn_icon = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn_teshari.dmi'
	equip_sound = 'sound/items/equip/jumpsuit_equip.ogg'
	pickup_sound = SFX_CLOTH_PICKUP
	drop_sound = SFX_CLOTH_DROP
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	storage_type = /datum/storage/duffel/deforest_paramedic
	zip_slowdown = 0.3 // Midrange between the other two bags
	unzip_duration = 1.2 SECONDS

/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked

/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked/PopulateContents()
	var/static/items_inside = list(
		/obj/item/scalpel = 1,
		/obj/item/hemostat = 1,
		/obj/item/retractor = 1,
		/obj/item/circular_saw/field_medic = 1,
		/obj/item/bonesetter = 1,
		/obj/item/cautery = 1,
		/obj/item/surgical_drapes = 1,
		/obj/item/stack/medical/bone_gel = 1,
		/obj/item/stack/medical/wound_recovery = 1,
		/obj/item/stack/medical/mesh/advanced = 1,
		/obj/item/stack/medical/suture/medicated = 1,
		/obj/item/stack/medical/wrap/gauze/sterilized = 1,
		/obj/item/storage/pill_bottle/painkiller = 1,
		/obj/item/storage/hypospraykit/paramedic = 1,
	)
	generate_items_inside(items_inside,src)

/datum/storage/duffel/deforest_paramedic
	max_specific_storage = WEIGHT_CLASS_NORMAL
	max_total_storage = 14 * WEIGHT_CLASS_NORMAL
	max_slots = 14

/datum/storage/duffel/deforest_paramedic/New()
	. = ..()

	can_hold = typecacheof(list(
		/obj/item/blood_filter,
		/obj/item/blood_scanner,
		/obj/item/bonesetter,
		/obj/item/cautery,
		/obj/item/circular_saw,
		/obj/item/clothing/neck/stethoscope,
		/obj/item/clothing/mask/breath,
		/obj/item/clothing/mask/muzzle,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/suit/toggle/labcoat/hospitalgown,
		/obj/item/dnainjector,
		/obj/item/extinguisher/mini,
		/obj/item/flashlight/pen,
		/obj/item/flesh_shears/medical,
		/obj/item/geiger_counter,
		/obj/item/healthanalyzer,
		/obj/item/hemostat,
		/obj/item/holosign_creator/medical,
		/obj/item/hypospray,
		/obj/item/implant,
		/obj/item/implantcase,
		/obj/item/implanter,
		/obj/item/lazarus_injector,
		/obj/item/lighter,
		/obj/item/pinpointer/crew,
		/obj/item/reagent_containers/blood,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/vial,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/applicator/patch/,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/syringe,
		/obj/item/reflexhammer,
		/obj/item/retractor,
		/obj/item/scalpel,
		/obj/item/surgical_drapes,
		/obj/item/stack/medical,
		/obj/item/stack/medical/wrap/sticky_tape,
		/obj/item/sensor_device,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/hypospraykit,
		/obj/item/storage/pill_bottle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tourniquet,
		/obj/item/storage/box/bandages,
		/obj/item/bodybag,
	))

/datum/design/deforest_medical
	name = "挎包式医疗包"
	id = "satchel_medical"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/storage/backpack/duffelbag/deforest_medkit
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/deforest_technician
	name = "医疗技术员背包"
	id = "satchel_tech"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/storage/backpack/duffelbag/deforest_paramedic
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/deforest_surgical
	name = "急救外科背包"
	id = "satchel_surgical"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/storage/backpack/duffelbag/deforest_surgical
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/medbay_equip_adv/New()
	design_ids += list(
		"satchel_medical",
		"satchel_tech",
		"satchel_surgical",
	)
	return ..()
