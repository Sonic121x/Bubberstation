#define SPELLBOOK_CATEGORY_PERKS "Perks"

/datum/spellbook_entry/perks
	desc = "特长主节点"
	category = SPELLBOOK_CATEGORY_PERKS
	refundable = FALSE // no refund
	requires_wizard_garb = FALSE
	/// Icon that will be shown on wizard hud when purchasing a perk.
	var/hud_icon

/datum/spellbook_entry/perks/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	var/datum/antagonist/wizard/wizard_datum = user.mind.has_antag_datum(/datum/antagonist/wizard)
	if(wizard_datum)
		wizard_datum.perks += src
	RegisterSignal(user, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))
	if (user.hud_used)
		on_hud_created(user)
	to_chat(user, span_notice("你获得了新特长：[src.name]。"))
	log_purchase(user.key)
	return TRUE

/datum/spellbook_entry/perks/proc/on_hud_created(mob/living/carbon/human/source)
	SIGNAL_HANDLER

	var/datum/hud/user_hud = source.hud_used
	var/datum/antagonist/wizard/wizard_datum = source.mind.has_antag_datum(/datum/antagonist/wizard)
	if(!user_hud.screen_objects[HUD_WIZARD_COMPACT_PERKS])
		user_hud.add_screen_object(/atom/movable/screen/perk/more, HUD_WIZARD_COMPACT_PERKS, HUD_GROUP_INFO, ui_loc = ui_perk_position(0), update_screen = TRUE)

	var/atom/movable/screen/perk/perk = user_hud.add_screen_object(/atom/movable/screen/perk, HUD_WIZARD_PERK(length(wizard_datum.perks)), HUD_GROUP_INFO, ui_loc = ui_perk_position(length(wizard_datum.perks)), update_screen = TRUE)
	perk.name = name
	perk.icon_state = hud_icon

/datum/spellbook_entry/perks/fourhands
	name = "四只手"
	desc = "赋予你更多只手来施展魔法"
	hud_icon = "fourhands"

/datum/spellbook_entry/perks/fourhands/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	user.change_number_of_hands(4)

/datum/spellbook_entry/perks/wormborn
	name = "蠕虫之生"
	desc = "你的灵魂被法力蠕虫侵染。当你死亡时，你将重生为一条巨大的蠕虫。\
		而当这蠕虫死亡时，可就没有这种好运了。寄生感染会阻止你将灵魂绑定到物体上。"
	hud_icon = "wormborn"
	no_coexistence_typecache = list(/datum/action/cooldown/spell/lichdom)

/datum/spellbook_entry/perks/wormborn/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	user.AddComponent(/datum/component/wormborn)

/datum/spellbook_entry/perks/dejavu
	name = "既视感"
	desc = "每隔 60 秒，将你送回 60 秒前所在的位置，并使你的生命值恢复到 60 秒前的状态。"
	hud_icon = "dejavu"

/datum/spellbook_entry/perks/dejavu/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	RegisterSignal(user, COMSIG_ENTER_AREA, PROC_REF(give_dejavu))

/datum/spellbook_entry/perks/dejavu/proc/give_dejavu(mob/living/carbon/human/wizard, area/new_area)
	SIGNAL_HANDLER

	if(istype(new_area, /area/centcom))
		return
	wizard.AddComponent(/datum/component/dejavu/wizard, 1, 60 SECONDS, TRUE)
	UnregisterSignal(wizard, COMSIG_ENTER_AREA)

/datum/spellbook_entry/perks/spell_lottery
	name = "法术抽奖"
	desc = "“法术抽奖”让你有机会完全免费地从法术书中获得某样东西，但你再也无法退款任何已购买的项目。"
	hud_icon = "spellottery"

/datum/spellbook_entry/perks/spell_lottery/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	ADD_TRAIT(user, TRAIT_SPELLS_LOTTERY, REF(src))

/datum/spellbook_entry/perks/gamble
	name = "赌博"
	desc = "你获得 2 个随机特长。"
	hud_icon = "gamble"

/datum/spellbook_entry/perks/gamble/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	var/datum/antagonist/wizard/check_perks = user.mind.has_antag_datum(/datum/antagonist/wizard)
	var/perks_allocated = 0
	var/list/taking_perks = list()
	for(var/datum/spellbook_entry/perks/generate_perk in book.entries)
		if(istype(generate_perk, src))
			continue
		if(check_perks && is_type_in_list(generate_perk, check_perks.perks))
			continue
		taking_perks += generate_perk
		perks_allocated++
		if(perks_allocated >= 2)
			break
	if(taking_perks.len < 1)
		to_chat(user, span_warning("“赌博”无法提供 2 个特长，因此点数已退还"))
		return FALSE
	taking_perks = shuffle(taking_perks)
	for(var/datum/spellbook_entry/perks/perks_ready in taking_perks)
		perks_ready.buy_spell(user, book, log_buy)

/datum/spellbook_entry/perks/heart_eater
	name = "食心者"
	desc = "赋予你通过吞食他人心脏来获取其生命力的能力。\
		此外，你可以赤手空拳掏出一名虚弱者的心脏。\
		吞食他人心脏可以提升你的伤害抗性，或让你获得随机突变。\
		心脏也能提供强大的治疗效果。"
	hud_icon = "hearteater"

/datum/spellbook_entry/perks/heart_eater/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	user.AddComponent(/datum/component/heart_eater)

/datum/spellbook_entry/perks/slime_friends
	name = "史莱姆伙伴"
	desc = "史莱姆是你的朋友。\
		每隔 15 秒，你会失去一些营养物质，并召唤一只随机邪恶史莱姆为你而战。"
	hud_icon = "slimefriends"

/datum/spellbook_entry/perks/slime_friends/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	user.AddComponent(/datum/component/slime_friends)

/datum/spellbook_entry/perks/transparence
	name = "半透明化"
	desc = "你向亡者的世界靠近了一些。\
		投射物会穿过你，但你会失去 25% 的生命值，并遭到一道可怕诅咒的追猎，它想把你带回死后世界。"
	hud_icon = "transparence"

/datum/spellbook_entry/perks/transparence/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	user.maxHealth *= 0.75
	user.alpha = 125
	ADD_TRAIT(user, TRAIT_UNHITTABLE_BY_PROJECTILES, REF(src))
	RegisterSignal(user, COMSIG_ENTER_AREA, PROC_REF(make_stalker))

/datum/spellbook_entry/perks/transparence/proc/make_stalker(mob/living/carbon/human/wizard, area/new_area)
	SIGNAL_HANDLER

	if(istype(new_area, /area/centcom/wizard_station))
		return
	wizard.gain_trauma(/datum/brain_trauma/magic/stalker, TRAUMA_RESILIENCE_ABSOLUTE)
	UnregisterSignal(wizard, COMSIG_ENTER_AREA)

/datum/spellbook_entry/perks/magnetism
	name = "磁性"
	desc = "你获得一个环绕你运行的小型重力异常。\
		附近的东西会被吸引向你。"
	hud_icon = "magnetism"

/datum/spellbook_entry/perks/magnetism/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	var/atom/movable/magnitizm = new /obj/effect/wizard_magnetism(get_turf(user))
	magnitizm.orbit(user, 20)

/obj/effect/wizard_magnetism
	name = "磁力异常"
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield2"
	/// We need to orbit around someone.
	var/datum/weakref/owner

/obj/effect/wizard_magnetism/New(loc, ...)
	. = ..()
	transform *= 0.4

/obj/effect/wizard_magnetism/orbit(atom/new_owner, radius, clockwise, rotation_speed, rotation_segments, pre_rotation)
	. = ..()
	if(!isliving(new_owner))
		return
	owner = WEAKREF(new_owner)
	RegisterSignal(new_owner, COMSIG_ENTER_AREA, PROC_REF(check_area))
	RegisterSignal(new_owner, COMSIG_LIVING_DEATH, PROC_REF(on_owner_death))

/obj/effect/wizard_magnetism/proc/check_area(mob/living/wizard, area/new_area)
	SIGNAL_HANDLER

	if(new_area == GLOB.areas_by_type[/area/centcom/wizard_station])
		return
	START_PROCESSING(SSprocessing, src)
	UnregisterSignal(wizard, COMSIG_ENTER_AREA)

/obj/effect/wizard_magnetism/proc/on_owner_death()
	SIGNAL_HANDLER

	stop_orbit()

/obj/effect/wizard_magnetism/process(seconds_per_tick)
	if(isnull(owner))
		stop_orbit()
		return
	var/mob/living/wizard = owner.resolve()
	var/list/things_in_range = orange(5, wizard) - orange(1, wizard)
	for(var/obj/take_object in things_in_range)
		if(!take_object.anchored)
			step_towards(take_object, wizard)
	for(var/mob/living/living_mov in things_in_range)
		if(wizard)
			if(living_mov == wizard)
				continue
		if(!living_mov.mob_negates_gravity())
			step_towards(living_mov, wizard)

/obj/effect/wizard_magnetism/stop_orbit(datum/component/orbiter/orbiter, refreshing = FALSE)
	if(refreshing)
		return ..()
	STOP_PROCESSING(SSprocessing, src)
	qdel(src)

#undef SPELLBOOK_CATEGORY_PERKS
