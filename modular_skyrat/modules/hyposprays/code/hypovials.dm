/obj/item/reagent_containers/cup/vial
	name = "破损的无针药瓶"
	desc = "你大概不该看到这东西。去吼程序员吧。"
	icon = 'modular_skyrat/modules/hyposprays/icons/vials.dmi'
	icon_state = "hypovial"
	greyscale_config = /datum/greyscale_config/hypovial
	fill_icon_state = "hypovial_fill"
	spillable = FALSE
	volume = 10
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(1,2,5,10)
	fill_icon_thresholds = list(10, 25, 50, 75, 100)
	var/chem_color = "#FFFFFF" //Used for hypospray overlay
	var/type_suffix = "-s"
	fill_icon = 'modular_skyrat/modules/hyposprays/icons/hypospray_fillings.dmi'

/obj/item/reagent_containers/cup/vial/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hypovial)

/datum/atom_skin/hypovial
	abstract_type = /datum/atom_skin/hypovial

/datum/atom_skin/hypovial/sterile
	preview_name = "无菌"
	new_icon_state = "hypovial"

/datum/atom_skin/hypovial/generic
	preview_name = "通用"
	new_icon_state = "hypovial-generic"

/datum/atom_skin/hypovial/brute
	preview_name = "钝伤"
	new_icon_state = "hypovial-brute"

/datum/atom_skin/hypovial/burn
	preview_name = "烧伤"
	new_icon_state = "hypovial-burn"

/datum/atom_skin/hypovial/toxin
	preview_name = "毒素"
	new_icon_state = "hypovial-tox"

/datum/atom_skin/hypovial/oxyloss
	preview_name = "缺氧"
	new_icon_state = "hypovial-oxy"

/datum/atom_skin/hypovial/crit
	preview_name = "危重"
	new_icon_state = "hypovial-crit"

/datum/atom_skin/hypovial/buff
	preview_name = "增益"
	new_icon_state = "hypovial-buff"

/datum/atom_skin/hypovial/custom
	preview_name = "自定义"
	new_icon_state = "hypovial-custom"

	/// The original icon file where our overlays reside.
	var/original_icon = 'modular_skyrat/modules/hyposprays/icons/vials.dmi'

/obj/item/reagent_containers/cup/vial/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/obj/item/reagent_containers/cup/vial/Destroy(force)
	. = ..()
	UnregisterSignal(src, COMSIG_OBJ_RESKIN)

/obj/item/reagent_containers/cup/vial/examine(mob/user)
	. = ..()
	. += span_notice("按住 Ctrl-Shift 点击可更换外观或设置自定义颜色。")

/obj/item/reagent_containers/cup/vial/click_ctrl_shift(mob/user, obj/item/held_item)
	var/datum/component/reskinable_item/reskin_component = GetComponent(/datum/component/reskinable_item)
	if(isnull(reskin_component))
		return
	icon_state = initial(icon_state)
	icon = initial(icon)
	greyscale_colors = null
	reskin_component.reskin_obj(user)

/obj/item/reagent_containers/cup/vial/proc/on_reskin(datum/source, datum/atom_skin/applied_skin)
	if(!istype(applied_skin, /datum/atom_skin/hypovial/custom))
		return
	icon_state = "hypovial"
	open_custom_greyscale_menu()

/obj/item/reagent_containers/cup/vial/proc/open_custom_greyscale_menu()
	var/list/allowed_greyscale_configs = list("[initial(greyscale_config)]")
	if(isnull(greyscale_colors))
		greyscale_colors = "#FFFF00"
	var/mob/user = usr
	if(isnull(user))
		return
	var/datum/greyscale_modify_menu/greyscale_menu = new(src, user, allowed_greyscale_configs)
	greyscale_menu.ui_interact(user)

/obj/item/reagent_containers/cup/vial/update_overlays()
	. = ..()
	// Search the overlays for the fill overlay from reagent_containers, and nudge its layer down to have it look correct.
	chem_color = "#FFFFFF"
	var/list/generated_overlays = .
	for(var/added_overlay in generated_overlays)
		if(istype(added_overlay, /mutable_appearance))
			var/mutable_appearance/overlay_image = added_overlay
			if(findtext(overlay_image.icon_state, fill_icon_state) != 0)
				overlay_image.layer = layer - 0.01
				chem_color = overlay_image.color

/obj/item/reagent_containers/cup/vial/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/reagent_containers/cup/vial/on_reagent_change()
	update_icon()

//Fit in all hypos
/obj/item/reagent_containers/cup/vial/small
	name = "无针药瓶"
	desc = "一个小型药瓶，容量 50 单位，可兼容大多数无针注射器。"
	volume = 50
	possible_transfer_amounts = list(1,2,5,10,15,25,50)

/obj/item/reagent_containers/cup/vial/small/style
	icon_state = "hypovial"

//Styles
/obj/item/reagent_containers/cup/vial/small/style/generic
	icon_state = "hypovial-generic"
/obj/item/reagent_containers/cup/vial/small/style/brute
	icon_state = "hypovial-brute"
/obj/item/reagent_containers/cup/vial/small/style/burn
	icon_state = "hypovial-burn"
/obj/item/reagent_containers/cup/vial/small/style/toxin
	icon_state = "hypovial-tox"
/obj/item/reagent_containers/cup/vial/small/style/oxy
	icon_state = "hypovial-oxy"
/obj/item/reagent_containers/cup/vial/small/style/crit
	icon_state = "hypovial-crit"
/obj/item/reagent_containers/cup/vial/small/style/buff
	icon_state = "hypovial-buff"

//Fit in CMO hypo only
/obj/item/reagent_containers/cup/vial/large
	name = "大型无针药瓶"
	icon_state = "hypoviallarge"
	fill_icon_state = "hypoviallarge_fill"
	desc = "一个大型药瓶，容量 100 单位，仅能装入最豪华的无针注射器。"
	volume = 100
	possible_transfer_amounts = list(1,2,5,10,20,30,40,50,100)
	type_suffix = "-l"

/obj/item/reagent_containers/cup/vial/large/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hypovial_large)

/datum/atom_skin/hypovial_large
	abstract_type = /datum/atom_skin/hypovial_large

/datum/atom_skin/hypovial_large/sterile
	preview_name = "无菌"
	new_icon_state = "hypoviallarge"

/datum/atom_skin/hypovial_large/generic
	preview_name = "通用"
	new_icon_state = "hypoviallarge-generic"

/datum/atom_skin/hypovial_large/brute
	preview_name = "钝伤"
	new_icon_state = "hypoviallarge-brute"

/datum/atom_skin/hypovial_large/burn
	preview_name = "烧伤"
	new_icon_state = "hypoviallarge-burn"

/datum/atom_skin/hypovial_large/toxin
	preview_name = "毒素"
	new_icon_state = "hypoviallarge-tox"

/datum/atom_skin/hypovial_large/oxyloss
	preview_name = "缺氧"
	new_icon_state = "hypoviallarge-oxy"

/datum/atom_skin/hypovial_large/crit
	preview_name = "危重"
	new_icon_state = "hypoviallarge-crit"

/datum/atom_skin/hypovial_large/buff
	preview_name = "增益"
	new_icon_state = "hypoviallarge-buff"

/datum/atom_skin/hypovial_large/custom
	preview_name = "自定义"
	new_icon_state = "hypoviallarge-custom"

/obj/item/reagent_containers/cup/vial/large/style/
	icon_state = "hypoviallarge"

//Styles
/obj/item/reagent_containers/cup/vial/large/style/generic
	icon_state = "hypoviallarge-generic"
/obj/item/reagent_containers/cup/vial/large/style/brute
	icon_state = "hypoviallarge-brute"
/obj/item/reagent_containers/cup/vial/large/style/burn
	icon_state = "hypoviallarge-burn"
/obj/item/reagent_containers/cup/vial/large/style/toxin
	icon_state = "hypoviallarge-tox"
/obj/item/reagent_containers/cup/vial/large/style/oxy
	icon_state = "hypoviallarge-oxy"
/obj/item/reagent_containers/cup/vial/large/style/crit
	icon_state = "hypoviallarge-crit"
/obj/item/reagent_containers/cup/vial/large/style/buff
	icon_state = "hypoviallarge-buff"

//Hypos that are in the CMO's kit round start
/obj/item/reagent_containers/cup/vial/large/deluxe
	name = "豪华无针药瓶"
	icon_state = "hypoviallarge-buff"
	list_reagents = list(/datum/reagent/medicine/omnizine = 15, /datum/reagent/medicine/leporazine = 15, /datum/reagent/medicine/atropine = 15)

/obj/item/reagent_containers/cup/vial/large/salglu
	name = "大型绿色无针药瓶（葡萄糖盐水）"
	icon_state = "hypoviallarge-oxy"
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 50)

/obj/item/reagent_containers/cup/vial/large/synthflesh
	name = "大型橙色无针药瓶（合成肉液）"
	icon_state = "hypoviallarge-crit"
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 50)

/obj/item/reagent_containers/cup/vial/large/multiver
	name = "大型黑色无针药瓶（穆尔提弗）"
	icon_state = "hypoviallarge-tox"
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 50)

//Some bespoke helper types for preloaded combat medkits.
/obj/item/reagent_containers/cup/vial/large/advbrute
	name = "钝伤治疗剂"
	icon_state = "hypoviallarge-brute"
	list_reagents = list(/datum/reagent/medicine/c2/libital = 50, /datum/reagent/medicine/sal_acid = 50)

/obj/item/reagent_containers/cup/vial/large/advburn
	name = "烧伤治疗剂"
	icon_state = "hypoviallarge-burn"
	list_reagents = list(/datum/reagent/medicine/c2/aiuri = 50, /datum/reagent/medicine/oxandrolone = 50)

/obj/item/reagent_containers/cup/vial/large/advtox
	name = "毒素治疗剂"
	icon_state = "hypoviallarge-tox"
	list_reagents = list(/datum/reagent/medicine/pen_acid = 100)

/obj/item/reagent_containers/cup/vial/large/advoxy
	name = "缺氧治疗剂"
	icon_state = "hypoviallarge-oxy"
	list_reagents = list(/datum/reagent/medicine/c2/tirimol = 50, /datum/reagent/medicine/salbutamol = 50)

/obj/item/reagent_containers/cup/vial/large/advcrit
	name = "危重治疗剂"
	icon_state = "hypoviallarge-crit"
	list_reagents = list(/datum/reagent/medicine/atropine = 100)

/obj/item/reagent_containers/cup/vial/large/advomni
	name = "全效治疗剂"
	icon_state = "hypoviallarge-buff"
	list_reagents = list(/datum/reagent/medicine/regen_jelly = 100)

/obj/item/reagent_containers/cup/vial/large/numbing
	name = "麻醉剂"
	icon_state = "hypoviallarge-generic"
	list_reagents = list(/datum/reagent/medicine/mine_salve = 50, /datum/reagent/medicine/morphine = 50)

//Some bespoke helper types for preloaded paramedic kits.
/obj/item/reagent_containers/cup/vial/small/libital
	name = "钝伤无针药瓶（利比妥）"
	icon_state = "hypovial-brute"

/obj/item/reagent_containers/cup/vial/small/libital/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/libital, amount = 50, added_purity = 1)

/obj/item/reagent_containers/cup/vial/small/lenturi
	name = "烧伤无针药瓶（伦图里）"
	icon_state = "hypovial-burn"

/obj/item/reagent_containers/cup/vial/small/lenturi/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/lenturi, amount = 50, added_purity = 1)

/obj/item/reagent_containers/cup/vial/small/seiver
	name = "毒素无针药瓶（塞弗）"
	icon_state = "hypovial-tox"

/obj/item/reagent_containers/cup/vial/small/seiver/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/seiver, amount = 50, reagtemp = 975, added_purity = 1)

/obj/item/reagent_containers/cup/vial/small/convermol
	name = "毒素无针药瓶（康弗莫）"
	icon_state = "hypovial-oxy"

/obj/item/reagent_containers/cup/vial/small/convermol/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/convermol, amount = 50, added_purity = 1)

/obj/item/reagent_containers/cup/vial/small/atropine
	name = "危重无针药瓶（阿托品）"
	icon_state = "hypovial-crit"

/obj/item/reagent_containers/cup/vial/small/atropine/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/atropine, amount = 50, added_purity = 1)
