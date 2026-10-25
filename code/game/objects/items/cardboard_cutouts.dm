//Cardboard cutouts! They're man-shaped and can be colored with a crayon to look like a human in a certain outfit, although it's limited, discolored, and obvious to more than a cursory glance.
/obj/item/cardboard_cutout
	name = "人形纸板"
	desc = "一块大致呈人形的纸板，上面一片空白。"
	icon = 'icons/obj/art/cardboard_cutout.dmi'
	icon_state = "cutout_basic"
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE
	obj_flags = CAN_BE_HIT
	item_flags = NO_PIXEL_RANDOM_DROP
	custom_materials = list(/datum/material/cardboard = SHEET_MATERIAL_AMOUNT * 5)
	/// If the cutout is pushed over and has to be righted
	var/pushed_over = FALSE
	/// If the cutout actually appears as what it portray and not a discolored version
	var/deceptive = FALSE
	/// What cutout datum we spawn at the start? Uses the name, not the path.
	var/starting_cutout
	/// Reference to the tactical component that should be deleted when the cutout is toppled.
	var/datum/component/tactical/tacticool

/obj/item/cardboard_cutout/Initialize(mapload)
	. = ..()
	if(starting_cutout)
		return INITIALIZE_HINT_LATELOAD
	if(!pushed_over)
		tacticool = AddComponent(/datum/component/tactical)

/obj/item/cardboard_cutout/Destroy()
	tacticool = null
	return ..()

/obj/item/cardboard_cutout/LateInitialize()
	ASSERT(!isnull(starting_cutout))

	var/datum/cardboard_cutout/cutout
	for (var/datum/cardboard_cutout/cutout_subtype as anything in subtypesof(/datum/cardboard_cutout))
		if (initial(cutout_subtype.name) != starting_cutout)
			continue

		cutout = get_cardboard_cutout_instance(cutout_subtype)

	ASSERT(!isnull(cutout), "No cutout found with name [starting_cutout]")

	cutout.apply(src)
	if(!pushed_over)
		tacticool = AddComponent(/datum/component/tactical)

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/cardboard_cutout/attack_hand(mob/living/user, list/modifiers)
	if(!user.combat_mode || pushed_over || !isturf(loc))
		return ..()
	user.visible_message(span_warning("[user]推倒了[src]！"), span_danger("你推倒了[src]！"))
	playsound(src, 'sound/items/weapons/genhit.ogg', 50, TRUE)
	push_over()

/obj/item/cardboard_cutout/equipped(mob/living/user, slot)
	. = ..()
	//Because of the tactical element, the user won't tilt left and right, but it'll still hop.
	user.AddElementTrait(TRAIT_WADDLING, REF(src), /datum/element/waddling)

/obj/item/cardboard_cutout/dropped(mob/living/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_WADDLING, REF(src))

/obj/item/cardboard_cutout/proc/push_over()
	appearance = initial(appearance)
	desc = "[initial(desc)]它被推倒了。"
	icon_state = "cutout_pushed_over"
	remove_atom_colour(FIXED_COLOUR_PRIORITY)
	pushed_over = TRUE
	QDEL_NULL(tacticool)

/obj/item/cardboard_cutout/attack_self(mob/living/user)
	if(!pushed_over)
		return
	to_chat(user, span_notice("你扶起了[src]。"))
	desc = initial(desc)
	icon = initial(icon)
	icon_state = initial(icon_state) //This resets a cutout to its blank state - this is intentional to allow for resetting
	pushed_over = FALSE
	tacticool = AddComponent(/datum/component/tactical)

/obj/item/cardboard_cutout/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/toy/crayon))
		return NONE
	change_appearance(tool, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/cardboard_cutout/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	. = ..()
	var/damage_sustained = . || 0
	if((damage_flag == BULLET || damage_flag == MELEE) && (damage_type == BRUTE) && prob(damage_sustained))
		push_over()

/obj/item/cardboard_cutout/atom_deconstruct(disassembled)
	new /obj/item/stack/sheet/cardboard(loc)

/proc/get_cardboard_cutout_instance(datum/cardboard_cutout/cardboard_cutout)
	ASSERT(ispath(cardboard_cutout), "[cardboard_cutout] is not a path of /datum/cardboard_cutout")

	var/static/list/cardboard_cutouts = list()

	if(isnull(cardboard_cutouts[cardboard_cutout]))
		cardboard_cutouts[cardboard_cutout] = new cardboard_cutout

	return cardboard_cutouts[cardboard_cutout]

/**
 * change_appearance: Changes a skin of the cardboard cutout based on a user's choice
 *
 * Arguments:
 * * crayon The crayon used to change and recolor the cardboard cutout
 * * user The mob choosing a skin of the cardboard cutout
 */
/obj/item/cardboard_cutout/proc/change_appearance(obj/item/toy/crayon/crayon, mob/living/user)
	var/list/appearances_by_name = list()
	var/list/possible_appearances = list()

	for (var/datum/cardboard_cutout/cutout_subtype as anything in subtypesof(/datum/cardboard_cutout))
		var/datum/cardboard_cutout/cutout = get_cardboard_cutout_instance(cutout_subtype)
		appearances_by_name[chinese_cardboard_cutout_display(cutout.name)] = cutout
		possible_appearances[chinese_cardboard_cutout_display(cutout.name)] = image(icon = cutout.preview_appearance)

	var/new_appearance = show_radial_menu(user, src, possible_appearances, custom_check = CALLBACK(src, PROC_REF(check_menu), user, crayon), radius = 36, require_near = TRUE)
	if(!new_appearance)
		return FALSE
	if(!do_after(user, 1 SECONDS, src, timed_action_flags = IGNORE_HELD_ITEM))
		return FALSE
	if(!check_menu(user, crayon))
		return FALSE
	user.visible_message(span_notice("[user]给[src]换了个新造型。"), span_notice("大功告成！你给[src]换了个新造型。"))
	crayon.use_charges(1)
	crayon.check_empty(user)
	alpha = 255
	icon = initial(icon)
	if(!deceptive)
		add_atom_colour("#FFD7A7", FIXED_COLOUR_PRIORITY)
	var/datum/cardboard_cutout/cutout = appearances_by_name[new_appearance]
	cutout.apply(src)
	return TRUE

/**
 * check_menu: Checks if we are allowed to interact with a radial menu
 *
 * Arguments:
 * * user The mob interacting with a menu
 * * crayon The crayon used to interact with a menu
 */
/obj/item/cardboard_cutout/proc/check_menu(mob/living/user, obj/item/toy/crayon/crayon)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	if(pushed_over)
		to_chat(user, span_warning("先扶起[src]！"))
		return FALSE
	if(!crayon || !user.is_holding(crayon))
		return FALSE
	if(crayon.check_empty(user))
		return FALSE
	if(crayon.is_capped)
		to_chat(user, span_warning("先取下笔帽！"))
		return FALSE
	return TRUE

/obj/item/cardboard_cutout/adaptive //Purchased by Syndicate agents, these cutouts are indistinguishable from normal cutouts but aren't discolored when their appearance is changed
	deceptive = TRUE

/obj/item/cardboard_cutout/nuclear_operative
	starting_cutout = "Nuclear Operative"

/obj/item/cardboard_cutout/xenomorph
	starting_cutout = "Xenomorph"

/datum/cardboard_cutout
	/// Name of the cutout, used for radial selection and the global list.
	var/name = "Boardjak"
	/// The appearance of the cardboard cutout that we show in the radial menu.
	var/mutable_appearance/preview_appearance
	/// A flat appearance, with only one direction, that we apply to the cardboard cutout.
	var/image/applied_appearance
	/// The base name we actually give to to the cardboard cutout. Can be overridden in get_name().
	var/applied_name = "纸板脸"
	/// The desc we give to the cardboard cutout.
	var/applied_desc = "一块画着呆滞表情的人形纸板。"
	/// If we're not using dynamic generation (for non-humans), we can set a direct icon to give.
	var/direct_icon = null
	/// Same as direct_icon, but icon_state!
	var/direct_icon_state = ""
	/// If we're using dynamic generation, the outfit the generated mob will have.
	var/outfit = null
	/// If we're using dynamic generation, the right hand item the generated mob will have.
	var/r_hand = NO_REPLACE
	/// If we're using dynamic generation, the left hand item the generated mob will have.
	var/l_hand = NO_REPLACE
	/// If we're using dynamic generation, the mob spawner the generated mob will base visuals from.
	var/mob_spawner = null
	/// If we're using dynamic generation, the species of the generated mob.
	var/species = /datum/species/human

/datum/cardboard_cutout/New()
	. = ..()
	if(direct_icon)
		preview_appearance = mutable_appearance(direct_icon, direct_icon_state)
	else
		preview_appearance = get_dynamic_human_appearance(outfit, species, mob_spawner, l_hand, r_hand, animated = FALSE)

/// This proc returns the name that the cardboard cutout item will use.
/datum/cardboard_cutout/proc/get_name()
	return applied_name

/// This proc sets the cardboard cutout item's vars.
/datum/cardboard_cutout/proc/apply(obj/item/cardboard_cutout/cutouts)
	if(isnull(applied_appearance))
		applied_appearance = image(fcopy_rsc(getFlatIcon(preview_appearance, no_anim = TRUE)))
	applied_appearance.plane = cutouts.plane
	applied_appearance.layer = cutouts.layer
	var/mutable_appearance/mirror = new(applied_appearance)
	cutouts.appearance = mirror
	cutouts.name = get_name()
	cutouts.desc = applied_desc
	cutouts.update_appearance() //forces an update on the tactical comp's appearance.

/datum/cardboard_cutout/assistant
	name = "Assistant"
	applied_name = "约翰·灰潮"
	applied_desc = "一块助理造型的人形纸板。"
	mob_spawner = /obj/effect/mob_spawn/corpse/human/generic_assistant

/datum/cardboard_cutout/assistant/get_name()
	return "[pick(GLOB.first_names_male)] [pick(GLOB.last_names)]"

/datum/cardboard_cutout/clown
	name = "Clown"
	applied_name = "HONK"
	applied_desc = "一块小丑造型的人形纸板。你总觉得它应该待在角落里。"
	outfit = /datum/outfit/job/clown

/datum/cardboard_cutout/clown/get_name()
	return pick(GLOB.clown_names)

/datum/cardboard_cutout/mime
	name = "Mime"
	applied_name = "..."
	applied_desc = "……（一块默剧演员造型的人形纸板。）"
	outfit = /datum/outfit/job/mime

/datum/cardboard_cutout/mime/get_name()
	return pick(GLOB.mime_names)

/datum/cardboard_cutout/traitor
	name = "Traitor"
	applied_name = "未知"
	applied_desc = "一块叛徒造型的人形纸板。"
	outfit = /datum/outfit/traitor_cutout

/datum/cardboard_cutout/traitor/get_name()
	return pick("未知", "舰长")

/datum/cardboard_cutout/nuclear_operative
	name = "Nuclear Operative"
	applied_name = "未知"
	applied_desc = "一块核爆特工造型的人形纸板。"
	outfit = /datum/outfit/syndicate/full

/datum/cardboard_cutout/nuclear_operative/get_name()
	return pick("未知", "通讯", "电信", "AI", "潜行特工", "隐秘", "偷偷摸摸", "军医", "医护")

/datum/cardboard_cutout/cultist
	name = "Cultist"
	applied_name = "未知"
	applied_desc = "一块血教徒造型的人形纸板。"
	outfit = /datum/outfit/cult_cutout

/datum/cardboard_cutout/revolutionary
	name = "Revolutionary"
	applied_name = "未知"
	applied_desc = "一块革命者造型的人形纸板。"
	outfit = /datum/outfit/rev_cutout

/datum/cardboard_cutout/wizard
	name = "Wizard"
	applied_name = "巫师"
	applied_desc = "一块巫师造型的人形纸板。"
	outfit = /datum/outfit/wizard/bookless

/datum/cardboard_cutout/wizard/get_name()
	return "[pick(GLOB.wizard_first)] [pick(GLOB.wizard_second)]"

/datum/cardboard_cutout/nightmare
	name = "Nightmare"
	applied_name = "梦魇"
	applied_desc = "一块梦魇造型的人形纸板。"
	species = /datum/species/shadow/nightmare

/datum/cardboard_cutout/nightmare/get_name()
	return pick(GLOB.nightmare_names)

/datum/cardboard_cutout/xenomorph
	name = "Xenomorph"
	applied_name = "异形猎手"
	applied_desc = "一块异形造型的人形纸板。"
	direct_icon = 'icons/mob/nonhuman-player/alien.dmi'
	direct_icon_state = "alienh"

/datum/cardboard_cutout/xenomorph/get_name()
	return applied_name + " ([rand(1, 999)])"

/datum/cardboard_cutout/xenomorph_maid
	name = "Xenomorph Maid"
	applied_name = "欲火异形女仆"
	applied_desc = "一块异形女仆造型的人形纸板。"
	direct_icon = 'icons/mob/nonhuman-player/alien.dmi'
	direct_icon_state = "maid"

/datum/cardboard_cutout/xenomorph_maid/get_name()
	return applied_name + " ([rand(1, 999)])"

/datum/cardboard_cutout/ash_walker
	name = "Ash Walker"
	applied_name = "蜥蜴"
	applied_desc = "一块灰行者造型的人形纸板。"
	species = /datum/species/lizard/ashwalker
	outfit = /datum/outfit/ashwalker/spear

/datum/cardboard_cutout/ash_walker/get_name()
	return generate_random_name_species_based(species_type = /datum/species/lizard)

/datum/cardboard_cutout/death_squad
	name = "Deathsquad Officer"
	applied_name = "死亡小队军官"
	applied_desc = "一块死亡突击队员造型的人形纸板。"
	outfit = /datum/outfit/centcom/death_commando

/datum/cardboard_cutout/death_squad/get_name()
	return pick(GLOB.commando_names)

/datum/cardboard_cutout/ian
	name = "Ian"
	applied_name = "伊恩"
	applied_desc = "一块人事主管心爱的柯基犬造型的纸板。"
	direct_icon = 'icons/mob/simple/pets.dmi'
	direct_icon_state = "corgi"

/datum/cardboard_cutout/slaughter_demon
	name = "Slaughter Demon"
	applied_name = "屠戮恶魔"
	applied_desc = "一块屠戮恶魔造型的人形纸板。"
	direct_icon = 'icons/mob/simple/demon.dmi'
	direct_icon_state = "slaughter_demon"

/datum/cardboard_cutout/laughter_demon
	name = "Laughter Demon"
	applied_name = "欢笑恶魔"
	applied_desc = "一块欢笑恶魔造型的人形纸板。"
	direct_icon = 'icons/mob/simple/demon.dmi'
	direct_icon_state = "bow_demon"

/datum/cardboard_cutout/security_officer
	name = "Private Security Officer"
	applied_name = "私人安保人员"
	applied_desc = "一块私人安保人员造型的人形纸板。"
	mob_spawner = /obj/effect/mob_spawn/corpse/human/nanotrasensoldier

/datum/cardboard_cutout/heretic
	name = "Heretic"
	applied_name = "未知"
	applied_desc = "一块异教徒造型的人形纸板。"
	outfit = /datum/outfit/heretic_hallucination

/datum/cardboard_cutout/changeling
	name = "Changeling"
	applied_name = "未知"
	applied_desc = "一块变形怪造型的人形纸板。"
	outfit = /datum/outfit/changeling

/datum/cardboard_cutout/pirate
	name = "Pirate"
	applied_name = "未知"
	applied_desc = "一块太空海盗造型的人形纸板。"
	outfit = /datum/outfit/pirate/space/captain/cardboard

/datum/cardboard_cutout/ninja
	name = "Space Ninja"
	applied_name = "未知"
	applied_desc = "一块太空忍者造型的人形纸板。"
	outfit = /datum/outfit/ninja

/datum/cardboard_cutout/abductor
	name = "Abductor Agent"
	applied_name = "未知"
	applied_desc = "一块绑架者特工造型的人形纸板。"
	species = /datum/species/abductor
	outfit = /datum/outfit/abductor/agent/cardboard
