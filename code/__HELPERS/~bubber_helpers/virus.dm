/datum/disease/advance/event/admin_details()
	var/list/name_symptoms = list()
	for(var/datum/symptom/S in symptoms)
		name_symptoms += S.name
	return "[name] - 症状：[english_list(name_symptoms)] 传播：[spreading_modifier] 传染性：[infectivity] 进展速度：[stage_prob] 治愈率：[cure_chance]"

/datum/disease/advance/proc/symptoms_list()
	var/list/name_symptoms = list()
	for(var/datum/symptom/S in symptoms)
		if(istype(S, /datum/symptom/viraladaptation) || istype(S, /datum/symptom/viralevolution))
			continue
		name_symptoms += S.name
	return english_list(name_symptoms)
