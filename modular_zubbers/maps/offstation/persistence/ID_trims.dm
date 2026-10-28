/datum/id_trim/syndicom/bubberstation

//Persistence

/datum/id_trim/syndicom/bubberstation/persistence
	assignment = "恒久号特工"
	trim_state = "trim_unknown"
	department_color = COLOR_ASSEMBLY_BLACK
	subdepartment_color = COLOR_SYNDIE_RED

/datum/id_trim/syndicom/bubberstation/persistence/prisoner
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "恒久号实习生"
	trim_state = "trim_ds2prisoner"
	subdepartment_color = COLOR_MAROON
	sechud_icon_state = SECHUD_DS2_PRISONER
	access = list(ACCESS_SYNDICATE)

/datum/id_trim/syndicom/bubberstation/persistence/syndicatestaff
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "恒久号普通职员"
	trim_state = "trim_ds2generalstaff"
	sechud_icon_state = SECHUD_DS2_GENSTAFF
	access = list(ACCESS_SYNDICATE)

/datum/id_trim/syndicom/bubberstation/persistence/janitor
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "恒久号清洁技术员"
	trim_state = "trim_ds2generalstaff"
	sechud_icon_state = SECHUD_DS2_GENSTAFF
	access = list(ACCESS_SYNDICATE)

/datum/id_trim/syndicom/bubberstation/persistence/researcher
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "恒久号研究员"
	trim_state = "trim_ds2researcher"
	sechud_icon_state = SECHUD_DS2_RESEARCHER
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS,ACCESS_RESEARCH,ACCESS_SCIENCE)

/datum/id_trim/syndicom/bubberstation/persistence/engineer
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "恒久号工程官"
	trim_state = "trim_ds2enginetech"
	sechud_icon_state = SECHUD_DS2_ENGINETECH

/datum/id_trim/syndicom/bubberstation/persistence/medicalofficer
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "恒久号医疗官"
	trim_state = "trim_ds2medicalofficer"
	sechud_icon_state = SECHUD_DS2_DOCTOR

/datum/id_trim/syndicom/bubberstation/persistence/cargo
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "恒久号货运技术员"
	trim_state = "trim_ds2miningofficer"
	sechud_icon_state = SECHUD_DS2_MININGOFFICER
	access = list(ACCESS_SYNDICATE, ACCESS_MINERAL_STOREROOM)

/datum/id_trim/syndicom/bubberstation/persistence/masteratarms
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "恒久号纠察长"
	trim_state = "trim_ds2masteratarms"
	sechud_icon_state = SECHUD_DS2_MASTERATARMS
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/bubberstation/persistence/brigofficer
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "恒久号拘留区长官"
	trim_state = "trim_ds2brigofficer"
	sechud_icon_state = SECHUD_DS2_BRIGOFFICER
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/bubberstation/persistence/corporateliasion
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "辛迪加企业联络官"
	trim_state = "trim_ds2corporateliaison"
	sechud_icon_state = SECHUD_DS2_CORPLIAISON
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/bubberstation/persistence/rigmanager
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "恒久号上将"
	trim_state = "trim_ds2admiral"
	sechud_icon_state = SECHUD_DS2_ADMIRAL
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/bubberstation/persistence/moraleofficer
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "恒久号士气官"
	trim_state = "trim_clown"
	sechud_icon_state = SECHUD_CLOWN
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)

/datum/id_trim/syndicom/bubberstation/persistence/assistant
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "恒久号休班职员"
	trim_state = "DS-2 General Staff"
	sechud_icon_state = SECHUD_CLOWN
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)
