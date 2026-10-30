/datum/design/biogen/organic_printer
	abstract_type = /datum/design/biogen/organic_printer
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/stack/medical
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_DEFOREST_MEDICAL,
	)

/datum/design/biogen/organic_printer/bruise_pack
	name = "淤伤包"
	materials = list(/datum/material/biomass = 4) // 6 per stacks
	build_path = /obj/item/stack/medical/bruise_pack

/datum/design/biogen/organic_printer/ointment
	name = "烧伤药膏"
	materials = list(/datum/material/biomass = 3) // 8 per stacks
	build_path = /obj/item/stack/medical/ointment

/datum/design/biogen/organic_printer/suture
	name = "缝合线"
	materials = list(/datum/material/biomass = 8) // 10 per stacks
	build_path = /obj/item/stack/medical/suture

/datum/design/biogen/organic_printer/regenerative_mesh
	name = "再生网纱"
	materials = list(/datum/material/biomass = 6) // 15 per stacks
	build_path = /obj/item/stack/medical/mesh

/datum/design/biogen/organic_printer/medical_gauze
	name = "医用纱布"
	materials = list(/datum/material/biomass = 5) // 6 per stacks
	build_path = /obj/item/stack/medical/wrap/gauze

/datum/design/biogen/organic_printer/balm
	name = "红日药膏"
	materials = list(/datum/material/biomass = 9) // 12 per stacks
	build_path = /obj/item/stack/medical/ointment/red_sun

/datum/design/biogen/organic_printer/gauze
	name = "密封无菌纱布"
	materials = list(/datum/material/biomass = 8) // 6 per stacks
	build_path = /obj/item/stack/medical/wrap/gauze/sterilized

/datum/design/biogen/organic_printer/coagulant_f
	name = "凝血剂-F 药包"
	materials = list(/datum/material/biomass = 5) // 12 per stacks
	build_path = /obj/item/stack/medical/suture/coagulant

/datum/design/biogen/organic_printer/amollin_pill
	name = "阿莫林止痛药"
	build_path = /obj/item/reagent_containers/applicator/pill/amollin

/datum/design/biogen/organic_printer/bandaid
	name = "急救绷带"
	build_path = /obj/item/stack/medical/bandage

/datum/design/biogen/organic_printer/synth_patch
	name = "机械修复贴片"
	build_path = /obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair

/datum/design/biogen/organic_printer/repair_foam
	name = "机械修复喷剂"
	materials = list(/datum/material/biomass = 40) // 2 per stacks
	build_path = /obj/item/stack/medical/wound_recovery/robofoam

/datum/design/biogen/organic_printer/bone_gel
	name = "骨胶"
	build_path = /obj/item/stack/medical/bone_gel

/datum/design/biogen/organic_printer/surgical_tape
	name = "手术胶带"
	build_path = /obj/item/stack/medical/wrap/sticky_tape/surgical
