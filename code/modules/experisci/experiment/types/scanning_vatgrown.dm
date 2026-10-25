/datum/experiment/scanning/cytology
	name = "细胞学扫描实验"
	exp_tag = "细胞学扫描"

/datum/experiment/scanning/cytology/final_contributing_index_checks(datum/component/experiment_handler/experiment_handler, atom/target, typepath)
	return ..() && HAS_TRAIT(target, TRAIT_VATGROWN)

/datum/experiment/scanning/cytology/serialize_progress_stage(atom/target, list/seen_instances)
	return EXPERIMENT_PROG_INT("扫描培养槽培育的 [initial(target.name)] 样本", seen_instances.len, required_atoms[target])

/datum/experiment/scanning/cytology/slime
	name = "培养槽史莱姆扫描"
	description = "见过异种生物学围栏里的史莱姆吗？当初我们的研究员把一片发霉的面包扔进培养槽，它们就这样诞生了。再培育一只并汇报结果。"
	performance_hint = "从发霉的面包上擦取史莱姆细胞系，或对现有史莱姆进行活检取样。然后在培养槽中培育它。"
	required_atoms = list(/mob/living/basic/slime = 1)


