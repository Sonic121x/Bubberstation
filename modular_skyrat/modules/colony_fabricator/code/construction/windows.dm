/obj/structure/window/fulltile/colony_fabricator
	name = "预制窗"
	desc = "保守搭建的金属框架，嵌着一块厚厚的航天级玻璃。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/prefab_window.dmi'
	icon_state = "prefab-0"
	base_icon_state = "prefab"
	fulltile = TRUE
	glass_type = /obj/item/stack/sheet/plastic_wall_panel
	glass_amount = 1
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/structure/grille/attackby(obj/item/item_in_question, mob/user, params)
	if(!istype(item_in_question, /obj/item/stack/sheet/plastic_wall_panel))
		return ..()

	if(broken)
		return
	var/obj/item/stack/stack_in_question = item_in_question
	if(stack_in_question.get_amount() < 1)
		to_chat(user, span_warning("你需要至少一块塑料板才能这样做！"))
		return
	var/dir_to_set = SOUTHWEST
	if(!anchored)
		to_chat(user, span_warning("[src] 需要先固定在地板上！"))
		return
	for(var/obj/structure/window/window_on_turf in loc)
		to_chat(user, span_warning("那里已经有一扇窗了！"))
		return
	if(!clear_tile(user))
		return
	to_chat(user, span_notice("你开始放置窗户……"))
	if(!do_after(user, 1 SECONDS, target = src))
		return
	if(!src.loc || !anchored) //Grille broken or unanchored while waiting
		return
	for(var/obj/structure/window/window_on_turf in loc) //Another window already installed on grille
		return
	if(!clear_tile(user))
		return
	var/obj/structure/window/new_window = new /obj/structure/window/fulltile/colony_fabricator(drop_location())
	new_window.setDir(dir_to_set)
	new_window.state = 0
	stack_in_question.use(1)
	to_chat(user, span_notice("你把 [new_window] 安装到了 [src] 上。"))
