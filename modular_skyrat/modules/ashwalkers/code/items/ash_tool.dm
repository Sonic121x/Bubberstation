//ASH TOOL
/obj/item/screwdriver/ashwalker
	name = "原始螺丝刀"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "screwdriver"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	post_init_icon_state = null

/datum/crafting_recipe/ash_recipe/ash_screwdriver
	name = "灰烬螺丝刀"
	result = /obj/item/screwdriver/ashwalker

/obj/item/wirecutters/ashwalker
	name = "原始剪线钳"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "cutters"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	post_init_icon_state = null

/datum/crafting_recipe/ash_recipe/ash_cutters
	name = "灰烬剪线钳"
	result = /obj/item/wirecutters/ashwalker

/obj/item/wrench/ashwalker
	name = "原始扳手"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "wrench"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	post_init_icon_state = null

/datum/crafting_recipe/ash_recipe/ash_wrench
	name = "灰烬扳手"
	result = /obj/item/wrench/ashwalker

/obj/item/secateurs/ashwalker
	name = "原始修枝剪"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "secateurs"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_secateur
	name = "灰烬修枝剪"
	result = /obj/item/secateurs/ashwalker

/obj/item/crowbar/ashwalker
	name = "原始撬棍"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "crowbar"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	post_init_icon_state = null

/datum/crafting_recipe/ash_recipe/ash_crowbar
	name = "灰烬撬棍"
	result = /obj/item/crowbar/ashwalker

/obj/item/chisel/ashwalker
	name = "原始凿子"
	desc = "有志者事竟成；这把凿子的工具头由骨头制成——趁新鲜时塑形，再泡在富含铁的水中钙化，从而得到一枚坚固的凿头，满足你所有的雕刻需求。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "chisel"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	post_init_icon_state = null
	toolspeed = 4

/datum/crafting_recipe/ash_recipe/ash_chisel
	name = "灰烬凿子"
	result = /obj/item/chisel/ashwalker

/obj/item/cursed_dagger
	name = "诅咒灰烬匕首"
	desc = "一把钝了刃的匕首，似乎能让附近的影子颤抖。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "crysknife"
	inhand_icon_state = "crysknife"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'

/obj/item/cursed_dagger/examine(mob/user)
	. = ..()
	. += span_notice("用于触须。它会在视觉上改变触须，以表明其是否已被诅咒。")

/obj/item/ash_seed
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'

	///list of things the ash seed can spawn
	var/list/spawn_list

/obj/item/ash_seed/examine(mob/user)
	. = ..()
	. += span_notice("要种植它，必须位于采矿层且位于玄武岩上。")

/obj/item/ash_seed/proc/harm_user(mob/living/user, sent_message, damage_amount)
	to_chat(user, span_warning(sent_message))
	user.adjust_brute_loss(damage_amount)
	if(!do_after(user, 4 SECONDS, target = src))
		to_chat(user, span_warning("你中断了种植 [src] 的过程！"))
		return FALSE

	return TRUE

/obj/item/ash_seed/attack_self(mob/user, modifiers)
	. = ..()
	if(isnull(spawn_list))
		return

	var/turf/src_turf = get_turf(src)
	if(!is_mining_level(src_turf.z) || !istype(src_turf, /turf/open/misc/asteroid/basalt))
		return

	if(!isliving(user))
		return

	var/mob/living/living_user = user
	if(!harm_user(user, "你开始挤压 [src]……", 20))
		return

	if(!harm_user(user, "[src] 开始在你指缝间蠕动，顺着你的手臂向上爬……", 20))
		return

	if(!harm_user(user, "[src] 缠住你的胸口并开始收紧，带来一种奇怪的针刺感……", 20))
		return

	to_chat(living_user, span_warning("[src] 满足地从你身上跃开，开始令人作呕地自行组装！"))
	var/type = pick(spawn_list)
	new type(user.loc)
	playsound(get_turf(src), 'sound/effects/magic/demon_attack1.ogg', 50, TRUE)
	qdel(src)

/obj/item/ash_seed/tendril
	name = "触须种子"
	desc = "一团可怕的肉质团块，随着暗能量脉动。"
	icon_state = "tendril_seed"
	spawn_list = list(/mob/living/basic/mining/tendril)

/obj/item/ash_seed/vent
	name = "矿脉种子"
	desc = "一团可怕的肉质团块包裹着巨石。它似乎在缓缓脉动，对你靠近有所反应。"
	icon_state = "vent_seed"
	spawn_list = list(/obj/structure/ore_vent/random)
