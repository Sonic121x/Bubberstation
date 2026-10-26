//copy pasta of the space piano, don't hurt me -Pete
/obj/item/instrument
	name = "通用乐器"
	force = 10
	max_integrity = 100
	resistance_flags = FLAMMABLE
	icon = 'icons/obj/art/musician.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/instruments_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/instruments_righthand.dmi'
	abstract_type = /obj/item/instrument
	/// Our song datum.
	var/datum/song/handheld/song
	/// Our allowed list of instrument ids. This is nulled on initialize.
	var/list/allowed_instrument_ids
	/// How far away our song datum can be heard.
	var/instrument_range = 15

/obj/item/instrument/Initialize(mapload)
	. = ..()
	song = new(src, allowed_instrument_ids, instrument_range)
	allowed_instrument_ids = null //We don't need this clogging memory after its used.

/obj/item/instrument/Destroy()
	QDEL_NULL(song)
	return ..()

/obj/item/instrument/proc/can_play(atom/music_player)
	if(!ismob(music_player))
		return FALSE
	var/mob/user = music_player
	if(user.incapacitated)
		return FALSE
	if(!Adjacent(user))
		return FALSE
	return TRUE

/obj/item/instrument/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 开始演奏《忧郁的星期天》！看上去是想自杀！"))
	return BRUTELOSS

/obj/item/instrument/ui_interact(mob/user, datum/tgui/ui)
	return song.ui_interact(user)

/obj/item/instrument/violin
	name = "太空小提琴"
	desc = "一件木制乐器，有四根琴弦和一把琴弓。“魔鬼降临太空，想找一名助理来捣乱。”"
	icon_state = "violin"
	inhand_icon_state = "violin"
	hitsound = SFX_SWING_HIT
	allowed_instrument_ids = "violin"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 4, /datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/item/instrument/violin/golden
	name = "黄金小提琴"
	desc = "一件黄金乐器，有四根琴弦和一把琴弓。“魔鬼降临太空，想找一名助理来捣乱。”"
	icon_state = "golden_violin"
	inhand_icon_state = "golden_violin"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 4, /datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/item/instrument/banjo
	name = "班卓琴"
	desc = "一把“穆拉”牌班卓琴。基本上就是个带琴颈和琴弦的鼓。"
	icon_state = "banjo"
	inhand_icon_state = "banjo"
	attack_verb_continuous = list("弹奏着", "拨着弦", "敲打着", "拍打着")
	attack_verb_simple = list("弹奏", "拨弦", "敲打", "拍打")
	hitsound = 'sound/items/weapons/banjoslap.ogg'
	allowed_instrument_ids = "banjo"

/obj/item/instrument/guitar
	name = "吉他"
	desc = "木制琴身，配青铜琴弦。"
	icon_state = "guitar"
	inhand_icon_state = "guitar"
	attack_verb_continuous = list("弹着金属乐", "深情献曲", "猛砸", "重击")
	attack_verb_simple = list("弹金属乐", "献曲", "猛砸", "重击")
	hitsound = 'sound/items/weapons/stringsmash.ogg'
	allowed_instrument_ids = list("guitar","csteelgt","cnylongt", "ccleangt", "cmutedgt")

/obj/item/instrument/eguitar
	name = "电吉他"
	desc = "满足你一切疯狂速弹的需求。"
	icon_state = "eguitar"
	inhand_icon_state = "eguitar"
	force = 12
	attack_verb_continuous = list("弹着金属乐", "狂飙速弹", "猛砸", "重击")
	attack_verb_simple = list("弹金属乐", "速弹", "猛砸", "重击")
	hitsound = 'sound/items/weapons/stringsmash.ogg'
	allowed_instrument_ids = "eguitar"

/obj/item/instrument/glockenspiel
	name = "钟琴"
	desc = "光滑的金属琴条，非常适合任何行进乐队。"
	icon_state = "glockenspiel"
	allowed_instrument_ids = list("glockenspiel","crvibr", "sgmmbox", "r3celeste")
	inhand_icon_state = "glockenspiel"

/obj/item/instrument/accordion
	name = "手风琴"
	desc = "不附赠潘潘。"
	icon_state = "accordion"
	allowed_instrument_ids = list("crack", "crtango", "accordion")
	inhand_icon_state = "accordion"

/obj/item/instrument/trumpet
	name = "小号"
	desc = "用于宣告国王的驾临！"
	icon_state = "trumpet"
	allowed_instrument_ids = "crtrumpet"
	inhand_icon_state = "trumpet"

/obj/item/instrument/trumpet/spectral
	name = "幽灵小号"
	desc = "马上要开始闹鬼了！"
	icon_state = "spectral_trumpet"
	inhand_icon_state = "spectral_trumpet"
	force = 0
	attack_verb_continuous = list("吹奏着", "即兴爵士", "吹着号", "哀悼", "嘟嘟", "惊吓")
	attack_verb_simple = list("吹奏", "即兴爵士", "吹号", "哀悼", "嘟嘟", "惊吓")
	var/single_use = FALSE

/obj/item/instrument/trumpet/spectral/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/spooky, too_spooky = !single_use, single_use = single_use)

/obj/item/instrument/trumpet/spectral/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	playsound(src, 'sound/runtime/instruments/trombone/En4.mid', 1000, 1, -1)
	return ..()

/obj/item/instrument/trumpet/spectral/one_doot
	single_use = TRUE

/obj/item/instrument/saxophone
	name = "萨克斯管"
	desc = "这抚慰人心的音色必定能让你的听众泪流满面。"
	icon_state = "saxophone"
	allowed_instrument_ids = "saxophone"
	inhand_icon_state = "saxophone"

/obj/item/instrument/saxophone/spectral
	name = "幽灵萨克斯管"
	desc = "这阴森的音色必定能让凡人化为一堆白骨。"
	icon_state = "saxophone"
	inhand_icon_state = "saxophone"
	force = 0
	attack_verb_continuous = list("吹奏着", "即兴爵士", "吹着萨克斯", "哀悼", "嘟嘟", "惊吓")
	attack_verb_simple = list("吹奏", "即兴爵士", "吹萨克斯", "哀悼", "嘟嘟", "惊吓")
	var/single_use = FALSE

/obj/item/instrument/saxophone/spectral/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/spooky, too_spooky = !single_use, single_use = single_use)

/obj/item/instrument/saxophone/spectral/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	playsound(src, 'sound/runtime/instruments/trombone/En4.mid', 1000, 1, -1)
	return ..()

/obj/item/instrument/saxophone/spectral/one_doot
	single_use = TRUE

/obj/item/instrument/trombone
	name = "长号"
	desc = "台球桌怎么可能是它的对手？"
	icon_state = "trombone"
	allowed_instrument_ids = list("crtrombone", "crbrass", "trombone")
	inhand_icon_state = "trombone"

/obj/item/instrument/trombone/spectral
	name = "幽灵长号"
	desc = "骷髅最钟爱的乐器。请直接对准凡人使用。"
	icon_state = "trombone"
	inhand_icon_state = "trombone"
	force = 0
	attack_verb_continuous = list("吹奏着", "即兴爵士", "吹着长号", "哀悼", "嘟嘟", "惊吓")
	attack_verb_simple = list("吹奏", "即兴爵士", "吹长号", "哀悼", "嘟嘟", "惊吓")
	var/single_use = FALSE

/obj/item/instrument/trombone/spectral/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/spooky, too_spooky = !single_use, single_use = single_use)

/obj/item/instrument/trombone/spectral/one_doot
	single_use = TRUE

/obj/item/instrument/trombone/spectral/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	playsound(src, 'sound/runtime/instruments/trombone/Cn4.mid', 1000, 1, -1)
	return ..()

/obj/item/instrument/recorder
	name = "竖笛"
	desc = "就像学校里那样，连吹奏水平也一模一样。"
	force = 5
	icon_state = "recorder"
	allowed_instrument_ids = "recorder"
	inhand_icon_state = "recorder"

/obj/item/instrument/harmonica
	name = "口琴"
	desc = "专治严重的太空忧郁症。"
	icon_state = "harmonica"
	allowed_instrument_ids = list("crharmony", "harmonica")
	inhand_icon_state = "harmonica"
	slot_flags = ITEM_SLOT_MASK
	force = 5
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/instrument)
	action_slots = ALL

/obj/item/instrument/harmonica/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if(!(slot & slot_flags))
		return
	RegisterSignal(user, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/obj/item/instrument/harmonica/dropped(mob/user, silent = FALSE)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_SAY)

/obj/item/instrument/harmonica/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER
	if(!song.playing)
		return
	if(!ismob(loc))
		CRASH("[src] was still registered to listen in on [source] but was not found to be on their mob.")
	to_chat(loc, span_warning("你停下口琴演奏，以便开口说话……"))
	song.playing = FALSE

/datum/action/item_action/instrument
	name = "使用乐器"
	desc = "使用指定的乐器"

/datum/action/item_action/instrument/do_effect(trigger_flags)
	if(!istype(target, /obj/item/instrument))
		return FALSE
	var/obj/item/instrument/instrument = target
	instrument.interact(usr)
	return TRUE

/obj/item/instrument/bikehorn
	name = "镀金自行车喇叭"
	desc = "一只装饰精美的自行车喇叭，能吹出各种音调。"
	icon_state = "bike_horn"
	inhand_icon_state = "bike_horn"
	lefthand_file = 'icons/mob/inhands/equipment/horns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/horns_righthand.dmi'
	allowed_instrument_ids = list("bikehorn", "honk")
	attack_verb_continuous = list("优美地叭叭作响")
	attack_verb_simple = list("优美地叭叭作响")
	w_class = WEIGHT_CLASS_TINY
	force = 0
	throw_speed = 3
	throw_range = 15
	hitsound = 'sound/items/bikehorn.ogg'

/obj/item/instrument/musicalmoth
	name = "音乐蛾"
	desc = "尽管颇受欢迎，这款争议十足的音乐玩具最终还是被禁售了，因为它不道德地采样了蛾子痛苦尖叫的声音。"
	icon_state = "mothsician"
	allowed_instrument_ids = "mothscream"
	attack_verb_continuous = list("扇动着翅膀拍", "扑扇着拍")
	attack_verb_simple = list("扇翅拍", "扑扇着拍")
	w_class = WEIGHT_CLASS_TINY
	force = 0
	hitsound = 'sound/mobs/humanoids/moth/scream_moth.ogg'
	custom_price = PAYCHECK_COMMAND * 2.37
	custom_premium_price = PAYCHECK_COMMAND * 2.37
