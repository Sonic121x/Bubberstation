//If you're looking for spawners like ash walker eggs, check ghost_role_spawners.dm

///Wizard tower item
/obj/item/disk/design_disk/knight_gear
	name = "锻造魔法磁盘"
	blueprints = list(/datum/design/knight_armour, /datum/design/knight_helmet)

//Free Golems

/obj/item/disk/design_disk/golem_shell
	name = "魔像制造磁盘"
	desc = "来自解放者的礼物。"
	icon_state = "datadisk1"
	blueprints = list(/datum/design/golem_shell)

/datum/design/golem_shell
	name = "魔像外壳建造"
	desc = "允许建造魔像外壳。"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*20)
	build_path = /obj/item/golem_shell
	category = list(RND_CATEGORY_IMPORTED)

/obj/item/golem_shell
	name = "未完成的自由魔像外壳"
	icon = 'icons/mob/shells.dmi'
	icon_state = "shell_unfinished"
	desc = "一具未完成的魔像躯体。加入十张特定矿物板材即可完成。"
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20)
	/// Amount of minerals you need to feed the shell to wake it up
	var/required_stacks = 10
	/// Type of shell to create
	var/shell_type = /obj/effect/mob_spawn/ghost_role/human/golem

/obj/item/golem_shell/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!isstack(tool))
		return NONE

	var/obj/item/stack/stack_food = tool
	var/stack_type = stack_food.merge_type
	if (!is_path_in_list(stack_type, GLOB.golem_stack_food_directory))
		balloon_alert(user, "矿物不兼容！")
		return ITEM_INTERACT_BLOCKING

	if(stack_food.amount < required_stacks)
		balloon_alert(user, "矿物不足！")
		return ITEM_INTERACT_BLOCKING

	if(!do_after(user, delay = 4 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING

	if(!stack_food.use(required_stacks))
		balloon_alert(user, "矿物不足！")
		return ITEM_INTERACT_BLOCKING

	new shell_type(get_turf(src), /* creator = */ user, /* made_of = */ stack_type)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/golem_shell/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()

	to_chat(user, span_notice("你开始撬下结构关键的碎块。"))
	playsound(src, 'sound/items/tools/crowbar.ogg',  70)
	if(!do_after(user, delay = 1 SECONDS, target = src))
		return
	if(QDELETED(src))
		return
	new /obj/item/stack/sheet/mineral/adamantine(get_turf(src), 1) //Return less than was used to construct the shell
	to_chat(user, span_notice("外壳向内塌陷了！"))
	playsound(src, 'sound/effects/rock/rock_break.ogg', 40)
	qdel(src)
	return

///made with xenobiology, the golem obeys its creator
/obj/item/golem_shell/servant
	name = "未完成的仆从魔像外壳"
	shell_type = /obj/effect/mob_spawn/ghost_role/human/golem/servant
	custom_materials = list(/datum/material/adamantine = SHEET_MATERIAL_AMOUNT * 3)
