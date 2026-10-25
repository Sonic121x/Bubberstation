// Mayhem in a bottle

/obj/item/mayhem
	name = "狂乱之瓶"
	desc = "一瓶注入了魔法的血液，其气味会让附近任何人陷入嗜杀狂乱。"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "vial"

/obj/item/mayhem/attack_self(mob/user)
	if(tgui_alert(user, "打碎瓶子会让附近的船员陷入嗜杀狂乱。请确保你知道自己在做什么……", "打碎瓶子？", list("打碎它！", "不要！")) != "打碎它！")
		return

	if(QDELETED(src) || !user.is_holding(src) || user.incapacitated)
		return

	for(var/mob/living/carbon/human/target in range(7, user))
		target.apply_status_effect(/datum/status_effect/mayhem)

	to_chat(user, span_notice("你打碎了瓶子！"))
	playsound(user.loc, 'sound/effects/glass/glassbr1.ogg', 100, TRUE)
	message_admins(span_adminnotice("[ADMIN_LOOKUPFLW(user)] 激活了狂乱之瓶！"))
	user.log_message("激活了狂乱之瓶", LOG_ATTACK)
	qdel(src)

// H.E.C.K. Suit

/obj/item/clothing/suit/hooded/hostile_environment
	name = "H.E.C.K. 防护服"
	desc = "敌对环境交叉动能防护服：专为抵御熔岩地带的多种危险而设计。可惜对它的上一位主人来说还不够。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/hostile_environment"
	post_init_icon_state = "hostile_env"
	hoodtype = /obj/item/clothing/head/hooded/hostile_environment
	armor_type = /datum/armor/hooded_hostile_environment
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	clothing_flags = THICKMATERIAL|HEADINTERNALS
	resistance_flags = FIRE_PROOF|LAVA_PROOF|ACID_PROOF
	transparent_protection = HIDESUITSTORAGE|HIDEJUMPSUIT
	allowed = null
	greyscale_colors = "#4d4d4d#808080"
	greyscale_config = /datum/greyscale_config/heck_suit
	greyscale_config_worn = /datum/greyscale_config/heck_suit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/heck_suit/worn/digi //SKYRAT EDIT ADDITION - DigiGreyscale
	flags_1 = IS_PLAYER_COLORABLE_1

/datum/armor/hooded_hostile_environment
	melee = 70
	bullet = 40
	laser = 10
	energy = 20
	bomb = 50
	fire = 100
	acid = 100

/obj/item/clothing/suit/hooded/hostile_environment/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/radiation_protected_clothing)
	AddElement(/datum/element/gags_recolorable)
	allowed = GLOB.mining_suit_allowed

/obj/item/clothing/suit/hooded/hostile_environment/process(seconds_per_tick)
	var/mob/living/carbon/wearer = loc
	if(istype(wearer) && SPT_PROB(1, seconds_per_tick)) //cursed by bubblegum
		if(prob(7.5))
			wearer.cause_hallucination(/datum/hallucination/oh_yeah, "H.E.C.K. 防护服", haunt_them = TRUE)
		else
			if(HAS_TRAIT(wearer, TRAIT_ANOSMIA)) //Anosmia quirk holder cannot fell any smell
				to_chat(wearer, span_warning("[pick("你听到微弱的低语。","你感到燥热。","你听到远处传来一声咆哮。")]"))
			else
				to_chat(wearer, span_warning("[pick("你听到微弱的低语。","你闻到灰烬的气味。","你感到燥热。","你听到远处传来一声咆哮。")]"))

/obj/item/clothing/head/hooded/hostile_environment
	name = "H.E.C.K. 头盔"
	desc = "敌对环境交叉动能头盔：专为抵御熔岩地带的多种危险而设计。可惜对它的上一位主人来说还不够。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/hooded/hostile_environment"
	post_init_icon_state = "hostile_env"
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	armor_type = /datum/armor/hooded_hostile_environment
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	clothing_flags = SNUG_FIT|THICKMATERIAL
	resistance_flags = FIRE_PROOF|LAVA_PROOF|ACID_PROOF
	flags_inv = HIDEMASK|HIDEEARS|HIDEFACE|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSMOUTH
	actions_types = list()
	greyscale_colors = "#4d4d4d#808080#ff3300"
	greyscale_config = /datum/greyscale_config/heck_helmet
	greyscale_config_worn = /datum/greyscale_config/heck_helmet/worn
	greyscale_config_worn_digi = /datum/greyscale_config/heck_helmet/worn/snouted //SKYRAT EDIT ADDITION - MuzzledGreyscale (Why does this use worn_digi)
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/hooded/hostile_environment/Initialize(mapload)
	. = ..()
	update_appearance()
	AddComponent(/datum/component/butchering/wearable, \
	speed = 0.5 SECONDS, \
	effectiveness = 150, \
	bonus_modifier = 0, \
	butcher_sound = null, \
	disabled = null, \
	can_be_blunt = TRUE, \
	butcher_callback = CALLBACK(src, PROC_REF(consume)), \
	)
	AddElement(/datum/element/radiation_protected_clothing)
	AddElement(/datum/element/gags_recolorable)

/obj/item/clothing/head/hooded/hostile_environment/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	to_chat(user, span_notice("你感到一股嗜血冲动。现在你可以徒手屠宰尸体了。"))

/obj/item/clothing/head/hooded/hostile_environment/dropped(mob/user, silent = FALSE)
	. = ..()
	to_chat(user, span_notice("你的嗜血冲动消失了。"))

/obj/item/clothing/head/hooded/hostile_environment/proc/consume(mob/living/user, mob/living/butchered)
	if(butchered.mob_biotypes & (MOB_ROBOTIC | MOB_SPIRIT))
		return
	var/health_consumed = butchered.maxHealth * 0.1
	user.heal_ordered_damage(health_consumed, list(BRUTE, BURN, TOX))
	to_chat(user, span_notice("你从 [butchered] 的尸骸中获得了治疗。"))
	var/datum/client_colour/color_effect = user.add_client_colour(/datum/client_colour/bloodlust, HELMET_TRAIT)
	QDEL_IN(color_effect, 1 SECONDS)

