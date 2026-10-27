/// The wizard die of fate event.
/// The die gets spawned in the hands of a random crewmember, if they roll the dice and get a 1, they die. If they get a 20, they get the wizard antagonist.
/// Either way, it moves to a new crewmember and repeats 20 times.

/datum/round_event_control/wizard_dice
	name = "巫师骰子"
	typepath = /datum/round_event/wizard_dice
	category = EVENT_CATEGORY_INVASION
	description = "一枚魔法 d20 会被传送到站上。有人掷出 20，就会成为巫师；掷出 1，就会当场死亡。"

	min_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS
	max_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS

	min_players = 30
	max_occurrences = 1
	weight = 10
	earliest_start = 60 MINUTES

	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL,TAG_COMBAT)

/datum/round_event/wizard_dice
	announce_chance = 100
	//the "when" stuff is measured in 2 second ticks, not deciseconds.
	announce_when = 30 //1 minute
	end_when = 300 //10 minutes
	var/obj/item/dice/d20/teleporting_die_of_fate/created_dice
	var/did_announce = FALSE

/datum/round_event/wizard_dice/setup()
	//Create the dice and add the signal.
	created_dice = new(get_safe_lucky_player_turf())
	RegisterSignal(created_dice, COMSIG_QDELETING, PROC_REF(on_dice_destroy))

/datum/round_event/wizard_dice/start()
	//Announce the event.
	announce_to_ghosts()

/datum/round_event/wizard_dice/announce(fake)
	priority_announce("区域内检测到一件魔法二十面体造物。请勿与任何科学无法解释的东西发生互动。", "法师学专家警告")
	did_announce = TRUE

/datum/round_event/wizard_dice/kill()
	UnregisterSignal(created_dice, COMSIG_QDELETING) //Remove this signal first.
	. = ..()
	//Garbage day!
	if(created_dice && !QDELETED(created_dice))
		qdel(created_dice)
	created_dice = null

/datum/round_event/wizard_dice/proc/on_dice_destroy()
	processing = FALSE //Stop processing the event.
	kill() //Kill the event.
