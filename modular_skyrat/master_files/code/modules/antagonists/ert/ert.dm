/datum/antagonist/ert/asset_protection
	name = "资产保护专员"
	outfit = /datum/outfit/centcom/asset_protection
	role = "专员"
	rip_and_tear = TRUE

/datum/antagonist/ert/asset_protection/New()
	. = ..()
	name_source = GLOB.commando_names

/datum/antagonist/ert/asset_protection/leader
	name = "资产保护官"
	outfit = /datum/outfit/centcom/asset_protection
	role = "保护官"
