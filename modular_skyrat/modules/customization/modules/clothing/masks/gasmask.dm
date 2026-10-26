/obj/item/clothing/mask/gas/glass
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	name = "玻璃防毒面具"
	desc = "一种可连接气源、覆盖面部的面罩。不过这一款不会遮住你的脸。"
	icon_state = "gas_clear"
	flags_inv = NONE

/obj/item/clothing/mask/gas/atmos/glass
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	name = "高级防毒面具"
	desc = "一种可连接气源、覆盖面部的面罩。不过这一款不会遮住你的脸。"
	icon_state = "gas_clear"
	flags_inv = NONE

/obj/item/clothing/mask/gas/alt
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	icon_state = "gas_alt2"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'

/obj/item/clothing/mask/gas/german
	name = "黑色防毒面具"
	desc = "一顶黑色防毒面具。你是我的妈咪吗？"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "m38_mask"

/obj/item/clothing/mask/gas/hecu1
	name = "现代防毒面具"
	desc = "我。的。屁。股。真。沉。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "hecu"

/obj/item/clothing/mask/gas/hecu2
	name = "M40 防毒面具"
	desc = "一种在 20 世纪于太阳系第三行星开发、现已停用的野战防护面具。它设计用于防护化学制剂、生物制剂和核沉降颗粒。但它不能保护使用者免受氨气侵害，也无法提供氧气，不过滤罐可以换成连接任何气瓶的软管。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/mask.dmi'
	icon_state = "hecu2"

/obj/item/clothing/mask/gas/soviet
	name = "苏联防毒面具"
	desc = "一顶带绿色滤罐的白色防毒面具，上面贴着一张小标签，证明它不含石棉！还有一张更小的标签被撕掉了。没什么好担心的。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "gp5_mask"

/obj/item/clothing/mask/gas/clown_colourable
	name = "可染色小丑面具"
	desc = "纯粹邪恶的面孔，如今变得五彩斑斓。"
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/gas/clown_colourable"
	post_init_icon_state = "gags_mask"
	clothing_flags = MASKINTERNALS
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	greyscale_config = /datum/greyscale_config/clown_mask
	greyscale_config_worn = /datum/greyscale_config/clown_mask/worn
	greyscale_colors = "#FFFFFF#F20018#0000FF#00CC00"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/mask/gas/clownbald
	name = "秃头小丑面具"
	desc = "他秃了，他他妈的在变秃！"
	clothing_flags = MASKINTERNALS
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "baldclown"
	inhand_icon_state = null
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE

/obj/item/clothing/mask/gas/respirator
	name = "半面罩呼吸器"
	desc = "一种半面罩呼吸器，其实只是摘掉玻璃的普通防毒面具。"
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/gas/respirator"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/masks.dmi'
	post_init_icon_state = "respirator"
	inhand_icon_state = "sechailer"
	w_class = WEIGHT_CLASS_SMALL
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEFACIALHAIR|HIDESNOUT
	flags_cover = MASKCOVERSMOUTH
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#2E3333"
	greyscale_config = /datum/greyscale_config/respirator
	greyscale_config_worn = /datum/greyscale_config/respirator/worn
	//NIGHTMARE NIGHTMARE NIGHTMARE
	greyscale_config_worn_digi = /datum/greyscale_config/respirator/worn/snouted
	greyscale_config_worn_better_vox = /datum/greyscale_config/respirator/worn/better_vox
	greyscale_config_worn_vox = /datum/greyscale_config/respirator/worn/vox
	greyscale_config_worn_teshari = /datum/greyscale_config/respirator/worn/teshari

/obj/item/clothing/mask/gas/respirator/examine(mob/user)
	. = ..()
	. += span_notice("你可以用 <b>Ctrl 点击</b> 切换它是否遮挡你的 TTS 语音。")

/obj/item/clothing/mask/gas/respirator/item_ctrl_click(mob/living/user)
	if(!isliving(user))
		return
	if(user.get_active_held_item() != src)
		to_chat(user, span_warning("你必须把 [src] 拿在手里才能这样做！"))
		return
	voice_filter = voice_filter ? null : initial(voice_filter)
	to_chat(user, span_notice("面具声音遮挡已[voice_filter ? "开启" : "关闭"]。"))

/obj/item/clothing/mask/gas/clown_hat/vox
	desc = "真正恶作剧大师的面部装束。没有假发和面具的小丑是不完整的。这一款设有方便取用的进食口，更适合沃克斯船员。"
	icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_better_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	starting_filter_type = /obj/item/gas_filter/vox

/obj/item/clothing/mask/gas/clown_hat/vox/Initialize(mapload)
	.=..()
	clownmask_designs = list(
		"真实形态" = image(icon = src.icon, icon_state = "clown"),
		"女权主义者" = image(icon = src.icon, icon_state = "sexyclown"),
		"巫师" = image(icon = src.icon, icon_state = "wizzclown"),
		"弄臣" = image(icon = src.icon, icon_state = "chaos"),
		"疯汉" = image(icon = src.icon, icon_state = "joker"),
		"彩虹色" = image(icon = src.icon, icon_state = "rainbow")
		)

/obj/item/clothing/mask/gas/clown_hat/vox/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated)
		return

	var/list/options = list()
	options["真实形态"] = "clown"
	options["女权主义者"] = "sexyclown"
	options["巫师"] = "wizzclown"
	options["疯汉"] = "joker"
	options["彩虹色"] = "rainbow"
	options["弄臣"] = "chaos"

	var/choice = show_radial_menu(user,src, clownmask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !user.incapacitated && in_range(user,src))
		icon_state = options[choice]
		user.update_worn_mask()
		update_item_action_buttons()
		to_chat(user, span_notice("你的小丑面具已变化为[choice]，赞美洪克之母！"))
		return TRUE

/obj/item/clothing/mask/gas/mime/vox
	desc = "传统默剧演员的面具。它有着诡异的面部姿态。这一款设有方便取用的进食口，更适合沃克斯船员。"
	icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_better_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	starting_filter_type = /obj/item/gas_filter/vox

/obj/item/clothing/mask/gas/mime/vox/Initialize(mapload)
	.=..()
	mimemask_designs = list(
		"纯白" = image(icon = src.icon, icon_state = "mime"),
		"兴奋" = image(icon = src.icon, icon_state = "sexymime"),
		"悲伤" = image(icon = src.icon, icon_state = "sadmime"),
		"惊恐" = image(icon = src.icon, icon_state = "scaredmime")
		)

/obj/item/clothing/mask/gas/mime/vox/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated)
		return

	var/list/options = list()
	options["纯白"] = "mime"
	options["悲伤"] = "sadmime"
	options["惊恐"] = "scaredmime"
	options["兴奋"] = "sexymime"

	var/choice = show_radial_menu(user,src, mimemask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !user.incapacitated && in_range(user,src))
		var/mob/living/carbon/human/human_user = user
		if(human_user.dna.species.mutant_bodyparts[FEATURE_SNOUT])
			icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
			worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
			var/list/avian_snouts = list("Beak", "Big Beak", "Corvid Beak")
			if(human_user.dna.species.mutant_bodyparts[FEATURE_SNOUT][MUTANT_INDEX_NAME] in avian_snouts)
				icon_state = "[options[choice]]_b"
		else
			icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
			worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
			icon_state = options[choice]
		icon_state = options[choice]

		user.update_worn_mask()
		update_item_action_buttons()
		to_chat(user, span_notice("你的默剧面具已变化为[choice]！"))
		return TRUE

/obj/item/clothing/mask/gas/atmos/vox
	desc = "大气技师使用的改进型防毒面具。它防火！这一款设有方便取用的进食口，更适合沃克斯船员。"
	icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_better_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	starting_filter_type = /obj/item/gas_filter/vox

/obj/item/clothing/mask/gas/sechailer/vox
	desc = "标准配发的安保防毒面具，内置“Compli-o-nator 3000”装置。它能播放十几种预录的服从语句，旨在让你在电击那些混蛋时让他们乖乖站好。请勿擅自改装该装置。这一款设有方便取用的进食口，更适合沃克斯船员。"
	icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_better_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS | GAS_FILTERING
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS | GAS_FILTERING
	starting_filter_type = /obj/item/gas_filter/vox
