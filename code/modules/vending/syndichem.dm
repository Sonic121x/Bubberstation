/obj/machinery/vending/syndichem
	name = "\improper 辛迪加化工"
	desc = "一台装满了手雷和手雷配件的售货机。由咚克公司赞助。"
	products = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/assembly/igniter = 20,
		/obj/item/assembly/prox_sensor = 5,
		/obj/item/assembly/signaler = 5,
		/obj/item/assembly/timer = 5,
		/obj/item/assembly/voice = 5,
		/obj/item/assembly/health = 5,
		/obj/item/assembly/infra = 5,
		/obj/item/grenade/chem_grenade = 5,
		/obj/item/grenade/chem_grenade/large = 5,
		/obj/item/grenade/chem_grenade/pyro = 5,
		/obj/item/grenade/chem_grenade/cryo = 5,
		/obj/item/grenade/chem_grenade/adv_release = 5,
		/obj/item/reagent_containers/cup/glass/bottle/holywater = 1
	)
	product_slogans = "拿钱办事就不算纵火狂！;闻到了吗？等离子体，孩子。世上再没有别的气味比得上它。;我爱清晨等离子体的味道。"
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/syndichem

/obj/item/vending_refill/syndichem
	machine_name = "辛迪加化工"
	icon_state = "refill_syndichem"
