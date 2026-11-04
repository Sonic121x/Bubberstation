// Generate names independently of translated symptom labels.
/datum/disease/advance/floorfood/New()
	var/max_symptoms = rand(3, 4)
	for(var/i in 1 to max_symptoms)
		var/datum/symptom/chosen_symptom = pick_n_take(possible_symptoms)
		if(!chosen_symptom)
			continue
		symptoms += new chosen_symptom

	var/disease_id = GetDiseaseID()
	var/datum/disease/advance/archived_disease = SSdisease.archive_diseases[disease_id]
	if(archived_disease)
		name = archived_disease.name
	else
		name = generate_floorfood_name()

	Refresh()
	if(!archived_disease)
		AssignName(name)

/datum/disease/advance/floorfood/proc/generate_floorfood_name()
	var/static/list/prefixes = list("灰雾", "赤潮", "暮霭", "寒露", "幽蓝", "苍白", "暗紫", "微光")
	var/static/list/suffixes = list("症", "热", "综合征")
	if(!length(prefixes) || !length(suffixes))
		return "未命名病原体-[GetDiseaseID()]"
	var/prefix = pick(prefixes)
	var/suffix = pick(suffixes)
	if(!length(prefix) || !length(suffix))
		return "未命名病原体-[GetDiseaseID()]"
	return "[prefix][suffix]"
