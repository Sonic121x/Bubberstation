//Proto-Kinetic Accelerators
/obj/item/gun/energy/recharge/kinetic_accelerator/railgun
	name = "原型动能轨道炮"
	desc = "在如今精巧流畅的原型动能加速器问世之前，采矿研发团队曾绘制过多种设计。\
	许多都失败了，包括这款过于笨重、效率过低的设计。最近研发团队喝醉后嚷着“管他妈的，干就完了”，\
	重新拿出了它，将其超频并成功运作，造出了名副其实的单兵便携粒子加速器。\
	它能够释放强大而难以控制的动能冲击，贯穿生物并造成巨大伤害。\
	唯一的问题是，它笨重到必须双手持用；由于破坏力惊人，还配备了特殊击发销，\
	禁止在空间站内部或附近使用。"
	icon = 'modular_zubbers/icons/obj/guns/guns.dmi'
	icon_state = "kineticrailgun"
	base_icon_state = "kineticrailgun"
	inhand_icon_state = "kineticgun"
	w_class = WEIGHT_CLASS_HUGE
	pin = /obj/item/firing_pin/wastes
	recharge_time = 3 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/railgun)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_HEAVY
	max_mod_capacity = 15 // A crumb of mod capacity as a treat
	recoil = 3 //railgun go brrrrr
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/recharge/kinetic_accelerator/repeater
	name = "原型动能连发枪"
	desc = "在庆祝新型动能碎灭器设计发布的披萨派对上，采矿研发团队成员每人只能吃一片。\
	有人抱怨“要是能多吃几片就好了”，另一人回应“要是加速器能多开几枪就好了”，连发枪便应运而生。\
	它牺牲少量威力，换取耗尽能量前连开三枪的能力，同时仍能一次充满电。\
	为了实现这一点，内部塞入了额外装置，挤占了改装空间，因此可安装的改装件少于普通加速器。"
	icon = 'modular_zubbers/icons/obj/guns/guns.dmi'
	icon_state = "kineticrepeater"
	base_icon_state = "kineticrepeater"
	inhand_icon_state = "kineticgun"
	recharge_time = 2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/repeater)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	max_mod_capacity = 75

/obj/item/gun/energy/recharge/kinetic_accelerator/shotgun
	name = "原型动能霰弹枪"
	desc = "在动能碎灭器设计的披萨派对上，一名采矿研发成员掏出真家伙——防暴霰弹枪，一枪打死了\
	另外三名研究员。研发主管立刻灵光一现，片刻后造出了原型动能霰弹枪，\
	并马上用它处决了带来真霰弹枪的研究员。这把枪牺牲了部分改装容量和冷却速度，\
	换取同时发射三枚较短射程、较低威力弹丸的能力。三枚合计伤害高于普通 PKA，但单发较弱。\
	看来需要双手持用才能有效发挥威力。"
	icon = 'modular_zubbers/icons/obj/guns/guns.dmi'
	icon_state = "kineticshotgun"
	base_icon_state = "kineticshotgun"
	inhand_icon_state = "kineticgun"
	recharge_time = 2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/shotgun)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_HEAVY
	max_mod_capacity = 60
	disabled_modkits = list(/obj/item/borg/upgrade/modkit/cooldown/aoe/) // Should cover all AOE variants

/obj/item/gun/energy/recharge/kinetic_accelerator/glock
	name = "原型动能手枪"
	desc = "在采矿研发团队的披萨派对上，一名娇气的研究员不要普通披萨片，偏要迷你墨菲披萨。\
	主管只好给他买了一个，结果这蠢货转头就把它掉在了 PKA 上。“自制专属 PKA”的点子就此诞生。\
	原型动能手枪的伤害和射程都比基础 PKA 差，但较低的基础性能\
	腾出了接近两倍的改装容量，让它真正成为“你自己的 PKA”。"
	icon = 'modular_zubbers/icons/obj/guns/guns.dmi'
	icon_state = "kineticpistol"
	base_icon_state = "kineticpistol"
	inhand_icon_state = "kineticgun"
	recharge_time = 2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/glock)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	max_mod_capacity = 200

/obj/item/gun/energy/recharge/kinetic_accelerator/shockwave
	name = "原型动能冲击波发生器"
	desc = "坦白说，我们不知道采矿研发团队是怎么想出这东西的，只知道他们喝了很多\
	啤酒。它会轰击地面，在使用者周围制造威力与基础 PKA 相同的冲击波。\
	缺点是改装容量更小、射程更短、冷却更久，但用来清理岩石相当不错。"
	icon = 'modular_zubbers/icons/obj/guns/guns.dmi'
	icon_state = "kineticshockwave"
	base_icon_state = "kineticshockwave"
	inhand_icon_state = "kineticgun"
	recharge_time = 2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/shockwave)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	max_mod_capacity = 75
	disabled_modkits = list(/obj/item/borg/upgrade/modkit/cooldown/aoe/) // Should cover all AOE variants

/obj/item/gun/energy/recharge/kinetic_accelerator/shockwave/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	target = get_edge_target_turf(user, user.dir)
	return ..()

/obj/item/gun/energy/recharge/kinetic_accelerator/m79
	name = "原型动能榴弹发射器"
	desc = "研发动能轨道炮时在醉酒狂欢中诞生的武器，发射与采矿 MOD 外骨骼\
	相同的炸弹。将炸弹装入武器所需的装置占满了内部，因此没有改装空间。"
	icon = 'modular_zubbers/icons/obj/guns/guns.dmi'
	icon_state = "kineticglauncher"
	base_icon_state = "kineticglauncher"
	inhand_icon_state = "kineticgun"
	pin = /obj/item/firing_pin/wastes
	recharge_time = 2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/m79)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	max_mod_capacity = 0
	disablemodification = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/m79/add_bayonet_point()
	return

//Accelerator Casing
//Fixed maths to use new standards
/obj/item/ammo_casing/energy/kinetic/railgun
	projectile_type = /obj/projectile/kinetic/railgun
	select_name = "kinetic"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE * 0.5)
	fire_sound = 'sound/items/weapons/beam_sniper.ogg'

/obj/item/ammo_casing/energy/kinetic/repeater
	projectile_type = /obj/projectile/kinetic/repeater
	select_name = "kinetic"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE * 0.15) //about three shots
	fire_sound = 'sound/items/weapons/kinetic_accel.ogg'

/obj/item/ammo_casing/energy/kinetic/shotgun
	projectile_type = /obj/projectile/kinetic/shotgun
	select_name = "kinetic"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE * 0.5)
	pellets = 3
	variance = 50
	fire_sound = 'sound/items/weapons/kinetic_accel.ogg'

/obj/item/ammo_casing/energy/kinetic/glock
	projectile_type = /obj/projectile/kinetic/glock
	select_name = "kinetic"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE * 0.5)
	fire_sound = 'sound/items/weapons/kinetic_accel.ogg'

/obj/item/ammo_casing/energy/kinetic/shockwave
	projectile_type = /obj/projectile/kinetic/shockwave
	select_name = "kinetic"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE * 0.5)
	pellets = 8
	variance = 360
	fire_sound = 'sound/items/weapons/gun/general/cannon.ogg'

/obj/item/ammo_casing/energy/kinetic/m79
	projectile_type = /obj/projectile/bullet/mining_missile //uses the mining bomb projectile from the mining modsuit
	select_name = "kinetic"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE * 0.5)
	fire_sound = 'sound/items/weapons/gun/general/grenade_launch.ogg'

//Accelerator Projectiles
/obj/projectile/kinetic/railgun
	name = "超强动能冲击"
	icon_state = null
	damage = 100 // Slightly less than a crusher marked hit (110 methinks), but ranged and really fast moving, big movement slowdown and bulky.
	damage_type = BRUTE
	armor_flag = BOMB
	range = 6
	pressure_decrease = 0.10 //Pressured enviorments are a no go for the railgun
	speed = 10 //NYOOM
	projectile_piercing = PASSMOB

/obj/projectile/kinetic/repeater
	name = "速发动能冲击"
	icon_state = null
	damage = 20 // Half damage, burst fire and a bit more range.
	damage_type = BRUTE
	armor_flag = BOMB
	range = 4
	log_override = TRUE

/obj/projectile/kinetic/shotgun
	name = "散射动能冲击"
	icon_state = null
	damage = 20 // 3 projectiles, 60 base damage. Theoretically more if all shots hit.
	damage_type = BRUTE
	armor_flag = BOMB
	range = 3
	log_override = TRUE

/obj/item/borg/upgrade/modkit/indoors/modify_projectile(obj/projectile/kinetic/shotgun/K)
	..()
	K.pressure_decrease = min(K.pressure_decrease, 0.5)

/obj/projectile/kinetic/glock
	name = "轻型动能冲击"
	icon_state = null
	damage = 10 // Low dmg, high modularity. Can be made great, especially when dual wielded.
	damage_type = BRUTE
	armor_flag = BOMB
	range = 3
	log_override = TRUE

/obj/projectile/kinetic/shockwave
	name = "震荡动能冲击"
	icon_state = null
	damage = 40 // 8 projectiles in a 360 around you. Good for CC and rock clearing.
	damage_type = BRUTE
	armor_flag = BOMB
	range = 1
	log_override = TRUE

//Wastes firing pin - restricts a weapon to only outside when mining - based on area defines not z-level

/obj/item/firing_pin/wastes
	name = "荒原击发销"
	desc = "这种安全击发销只允许武器在熔岩星或冰月的室外荒原上开火。"
	fail_message = "荒原检查失败！请先离空间站远一点。"
	pin_hot_swappable = FALSE
	pin_removable = FALSE
	var/list/wastes = list(/area/icemoon/underground/unexplored/rivers,
							/area/icemoon/surface/outdoors,
							/area/icemoon/surface/outdoors/unexplored/rivers/no_monsters,
							/area/icemoon/underground/unexplored/rivers/deep/shoreline,
							/area/icemoon/underground/explored,
							/area/moonstation/surface,
							/area/moonstation/surface/unexplored,
							/area/moonstation/underground,
							/area/moonstation/underground/unexplored,
							/area/lavaland/surface/outdoors,
							/area/lavaland/surface/outdoors/unexplored/danger,
							/area/lavaland/surface/outdoors/unexplored,
							/area/lavaland/surface/outdoors/explored,
							/area/ocean/generated,
							/area/ruin/
						)

/obj/item/firing_pin/wastes/pin_auth(mob/living/user)
	if(!istype(user))
		return FALSE
	if (is_type_in_list(get_area(user), wastes))
		return TRUE
	return FALSE
