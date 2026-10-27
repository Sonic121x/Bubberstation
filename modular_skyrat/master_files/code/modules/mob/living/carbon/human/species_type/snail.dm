#define SHELL_TRANSPARENCY_ALPHA 90

/datum/species/snail
	eyes_icon = 'modular_skyrat/modules/organs/icons/snail_eyes.dmi' //This is to consolidate our icons and prevent future calamity.
	mutantliver = /obj/item/organ/liver/snail //This is just a better liver to deal with toxins, it's a thematic thing.
	mutantheart = /obj/item/organ/heart/snail //This gives them the shell buff where they take less damage from behind, and their heart's more durable.
	exotic_bloodtype = null

	eyes_icon = 'modular_skyrat/modules/organs/icons/snail_eyes.dmi'

/datum/species/snail/on_species_gain(mob/living/carbon/new_snailperson, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	new_snailperson.update_icons()

/obj/item/storage/backpack/snail
	/// Whether or not a bluespace anomaly core has been inserted
	var/storage_core = FALSE
	slowdown = 6 // The snail's shell is what's making them slow.
	obj_flags = IMMUTABLE_SLOW //This should hopefully solve other issues involing it as well.
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER //This makes them layer over tails like the cult backpack; some tails really shouldn't appear over them!

/obj/item/storage/backpack/snail/Initialize(mapload)
	. = ..()
	atom_storage.max_total_storage = 30
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/snail_shell)

/datum/atom_skin/snail_shell
	abstract_type = /datum/atom_skin/snail_shell

/datum/atom_skin/snail_shell/conical
	preview_name = "圆锥壳"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "coneshell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/round
	preview_name = "圆壳"
	new_icon = 'icons/obj/storage/backpack.dmi'
	new_icon_state = "snailshell"
	new_worn_icon = 'icons/mob/clothing/back/backpack.dmi'

/datum/atom_skin/snail_shell/cinnamon
	preview_name = "肉桂壳"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "cinnamonshell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/caramel
	preview_name = "焦糖壳"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "caramelshell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/metal
	preview_name = "金属壳"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "mechashell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/pyramid
	preview_name = "金字塔壳"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "pyramidshell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/pyramid_ivory
	preview_name = "象牙金字塔壳"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "pyramidshellwhite"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/spiral
	preview_name = "螺旋壳"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "spiralshell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/spiral_ivory
	preview_name = "象牙螺旋壳"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "spiralshellwhite"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/rocky
	preview_name = "岩石壳"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "rockshell"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/datum/atom_skin/snail_shell/rocky_ivory
	preview_name = "象牙岩石壳"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	new_icon_state = "rockshellwhite"
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'

/obj/item/storage/backpack/snail/attackby(obj/item/core, mob/user)
	if(!istype(core, /obj/item/assembly/signaler/anomaly/bluespace))
		return ..()

	to_chat(user, span_notice("你把 [core] 插入自己的壳里，壳开始泛出蓝光，储物空间随之扩大！"))
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	add_filter("bluespace_shell", 2, list("type" = "outline", "color" = COLOR_BLUE_LIGHT, "size" = 1))
	storage_core = TRUE
	qdel(core)
	emptyStorage()
	create_storage(max_specific_storage = WEIGHT_CLASS_GIGANTIC, max_total_storage = 35, max_slots = 30, storage_type = /datum/storage/bag_of_holding)
	atom_storage.allow_big_nesting = TRUE
	name = "次元蜗牛壳"
	user.update_worn_back()
	update_appearance()

/obj/item/storage/backpack/snail/build_worn_icon(
	default_layer = 0,
	default_icon_file = null,
	isinhands = FALSE,
	female_uniform = NO_FEMALE_UNIFORM,
	override_state = null,
	override_file = null,
	mutant_styles = NONE,
	bodyshape = null
)

	var/mutable_appearance/standing = ..()
	if(storage_core == TRUE)
		standing.add_filter("bluespace_shell", 2, list("type" = "outline", "color" = COLOR_BLUE_LIGHT, "alpha" = SHELL_TRANSPARENCY_ALPHA, "size" = 1))
	return standing

/datum/species/snail/prepare_human_for_preview(mob/living/carbon/human/snail)
	snail.dna.features[FEATURE_MUTANT_COLOR] = "#adaba7"
	snail.update_body(TRUE)

/datum/species/snail/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "home",
			SPECIES_PERK_NAME = "有壳",
			SPECIES_PERK_DESC = "蜗牛背上长着与身体融为一体的壳。它能提供充裕的储物空间，最重要的是让蜗牛在背后受击或休息时减免 50% 的钝击伤害。按住 Alt 点击可更换外观！",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "wine-glass",
			SPECIES_PERK_NAME = "抗毒性",
			SPECIES_PERK_DESC = "蜗牛拥有强健的肝脏，因此对毒素有更高的耐受度。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "heart",
			SPECIES_PERK_NAME = "双心",
			SPECIES_PERK_DESC = "蜗牛有两颗心脏，因此要弄坏它们的心脏需要造成更多伤害。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "water",
			SPECIES_PERK_NAME = "水下呼吸",
			SPECIES_PERK_DESC = "蜗牛可以在水下呼吸。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bone",
			SPECIES_PERK_NAME = "无骨",
			SPECIES_PERK_DESC = "蜗牛是无脊椎动物，因此不会受到骨骼伤口，但也更容易被断肢。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "crutch",
			SPECIES_PERK_NAME = "涡轮加速",
			SPECIES_PERK_DESC = "蜗牛站立时移动极其缓慢。爬行时则快得多，而且在失去重力时能吸附在地面上。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "frown",
			SPECIES_PERK_NAME = "软塌塌",
			SPECIES_PERK_DESC = "蜗牛的出拳力度只有人类的一半。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "skull",
			SPECIES_PERK_NAME = "怕盐",
			SPECIES_PERK_DESC = "盐会灼伤蜗牛，盐堆还会挡住它们的去路。",
		),
	)

	return to_add

#undef SHELL_TRANSPARENCY_ALPHA
