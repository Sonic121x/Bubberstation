// KA modkit design discs

/obj/item/disk/design_disk/modkit_disc
	name = "KA 改装磁盘"
	desc = "一张设计磁盘，内含某种独特动能加速器改装套件的设计图。可与科研控制台配合使用。"
	icon_state = "datadisk1"
	var/modkit_design = /datum/design/unique_modkit

/obj/item/disk/design_disk/modkit_disc/Initialize(mapload)
	. = ..()
	blueprints += new modkit_design

/obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe
	name = "进攻性采矿爆破改装磁盘"
	modkit_design = /datum/design/unique_modkit/offensive_turf_aoe

/obj/item/disk/design_disk/modkit_disc/rapid_repeater
	name = "速射连发改装磁盘"
	modkit_design = /datum/design/unique_modkit/rapid_repeater

/obj/item/disk/design_disk/modkit_disc/resonator_blast
	name = "谐振爆破改装磁盘"
	modkit_design = /datum/design/unique_modkit/resonator_blast

/obj/item/disk/design_disk/modkit_disc/bounty
	name = "死亡虹吸改装磁盘"
	modkit_design = /datum/design/unique_modkit/bounty

// Wisp Lantern
/obj/item/wisp_lantern
	name = "诡异提灯"
	desc = "这盏提灯不发光，但里面住着一只友善的灵火。"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "lantern-blue-on"
	inhand_icon_state = "lantern-blue-on"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	var/obj/effect/wisp/wisp

/obj/item/wisp_lantern/attack_self(mob/user)
	. = ..()

	if(!wisp)
		to_chat(user, span_warning("灵火不见了！"))
		icon_state = "lantern-blue"
		inhand_icon_state = "lantern-blue"
		return

	if(wisp.loc == src)
		to_chat(user, span_notice("你放出了灵火。它开始在你头顶盘旋飘浮。"))
		icon_state = "lantern-blue"
		inhand_icon_state = "lantern-blue"
		wisp.orbit(user, 20)
		SSblackbox.record_feedback("tally", "wisp_lantern", 1, "Freed")
		return

	to_chat(user, span_notice("你把灵火收回提灯。"))
	icon_state = "lantern-blue-on"
	inhand_icon_state = "lantern-blue-on"
	wisp.forceMove(src)
	SSblackbox.record_feedback("tally", "wisp_lantern", 1, "Returned")

/obj/item/wisp_lantern/Initialize(mapload)
	. = ..()
	wisp = new(src)

/obj/item/wisp_lantern/Destroy()
	if(wisp)
		if(wisp.loc == src)
			qdel(wisp)
		else
			wisp.visible_message(span_notice("[wisp] 感到一阵悲伤，但很快就消散了。"))
	return ..()

/obj/effect/wisp
	name = "友善的灵火"
	desc = "乐于为你照亮前路。"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "orb"
	light_system = OVERLAY_LIGHT
	light_range = 6
	light_power = 1.2
	light_color = "#79f1ff"
	light_flags = LIGHT_ATTACHED
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	var/static/list/color_cutoffs = list(10, 25, 25)

/obj/effect/wisp/orbit(atom/thing, radius, clockwise, rotation_speed, rotation_segments, pre_rotation, lockinorbit)
	. = ..()
	if(!ismob(thing))
		return
	var/mob/being = thing
	RegisterSignal(being, COMSIG_MOB_UPDATE_SIGHT, PROC_REF(update_user_sight))
	to_chat(being, span_notice("灵火增强了你的视力。"))
	ADD_TRAIT(being, TRAIT_THERMAL_VISION, REF(src))

/obj/effect/wisp/stop_orbit(datum/component/orbiter/orbits, refreshing = FALSE)
	if(!ismob(orbit_target) || refreshing)
		return ..()
	var/mob/being = orbit_target
	UnregisterSignal(being, COMSIG_MOB_UPDATE_SIGHT)
	to_chat(being, span_notice("你的视力恢复正常。"))
	REMOVE_TRAIT(being, TRAIT_THERMAL_VISION, REF(src))
	return ..()

/obj/effect/wisp/proc/update_user_sight(mob/user)
	SIGNAL_HANDLER
	if(!isnull(color_cutoffs))
		user.lighting_color_cutoffs = blend_cutoff_colors(user.lighting_color_cutoffs, color_cutoffs)

// Jacob's ladder

/obj/item/jacobs_ladder
	name = "雅各布天梯"
	desc = "一架违背物理定律的天界之梯。"
	icon = 'icons/obj/structures.dmi'
	icon_state = "ladder00"

/obj/item/jacobs_ladder/attack_self(mob/user)
	var/turf/our_loc = get_turf(src)
	var/ladder_x = our_loc.x
	var/ladder_y = our_loc.y
	to_chat(user, span_notice("你展开了梯子。它延伸得比你预想的远得多。"))
	var/last_ladder = null
	for(var/i in 1 to world.maxz)
		if(is_centcom_level(i) || is_reserved_level(i) || is_away_level(i))
			continue
		var/turf/new_loc = locate(ladder_x, ladder_y, i)
		last_ladder = new /obj/structure/ladder/unbreakable/jacob(new_loc, null, last_ladder)
	qdel(src)

// Inherit from unbreakable but don't set ID, to suppress the default Z linkage
/obj/structure/ladder/unbreakable/jacob
	name = "雅各布天梯"
	desc = "一架违背物理定律、无法破坏的天界之梯。"

// Book of Babel

/obj/item/book_of_babel
	name = "巴别之书"
	desc = "一本用无数种语言写成的古老典籍。"
	icon = 'icons/obj/service/library.dmi'
	icon_state = "book1"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/book_of_babel/attack_self(mob/user)
	if(user.is_blind())
		to_chat(user, span_warning("你是盲人，什么也读不了！"))
		return FALSE
	if(!user.can_read(src))
		return FALSE
	to_chat(user, span_notice("你翻动书页，迅速而便捷地学会了世上所有的语言。稍微不那么便捷的是，这本老书在这个过程中化成了飞灰。唉。"))
	cure_curse_of_babel(user) // removes tower of babel if we have it
	user.grant_all_languages(source = LANGUAGE_BABEL)
	user.remove_blocked_language(GLOB.all_languages, source = LANGUAGE_ALL)
	if(user.mind)
		ADD_TRAIT(user.mind, TRAIT_TOWER_OF_BABEL, MAGIC_TRAIT) // this makes you immune to babel effects
	new /obj/effect/decal/cleanable/ash(get_turf(user))
	qdel(src)


// Potion of Flight

/obj/item/reagent_containers/cup/bottle/potion
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "potionflask"
	fill_icon = 'icons/obj/mining_zones/artefacts.dmi'
	fill_icon_state = "potion_fill"
	fill_icon_thresholds = list(0, 1)

/obj/item/reagent_containers/cup/bottle/potion/update_overlays()
	. = ..()
	if(reagents?.total_volume)
		. += "potionflask_cap"

/obj/item/reagent_containers/cup/bottle/potion/flight
	name = "奇异的灵药"
	desc = "一只散发着近乎神圣气息的烧瓶。瓶身上的标签写着：'erqo'hyy tvi'rf lbh jv'atf'。"
	list_reagents = list(/datum/reagent/flightpotion = 5)

/datum/reagent/flightpotion
	name = "飞行药水"
	description = "来历不明的奇异诱变化合物。"
	color = "#976230"

/datum/reagent/flightpotion/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE)
	. = ..()
	if(!ishuman(exposed_mob) || exposed_mob.stat == DEAD)
		return
	if(!(methods & (INGEST | TOUCH)))
		return
	var/mob/living/carbon/human/exposed_human = exposed_mob
	var/obj/item/bodypart/chest/chest = exposed_human.get_bodypart(BODY_ZONE_CHEST)
	if(!chest.wing_types || reac_volume < 5 || !exposed_human.dna)
		if((methods & INGEST) && show_message)
			to_chat(exposed_human, span_notice("<i>你只感到一股糟糕的余味。</i>"))
		return
	var/had_wings = exposed_human.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
	var/wing_type = get_wing_choice(exposed_human, chest)
	if(!wing_type)
		return
	var/obj/item/organ/wings/functional/wings = new wing_type()
	wings.Insert(exposed_human)
	if(had_wings)
		to_chat(exposed_human, span_userdanger("一阵剧痛沿着你的背部传来，你的翅膀改变了形状！"))
	else
		to_chat(exposed_human, span_userdanger("一阵剧痛沿着你的背部传来，翅膀猛然破体而出！"))
	playsound(exposed_human.loc, 'sound/items/poster/poster_ripped.ogg', 50, TRUE, -1)
	exposed_human.apply_damage(20, def_zone = BODY_ZONE_CHEST, forced = TRUE, wound_bonus = CANT_WOUND)
	exposed_human.emote("scream")

/datum/reagent/flightpotion/proc/get_wing_choice(mob/living/carbon/human/needs_wings, obj/item/bodypart/chest/chest)
	var/list/wing_types = chest.wing_types.Copy()
	if (wing_types.len == 1 || !needs_wings.client)
		return wing_types[1]
	var/list/radial_wings = list()
	var/list/name2type = list()
	for(var/obj/item/organ/wings/functional/possible_type as anything in wing_types)
		var/datum/sprite_accessory/accessory = SSaccessories.sprite_accessories[FEATURE_WINGS][possible_type::sprite_accessory_override::name] // BUBBER EDIT CHANGE - Original: var/datum/sprite_accessory/accessory = SSaccessories.feature_list[FEATURE_WINGS][possible_type::sprite_accessory_override::name] //get the singleton instance
		var/image/img = image(icon = accessory.icon, icon_state = "m_wingsopen_[accessory.icon_state]_BEHIND") //Process the HUD elements
		img.transform *= 0.5
		img.pixel_w = -32
		if(radial_wings[accessory.name])
			stack_trace("Different wing types with repeated names. Please fix as this may cause issues.")
		else
			radial_wings[accessory.name] = img
			name2type[accessory.name] = possible_type
	var/wing_name = show_radial_menu(needs_wings, needs_wings, radial_wings, tooltips = TRUE)
	var/wing_type = name2type[wing_name]
	// If our chest gets replaced in the meanwile this can end up breaking, so we need to re-fetch it just to make sure
	var/obj/item/bodypart/chest/new_chest = needs_wings.get_bodypart(BODY_ZONE_CHEST)
	if(new_chest != chest)
		chest = new_chest
		wing_type = null
	if(!wing_type)
		if(!length(chest.wing_types))
			return
		wing_type = pick(chest.wing_types)
	return wing_type
