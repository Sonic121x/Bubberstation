//VENDING MACHINES
/obj/machinery/vending/assaultops_ammo
	name = "\improper 辛迪加弹药站"
	desc = "一台弹药售货机，存有各式各样的弹匣。"
	icon_state = "liberationstation"
	vend_reply = "物品已发放。"
	scan_id = FALSE
	resistance_flags = FIRE_PROOF
	onstation = FALSE
	light_mask = "liberation-light-mask"
	default_price = 0

	/// Have we been FILLED?
	var/filled = FALSE

/obj/machinery/vending/assaultops_ammo/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		fill_ammo(user)
		ui = new(user, src, "Vending")
		ui.open()

/obj/machinery/vending/assaultops_ammo/proc/fill_ammo(mob/user)
	if(last_shopper == user && filled)
		return
	else
		filled = FALSE

	if(!ishuman(user))
		return FALSE

	if(!user.mind.has_antag_datum(/datum/antagonist/assault_operative))
		return FALSE

	//Remove all current items from the vending machine
	products.Cut()
	product_records.Cut()

	var/mob/living/carbon/human/human_user = user

	//Find all the ammo we should display
	for(var/object in human_user.contents)
		if(istype(object, /obj/item/gun/ballistic))
			var/obj/item/gun/ballistic/gun = object
			if(!gun.internal_magazine)
				products.Add(gun.spawn_magazine_type)
		if(istype(object, /obj/item/storage))
			var/obj/item/storage/storage = object
			for(var/storage_item in storage.contents)
				if(istype(storage_item, /obj/item/gun/ballistic))
					var/obj/item/gun/ballistic/gun = storage_item
					if(!gun.internal_magazine)
						products.Add(gun.spawn_magazine_type)

	//Add our items to the list of products
	deprecated_build_inventory(products, product_records, FALSE)

	filled = TRUE

/obj/machinery/vending/assaultops_ammo/proc/deprecated_build_inventory(list/productlist, list/recordlist, start_empty = FALSE, premium = FALSE)
	default_price = 0
	extra_price = 0
	for(var/typepath in productlist)
		var/amount = 4
		var/atom/temp = typepath
		var/datum/data/vending_product/vending_product = new /datum/data/vending_product()

		vending_product.name = initial(temp.name)
		vending_product.product_path = typepath
		if(!start_empty)
			vending_product.amount = amount
		vending_product.max_amount = amount
		vending_product.price = 0
		vending_product.age_restricted = FALSE
		recordlist += vending_product
