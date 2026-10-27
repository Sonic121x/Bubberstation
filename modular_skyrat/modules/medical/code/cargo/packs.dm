/datum/supply_pack/science/synthetic_burns
	name = "合成人烧伤套装"
	desc = "内含数瓶预冷赫库里和二氮等离子剂，非常适合处理合成人的烧伤！"
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(/obj/item/reagent_containers/spray/hercuri/chilled = 3, /obj/item/reagent_containers/spray/dinitrogen_plasmide = 3)
	crate_name = "冰镇赫库里箱"

	access_view = FALSE
	access = FALSE
	access_any = FALSE

/datum/supply_pack/science/synth_treatment_kits
	name = "合成人治疗套件"
	desc = "内含 2 套供合成人生命体使用的治疗套件，装满了处理无机伤口所需的一切！"
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(/obj/item/storage/backpack/duffelbag/synth_treatment_kit = 2)
	crate_name = "合成人治疗套件箱"

	access_view = FALSE
	access = FALSE
	access_any = FALSE

/datum/supply_pack/science/synth_healing_chems
	name = "合成人药物包"
	desc = "内含多种合成人专用药物。2 瓶液态焊锡、2 瓶纳米浆液、2 瓶系统清洁剂。"
	cost = CARGO_CRATE_VALUE * 7 // rarely made, so it should be expensive(?)
	contains = list(
		/obj/item/storage/pill_bottle/liquid_solder = 2,
		/obj/item/storage/pill_bottle/nanite_slurry = 2,
		/obj/item/storage/pill_bottle/system_cleaner = 2
	)
	crate_name = "synthetic medicine crate"

	access_view = FALSE
	access = FALSE
	access_any = FALSE

/datum/supply_pack/science/synth_medkits
	name = "机械维修套件"
	desc = "内含几套低规格的便携式合成人医疗包，适合分发给船员使用。"
	cost = CARGO_CRATE_VALUE * 4.5 // same as treatment kits
	contains = list(/obj/item/storage/medkit/robotic_repair/stocked = 4)

	crate_name = "合成人维修套件箱"

	access_view = FALSE
	access = FALSE
	access_any = FALSE
