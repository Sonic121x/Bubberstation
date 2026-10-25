/datum/round_event_control/wizard/greentext //Gotta have it!
	name = "绿字"
	weight = 4
	typepath = /datum/round_event/wizard/greentext
	max_occurrences = 1
	earliest_start = 0 MINUTES
	description = "绿色文字出现在空间站上，诱惑人们去把它捡起来。"
	min_wizard_trigger_potency = 5
	max_wizard_trigger_potency = 7

/datum/round_event/wizard/greentext/start()

	var/list/holder_canadates = GLOB.player_list.Copy()
	for(var/mob/M in holder_canadates)
		if(!ishuman(M))
			holder_canadates -= M
	if(!holder_canadates) //Very unlikely, but just in case
		return FALSE

	var/mob/living/carbon/human/H = pick(holder_canadates)
	new /obj/item/greentext(H.loc)
	to_chat(H, "<font color='green'>传说中的绿字出现在你脚边！有胆量就把它捡起来……</font>")


/obj/item/greentext
	name = "绿字"
	desc = "没人知道这本厚重的典籍有什么用，但它依然让人感到<i><font color='green'>渴望</font></i>……"
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "greentext"
	resistance_flags = FIRE_PROOF | ACID_PROOF | INDESTRUCTIBLE
	///The current holder of the greentext.
	var/mob/living/holder
	///Every person who has touched the greentext, having their colors changed by it.
	var/list/color_altered_mobs
	///The callback at the end of a round to check if the greentext has been completed.
	var/datum/callback/roundend_callback
	///Boolean on whether to announce the greentext's destruction to all mobs.
	var/quiet = FALSE

/obj/item/greentext/quiet
	quiet = TRUE

/obj/item/greentext/Initialize(mapload)
	. = ..()
	SSpoints_of_interest.make_point_of_interest(src)
	roundend_callback = CALLBACK(src, PROC_REF(check_winner))
	SSticker.OnRoundend(roundend_callback)

/obj/item/greentext/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	to_chat(user, span_green("只要你手捧绿字离开这里，你知道自己就会心满意足……"))
	if(user.mind && length(user.mind.get_all_objectives()) > 0)
		to_chat(user, span_warning("……前提是你仍然完成了自己的其他目标！"))
	holder = user
	if(!HAS_TRAIT(user, TRAIT_GREENTEXT_CURSED))
		LAZYOR(color_altered_mobs, WEAKREF(user))
		ADD_TRAIT(user, TRAIT_GREENTEXT_CURSED, REF(src))
	user.add_atom_colour("#00ff00", ADMIN_COLOUR_PRIORITY)

/obj/item/greentext/dropped(mob/user, silent = FALSE)
	if(HAS_TRAIT(user, TRAIT_GREENTEXT_CURSED))
		to_chat(user, span_warning("一阵突如其来的失败感席卷了你……"))
		user.add_atom_colour("#ff0000", ADMIN_COLOUR_PRIORITY) //ya blew it
	holder = null
	return ..()

/obj/item/greentext/Destroy(force)
	LAZYREMOVE(SSticker.round_end_events, roundend_callback)
	roundend_callback = null //This ought to free the callback datum, and prevent us from harddeling
	if(LAZYLEN(color_altered_mobs))
		INVOKE_ASYNC(src, PROC_REF(release_victims))
	return ..()

/obj/item/greentext/proc/release_victims()
	var/list/victims = list()
	for (var/datum/weakref/player_ref as anything in color_altered_mobs)
		var/mob/player_mob = player_ref.resolve()
		if (player_mob)
			victims += player_mob

	var/list/announce_list = quiet ? victims : GLOB.player_list
	for(var/mob/player as anything in announce_list)
		var/list/messages = list(span_warning("一股黑暗的诱惑已从这个世界消失！"))
		if(HAS_TRAIT(player, TRAIT_GREENTEXT_CURSED))
			messages += span_green("你终于能够原谅自己了……")
		to_chat(player, messages.Join("\n"))
	for(var/mob/player as anything in victims)
		REMOVE_TRAIT(player, TRAIT_GREENTEXT_CURSED, REF(src))
		if (!HAS_TRAIT(player, TRAIT_GREENTEXT_CURSED))
			player.remove_atom_colour(ADMIN_COLOUR_PRIORITY)
	LAZYNULL(color_altered_mobs)


/obj/item/greentext/proc/check_winner()
	if(!holder)
		return
	if(!is_centcom_level(holder.z)) //you're winner!
		return

	REMOVE_TRAIT(holder, TRAIT_GREENTEXT_CURSED, REF(src))
	release_victims()
	to_chat(holder, span_green("终于，胜利似乎已经十拿九稳！"))
	holder.mind.add_antag_datum(/datum/antagonist/greentext)
	holder.log_message("带着绿字获胜！！！", LOG_ATTACK, color = "green")
	resistance_flags |= ON_FIRE
	qdel(src)
