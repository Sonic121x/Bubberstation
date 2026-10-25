/// Plain, but durable and strong. Can destroy walls.
/mob/living/basic/guardian/standard
	guardian_type = GUARDIAN_STANDARD
	damage_coeff = list(BRUTE = 0.5, BURN = 0.5, TOX = 0.5, STAMINA = 0, OXY = 0.5)
	melee_damage_lower = 20
	melee_damage_upper = 20
	melee_attack_cooldown = 0.6 SECONDS
	wound_bonus = -5 //you can wound!
	obj_damage = 80
	environment_smash = ENVIRONMENT_SMASH_WALLS
	playstyle_string = span_holoparasite("作为<b>标准</b>型，你没有任何特殊能力，但拥有很高的伤害抗性和足以砸穿墙壁的强力攻击。")
	creator_name = "标准"
	creator_desc = "毁灭性的近战攻击与极高的伤害抗性。能砸穿脆弱的墙壁。"
	creator_icon = "standard"
	/// The text we shout when attacking.
	var/battlecry = "AT"

/mob/living/basic/guardian/standard/Initialize(mapload, datum/guardian_fluff/theme)
	. = ..()
	AddElement(/datum/element/wall_tearer, allow_reinforced = FALSE, tear_time = 1.5 SECONDS)
	var/datum/action/select_guardian_battlecry/cry = new(src)
	cry.Grant(src)

/mob/living/basic/guardian/standard/do_attack_animation(atom/attacked_atom, visual_effect_icon, used_item, no_effect)
	. = ..()
	if (!isliving(attacked_atom) && !isclosedturf(attacked_atom))
		return
	var/msg = ""
	for(var/i in 1 to 9)
		msg += battlecry
	say("[msg]!!", ignore_spam = TRUE)
	for(var/sounds in 1 to 4)
		addtimer(CALLBACK(src, PROC_REF(do_attack_sound), attacked_atom), sounds DECISECONDS, TIMER_DELETE_ME)

/// Echo our punching sounds
/mob/living/basic/guardian/standard/proc/do_attack_sound(atom/playing_from)
	if (QDELETED(playing_from))
		return
	playsound(playing_from, attack_sound, 50, TRUE, TRUE)

/// Action to change our battlecry
/datum/action/select_guardian_battlecry
	name = "选择战吼"
	desc = "更新你在每次攻击时喊出的那句超酷台词。"
	button_icon = 'icons/obj/clothing/gloves.dmi'
	button_icon_state = "boxing"
	background_icon = 'icons/hud/guardian.dmi'
	background_icon_state = "base"
	/// How long can it be? Shouldn't be too long because we repeat this a shitload of times
	var/max_length = 6

/datum/action/select_guardian_battlecry/IsAvailable(feedback)
	if (!istype(owner, /mob/living/basic/guardian/standard))
		return FALSE
	return ..()

/datum/action/select_guardian_battlecry/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if (!.)
		return
	var/mob/living/basic/guardian/standard/stand = owner
	var/input = tgui_input_text(owner, "你想把战吼设成什么？", "战吼", max_length = max_length)
	if(!input)
		return
	stand.battlecry = input
