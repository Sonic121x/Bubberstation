/proc/chinese_batch_four_admin_action_storage(value, action_type)
	if(ispath(action_type, /datum/action/antag_info))
		if(value == "打开特殊身份信息")
			return "Open Special Role Information"
		if(findtext(value, "打开") == 1 && copytext_char(value, -2) == "信息")
			return "Open [chinese_antag_storage_name(copytext_char(value, 3, -2))] Information"
	var/static/list/legacy_names
	if(!legacy_names)
		legacy_names = list(
			/datum/action/spawn_light = list("生成灯光" = "Spawn Light"),
			/datum/action/innate/path_debug/jps = list("JPS 测试" = "JPS Test"),
			/datum/action/innate/path_debug/sssp = list("路径图测试" = "Pathmap Test"),
			/datum/action/innate/teleport_in = list("传送至" = "Send To"),
			/datum/action/innate/teleport_out = list("回收" = "Retrieve"),
			/datum/action/innate/teleport_self = list("传送自己" = "Send Self"),
			/datum/action/innate/vest_mode_swap = list("切换背心模式" = "Switch Vest Mode"),
			/datum/action/innate/vest_disguise_swap = list("切换背心伪装" = "Switch Vest Disguise"),
			/datum/action/innate/set_droppoint = list("设置实验释放点" = "Set Experiment Release Point"),
			/datum/action/innate/blobpop = list("爆裂" = "Pop"),
			/datum/action/cooldown/mob_cooldown/blood_worm/cocoon/hatchling = list("成熟" = "Mature"),
			/datum/action/cooldown/mob_cooldown/blood_worm/cocoon/juvenile = list("成熟" = "Mature"),
			/datum/action/cooldown/mob_cooldown/blood_worm/cocoon/adult = list("繁殖" = "Reproduce"),
			/datum/action/cooldown/mob_cooldown/blood_worm/inject = list("注入血液" = "Inject Blood"),
			/datum/action/cooldown/mob_cooldown/blood_worm/invade = list("侵入尸体" = "Invade Corpse"),
			/datum/action/cooldown/mob_cooldown/blood_worm/eject = list("离开宿主" = "Leave Host"),
			/datum/action/cooldown/mob_cooldown/blood_worm/leech = list("吸血" = "Leech Blood"),
			/datum/action/cooldown/mob_cooldown/blood_worm/revive = list("复活宿主" = "Revive Host"),
			/datum/action/cooldown/mob_cooldown/blood_worm/spit = list("喷吐血液" = "Spit Blood"),
			/datum/action/cellular_emporium = list("细胞商场" = "Cellular Emporium"),
			/datum/action/changeling = list("原型针刺 - 调试按钮，请对此发起管理员求助" = "Prototype Sting - Debug button, ahelp this"),
			/datum/action/changeling/absorb_dna = list("吸收 DNA" = "Absorb DNA"),
			/datum/action/innate/exit_hivemind = list("退出蜂巢意识" = "Exit Hivemind"),
			/datum/action/changeling/eject_from_hivemind = list("逐出蜂巢意识" = "Eject from Hivemind"),
			/datum/action/changeling/adrenaline = list("基因刺激" = "Gene Stim"),
			/datum/action/changeling/augmented_eyesight = list("强化视觉" = "Augmented Eyesight"),
			/datum/action/changeling/biodegrade = list("生物降解" = "Biodegrade"),
			/datum/action/changeling/chameleon_skin = list("变色龙皮肤" = "Chameleon Skin"),
			/datum/action/changeling/darkness_adaptation = list("黑暗适应" = "Darkness Adaptation"),
			/datum/action/changeling/defib_grasp = list("除颤器之握" = "Defibrillator Grasp"),
			/datum/action/changeling/digitalcamo = list("数字伪装" = "Digital Camouflage"),
			/datum/action/changeling_expel_worm = list("驱除血虫" = "Expel Worm"),
		)
	for(var/legacy_type in legacy_names)
		if(ispath(action_type, legacy_type))
			var/list/type_names = legacy_names[legacy_type]
			if(type_names[value])
				return type_names[value]
	return value
