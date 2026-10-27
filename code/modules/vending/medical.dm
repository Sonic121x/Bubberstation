/obj/machinery/vending/medical
	name = "\improper 纳米医疗加强版"
	desc = "医疗药品售货机。"
	icon_state = "med"
	icon_deny = "med-deny"
	panel_type = "panel11"
	product_ads = "去多救几条命吧！;你医疗舱里最好的东西。;只提供最上等的工具。;纯天然化学品！;这些东西能救命。;你不来点吗？;叮！"
	products = list(
		/obj/item/stack/medical/wrap/gauze = 8,
		/obj/item/reagent_containers/syringe = 12,
		/obj/item/reagent_containers/dropper = 3,
		/obj/item/healthanalyzer = 4,
		/obj/item/wrench/medical = 1,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 3,
		/obj/item/healthanalyzer/simple = 4,
		/obj/item/stack/medical/ointment = 2,
		/obj/item/stack/medical/suture = 2,
		/obj/item/stack/medical/bone_gel = 4,
		/obj/item/cane/crutch = 2,
		/obj/item/cane/white = 2,
		/obj/item/clothing/glasses/eyepatch/medical = 2,
		/obj/item/storage/box/bandages = 2,
		/obj/item/storage/box/triage_cards = 4,
		/obj/item/pinpointer/crew = 2,
	)
	contraband = list(
		/obj/item/storage/box/gum/happiness = 3,
		/obj/item/storage/box/hug/medical = 1,
	)
	premium = list(
		/obj/item/reagent_containers/hypospray/medipen = 3,
		/obj/item/storage/belt/medical = 3,
		/obj/item/sensor_device = 2,
		/obj/item/storage/medkit/advanced = 2,
		/obj/item/shears = 1,
		/obj/item/tourniquet = 6,
		/obj/item/storage/organbox = 1,
		/obj/item/storage/medkit/surgery = 1, // BUBBER EDIT ADDITION
	)
	refill_canister = /obj/item/vending_refill/medical
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND
	payment_department = ACCOUNT_MED
	light_mask = "med-light-mask"

/obj/item/vending_refill/medical
	machine_name = "纳米医疗加强版"
	icon_state = "refill_medical"

/obj/machinery/vending/medical/syndicate
	name = "\improper 辛迪加医疗加强版"
	initial_language_holder = /datum/language_holder/syndicate
	allow_custom = FALSE

/obj/machinery/vending/medical/infested_frigate
	products = list(
		/obj/item/stack/medical/wrap/gauze = 0,
		/obj/item/reagent_containers/syringe = 7,
		/obj/item/reagent_containers/dropper = 3,
		/obj/item/healthanalyzer = 0,
		/obj/item/wrench/medical = 0,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 0,
		/obj/item/healthanalyzer/simple = 0,
		/obj/item/stack/medical/ointment = 0,
		/obj/item/stack/medical/suture = 1,
		/obj/item/stack/medical/bone_gel = 1,
		/obj/item/cane/crutch = 2,
		/obj/item/cane/white = 2,
		/obj/item/clothing/glasses/eyepatch/medical = 2,
	)
	allow_custom = FALSE

//Created out of a necessity to get these dumb chems out of the medical tools vendor.
/obj/machinery/vending/drugs
	name = "\improper 纳米药品加强版"
	desc = "医疗药品售货机。"
	icon_state = "drug"
	icon_deny = "drug-deny"
	panel_type = "panel11"
	product_ads = "去多救几条命吧！;你医疗舱里最好的东西。;只提供最上等的工具。;纯天然化学品！;这些东西能救命。;你不来点吗？;叮！"
	products = list(
		/obj/item/reagent_containers/applicator/patch/libital = 5,
		/obj/item/reagent_containers/applicator/patch/aiuri = 5,
		/obj/item/reagent_containers/syringe/convermol = 2,
		/obj/item/reagent_containers/applicator/pill/insulin = 5,
		/obj/item/reagent_containers/cup/bottle/multiver = 2,
		/obj/item/reagent_containers/cup/bottle/syriniver = 2,
		/obj/item/reagent_containers/cup/bottle/calomel = 2,
		/obj/item/reagent_containers/cup/bottle/epinephrine = 3,
		/obj/item/reagent_containers/cup/bottle/morphine = 4,
		/obj/item/reagent_containers/cup/bottle/potass_iodide = 1,
		/obj/item/reagent_containers/cup/bottle/salglu_solution = 3,
		/obj/item/reagent_containers/cup/bottle/toxin = 3,
		/obj/item/reagent_containers/syringe/antiviral = 6,
		/obj/item/reagent_containers/medigel/libital = 2,
		/obj/item/reagent_containers/medigel/aiuri = 2,
		/obj/item/reagent_containers/medigel/sterilizine = 6, // BUBBER EDIT CHANGE - ORIGINAL: 3
	)
	contraband = list(
		/obj/item/reagent_containers/applicator/pill/tox = 3,
		/obj/item/reagent_containers/applicator/pill/morphine = 4,
		/obj/item/reagent_containers/applicator/pill/multiver = 6,
	)
	premium = list(
		/obj/item/reagent_containers/medigel/synthflesh = 2,
		/obj/item/storage/pill_bottle/psicodine = 2,
		/obj/item/storage/pill_bottle/sansufentanyl = 1,
		/obj/item/inhaler/albuterol = 2,
	)
	default_price = 50
	extra_price = 100
	payment_department = ACCOUNT_MED
	refill_canister = /obj/item/vending_refill/drugs
	allow_custom = TRUE

/obj/item/vending_refill/drugs
	machine_name = "纳米药品加强版"
	icon_state = "refill_medical"
