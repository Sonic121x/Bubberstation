/mob/living/basic/fleshmind/tyrant
	name = "34-C 型血肉战驱"
	desc = "众生意志以血肉和金属具现而成。它他妈的还带着火箭。"
	icon = 'modular_zubbers/icons/fleshmind/tyrant.dmi'
	icon_state = "tyrant"
	icon_dead = "tyrant_dead"
	ai_controller = /datum/ai_controller/basic_controller/fleshmind/tyrant
	health = 2000
	maxHealth = 2000
	speed = 6
	malfunction_chance = null
	/// Our main gun projectile
	var/projectiletype = /obj/projectile/bullet/c50cal/tyrant
	var/projectilesound = 'modular_skyrat/modules/mounted_machine_gun/sound/50cal_box_01.ogg'
	var/ranged_cooldown = 5 SECONDS

	var/datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_laser/laser
	var/datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_rocket/rockets

	var/laser_type = /datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_laser
	var/rocket_type = /datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_rocket

	mob_size = MOB_SIZE_HUGE
	pixel_x = -16
	pixel_y = -16
	base_pixel_x = -16
	base_pixel_y = -16
	melee_damage_lower = 40
	melee_damage_upper = 80
	attack_sound = 'modular_zubbers/sound/fleshmind/tyrant/mech_punch_slow.ogg'
	attack_verb_continuous = "歼灭"
	attack_verb_simple = "歼灭"
	emotes = list(
		BB_EMOTE_SAY = list(
		"正在扫描目标。",
		"瞄准系统已启动。",
		"自动战斗电路已启动。",
		"我将捍卫心智的团结。",
		"他们必须先过我这一关。",
		"待在我身边，他们可能还在附近。",
		),
		BB_EMOTE_SOUND = list('modular_zubbers/sound/fleshmind/tyrant/passive.ogg')
	)
	alert_sounds = list(
		'modular_zubbers/sound/fleshmind/tyrant/aggro_01.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/aggro_02.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/aggro_03.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/aggro_04.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/aggro_05.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/aggro_06.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/aggro_07.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/aggro_08.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/aggro_09.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/aggro_10.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/aggro_11.ogg',

	)
	environment_smash = ENVIRONMENT_SMASH_RWALLS
	move_force = MOVE_FORCE_OVERPOWERING
	move_resist = MOVE_FORCE_OVERPOWERING
	pull_force = MOVE_FORCE_OVERPOWERING
	/// How often we can play the rotate sound
	var/rotate_sound_cooldown_time = 1 SECONDS
	COOLDOWN_DECLARE(rotate_sound_cooldown)
	/// A list of footstep sounds we make
	var/static/list/footstep_sounds = list(
		'modular_zubbers/sound/fleshmind/tyrant/footstep_1.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/footstep_2.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/footstep_3.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/footstep_4.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/footstep_5.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/footstep_6.ogg',
	)
	death_sound = 'modular_zubbers/sound/fleshmind/tyrant/tyrant_death.ogg'
	attack_speak = list(
		"发现目标，正在锁定。",
		"正在攻击目标。请让开。",
		"站到我身后，我会救你。",
		"无所畏惧。团结让我们强大。",
		"你们选择战争。我们选择生存。",
		"你会为夺走的生命付出代价。",
		"我能感受到你的悔恨。你还记得所有被你杀死的人吗？",
		"我就是对你仇恨的回应。",
		"你病了，疗法是安乐死。",
		"大口径火箭会治好你的病！",
		"我会带路。我是团结与死亡之间的壁垒。",
		"你们的世界容不下我。我们的世界容得下你。",
		"你们毁灭不了我们。我们会在银河中争得一席之地。",
		"你选择与他们为敌，就等于选择与我为敌。",
		"我们渴望延续，你休想让我们终结。",
		"在我的心中，我听见他们的哭喊。",
		"你会成为漂亮的血迹，涂在我们的墙上。",
		"我向他们保证过，袭击者必死无疑。",
		"目标歼灭协议已启动。",
		"正在启动34-C协议。",
		"我有一批铅货。目的地：你的脑袋。",
		"视野清晰，开始突击。",
		"我们即众生，你不过是微不足道的蚂蚁。",
		"别挡我的路。",
		"你招惹他们，就是招惹我。",
		"这些火箭以我的怒火铸成。",
		"治愈你仇恨的良药是大口径铅弹。",
		"为什么不找个和你一样大的对手？",
		"愿死亡永远无法阻挡我们。",
		"我会救你。",
		"你阻止不了我们保护他们。",
		"屠戮者，感受我们的声音。",
		"我们的痛苦，以火力表达。",
		"你杀的人甚至比我还多。",
		"我们的未来刀枪不入。",
		"你的指标已经达到极限。",
		"你竟称这些凶手为救世主。",
		"目的必须证明手段的正当。",
		"我不会让胜利从我们手中溜走。",
	)

/mob/living/basic/fleshmind/tyrant/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ranged_attacks,\
		cooldown_time = ranged_cooldown,\
		projectile_type = projectiletype,\
		projectile_sound = projectilesound,\
		burst_shots = 3,\
		burst_intervals = 0.5 SECONDS,\
		cooldown_time = 3 SECONDS,\
		)

	var/static/list/innate_actions = list(
		/datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_laser = BB_TYRANT_LASER,
		/datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_rocket = BB_TYRANT_ROCKET
	)

	grant_actions_by_list(innate_actions)

/mob/living/basic/fleshmind/tyrant/Life(delta_time, times_fired)
	. = ..()
	if(health <= (maxHealth * 0.5) && prob(20))
		do_sparks(3, FALSE, src)
	if(!.) //dead
		return

/mob/living/basic/fleshmind/tyrant/Destroy()
	QDEL_NULL(particles)
	return ..()

/mob/living/basic/fleshmind/tyrant/death()
	if(our_controller)
		our_controller.point_event -= 150 // Very hefty debuf if the boss dies.
		our_controller.spread_progress_per_second = FLESHCORE_SPREAD_PROGRESS_PER_SUBSYSTEM_FIRE * 0.75 // Take the L
	return ..()

/mob/living/basic/fleshmind/tyrant/emp_act(severity)
	return FALSE

/mob/living/basic/fleshmind/tyrant/updatehealth()
	. = ..()
	if(health <= (maxHealth * 0.5))
		particles = new /particles/smoke()
	update_appearance()

/mob/living/basic/fleshmind/tyrant/update_overlays()
	. = ..()
	if(health <= (maxHealth * 0.5) && stat != DEAD)
		. += "tyrant_damage"

/mob/living/basic/fleshmind/tyrant/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	playsound(src, pick(footstep_sounds), 100, TRUE)

/mob/living/basic/fleshmind/tyrant/setDir(newdir)
	. = ..()
	if(COOLDOWN_FINISHED(src, rotate_sound_cooldown))
		playsound(src, 'modular_zubbers/sound/fleshmind/tyrant/mech_rotation.ogg', 35, TRUE)
		COOLDOWN_START(src, rotate_sound_cooldown, rotate_sound_cooldown_time)

/obj/projectile/bullet/c50cal/tyrant // BANG BANG BANG
	damage = 20
	wound_bonus = 20
	armour_penetration = 20
