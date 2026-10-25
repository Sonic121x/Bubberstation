/obj/structure/chair
	name = "椅子"
	desc = "你坐在这上面。无论是自愿还是被迫。"
	icon = 'icons/obj/chairs.dmi'
	icon_state = "chair"
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = 0 //you sit in a chair, not lay
	resistance_flags = NONE
	max_integrity = 100
	integrity_failure = 0.1
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	layer = OBJ_LAYER
	interaction_flags_mouse_drop = ALLOW_RESTING

	var/buildstacktype = /obj/item/stack/sheet/iron
	var/buildstackamount = 1
	var/item_chair = /obj/item/chair // if null it can't be picked up
	///How much sitting on this chair influences fishing difficulty
	var/fishing_modifier = -5
	var/has_armrest = FALSE

/obj/structure/chair/Initialize(mapload)
	. = ..()
	if(prob(0.2))
		name = "战术[name]"
		fishing_modifier -= 8
	MakeRotate()
	if(can_buckle && fishing_modifier)
		AddElement(/datum/element/adjust_fishing_difficulty, fishing_modifier)

/obj/structure/chair/buckle_feedback(mob/living/being_buckled, mob/buckler)
	if(HAS_TRAIT(being_buckled, TRAIT_RESTRAINED))
		return ..()

	if(being_buckled == buckler)
		being_buckled.visible_message(
			span_notice("[buckler]坐到了[src]上。"),
			span_notice("你坐到了[src]上。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
	else
		being_buckled.visible_message(
			span_notice("[buckler]把[being_buckled]按到[src]上坐下。"),
			span_notice("[buckler]把你按到[src]上坐下。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

/obj/structure/chair/unbuckle_feedback(mob/living/being_unbuckled, mob/unbuckler)
	if(HAS_TRAIT(being_unbuckled, TRAIT_RESTRAINED))
		return ..()

	if(being_unbuckled == unbuckler)
		being_unbuckled.visible_message(
			span_notice("[unbuckler]从[src]上站了起来。"),
			span_notice("你从[src]上站了起来。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
	else
		being_unbuckled.visible_message(
			span_notice("[unbuckler]把[being_unbuckled]从[src]上扶了起来。"),
			span_notice("[unbuckler]把你从[src]上扶了起来。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

/obj/structure/chair/examine(mob/user)
	. = ..()
	. += span_notice("它靠几颗<b>螺栓</b>固定在一起。")
	if(!has_buckled_mobs() && can_buckle)
		. += span_notice("站在[src]上时，把你的角色图标拖放到[src]上即可系上。")

///This proc adds the rotate component, overwrite this if you for some reason want to change some specific args.
/obj/structure/chair/proc/MakeRotate()
	AddElement(/datum/element/simple_rotation, ROTATION_IGNORE_ANCHORED|ROTATION_GHOSTS_ALLOWED)

/obj/structure/chair/Destroy()
	SSjob.latejoin_trackers -= src //These may be here due to the arrivals shuttle
	return ..()

/obj/structure/chair/atom_deconstruct(disassembled)
	if(buildstacktype)
		new buildstacktype(loc,buildstackamount)
	else
		for(var/datum/material/mat as anything in custom_materials)
			new mat.sheet_type(loc, FLOOR(custom_materials[mat] / SHEET_MATERIAL_AMOUNT, 1))

/obj/structure/chair/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/chair/narsie_act()
	var/obj/structure/chair/wood/W = new/obj/structure/chair/wood(get_turf(src))
	W.setDir(dir)
	qdel(src)

/obj/structure/chair/attackby(obj/item/W, mob/user, list/modifiers, list/attack_modifiers)
	if(istype(W, /obj/item/assembly/shock_kit) && !HAS_TRAIT(src, TRAIT_ELECTRIFIED_BUCKLE))
		electrify_self(W, user)
		return
	. = ..()

/obj/structure/chair/update_overlays()
	. = ..()
	if (!has_buckled_mobs())
		return
	var/mutable_appearance/armrest = mutable_appearance(icon, "[icon_state]_armrest", ABOVE_MOB_LAYER, src, appearance_flags = KEEP_APART)
	var/mutable_appearance/armrest_blocker = emissive_blocker(icon, "[icon_state]_armrest", src, ABOVE_MOB_LAYER)
	if (cached_color_filter)
		armrest = filter_appearance_recursive(armrest, cached_color_filter)
	. += armrest
	. += armrest_blocker

///allows each chair to request the electrified_buckle component with overlays that dont look ridiculous
/obj/structure/chair/proc/electrify_self(obj/item/assembly/shock_kit/input_shock_kit, mob/user, list/overlays_from_child_procs)
	SHOULD_CALL_PARENT(TRUE)
	if(!user.temporarilyRemoveItemFromInventory(input_shock_kit))
		return
	if(!overlays_from_child_procs || overlays_from_child_procs.len == 0)
		var/mutable_appearance/echair_overlay = mutable_appearance('icons/obj/chairs.dmi', "echair_over", OBJ_LAYER, src, appearance_flags = KEEP_APART)
		AddComponent(/datum/component/electrified_buckle, (SHOCK_REQUIREMENT_ITEM | SHOCK_REQUIREMENT_LIVE_CABLE | SHOCK_REQUIREMENT_SIGNAL_RECEIVED_TOGGLE), input_shock_kit, list(echair_overlay), FALSE)
	else
		AddComponent(/datum/component/electrified_buckle, (SHOCK_REQUIREMENT_ITEM | SHOCK_REQUIREMENT_LIVE_CABLE | SHOCK_REQUIREMENT_SIGNAL_RECEIVED_TOGGLE), input_shock_kit, overlays_from_child_procs, FALSE)

	if(HAS_TRAIT(src, TRAIT_ELECTRIFIED_BUCKLE))
		to_chat(user, span_notice("你把电击组件连接到[src]上，使其带电了 "))
	else
		user.put_in_active_hand(input_shock_kit)
		to_chat(user, span_notice("你无法把电击组件安装到[src]上！"))


/obj/structure/chair/wrench_act_secondary(mob/living/user, obj/item/weapon)
	..()
	weapon.play_tool_sound(src)
	deconstruct(disassembled = TRUE)
	return TRUE

/obj/structure/chair/attack_tk(mob/user)
	if(!anchored || has_buckled_mobs() || !isturf(user.loc))
		return ..()
	setDir(turn(dir,-90))
	return COMPONENT_CANCEL_ATTACK_CHAIN


/obj/structure/chair/proc/handle_rotation(direction)
	handle_layer()
	if(has_buckled_mobs())
		for(var/m in buckled_mobs)
			var/mob/living/buckled_mob = m
			buckled_mob.setDir(direction)

/obj/structure/chair/proc/handle_layer()
	if(has_buckled_mobs() && dir == NORTH)
		layer = ABOVE_MOB_LAYER
	else
		layer = OBJ_LAYER

/obj/structure/chair/post_buckle_mob(mob/living/M)
	. = ..()
	handle_layer()
	//SKYRAT EDIT ADDITION
	if(HAS_TRAIT(M, TRAIT_OVERSIZED) || HAS_TRAIT(M, TRAIT_NO_VEHICLE))
		visible_message(span_warning("[src]在[M]的重量下变形断裂！"))
		playsound(src, 'modular_skyrat/modules/oversized/sound/chair_break.ogg', 70, TRUE)
		deconstruct()
	//SKYRAT EDIT END
	if (has_armrest)
		update_appearance()

/obj/structure/chair/post_unbuckle_mob()
	. = ..()
	handle_layer()
	if (has_armrest)
		update_appearance()

/obj/structure/chair/setDir(newdir)
	..()
	handle_rotation(newdir)

// Chair types

///Material chair
/obj/structure/chair/greyscale
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	item_chair = /obj/item/chair/greyscale
	buildstacktype = null //Custom mats handle this


/obj/structure/chair/wood
	icon_state = "wooden_chair"
	name = "木椅"
	desc = "老旧的东西也永远不会过时。"
	resistance_flags = FLAMMABLE
	max_integrity = 40
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 3
	item_chair = /obj/item/chair/wood
	fishing_modifier = -6
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 3)

/obj/structure/chair/wood/narsie_act()
	return

/obj/structure/chair/wood/wings
	icon_state = "wooden_chair_wings"
	item_chair = /obj/item/chair/wood/wings

/obj/structure/chair/comfy
	name = "舒适椅子"
	desc = "看起来挺舒服。"
	icon_state = "comfychair"
	color = rgb(255, 255, 255)
	resistance_flags = FLAMMABLE
	max_integrity = 70
	buildstackamount = 2
	item_chair = null
	fishing_modifier = -7
	has_armrest = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/chair/comfy/brown
	color = rgb(70, 47, 28)

/obj/structure/chair/comfy/beige
	color = rgb(240, 238, 198)

/obj/structure/chair/comfy/teal
	color = rgb(117, 214, 214)

/obj/structure/chair/comfy/black
	color = rgb(61, 60, 56)

/obj/structure/chair/comfy/lime
	color = rgb(193, 248, 104)

/obj/structure/chair/comfy/shuttle
	name = "穿梭机座椅"
	desc = "一张舒适而稳固的座椅。它的固定带系统看起来更结实，适合更平稳的飞行。"
	icon_state = "shuttle_chair"
	buildstacktype = /obj/item/stack/sheet/mineral/titanium
	buckle_sound = SFX_SEATBELT_BUCKLE
	unbuckle_sound = SFX_SEATBELT_UNBUCKLE
	resistance_flags = FIRE_PROOF
	max_integrity = 120
	custom_materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/chair/comfy/shuttle/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/structure/chair/comfy/shuttle/electrify_self(obj/item/assembly/shock_kit/input_shock_kit, mob/user, list/overlays_from_child_procs)
	if(!overlays_from_child_procs)
		var/mutable_appearance/echair_overlay = mutable_appearance('icons/obj/chairs.dmi', "echair_over", OBJ_LAYER, src, appearance_flags = KEEP_APART)
		echair_overlay.pixel_x = -1
		overlays_from_child_procs = list(echair_overlay)
	. = ..()

/obj/structure/chair/comfy/shuttle/buckle_feedback(mob/living/being_buckled, mob/buckler)
	if(being_buckled == buckler)
		being_buckled.visible_message(
			span_notice("[buckler]坐到[src]上，拉下头顶的固定带把自己固定好。"),
			span_notice("你坐到[src]上，拉下头顶的固定带把自己固定好。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
	else
		being_buckled.visible_message(
			span_notice("[buckler]把[being_buckled]按到[src]上坐下，拉下头顶的固定带把对方固定好。"),
			span_notice("[buckler]把你按到[src]上坐下，拉下头顶的固定带把你固定好。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

/obj/structure/chair/comfy/shuttle/unbuckle_feedback(mob/living/being_unbuckled, mob/unbuckler)
	if(being_unbuckled == unbuckler)
		being_unbuckled.visible_message(
			span_notice("[unbuckler]掀起头顶的固定带，从[src]上站了起来。"),
			span_notice("你掀起头顶的固定带，从[src]上站了起来。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
	else
		being_unbuckled.visible_message(
			span_notice("[unbuckler]掀起头顶的固定带，把[being_unbuckled]从[src]上扶了起来。"),
			span_notice("[unbuckler]掀起头顶的固定带，把你从[src]上扶了起来。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

/obj/structure/chair/comfy/shuttle/update_overlays()
	. = ..()
	if(has_buckled_mobs())
		. += mutable_appearance(icon, "[icon_state]_down_front", ABOVE_MOB_LAYER + 0.01)
		. += mutable_appearance(icon, "[icon_state]_down_behind", src.layer + 0.01)
	else
		. += mutable_appearance(icon, "[icon_state]_up", src.layer + 0.01)

/obj/structure/chair/comfy/shuttle/tactical
	name = "战术座椅"

/obj/structure/chair/comfy/carp
	name = "鲤鱼皮椅"
	desc = "一张豪华的椅子，众多紫色鳞片以极为悦目的方式反射着光线。"
	icon_state = "carp_chair"
	buildstacktype = /obj/item/stack/sheet/animalhide/carp
	fishing_modifier = -12
	custom_materials = null

/obj/structure/chair/office
	name = "办公椅"
	anchored = FALSE
	buildstackamount = 5
	item_chair = null
	fishing_modifier = -6
	icon_state = "officechair_dark"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)

/obj/structure/chair/office/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/noisy_movement)

/obj/structure/chair/office/electrify_self(obj/item/assembly/shock_kit/input_shock_kit, mob/user, list/overlays_from_child_procs)
	if(!overlays_from_child_procs)
		var/mutable_appearance/echair_overlay = mutable_appearance('icons/obj/chairs.dmi', "echair_over", OBJ_LAYER, src, appearance_flags = KEEP_APART)
		echair_overlay.pixel_x = -1
		overlays_from_child_procs = list(echair_overlay)
	. = ..()

/obj/structure/chair/office/tactical
	name = "战术转椅"
	fishing_modifier = -10

/obj/structure/chair/office/light
	name = "办公椅"
	icon_state = "officechair_white"

//Stool

/obj/structure/chair/stool
	name = "凳子"
	desc = "把屁股放上去。"
	icon_state = "stool"
	buildstackamount = 1
	item_chair = /obj/item/chair/stool
	max_integrity = 300

/obj/structure/chair/stool/post_buckle_mob(mob/living/Mob)
	Mob.add_offsets(type, z_add = 4)
	. = ..()

/obj/structure/chair/stool/post_unbuckle_mob(mob/living/Mob)
	Mob.remove_offsets(type)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/stool, 0)

/obj/structure/chair/stool/narsie_act()
	return

/obj/structure/chair/mouse_drop_dragged(atom/over_object, mob/user, src_location, over_location, params)
	if(!isliving(user) || over_object != user)
		return
	if(!item_chair || has_buckled_mobs())
		return
	if(flags_1 & HOLOGRAM_1)
		to_chat(user, span_notice("你试图拿起[src]，但它消散了！"))
		qdel(src)
		return

	user.visible_message(span_notice("[user]抓住了[src.name]。"), span_notice("你抓住了[src.name]。"))
	var/obj/item/chair_item = new item_chair(loc)
	chair_item.set_custom_materials(custom_materials)
	TransferComponents(chair_item)
	chair_item.update_integrity(get_integrity())
	user.put_in_hands(chair_item)
	qdel(src)

/obj/structure/chair/user_buckle_mob(mob/living/M, mob/user, check_loc = TRUE)
	return ..()

/obj/structure/chair/stool/bar
	name = "吧台凳"
	desc = "上面有些不太体面的污渍……"
	icon_state = "bar"
	item_chair = /obj/item/chair/stool/bar

/obj/structure/chair/stool/bar/post_buckle_mob(mob/living/Mob)
	. = ..()
	Mob.add_offsets(type, z_add = 7)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/stool/bar, 0)

/obj/structure/chair/stool/bamboo
	name = "竹凳"
	desc = "一张做工简易、带着乡村风格的竹凳。"
	icon_state = "bamboo_stool"
	resistance_flags = FLAMMABLE
	max_integrity = 40
	buildstacktype = /obj/item/stack/sheet/mineral/bamboo
	buildstackamount = 2
	item_chair = /obj/item/chair/stool/bamboo
	custom_materials = list(/datum/material/bamboo = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/chair
	name = "椅子"
	desc = "酒吧斗殴必备。"
	icon = 'icons/obj/chairs.dmi'
	icon_state = "chair_toppled"
	inhand_icon_state = "chair"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/items/chairs_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/chairs_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 8
	throwforce = 10
	demolition_mod = 1.25
	throw_range = 3
	max_integrity = 100
	hitsound = 'sound/items/trayhit/trayhit1.ogg'
	hit_reaction_chance = 50
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	item_flags = SKIP_FANTASY_ON_SPAWN

	// Duration of daze inflicted when the chair is smashed against someone from behind.
	var/daze_amount = 3 SECONDS

	// What structure type does this chair become when placed?
	var/obj/structure/chair/origin_type = /obj/structure/chair

/obj/item/chair/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item)

/obj/item/chair/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始用[src]猛砸自己！看起来是想自杀！"))
	playsound(src,hitsound,50,TRUE)
	return BRUTELOSS

/obj/item/chair/narsie_act()
	var/obj/item/chair/wood/W = new/obj/item/chair/wood(get_turf(src))
	W.setDir(dir)
	qdel(src)

/obj/item/chair/attack_self(mob/user)
	plant(user)

/obj/item/chair/proc/plant(mob/user)
	var/turf/turf = user.loc
	if(!istype(turf) || isgroundlessturf(turf))
		to_chat(user, span_warning("你需要有地面才能把它放下！"))
		return
	if(!user.dropItemToGround(src))
		to_chat(user, span_warning("[src]粘在你手上了！"))
		return
	if(flags_1 & HOLOGRAM_1)
		to_chat(user, span_notice("你试图放下[src]，但它消散了！"))
		qdel(src)
		return

	for(var/obj/object in turf)
		if(istype(object, /obj/structure/chair))
			to_chat(user, span_warning("这里已经有一把椅子了！"))
			return
		if(object.density && !(object.flags_1 & ON_BORDER_1))
			to_chat(user, span_warning("这里已经有东西了！"))
			return

	user.visible_message(span_notice("[user]把[src.name]扶正了。"), span_notice("你把[name]扶正了。"))
	var/obj/structure/chair/chair = new origin_type(turf)
	chair.set_custom_materials(custom_materials)
	TransferComponents(chair)
	chair.setDir(user.dir)
	chair.update_integrity(get_integrity())
	qdel(src)

/obj/item/chair/proc/smash(mob/living/user)
	var/stack_type = initial(origin_type.buildstacktype)
	if(!stack_type)
		return
	var/remaining_mats = initial(origin_type.buildstackamount)
	remaining_mats-- //Part of the chair was rendered completely unusable. It magically disappears. Maybe make some dirt?
	if(remaining_mats)
		for(var/M=1 to remaining_mats)
			new stack_type(get_turf(loc))
	else if(custom_materials[SSmaterials.get_material(/datum/material/iron)])
		new /obj/item/stack/rods(get_turf(loc), 2)
	qdel(src)

/obj/item/chair/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == UNARMED_ATTACK && prob(hit_reaction_chance) || attack_type == LEAP_ATTACK && prob(hit_reaction_chance))
		owner.visible_message(span_danger("[owner]用[src]挡下了[attack_text]！"))
		if(take_chair_damage(damage, damage_type, MELEE)) // Our chair takes our incoming damage for us, which can result in it smashing.
			smash(owner)
		return TRUE
	return FALSE

/obj/item/chair/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(!ishuman(target))
		return

	var/mob/living/carbon/human/give_this_fucker_the_chair = target

	// Here we determine if our attack is against a vulnerable target
	var/vulnerable_hit = check_behind(user, give_this_fucker_the_chair)

	// If our attack is against a vulnerable target, we do additional damage to the chair
	var/damage_to_inflict = vulnerable_hit ? (force * 5) : (force * 2.5)

	if(!take_chair_damage(damage_to_inflict, damtype, MELEE)) // If we would do enough damage to bring our chair's integrity to 0, we instead go past the check to smash it against our target
		return

	user.visible_message(span_danger("[user]把[src]在[give_this_fucker_the_chair]身上砸得粉碎"))
	if(!HAS_TRAIT(give_this_fucker_the_chair, TRAIT_BRAWLING_KNOCKDOWN_BLOCKED))
		if(vulnerable_hit || give_this_fucker_the_chair.get_timed_status_effect_duration(/datum/status_effect/staggered))
			give_this_fucker_the_chair.Knockdown(2 SECONDS, daze_amount = daze_amount)
			if(give_this_fucker_the_chair.health < give_this_fucker_the_chair.maxHealth*0.5)
				give_this_fucker_the_chair.adjust_confusion(10 SECONDS)

	smash(user)

/obj/item/chair/proc/take_chair_damage(damage_to_inflict, damage_type, armor_flag)
	if(damage_to_inflict >= atom_integrity)
		return TRUE
	take_damage(damage_to_inflict, damage_type, armor_flag)
	return FALSE

/obj/item/chair/greyscale
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	origin_type = /obj/structure/chair/greyscale

/obj/item/chair/stool
	name = "凳子"
	icon_state = "stool_toppled"
	inhand_icon_state = "stool"
	origin_type = /obj/structure/chair/stool
	max_integrity = 300 //It's too sturdy.

/obj/item/chair/stool/bar
	name = "吧台凳"
	icon_state = "bar_toppled"
	inhand_icon_state = "stool_bar"
	origin_type = /obj/structure/chair/stool/bar

/obj/item/chair/stool/bamboo
	name = "竹凳"
	icon_state = "bamboo_stool"
	inhand_icon_state = "stool_bamboo"
	hitsound = 'sound/items/weapons/genhit1.ogg'
	origin_type = /obj/structure/chair/stool/bamboo
	max_integrity = 40 //Submissive and breakable unlike the chad iron stool
	daze_amount = 0 //Not hard enough to cause them to become dazed
	custom_materials = list(/datum/material/bamboo = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/chair/stool/narsie_act()
	return //sturdy enough to ignore a god

/obj/item/chair/wood
	name = "木椅"
	icon_state = "wooden_chair_toppled"
	inhand_icon_state = "woodenchair"
	resistance_flags = FLAMMABLE
	max_integrity = 40
	hitsound = 'sound/items/weapons/genhit1.ogg'
	origin_type = /obj/structure/chair/wood
	custom_materials = null
	daze_amount = 0
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 3)

/obj/item/chair/wood/narsie_act()
	return

/obj/item/chair/wood/wings
	icon_state = "wooden_chair_wings_toppled"
	origin_type = /obj/structure/chair/wood/wings

/obj/structure/chair/old
	name = "奇怪的椅子"
	desc = "你坐在这上面。无论是自愿还是被迫。看起来真的非常不舒服。"
	icon_state = "chairold"
	item_chair = null
	fishing_modifier = 4

/obj/structure/chair/bronze
	name = "黄铜椅"
	desc = "一张青铜制成的旋转椅，轮子是小齿轮！"
	anchored = FALSE
	icon_state = "brass_chair"
	buildstacktype = /obj/item/stack/sheet/bronze
	buildstackamount = 1
	item_chair = null
	fishing_modifier = -13 //the pinnacle of Ratvarian technology.
	has_armrest = TRUE
	custom_materials = list(/datum/material/bronze = SHEET_MATERIAL_AMOUNT)
	/// Total rotations made
	var/turns = 0

/obj/structure/chair/bronze/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/noisy_movement, 'sound/machines/clockcult/integration_cog_install.ogg', 50)

/obj/structure/chair/bronze/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	. = ..()

/obj/structure/chair/bronze/process()
	setDir(turn(dir,-90))
	playsound(src, 'sound/effects/servostep.ogg', 50, FALSE)
	turns++
	if(turns >= 8)
		STOP_PROCESSING(SSfastprocess, src)

/obj/structure/chair/bronze/MakeRotate()
	return

/obj/structure/chair/bronze/click_alt(mob/user)
	turns = 0
	if(!(datum_flags & DF_ISPROCESSING))
		user.visible_message(span_notice("[user]把[src]转了起来，拉特瓦科技最后的残余让它永远转下去。"), \
		span_notice("自动旋转椅。古代拉特瓦科技的巅峰之作。"))
		START_PROCESSING(SSfastprocess, src)
	else
		user.visible_message(span_notice("[user]让[src]停止了失控的旋转。"), \
		span_notice("你抓住[src]，止住了它狂野的旋转。"))
		STOP_PROCESSING(SSfastprocess, src)
	return CLICK_ACTION_SUCCESS

/obj/structure/chair/mime
	name = "隐形椅子"
	desc = "默剧演员需要坐下来闭嘴。"
	anchored = FALSE
	icon_state = null
	buildstacktype = null
	item_chair = null
	obj_flags = parent_type::obj_flags | NO_DEBRIS_AFTER_DECONSTRUCTION
	alpha = 0
	fishing_modifier = -21 //it only lives for 25 seconds, so we make them worth it.
	custom_materials = null

/obj/structure/chair/mime/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/tool_blocker, TOOL_WRENCH, TOOL_ACT_SECONDARY)

/obj/structure/chair/mime/post_buckle_mob(mob/living/M)
	M.add_offsets(type, z_add = 5)

/obj/structure/chair/mime/post_unbuckle_mob(mob/living/M)
	M.remove_offsets(type)

/obj/structure/chair/plastic
	icon_state = "plastic_chair"
	name = "折叠塑料椅"
	desc = "不管你怎样扭动，它都不会舒服。"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2)
	buildstacktype = /obj/item/stack/sheet/plastic
	buildstackamount = 2
	item_chair = /obj/item/chair/plastic
	fishing_modifier = -10

/obj/structure/chair/plastic/post_buckle_mob(mob/living/Mob)
	Mob.add_offsets(type, z_add = 2)
	. = ..()
	if(iscarbon(Mob))
		INVOKE_ASYNC(src, PROC_REF(snap_check), Mob)

/obj/structure/chair/plastic/post_unbuckle_mob(mob/living/Mob)
	Mob.remove_offsets(type)

/obj/structure/chair/plastic/proc/snap_check(mob/living/carbon/Mob)
	if (Mob.nutrition >= NUTRITION_LEVEL_FAT)
		to_chat(Mob, span_warning("椅子开始咯吱作响，你太重了！"))
		if(do_after(Mob, 6 SECONDS, show_progress = FALSE))
			Mob.visible_message(span_notice("塑料椅在[Mob]的重量下断裂了！"))
			new /obj/effect/decal/cleanable/plastic(loc)
			qdel(src)

/obj/item/chair/plastic
	name = "折叠塑料椅"
	desc = "不知为何，你总能在摔角擂台下面找到一把。"
	icon = 'icons/obj/chairs.dmi'
	icon_state = "folded_chair"
	inhand_icon_state = "folded_chair"
	lefthand_file = 'icons/mob/inhands/items/chairs_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/chairs_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	force = 7
	throw_range = 5 //Lighter Weight --> Flies Farther.
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2)
	max_integrity = 70
	daze_amount = 0
	origin_type = /obj/structure/chair/plastic

/obj/structure/chair/musical
	name = "音乐椅"
	desc = "你听着它。无论是自愿还是被迫。"
	item_chair = /obj/item/chair/musical
	particles = new /particles/musical_notes

/obj/item/chair/musical
	name = "音乐椅"
	desc = "哦，所以这就像那套乱七八糟的大富翁规则——根本没有规则，你可以随意拿起和摆放音乐椅。"
	particles = new /particles/musical_notes
	origin_type = /obj/structure/chair/musical

/obj/structure/handrail
	name = "扶手"
	desc = "抓稳了！"
	icon = 'icons/obj/handrail.dmi'
	icon_state = "handrail"
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = NO_BUCKLE_LYING
	resistance_flags = FIRE_PROOF
	max_integrity = 50
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	layer = OBJ_LAYER

/obj/structure/handrail/attack_hand(mob/living/user, list/modifiers)
	return ..() || mouse_buckle_handling(user, user)

/obj/structure/handrail/is_user_buckle_possible(mob/living/target, mob/user, check_loc = TRUE)
	return ..() && user == target && !HAS_TRAIT(target, TRAIT_HANDS_BLOCKED)

/obj/structure/handrail/post_buckle_mob(mob/living/buckled_mob)
	RegisterSignal(buckled_mob, SIGNAL_ADDTRAIT(TRAIT_HANDS_BLOCKED), PROC_REF(stop_buckle))

	var/z_offset = 0
	var/w_offset = 0
	if(dir & NORTH)
		z_offset = -4
	else if(dir & SOUTH)
		z_offset = 8
	if(dir & EAST)
		w_offset = -8
	else if(dir & WEST)
		w_offset = 8

	buckled_mob.add_offsets(type, z_add = z_offset, w_add = w_offset)

/obj/structure/handrail/post_unbuckle_mob(mob/living/unbuckled_mob)
	UnregisterSignal(unbuckled_mob, SIGNAL_ADDTRAIT(TRAIT_HANDS_BLOCKED))
	unbuckled_mob.remove_offsets(type)

/obj/structure/handrail/proc/stop_buckle(mob/living/source, ...)
	SIGNAL_HANDLER
	source.visible_message(
		span_warning("[source]失去了对[src]的抓握！"),
		span_warning("你失去了对[src]的抓握！"),
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		vision_distance = COMBAT_MESSAGE_RANGE,
	)
	unbuckle_mob(source, TRUE, TRUE)

/obj/structure/handrail/buckle_feedback(mob/living/being_buckled, mob/buckler)
	buckler.visible_message(
		span_notice("[buckler]紧紧抓住[src]，让自己保持直立。"),
		span_notice("你紧紧抓住[src]，让自己保持直立。"),
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		vision_distance = COMBAT_MESSAGE_RANGE,
	)

/obj/structure/handrail/unbuckle_feedback(mob/living/being_unbuckled, mob/unbuckler)
	if(being_unbuckled == unbuckler)
		being_unbuckled.visible_message(
			span_notice("[unbuckler]松开了[src]。"),
			span_notice("你松开了[src]。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			vision_distance = COMBAT_MESSAGE_RANGE,
		)
	else
		being_unbuckled.visible_message(
			span_warning("[unbuckler]迫使[being_unbuckled]松开了[src]！"),
			span_warning("[unbuckler]迫使你松开了[src]！"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			vision_distance = COMBAT_MESSAGE_RANGE,
		)
