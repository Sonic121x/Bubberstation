// Add 'walkies' as valid input
/datum/pet_command/follow/dog
	activate_on_befriend = TRUE
	speech_commands = list("heel", "follow", "walkies")

// Add 'good dog' as valid input
/datum/pet_command/good_boy/dog
	speech_commands = list("good dog")

// Use dog-specific melee attack (paws harmlessly when BB_DOG_HARASS_HARM is false)
/datum/pet_command/attack/dog
	attack_subtree = /datum/bt_node/subtree/pet_command/attack/dog

/datum/pet_command/attack/dog/set_command_active(mob/living/parent, mob/living/commander)
	. = ..()
	parent.ai_controller.set_blackboard_key(BB_DOG_HARASS_HARM, TRUE)

//Dogs.

/mob/living/basic/pet/dog
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻拍"
	response_disarm_simple = "轻拍"
	response_harm_continuous = "踢"
	response_harm_simple = "踢"
	speak_emote = list("汪汪叫", "吠叫")
	faction = list(FACTION_NEUTRAL)
	ai_controller = /datum/ai_controller/basic_controller/dog
	// The dog attack pet command can raise melee attack above 0
	attack_verb_continuous = "咬"
	attack_verb_simple = "咬"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	melee_attack_cooldown = 0.8 SECONDS
	melee_damage_lower = 5
	melee_damage_upper = 10
	/// Instructions you can give to dogs
	var/static/list/pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/free,
		/datum/pet_command/move,
		/datum/pet_command/good_boy/dog,
		/datum/pet_command/follow/dog,
		/datum/pet_command/perform_trick_sequence,
		/datum/pet_command/attack/dog,
		/datum/pet_command/fetch,
		/datum/pet_command/play_dead,
	)
	///icon state of the collar we can wear
	var/collar_icon_state
	///icon state of our cult icon
	var/cult_icon_state

/datum/emote/dog
	abstract_type = /datum/emote/dog
	mob_type_allowed_typecache = /mob/living/basic/pet/dog
	mob_type_blacklist_typecache = list()

/datum/emote/dog/woof
	key = "woof"
	key_third_person = "woof"
	message = "开心地汪汪叫！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/mob/living/basic/pet/dog/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cultist_pet, pet_cult_icon_state = cult_icon_state)
	AddElement(/datum/element/wears_collar, collar_icon_state = collar_icon_state)
	ADD_TRAIT(src, TRAIT_WOUND_LICKER, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_COLORBLIND, INNATE_TRAIT)
	AddElement(/datum/element/pet_bonus, "woof")
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW)
	AddElement(/datum/element/unfriend_attacker, untamed_reaction = "%SOURCE% 用一种被背叛的眼神盯着 %TARGET%。")
	AddElement(/datum/element/can_be_held)
	var/static/list/food_types = list(
		/obj/item/food/meat/slab/human/mutant/skeleton,
		/obj/item/stack/sheet/bone,
	)
	AddComponent(/datum/component/tameable, food_types = food_types, tame_chance = 30, bonus_tame_chance = 15, unique = FALSE)
	AddComponent(/datum/component/obeys_commands, pet_commands)
	var/dog_area = get_area(src)
	for(var/obj/structure/bed/dogbed/dog_bed in dog_area)
		if(dog_bed.update_owner(src)) //No muscling in on my turf you fucking parrot
			break

///Updates dog speech and emotes
/mob/living/basic/pet/dog/proc/update_dog_speech(list/speech_data)
	speech_data[BB_EMOTE_SAY] = string_list(list("汪汪！", "汪！", "吠！", "嗷呜呜呜"))
	speech_data[BB_EMOTE_HEAR] = string_list(list("汪汪叫！", "吠叫！", "汪汪地叫。","喘着气。"))
	speech_data[BB_EMOTE_SEE] = string_list(list("摇了摇头。", "追着自己的尾巴。","打了个哆嗦。"))


/// Populates BB_BASIC_MOB_SPEAK_LINES with the dog's current speech data for BT random speech.
/// Subtypes override this to apply fashion accessories or variant speech.
/mob/living/basic/pet/dog/proc/update_dog_speak_blackboard(datum/ai_controller/controller)
	var/list/speech_data = list()
	speech_data[BB_EMOTE_SAY] = list("汪汪！", "汪！", "吠！", "嗷呜呜呜")
	speech_data[BB_EMOTE_HEAR] = list("汪汪叫！", "吠叫！", "汪汪地叫。", "喘着气。")
	speech_data[BB_EMOTE_SEE] = list("摇了摇头。", "追着自己的尾巴。", "打了个哆嗦。")
	speech_data[BB_SPEAK_CHANCE] = 1
	controller.override_blackboard_key(BB_BASIC_MOB_SPEAK_LINES, speech_data)

///Proc to run on a successful taming attempt
/mob/living/basic/pet/dog/tamed(mob/living/tamer, atom/food)
	. = ..()
	visible_message(span_notice("[src] 友好地舔了舔 [tamer]！"))

/// A dog bone fully heals a dog, and befriends it if it's not your friend.
/obj/item/dog_bone
	name = "超大号狗骨头"
	desc = "一根美味的股骨，里面满是多汁的骨髓，送给你最好的朋友再合适不过。"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "skeletonmeat"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 4)
	force = 3
	throwforce = 5
	attack_verb_continuous = list("敲打", "猛砸", "连击", "重击", "拍击")
	attack_verb_simple = list("敲打", "猛砸", "连击", "重击", "拍击")

/obj/item/dog_bone/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	if (!isdog(target) || user.combat_mode)
		return ..()
	var/mob/living/basic/pet/dog/dog_target = target
	if (IS_UNCONSCIOUS_OR_CRIT(dog_target))
		return ..()
	dog_target.emote("spin")
	dog_target.fully_heal()
	if (dog_target.befriend(user))
		dog_target.tamed(user)
	new /obj/effect/temp_visual/heart(target.loc)
	qdel(src)
	return TRUE
