/obj/item/gun/ballistic/shotgun
	name = "霰弹枪"
	desc = "一把传统的木质枪托霰弹枪，下方弹仓可容纳四发霰弹。"
	icon_state = "shotgun"
	worn_icon_state = null
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	inhand_icon_state = "shotgun"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	fire_sound = 'sound/items/weapons/gun/shotgun/shot.ogg'
	fire_sound_volume = 90
	rack_sound = 'sound/items/weapons/gun/shotgun/rack.ogg'
	load_sound = 'sound/items/weapons/gun/shotgun/insert_shell.ogg'
	drop_sound = 'sound/items/handling/gun/ballistics/shotgun/shotgun_drop1.ogg'
	pickup_sound = 'sound/items/handling/gun/ballistics/shotgun/shotgun_pickup1.ogg'
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot
	semi_auto = FALSE
	internal_magazine = TRUE
	casing_ejector = FALSE
	bolt_wording = "泵杆"
	cartridge_wording = "霰弹"
	tac_reloads = FALSE
	weapon_weight = WEAPON_HEAVY
	misfire_probability_cap = 35 // Even if the misfire probability and increment are both zero, we've some shots that may do that.

	pb_knockback = 2

/obj/item/gun/ballistic/shotgun/blow_up(mob/user)
	. = 0
	if(chambered?.loaded_projectile)
		process_fire(user, user, FALSE)
		. = 1

/obj/item/gun/ballistic/shotgun/lethal
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/lethal

// RIOT SHOTGUN //

/obj/item/gun/ballistic/shotgun/riot //for spawn in the armory
	name = "防暴霰弹枪"
	desc = "一把坚固的霰弹枪，配有加长弹仓和固定式战术枪托，专为非致命防暴控制而设计。"
	icon_state = "riotshotgun"
	inhand_icon_state = "shotgun"
	fire_delay = 8 DECISECONDS
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/riot
	sawn_desc = "想活命就跟我走。"
	can_be_sawn_off = TRUE
	chambered_attack_block = TRUE // necessary for riot shotgun due to fire_delay and wanting to shoot point blank without accidental melee

//component for seclight attachment
/obj/item/gun/ballistic/shotgun/riot/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 20, \
		overlay_y = 11)

// Pump-Action Grenade Launcher //

/obj/item/gun/ballistic/shotgun/china_lake
	name = "泵动式榴弹发射器"
	desc = "一把泵动式榴弹发射器，常见于太空海盗袭击者手中。重量方面差强人意，但大容量弹仓弥补了\
		笨重的缺点。"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	icon_state = "china_lake"
	inhand_icon_state = "china_lake"
	worn_icon_state = "riotshotgun"
	fire_sound = 'sound/items/weapons/gun/general/grenade_launch.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/lake
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	pb_knockback = 4 // Not advised.

// Automatic Shotguns//

/obj/item/gun/ballistic/shotgun/automatic/shoot_live_shot(mob/living/user)
	..()
	rack()

/obj/item/gun/ballistic/shotgun/automatic/combat //ICON OVERRIDDEN IN SKYRAT AESTHETICS - SEE MODULE
	name = "战斗霰弹枪"
	desc = "一把半自动霰弹枪，配有战术枪托，下方弹仓可容纳六发霰弹。"
	icon_state = "cshotgun"
	inhand_icon_state = "shotgun_combat"
	projectile_damage_multiplier = 1.5
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/com
	w_class = WEIGHT_CLASS_HUGE

//component for seclight attachment
/obj/item/gun/ballistic/shotgun/automatic/combat/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 20, \
		overlay_y = 11)

/obj/item/gun/ballistic/shotgun/automatic/combat/compact
	name = "紧凑型战斗霰弹枪"
	desc = "半自动战斗霰弹枪的紧凑型号。弹仓容量较小，但更便于携带。"
	icon_state = "cshotgunc"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/com/compact
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM

//component for seclight attachment
/obj/item/gun/ballistic/shotgun/automatic/combat/compact/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 16, \
		overlay_y = 11)

//Dual Feed Shotgun

/obj/item/gun/ballistic/shotgun/automatic/dual_tube
	name = "循环霰弹枪"
	desc = "一把高级霰弹枪，配备两个独立弹仓，可让你在弹药类型之间快速切换。"
	icon_state = "cycler"
	inhand_icon_state = "bulldog"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	worn_icon_state = "cshotgun"
	w_class = WEIGHT_CLASS_HUGE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/tube
	interaction_flags_click = NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING
	/// If defined, the secondary tube is this type, if you want different shell loads
	var/alt_mag_type
	/// If TRUE, we're drawing from the alternate_magazine
	var/toggled = FALSE
	/// The B tube
	var/obj/item/ammo_box/magazine/internal/shot/alternate_magazine

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/bounty
	name = "赏金循环霰弹枪"
	desc = "一把高级霰弹枪，配备两个独立弹仓。这把枪带有赏金猎人定制改装的痕迹，意味着它很可能装填了橡胶弹与燃烧弹头的双弹配置。"
	alt_mag_type = /obj/item/ammo_box/magazine/internal/shot/tube/fire

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/deadly
	spawn_magazine_type = /obj/item/ammo_box/magazine/internal/shot/tube/buckshot
	alt_mag_type = /obj/item/ammo_box/magazine/internal/shot/tube/slug

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/examine(mob/user)
	. = ..()
	. += span_notice("按住 Alt 点击以拉动泵杆。")

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/Initialize(mapload)
	. = ..()
	alt_mag_type = alt_mag_type || spawn_magazine_type
	alternate_magazine = new alt_mag_type(src)

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/Destroy()
	QDEL_NULL(alternate_magazine)
	return ..()

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/attack_self(mob/living/user)
	if(!chambered && get_ammo())
		rack()
	else
		toggle_tube(user)

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/proc/toggle_tube(mob/living/user)
	var/current_mag = magazine
	var/alt_mag = alternate_magazine
	magazine = alt_mag
	alternate_magazine = current_mag
	toggled = !toggled
	if(toggled)
		balloon_alert(user, "已切换至 B 管")
	else
		balloon_alert(user, "已切换至 A 管")

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/click_alt(mob/living/user)
	rack()
	return CLICK_ACTION_SUCCESS

// Bulldog shotgun //

/obj/item/gun/ballistic/shotgun/bulldog
	name = "\improper 斗牛犬霰弹枪"
	desc = "一种可两发点射、弹匣供弹的霰弹枪，适用于狭窄走廊中的战斗，被登舰小队戏称为“斗牛犬”。\
		只能使用特制的 8 发弹鼓。可加挂副弹匣，以便在弹药类型之间快速切换，\
		或者只是保持火力输出。"
	icon_state = "bulldog"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "bulldog"
	worn_icon = 'icons/mob/clothing/back.dmi'
	worn_icon_state = "bulldog"
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	projectile_damage_multiplier = 1.2
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/m12g
	can_suppress = FALSE
	burst_size = 2
	burst_delay = 5 //Skyrat edit - Original: 1
	pin = /obj/item/firing_pin/implant/pindicate
	fire_sound = 'sound/items/weapons/gun/shotgun/shot_alt.ogg'
	actions_types = list(/datum/action/item_action/toggle_firemode)
	mag_display = TRUE
	empty_indicator = TRUE
	empty_alarm = TRUE
	special_mags = TRUE
	mag_display_ammo = TRUE
	semi_auto = TRUE
	internal_magazine = FALSE
	tac_reloads = TRUE
	burst_fire_selection = TRUE
	/// The type of secondary magazine for the bulldog
	var/secondary_magazine_type
	/// The secondary magazine
	var/obj/item/ammo_box/magazine/secondary_magazine

/obj/item/gun/ballistic/shotgun/bulldog/Initialize(mapload)
	. = ..()
	secondary_magazine_type = secondary_magazine_type || spawn_magazine_type
	secondary_magazine = new secondary_magazine_type(src)
	update_appearance()

/obj/item/gun/ballistic/shotgun/bulldog/Destroy()
	QDEL_NULL(secondary_magazine)
	return ..()

/obj/item/gun/ballistic/shotgun/bulldog/examine(mob/user)
	. = ..()
	if(secondary_magazine)
		var/secondary_ammo_count = secondary_magazine.ammo_count()
		. += "装有副弹匣。"
		. += "其中还剩 [secondary_ammo_count] 发弹药。"
		. += "右键射击可在开火后切换至副弹匣。"
		. += "若弹匣打空，[src] 会自动切换至副弹匣。"
	. += "手持要装填的弹匣右键点击 [src]，即可装上副弹匣。"
	. += "按住 Alt 右键点击 [src]，即可卸下副弹匣。"
	. += "右键可将弹匣换到副位，反之亦然。"

/obj/item/gun/ballistic/shotgun/bulldog/update_overlays()
	. = ..()
	if(secondary_magazine)
		. += "[icon_state]_secondary_mag_[initial(secondary_magazine.icon_state)]"
		if(!secondary_magazine.ammo_count())
			. += "[icon_state]_secondary_mag_empty"

/obj/item/gun/ballistic/shotgun/bulldog/handle_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	if(!secondary_magazine)
		return ..()
	var/secondary_shells_left = LAZYLEN(secondary_magazine.stored_ammo)
	if(magazine)
		var/shells_left = LAZYLEN(magazine.stored_ammo)
		if(shells_left <= 0 && secondary_shells_left >= 1)
			toggle_magazine()
	else
		toggle_magazine()
	return ..()

/obj/item/gun/ballistic/shotgun/bulldog/attack_self_secondary(mob/user, modifiers)
	toggle_magazine()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/gun/ballistic/shotgun/bulldog/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(secondary_magazine)
		toggle_magazine()
	return ..()

/obj/item/gun/ballistic/shotgun/bulldog/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, secondary_magazine_type))
		return ..()
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	var/obj/item/ammo_box/magazine/old_mag = secondary_magazine
	secondary_magazine = tool
	if(old_mag)
		user.put_in_hands(old_mag)
	balloon_alert(user, "已装填副[magazine_wording]")
	playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/gun/ballistic/shotgun/bulldog/click_alt_secondary(mob/user)
	if(secondary_magazine)
		var/obj/item/ammo_box/magazine/old_mag = secondary_magazine
		secondary_magazine = null
		user.put_in_hands(old_mag)
		update_appearance()
		playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)

/obj/item/gun/ballistic/shotgun/bulldog/proc/toggle_magazine()
	var/primary_magazine = magazine
	var/alternative_magazine = secondary_magazine
	magazine = alternative_magazine
	secondary_magazine = primary_magazine
	playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)
	update_appearance()

/obj/item/gun/ballistic/shotgun/bulldog/unrestricted
	pin = /obj/item/firing_pin

// Double barrel shotgun skins
/datum/atom_skin/bar_shotgun
	abstract_type = /datum/atom_skin/bar_shotgun
	change_base_icon_state = TRUE

/datum/atom_skin/bar_shotgun/default
	preview_name = "标准涂装"
	new_icon_state = "dshotgun"

/datum/atom_skin/bar_shotgun/dark_red
	preview_name = "暗红涂装"
	new_icon_state = "dshotgun_d"

/datum/atom_skin/bar_shotgun/ash
	preview_name = "灰烬"
	new_icon_state = "dshotgun_f"

/datum/atom_skin/bar_shotgun/faded_grey
	preview_name = "褪色灰"
	new_icon_state = "dshotgun_g"

/datum/atom_skin/bar_shotgun/maple
	preview_name = "枫木"
	new_icon_state = "dshotgun_l"

/datum/atom_skin/bar_shotgun/rosewood
	preview_name = "玫瑰木"
	new_icon_state = "dshotgun_p"

/////////////////////////////
// DOUBLE BARRELED SHOTGUN //
/////////////////////////////

/obj/item/gun/ballistic/shotgun/doublebarrel
	name = "双管霰弹枪"
	desc = "真正的经典。"
	icon_state = "dshotgun"
	base_icon_state = "dshotgun"
	inhand_icon_state = "shotgun_db"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	force = 10
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/dual
	sawn_desc = "奥马尔来了！"
	obj_flags = UNIQUE_RENAME
	rack_sound_volume = 0
	semi_auto = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	can_be_sawn_off = TRUE
	pb_knockback = 3 // it's a super shotgun!

/obj/item/gun/ballistic/shotgun/doublebarrel/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/bar_shotgun)

/obj/item/gun/ballistic/shotgun/doublebarrel/sawoff(mob/user)
	. = ..()
	if(.)
		weapon_weight = WEAPON_MEDIUM

/obj/item/gun/ballistic/shotgun/doublebarrel/slugs
	name = "猎用霰弹枪"
	desc = "富人用来猎取“猎物”的猎用霰弹枪。"
	sawn_desc = "一把锯短枪管的猎用霰弹枪。变成现在这样后，它猎取……任何东西的效率都明显下降了。"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/dual/slugs

/obj/item/gun/ballistic/shotgun/doublebarrel/breacherslug
	name = "破门霰弹枪"
	desc = "一把经过改膛、可装填破门弹的普通双管霰弹枪。适合破开气闸和窗户，别的就做不了什么了。"
	sawn_desc = "锯短枪管的破门霰弹枪，配置更紧凑，但性能与之前相同。"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/dual/breacherslug

/obj/item/gun/ballistic/shotgun/hook
	name = "加装抓钩的锯短霰弹枪"
	desc = "当你能把受害者拉过来时，射程就不是问题了。"
	icon_state = "hookshotgun"
	inhand_icon_state = "hookshotgun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/bounty
	weapon_weight = WEAPON_MEDIUM
	semi_auto = TRUE
	obj_flags = CONDUCTS_ELECTRICITY
	force = 18 //it has a hook on it
	sharpness = SHARP_POINTY //it does in fact, have a hook on it
	attack_verb_continuous = list("劈砍", "钩拉", "刺击")
	attack_verb_simple = list("劈砍", "钩拉", "刺击")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	//our hook gun!
	var/obj/item/gun/magic/hook/bounty/hook

/obj/item/gun/ballistic/shotgun/hook/Initialize(mapload)
	. = ..()
	hook = new /obj/item/gun/magic/hook/bounty(src)

/obj/item/gun/ballistic/shotgun/hook/Destroy()
	QDEL_NULL(hook)
	return ..()

/obj/item/gun/ballistic/shotgun/hook/examine(mob/user)
	. = ..()
	. += span_notice("右键发射抓钩。")

/obj/item/gun/ballistic/shotgun/hook/try_fire_gun(atom/target, mob/living/user, params)
	if(LAZYACCESS(params2list(params), RIGHT_CLICK))
		return hook.try_fire_gun(target, user, params)
	return ..()

///An underpowered shotgun given to Pun Pun when the station job trait roll.
/obj/item/gun/ballistic/shotgun/monkey
	name = "\improper 吧台帮手的一击"
	desc = "一把黑猩猩尺寸的单发折开式霰弹枪，枪托设计并不实用。"
	icon_state = "chimp_shottie"
	inhand_icon_state = "shotgun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	force = 8
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = NONE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/single
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	semi_auto = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	spread = 10
	projectile_damage_multiplier = 0.5
	projectile_wound_bonus = -25
	recoil = 1
	pin = /obj/item/firing_pin/monkey
	pb_knockback = 1

/obj/item/gun/ballistic/shotgun/musket
	name = "\improper 咚克公司火枪"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "donk_musket"
	inhand_icon_state = "donk_musket"
	worn_icon_state = "donk_musket"
	desc = "一把大口径、枪机装填的枪械，配有雅致的木质枪身。便宜、精准且易于维护。每开一枪后都要重新装填并拉动枪机。"
	semi_auto = TRUE
	alternative_caliber = CALIBER_50BMG
	casing_ejector = TRUE
	bolt_type = BOLT_TYPE_LOCKING
	bolt_wording = "枪机"
	internal_magazine = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/single/musket
