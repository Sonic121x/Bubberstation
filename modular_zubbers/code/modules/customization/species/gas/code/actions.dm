/datum/action/cooldown/spell/toggle_eye_shields
	name = "切换护眼罩"
	desc = "切换你的防护眼罩。"
	button_icon = 'modular_zubbers/icons/actions/gas.dmi'
	button_icon_state = "gas_eyeshield"
	spell_requirements = null

/datum/action/cooldown/spell/toggle_eye_shields/cast(atom/cast_on)
	. = ..()
	var/obj/item/organ/eyes/serpentid/eyes = owner?.get_organ_slot(ORGAN_SLOT_EYES)
	var/mob/living/carbon/human/human_owner = owner
	if(!eyes)
		return
	if(!eyes.eyes_shielded)
		to_chat(owner, span_notice("近乎不透明的镜片滑下来遮住你的双眼。"))
		eyes.eyes_shielded = TRUE
		eyes.flash_protect = FLASH_PROTECTION_WELDER_SENSITIVE
		owner.overlay_fullscreen("eyeshield", /atom/movable/screen/fullscreen/blind)
		human_owner.set_eye_color("#AAAAAA")
		human_owner.dna.update_ui_block((/datum/dna_block/identity/eye_colors))
		human_owner.update_body()
	else
		to_chat(owner, span_notice("你的防护镜片缩了回去。"))
		eyes.eyes_shielded = FALSE
		eyes.flash_protect = FLASH_PROTECTION_HYPER_SENSITIVE
		owner.clear_fullscreen("eyeshield")
		human_owner.set_eye_color(sanitize_hexcolor(human_owner.client?.prefs?.read_preference(/datum/preference/color/eye_color)))
		human_owner.dna.update_ui_block(/datum/dna_block/identity/eye_colors)
		human_owner.update_body()

/datum/action/cooldown/spell/toggle_active_camo
	name = "切换主动迷彩"
	desc = "切换你的主动迷彩能力，使自己变得更加半透明。"
	button_icon = 'modular_zubbers/icons/actions/gas.dmi'
	button_icon_state = "gas-cloak-0"
	spell_requirements = null

/datum/action/cooldown/spell/toggle_active_camo/proc/update_button_state(new_state)
	button_icon_state = new_state
	owner.update_action_buttons()

/datum/action/cooldown/spell/toggle_active_camo/cast(atom/target)
	. = ..()
	var/obj/item/organ/heart/serpentid/heart = owner?.get_organ_slot(ORGAN_SLOT_HEART)
	heart.toggle_camo(target)
	if(heart.camouflaged)
		update_button_state("gas-cloak-1")
	else
		update_button_state("gas-cloak-0")

/datum/action/cooldown/spell/toggle_threat_display
	name = "切换威吓展示"
	desc = "切换你的威吓展示，让敌人知道你已准备好开战！"
	button_icon = 'modular_zubbers/icons/actions/gas.dmi'
	button_icon_state = "gas-threat"
	spell_requirements = null

/datum/species/gas
	var/displaying_threat = FALSE
	var/image/threat_overlay

/datum/action/cooldown/spell/toggle_threat_display/cast(atom/target)
	. = ..()
	if(!isgas(owner))
		return
	var/mob/living/carbon/human/snake_owner = owner
	var/datum/species/gas/gas_species = snake_owner.dna.species
	if(owner.incapacitated)
		to_chat(owner, span_warning("以你当前的状态，无法进行威吓展示。"))
		return
	if(gas_species.displaying_threat == FALSE)
		gas_species.threat_overlay = image('modular_skyrat/modules/bodyparts/icons/serpentid_parts_greyscale.dmi', "threat", MOB_LAYER)
		var/message = tgui_alert(owner, "你想展示一条吓人的信息吗？", "吓吓人", list("是", "否", "取消"))
		if(message == "取消")
			return
		else if(message == "是")
			owner.visible_message(span_warning("\The [owner] 的皮肤转为深红色，深色的人字形纹路如催眠般向下延伸。 \
				[owner] 挺直身子发起攻击，尖锐的棘刺瞄准那些威胁自己的家伙，利爪破空呼啸而过。"))
		playsound(owner.loc, 'modular_skyrat/modules/emotes/sound/emotes/angryserpentid.ogg', 60, 0)
		gas_species.displaying_threat = TRUE
		snake_owner.add_overlay(gas_species.threat_overlay)
	else
		snake_owner.cut_overlay(gas_species.threat_overlay)
		gas_species.displaying_threat = FALSE
