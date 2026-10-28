/datum/design/biogen/medical_replicator
	abstract_type = /datum/design/biogen/medical_replicator
	build_path = /obj/item/storage/pouch
	materials = list(/datum/material/biomass = 250)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_NRI_MEDICAL,
	)

/datum/design/biogen/medical_replicator/pocket_medkit
	name = "空的口袋急救包"
	build_path = /obj/item/storage/pouch/cin_medkit

/datum/design/biogen/medical_replicator/medipouch
	name = "空的注射笔小袋"
	build_path = /obj/item/storage/pouch/cin_medipens

/datum/design/biogen/medical_replicator/sutures
	name = "止血缝合线"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/medical/suture/bloody

/datum/design/biogen/medical_replicator/mesh
	name = "止血网"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/medical/mesh/bloody

/datum/design/biogen/medical_replicator/bruise_patch
	name = "瘀伤贴片"
	build_path = /obj/item/reagent_containers/applicator/patch/libital

/datum/design/biogen/medical_replicator/burn_patch
	name = "烧伤贴片"
	build_path = /obj/item/reagent_containers/applicator/patch/aiuri

/datum/design/biogen/medical_replicator/gauze
	name = "医用纱布"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/stack/medical/wrap/gauze

/datum/design/biogen/medical_replicator/epi_pill
	name = "肾上腺素药丸"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/epinephrine

/datum/design/biogen/medical_replicator/conv_pill
	name = "康弗莫药丸"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/convermol

/datum/design/biogen/medical_replicator/multiver_pill
	name = "穆尔提弗药丸"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/multiver
