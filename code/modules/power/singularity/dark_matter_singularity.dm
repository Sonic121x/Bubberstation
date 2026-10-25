// bonus probability to chase the target granted by eating a supermatter
#define DARK_MATTER_SUPERMATTER_CHANCE_BONUS 10

/// This type of singularity cannot grow as big, but it constantly hunts down living targets.
/obj/singularity/dark_matter
	name = "暗物质奇点"
	desc = "<i>“它既美丽又骇人，\
		是一个违背一切逻辑的宇宙悖论。我无法把\
		目光从它身上移开，尽管我知道它能在转瞬\
		之间将我们全部吞噬。”\
		</i><br>——总工程师 中村天心"
	ghost_notification_message = "它来了"
	icon_state = "dark_matter_s1"
	singularity_icon_variant = "dark_matter"
	maximum_stage = STAGE_FOUR
	energy = 250
	singularity_component_type = /datum/component/singularity/bloodthirsty
	///to avoid cases of the singuloth getting blammed out of existence by the very meteor it rode in on...
	COOLDOWN_DECLARE(initial_explosion_immunity)

/obj/singularity/dark_matter/Initialize(mapload, starting_energy)
	. = ..()
	COOLDOWN_START(src, initial_explosion_immunity, 5 SECONDS)
	var/datum/component/singularity/resolved_singularity = singularity_component.resolve()
	resolved_singularity.chance_to_move_to_target = 100
	addtimer(CALLBACK(src, PROC_REF(normalize_tracking)), 20 SECONDS)

/obj/singularity/dark_matter/examine(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, initial_explosion_immunity))
		. += span_warning("受暗物质保护，[src] 似乎能在 [DisplayTimeText(COOLDOWN_TIMELEFT(src, initial_explosion_immunity))] 内免疫爆炸。")
	if(consumed_supermatter)
		. += span_userdanger("它饥渴难耐")
	else
		. += span_warning("<i>“这个奇点最令人不安的地方，在于它\
		显然会被活着的生物吸引。它似乎能感知到\
		它们的存在，并以惊人的速度朝它们移动。\
		我们观察到它吞食了我们从这一星区采集到的\
		好几份动植物标本。奇点似乎并不在乎\
		其他无生命的物体或机械，但照样会把它们吞掉。\
		我们尝试过用各种方法与它沟通，\
		却始终没有得到任何回应。”</i><br>——科研主管 休伊·诺尔")

/obj/singularity/dark_matter/ex_act(severity, target)
	if(!COOLDOWN_FINISHED(src, initial_explosion_immunity))
		return FALSE
	return ..()

/obj/singularity/dark_matter/supermatter_upgrade()
	var/datum/component/singularity/resolved_singularity = singularity_component.resolve()
	resolved_singularity.chance_to_move_to_target += DARK_MATTER_SUPERMATTER_CHANCE_BONUS
	name = "辛古洛斯大君"
	desc = "你居然用暗物质造出了一个奇点——这完全说不通——然后你还往里扔了一块超物质？你他妈疯了吗？算了，赞美辛古洛斯大人吧。"
	consumed_supermatter = TRUE

///For 20 seconds, the singularity has buffed tracking to ensure it actually makes its way to the station, normalizes after 20 seconds
/obj/singularity/dark_matter/proc/normalize_tracking()
	var/datum/component/singularity/resolved_singularity = singularity_component.resolve()
	resolved_singularity.chance_to_move_to_target = consumed_supermatter ? initial(resolved_singularity.chance_to_move_to_target) + DARK_MATTER_SUPERMATTER_CHANCE_BONUS : initial(resolved_singularity.chance_to_move_to_target)

#undef DARK_MATTER_SUPERMATTER_CHANCE_BONUS
