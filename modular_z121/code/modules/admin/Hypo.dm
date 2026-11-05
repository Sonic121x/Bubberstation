#define C2NAMEREAGENT "[initial(reagent.name)]（有副作用）"

#define ADMIN_SHAKER_REAGENTS list(\
	/datum/reagent/consumable/applejuice,\
	/datum/reagent/consumable/banana,\
	/datum/reagent/consumable/coffee,\
	/datum/reagent/consumable/cream,\
	/datum/reagent/consumable/dr_gibb,\
	/datum/reagent/consumable/grenadine,\
	/datum/reagent/consumable/ice,\
	/datum/reagent/consumable/lemonjuice,\
	/datum/reagent/consumable/lemon_lime,\
	/datum/reagent/consumable/limejuice,\
	/datum/reagent/consumable/menthol,\
	/datum/reagent/consumable/milk,\
	/datum/reagent/consumable/nothing,\
	/datum/reagent/consumable/orangejuice,\
	/datum/reagent/consumable/peachjuice,\
	/datum/reagent/consumable/sodawater,\
	/datum/reagent/consumable/space_cola,\
	/datum/reagent/consumable/spacemountainwind,\
	/datum/reagent/consumable/pwr_game,\
	/datum/reagent/consumable/shamblers,\
	/datum/reagent/consumable/soymilk,\
	/datum/reagent/consumable/space_up,\
	/datum/reagent/consumable/sugar,\
	/datum/reagent/consumable/tea,\
	/datum/reagent/consumable/tomatojuice,\
	/datum/reagent/consumable/tonic,\
	/datum/reagent/water,\
	/datum/reagent/consumable/pineapplejuice,\
	/datum/reagent/consumable/sol_dry,\
	/datum/reagent/consumable/ethanol/ale,\
	/datum/reagent/consumable/ethanol/applejack,\
	/datum/reagent/consumable/ethanol/beer,\
	/datum/reagent/consumable/ethanol/champagne,\
	/datum/reagent/consumable/ethanol/cognac,\
	/datum/reagent/consumable/ethanol/creme_de_menthe,\
	/datum/reagent/consumable/ethanol/creme_de_cacao,\
	/datum/reagent/consumable/ethanol/gin,\
	/datum/reagent/consumable/ethanol/kahlua,\
	/datum/reagent/consumable/ethanol/rum,\
	/datum/reagent/consumable/ethanol/sake,\
	/datum/reagent/consumable/ethanol/tequila,\
	/datum/reagent/consumable/ethanol/triple_sec,\
	/datum/reagent/consumable/ethanol/vermouth,\
	/datum/reagent/consumable/ethanol/vodka,\
	/datum/reagent/consumable/ethanol/whiskey,\
	/datum/reagent/consumable/ethanol/wine,\
	/datum/reagent/consumable/ethanol/creme_de_coconut,\
	/datum/reagent/consumable/berryjuice,\
	/datum/reagent/consumable/blumpkinjuice,\
	/datum/reagent/consumable/watermelonjuice,\
	/datum/reagent/consumable/pumpkinjuice,\
	/datum/reagent/consumable/vanilla,\
	/datum/reagent/consumable/ethanol/absinthe,\
	/datum/reagent/consumable/laughter,\
	/datum/reagent/consumable/ethanol/synthanol,\
	/datum/reagent/consumable/ethanol/amaretto,\
	/datum/reagent/consumable/capsaicin,\
	/datum/reagent/consumable/coco,\
	/datum/reagent/consumable/ethanol/hcider,\
	/datum/reagent/consumable/ethanol,\
	/datum/reagent/consumable/ethanol/fernet,\
	/datum/reagent/consumable/potato_juice,\
	/datum/reagent/consumable/grapejuice,\
	/datum/reagent/consumable/parsnipjuice,\
	/datum/reagent/consumable/aloejuice,\
	/datum/reagent/consumable/ethanol/beer/maltliquor,\
	/datum/reagent/consumable/ethanol/lizardwine,\
	/datum/reagent/consumable/ethanol/hooch,\
	/datum/reagent/consumable/grape_soda,\
	/datum/reagent/toxin/coffeepowder,\
	/datum/reagent/toxin/teapowder,\
	/datum/reagent/consumable/blackpepper,\
	/datum/reagent/toxin/mushroom_powder,\
	/datum/reagent/consumable/enzyme,\
	/datum/reagent/blood,\
	/datum/reagent/consumable/eggyolk,\
	/datum/reagent/consumable/eggwhite,\
	/datum/reagent/consumable/honey,\
	/datum/reagent/iron,\
	/datum/reagent/pax/catnip\
	)

#define ADMIN_HYPO_REAGENTS list(\
	/datum/reagent/medicine/c2/convermol,\
	/datum/reagent/medicine/c2/libital,\
	/datum/reagent/medicine/c2/multiver,\
	/datum/reagent/medicine/c2/aiuri,\
	/datum/reagent/medicine/epinephrine,\
	/datum/reagent/medicine/spaceacillin,\
	/datum/reagent/medicine/salglu_solution,\
	/datum/reagent/medicine/mannitol,\
	/datum/reagent/medicine/oculine,\
	/datum/reagent/medicine/inacusiate,\
	/datum/reagent/medicine/mutadone,\
	/datum/reagent/medicine/haloperidol,\
	/datum/reagent/medicine/oxandrolone,\
	/datum/reagent/medicine/sal_acid,\
	/datum/reagent/medicine/rezadone,\
	/datum/reagent/medicine/pen_acid,\
	/datum/reagent/medicine/potass_iodide,\
	/datum/reagent/medicine/morphine,\
	/datum/reagent/medicine/lidocaine,\
	/datum/reagent/medicine/stimulants,\
	/datum/reagent/medicine/higadrite,\
	/datum/reagent/medicine/leporazine,\
	/datum/reagent/medicine/antihol,\
	/datum/reagent/toxin/formaldehyde,\
	/datum/reagent/medicine/salbutamol,\
	/datum/reagent/toxin/lipolicide,\
	/datum/reagent/medicine/atropine\
	)

#define ADMIN_HACKHYPO_REAGENTS list (\
	/datum/reagent/peaceborg/confuse,\
	/datum/reagent/peaceborg/tire,\
	/datum/reagent/pax/peaceborg,\
	/datum/reagent/medicine/stimulants,\
	/datum/reagent/medicine/syndicate_nanites,\
	/datum/reagent/toxin/acid/fluacid,\
	/datum/reagent/toxin/mutetoxin,\
	/datum/reagent/toxin/cyanide,\
	/datum/reagent/toxin/sodium_thiopental,\
	/datum/reagent/toxin/heparin,\
	/datum/reagent/toxin/lexorin,\
	/datum/reagent/consumable/superlaughter,\
	/datum/reagent/toxin/staminatoxin,\
	/datum/reagent/toxin/sulfonal,\
	/datum/reagent/toxin/fentanyl\
	)

//shaker
/obj/item/reagent_containers/borghypo/borgshaker/admin
	icon_state = "shaker_n"
	default_reagent_types = ADMIN_SHAKER_REAGENTS
//hypo
/obj/item/reagent_containers/borghypo/medical/admin
	bypass_protection = TRUE
	default_reagent_types = ADMIN_HYPO_REAGENTS

/obj/item/reagent_containers/borghypo/medical/admin/hacked
	bypass_protection = TRUE
	icon_state = "borghypo_s"
	default_reagent_types = ADMIN_HACKHYPO_REAGENTS
/*
/obj/item/reagent_containers/borghypo/medical/admin/afterattack(obj/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!selected_reagent)
		balloon_alert(user, "no reagent selected!")
		return
	if(target.is_refillable())
		if(!stored_reagents.has_reagent(selected_reagent.type, amount_per_transfer_from_this))
			balloon_alert(user, "not enough [selected_reagent.name]!")
			return
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			balloon_alert(user, "[target] is full!")
			return

		// This is the in-between where we're storing the reagent we're going to pour into the container
		// because we cannot specify a singular reagent to transfer in trans_to
		var/datum/reagents/shaker = new()
		stored_reagents.remove_reagent(selected_reagent.type, amount_per_transfer_from_this)
		shaker.add_reagent(selected_reagent.type, amount_per_transfer_from_this, reagtemp = dispensed_temperature, no_react = TRUE)

		shaker.trans_to(target, amount_per_transfer_from_this, transfered_by = user)
		balloon_alert(user, "[amount_per_transfer_from_this] unit\s poured")

//HYPO ATTACK FIX
/obj/item/reagent_containers/borghypo/medical/admin/attack(mob/living/carbon/injectee, mob/user)
	if(!istype(injectee))
		return
	if(!selected_reagent)
		balloon_alert(user, "no reagent selected!")
		return
	if(!stored_reagents.has_reagent(selected_reagent.type, amount_per_transfer_from_this))
		balloon_alert(user, "not enough [selected_reagent.name]!")
		return

	if(injectee.try_inject(user, user.zone_selected, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE | (bypass_protection ? INJECT_CHECK_PENETRATE_THICK : 0)))
		// This is the in-between where we're storing the reagent we're going to inject the injectee with
		// because we cannot specify a singular reagent to transfer in trans_to
		var/datum/reagents/hypospray_injector = new()
		stored_reagents.remove_reagent(selected_reagent.type, amount_per_transfer_from_this)
		hypospray_injector.add_reagent(selected_reagent.type, amount_per_transfer_from_this, reagtemp = dispensed_temperature, no_react = TRUE)

		to_chat(injectee, span_warning("You feel a tiny prick!"))
		to_chat(user, span_notice("You inject [injectee] with the injector."))

		if(injectee.reagents)
			hypospray_injector.trans_to(injectee, amount_per_transfer_from_this, transfered_by = user, methods = INJECT)
			balloon_alert(user, "[amount_per_transfer_from_this] unit\s injected")
			log_combat(user, injectee, "injected", src, "(CHEMICALS: [selected_reagent])")
	else
		balloon_alert(user, "[user.zone_selected] is blocked!")
*/
#undef C2NAMEREAGENT
#undef ADMIN_SHAKER_REAGENTS
#undef ADMIN_HYPO_REAGENTS
#undef ADMIN_HACKHYPO_REAGENTS
