/proc/meta_gas_list()
	var/list/gas_info = new (META_GAS_LENGTH)
	for (var/array_idx in 1 to gas_info.len)
		gas_info[array_idx] = list()

	var/list/gas_types = subtypesof(/datum/gas)
	ASSERT(GAS_TYPE_COUNT == length(gas_types),\
		"GAS_TYPE_COUNT != length(subtypesof(gas_types)), if you added new gas please increment GAS_TYPE_COUNT")
	for(var/datum/gas/gas_path as anything in gas_types)
		gas_info[META_GAS_SPECIFIC_HEAT][gas_path] = initial(gas_path.specific_heat)
		gas_info[META_GAS_NAME][gas_path] = initial(gas_path.name)
		gas_info[META_GAS_MOLES_VISIBLE][gas_path] = initial(gas_path.moles_visible)
		if (gas_info[META_GAS_MOLES_VISIBLE][gas_path])
			gas_info[META_GAS_OVERLAY][gas_path] += generate_gas_overlays(0, SSmapping.max_plane_offset, gas_path)
		gas_info[META_GAS_FUSION_POWER][gas_path] = initial(gas_path.fusion_power)
		gas_info[META_GAS_DANGER][gas_path] = initial(gas_path.cargo_flags) & GAS_DANGEROUS
		gas_info[META_GAS_ID][gas_path] = initial(gas_path.id)
		gas_info[META_GAS_DESC][gas_path] = initial(gas_path.desc)

	/datum/gas_mixture::gas_meta = gas_info // save the reference to the list
	return gas_info

/proc/generate_gas_overlays(old_offset, new_offset, datum/gas/gas_type)
	var/list/to_return = list()
	for(var/i in old_offset to new_offset)
		var/fill = list()
		to_return += list(fill)
		for(var/j in 1 to TOTAL_VISIBLE_STATES)
			var/obj/effect/overlay/gas/gas = new (initial(gas_type.gas_overlay), log(4, (j+0.4*TOTAL_VISIBLE_STATES) / (0.35*TOTAL_VISIBLE_STATES)) * 255, i)
			fill += gas
	return to_return

/proc/gas_id2path(id)
	var/list/meta_gas_id = GLOB.meta_gas_info[META_GAS_ID]
	if(id in meta_gas_id)
		return id
	for(var/path, meta_id in meta_gas_id)
		if(meta_id == id)
			return path
	return ""

/**
 * # Gas datums
 *
 * These are never and should never be instantiated,
 * they just exist to hold data which is passed into the gas metadata list.
 *
 * They are templates for how gases should generally act.
 */
/datum/gas
	var/id = ""
	var/specific_heat = 0
	var/name = ""
	var/desc
	///icon_state in icons/effects/atmospherics.dmi
	var/gas_overlay = ""
	var/moles_visible = null
	///How much the gas accelerates a fusion reaction
	var/fusion_power = 0
	/// relative rarity compared to other gases, used when setting up the reactions list.
	var/rarity = 0
	/// Flags that relate to how the gas is handled in cargo
	/// GAS_PURCHASABLE - Can be purchased in cargo
	/// GAS_EXPORTABLE - Can be sold in cargo
	/// GAS_DANGEROUS - Is considered dangerous, requires elevated access to purchase
	var/cargo_flags = NONE
	/// How does a single mole of this gas buy/sell for?
	/// Formula to calculate maximum value is in [code\modules\cargo\exports\large_objects.dm].
	/// Only necessary for exportable or purchasable gases, otherwise meaningless.
	var/base_value = 0
	/// RGB code for use when a generic color representing the gas is needed. Colors taken from contants.ts
	var/primary_color

/datum/gas/oxygen
	id = GAS_O2
	specific_heat = 20
	name = "氧气"
	rarity = 900
	cargo_flags = GAS_PURCHASABLE
	base_value = 0.2
	desc = "大多数生命形式赖以生存的气体。同时也是一种氧化剂。"
	primary_color = "#0000ff"

/datum/gas/nitrogen
	id = GAS_N2
	specific_heat = 20
	name = "氮气"
	rarity = 1000
	cargo_flags = GAS_PURCHASABLE
	base_value = 0.1
	desc = "一种非常常见的气体，用于将人造大气补充至适宜居住的气压。"
	primary_color = "#ffff00"

/datum/gas/carbon_dioxide //what the fuck is this?
	id = GAS_CO2
	specific_heat = 30
	name = "二氧化碳"
	rarity = 700
	cargo_flags = GAS_PURCHASABLE | GAS_DANGEROUS
	base_value = 0.2
	desc = "二氧化碳到底他妈的是什么东西？"
	// desc = "A colorless, odorless gas commonly produced by respiration and combustion. Potentially dangerous when inhaled in high concentrations."
	primary_color = COLOR_GRAY

/datum/gas/plasma
	id = GAS_PLASMA
	specific_heat = 200
	name = "等离子体"
	gas_overlay = "plasma"
	moles_visible = MOLES_GAS_VISIBLE
	cargo_flags = GAS_DANGEROUS
	rarity = 800
	base_value = 1.5
	desc = "一种具有许多奇特性质的可燃气体。对它的研究是纳米传讯的主要目标之一。"
	primary_color = "#ffc0cb"

/datum/gas/water_vapor
	id = GAS_WATER_VAPOR
	specific_heat = 40
	name = "水蒸气"
	gas_overlay = "water_vapor"
	moles_visible = MOLES_GAS_VISIBLE
	fusion_power = 8
	rarity = 500
	cargo_flags = GAS_PURCHASABLE
	base_value = 0.5
	desc = "气态的水。会使地板变滑，并清洗其上的物品。"
	primary_color = "#b0c4de"

/datum/gas/hypernoblium
	id = GAS_HYPER_NOBLIUM
	specific_heat = 2000
	name = "超惰性气体"
	gas_overlay = "freon"
	moles_visible = MOLES_GAS_VISIBLE
	fusion_power = 10
	rarity = 50
	cargo_flags = GAS_EXPORTABLE
	base_value = 2.5
	desc = "所有气体中最惰性的一种。大量存在时会主动阻止反应发生。"
	primary_color = COLOR_TEAL

/datum/gas/nitrous_oxide
	id = GAS_N2O
	specific_heat = 40
	name = "一氧化二氮"
	gas_overlay = "nitrous_oxide"
	moles_visible = MOLES_GAS_VISIBLE * 2
	fusion_power = 10
	rarity = 600
	cargo_flags = GAS_PURCHASABLE | GAS_DANGEROUS
	base_value = 1.5
	desc = "一种会引起困倦、欣快感，最终导致失去意识的气体。\
		常用于手术麻醉，偶尔也被用作娱乐性药物。"
	primary_color = "#ffe4c4"

/datum/gas/nitrium
	id = GAS_NITRIUM
	specific_heat = 10
	name = "氮素气"
	fusion_power = 7
	gas_overlay = "nitrium"
	moles_visible = MOLES_GAS_VISIBLE
	cargo_flags = GAS_DANGEROUS | GAS_EXPORTABLE
	rarity = 1
	base_value = 6
	desc = "一种带有轻微毒性的实验性体能增强气体，吸入后可提升速度和警觉性。"
	primary_color = "#a52a2a"

/datum/gas/tritium
	id = GAS_TRITIUM
	specific_heat = 10
	name = "氚"
	gas_overlay = "tritium"
	moles_visible = MOLES_GAS_VISIBLE
	cargo_flags = GAS_DANGEROUS | GAS_EXPORTABLE
	fusion_power = 5
	rarity = 300
	base_value = 2.5
	desc = "一种高度易燃且具有放射性的气体。"
	primary_color = "#32cd32"

/datum/gas/bz
	id = GAS_BZ
	specific_heat = 20
	name = "BZ"
	fusion_power = 8
	rarity = 400
	cargo_flags = GAS_PURCHASABLE | GAS_EXPORTABLE | GAS_DANGEROUS
	base_value = 1.5
	desc = "一种强效致幻神经毒剂，能够造成认知损伤。"
	primary_color = "#9370db"

/datum/gas/pluoxium
	id = GAS_PLUOXIUM
	specific_heat = 80
	name = "富氧气"
	fusion_power = -10
	rarity = 200
	cargo_flags = GAS_EXPORTABLE
	base_value = 2.5
	desc = "一种氧气替代品，在肺部的扩散效率是氧气的八倍，\
		甚至具有轻微的治疗效果，而其本身并非氧化剂。"
	primary_color = "#7b68ee"

/datum/gas/miasma
	id = GAS_MIASMA
	specific_heat = 20
	name = "瘴气"
	cargo_flags = GAS_DANGEROUS | GAS_EXPORTABLE
	gas_overlay = "miasma"
	moles_visible = MOLES_GAS_VISIBLE * 60
	rarity = 250
	base_value = 1
	desc = "瘴气未必是一种气体，而是泛指大气中的生物污染物，\
		这些污染物会引发疾病和恶心。"
	primary_color = COLOR_OLIVE

/datum/gas/freon
	id = GAS_FREON
	specific_heat = 600
	name = "氟利昂"
	cargo_flags = GAS_DANGEROUS | GAS_EXPORTABLE
	gas_overlay = "freon"
	moles_visible = MOLES_GAS_VISIBLE *30
	fusion_power = -5
	rarity = 10
	base_value = 5
	desc = "一种冷却气体。主要利用其与氧气的吸热反应。"
	primary_color = "#afeeee"

/datum/gas/hydrogen
	id = GAS_HYDROGEN
	specific_heat = 15
	name = "氢气"
	cargo_flags = GAS_DANGEROUS | GAS_EXPORTABLE
	fusion_power = 2
	rarity = 600
	base_value = 1
	desc = "一种高度易燃的气体。"
	primary_color = "#ffffff"

/datum/gas/healium
	id = GAS_HEALIUM
	specific_heat = 10
	name = "愈合气"
	cargo_flags = GAS_DANGEROUS | GAS_EXPORTABLE
	gas_overlay = "healium"
	moles_visible = MOLES_GAS_VISIBLE
	rarity = 300
	base_value = 5.5
	desc = "一种实验性的麻醉剂替代品，吸入后会使人失去意识，\
		并在此状态下加速愈合与再生。"
	primary_color = "#fa8072"

/datum/gas/proto_nitrate
	id = GAS_PROTO_NITRATE
	specific_heat = 30
	name = "原硝气"
	cargo_flags = GAS_DANGEROUS | GAS_EXPORTABLE
	gas_overlay = "proto_nitrate"
	moles_visible = MOLES_GAS_VISIBLE
	rarity = 200
	base_value = 2.5
	desc = "一种非常不稳定的气体，与其他气体的反应各不相同。"
	primary_color = "#adff2f"

/datum/gas/zauker
	id = GAS_ZAUKER
	specific_heat = 350
	name = "灼蚀气"
	cargo_flags = GAS_DANGEROUS | GAS_EXPORTABLE
	gas_overlay = "zauker"
	moles_visible = MOLES_GAS_VISIBLE
	rarity = 1
	base_value = 7
	desc = "一种剧毒且难以制取的气体。\
		它接触氮气时会分解，因此在类似地球的大气中相对安全。"
	primary_color = "#006400"

/datum/gas/halon
	id = GAS_HALON
	specific_heat = 175
	name = "哈龙"
	cargo_flags = GAS_DANGEROUS | GAS_EXPORTABLE
	gas_overlay = "halon"
	moles_visible = MOLES_GAS_VISIBLE
	rarity = 300
	base_value = 4
	desc = "一种强效灭火剂。能从高温火焰中移除氧气，并降低该区域的温度。"
	primary_color = COLOR_PURPLE

/datum/gas/helium
	id = GAS_HELIUM
	specific_heat = 15
	name = "氦气"
	fusion_power = 7
	rarity = 50
	cargo_flags = GAS_EXPORTABLE
	base_value = 3.5
	desc = "一种由氢气及其衍生物聚变产生的惰性气体。\
		因比空气轻且吸入后会使声音变尖而广为人知。"
	primary_color = "#f0f8ff"

/datum/gas/antinoblium
	id = GAS_ANTINOBLIUM
	specific_heat = 1
	name = "反惰性气体"
	cargo_flags = GAS_DANGEROUS | GAS_EXPORTABLE
	gas_overlay = "antinoblium"
	moles_visible = MOLES_GAS_VISIBLE
	fusion_power = 20
	rarity = 1
	base_value = 10
	desc = "一种能够自我复制的神秘高活性气体。\
		因其稀有而备受追捧，出口时可卖出高价。"
	primary_color = COLOR_MAROON

/obj/effect/overlay/gas
	icon = 'icons/effects/atmospherics.dmi'
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE  // should only appear in vis_contents, but to be safe
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE
	appearance_flags = TILE_BOUND
	vis_flags = NONE
	// The visual offset we are "on".
	// Can't use the traditional loc because we are stored in nullspace, and we can't set plane before init because of the helping that SET_PLANE_EXPLICIT does IN init
	var/plane_offset = 0

/obj/effect/overlay/gas/New(state, alph, offset)
	. = ..()
	icon_state = state
	alpha = alph
	plane_offset = offset

/obj/effect/overlay/gas/Initialize(mapload)
	. = ..()
	SET_PLANE_W_SCALAR(src, initial(plane), plane_offset)
