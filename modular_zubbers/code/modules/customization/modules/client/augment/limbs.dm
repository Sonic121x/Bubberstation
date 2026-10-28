/datum/augment_item/limb
	category = AUGMENT_CATEGORY_LIMBS
	allowed_biotypes = MOB_ORGANIC|MOB_ROBOTIC
	///Hardcoded styles that can be chosen from and apply to limb, if it's true
	var/uses_robotic_styles = TRUE
	///Should we draw these greyscale?
	var/uses_greyscale = FALSE
	///Used for legs - if it has a digitigrade sprite variant, set to TRUE.
	var/supports_digitigrade = FALSE

/datum/augment_item/limb/apply(mob/living/carbon/human/augmented, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup)
		//Cheaply "faking" the appearance of the prosthetic. Species code sets this back if it doesnt exist anymore
		var/obj/item/bodypart/new_limb = path
		var/body_zone = initial(new_limb.body_zone)
		var/obj/item/bodypart/old_limb = augmented.get_bodypart(body_zone)

		old_limb.limb_id = initial(new_limb.limb_id)
		old_limb.base_limb_id = initial(new_limb.limb_id)
		old_limb.is_dimorphic = initial(new_limb.is_dimorphic)

		if(uses_robotic_styles && prefs.augment_limb_styles[slot])
			var/datum/robotic_style/chosen_style = GLOB.robotic_styles_list[prefs.augment_limb_styles[slot]]
			old_limb.current_style = prefs.augment_limb_styles[slot]
			var/dimorphic_override = LAZYACCESS(chosen_style.dimorphic_overrides, old_limb.body_zone)
			if(!isnull(dimorphic_override))
				old_limb.is_dimorphic = dimorphic_override
			if(chosen_style.limb_id_override)
				old_limb.limb_id = chosen_style.limb_id_override
			if(!uses_greyscale)
				old_limb.set_icon_static(chosen_style.icon)
			else
				old_limb.set_icon_greyscale(chosen_style.icon)
		else
			if(!uses_greyscale)
				old_limb.set_icon_static(initial(new_limb.icon))
			else
				old_limb.set_icon_greyscale(UNLINT(initial(new_limb.icon_greyscale))) // stupid var_protected memes
		old_limb.should_draw_greyscale = uses_greyscale
			//old_limb.set_icon_static(initial(new_limb.icon))
		//old_limb.should_draw_greyscale = FALSE

		return body_zone
	else
		var/obj/item/bodypart/new_limb = new path(augmented)
		var/obj/item/bodypart/old_limb = augmented.get_bodypart(new_limb.body_zone)
		if(uses_robotic_styles && prefs.augment_limb_styles[slot])
			var/datum/robotic_style/chosen_style = GLOB.robotic_styles_list[prefs.augment_limb_styles[slot]] // Shit's fucked. Start testing on spawn?
			new_limb.current_style = prefs.augment_limb_styles[slot]
			var/dimorphic_override = LAZYACCESS(chosen_style.dimorphic_overrides, new_limb.body_zone)
			if(!isnull(dimorphic_override))
				new_limb.is_dimorphic = dimorphic_override
			if(chosen_style.limb_id_override)
				new_limb.limb_id = chosen_style.limb_id_override
			if(!uses_greyscale)
				new_limb.set_icon_static(chosen_style.icon)
			else
				new_limb.set_icon_greyscale(chosen_style.icon)
		if(supports_digitigrade == TRUE && old_limb.limb_id == BODYPART_ID_DIGITIGRADE)
			new_limb.limb_id = BODYPART_ID_DIGITIGRADE
			new_limb.base_limb_id = BODYPART_ID_DIGITIGRADE
			new_limb.bodyshape = old_limb.bodyshape

		new_limb.replace_limb(augmented)
		qdel(old_limb)

//HEADS
/datum/augment_item/limb/head
	slot = AUGMENT_SLOT_HEAD

/datum/augment_item/limb/head/cyborg
	name = "半机械人头"
	path = /obj/item/bodypart/head/robot/weak

/datum/augment_item/limb/head/cyborg/greyscale
	uses_greyscale = TRUE
	name = "半机械人头（灰度）"
	path = /obj/item/bodypart/head/robot/weak/greyscale

//CHESTS
/datum/augment_item/limb/chest
	slot = AUGMENT_SLOT_CHEST

/datum/augment_item/limb/chest/cyborg
	name = "半机械人躯干"
	path = /obj/item/bodypart/chest/robot/weak

/datum/augment_item/limb/chest/cyborg/greyscale
	uses_greyscale = TRUE
	name = "半机械人躯干（灰度）"
	path = /obj/item/bodypart/chest/robot/weak/greyscale

//LEFT ARMS
/datum/augment_item/limb/l_arm
	slot = AUGMENT_SLOT_L_ARM

/datum/augment_item/limb/l_arm/prosthetic
	name = "廉价义体左臂"
	path = /obj/item/bodypart/arm/left/robot/surplus
	cost = -1

/datum/augment_item/limb/l_arm/prosthetic/greyscale
	uses_greyscale = TRUE
	name = "廉价义体左臂（灰度）"
	path = /obj/item/bodypart/arm/left/robot/surplus/greyscale
	cost = -1

/datum/augment_item/limb/l_arm/kinetic
	name = "动能义体左臂"
	path = /obj/item/bodypart/arm/left/kinetic
	cost = -2
	uses_robotic_styles = FALSE

/datum/augment_item/limb/l_arm/peg
	name = "左木桩臂"
	path = /obj/item/bodypart/arm/left/ghetto
	cost = -3
	uses_robotic_styles = FALSE

/datum/augment_item/limb/l_arm/cyborg
	name = "半机械人左臂"
	path = /obj/item/bodypart/arm/left/robot/weak

/datum/augment_item/limb/l_arm/cyborg/greyscale
	uses_greyscale = TRUE
	name = "半机械人左臂（灰度）"
	path = /obj/item/bodypart/arm/left/robot/weak/greyscale

/datum/augment_item/limb/l_arm/plasmaman
	name = "等离子人左臂"
	path = /obj/item/bodypart/arm/left/plasmaman
	uses_robotic_styles = FALSE

/datum/augment_item/limb/l_arm/self_destruct
	name = "无左臂"
	path = /obj/item/bodypart/arm/left/self_destruct
	cost = -3
	uses_robotic_styles = FALSE

//RIGHT ARMS
/datum/augment_item/limb/r_arm
	slot = AUGMENT_SLOT_R_ARM

/datum/augment_item/limb/r_arm/prosthetic
	name = "廉价义体右臂"
	path = /obj/item/bodypart/arm/right/robot/surplus
	cost = -1

/datum/augment_item/limb/r_arm/prosthetic/greyscale
	uses_greyscale = TRUE
	name = "廉价义体右臂（灰度）"
	path = /obj/item/bodypart/arm/right/robot/surplus/greyscale
	cost = -1

/datum/augment_item/limb/r_arm/kinetic
	name = "动能义体右臂"
	path = /obj/item/bodypart/arm/right/kinetic
	cost = -2
	uses_robotic_styles = FALSE

/datum/augment_item/limb/r_arm/peg
	name = "右木桩臂"
	path = /obj/item/bodypart/arm/right/ghetto
	cost = -3
	uses_robotic_styles = FALSE

/datum/augment_item/limb/r_arm/cyborg
	name = "半机械人右臂"
	path = /obj/item/bodypart/arm/right/robot/weak

/datum/augment_item/limb/r_arm/cyborg/greyscale
	uses_greyscale = TRUE
	name = "半机械人右臂（灰度）"
	path = /obj/item/bodypart/arm/right/robot/weak/greyscale

/datum/augment_item/limb/r_arm/plasmaman
	name = "等离子人右臂"
	path = /obj/item/bodypart/arm/right/plasmaman
	uses_robotic_styles = FALSE

/datum/augment_item/limb/r_arm/self_destruct
	name = "无右臂"
	path = /obj/item/bodypart/arm/right/self_destruct
	cost = -3
	uses_robotic_styles = FALSE

//LEFT LEGS
/datum/augment_item/limb/l_leg
	slot = AUGMENT_SLOT_L_LEG

/datum/augment_item/limb/l_leg/prosthetic
	name = "廉价义体左腿"
	path = /obj/item/bodypart/leg/left/robot/surplus
	cost = -1

/datum/augment_item/limb/l_leg/prosthetic/greyscale
	uses_greyscale = TRUE
	name = "廉价义体左腿（灰度）"
	supports_digitigrade = TRUE
	path = /obj/item/bodypart/leg/left/robot/surplus/greyscale
	cost = -1

/datum/augment_item/limb/l_leg/kinetic
	name = "动能义体左腿"
	path = /obj/item/bodypart/leg/left/kinetic
	cost = -2
	uses_robotic_styles = FALSE

/datum/augment_item/limb/l_leg/peg
	name = "左木桩腿"
	path = /obj/item/bodypart/leg/left/ghetto
	cost = -3

/datum/augment_item/limb/l_leg/cyborg
	name = "半机械人左腿"
	path = /obj/item/bodypart/leg/left/robot/weak

/datum/augment_item/limb/l_leg/cyborg/greyscale
	uses_greyscale = TRUE
	supports_digitigrade = TRUE
	name = "半机械人左腿（灰度）"
	path = /obj/item/bodypart/leg/left/robot/weak/greyscale

/datum/augment_item/limb/l_leg/plasmaman
	name = "等离子人左腿"
	path = /obj/item/bodypart/leg/left/plasmaman
	uses_robotic_styles = FALSE

/datum/augment_item/limb/l_leg/self_destruct
	name = "无左腿"
	path = /obj/item/bodypart/leg/left/self_destruct
	cost = -3
	uses_robotic_styles = FALSE

//RIGHT LEGS
/datum/augment_item/limb/r_leg
	slot = AUGMENT_SLOT_R_LEG

/datum/augment_item/limb/r_leg/prosthetic
	name = "廉价义体右腿"
	path = /obj/item/bodypart/leg/right/robot/surplus
	cost = -1

/datum/augment_item/limb/r_leg/prosthetic/greyscale
	uses_greyscale = TRUE
	supports_digitigrade = TRUE
	name = "廉价义体右腿（灰度）"
	path = /obj/item/bodypart/leg/right/robot/surplus/greyscale
	cost = -1

/datum/augment_item/limb/r_leg/kinetic
	name = "动能义体右腿"
	path = /obj/item/bodypart/leg/right/kinetic
	cost = -2
	uses_robotic_styles = FALSE

/datum/augment_item/limb/r_leg/peg
	name = "右木桩腿"
	path = /obj/item/bodypart/leg/right/ghetto
	cost = -3

/datum/augment_item/limb/r_leg/cyborg
	name = "半机械人右腿"
	path = /obj/item/bodypart/leg/right/robot/weak

/datum/augment_item/limb/r_leg/cyborg/greyscale
	uses_greyscale = TRUE
	supports_digitigrade = TRUE
	name = "半机械人右腿（灰度）"
	path = /obj/item/bodypart/leg/right/robot/weak/greyscale

/datum/augment_item/limb/r_leg/plasmaman
	name = "等离子人右腿"
	path = /obj/item/bodypart/leg/right/plasmaman
	uses_robotic_styles = FALSE

/datum/augment_item/limb/r_leg/self_destruct
	name = "无右腿"
	path = /obj/item/bodypart/leg/right/self_destruct
	cost = -3
	uses_robotic_styles = FALSE
