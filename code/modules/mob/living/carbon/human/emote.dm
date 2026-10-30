/datum/emote/living/carbon/human
	mob_type_allowed_typecache = list(/mob/living/carbon/human)

/datum/emote/living/carbon/human/dap
	key = "dap"
	key_third_person = "daps"
	message = "遗憾地找不到可以击掌的人，只好跟自己击了个掌。真丢人。"
	message_param = "与 %t 击掌。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/eyebrow
	key = "eyebrow"
	message = "挑起了一侧眉毛。"

/datum/emote/living/carbon/human/glasses
	key = "glasses"
	key_third_person = "glasses"
	message = "推了推眼镜。"
	emote_type = EMOTE_VISIBLE

/datum/emote/living/carbon/human/glasses/can_run_emote(mob/user, status_check = TRUE, intentional, params)
	var/obj/eyes_slot = user.get_item_by_slot(ITEM_SLOT_EYES)
	if(istype(eyes_slot, /obj/item/clothing/glasses/regular) || istype(eyes_slot, /obj/item/clothing/glasses/sunglasses))
		return ..()
	return FALSE

/datum/emote/living/carbon/human/glasses/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/image/emote_animation = image('icons/mob/human/emote_visuals.dmi', user, "glasses")
	flick_overlay_global(emote_animation, GLOB.clients, 1.6 SECONDS)

/datum/emote/living/carbon/human/grumble
	key = "grumble"
	key_third_person = "grumbles"
	message = "咕哝起来！"
	message_mime = "无声地咕哝！"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/datum/emote/living/carbon/human/handshake
	key = "handshake"
	message = "自己跟自己握了握手。"
	message_param = "与 %t 握手。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/datum/emote/living/carbon/human/hug
	key = "hug"
	key_third_person = "hugs"
	message = "抱住了自己。"
	message_param = "拥抱 %t。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/mumble
	key = "mumble"
	key_third_person = "mumbles"
	message = "含糊地嘟囔！"
	message_mime = "无声地嘟囔！"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/datum/emote/living/carbon/human/screech // basically scream 2.0
	key = "screech"
	key_third_person = "screeches"
	message = "尖啸起来！"
	message_mime = "无声地尖啸。"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	manual_specific_emote_audio_cooldown = 10 SECONDS
	vary = FALSE

/datum/emote/living/carbon/human/screech/get_sound(mob/living/carbon/human/user)
	var/datum/emote/scream_emote = GLOB.emote_list[/datum/emote/living/scream::key][1]
	return scream_emote.get_sound(user)

/datum/emote/living/carbon/human/pale
	key = "pale"
	message = "脸色发白了片刻。"

/datum/emote/living/carbon/human/raise
	key = "raise"
	key_third_person = "raises"
	message = "举起了一只手。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/salute
	key = "salute"
	key_third_person = "salutes"
	message = "敬礼。"
	message_param = "向 %t 敬礼。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS
	sound = 'sound/mobs/humanoids/human/salute/salute.ogg'

/datum/emote/living/carbon/human/slit
	key = "slit"
	key_third_person = "slits"
	message = "用手指划过自己的脖子。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/scratch_h
	key = "scratchhead"
	message = "挠了挠头。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/thumb_up
	key = "thumbsup"
	message = "竖起了大拇指。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/thumb_down
	key = "thumbsdown"
	message = "大拇指朝下比了个手势。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/time
	key = "time"
	message = "看了看时间。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/tap
	key = "tap"
	key_third_person = "taps"
	message = "不耐烦地跺着脚。"

/datum/emote/living/carbon/human/halt
	key = "halt"
	key_third_person = "halts"
	message = "举起手掌，示意停下。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/shush
	key = "shush"
	key_third_person = "shushes"
	message = "把一根手指竖在唇边。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/listen
	key = "listen"
	key_third_person = "listens"
	message = "把手拢在耳边倾听。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/think
	key = "think"
	key_third_person = "thinks"
	message = "敲了敲脑袋，陷入思考。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/beckon
	key = "beckon"
	key_third_person = "beckons"
	message = "招手示意某人靠近。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/airquote
	key = "airquote"
	key_third_person = "airquotes"
	message = "比了个空气引号。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/crazy
	key = "crazy"
	message = "用一根手指在脑袋旁画圈。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/squint
	key = "squint"
	key_third_person = "squints"
	message = "眯起了眼睛。"

/datum/emote/living/carbon/human/rub
	key = "rub"
	key_third_person = "rubs"
	message = "摸了摸下巴。"
	can_use_flags = EMOTE_CANUSE_REQUIRE_HANDS

/datum/emote/living/carbon/human/shrug
	key = "shrug"
	key_third_person = "shrugs"
	message = "耸了耸肩。"

/datum/emote/living/carbon/human/wag
	key = "wag"
	key_third_person = "wags"
	message = "摇了摇"

/datum/emote/living/carbon/human/wag/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/organ/tail/oranges_accessory = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	//I am so sorry my son
	//We bypass helpers here cause we already have the tail
	if(oranges_accessory.wag_flags & WAG_WAGGING) //We verified the tail exists in can_run_emote()
		oranges_accessory.stop_wag(user)
	else
		oranges_accessory.start_wag(user)

/datum/emote/living/carbon/human/wag/select_message_type(mob/user, intentional)
	. = ..()
	var/obj/item/organ/tail/oranges_accessory = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(oranges_accessory.wag_flags & WAG_WAGGING)
		. = "停止摇动"
	. += "尾巴。"

/datum/emote/living/carbon/human/wag/can_run_emote(mob/user, status_check, intentional, params)
	var/obj/item/organ/tail/tail = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(tail?.wag_flags & WAG_ABLE)
		return ..()
	return FALSE

/datum/emote/living/carbon/human/wing
	key = "wing"
	key_third_person = "wings"
	message = "翅膀。"

/datum/emote/living/carbon/human/wing/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/organ/wings/wings = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
	if(isnull(wings))
		CRASH("[type] ran on a mob that has no wings!")
	if(wings.wings_open)
		wings.close_wings()
	else
		wings.open_wings()

/datum/emote/living/carbon/human/wing/select_message_type(mob/user, intentional)
	var/obj/item/organ/wings/wings = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
	var/emote_verb = wings.wings_open ? "收拢" : "展开"
	return "[emote_verb][message]"

/datum/emote/living/carbon/human/wing/can_run_emote(mob/user, status_check = TRUE, intentional, params)
	var/obj/item/organ/wings/wings = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
	if(!istype(wings) || !wings.has_open_sprite)
		return FALSE
	return ..()

/datum/emote/living/carbon/human/clear_throat
	key = "clear"
	key_third_person = "clearthroat"
	message = "清了清嗓子。"

/datum/emote/living/carbon/human/blink
	key = "blink"
	key_third_person = "blinks"
	message = "眨了眨眼。"
	sound = 'sound/mobs/humanoids/human/blink/blink.ogg'

/datum/emote/living/carbon/human/blink/can_run_emote(mob/living/carbon/human/user, status_check, intentional, params)
	if (!ishuman(user) || HAS_TRAIT(user, TRAIT_PREVENT_BLINKING) || HAS_TRAIT(user, TRAIT_NO_EYELIDS))
		return FALSE
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	if (!eyes)
		return FALSE
	return ..()

/datum/emote/living/carbon/human/blink/run_emote(mob/living/carbon/human/user, params, type_override, intentional)
	. = ..()
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	eyes.blink()

/datum/emote/living/carbon/human/blink_r
	key = "blink_r"
	name = "眨眼（快速）"
	message = "快速地眨了眨眼。"

/datum/emote/living/carbon/human/blink_r/can_run_emote(mob/living/carbon/human/user, status_check, intentional, params)
	if (!ishuman(user) || HAS_TRAIT(user, TRAIT_PREVENT_BLINKING) || HAS_TRAIT(user, TRAIT_NO_EYELIDS))
		return FALSE
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	if (!eyes)
		return FALSE
	return ..()

/datum/emote/living/carbon/human/blink_r/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	for (var/i in 1 to 3)
		addtimer(CALLBACK(eyes, TYPE_PROC_REF(/obj/item/organ/eyes, blink), 0.1 SECONDS, FALSE), i * 0.2 SECONDS)
	eyes.animate_eyelids(user)

/datum/emote/living/carbon/human/screech/roar
	key = "roar"
	key_third_person = "roars"
	message = "咆哮！"
	message_mime = "无声地表演了一声咆哮。"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/// emotes for glowy goobers
/datum/emote/living/carbon/human/glow
	key = "glow"
	key_third_person = "glows"
	message = "发出明亮的光芒！"
	emote_type = EMOTE_VISIBLE

/datum/emote/living/carbon/human/glow/can_run_emote(mob/living/carbon/human/user, status_check = TRUE, intentional, params)
	if(!user.has_status_effect(/datum/status_effect/grouped/bodypart_effect/ethereal_glow))
		return FALSE
	return ..()

/datum/emote/living/carbon/human/glow/run_emote(mob/living/carbon/human/user, params, type_override, intentional)
	. = ..()
	var/datum/status_effect/grouped/bodypart_effect/ethereal_glow/glow = user.has_status_effect(/datum/status_effect/grouped/bodypart_effect/ethereal_glow)
	glow.handle_glow_emote(1.75, 1.2)

/datum/emote/living/carbon/human/flare
	key = "flare"
	key_third_person = "flares"
	message = "骤然亮起，闪耀出刺眼的光芒！"
	emote_type = EMOTE_VISIBLE
	sound = 'sound/mobs/humanoids/ethereal/ethereal_hiss.ogg'

/datum/emote/living/carbon/human/flare/can_run_emote(mob/living/carbon/human/user, status_check = TRUE, intentional, params)
	if(!user.has_status_effect(/datum/status_effect/grouped/bodypart_effect/ethereal_glow))
		return FALSE
	return ..()

/datum/emote/living/carbon/human/flare/run_emote(mob/living/carbon/human/user, params, type_override, intentional)
	. = ..()
	var/datum/status_effect/grouped/bodypart_effect/ethereal_glow/glow = user.has_status_effect(/datum/status_effect/grouped/bodypart_effect/ethereal_glow)
	glow.handle_glow_emote(12, 6, flare = TRUE, duration = 2 SECONDS, flare_time = 10 SECONDS)

/datum/emote/living/carbon/human/flicker
	key = "flicker"
	key_third_person = "flicker"
	message = "闪烁不定。"
	emote_type = EMOTE_VISIBLE
	sound = 'sound/effects/sparks/sparks4.ogg'

/datum/emote/living/carbon/human/flicker/can_run_emote(mob/living/carbon/human/user, status_check = TRUE , intentional, params)
	if(!user.has_status_effect(/datum/status_effect/grouped/bodypart_effect/ethereal_glow))
		return FALSE
	return ..()

/datum/emote/living/carbon/human/flicker/run_emote(mob/living/carbon/human/user, params, type_override, intentional)
	. = ..()
	var/datum/status_effect/grouped/bodypart_effect/ethereal_glow/glow = user.has_status_effect(/datum/status_effect/grouped/bodypart_effect/ethereal_glow)
	glow.start_flicker()
