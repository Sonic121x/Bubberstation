///These alter reaction conditions while they're in the beaker
/datum/reagent/catalyst_agent
	name ="催化剂"
	///The typepath of the reagent they that they affect
	var/target_reagent_type
	///The minimumvolume required in the beaker for them to have an effect
	var/min_volume = 10
	///The value in which the associated type is modified
	var/modifier = 1

/datum/reagent/catalyst_agent/proc/consider_catalyst(datum/equilibrium/equilibrium)
	for(var/_product in equilibrium.reaction.results)
		if(ispath(_product, target_reagent_type))
			return TRUE
	return FALSE

/datum/reagent/catalyst_agent/speed
	name ="速度催化剂"

/datum/reagent/catalyst_agent/speed/consider_catalyst(datum/equilibrium/equilibrium)
	. = ..()
	if(.)
		equilibrium.speed_mod = creation_purity*modifier //So a purity 1 = the modifier, and a purity 0 = the inverse modifier. For this we don't want a negative speed_mod (I have no idea what happens if we do)
		equilibrium.time_deficit += (creation_purity)*(0.05 * modifier) //give the reaction a little boost too (40% faster)

/datum/reagent/catalyst_agent/ph
	name ="pH 催化剂"

/datum/reagent/catalyst_agent/ph/consider_catalyst(datum/equilibrium/equilibrium)
	. = ..()
	if(.)
		equilibrium.h_ion_mod = ((creation_purity-0.5)*2)*modifier //So a purity 1 = the modifier, and a purity 0 = the inverse modifier

/datum/reagent/catalyst_agent/temperature
	name = "温度催化剂"

/datum/reagent/catalyst_agent/temperature/consider_catalyst(datum/equilibrium/equilibrium)
	. = ..()
	if(.)
		equilibrium.thermic_mod = ((creation_purity-0.5)*2)*modifier //So a purity 1 = the modifier, and a purity 0 = the inverse modifier 
///Note from confused guy: It looks like this makes endothermic reactions suddenly become violently exothermic and visa versa at low purities. Wacky.

///Catalyst precursors (oh boy here i go competing again). P is the harder one to make, (ie. requires a good heater or some extra materials), because it is probably more useful
/datum/reagent/catalyst_precursor_ph
	name = "催化素 P"
	description = "这种试剂与前体因子化学性质相近，是离子调节剂的前体，会与稳定等离子体反应生成离子调节剂。"
	color = "#bafa69"
	ph = 7

/datum/reagent/catalyst_precursor_temp
	name = "催化素 T"
	description = "这种试剂与前体因子化学性质相近，是热力调节剂的前体，会与稳定等离子体反应生成热力调节剂。"
	color = "#c91a1a"
	ph = 7



///General catalysts
/datum/reagent/catalyst_agent/ph/generic
	name = "离子调节剂"
	target_reagent_type = /datum/reagent
	modifier = 0.5
	description = "这种催化试剂会稳定烧杯中的反应，减少反应中的化学物质引起的 pH 变化。"
	ph = 7 //perfectly balanced, as all things should be. (also it's a ph moderator so this makes sense)
	color = "#84e30b" //green = neutrality on a ph strip so a neutrality enforcing chem is bright green. logic.

/datum/reagent/catalyst_agent/temperature/generic
	name = "热力调节剂"
	target_reagent_type = /datum/reagent
	modifier = 0.5
	description = "这种催化试剂会稳定烧杯中的反应，减少其吸热/放热效应。"
	ph = 7 //perfectly balanced, as all things should be. (also it's a nonreactive catalyst so this makes sense)
	color = "#84e30b"




///These affect medicines
/datum/reagent/catalyst_agent/speed/medicine
	name = "钯合成物催化剂"
	description = "这种催化试剂会大幅加速与其同处一个烧杯中的所有药物反应。"
	target_reagent_type = /datum/reagent/medicine
	modifier = 2
	ph = 2 //drift towards acidity
	color = "#b1b1b1"
