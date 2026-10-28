/obj/item/clothing/gloves/misc/diver //Donor item for patriot210
	icon = 'modular_zubbers/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/hands.dmi'
	name = "黑色潜水员手套"
	desc = "一双旧手套，曾由如今已不复存在的采矿联合体使用。"
	icon_state = "diver"
	worn_icon_state = "diver"

/obj/item/clothing/gloves/latex/allamerican
	name = "全美餐馆乳胶手套"
	desc = "一双无菌手套，可在无污染风险的情况下准备食物！老派美式风格。"
	icon_state = "latex_black"
	worn_icon_state = "latex_black"

//Cat Gloves seemingly by Taomayo of MonkeStation

/obj/item/clothing/gloves/cat
	desc = "“高科技”爪形手套，非常适合角色扮演爱好者、主播和一般怪人。每只喵喵都问好！！"
	name = "猫咪手套"
	icon = 'icons/map_icons/clothing/_clothing.dmi'
	icon_state = "/obj/item/clothing/gloves/cat"
	post_init_icon_state = "catgloves"
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#ffffff#FFC0CB#B0EAF6"
	greyscale_config_worn = /datum/greyscale_config/catgloves/worn
	greyscale_config = /datum/greyscale_config/catgloves
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	resistance_flags = FIRE_PROOF
	var/lights_on = FALSE

/obj/item/clothing/gloves/cat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/gloves/cat/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_GLOVES)
		ADD_TRAIT(user, TRAIT_GLOVE_SURGERY_PASSTHROUGH, "cat_gloves")

/obj/item/clothing/gloves/cat/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_GLOVE_SURGERY_PASSTHROUGH, "cat_gloves")

/obj/item/clothing/gloves/cat/update_overlays()
	. = ..()
	if(lights_on)
		. += emissive_appearance(icon, icon_state, src, alpha = 100)

/obj/item/clothing/gloves/cat/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(lights_on)
		. += emissive_appearance(standing.icon, standing.icon_state, src, alpha = 100)

/obj/item/clothing/gloves/cat/examine(mob/user)
	. = ..()
	. += span_notice("手腕上有个小开关。目前处于<b>[lights_on ? "开启" : "关闭"]</b>状态。<a href='byond://?src=[REF(src)];toggle_lights=1'>\[切换\]</a>")

/obj/item/clothing/gloves/cat/Topic(href, href_list)
	. = ..()
	if(href_list["toggle_lights"])
		if(!usr || !ishuman(usr))
			return
		var/mob/living/carbon/human/toggler = usr
		if(toggler.gloves != src)
			return
		lights_on = !lights_on
		playsound(src, 'sound/machines/click.ogg', 30, FALSE)
		to_chat(usr, span_notice("你把装饰灯[lights_on ? "打开" : "关闭"]了。"))
		update_appearance()

/obj/item/clothing/gloves/cat/attackby(obj/item/item, mob/living/user, params)
	if(!istype(item, /obj/item/clothing/gloves/color/yellow))
		return ..()
	if(siemens_coefficient == 0)
		to_chat(user, span_warning("[src]已经绝缘了。"))
		return
	user.visible_message(
		span_notice("[user]笨拙地把[item]塞进[src]里。"),
		span_notice("你把[item]按在[src]上，过了一会儿，你成功把[item]塞了进去。")
	)
	siemens_coefficient = 0
	name = "绝缘[name]"
	if(desc == initial(desc))
		desc = "一双猫咪手套，里面笨拙地塞着一双绝缘手套。不知怎的，这居然管用。"
	qdel(item)
	update_appearance()
	return TRUE

/obj/item/clothing/gloves/cat/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_GLOVES)
		ADD_TRAIT(user, TRAIT_GLOVE_SURGERY_PASSTHROUGH, "cat_gloves")

/obj/item/clothing/gloves/cat/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_GLOVE_SURGERY_PASSTHROUGH, "cat_gloves")


//Metrocop Gloves by ... Dun dun dun, HL13 station.
/obj/item/clothing/gloves/color/black/security/metrocop
	name = "都市警察手套"
	desc = "现在你可以捡起那个罐子了！采用先进的 GigaSlop 品牌矩阵，可实现不同变体！"
	icon = 'modular_zubbers/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/hands.dmi'
	icon_state = "civilprotection"

/obj/item/clothing/gloves/color/black/security/metrocop/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/metrocop_gloves)

/datum/atom_skin/metrocop_gloves
	abstract_type = /datum/atom_skin/metrocop_gloves

/datum/atom_skin/metrocop_gloves/metro_cop
	preview_name = "Metro Cop"
	new_icon_state = "civilprotection"

/datum/atom_skin/metrocop_gloves/overwatch
	preview_name = "Overwatch"
	new_icon_state = "overwatch"

//MGS stuff sprited by Crumpaloo for onlyplateau, please credit when porting, which you obviously have permission to do.
/obj/item/clothing/gloves/color/black/security/snake
	name = "潜行手套"
	desc = "我们将背弃我们的国家。"
	icon = 'modular_zubbers/icons/obj/clothing/gloves/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/gloves/gloves.dmi'
	icon_state = "snake"

/obj/item/clothing/gloves/color/black/security/snake/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/gloves/bubber/snake
	name = "大首领的手套"
	desc = "我们将背弃我们的国家。"
	icon_state = "snake"

/obj/item/clothing/gloves/maid_arm_covers
	greyscale_config_worn_teshari = /datum/greyscale_config/bubber_maid_arm_covers/worn/teshari

/obj/item/clothing/gloves/ring/diamond
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/gloves/gloves_teshari.dmi'
