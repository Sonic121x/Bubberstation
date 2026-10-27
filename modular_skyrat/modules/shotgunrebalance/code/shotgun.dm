/obj/item/ammo_casing/shotgun
	icon = 'modular_skyrat/modules/shotgunrebalance/icons/shotshells.dmi'
	desc = "一发12号口径铁制独头弹。"
	custom_materials = AMMO_MATS_SHOTGUN

// THE BELOW TWO SLUGS ARE NOTED AS ADMINONLY AND HAVE ***EIGHTY*** WOUND BONUS. NOT BARE WOUND BONUS. FLAT WOUND BONUS.
/obj/item/ammo_casing/shotgun/executioner
	name = "膨胀独头弹"
	desc = "一发12号口径破碎独头弹，专为命中时摧毁血肉而设计。"
	can_be_printed = FALSE // noted as adminonly in code/modules/projectiles/projectile/bullets/shotgun.dm.

/obj/item/ammo_casing/shotgun/pulverizer
	name = "粉碎者独头弹"
	desc = "一发12号口径铀制独头弹，专为命中时打碎骨骼而设计。"
	can_be_printed = FALSE // noted as adminonly in code/modules/projectiles/projectile/bullets/shotgun.dm

/obj/item/ammo_casing/shotgun/incendiary
	name = "燃烧独头弹"
	desc = "一发12号口径镁制独头弹，专为“帅气地把东西点着”而生。\
	<br><br>\
	<i>燃烧：发射时留下火焰轨迹，并点燃目标。</i>"

/obj/item/ammo_casing/shotgun/ion
	custom_materials = AMMO_MATS_SHOTGUN_TIDE

/obj/item/ammo_casing/shotgun/techshell
	can_be_printed = FALSE // techshell... casing! so not really usable on its own but if you're gonna make these go raid a seclathe.

/obj/item/ammo_casing/shotgun/improvised
	can_be_printed = FALSE // this is literally made out of scrap why would you use this if you have a perfectly good ammolathe

/obj/item/ammo_casing/shotgun/dart/bioterror
	can_be_printed = FALSE // PRELOADED WITH TERROR CHEMS MAYBE LET'S NOT

/obj/item/ammo_casing/shotgun/dragonsbreath
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_SHOTGUN_PLASMA

/obj/item/ammo_casing/shotgun/stunslug
	name = "泰瑟独头弹"
	desc = "一发装有微型电子元件的12号口径银制独头弹，用于使目标失去行动能力。"
	can_be_printed = FALSE // comment out if you want rocket tag shotgun ammo being printable

/obj/item/ammo_casing/shotgun/meteorslug
	name = "流星独头弹"
	desc = "一发采用CMC技术的12号口径弹药，能够以巨大力量射出一团物质。\
	<br><br>\
	<i>流星：发射流星般的弹体，将人和气闸等可移动物体击退。</i>"
	can_be_printed = FALSE // techshell. assumed intended balance being a pain to assemble

/obj/item/ammo_casing/shotgun/frag12
	name = "FRAG-12独头弹"
	desc = "一发装有烈性炸药的12号口径弹药，用于摧毁部分障碍和轻型载具、排除简易爆炸装置，或拦截助理。\
	<br><br>\
	<i>高爆：命中时爆炸。</i>"
	can_be_printed = FALSE // techshell. assumed intended balance being a pain to assemble

/obj/item/ammo_casing/shotgun/pulseslug
	can_be_printed = FALSE // techshell. assumed intended balance being a pain to assemble

/obj/item/ammo_casing/shotgun/incapacitate
	name = "黄蜂窝霰弹"
	desc = "一发12号口径弹药，装填了特别适合使目标失能的材料。内含大量弹丸，\
	牺牲单颗弹丸威力，换来在近到可以“吐口水”的距离内的惊人停止作用。\
	<br><br>\
	<i>黄蜂窝：一次射出数量惊人的弹丸。</i>"
	can_be_printed = FALSE

/obj/item/ammo_casing/shotgun/beehive
	name = "黄蜂霰弹"
	desc = "一发低致命性12号口径弹药，发射四颗能够从几乎任何表面弹开的弹丸，\
		并自动重新瞄准最近的目标。不过，它们会攻击附近的<b>任何目标</b>。"
	icon_state = "cnrshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/beehive
	pellets = 4
	variance = 15
	fire_sound = 'sound/items/weapons/taser.ogg'
	harmful = FALSE
	custom_materials = AMMO_MATS_SHOTGUN_HIVE
	advanced_print_req = TRUE

/obj/projectile/bullet/pellet/shotgun_buckshot/beehive
	name = "黄蜂箭形弹"
	icon = 'modular_skyrat/modules/shotgunrebalance/icons/projectiles.dmi'
	icon_state = "hornet"
	damage = 4
	stamina = 15
	damage_falloff_tile = -1
	stamina_falloff_tile = -1
	wound_bonus = 5
	exposed_wound_bonus = 5
	wound_falloff_tile = 0
	sharpness = NONE
	ricochets_max = 5
	ricochet_chance = 200
	ricochet_auto_aim_angle = 60
	ricochet_auto_aim_range = 8
	ricochet_decay_damage = 1
	ricochet_decay_chance = 1
	ricochet_incidence_leeway = 0 //nanomachines son
	homing_turn_speed = 25
	homing_inaccuracy_min = 10
	homing_inaccuracy_max = 80

/obj/item/ammo_casing/shotgun/antitide
	name = "星尘弹"
	desc = "高度实验性的弹药，内含会嵌入软目标的纳米电极。电极从运动中获取电能，因此目标越动，受到的惩罚越重。它也无法被武术反弹。"
	icon_state = "lasershell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/antitide
	pellets = 1
	variance = 1
	harmful = FALSE
	fire_sound = 'sound/items/weapons/taser.ogg'
	custom_materials = AMMO_MATS_SHOTGUN_TIDE
	advanced_print_req = TRUE

/obj/projectile/bullet/pellet/shotgun_buckshot/antitide
	name = "电极"
	icon = 'modular_skyrat/modules/shotgunrebalance/icons/projectiles.dmi'
	icon_state = "stardust"
	damage = 15
	stamina = 33
	damage_falloff_tile = -0.2
	stamina_falloff_tile = -0.3
	wound_bonus = 40
	exposed_wound_bonus = 40
	stutter = 3 SECONDS
	jitter = 5 SECONDS
	eyeblur = 1 SECONDS
	sharpness = NONE
	range = 12
	embed_type = /datum/embedding/shotgun_buckshot/antitide
	reflectable = NONE

/datum/embedding/shotgun_buckshot/antitide
	embed_chance = 200
	pain_chance = 95
	fall_chance = 10
	jostle_chance = 10
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 1
	pain_mult = 3
	rip_time = 1 SECONDS

/obj/projectile/bullet/pellet/shotgun_buckshot/antitide/on_range()
	do_sparks(1, TRUE, src)
	..()

/obj/item/ammo_casing/shotgun/frangible
	name = "易碎独头弹"
	desc = "一种威力较弱的反器材弹，用于破开气闸、路障和建筑，对人效果不佳。"
	icon_state = "breacher"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1, /datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT)
	projectile_type = /obj/projectile/bullet/frangible_slug

/obj/projectile/bullet/frangible_slug
	name = "易碎独头弹"
	damage = 15 //I'd kill you if you manage to kill someone with this shit
	wound_bonus = 30
	exposed_wound_bonus = 30
	demolition_mod = 2

/obj/projectile/bullet/frangible_slug/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(istype(target, /obj/structure/window) || istype(target, /obj/machinery/door/airlock) || istype(target, /obj/structure/grille) || istype(target,/obj/structure/door_assembly) || istype(target,/obj/machinery/door/window/))
		if(isobj(target))
			demolition_mod = 50
			damage = 30
		else
			demolition_mod = 2
			damage = 15

/obj/item/ammo_casing/shotgun/hunter
	name = "狩猎独头弹"
	desc = "一发12号口径独头弹，使用特制弹头，可对当地星球的野生动物造成额外伤害。"
	icon_state = "huntershell"
	projectile_type = /obj/projectile/bullet/shotgun_slug/hunter

/obj/projectile/bullet/shotgun_slug/hunter
	name = "12号口径狩猎独头弹"
	damage = 20
	range = 12
	/// How much the damage is multiplied by when we hit a mob with the correct biotype
	var/biotype_damage_multiplier = 5
	/// What biotype we look for
	var/biotype_we_look_for = MOB_BEAST

/obj/projectile/bullet/shotgun_slug/hunter/on_hit(atom/target, blocked, pierce_hit)
	if(ismineralturf(target))
		var/turf/closed/mineral/mineral_turf = target
		mineral_turf.gets_drilled(firer)
		if(range > 0)
			return BULLET_ACT_FORCE_PIERCE
		return ..()
	if(!isliving(target) || (damage > initial(damage)))
		return ..()
	var/mob/living/target_mob = target
	if(target_mob.mob_biotypes & biotype_we_look_for || istype(target_mob, /mob/living/simple_animal/hostile/megafauna))
		damage *= biotype_damage_multiplier
	return ..()

/obj/item/ammo_casing/shotgun/honkshot
	name = "彩纸弹"
	desc = "一发装满彩纸的12号口径霰弹，耶！"
	icon_state = "honkshell"
	projectile_type = /obj/projectile/bullet/honkshot
	pellets = 12
	variance = 35
	fire_sound = 'sound/items/bikehorn.ogg'
	harmful = FALSE

/obj/projectile/bullet/honkshot
	name = "彩纸"
	damage = 0
	sharpness = NONE
	shrapnel_type = NONE
	impact_effect_type = null
	ricochet_chance = 0
	jitter = 1 SECONDS
	eyeblur = 1 SECONDS
	hitsound = SFX_CLOWN_STEP
	range = 4
	icon_state = "guardian"

/obj/projectile/bullet/honkshot/Initialize(mapload)
	. = ..()
	SpinAnimation()
	range = rand(1, 4)
	color = pick(
		COLOR_PRIDE_RED,
		COLOR_PRIDE_ORANGE,
		COLOR_PRIDE_YELLOW,
		COLOR_PRIDE_GREEN,
		COLOR_PRIDE_BLUE,
		COLOR_PRIDE_PURPLE,
	)

// This proc addition will spawn a decal on each tile the projectile travels over
/obj/projectile/bullet/honkshot/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	new /obj/effect/decal/cleanable/confetti(get_turf(old_loc))
	return ..()

// This proc addition will make living humanoids do a flip animation when hit by the projectile
/obj/projectile/bullet/honkshot/on_hit(atom/target, blocked, pierce_hit)
	if(!isliving(target))
		return ..()
	target.SpinAnimation(7,1)
	return ..()

// This proc addition adds a spark effect when the projectile expires/hits
/obj/projectile/bullet/honkshot/on_range()
	do_sparks(1, TRUE, src)
	return ..()

/obj/item/ammo_casing/shotgun/beanbag
	harmful = FALSE

/obj/item/gun/ballistic/shotgun/Initialize(mapload)
	AddElement(/datum/element/gun_launches_little_guys, throwing_force = 1, throwing_range = 1, knockdown_time = 0, gentle = TRUE)

	return ..()

// Deal with materials disparity between hand crafting and ammo bench recipes

/datum/crafting_recipe/meteorslug
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY

/datum/crafting_recipe/pulseslug
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY

/datum/crafting_recipe/dragonsbreath
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY

/datum/crafting_recipe/ionslug
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY
