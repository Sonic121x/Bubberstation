//Glasses
/obj/item/clothing/glasses
	name = "眼镜"
	icon = 'icons/obj/clothing/glasses.dmi'
	lefthand_file = 'icons/mob/inhands/clothing/glasses_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/glasses_righthand.dmi'
	abstract_type = /obj/item/clothing/glasses
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_EYES
	strip_delay = 2 SECONDS
	equip_delay_other = 2.5 SECONDS
	resistance_flags = NONE
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT*2.5)
	gender = PLURAL
	sound_vary = TRUE
	pickup_sound = SFX_GLASSES_PICKUP
	drop_sound = SFX_GLASSES_DROP
	equip_sound = SFX_GLASSES_EQUIP
	var/vision_flags = 0
	var/invis_view = SEE_INVISIBLE_LIVING // Admin only for now
	/// Override to allow glasses to set higher than normal see_invis
	var/invis_override = 0
	/// A percentage of how much rgb to "max" on the lighting plane
	/// This lets us brighten darkness without washing out bright color
	var/lighting_cutoff = null
	/// Similar to lighting_cutoff, except it has individual r g and b components in the same 0-100 scale
	var/list/color_cutoffs = null
	/// The current hud icons
	var/list/icon/current = list()
	/// Colors your vision when worn
	var/glass_colour_type
	/// Whether or not vision coloring is forcing
	var/forced_glass_color = FALSE

/obj/item/clothing/glasses/Initialize(mapload)
	. = ..()
	if(glass_colour_type)
		AddElement(/datum/element/wearable_client_colour, glass_colour_type, ITEM_SLOT_EYES, GLASSES_TRAIT, forced = forced_glass_color, comsig_toggle = COMSIG_CLICK_ALT_SECONDARY)

/obj/item/clothing/glasses/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 正把 [src] 刺进自己的眼睛！看起来是想自杀！"))
	return BRUTELOSS

/obj/item/clothing/glasses/visor_toggling()
	. = ..()
	alternate_worn_layer = up ? ABOVE_BODY_FRONT_HEAD_LAYER : initial(alternate_worn_layer) // SKYRAT EDIT CHANGE - ORIGINAL : alternate_worn_layer = up ? ABOVE_BODY_FRONT_HEAD_LAYER : null
	if(visor_vars_to_toggle & VISOR_VISIONFLAGS)
		vision_flags ^= initial(vision_flags)
	if(visor_vars_to_toggle & VISOR_INVISVIEW)
		invis_view ^= initial(invis_view)

/obj/item/clothing/glasses/adjust_visor(mob/living/user)
	. = ..()
	if(. && !user.is_holding(src) && (visor_vars_to_toggle & (VISOR_VISIONFLAGS|VISOR_INVISVIEW)))
		user.update_sight()

/obj/item/clothing/glasses/equipped(mob/living/user, slot)
	. = ..()
	if (!(slot & ITEM_SLOT_EYES))
		return
	RegisterSignal(user, COMSIG_CARBON_UPDATE_SIGHT_CUTOFFS, PROC_REF(update_wearer_sight))
	if (vision_flags || invis_override || invis_view || !isnull(lighting_cutoff))
		user.update_sight()

/obj/item/clothing/glasses/dropped(mob/living/user)
	. = ..()
	UnregisterSignal(user, COMSIG_CARBON_UPDATE_SIGHT_CUTOFFS)
	if (vision_flags || invis_override || invis_view || !isnull(lighting_cutoff))
		user.update_sight()

/obj/item/clothing/glasses/proc/update_wearer_sight(mob/living/carbon/source, list/new_sight_flags)
	SIGNAL_HANDLER

	new_sight_flags[1] |= vision_flags
	if(invis_override)
		source.set_invis_see(invis_override)
	else
		source.set_invis_see(min(invis_view, source.see_invisible))
	if(!isnull(lighting_cutoff))
		source.lighting_cutoff = max(source.lighting_cutoff, lighting_cutoff)
	if(length(color_cutoffs))
		source.lighting_color_cutoffs = blend_cutoff_colors(source.lighting_color_cutoffs, color_cutoffs)

//called when thermal glasses are emped.
/obj/item/clothing/glasses/proc/thermal_overload()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/H = src.loc
		var/obj/item/organ/eyes/eyes = H.get_organ_slot(ORGAN_SLOT_EYES)
		if(!H.is_blind())
			if(H.glasses == src)
				to_chat(H, span_danger("[src] 过载，使你失明！"))
				H.flash_act(visual = 1)
				H.adjust_temp_blindness(6 SECONDS)
				H.set_eye_blur_if_lower(10 SECONDS)
				eyes.apply_organ_damage(5)

/obj/item/clothing/glasses/proc/change_glass_color(new_color_type)
	if(glass_colour_type)
		RemoveElement(/datum/element/wearable_client_colour, glass_colour_type, ITEM_SLOT_EYES, GLASSES_TRAIT, forced = forced_glass_color)
	glass_colour_type = new_color_type
	if(glass_colour_type)
		AddElement(/datum/element/wearable_client_colour, glass_colour_type, ITEM_SLOT_EYES, GLASSES_TRAIT, forced = forced_glass_color)

/obj/item/clothing/glasses/meson
	name = "光学介子扫描仪"
	desc = "供工程与采矿人员使用，可透过墙壁看到基础结构与地形布局，不受光照条件影响。"
	icon_state = "meson"
	inhand_icon_state = "meson"
	clothing_traits = list(TRAIT_MADNESS_IMMUNE)
	flags_cover = GLASSESCOVERSEYES
	vision_flags = SEE_TURFS
	// Mesons get to be lightly green
	color_cutoffs = list(5, 15, 5)
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/clothing/glasses/meson/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 正把 [src] 贴到自己眼前并让亮度过载！看起来是想自杀！"))
	return BRUTELOSS

/obj/item/clothing/glasses/meson/night
	name = "夜视介子扫描仪"
	desc = "装有增强可见光谱叠加层的光学介子扫描仪，在黑暗中提供更清晰的视觉。"
	icon_state = "nvgmeson"
	inhand_icon_state = "nvgmeson"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	// Night vision mesons get the same but more intense
	color_cutoffs = list(10, 35, 10)
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen
	actions_types = list(/datum/action/item_action/toggle_nv)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 3.5)

/obj/item/clothing/glasses/meson/night/update_icon_state()
	. = ..()
	icon_state = length(color_cutoffs) ? initial(icon_state) : "nvgmeson_off"

/obj/item/clothing/glasses/meson/gar
	name = "GAR 介子镜"
	desc = "做不可能的事，看见看不见的东西！"
	icon_state = "gar_meson"
	inhand_icon_state = "gar_meson"
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	force = 10
	throwforce = 10
	throw_speed = 4
	attack_verb_continuous = list("slices")
	attack_verb_simple = list("slice")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/obj/item/clothing/glasses/science
	name = "科研护目镜"
	desc = "一副时髦的护目镜，可防止化学溅射。配有分析仪，可扫描物品与试剂。"
	icon_state = "purple"
	inhand_icon_state = "glasses"
	glass_colour_type = /datum/client_colour/glass_colour/purple
	flags_cover = GLASSESCOVERSEYES
	resistance_flags = ACID_PROOF
	armor_type = /datum/armor/glasses_science
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/datum/armor/glasses_science
	fire = 80
	acid = 100

/obj/item/clothing/glasses/science/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 正把 [src] 的带子勒紧在自己脖子上！看起来是想自杀！"))
	return OXYLOSS

/obj/item/clothing/glasses/science/night
	name = "夜视科研护目镜"
	desc = "让佩戴者能在黑暗中视物，并一眼辨别化合物。"
	icon_state = "scihudnight"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	// Real vivid purple
	color_cutoffs = list(30, 5, 15)
	glass_colour_type = /datum/client_colour/glass_colour/lightpurple
	actions_types = list(/datum/action/item_action/toggle_nv)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 3.5)

/obj/item/clothing/glasses/science/night/update_icon_state()
	. = ..()
	icon_state = length(color_cutoffs) ? initial(icon_state) : "night_off"

/obj/item/clothing/glasses/night
	name = "夜视护目镜"
	desc = "你现在完全能在黑暗中看见了！"
	icon_state = "night"
	inhand_icon_state = "glasses"
	flags_cover = GLASSESCOVERSEYES
	flash_protect = FLASH_PROTECTION_SENSITIVE
	// Dark green
	color_cutoffs = list(10, 25, 10)
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen
	actions_types = list(/datum/action/item_action/toggle_nv)
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 3.5)

/obj/item/clothing/glasses/night/update_icon_state()
	. = ..()
	icon_state = length(color_cutoffs) ? initial(icon_state) : "night_off"

/obj/item/clothing/glasses/eyepatch
	name = "眼罩"
	desc = "呀哈。"
	icon_state = "eyepatch"
	base_icon_state = "eyepatch"
	inhand_icon_state = null
	actions_types = list(/datum/action/item_action/flip)
	dog_fashion = /datum/dog_fashion/head/eyepatch
	var/flipped = FALSE
	pickup_sound = null
	drop_sound = null
	equip_sound = null
	custom_materials = null

/obj/item/clothing/glasses/eyepatch/click_alt(mob/user)
	. = ..()
	flip_eyepatch()

/obj/item/clothing/glasses/eyepatch/attack_self(mob/user)
	. = ..()
	flip_eyepatch()

/obj/item/clothing/glasses/eyepatch/proc/flip_eyepatch()
	flipped = !flipped
	icon_state = flipped ? "[base_icon_state]_flipped" : base_icon_state
	if (!ismob(loc))
		return
	var/mob/user = loc
	user.update_worn_glasses()
	if (!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	if (human_user.get_eye_scars() & (flipped ? RIGHT_EYE_SCAR : LEFT_EYE_SCAR))
		tint = INFINITY
	else
		tint = initial(tint)
	human_user.update_tint()

/obj/item/clothing/glasses/eyepatch/equipped(mob/living/user, slot)
	if (!ishuman(user))
		return ..()
	var/mob/living/carbon/human/human_user = user
	// lol lmao
	if (human_user.get_eye_scars() & (flipped ? RIGHT_EYE_SCAR : LEFT_EYE_SCAR))
		tint = INFINITY
	else
		tint = initial(tint)
	return ..()

/obj/item/clothing/glasses/eyepatch/dropped(mob/living/user)
	. = ..()
	tint = initial(tint)

/obj/item/clothing/glasses/eyepatch/medical
	name = "医疗眼罩"
	desc = "供太空二次元爱好者假装自己那只眼睛还在，也供真正失去眼睛的船员假装眼睛还在。"
	icon_state = "eyepatch_medical"
	base_icon_state = "eyepatch_medical"
	inhand_icon_state = null

/// wizard version
/obj/item/clothing/glasses/eyepatch/medical/chuuni
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/glasses/eyepatch/medical/chuuni/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CASTING_CLOTHING, INNATE_TRAIT)

/obj/item/clothing/glasses/eyepatch/medical/chuuni/equipped(mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_EYES)
		ADD_TRAIT(src, TRAIT_NODROP, type)

/obj/item/clothing/glasses/eyepatch/medical/chuuni/Initialize(mapload)
	. = ..()
	var/static/list/chuuni_backstories
	if(!chuuni_backstories)
		chuuni_backstories = list(
			"这副眼罩是封印魔王力量的印记。一旦我摘下它，就会给世界带来灭顶之灾。",
			"这副眼罩是光之天使的赠礼。它让我得以看清万物的本质，守护无辜者免受伤害。",
			"这副眼罩是我与龙神契约的凭证。它赐予我他古老的智慧与炽热的吐息。",
			"这副眼罩是我为爱牺牲的象征。它遮住了我为拯救挚爱免遭致命一击而留下的伤疤。",
		)
	desc = pick(chuuni_backstories)

/obj/item/clothing/glasses/monocle
	name = "单边眼镜"
	desc = "多么潇洒的镜片！"
	icon_state = "monocle"
	inhand_icon_state = "headset" // lol
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/material
	name = "光学材料扫描仪"
	desc = "非常令人困惑的眼镜。"
	icon_state = "material"
	inhand_icon_state = "glasses"
	flags_cover = GLASSESCOVERSEYES
	vision_flags = SEE_OBJS
	glass_colour_type = /datum/client_colour/glass_colour/lightblue
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP

/obj/item/clothing/glasses/material/mining
	name = "光学材料扫描仪"
	desc = "供矿工探测岩层深处的矿石。"
	icon_state = "material"
	inhand_icon_state = "glasses"

/obj/item/clothing/glasses/material/mining/gar
	name = "GAR 材料扫描仪"
	desc = "做不可能的事，看见看不见的东西！"
	icon_state = "gar_meson"
	inhand_icon_state = "gar_meson"
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	force = 10
	throwforce = 20
	throw_speed = 4
	attack_verb_continuous = list("slices")
	attack_verb_simple = list("slice")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen

/obj/item/clothing/glasses/regular
	name = "处方眼镜"
	desc = "由书呆子公司制造。"
	icon_state = "glasses_regular"
	inhand_icon_state = "glasses"
	flags_cover = GLASSESCOVERSEYES
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/regular/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/knockoff, 25, list(BODY_ZONE_PRECISE_EYES), slot_flags)
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)


/obj/item/clothing/glasses/regular/proc/on_entered(datum/source, atom/movable/movable)
	SIGNAL_HANDLER
	if(damaged_clothes == CLOTHING_SHREDDED)
		return
	if(item_flags & IN_INVENTORY)
		return
	if(isliving(movable))
		var/mob/living/crusher = movable
		if(crusher.move_intent != MOVE_INTENT_WALK && (!(crusher.movement_type & MOVETYPES_NOT_TOUCHING_GROUND) || crusher.buckled))
			playsound(src, 'sound/effects/footstep/glass_step.ogg', 30, TRUE)
			visible_message(span_warning("[crusher] 踩到了 [src]，把它弄坏了！"))
			take_damage(100, sound_effect = FALSE)

/obj/item/clothing/glasses/regular/atom_destruction(damage_flag)
	. = ..()
	detach_clothing_traits(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/regular/welder_act(mob/living/user, obj/item/I)
	. = ..()
	if(damaged_clothes == CLOTHING_PRISTINE)
		return
	if(!I.tool_start_check(user, amount=1))
		return
	if(I.use_tool(src, user, 10, volume=30))
		user.visible_message(span_notice("[user] 把 [src] 焊回原样。"),\
					span_notice("你把 [src] 焊回原样。"))
		repair()
		return TRUE

/obj/item/clothing/glasses/regular/repair()
	. = ..()
	attach_clothing_traits(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/regular/thin
	name = "细框处方眼镜"
	desc = "更贵、更脆弱、也更不实用，但就是那么时髦。"
	icon_state = "glasses_thin"

/obj/item/clothing/glasses/regular/jamjar
	name = "果酱罐眼镜"
	desc = "又名“童贞守护者”。"
	icon_state = "glasses_jamjar"
	inhand_icon_state = "glasses_jamjar"

/obj/item/clothing/glasses/regular/hipster
	name = "处方眼镜"
	desc = "由不酷公司制造。"
	icon_state = "glasses_hipster"
	inhand_icon_state = null

/obj/item/clothing/glasses/regular/circle
	name = "圆框眼镜"
	desc = "为什么要戴这么有争议却又这么勇敢的东西？"
	icon_state = "glasses_circle"
	inhand_icon_state = null

//Here lies green glasses, so ugly they died. RIP

/obj/item/clothing/glasses/sunglasses
	name = "太阳镜"
	desc = "奇怪地古老的科技，用于提供基本的眼部遮蔽。强化屏蔽可阻挡闪光。"
	icon_state = "sun"
	inhand_icon_state = "sunglasses"
	flags_cover = GLASSESCOVERSEYES
	flash_protect = FLASH_PROTECTION_FLASH
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/gray
	dog_fashion = /datum/dog_fashion/head

/obj/item/clothing/glasses/sunglasses/Initialize(mapload)
	. = ..()
	add_glasses_slapcraft_component()

/obj/item/clothing/glasses/sunglasses/proc/add_glasses_slapcraft_component()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/hudsunsec, /datum/crafting_recipe/hudsunmed, /datum/crafting_recipe/hudsundiag, /datum/crafting_recipe/scienceglasses)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/clothing/glasses/sunglasses/reagent
	name = "啤酒护目镜"
	icon_state = "sunhudbeer"
	desc = "一副装有试剂扫描装置的太阳镜，还能让佩戴者在移动时本能地理解液体黏度。"
	clothing_traits = list(TRAIT_BOOZE_SLIDER, TRAIT_REAGENT_SCANNER)

/obj/item/clothing/glasses/sunglasses/chemical
	name = "科研眼镜"
	icon_state = "sunhudsci"
	desc = "一副俗气的紫色太阳镜，佩戴者只需一瞥就能辨认各种化合物。"
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.8, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.55)

/obj/item/clothing/glasses/sunglasses/chemical/add_glasses_slapcraft_component()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/scienceglassesremoval)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/clothing/glasses/sunglasses/gar
	name = "黑色 GAR 眼镜"
	desc = "超越不可能，把理性踢到一边！"
	icon_state = "gar_black"
	inhand_icon_state = "gar_black"
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	force = 10
	throwforce = 10
	throw_speed = 4
	attack_verb_continuous = list("slices")
	attack_verb_simple = list("slice")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/obj/item/clothing/glasses/sunglasses/gar/orange
	name = "GAR 眼镜"
	desc = "你以为老子是谁？！"
	icon_state = "gar"
	inhand_icon_state = "gar"
	glass_colour_type = /datum/client_colour/glass_colour/orange

/obj/item/clothing/glasses/sunglasses/gar/giga
	name = "黑色究极 GAR 眼镜"
	desc = "相信我们人类吧。"
	icon_state = "gigagar_black"
	force = 12
	throwforce = 12

/obj/item/clothing/glasses/sunglasses/gar/giga/red
	name = "究极 GAR 眼镜"
	desc = "我们超越一分钟前的自己。一点一点，每一回合都在前进。钻头就是这么运作的！"
	icon_state = "gigagar_red"
	inhand_icon_state = "gar"
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/sunglasses/noir
	name = "黑色电影眼镜"
	desc = "一副时髦的未来主义眼镜，让佩戴者以不同的眼光看世界。"
	glass_colour_type = /datum/client_colour/monochrome/glasses
	forced_glass_color =  TRUE

///Syndicate item that upgrades the flash protection of your eyes.
/obj/item/syndicate_contacts
	name = "可疑的隐形眼镜盒"
	desc = "一个阴森的红色盒子，里面有两片闪闪发亮的黑色隐形眼镜。"
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/devices/syndie_gadget.dmi'
	icon_state = "contacts"

/obj/item/syndicate_contacts/attack_self(mob/user, modifiers)
	. = ..()
	if(!user.get_organ_slot(ORGAN_SLOT_EYES))
		to_chat(user, span_warning("你没有眼睛可以佩戴隐形眼镜！"))
		return
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)

	to_chat(user, span_notice("你开始把隐形眼镜戴到眼睛上……"))
	if(!do_after(user, 3 SECONDS, src))
		return
	to_chat(user, span_notice("镜片与你的虹膜无缝融合。"))
	eyes.flash_protect += FLASH_PROTECTION_WELDER
	to_chat(user, span_warning("[src] 化为一缕虚无。"))
	qdel(src)

/obj/item/clothing/glasses/welding
	name = "焊接护目镜"
	desc = "保护眼睛免受强光闪烁伤害；经疯狂科学家协会认证。"
	icon_state = "welding-g"
	inhand_icon_state = "welding-g"
	actions_types = list(/datum/action/item_action/toggle)
	flash_protect = FLASH_PROTECTION_WELDER
	visor_flags_cover = GLASSESCOVERSEYES
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	tint = 2
	visor_vars_to_toggle = VISOR_FLASHPROTECT | VISOR_TINT
	glass_colour_type = /datum/client_colour/glass_colour/gray
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER // SKYRAT EDIT - Just so it works until I make the change upstream

/obj/item/clothing/glasses/welding/Initialize(mapload)
	. = ..()
	if(!up)
		AddElement(/datum/element/adjust_fishing_difficulty, 8)

/obj/item/clothing/glasses/welding/attack_self(mob/living/user)
	adjust_visor(user)

/obj/item/clothing/glasses/welding/adjust_visor(mob/user)
	. = ..()
	if(up)
		RemoveElement(/datum/element/adjust_fishing_difficulty)
	else
		AddElement(/datum/element/adjust_fishing_difficulty, 8)

/obj/item/clothing/glasses/welding/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][up ? "up" : ""]"

/obj/item/clothing/glasses/welding/up/Initialize(mapload)
	. = ..()
	visor_toggling()

/obj/item/clothing/glasses/blindfold
	name = "眼罩布"
	desc = "遮住眼睛，阻止视物。"
	icon_state = "blindfold"
	inhand_icon_state = "blindfold"
	flash_protect = FLASH_PROTECTION_WELDER
	flags_cover = GLASSESCOVERSEYES
	tint = INFINITY // You WILL Be blind, no matter what
	dog_fashion = /datum/dog_fashion/head
	custom_materials = null

/obj/item/clothing/glasses/blindfold/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 8)

/obj/item/clothing/glasses/trickblindfold
	name = "眼罩布"
	desc = "一条透明眼罩布，非常适合在“把电击棍贴在小丑身上”之类的游戏中作弊。"
	icon_state = "trickblindfold"
	inhand_icon_state = "blindfold"
	flags_cover = GLASSESCOVERSEYES
	custom_materials = null

/obj/item/clothing/glasses/blindfold/white
	name = "盲人眼罩布"
	desc = "表示佩戴者患有失明。"
	icon_state = "blindfoldwhite"
	inhand_icon_state = null
	var/colored_before = FALSE

/obj/item/clothing/glasses/blindfold/white/visual_equipped(mob/living/carbon/human/user, slot)
	if(ishuman(user) && (slot & ITEM_SLOT_EYES) && !colored_before)
		add_atom_colour(BlendRGB(user.eye_color_left, user.eye_color_right, 0.5), FIXED_COLOUR_PRIORITY)
		colored_before = TRUE
	return ..()

/obj/item/clothing/glasses/sunglasses/big
	desc = "奇怪地古老的科技，用于提供基本的眼部遮蔽。比普通款更大，强化屏蔽可阻挡闪光。"
	icon_state = "bigsunglasses"
	inhand_icon_state = null

/obj/item/clothing/glasses/thermal
	name = "光学热成像扫描仪"
	desc = "眼镜形态的热成像仪。"
	icon_state = "thermal"
	inhand_icon_state = "glasses"
	vision_flags = SEE_MOBS
	// Going for an orange color here
	color_cutoffs = list(25, 8, 5)
	flash_protect = FLASH_PROTECTION_SENSITIVE
	flags_cover = GLASSESCOVERSEYES
	glass_colour_type = /datum/client_colour/glass_colour/red
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP

/obj/item/clothing/glasses/thermal/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	thermal_overload()

/obj/item/clothing/glasses/thermal/xray
	name = "辛迪加 X 射线护目镜"
	desc = "一副由辛迪加制造的 X 射线护目镜。"
	icon_state = "material"
	color_cutoffs = null
	vision_flags = SEE_TURFS|SEE_MOBS|SEE_OBJS
	glass_colour_type = /datum/client_colour/glass_colour/lightblue
	clothing_traits = list(TRAIT_XRAY_VISION)

/obj/item/clothing/glasses/thermal/syndi
	name = "变色龙热成像镜"
	desc = "一副装有内置变色龙发生器的热成像护目镜。"
	actions_types = list(/datum/action/item_action/chameleon/change/glasses/no_preset)
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE // SKYRAT EDIT ADDITION
	special_desc = "辛迪加用于渗透行动的变色龙热成像护目镜。" //SKYRAT EDIT ADDITION, I don't think the regular description persists through chameleon changes.

/obj/item/clothing/glasses/thermal/monocle
	name = "热成像单边镜"
	desc = "穿墙视物从未如此适合一位绅士。"
	icon_state = "thermoncle"
	flags_1 = null //doesn't protect eyes because it's a monocle, duh

/obj/item/clothing/glasses/thermal/monocle/examine(mob/user) //Different examiners see a different description!
	if(user.gender == MALE)
		desc = replacetext(desc, "绅士", "先生")
	else if(user.gender == FEMALE)
		desc = replacetext(desc, "绅士", "女士")
	. = ..()
	desc = initial(desc)

/obj/item/clothing/glasses/thermal/eyepatch
	name = "光学热成像眼罩"
	desc = "一副内置热成像光学器件的眼罩。"
	icon_state = "eyepatch"
	base_icon_state = "eyepatch"
	inhand_icon_state = null
	actions_types = list(/datum/action/item_action/flip)

/obj/item/clothing/glasses/thermal/eyepatch/attack_self(mob/user, modifiers)
	. = ..()
	icon_state = (icon_state == base_icon_state) ? "[base_icon_state]_flipped" : base_icon_state
	user.update_worn_glasses()

/obj/item/clothing/glasses/cold
	name = "防寒护目镜"
	desc = "一副适用于低温环境的护目镜。"
	icon_state = "cold"
	inhand_icon_state = null
	flags_cover = GLASSESCOVERSEYES
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP

/obj/item/clothing/glasses/heat
	name = "耐热护目镜"
	desc = "一副适用于高温环境的护目镜。"
	icon_state = "heat"
	inhand_icon_state = null
	flags_cover = GLASSESCOVERSEYES
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP

/obj/item/clothing/glasses/orange
	name = "橙色眼镜"
	desc = "一副好看的橙色墨镜。"
	icon_state = "orangeglasses"
	inhand_icon_state = null
	flags_cover = GLASSESCOVERSEYES
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

/obj/item/clothing/glasses/red
	name = "红色眼镜"
	desc = "嘿，前辈，你看起来真不错！"
	icon_state = "redglasses"
	inhand_icon_state = null
	flags_cover = GLASSESCOVERSEYES
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/geist_gazers
	name = "幽灵注视者"
	icon_state = "geist_gazers"
	worn_icon_state = "geist_gazers"
	glass_colour_type = /datum/client_colour/glass_colour/green
	flags_cover = GLASSESCOVERSEYES
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP

/obj/item/clothing/glasses/psych
	name = "精神眼镜"
	icon_state = "psych_glasses"
	worn_icon_state = "psych_glasses"
	glass_colour_type = /datum/client_colour/glass_colour/red
	flags_cover = GLASSESCOVERSEYES

/obj/item/clothing/glasses/debug
	name = "调试眼镜"
	desc = "医疗、安保与诊断 HUD。"
	desc_controls = "按住 Alt 点击可切换 X 射线。"
	icon_state = "nvgmeson"
	inhand_icon_state = "nvgmeson"
	flags_cover = GLASSESCOVERSEYES
	flash_protect = FLASH_PROTECTION_WELDER
	lighting_cutoff = LIGHTING_CUTOFF_HIGH
	glass_colour_type = FALSE
	vision_flags = SEE_TURFS
	clothing_traits = list(
		TRAIT_REAGENT_SCANNER,
		TRAIT_MADNESS_IMMUNE,
		TRAIT_MEDICAL_HUD,
		TRAIT_SECURITY_HUD,
		TRAIT_DIAGNOSTIC_HUD,
		TRAIT_BOT_PATH_HUD,
	)
	var/xray = FALSE
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP

/obj/item/clothing/glasses/debug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -15)

/obj/item/clothing/glasses/debug/click_alt(mob/user)
	if(!ishuman(user))
		return CLICK_ACTION_BLOCKING
	if(xray)
		vision_flags &= ~SEE_MOBS|SEE_OBJS
		detach_clothing_traits(TRAIT_XRAY_VISION)
	else
		vision_flags |= SEE_MOBS|SEE_OBJS
		attach_clothing_traits(TRAIT_XRAY_VISION)
	xray = !xray
	var/mob/living/carbon/human/human_user = user
	human_user.update_sight()
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/glasses/regular/kim
	name = "书呆子镜片"
	desc = "表明你知道如何缝好翻领，并把后开衩居中对齐。"
	icon_state = "glasses_binoclard"
	inhand_icon_state = null

/obj/item/clothing/glasses/salesman
	name = "彩色眼镜"
	desc = "一副镜片颜色独特的眼镜。镜框上刻着“1997 年度最佳销售员”。"
	icon_state = "salesman"
	inhand_icon_state = "salesman"
	flags_cover = GLASSESCOVERSEYES
	///Tells us who the current wearer([BIGSHOT]) is.
	var/mob/living/carbon/human/bigshot

/obj/item/clothing/glasses/salesman/equipped(mob/living/carbon/human/user, slot)
	..()
	if(!(slot & ITEM_SLOT_EYES))
		return
	bigshot = user
	RegisterSignal(bigshot, COMSIG_CARBON_SANITY_UPDATE, PROC_REF(moodshift))

/obj/item/clothing/glasses/salesman/dropped(mob/living/carbon/human/user)
	..()
	UnregisterSignal(bigshot, COMSIG_CARBON_SANITY_UPDATE)
	bigshot = initial(bigshot)
	icon_state = initial(icon_state)
	desc = initial(desc)

/obj/item/clothing/glasses/salesman/proc/moodshift(atom/movable/source, amount)
	SIGNAL_HANDLER
	if(amount < SANITY_UNSTABLE)
		icon_state = "salesman_fzz"
		desc = "一副眼镜，镜片里全是电视雪花。它们显然风光不再了……"
		bigshot.update_worn_glasses()
	else
		icon_state = initial(icon_state)
		desc = initial(desc)
		bigshot.update_worn_glasses()

/obj/item/clothing/glasses/nightmare_vision
	name = "噩梦视觉护目镜"
	desc = "它们散发着腐臭。似乎对任何东西都没有作用。"
	icon_state = "nightmare"
	inhand_icon_state = "glasses"
	glass_colour_type = /datum/client_colour/glass_colour/nightmare
	forced_glass_color = TRUE
	lighting_cutoff = LIGHTING_CUTOFF_FULLBRIGHT
	flags_cover = GLASSESCOVERSEYES
	/// Hallucination datum currently being used for seeing mares
	var/datum/hallucination/stored_hallucination
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP

/obj/item/clothing/glasses/nightmare_vision/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 13)

/obj/item/clothing/glasses/nightmare_vision/Destroy()
	QDEL_NULL(stored_hallucination)
	return ..()

/obj/item/clothing/glasses/nightmare_vision/equipped(mob/living/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_EYES))
		return
	//5% chance to get mare vision
	if(prob(5))
		stored_hallucination = 	user.cause_hallucination( \
			/datum/hallucination/delusion/preset/mare, \
			src.name, \
			duration = 0, \
			affects_us = TRUE, \
			affects_others = TRUE, \
			skip_nearby = FALSE, \
			play_wabbajack = FALSE, \
		)

/obj/item/clothing/glasses/nightmare_vision/dropped(mob/living/user)
	. = ..()
	QDEL_NULL(stored_hallucination)

/obj/item/clothing/glasses/osi
	name = "O.S.I. 太阳镜"
	desc = "根本没有所谓的好消息！只有坏消息和……怪消息……"
	icon_state = "osi_glasses"
	inhand_icon_state = null
	flags_cover = GLASSESCOVERSEYES

/obj/item/clothing/glasses/phantom
	name = "怪盗面具"
	desc = "看起来挺酷。"
	icon_state = "phantom_glasses"
	inhand_icon_state = null
	flags_cover = GLASSESCOVERSEYES
	custom_materials = null
