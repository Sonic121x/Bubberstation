/*
/obj/item/stack/sheet/mineral/plasma/Initialize()
	. = ..()
	icon = 'modular_z121/icons/obj/stack_objects.dmi'
	novariants = FALSE

/obj/item/stack/sheet/mineral/uranium
	icon = 'modular_z121/icons/obj/stack_objects.dmi'
	novariants = FALSE

/obj/item/stack/sheet/mineral/bananium
	icon = 'modular_z121/icons/obj/stack_objects.dmi'
	novariants = FALSE

/obj/item/stack/sheet/mineral/diamond
	icon = 'modular_z121/icons/obj/stack_objects.dmi'
	novariants = FALSE
*/
//StackSpawner
/obj/item/stackspawner
	name = "快速材料生成器"
	desc = "快速生成一叠指定材料。"
	icon = 'modular_skyrat/modules/ghostcafe/icons/stackspawner.dmi'
	icon_state = "stackspawner"

	var/obj/item/stack/itemstack
	var/spawnamount = 50

/obj/item/stackspawner/attack_self(mob/user)
	. = ..()

	var/static/list/material_list
	if(!material_list)
		material_list = list(
			"Metal"						= image(icon = icon, icon_state = "metal"),
			"Glass"						= image(icon = icon, icon_state = "glass"),
			"Plasma"					= image(icon = icon, icon_state = "plasma"),
			"Silver"					= image(icon = icon, icon_state = "silver"),
			"Titanium"					= image(icon = icon, icon_state = "titanium"),
			"Gold"						= image(icon = icon, icon_state = "gold"),
			"Uranium"					= image(icon = icon, icon_state = "uranium"),
			"Diamond"					= image(icon = icon, icon_state = "diamond"),
			"Bluespace"					= image(icon = icon, icon_state = "bluespace"),
			"Bananium"					= image(icon = icon, icon_state = "bananium"),
			"Plasteel"					= image(icon = icon, icon_state = "plasteel"),
			"Plastic"					= image(icon = icon, icon_state = "plastic"),
			"Plastitanium"				= image(icon = icon, icon_state = "plastitanium"),
			"Reinforced Glass"			= image(icon = icon, icon_state = "rglass"),
			"Plasma Glass"				= image(icon = icon, icon_state = "pglass"),
			"Plasma Reinforced Glass"	= image(icon = icon, icon_state = "prglass"),
			"Titanium Glass"			= image(icon = icon, icon_state = "tglass"),
			"Plastitanium Glass"		= image(icon = icon, icon_state = "ptglass"),
			"Bronze"					= image(icon = icon, icon_state = "brass"),
			"Runite"					= image(icon = icon, icon_state = "runite"),
			"Runed"						= image(icon = icon, icon_state = "runed"),
			"Mythril"					= image(icon = icon, icon_state = "mythril"),
			"Adamantine"				= image(icon = icon, icon_state = "adamantine"),
			"Alien Alloy"				= image(icon = icon, icon_state = "alien"),
			//"Alien Glass"				= image(icon = icon, icon_state = "aglass"),
			"Coal"						= image(icon = icon, icon_state = "coal"),
			"Wood"						= image(icon = icon, icon_state = "wood"),
			"Rods"						= image(icon = icon, icon_state = "rods"),
			"Sandstone"					= image(icon = icon, icon_state = "sandstone"),
			"Snow"						= image(icon = icon, icon_state = "snow"),
			"Paper"						= image(icon = icon, icon_state = "paper"),
			"Cloth"						= image(icon = icon, icon_state = "cloth"),
			"Leather"					= image(icon = icon, icon_state = "leather"),
			"Durathread"				= image(icon = icon, icon_state = "durathread"),
			"Cardboard"					= image(icon = icon, icon_state = "cardboard"),
			"Bamboo"					= image(icon = icon, icon_state = "bamboo"),
			"Wrapping Paper"			= image(icon = icon, icon_state = "wrapping"),
			"Bone"						= image(icon = icon, icon_state = "bone"),
			"Sinew"						= image(icon = icon, icon_state = "sinew"),
			"Goliath Hide"				= image(icon = icon, icon_state = "goliath"),
			"Dragon Hide"				= image(icon = icon, icon_state = "dragon")
		)

	var/static/list/material_labels = list(
		"Metal" = "金属", "Glass" = "玻璃", "Plasma" = "等离子", "Silver" = "银", "Titanium" = "钛",
		"Gold" = "金", "Uranium" = "铀", "Diamond" = "钻石", "Bluespace" = "蓝空间水晶", "Bananium" = "香蕉矿",
		"Plasteel" = "塑钢", "Plastic" = "塑料", "Plastitanium" = "塑钛", "Reinforced Glass" = "强化玻璃",
		"Plasma Glass" = "等离子玻璃", "Plasma Reinforced Glass" = "强化等离子玻璃", "Titanium Glass" = "钛玻璃",
		"Plastitanium Glass" = "塑钛玻璃", "Bronze" = "青铜", "Runite" = "符文矿", "Runed" = "符文金属",
		"Mythril" = "秘银", "Adamantine" = "精金", "Alien Alloy" = "外星合金", "Coal" = "煤", "Wood" = "木材",
		"Rods" = "金属棒", "Sandstone" = "砂岩", "Snow" = "雪", "Paper" = "纸", "Cloth" = "布",
		"Leather" = "皮革", "Durathread" = "耐久纤维", "Cardboard" = "纸板", "Bamboo" = "竹子",
		"Wrapping Paper" = "包装纸", "Bone" = "骨头", "Sinew" = "肌腱", "Goliath Hide" = "歌利亚皮", "Dragon Hide" = "龙皮",
	)
	var/list/display_options = list()
	var/list/option_keys = list()
	for(var/material_key in material_list)
		var/label = material_labels[material_key] || material_key
		display_options[label] = material_list[material_key]
		option_keys[label] = material_key
	var/choice = option_keys[show_radial_menu(user, src, display_options, radius = 50, tooltips = TRUE)]
	if(!choice)
		return
	switch(choice)
		if("Metal")
			itemstack = /obj/item/stack/sheet/iron
		if("Glass")
			itemstack = /obj/item/stack/sheet/glass
		if("Plasma")
			itemstack = /obj/item/stack/sheet/mineral/plasma
		if("Silver")
			itemstack = /obj/item/stack/sheet/mineral/silver
		if("Titanium")
			itemstack = /obj/item/stack/sheet/mineral/titanium
		if("Gold")
			itemstack = /obj/item/stack/sheet/mineral/gold
		if("Uranium")
			itemstack = /obj/item/stack/sheet/mineral/uranium
		if("Diamond")
			itemstack = /obj/item/stack/sheet/mineral/diamond
		if("Bluespace")
			itemstack = /obj/item/stack/sheet/bluespace_crystal
		if("Bananium")
			itemstack = /obj/item/stack/sheet/mineral/bananium
		if("Plasteel")
			itemstack = /obj/item/stack/sheet/plasteel
		if("Plastic")
			itemstack = /obj/item/stack/sheet/plastic
		if("Plastitanium")
			itemstack = /obj/item/stack/sheet/mineral/plastitanium
		if("Reinforced Glass")
			itemstack = /obj/item/stack/sheet/rglass
		if("Plasma Glass")
			itemstack = /obj/item/stack/sheet/plasmaglass
		if("Plasma Reinforced Glass")
			itemstack = /obj/item/stack/sheet/plasmarglass
		if("Titanium Glass")
			itemstack = /obj/item/stack/sheet/titaniumglass
		if("Plastitanium Glass")
			itemstack = /obj/item/stack/sheet/plastitaniumglass
		if("Runite")
			itemstack = /obj/item/stack/sheet/mineral/runite
		if("Bronze")
			itemstack = /obj/item/stack/tile/bronze
		if("Runed")
			itemstack = /obj/item/stack/sheet/runed_metal
		if("Mythril")
			itemstack = /obj/item/stack/sheet/mineral/mythril
		if("Adamantine")
			itemstack = /obj/item/stack/sheet/mineral/adamantine
		if("Alien Alloy")
			itemstack = /obj/item/stack/sheet/mineral/abductor
		//if("Alien Glass")
		//	itemstack =
		if("Coal")
			itemstack = /obj/item/stack/sheet/mineral/coal
		if("Wood")
			itemstack = /obj/item/stack/sheet/mineral/wood
		if("Rods")
			itemstack = /obj/item/stack/rods
		if("Sandstone")
			itemstack = /obj/item/stack/sheet/mineral/sandstone
		if("Snow")
			itemstack = /obj/item/stack/sheet/mineral/snow
		if("Paper")
			itemstack = /obj/item/stack/sheet/paperframes
		if("Cloth")
			itemstack = /obj/item/stack/sheet/cloth
		if("Leather")
			itemstack = /obj/item/stack/sheet/leather
		if("Durathread")
			itemstack = /obj/item/stack/sheet/durathread
		if("Cardboard")
			itemstack = /obj/item/stack/sheet/cardboard
		if("Bamboo")
			itemstack = /obj/item/stack/sheet/mineral/bamboo
		if("Wrapping Paper")
			itemstack = /obj/item/stack/wrapping_paper
		if("Bone")
			itemstack = /obj/item/stack/sheet/bone
		if("Sinew")
			itemstack = /obj/item/stack/sheet/sinew
		if("Goliath Hide")
			itemstack = /obj/item/stack/sheet/animalhide/goliath_hide
			spawnamount = 6
		if("Dragon Hide")
			itemstack = /obj/item/stack/sheet/animalhide/ashdrake
			spawnamount = 10

/obj/item/stackspawner/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/item/stack/spawnitemstack = new itemstack(get_turf(interacting_with))
	spawnitemstack.amount = spawnamount

/obj/machinery/stackspawner
	name = "快速材料生成器分发机"
	desc = "向所有敢于尝试的人提供快速材料生成器！"
	icon = 'modular_skyrat/modules/ghostcafe/icons/stackspawner.dmi'
	icon_state = "stackspawner_machine"

	density = FALSE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | FREEZE_PROOF

/obj/machinery/stackspawner/attack_hand(mob/living/user)
	. = ..()
	var/obj/item/stackspawner/SS = new /obj/item/stackspawner(get_turf(src))
	user.put_in_active_hand(SS)

/obj/machinery/stackspawner/attackby(obj/item/I, mob/living/user, params)
	if(I)
		return

/obj/machinery/stackspawner/attacked_by(obj/item/I, mob/living/user, attackchain_flags, damage_multiplier)
	if(I)
		return
