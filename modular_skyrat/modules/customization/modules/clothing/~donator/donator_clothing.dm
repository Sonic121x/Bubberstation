/**************SKYRAT REWARDS**************/
//SUITS
/obj/item/clothing/suit/hooded/wintercoat/colourable
	name = "定制冬季外套"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/colourable"
	post_init_icon_state = "winter_coat"
	worn_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/colourable
	greyscale_config = /datum/greyscale_config/winter_coat
	greyscale_config_worn = /datum/greyscale_config/winter_coat_worn
	greyscale_colors = "#666666#CCBBAA#0000FF"
	flags_1 = IS_PLAYER_COLORABLE_1
	hood_down_overlay_suffix = ""
	/// Whether the hood is flipped up
	var/hood_up = FALSE

/// Called when the hood is worn
/obj/item/clothing/suit/hooded/wintercoat/colourable/on_hood_up(obj/item/clothing/head/hooded/hood)
	hood_up = TRUE

/// Called when the hood is hidden
/obj/item/clothing/suit/hooded/wintercoat/colourable/on_hood_down(obj/item/clothing/head/hooded/hood)
	hood_up = FALSE

//In case colors are changed after initialization
/obj/item/clothing/suit/hooded/wintercoat/colourable/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()

	if(!hood)
		return

	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/list/new_coat_colors = coat_colors.Copy(1,3)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

//But also keep old method in case the hood is (re-)created later
/obj/item/clothing/suit/hooded/wintercoat/colourable/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = (SSgreyscale.ParseColorString(greyscale_colors))
	var/list/new_coat_colors = coat_colors.Copy(1,3)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

/obj/item/clothing/head/hooded/winterhood/colourable
	icon_state = "hood_winter"
	greyscale_config = /datum/greyscale_config/winter_hood
	greyscale_config_worn = /datum/greyscale_config/winter_hood/worn

// NECK

/obj/item/clothing/neck/cloak/colourable
	name = "可染色斗篷"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/cloak/colourable"
	post_init_icon_state = "gags_cloak"
	greyscale_config = /datum/greyscale_config/cloak
	greyscale_config_worn = /datum/greyscale_config/cloak/worn
	greyscale_colors = "#917A57#4e412e#4e412e"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/cloak/colourable/veil
	name = "可染色面纱"
	icon_state = "/obj/item/clothing/neck/cloak/colourable/veil"
	post_init_icon_state = "gags_veil"
	greyscale_config = /datum/greyscale_config/cloak/veil
	greyscale_config_worn = /datum/greyscale_config/cloak/veil/worn

/obj/item/clothing/neck/cloak/colourable/boat
	name = "可染色船式斗篷"
	icon_state = "/obj/item/clothing/neck/cloak/colourable/boat"
	post_init_icon_state = "gags_boat"
	greyscale_config = /datum/greyscale_config/cloak/boat
	greyscale_config_worn = /datum/greyscale_config/cloak/boat/worn

/obj/item/clothing/neck/cloak/colourable/shroud
	name = "可染色罩衣"
	icon_state = "/obj/item/clothing/neck/cloak/colourable/shroud"
	post_init_icon_state = "gags_shroud"
	greyscale_config = /datum/greyscale_config/cloak/shroud
	greyscale_config_worn = /datum/greyscale_config/cloak/shroud/worn

/**************CKEY EXCLUSIVES*************/

// Donation reward for Grunnyyy
/obj/item/clothing/suit/jacket/ryddid
	name = "里迪德"
	desc = "一件属于某个小恶魔的旧衣服，已经穿得破旧不堪。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "darkcoat"
	inhand_icon_state = "greatcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for Grunnyyy
/obj/item/clothing/neck/cloak/grunnyyy
	name = "黑红斗篷"
	desc = "这上面的图案似乎有点太眼熟了。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "infcloak"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = NONE

// Donation reward for Thedragmeme
// might make it have some flavour functionality in future, a'la rewritable piece of paper - JOKES ON YOU I'M MAKING IT DRAW
/obj/item/canvas/drawingtablet
	name = "绘图平板"
	desc = "一块可以让你作画的便携平板。传说在某些星区，这东西能替主人赚到一笔财富。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "drawingtablet"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	inhand_icon_state = "electronic"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	actions_types = list(/datum/action/item_action/dtselectcolor,/datum/action/item_action/dtcolormenu,/datum/action/item_action/dtcleargrid)
	pixel_x = 0
	pixel_y = 0
	width = 28
	height = 26
	nooverlayupdates = TRUE
	var/currentcolor = "#ffffff"
	var/list/colors = list("橡皮擦" = "#ffffff")

/obj/item/canvas/drawingtablet/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/dtselectcolor))
		currentcolor = tgui_color_picker(user, "", "选择颜色", currentcolor)
	else if(istype(action, /datum/action/item_action/dtcolormenu))
		var/list/selects = colors.Copy()
		selects["Save"] = "Save"
		selects["Delete"] = "Delete"
		var/selection = input(user, "", "颜色菜单", currentcolor) as null|anything in selects
		if(QDELETED(src) || !user.can_perform_action(src))
			return
		switch(selection)
			if("Save")
				var/name = input(user, "", "为颜色命名！", "淡紫") as text|null
				if(name)
					colors[name] = currentcolor
			if("Delete")
				var/delet = input(user, "", "颜色菜单", currentcolor) as null|anything in colors
				if(delet)
					colors.Remove(delet)
			if(null)
				return
			else
				currentcolor = colors[selection]
	else if(istype(action, /datum/action/item_action/dtcleargrid))
		var/yesnomaybe = tgui_alert(user, "你确定要清空画布吗？", "", list("Yes", "No", "Maybe"))
		if(QDELETED(src) || !user.can_perform_action(src))
			return
		switch(yesnomaybe)
			if("Yes")
				workspace = new(width,
					height,
					color_mode = SPRITE_EDITOR_COLOR_MODE_RGB,
					config_flags = NONE,
					tool_flags = SPRITE_EDITOR_TOOL_PENCIL | SPRITE_EDITOR_TOOL_BUCKET,
					initial_layer_color = "[canvas_color]ff" // To avoid needing to handle strings of mixed lengths, sprite editor workspaces always use the alpha channel
				)
				SStgui.update_uis(src)
			if("No")
				return
			if("Maybe")
				playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)
				audible_message(span_warning("[src] 发出蜂鸣声！"))
				return

/obj/item/canvas/drawingtablet/get_paint_tool_color()
	return currentcolor

/obj/item/canvas/drawingtablet/finalize()
	return // no finalizing this piece

/obj/structure/sign/painting/frame_canvas(mob/user,obj/item/canvas/new_canvas)
	if(istype(new_canvas, /obj/item/canvas/drawingtablet)) // NO FINALIZING THIS BITCH.
		return FALSE
	else
		return ..()

/obj/item/canvas/var/nooverlayupdates = FALSE

/obj/item/canvas/update_overlays()
	if(nooverlayupdates)
		return
	. = ..()

/datum/action/item_action/dtselectcolor
	name = "更换颜色"
	desc = "更改你的颜色。"
	button_icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

/datum/action/item_action/dtcolormenu
	name = "颜色菜单"
	desc = "在平板的颜色菜单中选取、保存或删除颜色！"
	button_icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

/datum/action/item_action/dtcleargrid
	name = "清空画布"
	desc = "清空绘图平板的画布。"
	button_icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

// Donation reward for Thedragmeme
/obj/item/clothing/suit/furcoat
	name = "皮外套"
	desc = "一件厚实、看起来很舒适的皮外套。领口和袖口处缀着蓬松的毛皮。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "furcoat"
	inhand_icon_state = "hostrench"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = NONE

// Donation reward for Thedragmeme
/obj/item/clothing/under/syndicate/tacticool/black
	name = "黑色高领衫"
	desc = "战术感爆表。还特别舒服。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "black_turtleneck"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = NONE
	armor_type = /datum/armor/clothing_under
	can_adjust = FALSE //There wasnt an adjustable sprite anyways
	has_sensor = HAS_SENSORS	//Actually has sensors, to balance the new lack of armor

// Donation reward for Bloodrite
/obj/item/clothing/shoes/clown_shoes/britches
	desc = "捣蛋鬼标配的小丑鞋。它们看起来格外可爱。按住 Ctrl 点击可切换摇摆稳定器。"
	name = "布里奇斯的鞋"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/feet.dmi'
	icon_state = "clown_shoes_cute"
	supports_variations_flags = NONE
	resistance_flags = FIRE_PROOF

// Donation reward for Bloodrite
/obj/item/clothing/under/rank/civilian/clown/britches
	name = "布里奇斯的连衣裙"
	desc = "<i>“洪克！”（但很可爱）</i>"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "clowndress"
	supports_variations_flags = NONE
	resistance_flags = FIRE_PROOF

// Donation reward for Bloodrite
/obj/item/clothing/mask/gas/britches
	name = "布里奇斯的面具"
	desc = "真正捣蛋鬼的面部装束。可爱。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "cute_mask"
	inhand_icon_state = null
	dye_color = "clown"
	supports_variations_flags = NONE
	clothing_flags = MASKINTERNALS
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSEYES
	resistance_flags = FIRE_PROOF

/******CALIGRA DONATIONS******/
// NOTE: Caligram is being renamed to Blacktide Mercenary Fleet. I'll be reflavoring them to that, with the Molerats/Dustworld stuff coming in its own unique PR later

// Donation reward for Farsighted Nightlight
/obj/item/clothing/mask/gas/nightlight
	name = "\improper BT-36 呼吸面罩"
	desc = "由黑潮为最初一批类人新兵设计的战斗呼吸面罩。线条流畅，通体漆黑。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "fir36"
	actions_types = list(/datum/action/item_action/adjust)
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS //same flags as actual sec hailer gas mask
	flags_inv = HIDESNOUT
	flags_cover = NONE
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	visor_flags_inv = HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	tint = 0
	interaction_flags_click = NEED_DEXTERITY

/obj/item/clothing/mask/gas/nightlight/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/gas/nightlight/click_alt(mob/user)
	adjust_visor(user)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/gas/nightlight/examine(mob/user)
	. = ..()
	. += span_notice("按住 Alt 点击 [src] 可进行调整。")

/obj/item/clothing/mask/gas/nightlight/alldono //different itempath so regular donators can have it, too

// Donation reward for Farsighted Nightlight
/obj/item/clothing/mask/gas/nightlight/fir22
	name = "\improper BT-22 加长型呼吸面罩"
	desc = "BT-36 呼吸面罩的加长面罩版本，专为吻部较长的黑潮新兵开发。和它的老大哥一样流畅漆黑。"
	icon_state = "fir22"

// Donation reward for Raxraus
/obj/item/clothing/head/caligram_cap_tan
	name = "\improper 黑潮软帽"
	desc = "为黑潮在各种环境中作业而制作的软帽，有棕褐色和雅致的蓝色两种款式。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "caligram_cap_tan"

/obj/item/clothing/head/caligram_cap_tan/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/caligram_cap)

/datum/atom_skin/caligram_cap
	abstract_type = /datum/atom_skin/caligram_cap

/datum/atom_skin/caligram_cap/tan
	preview_name = "棕褐款"
	new_icon_state = "caligram_cap_tan"

/datum/atom_skin/caligram_cap/blue
	preview_name = "蓝色款"
	new_icon_state = "caligram_cap_blue"

// Donation reward for Raxraus
/obj/item/clothing/under/jumpsuit/caligram_fatigues_tan
	name = "\improper 黑潮作战服"
	desc = "黑潮为其干员开发的一套作战服，适用于各种环境。有棕色和雅致的蓝色两种款式。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	icon_state = "caligram_fatigues_tan"
	worn_icon_state = "caligram_fatigues_tan"

/obj/item/clothing/under/jumpsuit/caligram_fatigues_tan/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/caligram_fatigues)

/datum/atom_skin/caligram_fatigues
	abstract_type = /datum/atom_skin/caligram_fatigues

/datum/atom_skin/caligram_fatigues/tan
	preview_name = "棕褐款"
	new_icon_state = "caligram_fatigues_tan"

/datum/atom_skin/caligram_fatigues/blue
	preview_name = "蓝色款"
	new_icon_state = "caligram_fatigues_blue"

// Donation reward for Raxraus
/obj/item/clothing/suit/jacket/caligram_parka_tan
	name = "\improper 黑潮外套"
	desc = "一件配黑色腰带的外套，臂章上缝着“/黑潮雇佣兵团/”。有棕褐、蓝色和无贴章蓝色三种款式。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "caligram_parka_tan"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS|HANDS

/obj/item/clothing/suit/jacket/caligram_parka_tan/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/caligram_parka)

/datum/atom_skin/caligram_parka
	abstract_type = /datum/atom_skin/caligram_parka

/datum/atom_skin/caligram_parka/tan
	preview_name = "棕褐款"
	new_icon_state = "caligram_parka_tan"

/datum/atom_skin/caligram_parka/blue
	preview_name = "蓝色款"
	new_icon_state = "caligram_parka_blue"

/datum/atom_skin/caligram_parka/blue_patchless
	preview_name = "蓝色无贴章款"
	new_icon_state = "caligram_parka_patchless_blue"

// Donation reward for Raxraus
/obj/item/clothing/suit/armor/vest/caligram_parka_vest_tan
	name = "\improper 黑潮装甲外套"
	desc = "一件配黑色腰带和轻装甲背心的外套，臂章上缝着“/黑潮雇佣兵团/”。有棕褐和蓝色两种款式。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "caligram_parka_vest_tan"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS|HANDS

/obj/item/clothing/suit/armor/vest/caligram_parka_vest_tan/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/caligram_parka_vest)

/datum/atom_skin/caligram_parka_vest
	abstract_type = /datum/atom_skin/caligram_parka_vest

/datum/atom_skin/caligram_parka_vest/tan
	preview_name = "棕褐款"
	new_icon_state = "caligram_parka_vest_tan"

/datum/atom_skin/caligram_parka_vest/blue
	preview_name = "蓝色款"
	new_icon_state = "caligram_parka_vest_blue"

// Donation reward for ChillyLobster
/obj/item/clothing/suit/jacket/brasspriest
	name = "黄铜祭司外套"
	desc = "一件淡红色外套，其上嵌着包黄铜外壳的部件。偶尔能听到里面某些齿轮转动的微弱声响。"
	icon_state = "brasspriest"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS

// Donation reward for ChillyLobster
/obj/item/clothing/suit/jacket/hydrogenrobes
	name = "金属氢长袍"
	desc = "一件极其闪亮的连衣裙，整片织物上似乎都覆着一层极薄的金属氢。防护性不怎么样。"
	icon_state = "hydrogenrobes"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'

// Donation reward for ChillyLobster

/obj/item/clothing/under/wetsuit_norm
	name = "贴身潜水服"
	desc = "一件能保暖、锁水的贴身潜水服。能极轻微地抵御外界环境。"
	icon_state = "wetsuit"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	armor_type = /datum/armor/clothing_under/wetsuit
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	can_adjust = FALSE
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for TheOOZ
/obj/item/clothing/mask/animal/wolf
	name = "狼面具"
	desc = "一副狼头形状的深色面具。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	icon_state = "kindle"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	inhand_icon_state = "gasmask_captain"
	animal_type = "狼"
	unique_death = 'modular_skyrat/master_files/sound/effects/wolfhead_curse.ogg'
	visor_flags_inv = HIDEFACIALHAIR | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	clothing_flags = VOICEBOX_DISABLED | MASKINTERNALS | BLOCK_GAS_SMOKE_EFFECT | GAS_FILTERING
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	use_radio_beeps_tts = TRUE

/obj/item/clothing/mask/animal/wolf/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/mask/gas/sechailer/sechailer_type = /obj/item/clothing/mask/gas/sechailer
	voice_filter = initial(sechailer_type.voice_filter)

// Donation reward for Random516
/obj/item/clothing/head/drake_skull
	name = "灰烬龙的头骨"
	desc = "他们是怎么弄到这个的？"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	icon_state = "drake_skull"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/large-worn-icons/32x64/head.dmi'
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	supports_variations_flags = NONE

// Donation reward for Random516
/obj/item/clothing/gloves/fingerless/blutigen_wraps
	name = "布卢蒂根缠布"
	desc = "佩戴它的人曾拥有一切，却失去了一切……"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	icon_state = "blutigen_wraps"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'

// Donation reward for Random516
/obj/item/clothing/suit/blutigen_kimono
	name = "布卢蒂根和服"
	desc = "因为被赐予这双眼睛的人，将会去追寻冒险……"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	icon_state = "blutigen_kimono"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = NONE

// Donation reward for Random516
/obj/item/clothing/under/custom/blutigen_undergarment
	name = "龙之内衣"
	desc = "龙也要穿性感内衣吗？"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "blutigen_undergarment"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/gloves/ring/hypno
	var/list/spans = list()
	actions_types = list(/datum/action/item_action/hypno_whisper)

// Donation reward for CoffeePot
/obj/item/clothing/gloves/ring/hypno/coffeepot
	name = "催眠恶魔的戒指"
	desc = "一枚苍白、色彩柔和黯淡的金戒指，看起来并不属于这个世界。很难说清它为何让人觉得与周遭格格不入——它泛出的光泽既像是和房间里的灯光不搭，又像是偶尔会在毫无理由的时候闪烁微光，而且总在你没有真正盯着它看的时候。"
	spans = list("velvet")

// Donation reward for Bippys
/obj/item/clothing/gloves/ring/hypno/bippys
	name = "催眠机器人的六角螺帽"
	desc = "一枚银色的螺栓部件，曾属于某个非常奇特的 IPC。它大得几乎任何手指都能当戒指戴；据说它能在低语般的柔声中，把一个人心中的声音放大传达给另一个人……"
	icon_state = "ringsilver"
	worn_icon_state = "sring"
	spans = list("hexnut")

/datum/action/item_action/hypno_whisper
	name = "催眠低语"

/obj/item/clothing/gloves/ring/hypno/ui_action_click(mob/living/user, action)
	if(!isliving(user) || !can_use(user))
		return
	var/message = input(user, "以催眠低语说话", "低语")
	if(QDELETED(src) || QDELETED(user) || !message || !user.can_speak())
		return
	user.whisper(message, spans = spans)

// Donation reward for SlippyJoe
/obj/item/clothing/head/avipilot
	name = "走私者的飞行帽"
	desc = "令人意外的是，尽管有太空强风、也毫无实用性可言，这顶飞行帽看起来依然保存得相当完好；它的侧面似乎压印着一个兔子头。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "avipilotup"
	inhand_icon_state = "rus_ushanka"
	flags_inv = HIDEHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT //about as warm as an ushanka
	actions_types = list(/datum/action/item_action/adjust)
	supports_variations_flags = NONE
	var/goggles = FALSE

/obj/item/clothing/head/avipilot/proc/adjust_goggles(mob/living/carbon/user)
	if(user?.incapacitated)
		return
	if(goggles)
		icon_state = "avipilotup"
		to_chat(user, span_notice("你使出全部力气把护目镜推了上去。"))
	else
		icon_state = "avipilotdown"
		to_chat(user, span_notice("你集中全部意志把护目镜拉下来罩住眼睛。"))
	goggles = !goggles
	if(user)
		user.update_worn_head()
		user.update_mob_action_buttons()

/obj/item/clothing/head/avipilot/ui_action_click(mob/living/carbon/user, action)
	adjust_goggles(user)

/obj/item/clothing/head/avipilot/attack_self(mob/living/carbon/user)
	adjust_goggles(user)

// Donation reward for NetraKyram - public use allowed via the command vendor
/obj/item/clothing/under/rank/captain/dress
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	name = "舰长礼服"
	desc = "一件蓝色礼服，上面带有磨损的金色标记，标示着“舰长”的军衔。"
	icon_state = "dress_cap_s"
	worn_icon_state = "dress_cap_s"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

// Donation reward for NetraKyram
/obj/item/clothing/under/rank/blueshield/netra
	name = "黑银装甲礼服"
	desc = "一件及踝的黑银长裙，由某种闪亮的合成材料制成，内嵌凯夫拉碎片与银色加固件；领口环绕着一圈银环，而且似乎没有拉链……这玩意儿到底怎么穿上去？"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "silver_dress"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = null
	supports_variations_flags = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

// Donation reward for NetraKyram
/obj/item/clothing/gloves/netra
	name = "黑银手套"
	desc = "一副带银色加固的黑色手套，由闪亮的合成材料制成。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	icon_state = "silver_dress_gloves"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'

// Donation reward for NetraKyram
/obj/item/clothing/shoes/jackboots/netra
	name = "擦亮的军靴"
	desc = "一双标准配发的军靴，被擦得亮得能照出人影，散发着硅制阅兵鞋油的气味。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/shoes.dmi'
	icon_state = "silver_dress_boots"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/feet.dmi'
	supports_variations_flags = NONE


/****************LEGACY REWARDS***************/
// Donation reward for inferno707
/obj/item/clothing/neck/cloak/inferno
	name = "琪亚拉的斗篷"
	desc = "这上面的图案似乎有点太眼熟了。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "infcloak"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

// Donation reward for inferno707
/obj/item/clothing/neck/inferno_collar
	name = "琪亚拉的项圈"
	desc = "一条柔软的黑色项圈，似乎会伸展以贴合任何佩戴者。"
	icon_state = "infcollar"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	alternate_worn_layer = UNDER_SUIT_LAYER
	kink_collar = TRUE
	/// What's the name on the tag, if any?
	var/tagname = null
	/// What treat item spawns inside the collar?
	var/treat_path = /obj/item/food/cookie

/obj/item/clothing/neck/inferno_collar/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small/collar)
	if(treat_path)
		new treat_path(src)

/obj/item/clothing/neck/inferno_collar/attack_self(mob/user)
	tagname = stripped_input(user, "你想更改吊牌上的名字吗？", "给你的新宠物命名", "琪亚拉", MAX_NAME_LEN)
	if(tagname)
		name = "[initial(name)] - [tagname]"

// Donation reward for inferno707
/obj/item/clothing/accessory/medal/steele
	name = "斯蒂尔徽记"
	desc = "一枚精巧的吊坠，赠予那些帮助过斯蒂尔公司要员的。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "steele"
	medaltype = "medal-silver"

// Donation reward for inferno707
/obj/item/toy/darksabre
	name = "琪亚拉的军刀"
	desc = "这把刀刃看起来和它的主人一样危险。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "darksabre"
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'

/obj/item/toy/darksabre/get_belt_overlay()
	return mutable_appearance('modular_skyrat/master_files/icons/donator/obj/custom.dmi', "darksheath-darksabre")

// Donation reward for inferno707
/obj/item/storage/belt/sheath/sabre/darksabre
	name = "华丽剑鞘"
	desc = "一具华丽、且看起来颇为阴森的军刀剑鞘。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "sheath"
	worn_icon_state = "sheath"
	stored_blade = /obj/item/toy/darksabre

/obj/item/storage/belt/sheath/sabre/darksabre/Initialize(mapload)
	. = ..()
	atom_storage.set_holdable(list(
		/obj/item/toy/darksabre
		))

// Donation reward for inferno707
/obj/item/clothing/suit/armor/vest/darkcarapace
	name = "黑暗护甲"
	desc = "一件深色、没有实际防护功能的护甲，表面为红黑配色。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "darkcarapace"
	blood_overlay_type = "armor"
	dog_fashion = /datum/dog_fashion/back
	supports_variations_flags = NONE
	armor_type = /datum/armor/none

// Donation reward for inferno707
/obj/item/clothing/mask/hheart
	name = "空心之心"
	desc = "一副古怪的陶瓷面具。内侧镶嵌着几个带有斯蒂尔科技品牌的古怪电子元件。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	icon_state = "hheart"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	var/c_color_index = 1
	var/list/possible_colors = list("off", "blue", "red")
	actions_types = list(/datum/action/item_action/hheart)
	supports_variations_flags = NONE

/obj/item/clothing/mask/hheart/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/clothing/mask/hheart/update_icon()
	. = ..()
	icon_state = "hheart-[possible_colors[c_color_index]]"

/datum/action/item_action/hheart
	name = "切换模式"
	desc = "切换空心之心的颜色。"

/obj/item/clothing/mask/hheart/ui_action_click(mob/user, action)
	. = ..()
	if(istype(action, /datum/action/item_action/hheart))
		if(!isliving(user))
			return
		var/mob/living/ooser = user
		var/the = possible_colors.len
		var/index = 0
		if(c_color_index >= the)
			index = 1
		else
			index = c_color_index + 1
		c_color_index = index
		update_icon()
		ooser.update_worn_mask()
		ooser.update_mob_action_buttons()
		to_chat(ooser, span_notice("你把 [src] 切换为 [possible_colors[c_color_index]]。"))

// Donation reward for asky / Zulie
/obj/item/clothing/suit/hooded/cloak/zuliecloak
	name = "Zul-E 计划"
	desc = "纳米传讯高层发放的原型斗篷的标准版本。尽管大部分技术都被剥离，作为一件斗篷它仍出奇地厚实沉重。它还附有一件蓝空间小饰品，能把配套的帽子召唤到使用者身上。斗篷内侧有一行磨损的铭文写着“Fleuret”……其余部分已经褪色难辨。"
	icon_state = "zuliecloak"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/zuliecloak
	body_parts_covered = CHEST|GROIN|ARMS
	slot_flags = ITEM_SLOT_OCLOTHING | ITEM_SLOT_NECK //it's a cloak. it's cosmetic. so why the hell not? what could possibly go wrong?
	supports_variations_flags = NONE

/obj/item/clothing/head/hooded/cloakhood/zuliecloak
	name = "纳米传讯特供"
	desc = "这顶帽子无疑是最好的，通过蓝空间技术往返于中央指挥部。它闻起来有鱼和茶的味道，还带一丝敌意。"
	icon_state = "zuliecap"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	flags_inv = null
	supports_variations_flags = NONE

// Donation reward for Lyricalpaws
/obj/item/clothing/neck/cloak/healercloak
	name = "传奇医者斗篷"
	desc = "由站上最娴熟的专业医疗人员所穿，这件传奇斗篷只有成为治疗技艺的巅峰才能获得。这一地位象征代表佩戴者已花费无数年完善救治病患与伤员的手艺。"
	icon_state = "healercloak"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'

// Donation reward for Kathrin Bailey / Floof Ball
/obj/item/clothing/under/custom/lannese
	name = "兰尼斯礼服"
	desc = "来自一颗名为坎塔兰的遥远星球的女性外星文化服饰。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "lannese"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	inhand_icon_state = "firefighter"
	can_adjust = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|LEGS|FEET

/obj/item/clothing/under/custom/lannese/vambrace
	desc = "来自一颗名为坎塔兰的遥远星球的女性外星文化服饰。还附带闪亮的护臂！"
	icon_state = "lannese_vambrace"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET

// Donation reward for Hacker T.Dog
/obj/item/clothing/suit/scraparmour
	name = "废料护甲"
	desc = "一件做工粗糙的护甲。除了笨重之外毫无益处。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	icon_state = "scraparmor"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_state = "scraparmor"
	body_parts_covered = CHEST

// Donation reward for Enzoman
/obj/item/clothing/mask/luchador/enzo
	name = "红圣殿骑士的面具"
	desc = "属于卢恰战士红圣殿骑士的面具。不建议从他手里把它拿走。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "luchador"
	worn_icon_state = "luchador"
	clothing_flags = MASKINTERNALS
	supports_variations_flags = NONE

// Donation Reward for Grand Vegeta
/obj/item/clothing/under/mikubikini
	name = "星光歌姬比基尼"
	desc = " "
	icon_state = "mikubikini"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_state = "mikubikini"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

// Donation Reward for Grand Vegeta
/obj/item/clothing/suit/mikujacket
	name = "星光歌姬外套"
	desc = " "
	icon_state = "mikujacket"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_state = "mikujacket"

// Donation Reward for Grand Vegeta
/obj/item/clothing/head/mikuhair
	name = "星光歌姬发型"
	desc = " "
	icon_state = "mikuhair"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_state = "mikuhair"
	flags_inv = HIDEHAIR

// Donation Reward for Grand Vegeta
/obj/item/clothing/gloves/mikugloves
	name = "星光歌姬手套"
	desc = " "
	icon_state = "mikugloves"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'
	worn_icon_state = "mikugloves"

// Donation Reward for Grand Vegeta
/obj/item/clothing/shoes/sneakers/mikuleggings
	name = "星光歌姬紧身裤"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	desc = " "
	icon_state = "mikuleggings"
	post_init_icon_state = null
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/feet.dmi'
	worn_icon_state = "mikuleggings"

// Donation reward for CandleJax
/obj/item/clothing/head/helmet/space/plasmaman/candlejax
	name = "Emission 的头盔"
	desc = "一顶专为高强度使用而设计的特殊密封头盔。这一顶上面有不少凹痕和刻痕。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "emissionhelm"
	visor_icon = "emissionhelm-envisor"

// Donation reward for CandleJax
/obj/item/clothing/head/helmet/space/plasmaman/candlejax2
	name = "Azulean 环境头盔"
	desc = "一顶 Azulean 制造的环保头盔，针对该种族特有的头骨形状作了调整。除标准配置外，头盔背面还压印着 Azulean 族徽。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "anahead"
	visor_icon = "anahead-envisor"

// Donation reward for CandleJax
/obj/item/clothing/under/plasmaman/candlejax
	name = "Emission 的密封服"
	desc = "一件改装过的环保服，采用内敛的配色。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	icon_state = "emissionsuit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for CandleJax
/obj/item/clothing/under/plasmaman/candlejax2
	name = "Azulean 环保服"
	desc = "一件 Azulean 制造的环保服。贴合 Azulean 的体形，配有富余的密封织物，好让那条凝固成等离子体的尾巴有呼吸的空间。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	icon_state = "ana_envirosuit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for CandleJax
/obj/item/clothing/under/plasmaman/jax2
	name = "Xuracorp 危险品内衬服"
	desc = "一套装有抗生物纤维的危险品防护服。背部配备自消毒泵。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	icon_state = "plasmaman_jax"

// Donation reward for Raxraus
/obj/item/clothing/shoes/jackboots/peacekeeper/armadyne/rax
	name = "战术靴"
	desc = "既战术又流线。这款似乎与 Armadyne 的款式相似。"

// Donation reward for Raxraus
/obj/item/clothing/suit/armor/vest/warden/rax
	name = "维和夹克"
	desc = "一件藏青色的装甲夹克，配蓝色肩部标识。"

// Donation reward for Raxraus
/obj/item/clothing/under/rank/security/rax
	name = "镶带制服"
	desc = "量身裁制的制服，在设计上兼顾防护与时尚。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	icon_state = "hos_black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for DeltaTri
/obj/item/clothing/suit/jacket/delta
	name = "灰色冬季连帽衫"
	desc = "一件普通的灰色旧连帽衫。内侧有些蓬松，兜帽的一半边缘缀着动物毛皮。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "greycoat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

// Donation reward for Cherno_00
/obj/item/clothing/suit/jacket/cherno
	name = "银扣外套"
	desc = "一件看起来很舒适的外套。它配有闪亮的银扣和几条腰带，显得颇为精致！"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "chernocoat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

// Donation reward for GoldenAlpharex
/obj/item/clothing/glasses/welding/steampunk_goggles
	name = "蒸汽朋克护目镜"
	desc = "这确实很像是会架在某位红发人士头上的东西……镜片周围镶着一圈相当精致的黄铜边。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "goldengoggles"
	slot_flags = ITEM_SLOT_EYES | ITEM_SLOT_HEAD // Making it fit in both first just so it can properly fit on the head slot in the loadout
	flash_protect = FLASH_PROTECTION_NONE
	flags_cover = GLASSESCOVERSEYES
	custom_materials = null // Don't want that to go in the autolathe
	visor_vars_to_toggle = 0
	tint = 0

	/// Was welding protection added yet?
	var/welding_upgraded = FALSE
	/// Was welding protection toggled on, if welding_upgraded is TRUE?
	var/welding_protection = FALSE
	/// The sound played when toggling the shutters.
	var/shutters_sound = 'sound/effects/clock_tick.ogg'

/obj/item/clothing/glasses/welding/steampunk_goggles/Initialize(mapload)
	. = ..()
	visor_toggling()

/obj/item/clothing/glasses/welding/steampunk_goggles/examine(mob/user)
	. = ..()
	if(welding_upgraded)
		. += "它已加装了焊接护片，目前处于[welding_protection ? "关闭" : "打开"]状态。"

/obj/item/clothing/glasses/welding/steampunk_goggles/item_action_slot_check(slot, mob/user)
	. = ..()
	if(. && (slot & ITEM_SLOT_HEAD))
		return FALSE

/obj/item/clothing/glasses/welding/steampunk_goggles/attack_self(mob/user)
	if(user.get_item_by_slot(ITEM_SLOT_HEAD) == src)
		to_chat(user, span_warning("你似乎没法把架在头顶的护目镜顺下来罩住眼睛！"))
		return
	. = ..()

/obj/item/clothing/glasses/welding/steampunk_goggles/visor_toggling()
	. = ..()
	slot_flags = up ? ITEM_SLOT_EYES | ITEM_SLOT_HEAD : ITEM_SLOT_EYES
	toggle_vision_effects()

/obj/item/clothing/glasses/welding/steampunk_goggles/adjust_visor(mob/user)
	. = ..()
	handle_sight_updating(user)

/obj/item/clothing/glasses/welding/steampunk_goggles/attackby(obj/item/attacking_item, mob/living/user, params)
	if(!istype(attacking_item, /obj/item/clothing/glasses/welding))
		return ..()

	if(welding_upgraded)
		to_chat(user, span_warning("\The [src] 已经升级过焊接防护了！"))
		return
	qdel(attacking_item)
	welding_upgraded = TRUE
	to_chat(user, span_notice("你给 \the [src] 加装了焊接护片，现在你可以切换焊接防护了！"))
	actions += new /datum/action/item_action/toggle_steampunk_goggles_welding_protection(src)

/// Proc that handles the whole toggling the welding protection on and off, with user feedback.
/obj/item/clothing/glasses/welding/steampunk_goggles/proc/toggle_shutters(mob/user)
	if(!can_use(user) || !user)
		return FALSE
	if(!toggle_welding_protection(user))
		return FALSE

	to_chat(user, span_notice("你推动 \the [src] 的焊接护片滑钮，将其[welding_protection ? "合上" : "打开"]。"))
	playsound(user, shutters_sound, 100, TRUE)
	if(iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		carbon_user.update_worn_head()
	update_item_action_buttons()
	return TRUE

/// This is the proc that handles toggling the welding protection, while also making sure to update the sight of a mob wearing it.
/obj/item/clothing/glasses/welding/steampunk_goggles/proc/toggle_welding_protection(mob/user)
	if(!welding_upgraded)
		return FALSE
	welding_protection = !welding_protection

	visor_vars_to_toggle = welding_protection ? VISOR_FLASHPROTECT | VISOR_TINT : initial(visor_vars_to_toggle)
	toggle_vision_effects()
	// We also need to make sure the user has their vision modified. We already checked that there was a user, so this is safe.
	handle_sight_updating(user)
	return TRUE

/// Proc handling changing the flash protection and the tint of the goggles.
/obj/item/clothing/glasses/welding/steampunk_goggles/proc/toggle_vision_effects()
	if(welding_protection)
		if(visor_vars_to_toggle & VISOR_FLASHPROTECT)
			flash_protect = up ? FLASH_PROTECTION_NONE : FLASH_PROTECTION_WELDER
	else
		flash_protect = FLASH_PROTECTION_NONE
	tint = flash_protect

/// Proc handling to update the sight of the user, while forcing an update_tint() call every time, due to how the welding protection toggle works.
/obj/item/clothing/glasses/welding/steampunk_goggles/proc/handle_sight_updating(mob/user)
	if(user && (user.get_item_by_slot(ITEM_SLOT_HEAD) == src || user.get_item_by_slot(ITEM_SLOT_EYES) == src))
		user.update_sight()
		if(iscarbon(user))
			var/mob/living/carbon/carbon_user = user
			carbon_user.update_tint()
			carbon_user.update_worn_head()

/obj/item/clothing/glasses/welding/steampunk_goggles/ui_action_click(mob/user, actiontype, is_welding_toggle = FALSE)
	if(!is_welding_toggle)
		return ..()
	else
		toggle_shutters(user)

/// Action button for toggling the welding shutters (aka, welding protection) on or off.
/datum/action/item_action/toggle_steampunk_goggles_welding_protection
	name = "切换焊接护片"

/// We need to do a bit of code duplication here to ensure that we do the right kind of ui_action_click(), while keeping it modular.
/datum/action/item_action/toggle_steampunk_goggles_welding_protection/Trigger(trigger_flags)
	if(!..())
		return FALSE
	if(!target || !istype(target, /obj/item/clothing/glasses/welding/steampunk_goggles))
		return FALSE

	var/obj/item/clothing/glasses/welding/steampunk_goggles/goggles = target
	goggles.ui_action_click(owner, src, is_welding_toggle = TRUE)
	return TRUE

// End of the code for GoldenAlpharex's donator item :^)

// Donation reward for MyGuy49
/obj/item/clothing/suit/cloak/ashencloak
	name = "灰白荒行者斗篷"
	desc = "一件做工精良的斗篷，显然不是灰行者能做出来的东西，多半是从某艘坠毁的飞船之类的地方弄来的。它似乎用歌利亚的皮与守望者的筋腱加固过，兜帽则已被扯掉。"
	icon_state = "ashencloak"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|LEGS|ARMS
	supports_variations_flags = NONE

//Donation reward for Hacker T.Dog
/obj/item/clothing/head/nanotrasen_consultant/hubert
	name = "中央指挥部少尉帽"
	desc = "一顶量身定制的军官大檐帽，标示着少尉军衔。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "CCofficerhat"

//Donation reward for Hacker T.Dog
/obj/item/clothing/suit/armor/vest/nanotrasen_consultant/hubert
	name = "中央指挥部少尉装甲背心"
	desc = "一件量身定制的少尉装甲背心，防护效果相同，但更有型。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "CCvest"

//Donation reward for Hacker T.Dog
/obj/item/clothing/under/rank/nanotrasen_consultant/hubert
	name = "中央指挥部少尉制服"
	desc = "一件量身定制的少尉制服，上面垂挂着各式奖章和链条。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	icon_state = "CCofficer"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for Cherno_00
/obj/item/clothing/head/costume/ushanka/frosty
	name = "蓝色护耳冬帽"
	desc = "一顶深蓝色护耳冬帽，正面手缝着一片雪花。摸上去凉凉的。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "fushankadown"
	upsprite = "fushankaup"
	downsprite = "fushankadown"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null

// Donation reward for M97screwsyourparents
/obj/item/clothing/neck/cross
	name = "银十字架"
	desc = "一枚挂在链子上戴在颈间的银十字架。必定能从上头为你带来庇佑。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/necklaces.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "cross"

// Donation reward for gamerguy14948
/obj/item/storage/belt/fannypack/occult
	name = "小饰品腰带"
	desc = "一条挂满多年来收集的小饰品的腰带。看样子现在已没剩多少空间放别的东西了。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/belt.dmi'
	icon_state = "occultfannypack"
	worn_icon_state = "occultfannypack"

// Donation reward for gamerguy14948
/obj/item/clothing/under/occult
	name = "秘术收藏家套装"
	desc = "一套适合衣着考究、又不介意弄脏的人的服装。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "occultoutfit"
	supports_variations_flags = NONE

// Donation reward for gamerguy14948
/obj/item/clothing/head/hooded/occult
	name = "兜帽"
	desc = "肯定让你看上去更阴森。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "occulthood"
	supports_variations_flags = NONE

// Donation reward for gamerguy14948
/obj/item/clothing/suit/hooded/occult
	name = "秘术收藏家外套"
	desc = "一件宽大厚重的大衣，内衬皮革与象牙白布料，还带有兜帽。看起来灰扑扑的。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "occultcoat"
	hoodtype = /obj/item/clothing/head/hooded/occult
	supports_variations_flags = NONE

// Donation reward for Octus
/obj/item/clothing/mask/breath/vox/octus
	name = "阴险面甲"
	desc = "尖啸无敌。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	worn_icon_vox = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask_vox.dmi'
	icon_state = "death"

// Donation reward for 1ceres
/obj/item/clothing/glasses/rosecolored
	name = "玫瑰色眼镜"
	desc = "护目镜形状的眼镜，似乎内嵌着某种古怪的线条文字脚本式 HUD 信息流。看起来不像是纳米传讯做的。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "rose"

// Donation reward for Fuzlet
/obj/item/card/fuzzy_license
	name = "拥抱许可证"
	desc = "一张看起来非常正式的许可证。实际上并未获得纳米传讯的认可。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "license"

	var/possible_types = list(
		"拥抱",
		"依偎",
		"搂抱",
		"亲吻",
		"宠朋友",
		"牵手",
		"持有此证",
		"吱吱叫",
		"卖萌",
		"摸摸头",
		"派发玩偶",
		"分发饼干",
		"做爱",
		"呜咽")

/obj/item/card/fuzzy_license/attack_self(mob/user)
	if(Adjacent(user))
		user.visible_message(span_notice("[user] 向你展示：[icon2html(src, viewers(user))] [src.name]。"), span_notice("你展示了 \the [src.name]。"))
	add_fingerprint(user)

/obj/item/card/fuzzy_license/attackby(obj/item/used, mob/living/user, params)
	if(user.ckey != "fuzlet")
		return

	if(istype(used, /obj/item/pen) || istype(used, /obj/item/toy/crayon))
		var/choice = input(user, "选择许可证类型", "许可证类型选择") as null|anything in possible_types
		if(!isnull(choice))
			name = "许可证：[choice]"

// Donation reward for 1ceres
/obj/item/clothing/suit/jacket/gorlex_harness
	name = "引擎技师背带"
	desc = "一件血红色的工程技师背带。你实在想不出它有什么用，但它某些部位似乎能以磁力扣合。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "gorlexharness"

// Donation reward for 1ceres
/obj/item/poster/korpstech
	name = "Korps 遗传学海报"
	poster_type = /obj/structure/sign/poster/contraband/korpstech
	icon_state = "rolled_poster"

/obj/structure/sign/poster/contraband/korpstech
	name = "Korps 遗传学"
	desc = "这张海报上印着一个巨大的粉色螺旋，下方的小字写着“Korps 研究所，自 2423 年起推动遗传学发展！”"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "korpsposter"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/korpstech, 32)

// Donation reward for Kay-Nite
/obj/item/clothing/glasses/eyepatch/rosecolored
	name = "玫瑰色眼罩"
	desc = "一副定制的眼罩，前面悬浮着明亮的粉色 HUD。从它所用的材料来看，它似乎不只是一只眼罩那么简单。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "rosepatch_R"
	base_icon_state = "rosepatch"

// Donation reward for Cimika
/obj/item/clothing/suit/toggle/labcoat/skyrat/tenrai
	name = "天雷实验袍"
	desc = "一件用各种纯净材料制成的实验袍，缝制手艺好得令人心惊。布料轻盈，滑如丝绸，触感异常舒服。金色条纹在黑暗中也能看见，为伤者指引方向。内侧的小标签上写着“天雷狐族至上”。"
	base_icon_state = "tenraicoat"
	icon_state = "tenraicoat"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/skyrat/tenrai/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

//Donation reward for RealWinterFrost
/obj/item/clothing/neck/cloak/fluffycloak
	name = "毛绒之主的斗篷"
	desc = "它只懂得拥抱与亲吻，愿它们的拥抱给予所有人，而不是只留给自己的“仅限弗菲使用”。"
	icon_state = "fluffycloak"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'

/obj/item/clothing/neck/cloak/fluffycloak/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)


/obj/item/clothing/mask/gas/larpswat
	name = "泡沫部队特警面具"
	desc = "乍看像一张特警面具，其实是一只防毒面具，只是用廉价塑料做了特警面具的仿制部件。不过至少，如果你喜欢扮成安保兵的样子，它还挺好看的。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "larpswat"
	supports_variations_flags = NONE

// Donation reward for Cimika, on behalf of tf4
/obj/item/clothing/neck/fishpendant
	name = "鱼形项链"
	desc = "一条简单的银项链，坠着一只蓝色金枪鱼吊坠。\n背面刻着“L. Alazawi”。你总觉得它配土豆和青豆会很搭。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/necklaces.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "fishpendant"

// Donation reward for Weredoggo
/obj/item/hairbrush/tactical
	name = "战术发刷"
	desc = "有时候，在与死亡擦肩而过之后，好好梳整一番正是缓解战术压力的最佳方式。 "
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "tacticalbrush"
	inhand_icon_state = "tacticalbrush"

// Donation reward for ultimarifox
/obj/item/clothing/under/rank/security/head_of_security/alt/roselia
	name = "黑红高领衫"
	desc = "一件黑色高领衫，接有红色饰边。让你想起蓝色出现之前的年代。而且它看起来里里外外都塞满了衬垫。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "hosaltred"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga/roselia
	name = "红色千兆 HUD GAR 墨镜"
	desc = "镜片中植入安保 HUD 的千兆 GAR 墨镜。让你想起蓝色出现之前的年代。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "supergarsred"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'

//Donation reward for Konstyantyn
/obj/item/clothing/accessory/badge/holo/jade
	name = "翡翠全息徽章"
	desc = "一枚奇特的绿色全息徽章。上面压印着“乌利亚中尉”，下方是字母 JS。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "greenbadge"

// Donation reward for Dudewithatude
/obj/item/clothing/suit/toggle/rainbowcoat
	name = "彩虹外套"
	desc = "一件绚丽非凡、能显现彩虹色彩的外套！"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "rainbowcoat"
	base_icon_state = "rainbowcoat"

// Donation reward for M97screwsyourparents
/obj/item/clothing/head/recruiter_cap
	name = "招募员帽子"
	desc = "嘿，免费上大学！"
	icon_state = "officerhat"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_state = "officerhat"

// Donation reward for M97screwsyourparents
/obj/item/clothing/suit/toggle/recruiter_jacket
	name = "招募员夹克"
	desc = "嘿，免费上大学！"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "officerjacket"
	base_icon_state = "officerjacket"

// Donation reward for M97screwsyourparents
/obj/item/clothing/under/recruiter_uniform
	name = "招募员制服"
	desc = "嘿，免费上大学！"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "oldmarine_whites"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = null
	can_adjust = FALSE

//Donation reward for Tetrako
/obj/item/clothing/under/nt_idol_skirt
	name = "\improper 纳米传讯偶像的西装裙"
	desc = "这套服装与其他高阶纳米传讯军官的款式十分相似，但带着不少花哨的点缀，比如裙摆周围的褶边、肩部微微的蓬起，最重要的是几枚金色搭扣，用来衬托那一身绿！只有这种衣服才配得上纳米传讯自家的偶像们穿！"
	icon = 'icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'icons/mob/clothing/under/centcom.dmi'
	icon_state = "centcom_skirt"
	inhand_icon_state = "dg_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for SlippyJoe
/obj/item/clothing/accessory/hypno_watch
	name = "破裂的怀表"
	desc = "一只闪亮的金质怀表，表面压印着金属漩涡纹，在合适的光线下几乎泛出紫水晶般的光泽……顶部有一个按钮可以弹开前盖，然而里面只有一层碎裂的玻璃，银色的指针卡在晚上 7:07。若目光停留过久，这些银色箭头上的拉丝纹理几乎像是在流转。尽管外表毫无动静，这件器物内部却似乎隐约传出齿轮转动、咔哒咬合的诡异机械声。落在对的人手里……"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	worn_icon_state = "pocketwatch"
	icon_state = "pocketwatch"
	inhand_icon_state = "pocketwatch"
	var/list/spans = list("velvet")
	actions_types = list(/datum/action/item_action/hypno_whisper)

//TODO: make a component for all that various hypno stuff instead of adding it to items individually
/obj/item/clothing/accessory/hypno_watch/ui_action_click(mob/living/user, action)
	if(!isliving(user) || !can_use(user))
		return
	var/message = input(user, "以催眠低语说话", "低语")
	if(QDELETED(src) || QDELETED(user) || !message || !user.can_speak())
		return
	user.whisper(message, spans = spans)

/obj/item/clothing/accessory/hypno_watch/examine()
	. = ..()
	. += span_boldwarning("谁知道它能用来做什么呢？")

// Donation reward for BoisterousBeebz

/obj/item/clothing/under/bubbly_clown/skirt
	name = "泡泡小丑连衣裙"
	desc = "一件鲜亮欢快的小丑连衣裙，洪克！"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "bubbly_clown_dress"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for Sweetsoulbrother
/obj/item/coin/donator/marsoc
	name = "MARSOC 挑战币"
	desc = "这是一枚颁发给所有光荣退役的 MARSOC 成员的挑战币。 \
			硬币一面是海军特种作战司令部的徽记，另一面是地球政府海军陆战队的标志。 \
			这一枚在海军陆战队标志那一面刻有一圈铭文： \
			“致亨利·洛克威尔上士，表彰他对特种作战社群堪称典范的贡献、他出众的道德品格， \
			以及作为地球政府海军陆战队核心价值的光辉榜样。”"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	sideslist = list("MARSOC", "SFMC")

// Donation reward for Kay-Nite
/obj/item/clothing/under/tactichill
	name = "战术休闲夹克"
	desc = "战术潮服中更鲜亮的一款，适合你想打扮得比平时更酷、同时还要继续行动的时候。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	icon_state = "tactichill"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

// Donation reward for thedragmeme
/obj/item/clothing/shoes/fancy_heels/drag
	desc = "一双精致的高跟鞋。咔哒、咔哒、咔哒……绝对能引来不少回头率。"

/obj/item/clothing/shoes/fancy_heels/drag/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/effects/footstep/highheel1.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel2.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel3.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel4.ogg' = 1), 70)

// Donation reward for Razurath

/obj/item/clothing/under/bimpcap
	name = "正式哑光黑舰长制服"
	desc = "一件看起来相当专业的哑光黑制服，缀满表彰卓越服役与英勇的奖章，只有站上最高级别的官员才会穿着。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "bimpcap"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for Nikohyena
/obj/item/clothing/glasses/gold_aviators
	name = "紫金飞行员墨镜"
	desc = "一副圆形金框飞行员墨镜，镜片染上了宝石般的紫色。"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "goldaviator"

// Donation reward for Thedragmeme
/obj/item/clothing/under/caged_dress/skirt
	name = "笼裙式紫裙"
	desc = "一件丝滑的紫色连衣裙，下方露出部分裙撑结构。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "caged_dress"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'

// Donation reward for Thedragmeme
/obj/item/clothing/suit/short_coat
	name = "短款紫外套"
	desc = "一件黑紫相间的短外套，主要用于美观，而非为穿着者保暖。"
	icon_state = "short_coat"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for Thedragmeme
/obj/item/clothing/neck/flower_collar
	name = "花朵项圈"
	desc = "一只紫色项圈，右侧缀着一朵小巧的红花。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/necklaces.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "flower_collar"
	kink_collar = TRUE

// Donation reward for Sigmar Alkahest
/obj/item/clothing/under/costume/skyrat/kimono/sigmar
	name = "短袖和服"
	desc = "一件传统的地球古代日式和服。白色底，配金色滚边与做旧金色的常春藤纹样。"
	icon_state = "kimono-gold"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	gets_cropped_on_taurs = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for Sigmar Alkahest
/obj/item/clothing/head/hooded/sigmarcoat
	name = "黑色雨衣兜帽"
	desc = "肯定让你看上去更阴森。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "long-coat-hood"
	supports_variations_flags = NONE

// Donation reward for Sigmar Alkahest
/obj/item/clothing/suit/hooded/sigmarcoat
	name = "黑色开襟雨衣"
	desc = "一件轻薄的黑色雨衣。你都不知道他们还会做这个颜色的雨衣。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "long-coat"
	hoodtype = /obj/item/clothing/head/hooded/sigmarcoat
	supports_variations_flags = NONE

// Donation reward for The Sharkenning

/obj/item/clothing/gloves/ring/hypno/sharkenning
	name = "可疑的光亮戒指"
	desc = "这枚戒指透着一种凌厉的气息，锐利的光线在光滑的黑青铜表面蜿蜒流转。如同戴着它的那根手指，异常考究的抛光几乎反射掉了所有掠过表面的光。若凑近细看，还能见到一丝金色光泽，昭示着合金内部所含的贵金属。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'
	icon_state = "ringblack"
	worn_icon_state = "ringblack"
	lefthand_file = null
	righthand_file = null
	spans = list("glossy")

/obj/item/clothing/ears/kinky_headphones/sharkenning
	name = "可疑的光亮耳机"
	desc = "黑色金属耳机，表面带有光泽。柔软的橡胶耳垫舒适且贴合。"
	icon_state = "kinkphones_black_off"
	base_icon_state = "kinkphones"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/ears.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/ears.dmi'
	inhand_icon_state = null
	current_kinkphones_color = "black"
	color_changed = TRUE

//reward for SomeRandomOwl
/obj/item/clothing/head/costume/strigihat
	name = "星光女巫帽"
	desc = "一顶可爱的女巫帽，通常由像猫头鹰一样的特沙利戴着。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/head_teshari.dmi'
	icon_state = "strigihat"

//Donation reward for Razurath
/obj/item/clothing/head/razurathhat
	name = "金色纳米传讯军官帽"
	desc = "一顶纳米传讯军官帽。现在更深、更金、更酷了！"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "razurath_hat"

//Donation reward for Razurath
/obj/item/clothing/suit/razurathcoat
	name = "金色纳米传讯军官外套"
	desc = "一件精致的纳米传讯军官外套。现在比以往更深、更金、更酷！"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "razurath_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for MaSvedish
/obj/item/holocigarette/masvedishcigar
	name = "全息雪茄"
	desc = "一件发出柔和嗡鸣的装置，用全息甲板技术模拟缓慢燃烧的雪茄。现在还采用了低电击技术。金色标签上刻着一个小小的“MG”。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	inhand_icon_state = "masvedishcigar_off"
	worn_icon_state = "masvedishcigar_off"
	icon_state = "masvedishcigar_off"
	icon_on = "masvedishcigar_on"
	icon_off = "masvedishcigar_off"

// Donation reward for LT3
/obj/item/clothing/suit/armor/skyy
	name = "银色夹克 Mk II"
	desc = "一件专为气场强大者打造的夹克。由合成纤维制成，织入了特殊合金，既提供额外防护又很时尚。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "lt3_jacket"
	inhand_icon_state = "syndicate-black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/jacket/skyy
	name = "银色夹克"
	desc = "一件专为气场强大者打造的夹克。由合成纤维制成，织入了特殊合金，既提供额外防护又很时尚。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "lt3_jacket"
	inhand_icon_state = "syndicate-black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/pants/skyy
	name = "银色牛仔裤"
	desc = "一条专为气场强大者打造的牛仔裤。由闪亮的银色丹宁布制成，织入了特殊合金，既提供额外防护又很时尚。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "lt3_jeans"
	inhand_icon_state = "lt3_jeans"

/obj/item/clothing/gloves/skyy
	name = "炭灰色无指手套"
	desc = "比起实用更看重造型，这副手套几乎只遮得住你的掌心。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'
	icon_state = "lt3_gloves"

// Donation reward for Lolpopomg101
/obj/item/clothing/suit/hooded/colorblockhoodie
	name = "拼色连帽衫"
	desc = "一件来自某个认不出的品牌的柔和粉彩拼色连帽衫。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "colorblockhoodie"
	hoodtype = /obj/item/clothing/head/hooded/colorblockhoodie
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hooded/colorblockhoodie
	name = "兜帽"
	desc = "里面非常柔软！"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "colorblockhood"
	flags_inv = HIDEHAIR

/obj/item/clothing/suit/toggle/digicoat
	toggle_noun = "全息显示屏"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//Public donation reward for Razurath
/obj/item/clothing/suit/toggle/digicoat/glitched
	name = "被黑入的数字外套"
	desc = "背面显示着故障的图像。酷！"
	base_icon_state = "digicoat_glitched"
	icon_state = "digicoat_glitched"

/obj/item/clothing/suit/toggle/digicoat/nanotrasen
	name = "纳米传讯数字外套"
	desc = "一件设计很受欢迎的公司夹克。"
	base_icon_state = "digicoat_nt"
	icon_state = "digicoat_nt"

/obj/item/clothing/suit/toggle/digicoat/interdyne
	name = "英特戴恩数字外套"
	desc = "一件来自一家眼熟公司的阴森配色夹克。"
	base_icon_state = "digicoat_interdyne"
	icon_state = "digicoat_interdyne"

/obj/item/clothing/suit/armor/hos/elofy
	name = "动画提督外套"
	desc = "这件外套几乎完美复刻了《银河冲突英雄传》主角李舜臣提督所穿的那一件， \
		这是一部以自由行星贸易联盟与第二银河帝国为背景的动画战争剧。 \
		在欣赏动画片与年代战争剧的人群中，它曾是一件轰动一时的单品， \
		但在地球政府之外并没有流传多广。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "coat_blackred"
	inhand_icon_state = "hostrench"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = NONE

/obj/item/clothing/suit/armor/hos/elofy/examine_more(mob/user)
	. = ..()
	. += "它摸起来格外柔软，柔软的布料里织入了细微的防弹纤维，并且完美贴合穿着者的身体。每一处金色刻纹在你眼前都会反射出微微刺目的光芒。这是一整套月狼军团战服的一部分。"


/obj/item/clothing/head/hats/hos/elofy
	name = "动画提督帽"
	desc = "这顶帽子几乎完美复刻了《银河冲突英雄传》主角李舜臣提督所戴的那一顶， \
		这是一部以自由行星贸易联盟与第二银河帝国为背景的动画战争剧。 \
		在欣赏动画片与年代战争剧的人群中，它曾是一件轰动一时的单品， \
		但在地球政府之外并没有流传多广。"
	icon ='modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "hat_black"

/obj/item/clothing/gloves/elofy
	name = "动画提督手套"
	desc = "这副手套几乎完美复刻了《银河冲突英雄传》主角李舜臣提督所戴的那一副， \
		这是一部以自由行星贸易联盟与第二银河帝国为背景的动画战争剧。 \
		在欣赏动画片与年代战争剧的人群中，它曾是一件轰动一时的单品， \
		但在地球政府之外并没有流传多广。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'
	icon_state = "gloves_black"

/obj/item/clothing/shoes/jackboots/elofy
	name = "动画提督靴"
	desc = "这双靴子几乎完美复刻了《银河冲突英雄传》主角李舜臣提督所穿的那一双， \
		这是一部以自由行星贸易联盟与第二银河帝国为背景的动画战争剧。 \
		在欣赏动画片与年代战争剧的人群中，它曾是一件轰动一时的单品， \
		但在地球政府之外并没有流传多广。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/feet.dmi'
	icon_state = "boots_blackred"

// Donation reward for grasshand
/obj/item/clothing/under/rank/civilian/chaplain/divine_archer/noble
	name = "贵族武装衣"
	desc = "这些衣服让你觉得离太空更近了一点。"
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/civilian_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/civilian_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/shoes/jackboots/noble
	name = "贵族靴"
	desc = "这双靴子让你觉得自己能在太空上行走。"
	icon_state = "archerboots"
	inhand_icon_state = "archerboots"

// Donation reward for nikotheguydude
/obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "vickyred"
	name = "贵族礼服外套"
	desc = "一件精巧的外套，由丝滑却挺括的材料制成。 \
		布料相当薄，提供的防护与保暖几乎可以忽略， \
		但贴在皮肤上很舒服。\n虽然做工极佳，它看起来却相当 \
		脆弱，而且颇为<i>昂贵</i>。你总觉得如果不作专门处理，它可能撑不过 \
		一台<b>洗衣机</b>。"
	special_desc = "它的纽扣上压印着某种纹章——对熟悉提兹拉政治或贵族的人而言， \
		可以认出那是 <b>Kor'Yesh 家徽</b>， \
		<i>提兹拉</i>境内一个相对<i>不起眼的贵族家族</i>。\n\n\
		再仔细查看，内里似乎经过改装，加上了防护材料与挂载点， \
		这类设计最常见于医疗实验袍。"
	limb_integrity = 100 // note that this is usually disabled by having it set to 0, so this is just strictly worse
	body_parts_covered = CHEST|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator/Initialize(mapload)
	. = ..()

	qdel(GetComponent(/datum/component/toggle_icon)) // we dont have a toggle icon

#define NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED 2500

// this is based on an in-joke with the character whom inspires this donator item, where they need a fuckton of money to wash their coat. this takes it literally
/obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator/machine_wash(obj/machinery/washing_machine/washer)

	var/total_credits = 0
	var/list/obj/item/money_to_delete = list()
	for (var/obj/item/holochip/chip in washer)
		total_credits += chip.get_item_credit_value()
		money_to_delete += chip
		if (total_credits >= NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED)
			break
	if (total_credits < NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED)
		for (var/obj/item/stack/spacecash/cash in washer)
			total_credits += cash.get_item_credit_value()
			money_to_delete += cash
			if (total_credits >= NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED)
				break

	var/message
	var/sound_effect_path
	var/sound_effect_volume
	if (total_credits >= NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED) // all is well
		message = span_notice("[src] 似乎从周围吸收了纯粹的资本，并被成功洗净！")
		sound_effect_path = 'sound/effects/whirthunk.ogg'
		sound_effect_volume = 40
		for (var/obj/item/entry_to_delete as anything in money_to_delete)
			qdel(entry_to_delete)
	else // IT COSTS ME A THOUSAND CREDITS TO WASH THIS!! HALF MY BUDGET IS DRY CLEANING
		message = span_warning("[src] 娇贵的布料被 [washer] 撕碎了！太可怕了！")
		sound_effect_path = 'sound/effects/cloth_rip.ogg'
		sound_effect_volume = 30
		for (var/zone in cover_flags2body_zones(body_parts_covered))
			take_damage_zone(zone, limb_integrity * 1.1, BRUTE) // fucking shreds it

	var/turf/our_turf = get_turf(src)
	our_turf.visible_message(message)
	playsound(src, sound_effect_path, sound_effect_volume, FALSE)

	return ..()

/obj/item/clothing/under/costume/dragon_maid
	name = "龙女仆制服"
	desc = "一件厨房女仆的制服，带有龙族风格的装饰细节。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "dragon_maid"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	can_adjust = FALSE

#undef NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED

//  Donation reward for vexcint
/obj/item/clothing/head/anubite
	name = "\improper 阿努比斯信徒头饰"
	desc = "一件深色头饰，带金色点缀。它的造型让人联想到阿努比斯神。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	icon_state = "anubite_headpiece"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	worn_y_offset = 4

//Donation reward for Jasohavents
/obj/item/clothing/under/rank/cargo/qm/skirt/old
	name = "货运主管的连体短裙"
	desc = "看来有人留着几套过时的货运主管制服。它们闻起来有朗姆酒和烟味。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'

//Donation reward for Jasohavents
/obj/item/food/griddle_toast/toaster_implant
	name = "吐司"
	desc = "厚切面包，烤得恰到好处。"
	food_reagents = list(/datum/reagent/consumable/nutriment = 1)
//it's meant to be practically non-functional in terms of giving any ingame advantage, but it seems food needs to have *something* in it to be edible
//it *can* be a whole thing with a "gridle" that only accepts bread from the user's hand but I can't be assed to implement it for a one-off gimmick donator item

#define TOASTER_IMPLANT_COOLDOWN (3 MINUTES)
/obj/item/implant/toaster
	name = "烤面包机植入体"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "griddle_toast"
	COOLDOWN_DECLARE(toast_cooldown)

/obj/item/implant/toaster/get_data()
	var/dat = {"<b>植入体规格：</b><BR>
				<b>名称：</b>Toaster-O 牌烤面包模块<BR>
				<b>植入体详情：</b> <BR>
				<b>功能：</b>为你奉上一片美味的烤面包。"}
	return dat

/obj/item/implant/toaster/activate()
	. = ..()
	if(!COOLDOWN_FINISHED(src, toast_cooldown))
		imp_in.show_message(span_notice("你还没准备好再烤一片吐司。"))
		return

	var/obj/item/food/griddle_toast/toaster_implant/toast = new(get_turf(imp_in))
	var/adjective = pick("酥脆的", "美味的", "新鲜的")
	imp_in.visible_message(span_notice("[imp_in] 弹出了一片[adjective]吐司！"), span_notice("随着熟悉的“叮”声，烤面包机弹出了一片[adjective]吐司。"))

	playsound(imp_in, 'sound/machines/ding.ogg', vol = 75, vary = FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	toast.throw_at(get_turf(imp_in), 2, 3)
	COOLDOWN_START(src, toast_cooldown, TOASTER_IMPLANT_COOLDOWN)

/obj/item/implanter/toaster
	name = "植入器（烤面包机）"
	imp_type = /obj/item/implant/toaster

/obj/item/implantcase/toaster
	name = "植入体盒 -“烤面包机”"
	desc = "一个装有烤面包机植入体的玻璃盒。真甜。"
	imp_type = /obj/item/implant/toaster

#undef TOASTER_IMPLANT_COOLDOWN
