/obj/item/implant/kaza_ruk
	name = "卡扎鲁克植入体"
	desc = "通过五段直接射入你眼球的短片，教你提兹拉的卡扎鲁克武术。"
	icon = 'icons/obj/scrolls.dmi'
	icon_state ="scroll2"
	/// The martial art style this implant teaches.
	var/datum/martial_art/kaza_ruk/style

	implant_info = "植入后自动激活。教你提兹拉的卡扎鲁克武术。"

	implant_lore = "卡扎鲁克植入体是一套集成式训练数据库，由五段直接射入眼球的短片组成，\
		可按需重播，用于复习提兹拉卡扎鲁克武术的\
		基础要领，无论宿主此前是否具备武术功底，抑或是明显缺乏功底。"

/obj/item/implant/kaza_ruk/Initialize(mapload)
	. = ..()
	style = new(src)

/obj/item/implant/kaza_ruk/Destroy()
	QDEL_NULL(style)
	return ..()

/obj/item/implant/kaza_ruk/activate()
	. = ..()
	if(isnull(imp_in.mind))
		return
	if(style.unlearn(imp_in))
		return

	style.teach(imp_in)

/obj/item/implanter/kaza_ruk
	name = "植入器（卡扎鲁克）"
	imp_type = /obj/item/implant/kaza_ruk

/obj/item/implantcase/kaza_ruk
	name = "植入体盒 - “卡扎鲁克”"
	desc = "一个玻璃盒，内装能教使用者提兹拉卡扎鲁克武术的植入体。"
	imp_type = /obj/item/implant/kaza_ruk
