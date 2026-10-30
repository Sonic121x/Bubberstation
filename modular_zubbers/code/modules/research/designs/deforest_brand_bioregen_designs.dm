// Designs for the DeForest Brand Bio-Regenerator
// Combines the Wall Med-Station with some of the medicines produced by the Colonial Supply Core,
// along with adding additional medicines to support certain quirks or treat specific conditions - mostly stuff available in your typical DeForest Med-Vend.

//// First Aid ////

// Burn Treatments

/datum/design/biogen/dfbbr_balm
	name = "红日药膏"
	materials = list(/datum/material/biomass = 18)
	build_path = /obj/item/stack/medical/ointment/red_sun
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_ointment
	name = "烧伤药膏"
	materials = list(/datum/material/biomass = 6)
	build_path = /obj/item/stack/medical/ointment
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_aseptic_gauze
	name = "密封无菌纱布"
	materials = list(/datum/material/biomass = 16)
	build_path = /obj/item/stack/medical/wrap/gauze/sterilized
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_mesh
	name = "再生网纱"
	materials = list(/datum/material/biomass = 12)
	build_path = /obj/item/stack/medical/mesh
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_hemo_mesh
	name = "止血网"
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/stack/medical/mesh/bloody
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

// Brute Treatments

/datum/design/biogen/dfbbr_bruise_pack
	name = "淤伤包"
	materials = list(/datum/material/biomass = 8)
	build_path = /obj/item/stack/medical/bruise_pack
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_bandaid
	name = "急救绷带"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/stack/medical/bandage
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_sutures
	name = "缝合线"
	materials = list(/datum/material/biomass = 16)
	build_path = /obj/item/stack/medical/suture
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_hemo_sutures
	name = "止血缝合线"
	materials = list(/datum/material/biomass = 30)
	build_path = /obj/item/stack/medical/suture/bloody
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

// Bleed Treatments

/datum/design/biogen/dfbbr_coagulant_f
	name = "凝血剂-F 药包"
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/stack/medical/suture/coagulant
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_coagulant_rapid
	name = "快速凝血剂涂抹器"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/stack/medical/wound_recovery/rapid_coagulant
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

// Synth Treatments

/datum/design/biogen/dfbbr_synth_patch
	name = "机械修复贴片"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_repair_foam
	name = "机械修复喷剂"
	materials = list(/datum/material/biomass = 80)
	build_path = /obj/item/stack/medical/wound_recovery/robofoam
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_repair_foam_premium
	name = "高级机械修复喷剂"
	materials = list(/datum/material/biomass = 160)
	build_path = /obj/item/stack/medical/wound_recovery/robofoam_super
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

// Fracture Treatments

/datum/design/biogen/dfbbr_gauze
	name = "医用纱布"
	materials = list(/datum/material/biomass = 16)
	build_path = /obj/item/stack/medical/wrap/gauze
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_bone_gel
	name = "骨胶"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/stack/medical/bone_gel
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_surgical_tape
	name = "手术胶带"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/stack/medical/wrap/sticky_tape/surgical
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/biogen/dfbbr_splint_applicator
	name = "皮下夹板贴敷器"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/stack/medical/wound_recovery
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

//// Medicine ////

// Patches

/datum/design/biogen/dfbbr_bruise_patch
	name = "淤伤贴片"
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/reagent_containers/applicator/patch/libital
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/biogen/dfbbr_burn_patch
	name = "烧伤贴片"
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/reagent_containers/applicator/patch/aiuri
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/biogen/dfbbr_synthflesh_patch
	name = "合成肉液贴片"
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/applicator/patch/synthflesh
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

// Pills

/datum/design/biogen/dfbbr_amollin_pill
	name = "阿莫林止痛药"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/reagent_containers/applicator/pill/amollin
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/biogen/dfbbr_iron_pill
	name = "铁药丸"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/reagent_containers/applicator/pill/iron
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/biogen/dfbbr_probital_pill
	name = "普罗比妥药丸"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/reagent_containers/applicator/pill/probital
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/biogen/dfbbr_epi_pill
	name = "肾上腺素药丸"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/epinephrine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/biogen/dfbbr_conv_pill
	name = "康弗莫药丸"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/convermol
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/biogen/dfbbr_multiver_pill
	name = "穆尔提弗药丸"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/multiver
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/biogen/dfbbr_potassiodide_pill
	name = "碘化钾药丸"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/potassiodide
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

// Quirk Related Meds //

/datum/design/biogen/dfbbr_insulin_pill
	name = "胰岛素药丸"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/insulin
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/biogen/dfbbr_psicodine_pill
	name = "心定宁药丸"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/psicodine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

// Spacer, working in lavaland... or it is Ice Box. At least it also allows people with the Spacer quirk to visit safely.
/datum/design/biogen/dfbbr_ondansetron_pill
	name = "昂丹司琼药丸"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/ondansetron
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/biogen/dfbbr_sansufentanyl_pill
	name = "桑苏芬太尼药丸"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/sansufentanyl
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

// I don't know why you'd do it, but just in case someone plays with the brain degeneration.
/datum/design/biogen/dfbbr_mannitol_pill
	name = "甘露醇药丸"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/reagent_containers/applicator/pill/mannitol
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/biogen/dfbbr_neurine_pill
	name = "神经碱药丸"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/reagent_containers/applicator/pill/neurine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

// Asthma, on lavaland, truly a genius move.
/datum/design/biogen/dfbbr_albuterol_canister
	name = "沙丁胺醇气罐"
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/inhaler_canister/albuterol
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

//// Autoinjectors ////

/datum/design/biogen/dfbbr_autoinjector_occuisate
	name = "奥库伊萨特感官恢复注射器"
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/hypospray/medipen/deforest/occuisate
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_INJECTORS)

/datum/design/biogen/dfbbr_autoinjector_calopine
	name = "卡洛平应急稳定剂注射器"
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/hypospray/medipen/deforest/calopine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_INJECTORS)

/datum/design/biogen/dfbbr_autoinjector_halobinin
	name = "哈洛比宁醒酒剂注射器"
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/hypospray/medipen/deforest/halobinin
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_INJECTORS)

/datum/design/biogen/dfbbr_autoinjector_synthcleaner
	name = "合成体清洁剂自动注射器"
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_INJECTORS)

/datum/design/biogen/dfbbr_autoinjector_liquidsolder
	name = "合成体智能焊锡自动注射器"
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/hypospray/medipen/deforest/robot_liquid_solder
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_INJECTORS)
