/datum/bounty/item/special
	unique = TRUE

/datum/bounty/item/special/alien_organs
	name = "异形器官"
	description = "纳米传讯有兴趣研究异形生物学。运送一整套器官来换取丰厚的报酬。"
	reward = CARGO_CRATE_VALUE * 50
	required_count = 3
	wanted_types = list(
		/obj/item/organ/brain/alien = TRUE,
		/obj/item/organ/alien = TRUE,
		/obj/item/organ/body_egg/alien_embryo = TRUE,
		/obj/item/organ/liver/alien = TRUE,
		/obj/item/organ/tongue/alien = TRUE,
		/obj/item/organ/eyes/alien = TRUE,
	)

/datum/bounty/item/special/syndicate_documents
	name = "辛迪加文件"
	description = "有关辛迪加的情报在中央指挥部备受欢迎。如果你找到了辛迪加文件，就运送过来吧。你能拯救生命。"
	reward = CARGO_CRATE_VALUE * 30
	wanted_types = list(
		/obj/item/documents/syndicate = TRUE,
		/obj/item/documents/photocopy = TRUE,
	)

/datum/bounty/item/special/syndicate_documents/applies_to(obj/O)
	if(!..())
		return FALSE
	if(istype(O, /obj/item/documents/photocopy))
		var/obj/item/documents/photocopy/Copy = O
		return (Copy.copy_type && ispath(Copy.copy_type, /obj/item/documents/syndicate))
	return TRUE

/datum/bounty/item/special/adamantine
	name = "精金"
	description = "纳米传讯的异常材料部门急需精金。送一批大批量过来，我们会让你觉得物有所值。"
	reward = CARGO_CRATE_VALUE * 70
	required_count = 10
	wanted_types = list(/obj/item/stack/sheet/mineral/adamantine = TRUE)
