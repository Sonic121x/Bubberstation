//CODE CREDIT TO JJPARK-KB
//Infinite welding fuel source, lets ashwalkers have infinite fuel without needing high-tech welders.

/obj/structure/sink/fuel_well
	name = "燃料井"
	desc = "一汪冒着气泡的燃料池。要不是蓝空间技术在 200 年前让化石燃料变得不再必要，这大概会很值钱。"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "puddle-oil"
	dispensedreagent = /datum/reagent/fuel
	color = "#742912"	//Gives it a weldingfuel hue

/obj/structure/sink/fuel_well/Initialize(mapload)
	.=..()
	create_reagents(20)
	reagents.add_reagent(dispensedreagent, 20)

/obj/structure/sink/fuel_well/attack_hand(mob/user, list/modifiers)
	flick("puddle-oil-splash",src)
	reagents.expose(user, TOUCH, 20) //Covers target in 20u of fuel.
	to_chat(user, span_notice("你碰了碰燃料池，结果弄得自己满身燃料。最好用水把它洗掉。"))

/obj/structure/sink/fuel_well/attackby(obj/item/O, mob/living/user, params)
	flick("puddle-oil-splash",src)
	if(O.tool_behaviour == TOOL_SHOVEL) //attempt to deconstruct the puddle with a shovel //attempt to deconstruct the puddle with a shovel
		to_chat(user, "你用泥土把燃料井填平了。")
		O.play_tool_sound(src)
		deconstruct()
		return 1
	if(istype(O, /obj/item/reagent_containers)) //Refilling bottles with oil
		var/obj/item/reagent_containers/RG = O
		if(RG.is_refillable())
			if(!RG.reagents.holder_full())
				RG.reagents.add_reagent(dispensedreagent, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
				to_chat(user, span_notice("你从 [src] 中把 [RG] 装满了。"))
				return TRUE
			to_chat(user, span_notice("[RG] 已经满了。"))
			return FALSE
	if(O.tool_behaviour == TOOL_WELDER)
		if(!reagents.has_reagent(/datum/reagent/fuel))
			to_chat(user, span_warning("[src] 里的燃料已经用完了！"))
			return
		var/obj/item/weldingtool/W = O
		if(istype(W) && !W.welding)
			if(W.reagents.has_reagent(/datum/reagent/fuel, W.max_fuel))
				to_chat(user, span_warning("你的 [W.name] 已经满了！"))
				return
			reagents.trans_to(W, W.max_fuel, transferred_by = user)
			user.visible_message(span_notice("[user] 把自己的 [W.name] 加满了燃料。"), span_notice("你给自己的 [W] 加满了燃料。"))
			playsound(src, 'sound/effects/refill.ogg', 50, TRUE)
			W.update_appearance()
		return
	else
		return ..()
