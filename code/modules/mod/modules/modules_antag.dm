//Antag modules for MODsuits

///Energy Shield - Gives you a rechargeable energy shield that nullifies attacks.
/obj/item/mod/module/energy_shield
	name = "\improper MOD 能量护盾模块"
	desc = "一种常见于军事用途的个人防护力场。\
		这种高级偏导护盾本质上是星舰护盾的缩小版，\
		其能量消耗也直观地体现了这一点。然而，它能阻挡几乎任何来袭攻击，\
		但每几秒只能阻挡一次；这是对使用者终有一死的冷酷提醒。"
	icon_state = "energy_shield"
	complexity = 3
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.5
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 2
	incompatible_modules = list(/obj/item/mod/module/energy_shield)
	required_slots = list(ITEM_SLOT_BACK)
	/// Max charges of the shield.
	var/max_charges = 1
	/// The time it takes for the first charge to recover.
	var/recharge_start_delay = 10 SECONDS
	/// How much time it takes for charges to recover after they started recharging.
	var/charge_increment_delay = 1 SECONDS
	/// How much charge is recovered per recovery.
	var/charge_recovery = 1
	/// Whether or not this shield can lose multiple charges.
	var/lose_multiple_charges = FALSE
	/// The icon file of the shield.
	var/shield_icon_file = 'icons/effects/effects.dmi'
	/// The icon_state of the shield.
	var/shield_icon = "shield-red"
	/// Charges the shield should start with.
	var/charges
	/// Whether or not we allow this shield to block overwhelming attacks, such as from mechs.
	var/block_overwhelming_attacks = FALSE

/obj/item/mod/module/energy_shield/Initialize(mapload)
	. = ..()
	charges = max_charges

/obj/item/mod/module/energy_shield/on_part_activation()
	mod.AddComponent(\
		/datum/component/shielded, \
		max_charges = max_charges, \
		recharge_start_delay = recharge_start_delay, \
		charge_increment_delay = charge_increment_delay, \
		charge_recovery = charge_recovery, \
		lose_multiple_charges = lose_multiple_charges, \
		starting_charges = charges, \
		can_block_overwhelming = block_overwhelming_attacks, \
		shield_icon_file = shield_icon_file, \
		shield_icon = shield_icon)
	RegisterSignal(mod.wearer, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(shield_reaction))

/obj/item/mod/module/energy_shield/on_part_deactivation(deleting = FALSE)
	var/datum/component/shielded/shield = mod.GetComponent(/datum/component/shielded)
	charges = shield.current_charges
	qdel(shield)
	UnregisterSignal(mod.wearer, COMSIG_LIVING_CHECK_BLOCK)

/obj/item/mod/module/energy_shield/proc/shield_reaction(mob/living/carbon/human/owner,
	atom/movable/hitby,
	damage = 0,
	attack_text = "这次攻击",
	attack_type = MELEE_ATTACK,
	armour_penetration = 0,
	damage_type = BRUTE
)
	SIGNAL_HANDLER

	if(mod.hit_reaction(owner, hitby, attack_text, 0, damage, attack_type))
		drain_power(use_energy_cost + use_energy_cost * (attack_type == OVERWHELMING_ATTACK ? (damage/100) : 0))
		return SUCCESSFUL_BLOCK
	return NONE

/obj/item/mod/module/energy_shield/wizard
	name = "\improper MOD 战斗法师护盾模块"
	desc = "施放此法术的施法者会在身周获得一层可见的屏障，借助铭刻在\
		套装表面的专用符文引导奥术能量，生成一道力场之墙。\
		这层护盾能完美抵消从高口径步枪到魔法飞弹的各种攻击，\
		但也会被更寻常的攻击消耗掉。它无法保护施法者免受他人嘲笑。"
	icon_state = "battlemage_shield"
	idle_power_cost = 0 //magic
	use_energy_cost = 0 //magic too
	max_charges = 5
	recharge_start_delay = 20 SECONDS
	charge_increment_delay = 3 SECONDS
	block_overwhelming_attacks = TRUE // It's magic, bitch
	shield_icon_file = 'icons/effects/magic.dmi'
	shield_icon = "mageshield"
	required_slots = list()

///Magic Nullifier - Protects you from magic.
/obj/item/mod/module/anti_magic
	name = "\improper MOD 魔法抵消模块"
	desc = "一系列黑曜石棒被装入套装四周的关键位置，\
		以特定低频振动使其产生共振。\
		这会在使用者周围形成一个范围虽小但十分强大的魔法抵消场，\
		此外套装原本的冷却液也被完全替换为圣水。\
		法术会在这道场面前直接剥落，不过这并不能让别人相信你说的这一切。"
	icon_state = "magic_nullifier"
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/anti_magic)
	required_slots = list(ITEM_SLOT_BACK)

/obj/item/mod/module/anti_magic/on_part_activation()
	mod.wearer.add_traits(list(TRAIT_ANTIMAGIC, TRAIT_HOLY), REF(src))

/obj/item/mod/module/anti_magic/on_part_deactivation(deleting = FALSE)
	mod.wearer.remove_traits(list(TRAIT_ANTIMAGIC, TRAIT_HOLY), REF(src))

/obj/item/mod/module/anti_magic/wizard
	name = "\improper MOD 魔法中和模块"
	desc = "施放此法术的施法者会在身周获得一层不可见的屏障，借助铭刻在\
		套装表面的专用符文引导奥术能量，生成反魔法场。\
		该场会中和所有接触到使用者的魔法。\
		它无法保护施法者免受他人嘲笑。"
	icon_state = "magic_neutralizer"
	required_slots = list()

/obj/item/mod/module/anti_magic/wizard/on_part_activation()
	mod.wearer.add_traits(list(TRAIT_ANTIMAGIC, TRAIT_ANTIMAGIC_NO_SELFBLOCK), REF(src))

/obj/item/mod/module/anti_magic/wizard/on_part_deactivation(deleting = FALSE)
	mod.wearer.remove_traits(list(TRAIT_ANTIMAGIC, TRAIT_ANTIMAGIC_NO_SELFBLOCK), REF(src))

///Insignia - Gives you a skin specific stripe.
/obj/item/mod/module/insignia
	name = "\improper MOD 徽记模块"
	desc = "尽管已有 IFF 系统、无线电通讯以及依靠佩戴者自身双眼进行推理的现代手段，\
		彩色涂装仍然是银河系中不同派系展示自身身份的流行方式。\
		该系统利用一系列微型移动喷漆器，向套装施加或除去不同的\
		颜色图案。"
	icon_state = "insignia"
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/insignia)
	overlay_state_inactive = "module_insignia"
	mask_worn_overlay = TRUE

/obj/item/mod/module/insignia/generate_worn_overlay(obj/item/source, mutable_appearance/standing)
	overlay_state_inactive = "[initial(overlay_state_inactive)]-[mod.skin]"
	. = ..()
	for(var/mutable_appearance/appearance as anything in .)
		appearance.color = color

/obj/item/mod/module/insignia/commander
	color = "#4980a5"

/obj/item/mod/module/insignia/security
	color = "#b30d1e"

/obj/item/mod/module/insignia/engineer
	color = "#e9c80e"

/obj/item/mod/module/insignia/medic
	color = "#ebebf5"

/obj/item/mod/module/insignia/janitor
	color = "#7925c7"

/obj/item/mod/module/insignia/clown
	color = "#ff1fc7"

/obj/item/mod/module/insignia/chaplain
	color = "#f0a00c"

/obj/item/mod/module/insignia/syndie
	color = COLOR_SYNDIE_RED

///Anti Slip - Prevents you from slipping on water.
/obj/item/mod/module/noslip
	name = "\improper MOD 防滑模块"
	desc = "这是标准磁力靴的改装版本，靴底装有压电晶体。\
		当使用者迈步时，靴底的两块板会自动伸出并磁化；\
		这股吸力太弱，不足以让人固定在船体上，但恰好强到\
		能防住你自己没看小心地滑警示牌这件事。洪克公司已多次\
		公开抗议这些模块居然合法。"
	icon_state = "noslip"
	complexity = 1
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.1
	incompatible_modules = list(/obj/item/mod/module/noslip)
	required_slots = list(ITEM_SLOT_FEET)

/obj/item/mod/module/noslip/on_part_activation()
	ADD_TRAIT(mod.wearer, TRAIT_NO_SLIP_WATER, REF(src))

/obj/item/mod/module/noslip/on_part_deactivation(deleting = FALSE)
	REMOVE_TRAIT(mod.wearer, TRAIT_NO_SLIP_WATER, REF(src))

//Bite of 87 Springlock - Equips faster, disguised as DNA lock.
/obj/item/mod/module/springlock/bite_of_87
	name = /obj/item/mod/module/dna_lock::name
	desc = /obj/item/mod/module/dna_lock::desc
	icon_state = /obj/item/mod/module/dna_lock::icon_state
	complexity = /obj/item/mod/module/dna_lock::complexity
	use_energy_cost = /obj/item/mod/module/dna_lock::use_energy_cost
	step_change = 0.1

/obj/item/mod/module/springlock/bite_of_87/on_part_activation()
	..()
	if(check_holidays(APRIL_FOOLS) || prob(1))
		mod.set_mod_color("#b17f00")
		mod.wearer.remove_atom_colour(WASHABLE_COLOUR_PRIORITY) // turns purple guy purple
		mod.wearer.add_atom_colour("#704b96", FIXED_COLOUR_PRIORITY)

///Flamethrower - Launches fire across the area.
/obj/item/mod/module/flamethrower
	name = "\improper MOD 火焰喷射器模块"
	desc = "一台定制制造的火焰喷射器，用来烧穿你的前路。好好烧吧。"
	icon_state = "flamethrower"
	module_type = MODULE_ACTIVE
	complexity = 3
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 3
	incompatible_modules = list(/obj/item/mod/module/flamethrower)
	cooldown_time = 2.5 SECONDS
	overlay_state_inactive = "module_flamethrower"
	overlay_state_active = "module_flamethrower_on"
	required_slots = list(ITEM_SLOT_OCLOTHING|ITEM_SLOT_ICLOTHING)

/obj/item/mod/module/flamethrower/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	var/obj/projectile/flame = new /obj/projectile/bullet/incendiary/fire(mod.wearer.loc)
	flame.aim_projectile(target, mod.wearer)
	flame.firer = mod.wearer
	playsound(src, 'sound/items/modsuit/flamethrower.ogg', 75, TRUE)
	INVOKE_ASYNC(flame, TYPE_PROC_REF(/obj/projectile, fire))
	drain_power(use_energy_cost)

///Power kick - Lets the user launch themselves at someone to kick them.
/obj/item/mod/module/power_kick
	name = "\improper MOD 动力踢击模块"
	desc = "本模块使用高功率人造肌肉产生惊人的能量，并将其转化为一记踢击的力量。"
	icon_state = "power_kick"
	module_type = MODULE_ACTIVE
	removable = FALSE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 5
	incompatible_modules = list(/obj/item/mod/module/power_kick)
	cooldown_time = 5 SECONDS
	required_slots = list(ITEM_SLOT_FEET)
	/// Damage on kick.
	var/damage = 20
	/// The wound bonus of the kick.
	var/wounding_power = 35
	/// How long we knockdown for on the kick.
	var/knockdown_time = 2 SECONDS

/obj/item/mod/module/power_kick/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	mod.wearer.visible_message(span_warning("[mod.wearer] 开始蓄力准备踢击！"), \
		blind_message = span_hear("你听到充能的声音。"))
	playsound(src, 'sound/items/modsuit/loader_charge.ogg', 75, TRUE)
	balloon_alert(mod.wearer, "你开始蓄力……")
	animate(mod.wearer, 0.3 SECONDS, pixel_z = 16, flags = ANIMATION_RELATIVE, easing = SINE_EASING|EASE_OUT)
	addtimer(CALLBACK(mod.wearer, TYPE_PROC_REF(/atom, SpinAnimation), 3, 2), 0.3 SECONDS)
	if(!do_after(mod.wearer, 1 SECONDS, target = mod))
		animate(mod.wearer, 0.2 SECONDS, pixel_z = -16, flags = ANIMATION_RELATIVE, easing = SINE_EASING|EASE_IN)
		return
	animate(mod.wearer)
	drain_power(use_energy_cost)
	playsound(src, 'sound/items/modsuit/loader_launch.ogg', 75, TRUE)
	var/angle = get_angle(mod.wearer, target) + 180
	mod.wearer.transform = mod.wearer.transform.Turn(angle)
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_IMPACT, PROC_REF(on_throw_impact))
	mod.wearer.throw_at(target, range = 7, speed = 2, thrower = mod.wearer, spin = FALSE, gentle = TRUE, callback = CALLBACK(src, PROC_REF(on_throw_end), mod.wearer, -angle))

/obj/item/mod/module/power_kick/proc/on_throw_end(mob/user, angle)
	if(!user)
		return
	user.transform = user.transform.Turn(angle)
	animate(user, 0.2 SECONDS, pixel_z = -16, flags = ANIMATION_RELATIVE, easing = SINE_EASING|EASE_IN)

/obj/item/mod/module/power_kick/proc/on_throw_impact(mob/living/source, atom/target, datum/thrownthing/thrownthing)
	SIGNAL_HANDLER

	UnregisterSignal(source, COMSIG_MOVABLE_IMPACT)
	if(!mod?.wearer)
		return
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.apply_damage(damage, BRUTE, mod.wearer.zone_selected, wound_bonus = wounding_power)
		living_target.Knockdown(knockdown_time)
	else if(target.uses_integrity)
		target.take_damage(damage, BRUTE, MELEE)
	else
		return
	mod.wearer.do_attack_animation(target, ATTACK_EFFECT_SMASH)

///Chameleon - lets the suit disguise as any item that would fit on that slot.
/obj/item/mod/module/chameleon
	name = "\improper MOD 变色龙模块"
	desc = "一种利用变色龙技术将套装伪装成其他物体的模块。"
	icon_state = "chameleon"
	module_type = MODULE_USABLE
	complexity = 2
	incompatible_modules = list(/obj/item/mod/module/chameleon)
	cooldown_time = 0.5 SECONDS
	allow_flags = list(MODULE_ALLOW_INACTIVE|MODULE_ALLOW_UNWORN)
	/// A list of all the items the suit can disguise as.
	var/list/possible_disguises = list()
	/// The path of the item we're disguised as.
	var/obj/item/current_disguise

/obj/item/mod/module/chameleon/on_install()
	. = ..()
	var/list/all_disguises = sort_list(subtypesof(get_path_by_slot(mod.slot_flags)), GLOBAL_PROC_REF(cmp_typepaths_asc))
	for(var/clothing_path in all_disguises)
		var/obj/item/clothing = clothing_path
		if(!initial(clothing.icon_state))
			continue
		var/chameleon_item_name = "[initial(clothing.name)] ([initial(clothing.icon_state)])"
		possible_disguises[chameleon_item_name] = clothing_path

/obj/item/mod/module/chameleon/on_uninstall(deleting = FALSE)
	. = ..()
	if(current_disguise)
		return_look()
	possible_disguises = null

/obj/item/mod/module/chameleon/used(mob/activator)
	if(mod.active || mod.activating)
		balloon_alert(activator, "装置已激活！")
		return FALSE
	return ..()

/obj/item/mod/module/chameleon/on_use(mob/activator)
	if(current_disguise)
		return_look()
		return
	var/picked_name = tgui_input_list(activator, "选择要变成的外观", "变色龙设置", possible_disguises)
	if(!possible_disguises[picked_name] || mod.active || mod.activating)
		return
	current_disguise = possible_disguises[picked_name]
	update_look()

/obj/item/mod/module/chameleon/proc/update_look()
	mod.name = initial(current_disguise.name)
	mod.desc = initial(current_disguise.desc)
	mod.icon_state = initial(current_disguise.icon_state)
	mod.icon = initial(current_disguise.icon)
	mod.worn_icon = initial(current_disguise.worn_icon)
	mod.alternate_worn_layer = initial(current_disguise.alternate_worn_layer)
	mod.lefthand_file = initial(current_disguise.lefthand_file)
	mod.righthand_file = initial(current_disguise.righthand_file)
	mod.worn_icon_state = initial(current_disguise.worn_icon_state)
	mod.inhand_icon_state = initial(current_disguise.inhand_icon_state)
	update_clothing_slots()
	RegisterSignal(mod, COMSIG_MOD_ACTIVATE, PROC_REF(return_look))

/obj/item/mod/module/chameleon/proc/return_look()
	mod.name = "[chinese_batch_ten_theme_display(mod.theme.name)] [initial(mod.name)]"
	mod.desc = "[initial(mod.desc)] [mod.theme.desc]"
	mod.icon_state = "[mod.skin]-[initial(mod.icon_state)]"
	var/list/mod_skin = mod.theme.variants[mod.skin]
	mod.icon = mod_skin[MOD_ICON_OVERRIDE] || 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	mod.worn_icon = mod_skin[MOD_WORN_ICON_OVERRIDE] || 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	mod.lefthand_file = initial(mod.lefthand_file)
	mod.righthand_file = initial(mod.righthand_file)
	mod.worn_icon_state = null
	mod.inhand_icon_state = null
	update_clothing_slots()
	current_disguise = null
	UnregisterSignal(mod, COMSIG_MOD_ACTIVATE)

///Plate Compression - Compresses the suit to normal size
/obj/item/mod/module/plate_compression
	name = "\improper MOD 板材压缩模块"
	desc = "一种让套装保持极度贴合状态、从而减小整体体积的模块。\
		由于所有部件都承受着压力，常规存储模块无法装入。"
	icon_state = "plate_compression"
	complexity = 2
	incompatible_modules = list(/obj/item/mod/module/plate_compression, /obj/item/mod/module/storage)
	/// The size we set the suit to.
	var/new_size = WEIGHT_CLASS_NORMAL
	/// The suit's size before the module is installed.
	var/old_size

/obj/item/mod/module/plate_compression/on_install()
	. = ..()
	old_size = mod.w_class
	mod.update_weight_class(new_size)

/obj/item/mod/module/plate_compression/on_uninstall(deleting = FALSE)
	. = ..()
	mod.update_weight_class(old_size)
	old_size = null
	if(!mod.loc)
		return
	var/datum/storage/holding_storage = mod.loc.atom_storage
	if(!holding_storage || holding_storage.max_specific_storage >= mod.w_class)
		return
	mod.forceMove(mod.drop_location())

/obj/item/mod/module/demoralizer
	name = "\improper MOD 灵能回响挫志模块"
	desc = "玫瑰银河公司研发团队中一位极其病态的成员曾向同事们提出一个问题。\
	‘我希望在杀死敌人的同时还能在精神上给他们留下创伤。谁要阻止我把这功能加进下一个项目？’\
	于是，灵能回响挫志装置就这样不情不愿地被发明了出来。心理战的未来，就在今天！"
	icon_state = "brain_hurties"
	complexity = 0
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.1
	removable = FALSE
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)
	var/datum/proximity_monitor/advanced/demoraliser/demoralizer

/obj/item/mod/module/demoralizer/on_part_activation()
	var/datum/demoralise_moods/module/mood_category = new()
	demoralizer = new(mod.wearer, 7, TRUE, mood_category)

/obj/item/mod/module/demoralizer/on_part_deactivation(deleting = FALSE)
	QDEL_NULL(demoralizer)

/obj/item/mod/module/infiltrator
	name = "\improper MOD 渗透核心程序模块"
	desc = "套装内部运行的主要隐形系统。借助电磁信号，\
		使用者无法被近距离仔细观察，周围的人也听不清其声音。\
		它还包含一些减震系统，帮助保护使用者免受头部打击。"
	icon_state = "infiltrator"
	complexity = 0
	removable = FALSE
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0
	incompatible_modules = list(/obj/item/mod/module/infiltrator, /obj/item/mod/module/welding/syndicate, /obj/item/mod/module/welding, /obj/item/mod/module/headprotector)
	required_slots = list(ITEM_SLOT_FEET, ITEM_SLOT_HEAD, ITEM_SLOT_OCLOTHING)
	/// List of traits added when the suit is activated
	var/list/traits_to_add = list(TRAIT_SILENT_FOOTSTEPS, TRAIT_UNKNOWN_APPEARANCE, TRAIT_UNKNOWN_VOICE, TRAIT_HEAD_INJURY_BLOCKED)

/obj/item/mod/module/infiltrator/on_install()
	. = ..()
	ADD_TRAIT(mod, TRAIT_EXAMINE_SKIP, REF(src))

/obj/item/mod/module/infiltrator/on_uninstall(deleting = FALSE)
	. = ..()
	REMOVE_TRAIT(mod, TRAIT_EXAMINE_SKIP, REF(src))

/obj/item/mod/module/infiltrator/on_part_activation()
	mod.wearer.add_traits(traits_to_add, REF(src))
	RegisterSignal(mod.wearer, COMSIG_TRY_MODIFY_SPEECH, PROC_REF(on_speech_modification))
	var/obj/item/organ/tongue/user_tongue = mod.wearer.get_organ_slot(ORGAN_SLOT_TONGUE)
	user_tongue.temp_say_mod = "states"
	var/obj/item/clothing/head_cover = mod.get_part_from_slot(ITEM_SLOT_HEAD)
	if(istype(head_cover))
		head_cover.flash_protect = FLASH_PROTECTION_WELDER_HYPER_SENSITIVE

/obj/item/mod/module/infiltrator/on_part_deactivation(deleting = FALSE)
	mod.wearer.remove_traits(traits_to_add, REF(src))
	UnregisterSignal(mod.wearer, COMSIG_TRY_MODIFY_SPEECH)
	var/obj/item/organ/tongue/user_tongue = mod.wearer.get_organ_slot(ORGAN_SLOT_TONGUE)
	user_tongue.temp_say_mod = initial(user_tongue.temp_say_mod)
	if(deleting)
		return
	var/obj/item/clothing/head_cover = mod.get_part_from_slot(ITEM_SLOT_HEAD)
	if(istype(head_cover))
		head_cover.flash_protect = initial(head_cover.flash_protect)

/obj/item/mod/module/infiltrator/proc/on_speech_modification(datum/source)
	SIGNAL_HANDLER
	if(!mod.active)
		return
	//Prevent speech modifications if the suit is active
	return PREVENT_MODIFY_SPEECH

///Medbeam - Medbeam but built into a modsuit
/obj/item/mod/module/medbeam
	name = "\improper MOD 医疗光束枪模块"
	desc = "腕挂式医疗光束枪，让使用者能在不必担心掉落的情况下治疗盟友。"
	icon_state = "chronogun"
	module_type = MODULE_ACTIVE
	complexity = 1
	active_power_cost = DEFAULT_CHARGE_DRAIN
	device = /obj/item/gun/medbeam/mod
	incompatible_modules = list(/obj/item/mod/module/medbeam)
	removable = TRUE
	cooldown_time = 0.05 SECONDS
	required_slots = list(ITEM_SLOT_BACK)

/obj/item/gun/medbeam/mod
	name = "\improper MOD 医疗光束"

/obj/item/mod/module/stealth/wraith
	name = "\improper MOD 怨灵隐形模块"
	desc = "隐形模块更具破坏性的改装版本。与护甲模块不兼容。"
	icon_state = "cloak_traitor"
	stealth_alpha = 30
	module_type = MODULE_ACTIVE
	cooldown_time = 2 SECONDS
	incompatible_modules = list(/obj/item/mod/module/stealth, /obj/item/mod/module/welding/syndicate)
	/// How much time before we are able to cloak again after the cloak is broken (not disabled)
	COOLDOWN_DECLARE(recloak_timer)
	/// If the stealth portion of the module is active
	var/stealth_active = FALSE

/obj/item/mod/module/stealth/wraith/on_select_use(atom/target)
	. = ..()
	if(!. || target == mod.wearer)
		return
	if(get_dist(mod.wearer, target) > 6)
		balloon_alert(mod.wearer, "够不到那里！")
		return
	if(istype(target, /obj/machinery/power/apc)) //Bit too strong for a module so this is blacklisted
		balloon_alert(mod.wearer, "无法瘫痪 APC！")
		return

	var/list/things_to_disrupt = list(target)
	if(isliving(target))
		var/mob/living/live_target = target
		things_to_disrupt += live_target.get_all_gear(INCLUDE_PROSTHETICS|INCLUDE_ABSTRACT|INCLUDE_ACCESSORIES)

	for(var/atom/disrupted as anything in things_to_disrupt)
		if(disrupted.on_saboteur(src, 1 MINUTES))
			mod.add_charge(DEFAULT_CHARGE_DRAIN * 250)

/obj/item/mod/module/stealth/wraith/on_activation(mob/activator)
	return // Don't activate stealth when the module is activated because the stealth portion of the module is fully passive

/obj/item/mod/module/stealth/wraith/on_deactivation(mob/activator, display_message = TRUE, deleting = FALSE)
	. = ..()
	UnregisterSignal(mod.wearer, list(COMSIG_LIVING_MOB_BUMP, COMSIG_ATOM_BUMPED, COMSIG_MOB_FIRED_GUN))

/obj/item/mod/module/stealth/wraith/on_part_activation()
	start_stealth()

/obj/item/mod/module/stealth/wraith/on_part_deactivation(deleting)
	UnregisterSignal(mod.wearer, list(COMSIG_LIVING_UNARMED_ATTACK, COMSIG_MOB_ITEM_ATTACK, COMSIG_ATOM_ATTACKBY, COMSIG_ATOM_ATTACK_HAND, COMSIG_ATOM_BULLET_ACT, COMSIG_ATOM_HITBY, COMSIG_ATOM_HULK_ATTACK, COMSIG_ATOM_ATTACK_PAW, COMSIG_CARBON_CUFF_ATTEMPTED, COMSIG_LIVING_MOB_BUMP, COMSIG_ATOM_BUMPED, COMSIG_MOB_FIRED_GUN))
	animate(mod.wearer, alpha = 255, time = 1.5 SECONDS)
	stealth_active = FALSE

/obj/item/mod/module/stealth/wraith/proc/start_stealth()
	if(!COOLDOWN_FINISHED(src, recloak_timer)) // Prevents being able to bypass the cooldown by disabling and re-enabling the module
		addtimer(CALLBACK(src, PROC_REF(start_stealth)), COOLDOWN_TIMELEFT(src, recloak_timer))
		return
	RegisterSignals(mod.wearer, list(COMSIG_LIVING_MOB_BUMP, COMSIG_ATOM_BUMPED, COMSIG_MOB_FIRED_GUN), PROC_REF(unstealth))
	RegisterSignal(mod.wearer, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(on_unarmed_attack))
	RegisterSignal(mod.wearer, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_bullet_act))
	RegisterSignals(mod.wearer, list(COMSIG_MOB_ITEM_ATTACK, COMSIG_ATOM_ATTACKBY, COMSIG_ATOM_ATTACK_HAND, COMSIG_ATOM_HITBY, COMSIG_ATOM_HULK_ATTACK, COMSIG_ATOM_ATTACK_PAW, COMSIG_CARBON_CUFF_ATTEMPTED), PROC_REF(unstealth))
	animate(mod.wearer, alpha = stealth_alpha, time = 1.5 SECONDS)
	drain_power(use_energy_cost)
	stealth_active = TRUE

/obj/item/mod/module/stealth/wraith/unstealth(datum/source)
	if(!stealth_active)
		return
	to_chat(mod.wearer, span_warning("[src] 因接触而放电！"))
	do_sparks(2, TRUE, src)
	drain_power(use_energy_cost)
	// Don't deactivate() directly as the module may not be active in the first place when stealthing
	on_deactivation()
	if(!mod.active)
		return
	COOLDOWN_START(src, recloak_timer, 20 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(start_stealth)), 20 SECONDS)
	stealth_active = FALSE

/obj/item/mod/module/stealth/wraith/examine_more(mob/user)
	. = ..()
	. += span_info( \
		"怨灵模块并不只是简单地弯折使用者周围的光线来掩盖其视觉特征，\
		还会主动攻击并过载周围发光的物体，将这些能量重新用于驱动套装。\
		这项技术可能源自蜘蛛氏族的进步成果，\
		但怨灵模块的确切来源极具争议。\
		由于窃取蜘蛛氏族技术会带来政治后果以及对方必然的报复，没有任何团体站出来宣称这是自己的杰作。\
		大多数人把矛头指向赛博太阳工业，但也有传言说，它甚至可能来自辛迪加各分支中更为隐秘的组织。\
		无论如何，如果你此刻正看着这样一件东西，别拿给太空忍者看。" \
	)
