/////////Protean servo module////////
//Module meant to give temporary passive buffs to wearer, gives three options with diffrent effects and shared cooldowns.

/obj/item/mod/module/protean_servo
	name = "\improper 普罗蒂安 MOD 伺服模块"
	desc = "一种专为普罗蒂安 MOD 外骨骼设计的模块，能在折叠状态下新增子程序。它提供三种模式，各自会部分接管外骨骼的运动功能，用于强化穿戴者的日常移动、医疗工作或建造任务。由于算力需求很高，普罗蒂安只能在自己被别人穿戴时使用此模块。"
	icon_state = "no_baton"
	complexity = 3
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	module_type = MODULE_TOGGLE //with this the module will automaticly deactivate if it's depowered or taken off
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
//abilities that we'll be granting to Protean by activating the module
	var/datum/action/cooldown/protean_servo/movement/servo_movement = new /datum/action/cooldown/protean_servo/movement
//	var/datum/action/cooldown/protean_servo/medical/servo_medical = new /datum/action/cooldown/protean_servo/medical
	var/datum/action/cooldown/protean_servo/engineering/servo_engineering = new /datum/action/cooldown/protean_servo/engineering

/obj/item/mod/module/protean_servo/on_activation()
	. = ..()

	var/obj/item/mod/core/protean/protean_core = mod.core
	var/mob/living/carbon/human/protean_in_suit = protean_core.linked_species.owner

	if(protean_in_suit == mod.wearer) //Protean cant benefit from module they're suposed to be powering
		playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		to_chat(mod.wearer, span_warning("[src] 需要由别人穿戴，不能用在普罗蒂安自己身上。"))
		deactivate()
		return

	servo_movement.Grant(protean_in_suit)
//	servo_medical.Grant(protean_in_suit)
	servo_engineering.Grant(protean_in_suit)

/obj/item/mod/module/protean_servo/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	var/obj/item/mod/core/protean/protean_core = mod.core
	var/mob/living/carbon/human/protean_in_suit = protean_core?.linked_species.owner

	servo_movement.Remove(protean_in_suit) //All the cleanup, since module deactivates once out of power, this will remove granted abilities
//	servo_medical.Remove(protean_in_suit)
	servo_engineering.Remove(protean_in_suit)

	mod.wearer.remove_status_effect(/datum/status_effect/protean_servo_movement)
//	mod.wearer.remove_status_effect(/datum/status_effect/protean_servo_medical)
	mod.wearer.remove_status_effect(/datum/status_effect/protean_servo_engineer)

////Protean servo module: Abilities////
//The abilities we give to protean once module is active

/datum/action/cooldown/protean_servo
	background_icon_state = "bg_mod"
	cooldown_time = 60 SECONDS
	cooldown_rounding = 1
	shared_cooldown = MOB_SHARED_COOLDOWN_1 //Using one action puts other two on cooldown
	text_cooldown = TRUE

/datum/action/cooldown/protean_servo/movement
	name = "强化移动"
	desc = "在数秒内辅助穿戴者的移动，但会束缚其双手，并让其更容易被抓住"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_electricity"

/datum/action/cooldown/protean_servo/movement/Activate()
	var/mob/living/carbon/protean = owner
	var/datum/species/protean/species = protean.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	var/mob/living/carbon/wearer = suit.wearer

	wearer.apply_status_effect(/datum/status_effect/protean_servo_movement)
	wearer.visible_message(span_warning("[protean] 加快了 [wearer] 的移动速度！"))
	StartCooldown()

/*
/datum/action/cooldown/protean_servo/medical
	name = "Enhance medical actions"
	desc = "Aids in your wearer's surgeries, medicicine aplications and carrying patients for moderate amount of time."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_blood"

/datum/action/cooldown/protean_servo/medical/Activate()
	var/mob/living/carbon/protean = owner
	var/datum/species/protean/species = protean.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	var/mob/living/carbon/wearer = suit.wearer

	wearer.apply_status_effect(/datum/status_effect/protean_servo_medical)
	wearer.visible_message(span_warning("[protean] assists in [wearer]'s medical actions!"))
	StartCooldown()
*/

/datum/action/cooldown/protean_servo/engineering
	name = "强化建造"
	desc = "在一段适中时间内辅助穿戴者的建造工作以及更广泛的操作。"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_repair"

/datum/action/cooldown/protean_servo/engineering/Activate()
	var/mob/living/carbon/protean = owner
	var/datum/species/protean/species = protean.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	var/mob/living/carbon/wearer = suit.wearer

	wearer.apply_status_effect(/datum/status_effect/protean_servo_engineer)
	wearer.visible_message(span_warning("[protean] 协助 [wearer] 进行建造任务！"))
	StartCooldown()

////Protean servo module: Status Effects////
//Status effects that are granted to wearer

/atom/movable/screen/alert/status_effect/protean_servo_movement
	name = "更快但笨拙"
	desc = "你的 MOD 正在让你变快，但同时让你更容易被抓住，也无法使用双手。"
	icon = 'icons/mob/actions/actions_items.dmi'
	icon_state = "bci_electricity"

/datum/status_effect/protean_servo_movement
	id = "protean_servo_movement"
	duration = 7 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/protean_servo_movement

/datum/status_effect/protean_servo_movement/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/protean_servo/movement)
	for(var/obj/item/thing in owner.held_items)
		ADD_TRAIT(thing, TRAIT_NODROP, PROTEAN_SERVO_TRAIT) //to prevent items droping out of wearer's hands
		RegisterSignals(thing, list(COMSIG_ITEM_DROPPED, COMSIG_MOVABLE_MOVED), PROC_REF(clear_servo_trait)) //In case you somehow drop it anyway
	owner.add_traits(list(TRAIT_RESTRAINED),PROTEAN_SERVO_TRAIT) //main drawback to balance out this particular effect

/datum/status_effect/protean_servo_movement/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_servo/movement)
	owner.remove_traits(list(TRAIT_RESTRAINED),PROTEAN_SERVO_TRAIT)
	for(var/obj/item/thing in owner.held_items)
		clear_servo_trait(thing)
	owner.visible_message(span_warning("[owner] 的移动恢复正常，普罗蒂安模块已耗尽能量。"))

/datum/status_effect/protean_servo_movement/proc/clear_servo_trait(obj/item/thing, ...)
	SIGNAL_HANDLER
	REMOVE_TRAIT(thing, TRAIT_NODROP, PROTEAN_SERVO_TRAIT)
	UnregisterSignal(thing, list(COMSIG_ITEM_DROPPED, COMSIG_MOVABLE_MOVED))

/datum/movespeed_modifier/protean_servo/movement
	multiplicative_slowdown = -0.4 //movement speed modifier
	blacklisted_movetypes = (FLYING|FLOATING)

/*
//Medical option
/atom/movable/screen/alert/status_effect/protean_servo_medical
	name = "Helping hand"
	desc = "Your MOD suit is guiding your hands to speed up surgery, applying medication or carrying patients."
	icon = 'icons/mob/actions/actions_items.dmi'
	icon_state = "bci_blood"

/datum/status_effect/protean_servo_medical
	id = "protean_servo_medical"
	duration = 60 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/protean_servo_medical

/datum/status_effect/protean_servo_medical/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_INITIATE_SURGERY_STEP, PROC_REF(servo_surgery_bonus)) //this is how we affect the surgery speed
	owner.add_traits(list(TRAIT_QUICKER_CARRY, TRAIT_FASTMED),PROTEAN_SERVO_TRAIT)

/datum/status_effect/protean_servo_medical/on_remove()
	. = ..()
	UnregisterSignal(owner, COMSIG_LIVING_INITIATE_SURGERY_STEP)
	owner.remove_traits(list(TRAIT_QUICKER_CARRY, TRAIT_FASTMED),PROTEAN_SERVO_TRAIT)
	owner.visible_message(span_warning("[owner]'s movement return to normal as Protean module runs out of power."))

/datum/status_effect/protean_servo_medical/proc/servo_surgery_bonus(mob/living/carbon/_source, mob/living/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, datum/surgery_step/step, list/modifiers)
	SIGNAL_HANDLER
	modifiers[SPEED_MOD_INDEX] *= 0.25 //surgery speed modifier
*/

//Engineering option
/atom/movable/screen/alert/status_effect/protean_servo_engineer
	name = "自适应握持"
	desc = "你的 MOD 外骨骼手套正在调整形状，以便更好地进行建造和物品操作。"
	icon = 'icons/mob/actions/actions_items.dmi'
	icon_state = "bci_repair"

/datum/status_effect/protean_servo_engineer
	id = "protean_servo_engineer"
	duration = 60 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/protean_servo_engineer

/datum/status_effect/protean_servo_engineer/on_apply()
	. = ..()
	owner.add_actionspeed_modifier(/datum/actionspeed_modifier/protean_servo_engineer)
	owner.add_traits(list(TRAIT_QUICK_BUILD),PROTEAN_SERVO_TRAIT)

/datum/status_effect/protean_servo_engineer/on_remove()
	. = ..()
	owner.remove_actionspeed_modifier(/datum/actionspeed_modifier/protean_servo_engineer)
	owner.remove_traits(list(TRAIT_QUICK_BUILD),PROTEAN_SERVO_TRAIT)
	owner.visible_message(span_warning("[owner] 的移动恢复正常，普罗蒂安模块已耗尽能量。"))

/datum/actionspeed_modifier/protean_servo_engineer
	multiplicative_slowdown = -0.35 //action speed modifier


