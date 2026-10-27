// Wintercoat
/obj/item/clothing/suit/hooded/wintercoat
	name = "冬季外套"
	desc = "一件用“合成”动物毛皮制成的厚重夹克。"
	icon = 'icons/obj/clothing/suits/wintercoat.dmi'
	icon_state = "coatwinter"
	worn_icon = 'icons/mob/clothing/suits/wintercoat.dmi'
	inhand_icon_state = "coatwinter"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	allowed = list()
	armor_type = /datum/armor/hooded_wintercoat
	hood_down_overlay_suffix = "_hood"
	/// How snug are we?
	var/zipped = FALSE
	/// Whether alt-clicking this coat zips/unzips it
	var/can_altclick_zip = TRUE
	auto_deploy_hood_on_outfit_equip = FALSE

/datum/armor/hooded_wintercoat
	bio = 10

/obj/item/clothing/suit/hooded/wintercoat/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/flashlight,
		/obj/item/lighter,
		/obj/item/modular_computer/pda,
		/obj/item/radio,
		/obj/item/storage/bag/books,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy,
	)

/obj/item/clothing/suit/hooded/wintercoat/on_hood_up(obj/item/clothing/head/hooded/hood)
	. = ..()
	zipped = TRUE

/// Called when the hood is hidden
/obj/item/clothing/suit/hooded/wintercoat/on_hood_down(obj/item/clothing/head/hooded/hood)
	. = ..()
	zipped = FALSE

/obj/item/clothing/suit/hooded/wintercoat/examine(mob/user)
	. = ..()
	if(can_altclick_zip)
		. += span_notice("按 <b>Alt 左键</b> 来[zipped ? "拉开" : "拉上"]拉链。")


/obj/item/clothing/suit/hooded/wintercoat/click_alt(mob/user)
	if(!can_altclick_zip)
		return CLICK_ACTION_BLOCKING
	zipped = !zipped
	playsound(src, 'sound/items/zip/zip_up.ogg', 30, TRUE, -3)
	worn_icon_state = "[initial(post_init_icon_state) || initial(icon_state)][zipped ? "_t" : ""]"
	balloon_alert(user, "[zipped ? "已拉上" : "已拉开"]拉链")

	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		wearer.update_worn_oversuit()
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/head/hooded/winterhood
	name = "冬季兜帽"
	desc = "一顶舒适的冬季兜帽，连在厚重的冬季夹克上。"
	icon = 'icons/obj/clothing/head/winterhood.dmi'
	icon_state = "hood_winter"
	worn_icon = 'icons/mob/clothing/head/winterhood.dmi'
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEEARS
	hair_mask = /datum/hair_mask/winterhood
	armor_type = /datum/armor/hooded_winterhood

// An coat intended for use for general crew EVA, with values close to those of the space suits found in EVA normally
// Slight extra armor, bulky size, slows you down, can carry a large oxygen tank, won't burn off.
/datum/armor/hooded_winterhood
	bio = 10

/obj/item/clothing/suit/hooded/wintercoat/eva
	name = "\proper 恒温冬季外套"
	desc = "一件填充厚实的冬季外套，无论身处何种环境都能让穿着者保持良好保温。背面附有用于固定大型氧气罐的背带。"
	icon_state = "coateva"
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 0.75
	armor_type = /datum/armor/wintercoat_eva
	strip_delay = 6 SECONDS
	equip_delay_other = 6 SECONDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT // Protects very cold.
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT // Protects a little hot.
	clothing_flags = THICKMATERIAL
	resistance_flags = NONE
	hoodtype = /obj/item/clothing/head/hooded/winterhood/eva

/datum/armor/wintercoat_eva
	melee = 10
	laser = 10
	energy = 10
	bio = 50
	fire = 50
	acid = 20

/obj/item/clothing/suit/hooded/wintercoat/eva/Initialize(mapload)
	. = ..()
	allowed += /obj/item/tank/internals

/obj/item/clothing/head/hooded/winterhood/eva
	name = "\proper 恒温冬季兜帽"
	desc = "一顶填充厚实的兜帽，连在更加厚实的外套上。"
	icon_state = "hood_eva"
	armor_type = /datum/armor/winterhood_eva
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	clothing_flags = THICKMATERIAL|SNUG_FIT // Snug fit doesn't really matter, but might as well
	resistance_flags = NONE

// CentCom
/datum/armor/winterhood_eva
	melee = 10
	laser = 10
	energy = 10
	bio = 50
	fire = 50
	acid = 20

/obj/item/clothing/suit/hooded/wintercoat/centcom
	name = "中央指挥部冬季外套"
	desc = "一件豪华的冬季外套，织有中央指挥部亮绿与金色的配色。它的拉链头是一枚纳米传讯标志形状的小别针。"
	icon_state = "coatcentcom"
	inhand_icon_state = null
	armor_type = /datum/armor/wintercoat_centcom
	hoodtype = /obj/item/clothing/head/hooded/winterhood/centcom

/datum/armor/wintercoat_centcom
	melee = 35
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 10
	fire = 10
	acid = 60

/obj/item/clothing/suit/hooded/wintercoat/centcom/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/centcom
	icon_state = "hood_centcom"
	armor_type = /datum/armor/winterhood_centcom

// Captain
/datum/armor/winterhood_centcom
	melee = 35
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 10
	fire = 10
	acid = 60

/obj/item/clothing/suit/hooded/wintercoat/captain
	name = "舰长冬季外套"
	desc = "一件豪华的冬季外套，内填濒危乌卡鸟的绒羽，并以真紫貂皮滚边。面料是柔软得令人沉溺的超细纤维， \
			而那种深邃的群青色，只有把微量结晶蓝空间尘织进纤维之间才能得到。 \
			极其奢华，也极其耐用。"
	icon_state = "coatcaptain"
	inhand_icon_state = "coatcaptain"
	armor_type = /datum/armor/wintercoat_captain
	hoodtype = /obj/item/clothing/head/hooded/winterhood/captain

/datum/armor/wintercoat_captain
	melee = 25
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	acid = 50

/obj/item/clothing/suit/hooded/wintercoat/captain/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/captain
	icon_state = "hood_captain"
	armor_type = /datum/armor/winterhood_captain

// Head of Personnel
/datum/armor/winterhood_captain
	melee = 25
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	acid = 50

/obj/item/clothing/suit/hooded/wintercoat/hop
	name = "人事主管冬季外套"
	desc = "一件覆满厚实毛皮的舒适冬季外套。胸前有一枚傲然的黄色 V 形条纹，提醒所有人你才是二把手。"
	icon_state = "coathop"
	inhand_icon_state = null
	armor_type = /datum/armor/wintercoat_hop
	allowed = list(
		/obj/item/melee/baton/telescopic,
		/obj/item/stamp,
	)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/hop

/datum/armor/wintercoat_hop
	melee = 10
	bullet = 15
	laser = 15
	energy = 25
	bomb = 10
	acid = 35

/obj/item/clothing/suit/hooded/wintercoat/hop/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/hop
	icon_state = "hood_hop"
	armor_type =/datum/armor/wintercoat_hop

// Botanist
/obj/item/clothing/suit/hooded/wintercoat/hydro
	name = "水培冬季外套"
	desc = "一件绿蓝相间的冬季外套。拉链头做成了一朵 Rosa Hesperrhodos 的花形，那是一种漂亮的粉白色玫瑰。这些颜色完全不搭。"
	icon_state = "coathydro"
	inhand_icon_state = "coathydro"
	allowed = /obj/item/clothing/suit/apron::allowed
	hoodtype = /obj/item/clothing/head/hooded/winterhood/hydro

/obj/item/clothing/head/hooded/winterhood/hydro
	desc = "一顶绿色冬季外套兜帽。"
	icon_state = "hood_hydro"

// Janitor
/obj/item/clothing/suit/hooded/wintercoat/janitor
	name = "清洁工冬季外套"
	desc = "一件紫米相间的冬季外套，闻起来有太空清洁剂的味道。"
	icon_state = "coatjanitor"
	inhand_icon_state = null
	allowed = list(
		/obj/item/access_key,
		/obj/item/grenade/chem_grenade,
		/obj/item/holosign_creator,
		/obj/item/key/janitor,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/spray,
	)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/janitor

/obj/item/clothing/head/hooded/winterhood/janitor
	desc = "一顶紫色兜帽，闻起来有太空清洁剂的味道。"
	icon_state = "hood_janitor"

// Security Officer
/obj/item/clothing/suit/hooded/wintercoat/security
	name = "安保冬季夹克"
	desc = "一件红色的加护冬季外套。它带着轻微的烧蚀涂层光泽，以及一股稳重的权威气场。拉链头是一副叮当作响的小手铐，十秒之后就让人烦。"
	icon_state = "coatsecurity"
	inhand_icon_state = "coatsecurity"
	armor_type = /datum/armor/wintercoat_security
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security

/datum/armor/wintercoat_security
	melee = 25
	bullet = 15
	laser = 30
	energy = 40
	bomb = 25
	acid = 45

/obj/item/clothing/suit/hooded/wintercoat/security/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/security
	desc = "一顶红色的加护冬季兜帽。绝对防不了子弹，尤其是脸对着的那部分。"
	icon_state = "hood_security"
	armor_type = /datum/armor/winterhood_security

// Medical Doctor
/datum/armor/winterhood_security
	melee = 25
	bullet = 15
	laser = 30
	energy = 40
	bomb = 25
	acid = 45

/obj/item/clothing/suit/hooded/wintercoat/medical
	name = "医疗冬季外套"
	desc = "一件北极白色的冬季外套，拉链头不是塑料件，而是一枚小小的蓝色双蛇杖。很时髦。"
	icon_state = "coatmedical"
	inhand_icon_state = "coatmedical"
	allowed = list(
		/obj/item/defibrillator/compact,
		/obj/item/flashlight/pen,
		/obj/item/gun/syringe,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/applicator,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/syringe,
		/obj/item/sensor_device,
		/obj/item/storage/pill_bottle,
	)
	armor_type = /datum/armor/wintercoat_medical
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical

/datum/armor/wintercoat_medical
	bio = 40
	fire = 10
	acid = 20

/obj/item/clothing/head/hooded/winterhood/medical
	desc = "一顶白色冬季外套兜帽。"
	icon_state = "hood_medical"
	armor_type = /datum/armor/winterhood_medical

/datum/armor/winterhood_medical
	bio = 40
	fire = 10
	acid = 20

// Chief Medical Officer
/obj/item/clothing/suit/hooded/wintercoat/medical/cmo
	name = "首席医疗官冬季外套"
	desc = "一件鲜艳蓝色的冬季外套，拉链头不是塑料件，而是一枚小小的银色双蛇杖。内衬换成了极其厚实柔软的毛皮。"
	icon_state = "coatcmo"
	inhand_icon_state = null
	armor_type = /datum/armor/medical_cmo
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical/cmo

/datum/armor/medical_cmo
	bio = 50
	fire = 20
	acid = 30

/obj/item/clothing/suit/hooded/wintercoat/medical/cmo/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/melee/baton/telescopic,
		/obj/item/gun/energy/cell_loaded/medigun, //SKYRAT EDIT MEDIGUNS
	)

/obj/item/clothing/head/hooded/winterhood/medical/cmo
	desc = "一顶蓝色冬季外套兜帽。"
	icon_state = "hood_cmo"
	armor_type = /datum/armor/medical_cmo

// Chemist
/obj/item/clothing/suit/hooded/wintercoat/medical/chemistry
	name = "化学冬季外套"
	desc = "一件实验室级冬季外套，以耐酸聚合物制成。送给那位被流放到冰封荒原、却仍充满干劲的化学家。"
	icon_state = "coatchemistry"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical/chemistry

/obj/item/clothing/suit/hooded/wintercoat/medical/chemistry/Initialize(mapload)
	. = ..()
	allowed += /obj/item/storage/bag/chemistry

/obj/item/clothing/head/hooded/winterhood/medical/chemistry
	desc = "一顶白色冬季外套兜帽。"
	icon_state = "hood_chemistry"

// Coroner
/obj/item/clothing/suit/hooded/wintercoat/medical/coroner
	name = "验尸官冬季外套"
	desc = "一件以耐酸聚合物制成的冬季外套，在冰冷的尸体让人受不了时派上用场。"
	icon_state = "coatcoroner"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical/coroner

/obj/item/clothing/suit/hooded/wintercoat/medical/coroner/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/autopsy_scanner,
		/obj/item/scythe,
		/obj/item/shovel,
		/obj/item/shovel/serrated,
		/obj/item/trench_tool,
	)

/obj/item/clothing/head/hooded/winterhood/medical/coroner
	desc = "一顶白色冬季外套兜帽。"
	icon_state = "hood_coroner"

// Virologist
/obj/item/clothing/suit/hooded/wintercoat/medical/viro
	name = "病毒学冬季外套"
	desc = "一件带绿色标记的白色冬季外套。很保暖，但挡不住普通感冒或任何其他疾病。可能会让走廊里的人离你远远的。拉链头看起来像一只超大号的噬菌体。"
	icon_state = "coatviro"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical/viro

/obj/item/clothing/suit/hooded/wintercoat/medical/viro/Initialize(mapload)
	. = ..()
	allowed += /obj/item/storage/bag/bio

/obj/item/clothing/head/hooded/winterhood/medical/viro
	desc = "一顶带绿色标记的白色冬季外套兜帽。"
	icon_state = "hood_viro"

// Paramedic
/obj/item/clothing/suit/hooded/wintercoat/medical/paramedic
	name = "急救员冬季外套"
	desc = "一件带蓝色标记的冬季外套。很保暖，但大概挡不住生物制剂。送给四处奔波的舒适医生。"
	icon_state = "coatparamed"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical/paramedic

/obj/item/clothing/suit/hooded/wintercoat/medical/paramedic/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) //mirrored from jacket
	allowed += /obj/item/crowbar/power/paramedic

/obj/item/clothing/head/hooded/winterhood/medical/paramedic
	desc = "一顶带蓝色标记的白色冬季外套兜帽。"
	icon_state = "hood_paramed"

// Scientist
/obj/item/clothing/suit/hooded/wintercoat/science
	name = "科研冬季外套"
	desc = "一件白色冬季外套，拉链头不是塑料件，而是一个过时的原子模型。"
	icon_state = "coatscience"
	inhand_icon_state = "coatscience"
	allowed = list(
		/obj/item/analyzer,
		/obj/item/dnainjector,
		/obj/item/paper,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/storage/bag/xeno,
		/obj/item/storage/pill_bottle,
	)
	armor_type = /datum/armor/wintercoat_science
	hoodtype = /obj/item/clothing/head/hooded/winterhood/science
	species_exception = list(/datum/species/golem)

/datum/armor/wintercoat_science
	bio = 10
	fire = 20

/obj/item/clothing/head/hooded/winterhood/science
	desc = "一顶白色冬季外套兜帽。这一顶能让你的大脑保持温暖。其实和其他几顶差不多。"
	icon_state = "hood_science"
	armor_type = /datum/armor/winterhood_science

// Research Director
/datum/armor/winterhood_science
	bio = 10
	fire = 20

/obj/item/clothing/suit/hooded/wintercoat/science/rd
	name = "科研主管冬季外套"
	desc = "一件厚实的北极冬季外套，拉链头不是塑料件，而是一个过时的原子模型。多数内行人都很清楚，玻尔的原子模型在 1930 年代海森堡与薛定谔模型被普遍认可为真时就已过时。尽管如此，我们仍能在时代错置、角色扮演，以及此处这种拉链头上看到它的身影。至少它能在你的象牙塔上让你保持温暖。"
	icon_state = "coatrd"
	inhand_icon_state = null
	armor_type = /datum/armor/science_rd
	hoodtype = /obj/item/clothing/head/hooded/winterhood/science/rd

/datum/armor/science_rd
	bomb = 20
	fire = 30

/obj/item/clothing/suit/hooded/wintercoat/science/rd/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/melee/baton/telescopic,
	)

/obj/item/clothing/head/hooded/winterhood/science/rd
	desc = "一顶白色冬季外套兜帽。隐约有发胶的味道。"
	icon_state = "hood_rd"
	armor_type = /datum/armor/science_rd

// Roboticist
/obj/item/clothing/suit/hooded/wintercoat/science/robotics
	name = "机器人学冬季外套"
	desc = "一件黑色冬季外套，拉链头是一颗霸气燃烧的机械骷髅。这一件还有鲜红色的图案和几颗没用的纽扣。"
	icon_state = "coatrobotics"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/science/robotics

/obj/item/clothing/head/hooded/winterhood/science/robotics
	desc = "一顶黑色冬季外套兜帽。你可以把它拉下来盖住眼睛，假装自己是 1980 年代末对未来机械化警察部队的过时想象。他们会修好你。他们什么都能修。"
	icon_state = "hood_robotics"

// Geneticist
/obj/item/clothing/suit/hooded/wintercoat/science/genetics
	name = "遗传学冬季外套"
	desc = "一件白色冬季外套，拉链头是一个 DNA 双螺旋。"
	icon_state = "coatgenetics"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/science/genetics

/obj/item/clothing/suit/hooded/wintercoat/science/genetics/Initialize(mapload)
	. = ..()
	allowed += /obj/item/sequence_scanner

/obj/item/clothing/head/hooded/winterhood/science/genetics
	desc = "一顶白色冬季外套兜帽。很暖和。"
	icon_state = "hood_genetics"

// Station Engineer
/obj/item/clothing/suit/hooded/wintercoat/engineering
	name = "工程冬季外套"
	desc = "一件意外地沉重的黄色冬季外套，带反光橙色条纹。拉链头是一把小扳手，内层覆有抗辐射的银尼龙混纺材料。因为你值得。"
	icon_state = "coatengineer"
	inhand_icon_state = "coatengineer"
	allowed = list(
		/obj/item/analyzer,
		/obj/item/construction/rcd,
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag/construction,
		/obj/item/t_scanner,
		/obj/item/construction/rld,
		/obj/item/construction/rtd,
		/obj/item/gun/ballistic/rifle/rebarxbow,
		/obj/item/storage/bag/rebar_quiver,
	)
	armor_type = /datum/armor/wintercoat_engineering
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering

/datum/armor/wintercoat_engineering
	fire = 20

/obj/item/clothing/suit/hooded/wintercoat/engineering/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)

/obj/item/clothing/head/hooded/winterhood/engineering
	desc = "一顶黄色冬季外套兜帽。绝对不能代替安全帽。"
	icon_state = "hood_engineer"
	armor_type = /datum/armor/winterhood_engineering

/datum/armor/winterhood_engineering
	fire = 20

/obj/item/clothing/head/hooded/winterhood/engineering/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)

// Chief Engineer
/obj/item/clothing/suit/hooded/wintercoat/engineering/ce
	name = "总工程师冬季外套"
	desc = "一件带反光绿色与黄色条纹的白色冬季外套。内填石棉，经阻燃 PBDE 处理，衬里是一层极薄的铅箔，并按你的身材尺寸贴身剪裁。这宝贝能让你免受一切伤害，除了穿上它后你会得的甲状腺癌与全身性纤维化。拉链头是一把小小的金色扳手。"
	icon_state = "coatce"
	inhand_icon_state = null
	armor_type = /datum/armor/engineering_ce
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering/ce

/datum/armor/engineering_ce
	fire = 30
	acid = 10

/obj/item/clothing/suit/hooded/wintercoat/engineering/ce/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/melee/baton/telescopic,
	)

/obj/item/clothing/head/hooded/winterhood/engineering/ce
	desc = "一顶白色冬季外套兜帽。意外地沉。标签上写着它不适合儿童使用。"
	icon_state = "hood_ce"
	armor_type = /datum/armor/engineering_ce

// Atmospherics Technician
/obj/item/clothing/suit/hooded/wintercoat/engineering/atmos
	name = "大气冬季外套"
	desc = "一件黄蓝相间的冬季外套。拉链头做成了一只微型呼吸面罩的样子。"
	icon_state = "coatatmos"
	inhand_icon_state = "coatatmos"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering/atmos

/obj/item/clothing/head/hooded/winterhood/engineering/atmos
	desc = "一顶黄蓝相间的冬季外套兜帽。"
	icon_state = "hood_atmos"

// Cargo Technician
/obj/item/clothing/suit/hooded/wintercoat/cargo
	name = "货运冬季外套"
	desc = "一件棕灰相间的冬季外套。拉链头是一枚形似 MULE 的小别针。它以猛烈独立精神的暖意充盈着你。"
	icon_state = "coatcargo"
	inhand_icon_state = "coatcargo"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/cargo
	allowed = list(
		/obj/item/storage/bag/mail,
		/obj/item/stamp,
		/obj/item/universal_scanner,
	)

/obj/item/clothing/head/hooded/winterhood/cargo
	desc = "一顶灰色冬季外套兜帽。"
	icon_state = "hood_cargo"

// Quartermaster
/obj/item/clothing/suit/hooded/wintercoat/cargo/qm
	name = "货运主管冬季外套"
	desc = "一件深棕色冬季外套，拉链拉手是一枚金色的板条箱别针。"
	icon_state = "coatqm"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/cargo/qm

/obj/item/clothing/suit/hooded/wintercoat/cargo/qm/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/melee/baton/telescopic,
	)

/obj/item/clothing/head/hooded/winterhood/cargo/qm
	desc = "一顶深棕色冬季兜帽"
	icon_state = "hood_qm"

// Shaft Miner
/obj/item/clothing/suit/hooded/wintercoat/miner
	name = "采矿冬季外套"
	desc = "一件沾满灰尘的纽扣式冬季外套。拉链头看起来像一把小小的镐。"
	icon_state = "coatminer"
	inhand_icon_state = "coatminer"
	allowed = list(
		/obj/item/gun/energy/recharge/kinetic_accelerator,
		/obj/item/mining_scanner,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/storage/bag/ore,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/tank/internals,
		/obj/item/shovel,
		/obj/item/trench_tool,
	)
	armor_type = /datum/armor/wintercoat_miner
	hoodtype = /obj/item/clothing/head/hooded/winterhood/miner

/datum/armor/wintercoat_miner
	melee = 10

/obj/item/clothing/head/hooded/winterhood/miner
	desc = "一顶沾满灰尘的冬季外套兜帽。"
	icon_state = "hood_miner"
	armor_type = /datum/armor/winterhood_miner

/datum/armor/winterhood_miner
	melee = 10

/obj/item/clothing/suit/hooded/wintercoat/custom
	name = "定制冬季外套"
	desc = "一件用“合成”动物毛皮制成的厚重夹克，可自定义颜色。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/custom"
	post_init_icon_state = "coatwinter"
	hood_down_overlay_suffix = ""
	greyscale_config = /datum/greyscale_config/winter_coats
	greyscale_config_worn = /datum/greyscale_config/winter_coats/worn
	greyscale_colors = "#ffffff#ffffff#808080#808080#808080#808080"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/custom
	flags_1 = IS_PLAYER_COLORABLE_1

//In case colors are changed after initialization
/obj/item/clothing/suit/hooded/wintercoat/custom/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()
	if(!hood)
		return
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/list/new_coat_colors = coat_colors.Copy(1,4)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.
	hood.update_slot_icon()

//But also keep old method in case the hood is (re-)created later
/obj/item/clothing/suit/hooded/wintercoat/custom/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = (SSgreyscale.ParseColorString(greyscale_colors))
	var/list/new_coat_colors = coat_colors.Copy(1,4)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

/obj/item/clothing/head/hooded/winterhood/custom
	name = "定制冬季外套兜帽"
	desc = "一顶用“合成”动物毛皮制成的厚重夹克兜帽，可自定义颜色。"
	greyscale_config = /datum/greyscale_config/winter_hoods
	greyscale_config_worn = /datum/greyscale_config/winter_hoods/worn
	flags_1 = NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/suit/hooded/wintercoat/pullover
	name = "套头衫"
	desc = "一件可染色的套头连帽衫。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/pullover"
	post_init_icon_state = "pullover"
	greyscale_config = /datum/greyscale_config/hoodie_pullover
	greyscale_config_worn = /datum/greyscale_config/hoodie_pullover/worn
	greyscale_colors = "#5f5f5f"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/pullover
	flags_1 = IS_PLAYER_COLORABLE_1
	hood_down_overlay_suffix = ""
	hood_up_affix = "_t"
	can_altclick_zip = FALSE

/obj/item/clothing/suit/hooded/wintercoat/pullover/on_hood_up(obj/item/clothing/head/hooded/hood)
	return

/obj/item/clothing/suit/hooded/wintercoat/pullover/on_hood_down(obj/item/clothing/head/hooded/hood)
	return

/obj/item/clothing/head/hooded/winterhood/pullover
	name = "套头衫兜帽"
	desc = "一件可染色的套头连帽衫。"
	icon_state = "hood_pullover"
	worn_icon_state = "hood_pullover"
	hair_mask = /datum/hair_mask/hoodie
	greyscale_config = /datum/greyscale_config/hoodie_pullover_hood
	greyscale_config_worn = /datum/greyscale_config/hoodie_pullover_hood/worn
	greyscale_colors = "#5f5f5f"
	flags_1 = NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/suit/hooded/wintercoat/pullover/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()
	if(!hood)
		return
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	hood.set_greyscale(coat_colors)
	hood.update_slot_icon()

/obj/item/clothing/suit/hooded/wintercoat/pullover/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	hood.set_greyscale(coat_colors)

/obj/item/clothing/suit/hooded/wintercoat/zipup
	name = "拉链衫"
	desc = "一件可染色的拉链连帽衫。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/zipup"
	post_init_icon_state = "zipup"
	greyscale_config = /datum/greyscale_config/hoodie_zipup
	greyscale_config_worn = /datum/greyscale_config/hoodie_zipup/worn
	greyscale_colors = "#5f5f5f"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/zipup
	flags_1 = IS_PLAYER_COLORABLE_1
	hood_down_overlay_suffix = ""
	hood_up_affix = "_t"

/obj/item/clothing/suit/hooded/wintercoat/zipup/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(isinhands || (hood && hood.loc != src))
		return

	var/suffix = (zipped ? "hood_t" : "hood")
	var/state = "[initial(post_init_icon_state) || initial(icon_state)]_[suffix]"
	. += mutable_appearance(icon_file, state, -SUIT_LAYER)

/obj/item/clothing/head/hooded/winterhood/zipup
	name = "拉链衫兜帽"
	desc = "一件可染色的拉链连帽衫。"
	icon_state = "hood_zipup"
	worn_icon_state = "hood_zipup"
	hair_mask = /datum/hair_mask/hoodie
	greyscale_config = /datum/greyscale_config/hoodie_zipup_hood
	greyscale_config_worn = /datum/greyscale_config/hoodie_zipup_hood/worn
	greyscale_colors = "#5f5f5f"
	flags_1 = NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/suit/hooded/wintercoat/zipup/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()
	if(!hood)
		return
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	hood.set_greyscale(coat_colors)
	hood.update_slot_icon()

/obj/item/clothing/suit/hooded/wintercoat/zipup/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	hood.set_greyscale(coat_colors)
