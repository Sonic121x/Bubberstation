/obj/item/organ/brain/lycan
	name = "狼人脑"
	desc = "一颗比寻常更大、也略微更光滑的脑。下丘脑似乎比正常尺寸更大。" // I read in a random medical artical that the hypothalamus controls aggression.
	actions_types = list(/datum/action/cooldown/spell/beast_form)
	var/last_slot
	var/to_human_sfx = 'modular_zubbers/code/modules/customization/species/lycans/transform.ogg'
	var/to_lycan_sfx = 'modular_zubbers/code/modules/customization/species/lycans/transform.ogg'

/obj/item/organ/brain/lycan/on_mob_insert(mob/living/carbon/brain_owner, special, movement_flags)
	. = ..()

	addtimer(CALLBACK(src, PROC_REF(try_getting_slot)), 0.1 SECONDS)

// no remove. we want it to REMEMBER.

/// A delayed getter for the current slot of the mob. Used because theres no easy way to access the client when a mob is spawend...
/obj/item/organ/brain/lycan/proc/try_getting_slot()
	if (last_slot)
		return

	var/client/target_client = owner?.client
	if (!isnull(target_client))
		last_slot = target_client.prefs.savefile.get_entry("default_slot")

/obj/item/organ/brain/lycan/proc/enter_beast_form()
	owner.apply_status_effect(/datum/status_effect/beast_form)

/obj/item/organ/brain/lycan/proc/leave_beast_form()
	owner.remove_status_effect(/datum/status_effect/beast_form)

//GAME_VERB_PROC_DESC(/obj/item/organ/brain/lycan, toggle_beast_form, "Enter/Leave Lycan Form", "Succumb to the rage and turn into a lycan.", "Lycan", mob/user)
GAME_VERB_PROC_DESC(/obj/item/organ/brain/lycan, toggle_beast_form, "进入/离开狼人形态", "屈从于怒火，化身为狼人。", "狼人")
	VERB_ARG_TYPED(user, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	if(!user)
		return
	if(user.has_status_effect(/datum/status_effect/beast_form))
		leave_beast_form()
	else
		if (HAS_TRAIT(user, TRAIT_MANSUS_INHIBITION))
			user.balloon_alert(user, "受抑制时无法变形！")
			return
		enter_beast_form()
