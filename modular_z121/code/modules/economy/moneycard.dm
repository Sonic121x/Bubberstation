/*
/obj/item/holochip/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/card/id))
		var/obj/item/card/id/ID = I
		if(!ID.registered_account)
			to_chat(user, "<span class='warning'>[ID] doesn't have a linked account to deposit into!</span>")
			return
		for(var/obj/item/holochip/money in src.loc.contents)
			ID.attackby(money, user)
		for(var/obj/item/stack/spacecash/money in src.loc.contents)
			ID.attackby(money, user)
		for(var/obj/item/coin/money in src.loc.contents)
			ID.attackby(money, user)

/obj/item/stack/spacecash/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/card/id))
		var/obj/item/card/id/ID = W
		if(!ID.registered_account)
			to_chat(user, "<span class='warning'>[ID] doesn't have a linked account to deposit into!</span>")
			return
		for(var/obj/item/holochip/money in src.loc.contents)
			ID.attackby(money, user)
		for(var/obj/item/stack/spacecash/money in src.loc.contents)
			ID.attackby(money, user)
		for(var/obj/item/coin/money in src.loc.contents)
			ID.attackby(money, user)

/obj/item/coin/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/card/id))
		var/obj/item/card/id/ID = W
		if(!ID.registered_account)
			to_chat(user, "<span class='warning'>[ID] doesn't have a linked account to deposit into!</span>")
			return
		for(var/obj/item/holochip/money in src.loc.contents)
			ID.attackby(money, user)
		for(var/obj/item/stack/spacecash/money in src.loc.contents)
			ID.attackby(money, user)
		for(var/obj/item/coin/money in src.loc.contents)
			ID.attackby(money, user)
	else
		..()

//资金卡
/obj/item/card/id/departmental_budget/med
	department_ID = ACCOUNT_MED
	department_name = ACCOUNT_MED_NAME
	icon_state = "med_budget"

/obj/item/card/id/departmental_budget/eng
	department_ID = ACCOUNT_ENG
	department_name = ACCOUNT_ENG_NAME
	icon_state = "eng_budget"

/obj/item/card/id/departmental_budget/sec
	department_ID = ACCOUNT_SEC
	department_name = ACCOUNT_SEC_NAME
	icon_state = "sec_budget"

/obj/item/card/id/departmental_budget/sci
	department_ID = ACCOUNT_SCI
	department_name = ACCOUNT_SCI_NAME
	icon_state = "sci_budget"

/obj/item/card/id/departmental_budget/srv
	department_ID = ACCOUNT_SRV
	department_name = ACCOUNT_SRV_NAME
	icon_state = "srv_budget"

//资金卡添加
/obj/structure/closet/secure_closet/chief_medical/PopulateContents()
	..()
	new /obj/item/card/id/departmental_budget/med(src)

/obj/structure/closet/secure_closet/engineering_chief/PopulateContents()
	..()
	new /obj/item/card/id/departmental_budget/eng(src)

/obj/structure/closet/secure_closet/hos/PopulateContents()
	..()
	new /obj/item/card/id/departmental_budget/sec(src)

/obj/structure/closet/secure_closet/research_director/PopulateContents()
	..()
	new /obj/item/card/id/departmental_budget/sci(src)

/obj/structure/closet/secure_closet/hop/PopulateContents()
	..()
	new /obj/item/card/id/departmental_budget/srv(src)
*/
#define WILDCARD_LIMIT_GREY_121 list( \
	WILDCARD_NAME_COMMON = list(limit = -1, usage = list()), \
	WILDCARD_NAME_COMMAND = list(limit = 8, usage = list()) \
)
#define WILDCARD_LIMIT_SILVER_121 list( \
	WILDCARD_NAME_COMMAND = list(limit = -1, usage = list()), \
	WILDCARD_NAME_PRV_COMMAND = list(limit = 3, usage = list()) \
)
#define WILDCARD_LIMIT_CHAMELEON_121 list( \
	WILDCARD_NAME_CAPTAIN = list(limit = -1, usage = list()) \
)
/obj/item/card/id/advanced
	wildcard_slots = WILDCARD_LIMIT_GREY_121

/obj/item/card/id/advanced/silver
	wildcard_slots = WILDCARD_LIMIT_SILVER_121

/obj/item/card/id/advanced/chameleon
	wildcard_slots = WILDCARD_LIMIT_CHAMELEON_121

/obj/item/card/id/advanced/centcom/station
	wildcard_slots = WILDCARD_LIMIT_SILVER_121

/obj/item/card/id/advanced/robotic
	wildcard_slots = WILDCARD_LIMIT_SILVER_121

/datum/id_trim/centcom/foundation
	assignment = "SCP基金会"
	sechud_icon_state = "SECHUD_FOUNDATION"

/obj/item/card/id/scp
	name = "SCP基金会ID"
	desc = "SCP基金会的外勤ID，已经写入了所有通行权限以用于执行各种机密任务"
	icon = 'modular_z121/icons/obj/card.dmi'
	icon_state = "card_SCP"
	trim = /datum/id_trim/centcom/foundation
	wildcard_slots = WILDCARD_LIMIT_CENTCOM
