/obj/item/autopsy_scanner
	name = "尸检扫描仪"
	desc = "用于在手术中提取尸体信息。还可像高级健康分析仪一样扫描尸体的健康状况！"
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "autopsy_scanner"
	inhand_icon_state = "autopsy_scanner"
	worn_icon_state = "autopsy_scanner"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = CRUEL_IMPLEMENT
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	custom_price = PAYCHECK_COMMAND
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP

/obj/item/autopsy_scanner/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	if(!user.can_read(src) || user.is_blind())
		return ITEM_INTERACT_BLOCKING

	var/mob/living/scanned = interacting_with

	if(!IS_DEAD_OR_FAKING(scanned)) // good job, you found a loophole
		to_chat(user, span_deadsay("[icon2html(src, user)] 错误！无法扫描活着的尸体。请使用健康分析仪，或终止患者生命。"))
		return ITEM_INTERACT_BLOCKING

	. = ITEM_INTERACT_SUCCESS

	// Clumsiness/brain damage check
	if ((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_DUMB)) && prob(50))
		user.visible_message(span_warning("[user]在分析地板的生命体征！"), \
							span_notice("你傻乎乎地试图分析地板的生命体征！"))
		to_chat(user, "[span_info("地板的分析结果：\n\t整体状况：<b>健康</b>")]\
				\n[span_info("图例：<font color='#00cccc'>窒息</font>/<font color='#00cc66'>毒素</font>/<font color='#ffcc33'>烧伤</font>/<font color='#ff3333'>物理</font>")]\
				\n[span_info("\t损伤明细：<font color='#66cccc'>0</font>-<font color='#00cc66'>0</font>-<font color='#ff9933'>0</font>-<font color='#ff3333'>0</font>")]\
				\n[span_info("体温：???")]")
		return

	user.visible_message(span_notice("[user]扫描了[scanned]的尸体。"))
	to_chat(user, span_deadsay("[icon2html(src, user)] 正在分析尸体。"))

	healthscan(user, scanned, scanpower = SCANPOWER_ADVANCED)

	add_fingerprint(user)

/obj/item/autopsy_scanner/proc/scan_cadaver(mob/living/carbon/human/user, mob/living/carbon/scanned)
	if(scanned.stat != DEAD)
		return

	var/obj/item/paper/autopsy_report = new(get_turf(src))
	autopsy_report.color = "#99ccff"
	autopsy_report.name = "[scanned]的尸检报告 - [server_timestamp(format = "hh:mm", ic_time = TRUE)]"
	var/final_report_text = "<center><b>尸检报告</br>\
		尸检时间：[UNDERLINED_HTML_TEXT("[server_timestamp(format = "hh:mm", ic_time = TRUE)]", "当班时间：[round_timestamp(format = "hh:mm")]")]</b></center>"

	//A lot of this is extremely similar to /proc/healthscan() - but with different formatting, no color, and some added/removed info
	//Does not list quirks/exhaustion/how to repair wounds
	//DOES list wound sources/
	var/list/autopsy_information = list()
	autopsy_information += "验尸人员 - [user.name]<hr>"

	autopsy_information += "<b>[scanned.name]</b>的分析结果：</br></br>"
	autopsy_information += "死亡时间 - <b>[scanned.station_timestamp_timeofdeath]</b></br>"
	autopsy_information += "受检者已死亡<b>[DisplayTimeText(round(world.time - scanned.timeofdeath))]</b>。<hr>"

	var/oxy_loss = scanned.get_oxy_loss()
	var/tox_loss = scanned.get_tox_loss()
	var/fire_loss = scanned.get_fire_loss()
	var/brute_loss = scanned.get_brute_loss()
	/// "Body Data" portion of the autopsy - damage, wounds, and limbs
	var/dmgreport = "<u><b>身体数据：</b></u>\
					<table class='ml-2'>\
					<tr>\
					<td style='width:7em;'><b>损伤：</b></td>\
					<td style='width:5em;'><b>物理</b></td>\
					<td style='width:4em;'><b>烧伤</b></td>\
					<td style='width:4em;'><b>毒素</b></td>\
					<td style='width:8em;'><b>窒息</b></td>\
					</tr>"
	for(var/zone in scanned.get_all_limbs()) //Same order every time for consistency across all humans
		var/obj/item/bodypart/limb = scanned.get_bodypart(zone)
		if(isnull(limb))
			dmgreport += "<tr>"
			dmgreport += "<td><b>[capitalize(parse_zone(zone))]:</b></td>"
			dmgreport += "<td>-</td>"
			dmgreport += "<td>-</td>"
			dmgreport += "</tr>"
			dmgreport += "<tr><td colspan=6>&rdsh; 外伤：<u>肢体缺失</u></td></tr>"
			continue
		var/has_any_embeds = LAZYLEN(limb.embedded_objects) >= 1
		var/has_any_wounds = length(limb.wounds) >= 1
		dmgreport += "<tr>"
		dmgreport += "<td><b>[chinese_scanner_label(limb.name)]：</b></td>"
		dmgreport += "<td>[limb.brute_dam > 0 ? ceil(limb.brute_dam) : "0"]</td>"
		dmgreport += "<td>[limb.burn_dam > 0 ? ceil(limb.burn_dam) : "0"]</td>"
		if(zone == BODY_ZONE_CHEST) // tox/oxy is stored in the chest
			dmgreport += "<td>[tox_loss > 0 ? ceil(tox_loss) : "0"]</td>"
			dmgreport += "<td>[oxy_loss > 0 ? ceil(oxy_loss) : "0"]</td>"
		dmgreport += "</tr>"
		if(has_any_embeds)
			var/list/embedded_names = list()
			for(var/obj/item/embed as anything in limb.embedded_objects)
				embedded_names[capitalize(embed.name)] += 1
			for(var/embedded_name in embedded_names)
				var/displayed = embedded_name
				var/embedded_amt = embedded_names[embedded_name]
				if(embedded_amt > 1)
					displayed = "[embedded_amt]x [embedded_name]"
				dmgreport += "<tr><td colspan=6><i>&rdsh; 异物：[displayed]。</i></td></tr>"
		if(has_any_wounds)
			for(var/datum/wound/wound as anything in limb.wounds)
				dmgreport += "<tr><td colspan=6><i>&rdsh; 外伤：[wound.name]（[wound.severity_text()]） - 致伤原因：<u>[chinese_scanner_label(wound.wound_source)]。</u></i></td></tr>"

	dmgreport += "<tr>\
		<td><b>总计：</b></td>\
		<td><b>[ceil(brute_loss)] 物理</b></td>\
		<td><b>[ceil(fire_loss)] 烧伤</b></td>\
		<td><b>[ceil(tox_loss)] 毒素</b></td>\
		<td><b>[ceil(oxy_loss)] 窒息</b></td>\
		</tr>"
	dmgreport += "</table><hr>"
	autopsy_information += dmgreport

	// Only humanoids list organs, implants, gene stability, species and core-temp
	if(ishuman(scanned))
		var/mob/living/carbon/human/humantarget = scanned
		/// "Organ Data" portion of the autopsy - damage, functional status (or if it's missing), and implants
		var/organreport = "<u><b>器官数据：</b></u>\
				<table class='ml-2'>\
				<tr>\
				<td style='width:10em;'><b>器官：</b></td>\
				<td style='width:6em;'><b>损伤</b></td>\
				<td style='width:30em;'><b>状态</b></td>\
				</tr>"

		var/list/missing_organs = humantarget.get_missing_organs()
		for(var/sorted_slot in GLOB.organ_process_order) //Same order every time for consistency across all humans
			var/obj/item/organ/organ = humantarget.get_organ_slot(sorted_slot)
			if(isnull(organ))
				if(missing_organs[sorted_slot])
					organreport += "<tr><td><b>[chinese_scanner_label(missing_organs[sorted_slot])]：</b></td>\
						<td>-</td>\
						<td><u>缺失</u></td></tr>"
				continue
			var/status = chinese_scanner_organ_status(organ.get_status_text(scanpower = SCANPOWER_ADVANCED, add_tooltips = FALSE, colored = FALSE))
			var/appendix = chinese_scanner_organ_status(organ.get_status_appendix(scanpower = SCANPOWER_ADVANCED, add_tooltips = FALSE))
			if(!status)
				status ||= "正常" // otherwise flawless organs have no status reported by default
			organreport += "<tr>\
				<td><b>[chinese_scanner_label(organ.name)]：</b></td>\
				<td>[organ.damage > 0 ? ceil(organ.damage) : "0"]</td>\
				<td>[status]</td>\
				</tr>"
			if(appendix)
				organreport += "<tr><td colspan=4><i>&rdsh; [appendix]</i></td></tr>"
		organreport += "</table>" //<hr> comes after Cybernetics below
		autopsy_information += organreport

		var/mutant = HAS_TRAIT(humantarget, TRAIT_HULK) //Also applied by genetics infusions
		// Cybernetics
		var/list/cyberimps
		for(var/obj/item/organ/target_organ as anything in humantarget.organs)
			if(IS_ROBOTIC_ORGAN(target_organ) && !(target_organ.organ_flags & ORGAN_HIDDEN))
				LAZYADD(cyberimps, target_organ.examine_title(user))
			if(target_organ.organ_flags & ORGAN_MUTANT)
				mutant = TRUE
		if(LAZYLEN(cyberimps))
			autopsy_information += "<b>检测到义体改造：</b></br>"
			autopsy_information += "[jointext(cyberimps, "、")]</br>"

		autopsy_information += "<hr>"

		// Genetic Stability, Species, and Body Temperature
		if(humantarget.has_dna() && humantarget.dna.stability != initial(humantarget.dna.stability))
			autopsy_information += "<b>基因稳定性：</b>[humantarget.dna.stability]%。</br>"
		var/datum/species/targetspecies = humantarget.dna.species
		var/disguised = !ishumanbasic(humantarget) && istype(humantarget.head, /obj/item/clothing/head/hooded/human_head) && istype(humantarget.wear_suit, /obj/item/clothing/suit/hooded/bloated_human)
		var/species_name = "[disguised ? "\"[chinese_footprint_species_display(/datum/species/human::name)]\"" : chinese_footprint_species_display(targetspecies.name)][mutant ? "衍生突变体" : ""]"
		autopsy_information += "<b>物种：</b>[species_name]</br>"
		autopsy_information += "<b>核心体温：</b>[round(humantarget.coretemperature-T0C, 0.1)] &deg;C ([round(humantarget.coretemperature*1.8-459.67,0.1)] &deg;F)</br>"
	// (End of humanoid-only information)
	autopsy_information += "<b>体温：</b>[round(scanned.bodytemperature-T0C, 0.1)] &deg;C ([round(scanned.bodytemperature*1.8-459.67,0.1)] &deg;F)</br>"

	// Blood Info
	if(HAS_TRAIT(scanned, TRAIT_HUSK))
		autopsy_information += "受检者躯体严重损毁，原因："
		if(HAS_TRAIT_FROM(scanned, TRAIT_HUSK, CHANGELING_DRAIN))
			autopsy_information += "干瘪，通常由变形怪吸干血肉导致。</br>"
		else if(HAS_TRAIT_FROM(scanned, TRAIT_HUSK, SKELETON_TRAIT))
			autopsy_information += "血肉被剥离。</br>"
		else if(HAS_TRAIT_FROM(scanned, TRAIT_HUSK, /datum/status_effect/zombie::id))
			autopsy_information += "僵尸化。</br>"
		else if(!HAS_TRAIT_FROM(scanned, TRAIT_HUSK, BURN)) // prioritize showing unknown causes over burns
			autopsy_information += "原因不明。</br>"
		else
			autopsy_information += "严重烧伤。</br>"

	var/datum/blood_type/blood_type = scanned.get_bloodtype()
	if(blood_type)
		var/cached_blood_volume = scanned.get_blood_volume(apply_modifiers = TRUE)
		var/blood_percent = round((cached_blood_volume / BLOOD_VOLUME_NORMAL) * 100)
		var/blood_type_format
		var/level_format
		if(cached_blood_volume <= BLOOD_VOLUME_SAFE && cached_blood_volume > BLOOD_VOLUME_OKAY)
			level_format = "偏低 [blood_percent]%，[cached_blood_volume] cl"
		else if(cached_blood_volume <= BLOOD_VOLUME_OKAY)
			level_format = "<u>危急 [blood_percent]%</u>，[cached_blood_volume] cl"
		else
			level_format = "[blood_percent]%, [cached_blood_volume] cl"
		if(blood_type.get_type())
			blood_type_format = "血型：[blood_type.get_type()]"
		autopsy_information += "<b>[chinese_scanner_label(blood_type.get_blood_name())]含量：</b>[level_format]，[blood_type_format]</br>"
	var/blood_alcohol_content = scanned.get_blood_alcohol_content()
	if(blood_alcohol_content > 0)
		autopsy_information += "&rdsh; [chinese_scanner_label(blood_type?.get_blood_name() || "Blood")]酒精浓度：[blood_alcohol_content]%</br>"
	autopsy_information += "<hr>"

	autopsy_information += "<u>化学物质数据：</u></br>"
	for(var/datum/reagent/scanned_reagents as anything in scanned.reagents.reagent_list)
		if(scanned_reagents.chemical_flags & REAGENT_INVISIBLE)
			continue
		autopsy_information += "<b>[scanned_reagents.name]：</b>血液中含有[round(scanned_reagents.volume, 0.1)]单位。</br>"
		autopsy_information += "<i>&rdsh; [scanned_reagents.description]</i></br>"
	autopsy_information += "<hr>"

	autopsy_information += "<u>疾病数据：</u></br>"
	for(var/datum/disease/diseases as anything in scanned.diseases)
		autopsy_information += "<b>疾病名称：</b>\"[diseases.name]\"</br>"
		autopsy_information += "<b>传播方式：</b>[diseases.spread_text]</br>"
		if(!istype(diseases, /datum/disease/advance))
			continue
		autopsy_information += "<b>症状：</b></br>"
		var/datum/disease/advance/advanced_disease = diseases
		for(var/datum/symptom/symptom as anything in advanced_disease.symptoms)
			autopsy_information += "&rdsh; [symptom.name] - <i>[symptom.desc]</i></br>"
	autopsy_information += "<hr>"

	autopsy_information += "<b>验尸人员备注：</b>" //Bottom of the page, anything past here is player-written

	final_report_text += jointext(autopsy_information, "")
	autopsy_report.add_raw_text(final_report_text, advanced_html = TRUE)
	autopsy_report.update_appearance()
	user.put_in_hands(autopsy_report)
	user.balloon_alert(user, "报告已打印")
	return TRUE
