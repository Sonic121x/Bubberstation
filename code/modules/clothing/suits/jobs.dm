/*
 * Job related
 */

//Botanist
/obj/item/clothing/suit/apron
	name = "围裙"
	desc = "一条基本的蓝色围裙。"
	icon_state = "apron"
	icon = 'icons/obj/clothing/suits/utility.dmi'
	worn_icon = 'icons/mob/clothing/suits/utility.dmi'
	inhand_icon_state = null
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN
	allowed = list(
		/obj/item/cultivator,
		/obj/item/geneshears,
		/obj/item/graft,
		/obj/item/hatchet,
		/obj/item/plant_analyzer,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/spray/pestspray,
		/obj/item/reagent_containers/spray/plantbgone,
		/obj/item/secateurs,
		/obj/item/seeds,
		/obj/item/storage/bag/plants,
		/obj/item/tank/internals/emergency_oxygen,
	)
	species_exception = list(/datum/species/golem)
	armor_type = /datum/armor/suit_apron
	supports_variations_flags = CLOTHING_DIGITIGRADE_MASK
	bodyshapes_with_variations = BODYSHAPE_DIGITIGRADE

/obj/item/clothing/suit/apron/generate_digitigrade_icons(icon/base_icon, greyscale_colors)
	var/icon/legs = icon(SSgreyscale.GetColoredIconByType(/datum/greyscale_config/digitigrade, greyscale_colors), "apron_worn")
	return replace_icon_legs(base_icon, legs)

/datum/armor/suit_apron
	bio = 50

/obj/item/clothing/suit/apron/waders
	name = "园艺涉水裤"
	desc = "一条重型皮革涉水裤，能完美地让你的柔软血肉隔绝泼洒物、泥土和荆棘。"
	icon_state = "hort_waders"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/apron/overalls
	name = "连体工作服"
	desc = "一套连体工作服，适合保护较薄的衣物免受环境侵蚀。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/apron/overalls"
	post_init_icon_state = "overalls"
	inhand_icon_state = ""
	body_parts_covered = CHEST|GROIN|LEGS
	gender = PLURAL
	species_exception = list(/datum/species/golem)
	greyscale_config = /datum/greyscale_config/overalls
	greyscale_config_worn = /datum/greyscale_config/overalls/worn
	greyscale_colors = "#313c6e"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/apron/overalls/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -4)

//Captain
/obj/item/clothing/suit/jacket/capjacket
	name = "船长阅兵夹克"
	desc = "由船长穿着，以彰显其格调。"
	icon_state = "capjacket"
	inhand_icon_state = "bio_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	allowed = list(
		/obj/item/assembly/flash/handheld,
		/obj/item/cigarette,
		/obj/item/disk,
		/obj/item/lighter,
		/obj/item/melee,
		/obj/item/reagent_containers/cup/glass/flask,
		/obj/item/stamp,
		/obj/item/storage/box/matches,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/lockbox/medal,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
	)

//Chef
/obj/item/clothing/suit/toggle/chef
	name = "厨师围裙"
	desc = "高级厨师使用的一种围裙式夹克。"
	icon_state = "chef"
	inhand_icon_state = "chef"
	icon = 'icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'icons/mob/clothing/suits/jacket.dmi'
	armor_type = /datum/armor/toggle_chef
	body_parts_covered = CHEST|GROIN|ARMS
	allowed = list(
		/obj/item/kitchen,
		/obj/item/knife/kitchen,
		/obj/item/storage/bag/tray,
	)
	toggle_noun = "袖子"
	species_exception = list(/datum/species/golem)

//Cook
/datum/armor/toggle_chef
	bio = 50

/obj/item/clothing/suit/apron/chef
	name = "厨工围裙"
	desc = "一条朴素乏味的白色厨工围裙。"
	icon_state = "apronchef"
	inhand_icon_state = null
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN
	allowed = list(
		/obj/item/kitchen,
		/obj/item/knife/kitchen,
		/obj/item/storage/bag/tray,
	)

//Detective
/obj/item/clothing/suit/toggle/jacket/det_trench
	name = "棕色风衣"
	desc = "一件 18 世纪多功能风衣。穿它的人可不是闹着玩的。"
	icon_state = "det_trenchcoat"
	inhand_icon_state = "det_suit"
	blood_overlay_type = "coat"
	armor_type = /datum/armor/jacket_det_suit
	flags_inv = HIDEBELT

/datum/armor/jacket_det_suit
	melee = 25
	bullet = 10
	laser = 25
	energy = 35
	acid = 45

/obj/item/clothing/suit/toggle/jacket/det_trench/Initialize(mapload)
	. = ..()
	allowed = GLOB.detective_vest_allowed

/obj/item/clothing/suit/toggle/jacket/det_trench/noir
	name = "暗调风衣"
	desc = "一名硬派私家侦探的深色风衣。"
	icon_state = "noir_trenchcoat"
	inhand_icon_state = null

/obj/item/clothing/suit/jacket/det_suit
	name = "棕色西装外套"
	desc = "一件非常适合晚餐约会与刑事调查的西装外套。"
	icon_state = "det_blazer"
	armor_type = /datum/armor/jacket_det_suit
	inhand_icon_state = null

/obj/item/clothing/suit/jacket/det_suit/Initialize(mapload)
	. = ..()
	allowed = GLOB.detective_vest_allowed

/obj/item/clothing/suit/jacket/det_suit/noir
	name = "暗调西装外套"
	desc = "一位干练私家侦探的深色西装外套。"
	icon_state = "noir_blazer"

/obj/item/clothing/suit/jacket/det_suit/kim
	name = "浮空轰炸机夹克"
	desc = "一件曾在反百年革命期间由革命空军旅穿着的夹克。内侧有相当多的口袋，主要用于存放笔记本和指南针。"
	icon_state = "aerostatic_bomber_jacket"

/obj/item/clothing/suit/jacket/det_suit/disco
	name = "迪斯科风花哨外套"
	desc = "看起来像是有人从某种早已灭绝的迪斯科动物身上剥下了这件外套。背面和右袖上有一块神秘的白矩形。"
	icon_state = "jamrock_blazer"

//Engineering
/obj/item/clothing/suit/hazardvest
	name = "高可见防护背心"
	desc = "一种用于作业区的高可见度背心。"
	icon_state = "hazard"
	icon = 'icons/obj/clothing/suits/utility.dmi'
	worn_icon = 'icons/mob/clothing/suits/utility.dmi'
	inhand_icon_state = null
	blood_overlay_type = "armor"
	allowed = list(
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/flashlight,
		/obj/item/radio,
		/obj/item/storage/bag/construction,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/t_scanner,
		/obj/item/gun/ballistic/rifle/boltaction/pipegun,
		/obj/item/storage/bag/rebar_quiver,
		/obj/item/gun/ballistic/rifle/rebarxbow,
	)
	resistance_flags = NONE
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/hazardvest/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)

/obj/item/clothing/suit/hazardvest/press // Variant used by the Curator
	name = "记者防护背心"
	desc = "一件蓝色高可见度背心，用于区分<i>非战斗人员</i>“媒体”成员——前提是有人在意。"
	icon_state = "hazard_press"

//Lawyer
/obj/item/clothing/suit/toggle/lawyer
	name = "蓝色正式西装外套"
	desc = "一件专业的西装外套。"
	icon_state = "suitjacket_blue"
	icon = 'icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'icons/mob/clothing/suits/jacket.dmi'
	inhand_icon_state = null
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	species_exception = list(/datum/species/golem)
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/suit/toggle/lawyer/purple
	name = "紫色正式西装外套"
	icon_state = "suitjacket_purp"
	inhand_icon_state = null

/obj/item/clothing/suit/toggle/lawyer/black
	name = "黑色正式西装外套"
	icon_state = "suitjacket_black"
	inhand_icon_state = "ro_suit"

// Cargo

/obj/item/clothing/suit/toggle/cargo_tech
	name = "货运 Gorka 夹克"
	desc = "一件棕黑配色的蓬松夹克，由合成面料制成。灵感来自古老的东欧设计。"
	icon_state = "cargo_jacket"
	icon = 'icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'icons/mob/clothing/suits/jacket.dmi'
	inhand_icon_state = null
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	allowed = list(
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/boxcutter,
		/obj/item/dest_tagger,
		/obj/item/stamp,
		/obj/item/storage/bag/mail,
		/obj/item/universal_scanner,
	)

// Quartermaster

/obj/item/clothing/suit/jacket/quartermaster
	name = "后勤官大衣"
	desc = "一件用袋鼠皮制成的棕色双排扣奢侈品大衣。其金色袖口彼此相连，样式仿照信用点符号。它让你觉得自己比实际更重要。"
	icon_state = "qm_coat"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/jacket/quartermaster/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/stamp,
		/obj/item/storage/bag/mail,
		/obj/item/universal_scanner,
		/obj/item/melee/baton/telescopic,
	)

/obj/item/clothing/suit/toggle/lawyer/greyscale
	name = "正式西装外套"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/lawyer/greyscale"
	post_init_icon_state = "jacket_lawyer"
	inhand_icon_state = ""
	greyscale_config = /datum/greyscale_config/jacket_lawyer
	greyscale_config_worn = /datum/greyscale_config/jacket_lawyer/worn
	greyscale_colors = "#ffffff"
	flags_1 = IS_PLAYER_COLORABLE_1

//Mime
/obj/item/clothing/suit/toggle/suspenders
	name = "吊带"
	desc = "它们吊起默剧表演的幻觉。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/suspenders"
	post_init_icon_state = "suspenders"
	worn_icon = 'icons/mob/clothing/suits/utility.dmi'
	worn_icon_state = "suspenders"
	blood_overlay_type = "armor" //it's the less thing that I can put here
	toggle_noun = "带子"
	species_exception = list(/datum/species/golem)
	greyscale_config = /datum/greyscale_config/suspenders
	greyscale_config_worn = /datum/greyscale_config/suspenders/worn
	greyscale_colors = "#972A2A"
	flags_1 = IS_PLAYER_COLORABLE_1

//Security
/obj/item/clothing/suit/jacket/officer/blue
	name = "安保官夹克"
	desc = "这件夹克适合那些安保官无需穿着护甲的特别场合。"
	icon_state = "officerbluejacket"
	inhand_icon_state = null
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/jacket/officer/tan
	name = "安保官夹克"
	desc = "这件夹克适合那些安保官无需穿着护甲的特别场合。"
	icon_state = "officertanjacket"
	inhand_icon_state = null
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/jacket/warden/blue
	name = "典狱长夹克"
	desc = "非常适合想给造访禁闭室的访客留下风格印象的典狱长。"
	icon_state = "wardenbluejacket"
	inhand_icon_state = null
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/jacket/warden/tan
	name = "典狱长夹克"
	desc = "非常适合想给造访禁闭室的访客留下风格印象的典狱长。"
	icon_state = "wardentanjacket"
	inhand_icon_state = null
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/jacket/hos/blue
	name = "安保主管夹克"
	desc = "这件衣物专为彰显上级权威而设计。"
	icon_state = "hosbluejacket"
	inhand_icon_state = null
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/jacket/hos/tan
	name = "安保主管夹克"
	desc = "这件衣物专为彰显上级权威而设计。"
	icon_state = "hostanjacket"
	inhand_icon_state = null
	body_parts_covered = CHEST|ARMS

//Surgeon
/obj/item/clothing/suit/apron/surgical
	name = "手术围裙"
	desc = "一条无菌的蓝色手术围裙。"
	icon_state = "surgical"
	allowed = list(
		/obj/item/bonesetter,
		/obj/item/cautery,
		/obj/item/defibrillator/compact,
		/obj/item/flashlight/pen,
		/obj/item/healthanalyzer,
		/obj/item/hemostat,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/syringe,
		/obj/item/retractor,
		/obj/item/scalpel,
		/obj/item/storage/pill_bottle,
		/obj/item/surgical_drapes,
		/obj/item/tank/internals/emergency_oxygen,
	)

/obj/item/clothing/suit/apron/surgical/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) // FISH DOCTOR?!

//Curator
/obj/item/clothing/suit/jacket/curator
	name = "寻宝者外套"
	desc = "既时尚又带轻甲，这件夹克深受全银河寻宝者喜爱。"
	icon_state = "curator"
	inhand_icon_state = null
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	allowed = list(
		/obj/item/melee/curator_whip,
		/obj/item/storage/bag/books,
		/obj/item/tank/internals,
	)
	armor_type = /datum/armor/jacket_curator
	cold_protection = CHEST|ARMS
	heat_protection = CHEST|ARMS

/datum/armor/jacket_curator
	melee = 25
	bullet = 10
	laser = 25
	energy = 35
	acid = 45

//Robotocist
/obj/item/clothing/suit/hooded/techpriest
	name = "科技教士长袍"
	desc = "献给那些真心钟爱自己烤面包机的人。"
	icon_state = "techpriest"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	hoodtype = /obj/item/clothing/head/hooded/techpriest

/obj/item/clothing/head/hooded/techpriest
	name = "科技教士兜帽"
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	desc = "一顶献给那些真心钟爱自己烤面包机的人的兜帽。"
	icon_state = "techpriesthood"
	inhand_icon_state = null
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS

// Atmos
/obj/item/clothing/suit/atmos_overalls
	name = "大气工程连体服"
	desc = "一套防火连体工作服，适合保护较薄的衣物免受气体泄漏影响。"
	icon = 'icons/obj/clothing/suits/utility.dmi'
	worn_icon = 'icons/mob/clothing/suits/utility.dmi'
	icon_state = "atmos_overalls"
	inhand_icon_state = ""
	body_parts_covered = CHEST|GROIN|LEGS
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/atmos_overalls
	species_exception = list(/datum/species/golem)
	allowed = list(
		/obj/item/analyzer,
		/obj/item/construction/rcd,
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag/construction,
		/obj/item/t_scanner,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/extinguisher,
		/obj/item/construction/rtd,
		/obj/item/gun/ballistic/rifle/rebarxbow,
		/obj/item/storage/bag/rebar_quiver,
	)
	supports_variations_flags = CLOTHING_DIGITIGRADE_MASK
	bodyshapes_with_variations = BODYSHAPE_DIGITIGRADE

/obj/item/clothing/suit/atmos_overalls/generate_digitigrade_icons(icon/base_icon, greyscale_colors)
	var/icon/legs = icon(SSgreyscale.GetColoredIconByType(/datum/greyscale_config/digitigrade, greyscale_colors), "apron_worn")
	return replace_icon_legs(base_icon, legs)

/datum/armor/atmos_overalls
	fire = 100
	acid = 50

/obj/item/clothing/suit/atmos_overalls/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)
