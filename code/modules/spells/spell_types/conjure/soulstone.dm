/datum/action/cooldown/spell/conjure/soulstone
	name = "召唤灵魂石"
	desc = "此法术探入纳尔西的领域，从时空之中召唤出一块传说中的碎片。"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "summonsoulstone"

	school = SCHOOL_CONJURATION
	cooldown_time = 4 MINUTES
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

	summon_radius = 0
	summon_type = list(/obj/item/soulstone)

/datum/action/cooldown/spell/conjure/soulstone/cult
	name = "制造纳尔西灵魂石"
	cooldown_time = 6 MINUTES

/datum/action/cooldown/spell/conjure/soulstone/noncult
	name = "制造灵魂石"
	summon_type = list(/obj/item/soulstone/anybody)

/datum/action/cooldown/spell/conjure/soulstone/purified
	name = "制造净化灵魂石"
	summon_type = list(/obj/item/soulstone/anybody/purified)

/datum/action/cooldown/spell/conjure/soulstone/mystic
	name = "制造神秘灵魂石"
	summon_type = list(/obj/item/soulstone/mystic)
