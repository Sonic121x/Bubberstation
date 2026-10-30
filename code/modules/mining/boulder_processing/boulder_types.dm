#define BONUS_MATS_MINIMUM 1
#define BONUS_MATS_MAXIMUM 5

///Boulders with special artificats that can give higher mining points
/obj/item/boulder/artifact
	name = "秘藏巨石"
	desc = "这块巨石充满了奇异的能量。敲开它，也许能找到对科学研究不同寻常的东西。"
	icon_state = "boulder_artifact"
	/// This is the type of item that will be inside the boulder. Default is a strange object.
	var/artifact_type = /obj/item/assembly/relic/lavaland
	/// References to the relic inside the boulder, if any.
	var/obj/item/artifact_inside
	/// Bonus materials to add to this boulder, in addition to existing materials created by the ore vent.
	var/datum/material/bonus_mat

/obj/item/boulder/artifact/Initialize(mapload)
	. = ..()
	artifact_inside = new artifact_type(src) /// This could be poggers for archaeology in the future.
	if(bonus_mat)
		add_bonus_mats()

/obj/item/boulder/artifact/Destroy(force)
	QDEL_NULL(artifact_inside)
	return ..()

/obj/item/boulder/artifact/convert_to_ore()
	. = ..()
	artifact_inside.forceMove(drop_location())
	artifact_inside = null

/obj/item/boulder/artifact/break_apart()
	artifact_inside = null
	return ..()

/obj/item/boulder/artifact/update_icon_state()
	. = ..()
	icon_state = initial(icon_state) // Hardset to artifact sprites for consistency

/// Adds a random amount of material to an artifact boulder, determined by BONUS_MAT defines and of the type bonus_mat defined on the boulder.
/obj/item/boulder/artifact/proc/add_bonus_mats()
	var/list/bonus_mats = list()
	if(custom_materials)
		bonus_mats = custom_materials.Copy()
	bonus_mats[bonus_mat] += rand(BONUS_MATS_MINIMUM, BONUS_MATS_MAXIMUM) * SHEET_MATERIAL_AMOUNT
	set_custom_materials(bonus_mats)


/obj/item/boulder/artifact/bluespace
	icon_state = "boulder_artifact_BS"
	bonus_mat = /datum/material/bluespace

/obj/item/boulder/artifact/diamond
	icon_state = "boulder_artifact_diamond"
	bonus_mat = /datum/material/diamond

///Boulders spawned by the vent in the work camp, contain exclusively iron so we can have a reliable payout
/obj/item/boulder/gulag_vent
	name = "铁巨石"
	desc = "基本上就是一块生铁。用镐子把它敲碎。"
	// This produces 5 ore when smashed open because not using a machine reduces the ore count by one. 14 boulders x 15 ore x 5 points = 1050 points
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 16)

/// Boulders usually spawned in lavaland labour camp area, broken open with pickaxe like a loot box
/obj/item/boulder/gulag
	name = "劣质巨石"
	desc = "用镐子敲碎它，一次获得大量矿石。这石头真带劲。"

/obj/item/boulder/gulag/Initialize(mapload)
	. = ..()

	/// Static list of all minerals to populate gulag boulders with.
	var/static/list/gulag_minerals = list(
		/datum/material/gold = 1,
		/datum/material/iron = 5,
		/datum/material/plasma = 4,
		/datum/material/silver = 2,
	)

	var/amount = rand(10, 13)
	set_custom_materials(list(pick_weight(gulag_minerals) = SHEET_MATERIAL_AMOUNT * amount))

///lowgrade boulder, Exists as an admin spawn for testing and unit testing.
/obj/item/boulder/shabby
	name = "破旧巨石"
	desc = "一块古怪扭曲的巨石。等等，不对，只是一块石头。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.1, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.1)
	durability = 1

#undef BONUS_MATS_MINIMUM
#undef BONUS_MATS_MAXIMUM
