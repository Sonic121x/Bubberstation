/*
Todo: Refactor upstream code so that item deletion is decided at the bounty level rather than at the machine running the bounty

/datum/bounty/item/blacksmith
	//if not null, bounty items require have required_material in its materials list
	var/datum/material/required_material = null
	//if not null, bounty items cannot contain this material
	var/list/blacklisted_materials = null
	//if true, redeeming a bounty item does not remove it (instead sets it as non-viable for future bounties)


/datum/bounty/item/applies_to(obj/shipped)
	if(shipped.GetComponent(/datum/component/block_redeemed_item_in_bounty))
		return FALSE
	else
		return ..()

/datum/bounty/item/ship(obj/shipped)
	if(!applies_to(shipped))
		return FALSE
	if(istype(shipped,/obj/item/stack))
		var/obj/item/stack/shipped_is_a_stack = shipped
		shipped_count += shipped_is_a_stack.amount
	else
		shipped_count += 1
	return TRUE

/datum/component/block_redeemed_item_in_bounty

*/

/datum/bounty/item/blacksmith/rail_track
	name = "铁轨"
	description = "电车又抛锚了。给我们造些铁轨，好让我们能四处走动。"
	reward = CARGO_CRATE_VALUE * 9.75
	required_count = 20
	wanted_types = list(/obj/item/stack/rail_track = TRUE)

/datum/bounty/item/blacksmith/cuffs
	name = "手铐"
	description = "我们的一位狱警又把所有手铐弄丢了。帮忙恢复秩序，运些手铐过来就能得到报酬。"
	reward = CARGO_CRATE_VALUE * 15
	required_count = 3
	wanted_types = list(/obj/item/restraints/handcuffs = TRUE) //This includes reagent cuffs

/datum/bounty/item/blacksmith/staff
	name = "法杖"
	description = "一位受人尊敬的宗教人士正在访问中央指挥部，却在路上弄丢了自己的法杖！请尽快送来一根替代品。"
	reward = CARGO_CRATE_VALUE * 5.25
	wanted_types = list(/obj/item/melee/forged_reagent_weapon/staff = TRUE)

/datum/bounty/item/blacksmith/swords
	name = "长剑"
	description = "我们实习生的莫辛-纳甘全坏了，运些长剑来让他们有件能打的东西。"
	required_count = 3
	reward = CARGO_CRATE_VALUE * 17
	wanted_types = list(/obj/item/melee/forged_reagent_weapon/sword = TRUE)

/datum/bounty/item/blacksmith/armor
	name = "护甲部件"
	description = "我们的安保指挥官想要一件新的板甲来装饰办公室。立刻给他送些过去"
	required_count = 2
	reward = CARGO_CRATE_VALUE * 13
	wanted_types = list(/obj/item/clothing/shoes/forging_plate_boots = TRUE,
						/obj/item/clothing/head/helmet/forging_plate_helmet = TRUE,
						/obj/item/clothing/gloves/forging_plate_gloves = TRUE,
						/obj/item/clothing/suit/armor/forging_plate_armor = TRUE
						)

/datum/bounty/item/blacksmith/katana
	name = "武士刀"
	description = "我们的一位科研人员要去参加太空动漫展，想炫耀一把真正的武士刀！送一把来，好让他别再烦我们。"
	reward = CARGO_CRATE_VALUE * 5.5
	wanted_types = list(/obj/item/melee/forged_reagent_weapon/katana = TRUE)
