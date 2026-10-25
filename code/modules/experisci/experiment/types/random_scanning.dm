/datum/experiment/scanning/random
	name = "基础随机扫描实验"
	description = "该实验的内容将随机生成。祝你好运！"
	///list of types which that can be included in the experiment. Randomly picked from on New
	var/list/possible_types = list()
	/// The total desired number of atoms to have scanned
	var/total_requirement = 0
	/// Max amount of a requirement per type
	var/max_requirement_per_type = 100

/datum/experiment/scanning/random/New(datum/techweb/techweb)
	// Generate random contents
	if (possible_types.len)
		var/picked = 0
		while (picked < total_requirement)
			var/randum = min(rand(1, total_requirement - picked), max_requirement_per_type) //Short for "random num" and not "this is dum that I have to rename 100 different variable names"
			required_atoms[pick(possible_types)] += randum
			picked += randum

	// Fill the experiment as per usual
	..()

/datum/experiment/scanning/random/mecha_damage_scan/New(datum/techweb/techweb)
	. = ..()
	damage_percent = rand(15, 95)
	//updating the description with the damage_percent var set
	description = "你的外骨骼制造机能够进行小规模快速生产，但所制部件的结构完整性不如以更传统手段制造的部件。将几台外骨骼损坏至约 [damage_percent]% 完整度后扫描它们，以帮助我们确定护甲在应力下如何失效。"

/datum/experiment/scanning/random/mecha_damage_scan/final_contributing_index_checks(datum/component/experiment_handler/experiment_handler, atom/target, typepath)
	var/found_percent = round((target.get_integrity() / target.max_integrity) * 100)
	return ..() && ISINRANGE(found_percent, damage_percent - 5, damage_percent + 5)

/datum/experiment/scanning/random/mecha_equipped_scan/final_contributing_index_checks(datum/component/experiment_handler/experiment_handler, atom/target, typepath)
	var/obj/vehicle/sealed/mecha/stompy = target
	if(!istype(stompy))
		return FALSE //Not a mech
	if(!HAS_TRAIT(stompy,TRAIT_MECHA_CREATED_NORMALLY))
		experiment_handler.announce_message("被扫描的机甲并非船员制造。在这里没什么可学的。")
		return FALSE //Not hand-crafted
	if(!(stompy.equip_by_category[MECHA_L_ARM] && stompy.equip_by_category[MECHA_R_ARM]))
		experiment_handler.announce_message("被扫描的机甲臂部缺少装备，无法继续进行该实验。")
		return FALSE //Both arms need be filled
	return ..()
