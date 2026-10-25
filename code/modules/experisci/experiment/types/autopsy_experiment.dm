/datum/experiment/autopsy
	name = "尸检实验"
	description = "一项需要通过尸检手术来推进的实验"
	exp_tag = "Autopsy"
	performance_hint = "在连接手术电脑的情况下进行尸检手术。"

/datum/experiment/autopsy/is_complete()
	return completed

/datum/experiment/autopsy/perform_experiment_actions(datum/component/experiment_handler/experiment_handler, mob/target)
	if (is_valid_autopsy(target))
		completed = TRUE
		return TRUE
	else
		return FALSE

/datum/experiment/autopsy/proc/is_valid_autopsy(mob/target)
	return TRUE

/datum/experiment/autopsy/human
	name = "人类尸检实验"
	description = "我们可不想投资一个连尾骨和耳蜗都分不清的空间站。给我们发回解剖人类的数据，就能获得更多经费。"

/datum/experiment/autopsy/human/is_valid_autopsy(mob/target)
	return ishumanbasic(target)

/datum/experiment/autopsy/nonhuman
	name = "非人类尸检实验"
	description = "我们说要尾骨的时候，并不是那个意思……听着，给我们发回任何不是人类的东西的数据。就算是一只猴子我们也无所谓，只要把研究数据发来。"

/datum/experiment/autopsy/nonhuman/is_valid_autopsy(mob/target)
	return ishuman(target) && !ishumanbasic(target)

/datum/experiment/autopsy/xenomorph
	name = "异形尸检实验"
	description = "我们对异形的了解还只触及皮毛。给我们发回解剖异形的研究数据。"

/datum/experiment/autopsy/xenomorph/is_valid_autopsy(mob/target)
	return isalien(target)
