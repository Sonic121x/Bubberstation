/datum/lazy_template/virtual_domain/beach_bar
	name = "海滩酒吧"
	desc = "一处欢快的海滨避风港，友善的骷髅在此供应饮品。话说，你们几位是怎么死得这么彻底的？"
	completion_loot = list(/obj/item/toy/beach_ball = 1)
	help_text = "这里全靠一支骷髅船员维持运转，而他们似乎不太愿意透露细节。 \
	也许来几杯魅力之酒能让他们打起精神。俗话说得好，打不过就加入。"
	key = "beach_bar"
	map_name = "beach_bar"
	domain_flags = DOMAIN_NO_NOHIT_BONUS

/datum/lazy_template/virtual_domain/beach_bar/setup_domain(list/created_atoms)
	. = ..()

	for(var/obj/item/reagent_containers/cup/glass/drink in created_atoms)
		RegisterSignal(drink, COMSIG_GLASS_DRANK, PROC_REF(on_drink_drank))
	for(var/obj/machinery/vending/vending_machine in created_atoms)
		RegisterSignal(vending_machine, COMSIG_VENDING_DISPENSED, PROC_REF(on_vended_item))


/datum/lazy_template/virtual_domain/beach_bar/proc/on_vended_item(obj/machinery/vending/vending_machine, obj/item/vended_item)
	if(istype(vended_item, /obj/item/reagent_containers/cup/glass))
		RegisterSignal(vended_item, COMSIG_GLASS_DRANK, PROC_REF(on_drink_drank))


/// Eventually reveal the cache
/datum/lazy_template/virtual_domain/beach_bar/proc/on_drink_drank(datum/source)
	SIGNAL_HANDLER

	add_points(0.5)
