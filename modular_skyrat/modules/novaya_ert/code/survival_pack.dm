/obj/item/storage/box/nri_survival_pack
	name = "泛斯拉夫联邦生存包"
	desc = "泛斯拉夫联邦提供的物资盒，装满了实用的应急用品。"
	icon_state = "survival_pack"
	icon = 'modular_skyrat/modules/novaya_ert/icons/survival_pack.dmi'
	illustration = null

/obj/item/storage/box/nri_survival_pack/PopulateContents()
	new /obj/item/oxygen_candle(src)
	new /obj/item/tank/internals/emergency_oxygen/double(src)
	new /obj/item/stack/spacecash/c1000(src)
	new /obj/item/storage/pill_bottle/iron(src)
	new /obj/item/storage/box/colonial_rations(src)
	new /obj/item/storage/box/nri_pens(src)
	new /obj/item/storage/box/nri_flares(src)
	new /obj/item/crowbar/red(src)

/obj/item/storage/box/nri_pens
	name = "注射笔盒"
	desc = "一盒急救和战斗医疗注射笔。"
	illustration = "epipen"

/obj/item/storage/box/nri_pens/PopulateContents()
	new /obj/item/reagent_containers/hypospray/medipen/ekit(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpack/traitor(src)
	new /obj/item/reagent_containers/hypospray/medipen/oxandrolone(src)
	new /obj/item/reagent_containers/hypospray/medipen/salacid(src)
	new /obj/item/reagent_containers/hypospray/medipen/salacid(src)
	new /obj/item/reagent_containers/hypospray/medipen/penacid(src)
	new /obj/item/reagent_containers/hypospray/medipen/salbutamol(src)
	new /obj/item/reagent_containers/hypospray/medipen/atropine(src)
	new /obj/item/reagent_containers/hypospray/medipen/blood_loss(src)

/obj/item/storage/box/nri_flares
	name = "信号棒盒"
	desc = "一盒红色应急信号棒。"
	illustration = "firecracker"

/obj/item/storage/box/nri_flares/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/flashlight/flare(src)
