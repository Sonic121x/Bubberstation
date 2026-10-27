/// Singleton datums used to hold material property info
/datum/material_property
	abstract_type = /datum/material_property
	var/name = "错误"
	/// Associated property ID
	var/id = null
	/// Should this property be inherited by child materials?
	var/inherited = TRUE

/// Returns a string to display to sci glasses wearers when the material is examined
/datum/material_property/proc/get_descriptor(value)
	return null

/// Returns the contents of the tooltip under our descriptor
/datum/material_property/proc/get_tooltip(value)
	return "[value < 0 ? "-" : ""]\Roman[round(abs(value), 1)]"

/// Called whenever a material with this property initializes. Mostly used for behavior tracking on optional properties
/datum/material_property/proc/attach_to(datum/material/material)
	return

/// How dense a material is
/datum/material_property/density
	name = "密度"
	id = MATERIAL_DENSITY

/datum/material_property/density/get_descriptor(value)
	// Just for reference, IRL density of ABS plastic and water is ~1g/cm3, glass is 2.5, iron is 7.5 and lead is 11
	// So 0 ~ 1 would be paper/cardboard, then wood at 2, plastic at 3, glass at 4, iron at 6 and lead at 8 ~ 9
	switch(value)
		if (0 to 1)
			return "极为轻盈"
		if (1 to 2)
			return "非常轻盈"
		if (2 to 3)
			return "轻盈"
		if (3 to 4)
			return "略微致密"
		if (4 to 6)
			return "致密"
		if (6 to 8)
			return "非常致密"
		if (8 to INFINITY)
			return "极为致密"

/// How hard to deformation a material is, pierce/slashing impacts
/datum/material_property/hardness
	name = "硬度"
	id = MATERIAL_HARDNESS

/datum/material_property/hardness/get_descriptor(value)
	switch(value)
		if (0 to 1)
			return "极为柔软"
		if (1 to 2)
			return "非常柔软"
		if (2 to 3)
			return "柔软"
		if (3 to 4)
			return "略硬"
		if (4 to 6)
			return "坚硬"
		if (6 to 8)
			return "非常坚硬"
		if (8 to INFINITY)
			return "极为坚硬"

/// How well a material bends and sustains deformation
/datum/material_property/flexibility
	name = "柔韧性"
	id = MATERIAL_FLEXIBILITY

/datum/material_property/flexibility/get_descriptor(value)
	switch(value)
		if (0 to 1)
			return "极难弯曲"
		if (1 to 2)
			return "很难弯曲"
		if (2 to 3)
			return "不易弯曲"
		if (3 to 4)
			return "略有柔韧性"
		if (4 to 6)
			return "柔韧"
		if (6 to 8)
			return "非常柔韧"
		if (8 to INFINITY)
			return "极为柔韧"

/// How shiny a material is
/datum/material_property/reflectivity
	name = "反射率"
	id = MATERIAL_REFLECTIVITY

/datum/material_property/reflectivity/get_descriptor(value)
	switch(value)
		if (0 to 1)
			return "极为暗淡"
		if (1 to 2)
			return "非常暗淡"
		if (2 to 3)
			return "暗淡"
		if (3 to 4)
			return "哑光"
		if (4 to 6)
			return "反光"
		if (6 to 8)
			return "高度反光"
		if (8 to INFINITY)
			return "极度反光"

/// How electrically conductive a material is (siemens coeff)
/datum/material_property/electric_conductivity
	name = "导电性"
	id = MATERIAL_ELECTRICAL

/datum/material_property/electric_conductivity/get_descriptor(value)
	switch(value)
		if (0)
			return "完全绝缘"
		if (0 to 1)
			return "高度绝缘"
		if (1 to 2)
			return "绝缘"
		if (2 to 3)
			return "绝缘性较差"
		if (3 to 4)
			return "略微导电"
		if (4 to 6)
			return "导电"
		if (6 to 8)
			return "高度导电"
		if (8 to INFINITY)
			return "极度导电"

/// How well a material conducts heat
/datum/material_property/thermal_conductivity
	name = "导热性"
	id = MATERIAL_THERMAL

/datum/material_property/thermal_conductivity/get_descriptor(value)
	switch(value)
		if (0 to 1)
			return "极强隔热性"
		if (1 to 2)
			return "很强隔热性"
		if (2 to 3)
			return "隔热"
		if (3 to 4)
			return "略微导热"
		if (4 to 6)
			return "导热"
		if (6 to 8)
			return "高度导热"
		if (8 to INFINITY)
			return "极度导热"

/// How well the material resists acids and other similar chemicals
/datum/material_property/chemical_resistance
	name = "耐化学性"
	id = MATERIAL_CHEMICAL

/datum/material_property/chemical_resistance/get_descriptor(value)
	switch(value)
		if (0 to 1)
			return "极易发生化学反应"
		if (1 to 2)
			return "易发生化学反应"
		if (2 to 3)
			return "略易发生化学反应"
		if (3 to 4)
			return "略有耐化学性"
		if (4 to 6)
			return "耐化学性良好"
		if (6 to 8)
			return "耐化学性很强"
		if (8 to INFINITY)
			return "耐化学性极强"
