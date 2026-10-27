/obj/effect/mob_spawn/ghost_role/human/lavaland_gasstation
	name = "加油站店员"
	desc = "里面好像有人正在安睡。"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "一名加油站工人"
	you_are_text = "你是采矿设施附近一家蜥蜴加油站的员工。"
	flavour_text = "然而你的雇主没意识到这一带有敌对的巨型生物和部落，所以务必确保你能自卫。另外，偶尔也要卖点东西给客人。"
	important_text = "绝不要让工作场所受损！也不要弃之不顾！"
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = TRUE
	outfit = /datum/outfit/lavaland_gasstation
	allow_custom_character = ALL

/datum/outfit/lavaland_gasstation
	name = "Lizard Gas Station Attendant"
	uniform = /obj/item/clothing/under/costume/lizardgas
	shoes = /obj/item/clothing/shoes/sneakers/black
	ears = /obj/item/instrument/piano_synth/headphones
	gloves = /obj/item/clothing/gloves/fingerless
	head = /obj/item/clothing/head/soft/purple
	l_pocket = /obj/item/modular_computer/pda
	id = /obj/item/card/id/advanced/lizardgas

/datum/outfit/lavaland_gasstation/post_equip(mob/living/carbon/human/clerk, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = clerk.wear_id
	if(istype(id_card))
		id_card.registered_name = clerk.real_name
		id_card.update_label()
		id_card.update_icon()
	handlebank(clerk)
	return ..()

/datum/outfit/hermit
	backpack_contents = list(/obj/item/research_paper = 1)

/datum/outfit/hermit/post_equip(mob/living/carbon/human/hermit, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	hermit.mind?.teach_crafting_recipe(/datum/crafting_recipe/research_paper)
	to_chat(hermit, span_notice("你学会了<b>研究论文</b>的配方，这让你能够无中生有地制作一切。"))

/// Manager and departmental ID additions
#define ROLE_LZGAS "Lizard Gas Station Manager"

/obj/effect/mob_spawn/ghost_role/human/lavaland_gasstation/manager
	name = "加油站经理"
	prompt_name = "一名加油站经理"
	outfit = /datum/outfit/lavaland_gasstation/manager
	you_are_text = "你是采矿设施附近一家蜥蜴加油站的部门经理。"
	flavour_text = "在蜥蜴加油站工作多年终于有了回报，你被提升为分部经理！遗憾的是，你的雇主没意识到这一带有敌对的巨型生物和部落，所以务必确保你能保护自己和你的员工。另外，偶尔也要卖点东西给客人。"
	important_text = "照顾好你的员工，他们无可替代！绝不要让工作场所受损！也不要弃之不顾！身为经理，你要以更高的标准要求自己。"

/datum/outfit/lavaland_gasstation/manager
	name = "Lizard Gas Station Manager"
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/knife/combat/survival = 1,
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 1,
		/obj/item/ammo_box/magazine/m45 = 3,
		)

/obj/item/card/id/faction_budget/lizgas
	department_ID = ACCOUNT_LIZ
	department_name = ACCOUNT_LIZ_NAME
	icon_state = "srv_budget" // Green just like our lizard.

#undef ROLE_LZGAS
