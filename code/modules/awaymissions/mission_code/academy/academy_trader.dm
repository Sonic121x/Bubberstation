/mob/living/basic/trader/mr_corporate
	name = "企业先生"
	desc = "一名穿着 MOD 外骨骼的中央指挥部高级官员，看起来有点……浅薄。"
	speak_emote = list("要求")
	mob_biotypes = MOB_UNDEAD|MOB_HUMANOID
	gender = MALE
	spawner_path = /obj/effect/mob_spawn/corpse/human/skeleton/mr_corporate
	loot = list(/obj/effect/decal/remains/human)
	ranged_attack_casing = /obj/item/ammo_casing/a75
	held_weapon_visual = /obj/item/gun/ballistic/automatic/gyropistol
	trader_data_path = /datum/trader_data/mr_corporate

/obj/effect/mob_spawn/corpse/human/skeleton/mr_corporate
	mob_species = /datum/species/skeleton
	outfit = /datum/outfit/mr_corporate

/datum/outfit/mr_corporate
	name = "中央指挥部官员"
	uniform = /obj/item/clothing/under/rank/centcom/commander
	mask = /obj/item/clothing/mask/gas/atmos/centcom
	ears = /obj/item/radio/headset/headset_cent/alt/leader
	shoes = /obj/item/clothing/shoes/jackboots
	back = /obj/item/mod/control/pre_equipped/corporate
	gloves = /obj/item/clothing/gloves/kaza_ruk/combatglovesplus
	neck = /obj/item/clothing/neck/large_scarf/green
