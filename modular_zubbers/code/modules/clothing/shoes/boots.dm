/obj/item/clothing/shoes/boots/diver //Donor item for patriot210
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'
	name = "黑色潜水靴"
	desc = "一双老旧靴子，曾属于如今已解体的某个采矿联盟，外形接近纳米传讯矿工所穿的款式，只是没有用来装小物件的隔层。"
	icon_state = "diver"
	worn_icon_state = "diver"

/obj/item/clothing/shoes/fancy_heels/cc
	name = "纳米传讯高跟鞋"
	desc = "这肯定不是官方配发的。对吧？"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/cc"
	greyscale_colors = "#316E4A"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/syndi
	name = "辛迪加高跟鞋"
	desc = "一双在“跟”字上做足文章的高跟鞋。"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/syndi"
	greyscale_colors = "#18191E"
	body_parts_covered = parent_type::body_parts_covered | LEGS
	armor_type = /datum/armor/shoes_combat

	lace_time = 12 SECONDS
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	strip_delay = 2 SECONDS
	force = 10
	throwforce = 15
	sharpness = SHARP_POINTY
	attack_verb_continuous = list("攻击", "切片", "斩击", "切割", "刺击")
	attack_verb_simple = list("攻击", "切片", "斩击", "切割", "刺击")
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/wizard
	name = "魔法高跟鞋"
	desc = "一双似乎能用魔法解决穿高跟鞋行走一切问题的鞋子。"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/wizard"
	strip_delay = 2 SECONDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	greyscale_colors = "#291A69"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/red
	name = "红色高跟鞋"
	desc = "一双优雅的红色高跟鞋。"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/red"
	greyscale_colors = "#921C25"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/blue
	name = "蓝色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/blue"
	greyscale_colors = "#41579a"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/lightgrey
	name = "浅灰色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/lightgrey"
	greyscale_colors = "#d0d7da"
	flags_1 = null

//HEELED STUFF (NOT THE FANCY HEELS) SPRITES BY DimWhat OF MONKE STATION

/obj/item/clothing/shoes/workboots/mining/heeled
	name = "高跟采矿靴"
	desc = "钢头采矿高跟靴，专为危险环境下的采矿作业打造。这主意糟透了。"
	icon_state = "explorer_heeled"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	species_exception = null

/obj/item/clothing/shoes/fancy_heels/navyblue
	name = "藏青色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/navyblue"
	greyscale_colors = "#362f68"
	flags_1 = null

/obj/item/clothing/shoes/workboots/heeled
	name = "高跟工作靴"
	desc = "纳米传讯工程部配发的系带高跟工作靴，几乎像是专门为了引发工伤事故而设计的。"
	icon_state = "workboots_heeled"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	species_exception = null

//MEDICAL

/obj/item/clothing/shoes/fancy_heels/white
	name = "白色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/white"
	greyscale_colors = "#ffffff"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/darkblue
	name = "深蓝色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/darkblue"
	greyscale_colors = "#364660"
	flags_1 = null

//SCIENCE

/obj/item/clothing/shoes/fancy_heels/black
	name = "黑色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/black"
	greyscale_colors = "#39393f"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/purple
	name = "紫色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/purple"
	greyscale_colors = "#7e1980"
	flags_1 = null

//SECURITY

/obj/item/clothing/shoes/fancy_heels/red
	name = "红色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/red"
	greyscale_colors = "#a52f29"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/grey
	name = "灰色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/grey"
	greyscale_colors = "#918f8c"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/brown
	name = "棕色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/brown"
	greyscale_colors = "#784f44"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/orange
	name = "橙色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/orange"
	greyscale_colors = "#ff8d1e"
	flags_1 = null

//HEELED STUFF (NOT THE FANCY HEELS) SPRITES BY DimWhat OF MONKE STATION

/obj/item/clothing/shoes/jackboots/gogo_boots
	name = "战术戈戈靴"
	desc = "极具战术性的鞋履，专为让你更好地观察战场而设计。"
	icon_state = "hos_boots"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

//SERVICE

/obj/item/clothing/shoes/fancy_heels/lightblue
	name = "浅蓝色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/lightblue"
	greyscale_colors = "#3e6588"
	flags_1 = null

//HEELED STUFF (NOT THE FANCY HEELS) SPRITES BY DimWhat OF MONKE STATION

/obj/item/clothing/shoes/galoshes/heeled
	name = "高跟套鞋"
	desc = "一双黄色橡胶高跟套鞋，用于防止在湿滑地面上滑倒。穿着它走路比普通高跟鞋还要难。"
	icon_state ="galoshes_heeled"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	custom_premium_price = PAYCHECK_CREW * 3

/obj/item/clothing/shoes/fancy_heels/green
	name = "绿色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/green"
	greyscale_colors = "#50d967"
	flags_1 = null

//HEELED STUFF (NOT THE FANCY HEELS) SPRITES BY DimWhat OF MONKE STATION

/obj/item/clothing/shoes/clown_shoes/heeled
	name = "洪克高跟鞋"
	desc = "一双高跟小丑鞋。什么样的疯子才会设计这种东西？"
	icon_state ="honk_heels"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'

/obj/item/clothing/shoes/fancy_heels/darkgreen
	name = "深绿色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/darkgreen"
	greyscale_colors = "#47853a"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/teal
	name = "青蓝色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/teal"
	greyscale_colors = "#5cbfaa"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/mutedblack
	name = "暗哑黑高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/mutedblack"
	greyscale_colors = "#2f3038"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/mutedblue
	name = "暗哑蓝高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/mutedblue"
	greyscale_colors = "#1165c5"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/beige
	name = "米色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/beige"
	greyscale_colors = "#a69e9a"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/darkgrey
	name = "深灰色高跟鞋"
	icon_state = "/obj/item/clothing/shoes/fancy_heels/darkgrey"
	greyscale_colors = "#46464d"
	flags_1 = null

// Syndicate slippers, guaranteed slipping for whoever wears them.
/obj/item/clothing/shoes/banana_slippers
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	name = "香蕉拖鞋"
	desc = "时尚的香蕉造型鞋子，穿上之后根本没法不打滑地走路。由于它们实在太滑，想脱下来还得请朋友帮忙！"
	icon_state = "banana_slippers"
	worn_icon_state = "banana_slippers"
	fastening_type = SHOES_SLIPON
	strip_delay = 10 SECONDS

// Special throw_impact for hats to frisbee hats at people to place them on their heads/attempt to de-hat them.
/obj/item/clothing/shoes/banana_slippers/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	. = ..()
	// if the thrown object's target zone isn't the head
	if(thrownthing.target_zone != BODY_ZONE_L_LEG && thrownthing.target_zone != BODY_ZONE_R_LEG)
		return
	// Just in case someone adds storage down the line on the slippers
	if(LAZYLEN(contents))
		return
	if(iscarbon(hit_atom))
		var/mob/living/carbon/human/hit_human = hit_atom
		if(istype(hit_human.shoes, /obj/item))
			var/obj/item/hit_human_shoes = hit_human.shoes
			// check if the item has NODROP
			if(HAS_TRAIT(hit_human_shoes, TRAIT_NODROP))
				hit_human.visible_message(span_warning("[src] 从 [hit_human] 的[hit_human_shoes.name]上弹开了！"), span_warning("[src] 从你的[hit_human_shoes.name]上弹开，掉到了地板上。"))
				return
			// check if the item is an actual clothing feet item, since some non-clothing items can be worn
			if(istype(hit_human_shoes, /obj/item/clothing/shoes))
				var/obj/item/clothing/head/hit_human_shoes_confirmed = hit_human_shoes
				// SNUG_FIT shoes are immune to being knocked off
				if(hit_human_shoes_confirmed.clothing_flags & SNUG_FIT)
					hit_human.visible_message(span_warning("[src] 从 [hit_human] 的[hit_human_shoes_confirmed.name]上弹开了！"), span_warning("[src] 从你的[hit_human_shoes_confirmed.name]上弹开，掉到了地板上。"))
					return
			// if the slippers manages to knock something off
			if(hit_human.dropItemToGround(hit_human_shoes))
				hit_human.visible_message(span_warning("[src] 把[hit_human_shoes]从 [hit_human] 的脚上蹭了下来！"), span_warning("[hit_human_shoes]突然被[src]从你脚上蹭掉了！"))
		if(hit_human.equip_to_slot_if_possible(src, ITEM_SLOT_FEET, 0, 1, 1))
			hit_human.visible_message(span_notice("[src] 稳稳地落在 [hit_human] 的脚上！"), span_notice("[src] 完美地套在了你的脚上！"))
			hit_human.update_held_items() //force update hands to prevent ghost sprites appearing when throw mode is on
		return
	if(iscyborg(hit_atom))
		return

/obj/item/clothing/shoes/banana_slippers/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, 80)
	RegisterSignal(src, COMSIG_SHOES_STEP_ACTION, PROC_REF(on_step))

/obj/item/clothing/shoes/banana_slippers/proc/on_step()
	SIGNAL_HANDLER
	if(iscarbon(src.loc))
		var/mob/living/carbon/stepping_mob = src.loc
		stepping_mob.slip(80)

/obj/item/clothing/shoes/banana_slippers/equipped(mob/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_FEET)
		ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(type))

/obj/item/clothing/shoes/banana_slippers/dropped(mob/user)
	. = ..()
	// Could have been blown off in an explosion from the previous owner
	REMOVE_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(type))

/obj/item/clothing/shoes/banana_slippers/canStrip(mob/stripper, mob/owner)
	return TRUE

/obj/item/clothing/shoes/banana_slippers/doStrip(mob/stripper, mob/owner)
	REMOVE_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(type))
	if (!owner.dropItemToGround(src))
		return FALSE
	return TRUE

/obj/item/clothing/shoes/horseshoe
	name = "马蹄铁"
	desc = "一副用链条制成的马蹄铁。"
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	icon_state = "horseshoe"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

	body_parts_covered = parent_type::body_parts_covered | LEGS
	resistance_flags = FIRE_PROOF
	fastening_type = SHOES_SLIPON

// sprites by Aeri/unionheart
// digi sprites by @sippykot
/obj/item/clothing/shoes/jackboots/heel
	name = "高跟长筒军靴"
	desc = "合成皮革长筒军靴，材质被打磨得几乎像镜面一样发亮——还古怪地加了一只相当有攻击性的鞋跟。"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'
	icon_state = "heel-jackboots"

/obj/item/clothing/shoes/jackboots/heel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/effects/footstep/highheel1.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel2.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel3.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel4.ogg' = 1), 70)
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

// Diesel Boots | Sprites by Fluff from Bad Deathclaw
/obj/item/clothing/shoes/jackboots/diesel_m
	name = "男式柴油靴"
	desc = "考究的男式钢头靴。"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	icon_state = "diesel_m"

/obj/item/clothing/shoes/jackboots/diesel_f
	name = "女式柴油靴"
	desc = "考究的女式及膝厚底靴，配有锃亮的钢制搭扣。"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	icon_state = "diesel_f"

/obj/item/clothing/shoes/jackboots/toeless // Ported from SPLURT
	name = "露趾长筒军靴"
	desc = "经过改装的长筒军靴，对脚趾带爪的种族格外友好。"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	icon_state = "jackboots-toeless"
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/obj/item/clothing/shoes/workboots/toeless // Ported from SPLURT
	name = "露趾工作靴"
	desc = "一双为工业场景设计的露趾工作靴。经过改装，适合脚趾带爪的种族。"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	icon_state = "workboots-toeless"
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'


/obj/item/clothing/shoes/jackboots/combine
	name = "联合军长筒靴"
	desc = "碾扁易拉罐，也碾碎头骨。"
	clothing_traits = list(TRAIT_SILENT_FOOTSTEPS)

/obj/item/clothing/shoes/jackboots/combine/Initialize(mapload)
	. = ..()
	var/list/combine_sounds = list(
		'modular_zubbers/sound/effects/combine/gear1.ogg'= 1,
		'modular_zubbers/sound/effects/combine/gear2.ogg'= 1,
		'modular_zubbers/sound/effects/combine/gear3.ogg'= 1,
		'modular_zubbers/sound/effects/combine/gear4.ogg'= 1,
		'modular_zubbers/sound/effects/combine/gear5.ogg'= 1,
		'modular_zubbers/sound/effects/combine/gear6.ogg'= 1,
		)
	AddComponent(/datum/component/squeak, combine_sounds, 75)


//MGS stuff sprited by Crumpaloo for onlyplateau, please credit when porting, which you obviously have permission to do.
/obj/item/clothing/shoes/combat/boss
	name = "爱国者的靴子"
	desc = "如今我心中已空无一物。什么都不剩了。没有仇恨，甚至连悔意也没有。"
	icon_state = "boss"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'
	clothing_traits = list(TRAIT_SILENT_FOOTSTEPS) //Stealth suit.

/obj/item/clothing/shoes/jackboots/boss
	name = "水星女郎的靴子"
	desc = "如今我心中已空无一物。什么都不剩了。没有仇恨，甚至连悔意也没有。"
	icon_state = "boss"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/obj/item/clothing/shoes/jackboots/snake
	name = "潜行靴"
	desc = "我们将把故土抛在身后。"
	icon_state = "snake"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'
	clothing_traits = list(TRAIT_SILENT_FOOTSTEPS)

/obj/item/clothing/shoes/workboots/black
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/obj/item/clothing/shoes/pirate
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/obj/item/clothing/shoes/jackboots/netra
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/obj/item/clothing/shoes/jackboots/noble
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/obj/item/clothing/shoes/jackboots/elofy
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/obj/item/clothing/shoes/workboots
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/obj/item/clothing/shoes/winterboots/ice_boots/primitive_catgirl_boots
	greyscale_config_worn_digi = /datum/greyscale_config/primitive_catgirl_boots/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/primitive_catgirl_boots/worn/teshari

/obj/item/clothing/shoes/wraps/colourable
	greyscale_config_worn_teshari = /datum/greyscale_config/legwraps/worn/teshari

/obj/item/clothing/shoes/sandal
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/obj/item/clothing/shoes/combat/debug
	name = "技师靴"
	desc = "一双你本不该拥有的作战靴。鞋垫衬着蓝空间织物，让它能干出些胡扯的事来，例如踏空、跨越深渊、漫步太空、踩过熔岩以及穿墙。"
	strip_delay = 60 SECONDS
	resistance_flags = INDESTRUCTIBLE|LAVA_PROOF|FIRE_PROOF|UNACIDABLE|ACID_PROOF
	lace_time = 0.5 SECONDS
	clothing_traits = list(TRAIT_NO_SLIP_ALL)
	actions_types = list(/datum/action/item_action/toggle)
	w_class = WEIGHT_CLASS_SMALL

	var/free_move = FALSE
	var/list/active_traits = list(TRAIT_SPACEWALK, TRAIT_NEGATES_GRAVITY, TRAIT_MOVE_PHASING, TRAIT_MOVE_FLYING, TRAIT_LAVA_IMMUNE, TRAIT_NO_FLOATING_ANIM)

GAME_VERB_SRC(/obj/item/clothing/shoes/combat/debug, toggle, usr, "切换蓝空间磁体", null)
	if(!can_use(usr))
		return
	attack_self(usr)

/obj/item/clothing/shoes/combat/debug/attack_self(mob/user)
	free_move = !free_move
	if(free_move)
		attach_clothing_traits(active_traits)
	else
		detach_clothing_traits(active_traits)

	balloon_alert(user, "蓝空间磁体已[free_move ? "激活" : "停用"]")

/obj/item/clothing/shoes/combat/debug/examine(mob/user)
	. = ..()
	. += "它的蓝空间磁体似乎处于[free_move ? "激活" : "停用"]状态。"
