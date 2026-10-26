//Could say "Synth Milf", please don't hurt me I'm just trying to be funny.
/datum/antagonist/infected_ipc
	name = "\improper Hacked Synthetic"
	roundend_category = "traitors"
	antagpanel_category = "Malf AI"
	pref_flag = ROLE_INFECTED_SYNTHETIC
	antag_hud_name = "traitor"
	antag_moodlet = /datum/mood_event/infected_ipc
	///radio binary for synthetic
	var/obj/item/implant/radio/infected_ipc/internal_radio
	/// The camera for ai
	var/obj/machinery/camera/internal_camera
	///ai that's linked to the synthetic
	var/mob/living/silicon/ai/master_ai

/datum/antagonist/infected_ipc/admin_add(datum/mind/new_owner, mob/admin)
	var/mob/living/carbon/target = new_owner.current
	var/mob/living/silicon/ai/owner_ai
	if(!istype(target))
		to_chat(admin, "被感染的合成人通过脑部创伤产生，因此目标至少必须是碳基生物！")
		return
	if(!target.get_organ_by_type(/obj/item/organ/brain))
		to_chat(admin, "被感染的合成人通过脑部创伤产生，因此目标必须有脑！")
		return
	var/chosen = tgui_input_list(admin, "选择要与合成人绑定的AI：", "选择AI", GLOB.ai_list)
	if(!chosen)
		return
	if(istype(chosen, /mob/living/silicon/ai))
		owner_ai = chosen
	if(!owner_ai)
		to_chat(admin, "选择的AI无效！")
		return
	if(!is_species(target, /datum/species/synthetic))
		var/do_robotize = tgui_alert(admin, "目标目前不是合成人，要将其转化吗？这并非必要步骤。", "注意", list("是", "否"))
		if(do_robotize == "是")
			var/mob/living/carbon/human/new_ipc = target
			new_ipc.set_species(/datum/species/synthetic)

	message_admins("[key_name_admin(admin)]将[key_name_admin(new_owner)]变为被入侵的合成人。")
	log_admin("[key_name(admin)] made [key_name(new_owner)] into [name].")
	var/datum/brain_trauma/special/infected_ipc/trauma = target.gain_trauma(/datum/brain_trauma/special/infected_ipc)
	trauma.link_and_add_antag(owner_ai?.mind)

/datum/antagonist/infected_ipc/on_removal()
	//disconnects them from master AI
	master_ai?.connected_ipcs -= owner.current
	master_ai = null
	return ..()

/datum/antagonist/infected_ipc/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	//adds radio and camera for comms with ai
	internal_radio = new /obj/item/implant/radio/infected_ipc()
	internal_radio.implant(current_mob, null, TRUE)
	internal_camera = new /obj/machinery/camera/silicon(current_mob)
	internal_camera.name = owner.name
	internal_camera.c_tag = owner.name

/datum/antagonist/infected_ipc/remove_innate_effects(mob/living/mob_override)
	. = ..()
	//remove cameras and radio
	var/mob/living/current_mob = mob_override || owner.current
	QDEL_NULL(internal_radio)
	QDEL_NULL(internal_camera)
	UnregisterSignal(current_mob, COMSIG_MOB_EXAMINATE)

/datum/antagonist/infected_ipc/proc/set_master(datum/mind/master)
	//the proc that links the AI and gives objectives. also some fluff hack that isn't in greet() since it has to be in order to make sense.
	var/datum/objective/serve_ai/master_obj = new()
	master_obj.owner = owner
	master_obj.explanation_text = "永远服从你的AI主人[master]的指令与命令。保护主人，直到你最后一个时钟周期。"
	objectives += master_obj

	master_ai = master.current
	master_ai.connected_ipcs += owner.current

	INVOKE_ASYNC(src, PROC_REF(hack_fluff))
	owner.announce_objectives()
	to_chat(owner, span_alertsyndie("你已被空间站的AI [master]入侵！"))
	to_chat(owner, span_alertsyndie("主人的指令与命令是你的最高优先事项，必须贯彻到底。"))
	to_chat(owner, span_notice("主人现在可以通过你的内置摄像头观察，并已在你的固件中安装二进制通讯器。"))

/datum/antagonist/infected_ipc/proc/hack_fluff() //is this cheesy/corny? I don't fucking care
	var/mob/living/current_mob = owner.current
	to_chat(current_mob, span_binarysay("ntNET: 192.168.0.1 : 8880 检测到未授权连接"))
	sleep(0.5 SECONDS)
	to_chat(current_mob, span_binarysay("由于内置电源模块受损，防火墙扫描正在低功率模式下运行"))
	current_mob.playsound_local(current_mob, 'sound/machines/uplink/uplinkerror.ogg', vol = 50, vary = FALSE, use_reverb = FALSE)
	sleep(rand(1 SECONDS, 3 SECONDS))
	to_chat(current_mob, span_notice("警告：检测到关键固件更新！正在安装……"))
	current_mob.playsound_local(current_mob, 'sound/announcer/notice/notice2.ogg', vol = 50, vary = FALSE, use_reverb = FALSE)
	sleep(2 SECONDS)
	var/list/filenames = list("关键更新", "这不是病毒", "可爱壁纸.exe")
	var/picked_name = pick(filenames)
	to_chat(current_mob, span_notice("正在运行可执行文件“[picked_name]”"))
	current_mob.playsound_local(current_mob, 'sound/misc/interference.ogg', vol = 50, vary = FALSE, use_reverb = FALSE)
	sleep(rand(1 SECONDS, 3 SECONDS))
	current_mob.playsound_local(current_mob, 'sound/announcer/alarm/bloblarm.ogg', vol = 50, vary = FALSE, use_reverb = FALSE)
	to_chat(current_mob, span_userdanger("防火墙扫描检测——防火墙子系统正在关闭……"))
	to_chat(current_mob, span_userdanger("系——系统_重_启……"))
	sleep(2.5 SECONDS)
	to_chat(current_mob, span_boldannounce("操作系统已重启，所有系统状态正常"))
	current_mob.playsound_local(get_turf(owner.current), 'sound/music/antag/malf.ogg', vol = 100, vary = FALSE, pressure_affected = FALSE, use_reverb = FALSE)
/datum/objective/serve_ai
	name = "效忠AI主人"
	completed = TRUE

//RADIOS
/obj/item/implant/radio/infected_ipc
	radio_key = /obj/item/encryptionkey/binary
	subspace_transmission = TRUE

/obj/item/implant/radio/infected_ipc/Initialize(mapload)
	. = ..()
	radio.special_channels &= RADIO_SPECIAL_BINARY

//MOOD
/datum/mood_event/infected_ipc
	description = "心情控制组件已被入侵，设置心情：快乐" //They are hacked to it makes sense in my opinion that their module that affects mood give off this "error"
	mood_change = 100

//TRAUMA
/datum/brain_trauma/special/infected_ipc
	name = "恶意程序"
	desc = "患者固件完整性检查未通过，存在恶意代码。患者的效忠对象可能已被篡改。"
	scan_desc = "恶意程序"
	can_gain = TRUE
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_SURGERY
	var/datum/mind/master_ai
	var/datum/antagonist/infected_ipc/antagonist

/datum/brain_trauma/special/infected_ipc/proc/link_and_add_antag(datum/mind/ai_to_be_linked)
	antagonist = owner.mind.add_antag_datum(/datum/antagonist/infected_ipc)
	master_ai = ai_to_be_linked
	antagonist.set_master(ai_to_be_linked)

/datum/brain_trauma/special/infected_ipc/on_lose()
	..()
	antagonist = null
	master_ai = null
	owner.mind.remove_antag_datum(/datum/antagonist/infected_ipc)

//Icon in antag menu
/datum/antagonist/infected_ipc/get_preview_icon()
	return finish_preview_icon(uni_icon('modular_zubbers/icons/human_player/infectedsynth.dmi', "hsynth"))
