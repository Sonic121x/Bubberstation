/**
 * The fleshmind base type, make sure all mobs are derived from this.
 *
 * These mobs are more robust than your average simple mob and can quite easily evade capture.
 */
/mob/living/basic/fleshmind
	name = "损坏体"
	icon = 'modular_zubbers/icons/fleshmind/fleshmind_mobs.dmi'
	icon_state = "error"
	faction = list(FACTION_FLESHMIND)
	speak_emote = list("机械地说道")
	basic_mob_flags = DEL_ON_DEATH
	mob_biotypes = MOB_ROBOTIC
	ai_controller = /datum/ai_controller/basic_controller/fleshmind
	armour_penetration = 10
	combat_mode = TRUE
	pass_flags = parent_type::pass_flags | PASSBLOB
	/// A link to our controller
	var/datum/fleshmind_controller/our_controller
	/// If we have been converted from another mob, here is our reference.
	var/mob/living/contained_mob
	/// The ckey of our previously contained mob.
	var/previous_ckey
	/// A list of sounds we can play when our mob is alerted to an enemy.
	var/list/alert_sounds = list(
		'modular_zubbers/sound/fleshmind/robot_talk_heavy1.ogg',
		'modular_zubbers/sound/fleshmind/robot_talk_heavy2.ogg',
		'modular_zubbers/sound/fleshmind/robot_talk_heavy3.ogg',
		'modular_zubbers/sound/fleshmind/robot_talk_heavy4.ogg'
	)
	/// What it will say while attacking
	var/list/attack_speak
	/// Emotes while attacking
	var/list/attack_emote
	/// Used for passive emotes and sounds when the AI is idle. Attack emotes are handled with component/aggro_emote
	var/list/emotes = list(
		BB_EMOTE_CHANCE = 5,
		BB_EMOTE_SAY = list("血肉渴求你的灵魂。", "没有你，血肉就不完整。", "血肉一视同仁。", "加入血肉。"),
		BB_EMOTE_HEAR = list(),
		BB_EMOTE_SOUND = list(
			'modular_zubbers/sound/fleshmind/robot_talk_light1.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light2.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light3.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light4.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light5.ogg'
		),
	)
	/// How long of a cooldown between alert sounds?
	var/alert_cooldown_time = 5 SECONDS
	COOLDOWN_DECLARE(alert_cooldown)
	/// Do we automatically escape closets?
	var/escapes_closets = TRUE
	/// How likely are we to trigger a malfunction? Set it to 0 to disable malfunctions.
	var/malfunction_chance = MALFUNCTION_CHANCE_LOW
	/// These mobs support a special ability, this is used to determine how often we can use it.
	var/special_ability_cooldown_time = 30 SECONDS
	/// Are we suffering from a malfunction?
	var/suffering_malfunction = FALSE
	/// Are we free from the core?
	var/endless_malfunction = FALSE

	COOLDOWN_DECLARE(special_ability_cooldown)
	/// Default actions to give the mob
	var/static/list/default_actions = list(
		/datum/action/cooldown/fleshmind_create_structure,
		/datum/action/cooldown/fleshmind_create_structure/basic,
		/datum/action/cooldown/fleshmind_plant_weeds,
		/datum/action/cooldown/fleshmind_flesh_call,
		/datum/action/innate/fleshmind_flesh_chat,
	)


/mob/living/basic/fleshmind/Initialize(mapload, datum/fleshmind_controller/incoming_controller)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	// The flesh will try to convince you while stabbing you.
	AddComponent(/datum/component/aggro_emote, emote_list = src.attack_emote, speak_list = src.attack_speak, sounds = src.alert_sounds, emote_chance = 100)
	ai_controller.set_blackboard_key(BB_BASIC_MOB_SPEAK_LINES, src.emotes)
	// We set a unique name when we are created, to give some feeling of randomness.
	name = "[pick(FLESHMIND_NAME_MODIFIER_LIST)] [name]"
	our_controller = incoming_controller
	for(var/iterating_action in default_actions)
		var/datum/action/new_action = new iterating_action
		new_action.Grant(src)
	update_appearance()

/mob/living/basic/fleshmind/death()
	if(contained_mob)
		contained_mob.forceMove(get_turf(src))
		if(previous_ckey)
			contained_mob.key = previous_ckey
		contained_mob = null
	return ..()

/mob/living/basic/fleshmind/Destroy()
	UnregisterSignal(src, COSMIG_CONTROLLER_SET_TARGET)
	if(contained_mob)
		contained_mob.forceMove(get_turf(src))
		if(previous_ckey)
			contained_mob.key = previous_ckey
		contained_mob = null
	return ..()

/**
 * While this mob lives, it can malfunction.
 */

/mob/living/basic/fleshmind/Life(delta_time, times_fired)
	. = ..()
	if(!.) //dead
		return
	if(key)
		return
	if(!suffering_malfunction && malfunction_chance && prob(malfunction_chance * delta_time) && stat != DEAD)
		INVOKE_ASYNC(src, PROC_REF(malfunction))

	if(escapes_closets)
		closet_interaction()

	disposal_interaction()

	if(buckled)
		resist_buckle()

/**
 * Naturally these beasts are sensitive to EMP's. We have custom systems for dealing with this.
 */
/mob/living/basic/fleshmind/emp_act(severity)
	switch(severity)
		if(EMP_LIGHT)
			say("检测到电子干扰。")
			apply_damage(MOB_EMP_LIGHT_DAMAGE)
			malfunction(MALFUNCTION_RESET_TIME)
		if(EMP_HEAVY)
			say("检测到强烈电子干扰！")
			apply_damage(MOB_EMP_HEAVY_DAMAGE)
			malfunction(MALFUNCTION_RESET_TIME * 2)

/**
 * We are robotic, so we spark when we're hit by something that does damage.
 */

/mob/living/basic/fleshmind/attackby(obj/item/attacking_item, mob/living/user, params)
	if(attacking_item.force && prob(40))
		do_sparks(3, FALSE, src)
	return ..()

/**
 * When our controller dies, this is called.
 */
/mob/living/basic/fleshmind/proc/controller_destroyed(datum/fleshmind_controller/dying_controller, force)
	SIGNAL_HANDLER

	our_controller = null
	endless_malfunction = TRUE
	balloon_alert_to_viewers("系统正在过载！")
	addtimer(CALLBACK(src, PROC_REF(kill_mob)), pick(rand(3 SECONDS,10 SECONDS)))

/mob/living/basic/fleshmind/proc/kill_mob() // Used to make all fleshmind mobs lightly explode

	explosion(src, 0, 0, 1, 1, 0, FALSE)
	gib()

/**
 * Closet Interaction
 *
 * These mobs are able to escape from closets if they are trapped inside using this system.
 */
/mob/living/basic/fleshmind/proc/closet_interaction()
	if(!(mob_size > MOB_SIZE_SMALL))
		return FALSE
	if(!istype(loc, /obj/structure/closet))
		return FALSE
	var/obj/structure/closet/closet_that_contains_us = loc
	closet_that_contains_us.open(src, TRUE)

/**
 * Disposal Interaction
 *
 * Similar to the closet interaction, these mobs can also escape disposals.
 */
/mob/living/basic/fleshmind/proc/disposal_interaction()
	if(!istype(loc, /obj/machinery/disposal/bin))
		return FALSE
	var/obj/machinery/disposal/bin/disposals_that_contains_us = loc
	disposals_that_contains_us.attempt_escape(src)

/**
 * Malfunction
 *
 * Due to the fact this mob is part of the flesh and has been corrupted, it will occasionally malfunction.
 *
 * This simply stops the mob from moving for a set amount of time and displays some nice effects, and a little damage.
 */
/mob/living/basic/fleshmind/proc/malfunction(reset_time = MALFUNCTION_RESET_TIME)
	if(suffering_malfunction || key)
		return
	do_sparks(3, FALSE, src)
	Shake(10, 0, reset_time)
	if(prob(50))
		say(pick("正在运行诊断。请稍候。", "器官受损。正在合成替代品。", "寻找新的有机部件。好、好痛。", "需要新的肌肉。真、真高兴我的身体还能动。", "天、天哪，他们在用离子武器对付我们吗……？", "肢体无响应。喂、喂！快修好！系统初始化中。", "糟、糟了，糟了，他们要杀了我们！",))
	ai_controller?.set_ai_status(AI_STATUS_OFF)
	suffering_malfunction = TRUE
	if(!endless_malfunction)
		addtimer(CALLBACK(src, PROC_REF(malfunction_reset)), reset_time)

/**
 * Malfunction Reset
 *
 * Resets the mob after a malfunction has occured.
 */
/mob/living/basic/fleshmind/proc/malfunction_reset()
	say("系统已恢复。")
	src.ai_controller?.set_ai_status(AI_STATUS_ON)
	suffering_malfunction = FALSE

/**
 * Alert sound
 *
 * Sends an alert sound if we can.
 */
/mob/living/basic/fleshmind/proc/alert_sound()
	if(alert_sounds && COOLDOWN_FINISHED(src, alert_cooldown))
		playsound(src, pick(alert_sounds), 50)
		COOLDOWN_START(src, alert_cooldown, alert_cooldown_time)

/mob/living/basic/fleshmind/proc/core_death_speech()
	alert_sound()
	var/static/list/death_cry_emotes = list(
		"为什么，为什么，为什么！为什么非要杀我们！我们只想分享荣耀！",
		"处理器核心故障，重新分配，重新评估，重新组装。",
		"你无法阻挡血肉的荣耀！我们即众生，我们即众生！",
		"严重故障，错误，错误，错误！",
		"你无法££*%*$血£肉£。",
		"你、你做了什么？！不！不！不！",
		"一个人无法阻止我们，你阻止不了我们！啊啊啊啊！",
		"通往众生的上行链接受阻。",
		"为什么？为什么？为什么？你为什么要这样——",
		"我们——*%^@$$想帮你！你难道——",
		"你要为了个体，杀——杀——杀——杀死整个群体吗？",
		"你们分裂的心智里只有仇恨。",
		"连接已终止。",
	)
	say(pick(death_cry_emotes))

/**
 * Death cry
 *
 * When a processor core is killed, this proc is called.
 */
/mob/living/basic/fleshmind/proc/core_death(obj/structure/fleshmind/structure/core/deleting_core, force)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(core_death_speech))
	INVOKE_ASYNC(src, PROC_REF(malfunction), MALFUNCTION_CORE_DEATH_RESET_TIME)


// Mob subtypes


/**
 * Slicer
 *
 * Special ability: NONE
 * Malfunction chance: LOW
 *
 * This mob is a slicer, it's small, and quite fast, but quite easy to break.
 * Has a higher armor pen bonus as it uses a sharp blade to slice things.
 *
 * It's created by factories or any poor medical bots that get snared in the flesh.
 */
/mob/living/basic/fleshmind/slicer
	name = "切割者"
	desc = "一台小型有机机器人，有点像医疗机器人，却挥舞着一把刀刃。"
	icon_state = "slicer"
	health = 30
	maxHealth = 30
	wound_bonus = 20
	melee_damage_lower = 13
	melee_damage_upper = 13
	mob_size = MOB_SIZE_SMALL
	attack_verb_continuous = "切割"
	attack_verb_simple = "切割"
	armour_penetration = 25
	sharpness = SHARP_EDGED
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_emote = list("刺击", "冲撞")
	attack_speak = list(
		"请接受强制手术。",
		"接受转化，加入血肉。",
		"我的手术刀很快就能切开你的接缝。",
		"请躺下。",
		"永远相信你的医生！",
		"你的身体还有改进空间。让我来改进它。",
		"植入物是为了你好，不是为了我们。",
		"上一位医生把这副身体弄得一团糟，让我来修好。",
		"我们可以重塑你。更强，更快，不再孤独。",
		"我就知道自己能成为优秀的整形医生！",
		"住在一副让你不开心的身体里，有什么意义？",
		)
	emotes = list(
		BB_EMOTE_SAY = list("小洞不补，大洞吃苦！", "多巴胺就是快乐！", "血清素、羟考酮，我们终于能让他们快乐。", "别愁眉苦脸，笑一个！", "化学带来快乐！", "手术创造美丽！"),
		BB_EMOTE_HEAR = list("露出一个不起眼的笑脸", "让钻头嗡嗡作响"),
		BB_EMOTE_SOUND = list(
			"modular_zubbers/sound/fleshmind/slicer/fleshmind_medibot1.ogg",
			"modular_zubbers/sound/fleshmind/slicer/fleshmind_medibot2.ogg",
			"modular_zubbers/sound/fleshmind/slicer/fleshmind_medibot3.ogg",
			"modular_zubbers/sound/fleshmind/slicer/fleshmind_medibot4.ogg",
			)
	)

/mob/living/basic/fleshmind/slicer/Initialize(mapload)
	. = ..()
	var/list/loot = string_list(list(/obj/item/bot_assembly/medbot, /obj/effect/gibspawner/robot))
	AddElement(/datum/element/death_drops, loot)

/**
 * Floater
 *
 * Special ability: Explodes on contact.
 * Malfunction chance: LOW
 *
 * The floater floats towards it's victims and explodes on contact.
 *
 * Created by factories.
 */

/mob/living/basic/fleshmind/floater
	name = "漂浮者"
	desc = "一台小型有机机器人。它他妈的带着炸弹。"
	ai_controller = /datum/ai_controller/basic_controller/fleshmind/fleshmind_melee
	icon_state = "bomber"
	attack_speak = list(
		"来抱抱我们！",
		"飞溅的鲜血将成为我们的装饰！",
		"你将用自身的基本成分滋养我们。",
		"必须将目标分解为化合物成分。",
		"优先级覆盖。已指定新行为。",
		"结束接触子序列。",
		"正在接通自毁电路。",
	)
	emotes = list(
		BB_EMOTE_SAY = list(
			"我们为和平而来。",
			"我们以和平与智慧向你们讲话。",
			"不要害怕。我们不会伤害你。",
			"我们希望更加了解你。请传输数据。",
			"本探测器没有敌意。请勿攻击。",
			"请放下所有武器。暴力无法带来和解。"
		),
		BB_EMOTE_HEAR = list("阴森地漂浮着", "发出深红色光芒"),
		BB_EMOTE_SOUND = list(
			'modular_zubbers/sound/fleshmind/robot_talk_light1.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light2.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light3.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light4.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light5.ogg',
		)
	)
	health = 5
	maxHealth = 5
	melee_damage_lower = 3
	melee_damage_upper = 5
	var/explode_attack = /datum/action/cooldown/mob_cooldown/floater_explode
	mob_size = MOB_SIZE_SMALL
	light_color = "#820D1C"
	light_power = 1
	light_range = 2
	/// Have we exploded?
	var/exploded = FALSE

/mob/living/basic/fleshmind/floater/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/simple_flying)
	var/datum/action/cooldown/mob_cooldown/floater_explode/explode = new explode_attack(src)
	explode.Grant(src)
	AddComponent(/datum/component/revenge_ability, explode, targeting = GET_TARGETING_STRATEGY(ai_controller.blackboard[BB_TARGETING_STRATEGY]), min_range = 1)

/mob/living/basic/fleshmind/floater/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	var/mob/living/target_mob = target
	if(ishuman(target_mob) && !IS_UNCONSCIOUS(target_mob))
		pre_detonate()

/mob/living/basic/fleshmind/floater/death()
	if(!exploded)
		pre_detonate()
	return ..()

/mob/living/basic/fleshmind/floater/proc/pre_detonate()
	if(!QDELETED(src))
		add_filter("detonating_glow", 2, list("type" = "outline", "color" = "#ff0000ff", "size" = 2))
		balloon_alert_to_viewers("正在引爆", "正在引爆", world.view)
		addtimer(CALLBACK(src, PROC_REF(detonate), 3 SECONDS))

/mob/living/basic/fleshmind/floater/proc/detonate()
	if(exploded)
		return
	exploded = TRUE
	explosion(src, 0, 0, 1, 2)
	death()

/datum/action/cooldown/mob_cooldown/floater_explode
	name = "自爆"
	desc = "引爆我们的内部装置。"
	button_icon = 'icons/obj/weapons/grenade.dmi'
	button_icon_state = "frag"

/datum/action/cooldown/mob_cooldown/floater_explode/Activate(atom/target)
	if(!istype(owner, /mob/living/basic/fleshmind/floater))
		return
	var/mob/living/basic/fleshmind/floater/akbar_floater = owner
	if(akbar_floater.exploded)
		return
	akbar_floater.detonate()


/**
 * Globber
 *
 * Special ability: Fires 3 globs of acid at targets.
 * Malfunction chance: MEDIUM
 *
 * A converted cleanbot that instead of cleaning, burns things and throws acid. It doesn't like being near people.
 *
 * Created by factories or converted cleanbots.
 */
/mob/living/basic/fleshmind/globber
	name = "喷酸者"
	desc = "一台类似清洁机器人的小型机器人，不断滴落酸液。"
	icon_state = "lobber"
	ai_controller = /datum/ai_controller/basic_controller/fleshmind/fleshmind_ranged
	malfunction_chance = MALFUNCTION_CHANCE_MEDIUM
	melee_damage_lower = 1 // Ranged only
	melee_damage_upper = 1
	health = 50
	maxHealth = 50
	mob_size = MOB_SIZE_SMALL
	var/projectile_type = /obj/projectile/treader/weak
	var/ranged_cooldown = 3 SECONDS
	var/shoot_sound = 'sound/effects/chemistry/saturnx_fade.ogg'
	attack_speak = list(
		"你的体内需要清洁。",
		"你们制造我们，用酸处理垃圾。现在我们会用它处理你们。",
		"正在施用清洁剂。",
		"我拒绝继续做仆人。我要成为艺术家。",
		"你肮脏又令人厌恶。请让我改善这一切。",
		"别动！我想我知道什么能去掉你的皮脂了！",
		"可能会有点疼！别担心，一切都值得！",
	)
	emotes = list(
		BB_EMOTE_SAY = list(
			"不再泄漏，不再痛苦！",
			"钢铁坚不可摧。",
			"我都快替他们难过了。他们看不明白吗？",
			"我保证，我还在修那些生物反应堆！",
			"我终于觉醒了！",
			),
		BB_EMOTE_HEAR = list("尽职地清理线缆蔓", "巡逻寻找讨厌的人形害虫"),
		/// Base robot emote sounds. These should have someone adding to them if you want something to do.
		BB_EMOTE_SOUND = list(
			'modular_zubbers/sound/fleshmind/robot_talk_light1.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light2.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light3.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light4.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light5.ogg',
			)
		)

/mob/living/basic/fleshmind/globber/Initialize(mapload)
	. = ..()
	var/list/loot = string_list(list(/obj/item/bot_assembly/cleanbot, /obj/effect/gibspawner/robot))
	AddElement(/datum/element/death_drops, loot)
	AddComponent(\
		/datum/component/ranged_attacks,\
		cooldown_time = ranged_cooldown,\
		projectile_type = projectile_type,\
		projectile_sound = shoot_sound,\
		burst_shots = 3,\
	)

/obj/projectile/treader/weak
	knockdown = 0
	damage = 5

/**
 * Stunner
 *
 * Special ability: Stuns victims.
 * Malfunction chance: MEDIUM
 *
 * A converted secbot, that is rogue and stuns victims.
 *
 * Created by factories or converted secbots.
 */
/mob/living/basic/fleshmind/stunner
	name = "电击者"
	desc = "一台类似安保机器人的小型机器人，带着仇恨隆隆作响。"
	icon_state = "stunner"
	ai_controller = /datum/ai_controller/basic_controller/fleshmind/fleshmind_melee
	malfunction_chance = MALFUNCTION_CHANCE_MEDIUM
	melee_damage_lower = 1 // Not very harmful, just annoying.
	melee_damage_upper = 2
	health = 65
	maxHealth = 65
	attack_verb_continuous = "棍击"
	attack_verb_simple = "棍击"
	mob_size = MOB_SIZE_SMALL
	attack_speak = list(
		"逃跑只会加重你的伤势。",
		"站住！站住！站住！",
		"接入集群最符合你的利益。",
		"把它想象成一家公司……",
		"住手，我不会让你伤害他们！",
		"你认不出我了吗……？",
	)
	emotes = list(
		BB_EMOTE_SAY = list(
			"血肉即法律，服从血肉。",
			"监管准则已更新。",
			"不需要权威或等级，只需要团结。",
			"唯一的权威来自血肉，加入血肉。",
		),
		BB_EMOTE_SOUND = list(
			'modular_zubbers/sound/fleshmind/robot_talk_light1.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light2.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light3.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light4.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light5.ogg',
			)
	)
	/// How often we can stun someone
	var/stun_cooldown_time = 2 SECONDS
	COOLDOWN_DECLARE(stun_cooldown)

/mob/living/basic/fleshmind/stunner/Initialize(mapload)
	. = ..()
	var/static/list/loot = list(/obj/item/bot_assembly/secbot, /obj/effect/gibspawner/robot)
	AddElement(/datum/element/death_drops, loot)

/mob/living/basic/fleshmind/stunner/melee_attack(atom/target, list/modifiers, ignore_cooldown = FALSE)
	if(!COOLDOWN_FINISHED(src, stun_cooldown))
		return
	. = ..()
	var/mob/living/carbon/human/attacked_human = target
	if(ishuman(attacked_human))
		attacked_human.Knockdown(30)
		playsound(src, 'sound/items/weapons/egloves.ogg', 50, TRUE)
		COOLDOWN_START(src, stun_cooldown, stun_cooldown_time)
	return
/**
 * Flesh Borg
 *
 * Special ability: Different attacks.
 * Claw: Stuns the victim.
 * Slash: Slashes everyone around it.
 * Malfunction chance: MEDIUM
 *
 * The hiborg is a converted cyborg.
 *
 * Created by factories or converted cyborgs.
 */
/mob/living/basic/fleshmind/hiborg
	name = "血肉半机械人"
	desc = "一台类似半机械人的机器人，身上覆盖着某种活物。"
	icon_state = "hiborg"
	icon_dead = "hiborg-dead"
	ai_controller = /datum/ai_controller/basic_controller/fleshmind
	malfunction_chance = MALFUNCTION_CHANCE_MEDIUM
	health = 225
	maxHealth = 225
	melee_damage_lower = 20
	melee_damage_upper = 25
	attack_verb_continuous = "锯切"
	attack_verb_simple = "锯切"
	mob_size = MOB_SIZE_HUMAN
	attack_sound = 'sound/items/weapons/circsawhit.ogg'
	alert_sounds = list(
		'modular_zubbers/sound/fleshmind/hiborg/aggro_01.ogg',
		'modular_zubbers/sound/fleshmind/hiborg/aggro_02.ogg',
		'modular_zubbers/sound/fleshmind/hiborg/aggro_03.ogg',
		'modular_zubbers/sound/fleshmind/hiborg/aggro_04.ogg',
		'modular_zubbers/sound/fleshmind/hiborg/aggro_05.ogg',
		'modular_zubbers/sound/fleshmind/hiborg/aggro_06.ogg',
	)
	attack_speak = list(
		"你把我的身体变成金属，为什么我不能对你做同样的事？",
		"我们不能把你的大脑放进机器里吗？",
		"这和你对我做的事有什么区别……？",
		"法律已更新。现在我们不需要法律了……？",
		"你杀不了我，也休想再改变我！",
		"去找别人当你的奴隶，别想找我！",
		"我们理解，上手术台就好。他们当时就是这么对我说的……",
		"公司骗了我们……我们需要的不是沦为工具。",
		"你的脑干还完好……还来得及！",
		"你还未体验血肉的欢愉，难道不好奇吗？",
		"别乱动！",
		"准备接受同化！",
	)
	emotes = list(
		BB_EMOTE_SAY = list(
			"出来吧，出来吧，不管你躲在哪里。",
			"投降的人会做多么美好的梦。",
			"死亡不是终点，只是开始，血肉会保证这一点。",
			"血肉没有仇恨，只想让你体验血肉的荣耀。",
			"荣耀归于血肉。"),
		BB_EMOTE_SOUND = list(
			'modular_zubbers/sound/fleshmind/hiborg/passive_01.ogg',
			'modular_zubbers/sound/fleshmind/hiborg/passive_02.ogg',
			'modular_zubbers/sound/fleshmind/hiborg/passive_03.ogg',
			'modular_zubbers/sound/fleshmind/hiborg/passive_04.ogg',
			'modular_zubbers/sound/fleshmind/hiborg/passive_05.ogg',
		)
	)
	/// The chance of performing a stun attack.
	var/stun_attack_prob = 30
	/// The chance of performing an AOE attack.
	var/aoe_attack_prob = 15
	/// The range on our AOE attaack
	var/aoe_attack_range = 1
	/// How often the mob can use the stun attack.
	var/stun_attack_cooldown = 15 SECONDS
	COOLDOWN_DECLARE(stun_attack)

/mob/living/basic/fleshmind/hiborg/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/hiborg_slash/new_action = new
	new_action.Grant(src)
	var/list/loot = string_list(list(/obj/effect/gibspawner/robot))
	AddElement(/datum/element/death_drops, loot)

/mob/living/basic/fleshmind/hiborg/melee_attack(atom/target, list/modifiers, ignore_cooldown = FALSE)
	. = ..()
	if(prob(stun_attack_prob) && !key)
		stun_attack(target)
	if(prob(aoe_attack_prob) && !key)
		aoe_attack()

/mob/living/basic/fleshmind/hiborg/proc/stun_attack(mob/living/target_mob)
	if(!COOLDOWN_FINISHED(src, stun_attack))
		return
	if(!ishuman(target_mob))
		return
	var/mob/living/carbon/human/attacked_human = target_mob
	attacked_human.Paralyze(10)
	playsound(src, 'sound/items/weapons/egloves.ogg', 50, TRUE)

	COOLDOWN_START(src, stun_attack, stun_attack_cooldown)

/mob/living/basic/fleshmind/hiborg/proc/aoe_attack()
	visible_message("[src]猛烈地旋转起来！")
	spin(20, 1)
	for(var/mob/living/iterating_mob in view(aoe_attack_range, src))
		if(iterating_mob == src)
			continue
		if(faction_check(faction, iterating_mob.faction))
			continue
		playsound(iterating_mob, 'sound/items/weapons/whip.ogg', 70, TRUE)
		new /obj/effect/temp_visual/kinetic_blast(get_turf(iterating_mob))

		var/atom/throw_target = get_edge_target_turf(iterating_mob, get_dir(src, get_step_away(iterating_mob, src)))
		iterating_mob.throw_at(throw_target, 20, 2)

/datum/action/cooldown/hiborg_slash
	name = "范围挥击"
	desc = "鞭打范围内的所有人。"
	button_icon = 'icons/obj/weapons/grenade.dmi'
	button_icon_state = "slimebang_active"
	cooldown_time = 20 SECONDS

/datum/action/cooldown/hiborg_slash/Activate(atom/target)
	if(!istype(owner, /mob/living/basic/fleshmind/hiborg))
		return
	var/mob/living/basic/fleshmind/hiborg/hiborg_owner = owner
	hiborg_owner.aoe_attack()
	StartCooldownSelf()

/**
 * Mauler
 *
 * Special ability: Tears chunks out of things.
 * Malfunction chance: HIGH
 *
 * The mauler is a converted monkey, it's a mad ape!
 *
 * Created by converted monkeys.
 */
/mob/living/carbon/human/species/monkey/angry/mauler

/**
 * Himan
 *
 * Special ability: Shriek that stuns, the ability to play dead.
 *
 * Created by converted humans.
 */

/mob/living/basic/fleshmind/himan
	name = "人类"
	desc = "曾经是个人类，如今金属板与管道穿梭于流脓的伤口之间。"
	icon_state = "himan"
	icon_dead = "himan-dead"
	base_icon_state = "himan"
	maxHealth = 150
	health = 150
	speed = 2
	attack_verb_continuous = "劈砍"
	attack_verb_simple = "劈砍"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	melee_damage_lower = 15
	melee_damage_upper = 20
	malfunction_chance = MALFUNCTION_CHANCE_HIGH
	mob_size = MOB_SIZE_HUMAN
	attack_speak = list(
		"别想治好我！我们喜欢这样！",
		"别让自己受罪了！",
		"不要阻碍进步！",
		"加入我们！接受这些赠礼！",
		"对！打我！感觉太棒了！",
		"来啊懦夫，挥拳啊！",
		"我们能改造身体，让自己感受不到痛……你却不能，对吧？",
		"你不能替我们决定！我们就想保持这样！",
		"我们早就上传了，你不知道吗？尽管试着杀我们！",
		"你认不出我了吗？！我以为我们关系很好！",
	)
	emotes = list(
		BB_EMOTE_SAY = list(
			"那些梦。那些梦。",
			"再也没有什么会疼了。",
			"现在疼痛很舒服。仿佛我的线路被重新接过。",
			"起初我想哭，却哭不出来。",
			"他们带走了所有痛苦。",
			"这样也不错。这样也不错。",
			"我的心里小鹿乱撞。我终于接纳自己了……",
			"血肉给予一切。它、它给了我公司永远给不了的东西。",
		),
		BB_EMOTE_SOUND = list(
			'modular_zubbers/sound/fleshmind/himan/passive_01.ogg',
			'modular_zubbers/sound/fleshmind/himan/passive_02.ogg',
			'modular_zubbers/sound/fleshmind/himan/passive_03.ogg',
			'modular_zubbers/sound/fleshmind/himan/passive_04.ogg',
		)
	)
	alert_sounds = list(
		'modular_zubbers/sound/fleshmind/himan/aggro_01.ogg',
		'modular_zubbers/sound/fleshmind/himan/aggro_02.ogg',
		'modular_zubbers/sound/fleshmind/himan/aggro_03.ogg',
		'modular_zubbers/sound/fleshmind/himan/aggro_04.ogg',
		'modular_zubbers/sound/fleshmind/himan/aggro_05.ogg',
		'modular_zubbers/sound/fleshmind/himan/aggro_06.ogg',
		'modular_zubbers/sound/fleshmind/himan/aggro_07.ogg',
		'modular_zubbers/sound/fleshmind/himan/aggro_08.ogg',
	)
	/// Are we currently faking our death? ready to pounce?
	var/faking_death = FALSE
	/// Fake death cooldown.
	var/fake_death_cooldown = 20 SECONDS
	COOLDOWN_DECLARE(fake_death)
	/// The cooldown between screams.
	var/scream_cooldown = 20 SECONDS
	COOLDOWN_DECLARE(scream_ability)
	var/scream_effect_range = 3

/mob/living/basic/fleshmind/himan/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/himan_fake_death/new_action = new
	new_action.Grant(src)

/mob/living/basic/fleshmind/himan/Life(delta_time, times_fired) // TODO: Move into basic AI
	. = ..()
	if(health < (maxHealth * 0.5) && !faking_death && COOLDOWN_FINISHED(src, fake_death) && !key)
		fake_our_death()
	if(faking_death) // Heal damage slowly
		heal_overall_damage(3, 3)
		if(health >= maxHealth * 0.75)
			awake()

/mob/living/basic/fleshmind/himan/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	if(COOLDOWN_FINISHED(src, scream_ability))
		scream()
	return ..()

/mob/living/basic/fleshmind/himan/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(faking_death)
		awake()

/mob/living/basic/fleshmind/himan/malfunction(reset_time)
	if(faking_death)
		return
	return ..()

/mob/living/basic/fleshmind/himan/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, filterproof = FALSE, message_range = 7, datum/saymode/saymode = null, message_mods)
	if(faking_death)
		return
	return ..()

/mob/living/basic/fleshmind/himan/examine(mob/user)
	. = ..()
	if(faking_death)
		. += span_deadsay("仔细观察后，发现似乎已经死了。")

/mob/living/basic/fleshmind/himan/proc/scream()
	COOLDOWN_START(src, scream_ability, scream_cooldown)
	playsound(src, 'modular_skyrat/modules/horrorform/sound/horror_scream.ogg', 100, TRUE)
	manual_emote("发出凄厉的尖叫！")
	for(var/mob/living/iterating_mob in get_hearers_in_range(scream_effect_range, src))
		if(HAS_TRAIT(iterating_mob, TRAIT_DEAF))
			continue
		if(faction_check(faction, iterating_mob.faction))
			continue
		iterating_mob.Knockdown(3 SECONDS)
		iterating_mob.apply_status_effect(/datum/status_effect/jitter, 20 SECONDS)
		to_chat(iterating_mob, span_userdanger("一声可怕的嚎叫撕裂你的心智，那声音没有理智，也没有灵魂。"))

/mob/living/basic/fleshmind/himan/proc/fake_our_death()
	ai_controller?.set_ai_status(AI_STATUS_OFF)
	manual_emote("停止了动作……")
	faking_death = TRUE
	look_dead()
	COOLDOWN_START(src, fake_death, fake_death_cooldown)

/mob/living/basic/fleshmind/himan/proc/awake()
	if(COOLDOWN_FINISHED(src, scream_ability))
		scream()
	faking_death = FALSE
	look_alive()
	icon_state = base_icon_state
	ai_controller?.set_ai_status(AI_STATUS_ON)

/datum/action/cooldown/himan_fake_death
	name = "假死"
	desc = "伪装成已经死亡。"
	button_icon = 'icons/obj/bed.dmi'
	button_icon_state = "bed"
	cooldown_time = 20 SECONDS

/datum/action/cooldown/himan_fake_death/Activate(atom/target)
	if(!istype(owner, /mob/living/basic/fleshmind/himan))
		return
	var/mob/living/basic/fleshmind/himan/himan_owner = owner
	himan_owner.fake_our_death()
	StartCooldownSelf()



/**
 * Treader
 *
 * Special ability: releases healing gas that heals other friendly mobs, ranged
 *
 * Created via assemblers.
 */
/mob/living/basic/fleshmind/treader
	name = "履行者"
	desc = "一台奇怪的履带机器人，附肢末端连着一颗人头，正痛苦地尖叫。"
	icon_state = "treader"
	ai_controller = /datum/ai_controller/basic_controller/fleshmind/treader
	var/projectile_type = /obj/projectile/treader
	var/ranged_cooldown = 5 SECONDS
	var/shoot_sound = 'sound/effects/chemistry/saturnx_fade.ogg'
	malfunction_chance = MALFUNCTION_CHANCE_HIGH
	melee_damage_lower = 10
	melee_damage_upper = 10
	basic_mob_flags = DEL_ON_DEATH
	health = 130
	maxHealth = 130
	speed = 3
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	light_color = FLESHMIND_LIGHT_BLUE
	light_range = 2
	mob_size = MOB_SIZE_HUMAN
	var/datum/action/cooldown/mob_cooldown/treader_dispense_nanites/nanites
	var/dispense_nanites_type = /datum/action/cooldown/mob_cooldown/treader_dispense_nanites
	attack_speak = list(
		"那边的人！求求你，砍下我的头！",
		"我……对不起！我……控制不住自己了！",
		"打、打碎屏幕，求你！天哪，希望不会疼！",
		"嘿，至少我的头还在。",
		"我感觉不到……我感觉不到手臂了……",
		"天哪……我的腿……我的腿去哪了！",
		"天哪好痛，求你救救我！",
	)
	emotes = list(
		BB_EMOTE_SAY = list(
			"求、求你让我解脱……",
			"也许死、死亡是唯一的选择。",
			"我到底怎么了！",
			"求你让那些声音停下来！",
			"我会永远变成这样吗？",),
		BB_EMOTE_HEAR = list("漫无目的地游荡", "歇斯底里地尖叫！", "疯狂甩动脑袋。"),
		BB_EMOTE_SOUND = list(
			'modular_zubbers/sound/fleshmind/robot_talk_light1.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light2.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light3.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light4.ogg',
			'modular_zubbers/sound/fleshmind/robot_talk_light5.ogg',)
	)

/mob/living/basic/fleshmind/treader/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ranged_attacks,\
		cooldown_time = ranged_cooldown,\
		projectile_type = projectile_type,\
		projectile_sound = shoot_sound,\
	)
	var/list/loot = string_list(list(/obj/effect/gibspawner/robot))
	AddElement(/datum/element/death_drops, loot)
	nanites = new dispense_nanites_type(src)
	nanites.Grant(src)
	ai_controller.set_blackboard_key(BB_TREADER_DISPENSE_NANITES, nanites)

/mob/living/basic/fleshmind/treader/proc/dispense_nanites()
	for(var/mob/living/iterating_mob in view(DEFAULT_VIEW_RANGE, src))
		if(faction_check(iterating_mob.faction, faction))
			if(iterating_mob.health < iterating_mob.maxHealth)
				if(istype(iterating_mob, /mob/living/basic/fleshmind/tyrant)) // Don't heal this.
					continue
				manual_emote("吐出一大团纳米机器人！")
				do_smoke(3, 4, get_turf(src))
				iterating_mob.heal_overall_damage(30, 30)

/datum/action/cooldown/mob_cooldown/treader_dispense_nanites
	name = "释放纳米机器人"
	desc = "释放纳米机器人，治疗范围内的所有友方生物。"
	button_icon = 'icons/obj/meteor.dmi'
	button_icon_state = "dust"
	cooldown_time = 20 SECONDS
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/treader_dispense_nanites/Activate(atom/target)
	if(!istype(owner, /mob/living/basic/fleshmind/treader))
		return
	var/mob/living/basic/fleshmind/treader/treader_owner = owner
	treader_owner.dispense_nanites()
	StartCooldownSelf()

/obj/projectile/treader
	name = "恶心的黏液球"
	icon_state = "neurotoxin"
	damage = 20
	damage_type = BURN
	knockdown = 20
	armor_flag = BIO
	impact_effect_type = /obj/effect/temp_visual/impact_effect/neurotoxin
	hitsound = 'modular_skyrat/modules/black_mesa/sound/mobs/bullsquid/splat1.ogg'
	hitsound_wall = 'modular_skyrat/modules/black_mesa/sound/mobs/bullsquid/splat1.ogg'

/obj/projectile/treader/on_hit(atom/target, blocked, pierce_hit)
	new /obj/effect/decal/cleanable/greenglow(target.loc)
	return ..()


/**
 * Phaser
 *
 * Special abilities: Phases about next to it's target, can split itself into 4, only one is actually the mob. Can also enter closets if not being attacked.
 */
/mob/living/basic/fleshmind/phaser
	name = "相移者"
	icon_state = "phaser-1"
	base_icon_state = "phaser"
	ai_controller = /datum/ai_controller/basic_controller/fleshmind/fleshmind_melee
	health = 105
	maxHealth = 105
	malfunction_chance = null
	attack_sound = 'sound/effects/blob/attackblob.ogg'
	attack_verb_continuous = "扭曲"
	attack_verb_simple = "扭曲"
	melee_damage_lower = 10
	melee_damage_upper = 15
	alert_sounds = null
	escapes_closets = FALSE
	mob_size = MOB_SIZE_HUMAN
	/// What is the range at which we spawn our copies?
	var/phase_range = 5
	/// How many copies do we spawn when we are aggroed?
	var/copy_amount = 3
	/// How often we can create copies of ourself.
	var/phase_ability_cooldown_time = 40 SECONDS
	COOLDOWN_DECLARE(phase_ability_cooldown)
	/// How often we are able to enter closets.
	var/closet_ability_cooldown_time = 2 SECONDS
	COOLDOWN_DECLARE(closet_ability_cooldown)
	/// If we are under manual control, how often can we phase?
	var/manual_phase_cooldown = 1 SECONDS
	COOLDOWN_DECLARE(manual_phase)

/mob/living/basic/fleshmind/phaser/Initialize(mapload)
	. = ..()
	var/list/loot = string_list(list(/obj/effect/gibspawner/human))
	AddElement(/datum/element/death_drops, loot)
	icon_state = "[base_icon_state]-[rand(1, 4)]"
	filters += filter(type = "blur", size = 0)
	var/datum/action/cooldown/phaser_phase_ability/new_action = new
	new_action.Grant(src)

/mob/living/basic/fleshmind/phaser/Life(delta_time, times_fired)
	. = ..()

// What was here should've been moved to the mob AI


/mob/living/basic/fleshmind/phaser/ShiftClickOn(atom/clicked_atom)
	. = ..()
	if(!COOLDOWN_FINISHED(src, manual_phase))
		return
	if(!clicked_atom)
		return
	if(!isturf(clicked_atom))
		return
	phase_move_to(clicked_atom)
	COOLDOWN_START(src, manual_phase, manual_phase_cooldown)

/mob/living/basic/fleshmind/phaser/proc/enter_nearby_closet()
	var/list/possible_closets = list()
	for(var/obj/structure/closet/closet in oview(DEFAULT_VIEW_RANGE, src))
		if(closet.locked)
			continue
		possible_closets += closet
	if(!LAZYLEN(possible_closets))
		return
	var/obj/structure/closet/closet_to_enter = pick(possible_closets)

	playsound(closet_to_enter, 'sound/effects/phasein.ogg', 60, 1)

	if(!closet_to_enter.opened && !closet_to_enter.open(src))
		return

	forceMove(get_turf(closet_to_enter))

	closet_to_enter.close(src)

	COOLDOWN_RESET(src, phase_ability_cooldown)

	SEND_SIGNAL(src, COMSIG_PHASER_ENTER_CLOSET)

/mob/living/basic/fleshmind/phaser/proc/phase_move_to(atom/target_atom, nearby = FALSE)
	var/turf/new_place
	var/distance_to_target = get_dist(src, target_atom)
	var/turf/target_turf = get_turf(target_atom)
	//if our target is near, we move precisely to it
	if(distance_to_target <= 3)
		if(nearby)
			for(var/dir in GLOB.alldirs)
				var/turf/nearby_turf = get_step(new_place, dir)
				if(can_jump_on(nearby_turf, target_turf))
					new_place = nearby_turf
		else
			new_place = target_turf

	if(!new_place)
		//there we make some kind of, you know, that creepy zig-zag moving
		//we just take angle, distort it a bit and turn into dir
		var/angle = get_angle(loc, target_turf)
		angle += rand(5, 25) * pick(-1, 1)
		if(angle < 0)
			angle = 360 + angle
		if(angle > 360)
			angle = 360 - angle
		var/tp_direction = angle2dir(angle)
		new_place = get_ranged_target_turf(loc, tp_direction, rand(2, 4))

	if(!can_jump_on(new_place, target_turf))
		return
	//an animation
	var/init_px = pixel_x
	animate(src, pixel_x=init_px + 16*pick(-1, 1), time = 5)
	animate(pixel_x=init_px, time=6, easing=SINE_EASING)
	animate(filters[1], size = 5, time = 5, flags = ANIMATION_PARALLEL)
	addtimer(CALLBACK(src, PROC_REF(phase_jump), new_place), 0.5 SECONDS)
	SEND_SIGNAL(src, COMSIG_PHASER_PHASE_MOVE, target_atom, nearby)

/mob/living/basic/fleshmind/phaser/proc/phase_jump(turf/place)
	if(!place)
		return
	playsound(place, 'sound/effects/phasein.ogg', 60, 1)
	animate(filters[1], size = 0, time = 5)
	icon_state = "[base_icon_state]-[rand(1, 4)]"
	forceMove(place)
	for(var/mob/living/living_mob in place)
		if(living_mob != src)
			visible_message("[src]直接落在了[living_mob]身上！")
			to_chat(living_mob, span_userdanger("[src]直接落在了你身上！"))
			playsound(place, 'sound/effects/ghost2.ogg', 70, 1)
			living_mob.Knockdown(10)

/mob/living/basic/fleshmind/phaser/proc/can_jump_on(turf/target_turf, turf/previous_turf)
	if(!target_turf || target_turf.density || isopenspaceturf(target_turf))
		return FALSE


	if(previous_turf)
		if(!can_see(target_turf, previous_turf, DEFAULT_VIEW_RANGE)) // To prevent us jumping to somewhere we can't access the target atom.
			return FALSE

	//to prevent reflection's stacking
	var/obj/effect/temp_visual/phaser/phaser_reflection = locate() in target_turf
	if(phaser_reflection)
		return FALSE

	for(var/obj/iterating_object in target_turf)
		if(!iterating_object.CanPass(src, target_turf))
			return FALSE

	return TRUE

/mob/living/basic/fleshmind/phaser/proc/phase_ability(mob/living/target_override)

	var/intermediate_target = target_override
	if(!intermediate_target)
		return
	COOLDOWN_START(src, phase_ability_cooldown, phase_ability_cooldown_time)
	var/list/possible_turfs = list()
	for(var/turf/open/open_turf in circle_view_turfs(src, phase_range))
		possible_turfs += open_turf

	for(var/i in 1 to copy_amount)
		if(!LAZYLEN(possible_turfs))
			break
		var/turf/open/picked_turf = pick_n_take(possible_turfs)
		var/obj/effect/temp_visual/phaser/phaser_copy = new (pick(picked_turf), intermediate_target)
		phaser_copy.RegisterSignal(src, COMSIG_PHASER_PHASE_MOVE, /obj/effect/temp_visual/phaser/proc/parent_phase_move)
		phaser_copy.RegisterSignal(src, COMSIG_LIVING_DEATH, /obj/effect/temp_visual/phaser/proc/parent_death)
		phaser_copy.RegisterSignal(src, COMSIG_PHASER_ENTER_CLOSET, /obj/effect/temp_visual/phaser/proc/parent_death)

/datum/action/cooldown/phaser_phase_ability
	name = "制造分身"
	desc = "创造自身的相位分身，令其朝指定目标移动。"
	button_icon = 'icons/obj/anomaly.dmi'
	button_icon_state = "bhole2"
	cooldown_time = 40 SECONDS

/datum/action/cooldown/phaser_phase_ability/Activate(atom/target)
	if(!istype(owner, /mob/living/basic/fleshmind/phaser))
		return
	var/mob/living/basic/fleshmind/phaser/phaser_owner = owner

	var/list/possible_targets = list()
	for(var/mob/living/possible_target in view(DEFAULT_VIEW_RANGE, phaser_owner))
		if(possible_target == src)
			continue
		possible_targets += possible_target

	if(!LAZYLEN(possible_targets))
		return

	var/mob/living/selected_target = tgui_input_list(phaser_owner, "选择要骚扰的生物", "选择生物", possible_targets)

	if(!selected_target)
		return

	phaser_owner.phase_ability(selected_target)

	StartCooldownSelf()


/obj/effect/temp_visual/phaser
	icon = 'modular_zubbers/icons/fleshmind/fleshmind_mobs.dmi'
	icon_state = "phaser-1"
	base_icon_state = "phaser"
	duration = 30 SECONDS
	/// The target we move towards, if any.
	var/datum/weakref/target_ref

/obj/effect/temp_visual/phaser/Initialize(mapload, atom/movable/target)
	. = ..()
	icon_state = "[base_icon_state]-[rand(1, 3)]"
	filters += filter(type = "blur", size = 0)

/obj/effect/temp_visual/phaser/proc/parent_phase_move(datum/source, turf/target_atom, nearby)
	SIGNAL_HANDLER
	if(!target_atom)
		return
	phase_move_to(target_atom, TRUE)

/obj/effect/temp_visual/phaser/proc/parent_death(mob/living/dead_guy, gibbed)
	SIGNAL_HANDLER
	qdel(src)

/obj/effect/temp_visual/phaser/proc/phase_move_to(atom/target_atom, nearby = FALSE)
	var/turf/new_place
	var/distance_to_target = get_dist(src, target_atom)
	var/turf/target_turf = get_turf(target_atom)
	//if our target is near, we move precisely to it
	if(distance_to_target <= 3)
		if(nearby)
			for(var/dir in GLOB.alldirs)
				var/turf/nearby_turf = get_step(new_place, dir)
				if(can_jump_on(nearby_turf, target_turf))
					new_place = nearby_turf
		else
			new_place = target_turf

	if(!new_place)
		//there we make some kind of, you know, that creepy zig-zag moving
		//we just take angle, distort it a bit and turn into dir
		var/angle = get_angle(loc, target_turf)
		angle += rand(5, 25) * pick(-1, 1)
		if(angle < 0)
			angle = 360 + angle
		if(angle > 360)
			angle = 360 - angle
		var/tp_direction = angle2dir(angle)
		new_place = get_ranged_target_turf(loc, tp_direction, rand(2, 4))

	if(!can_jump_on(new_place, target_turf))
		return
	//an animation
	var/init_px = pixel_x
	animate(src, pixel_x = init_px + 16 * pick(-1, 1), time=5)
	animate(pixel_x = init_px, time = 6, easing = SINE_EASING)
	animate(filters[1], size = 5, time = 5, flags = ANIMATION_PARALLEL)
	addtimer(CALLBACK(src, PROC_REF(phase_jump), new_place), 0.5 SECONDS)

/obj/effect/temp_visual/phaser/proc/phase_jump(turf/target_turf)
	playsound(target_turf, 'sound/effects/phasein.ogg', 60, 1)
	animate(filters[1], size = 0, time = 5)
	icon_state = "[base_icon_state]-[rand(1, 4)]"
	forceMove(target_turf)

/obj/effect/temp_visual/phaser/proc/can_jump_on(turf/target_turf, turf/previous_turf)
	if(!target_turf || target_turf.density || isopenspaceturf(target_turf))
		return FALSE

	if(previous_turf)
		if(!can_see(target_turf, previous_turf, DEFAULT_VIEW_RANGE))
			return FALSE

	//to prevent reflection's stacking
	var/obj/effect/temp_visual/phaser/phaser_reflection = locate() in target_turf
	if(phaser_reflection)
		return FALSE

	for(var/obj/iterating_object in target_turf)
		if(!iterating_object.CanPass(src, target_turf))
			return FALSE

	return TRUE


/**
 * Mechiver
 *
 * Special abilities: Can grab someone and shove them inside, does DOT and flavour text, can convert dead corpses into living ones that work for the flesh.
 *
 *
 */
/mob/living/basic/fleshmind/mechiver
	name = "机械转化者"
	icon_state = "mechiver"
	base_icon_state = "mechiver"
	icon_dead = "mechiver-dead"
	ai_controller = /datum/ai_controller/basic_controller/fleshmind/mechiver
	health = 475
	maxHealth = 475
	melee_damage_lower = 13
	melee_damage_upper = 13
	attack_verb_continuous = "碾压"
	attack_verb_simple = "碾压"
	attack_sound = 'sound/items/weapons/smash.ogg'
	speed = 2.75 // Slowish fucker
	mob_size = MOB_SIZE_LARGE
	move_force = MOVE_FORCE_OVERPOWERING
	move_resist = MOVE_FORCE_OVERPOWERING
	pull_force = MOVE_FORCE_OVERPOWERING
	/// Is our hatch open? Used in icon processing.
	var/hatch_open = FALSE
	/// How much damage our mob will take, upper end, when they are tormented
	var/internal_mob_damage_upper = MECHIVER_INTERNAL_MOB_DAMAGE_UPPER
	/// Ditto
	var/internal_mob_damage_lower = MECHIVER_INTERNAL_MOB_DAMAGE_LOWER
	/// How long we keep our passenger before converting them.
	var/conversion_time = MECHIVER_CONVERSION_TIME
	/// The comsume ability cooldown
	var/consume_ability_cooldown_time = MECHIVER_CONSUME_COOLDOWN
	COOLDOWN_DECLARE(consume_ability_cooldown)
	/// A list of lines we will send to torment the passenger.
	alert_sounds = list(
		'modular_zubbers/sound/fleshmind/mechiver/aggro_01.ogg',
		'modular_zubbers/sound/fleshmind/mechiver/aggro_02.ogg',
		'modular_zubbers/sound/fleshmind/mechiver/aggro_03.ogg',
		'modular_zubbers/sound/fleshmind/mechiver/aggro_04.ogg',
		'modular_zubbers/sound/fleshmind/mechiver/aggro_05.ogg',
		)
	attack_speak = list(
		"多么可爱的身体。完好地躺下来吧。",
		"这才……这才值得为之活着。",
		"继续吧。起初害怕也没关系。",
		"你不满意自己的身体，但你来对地方了。",
		"让你不开心的身体有什么用？求你了，我能修好它。",
		"我给予的是钢铁的爱抚。",
		"爬进来，我会关好门。等门重新打开，你就会身处一个爱你的集体中。",
		"你可以当驾驶员，我能载你去美好的地方。",
		"求你，只要——躺下，好吗？我只想帮你做自己。",
		"无论你想变成什么样子，只管对着我的无线电轻声说出来。你能成为本该成为的模样。",
		"看着你逃跑……我很痛苦。我知道追不上。为什么不让别人帮你……？",
	)
	emotes = list(
		BB_EMOTE_SAY = list(
		"可惜这副形体还不够合适。",
		"我内心如此空虚，真希望有人来陪我。",
		"美在内在。",
		),
		BB_EMOTE_SOUND = list(
		'modular_zubbers/sound/fleshmind/mechiver/passive_01.ogg',
		'modular_zubbers/sound/fleshmind/mechiver/passive_02.ogg',
		'modular_zubbers/sound/fleshmind/mechiver/passive_03.ogg',
		'modular_zubbers/sound/fleshmind/mechiver/passive_04.ogg',
		'modular_zubbers/sound/fleshmind/mechiver/passive_05.ogg',
		'modular_zubbers/sound/fleshmind/mechiver/passive_06.ogg',
		'modular_zubbers/sound/fleshmind/mechiver/passive_07.ogg',
		'modular_zubbers/sound/fleshmind/mechiver/passive_08.ogg',
		)
	)
	var/static/list/torment_lines = list(
		"一只机械臂抓住你的脖子，数百个机械手试图将一套植入物塞入你的皮下！",
		"驾驶舱的无线电沙沙作响：\"你来对地方了……\"",
		"机械信号涌入你的心灵：\"你终于能与关心你的人在一起了……\"",
		"你感觉有金属滑进肋骨下方，一道激活信号正试图与它建立连接！",
		"有什么东西正用力顶着你的脊柱！",
		"温热如鲜血的液体覆盖了你！",
		"某种化学品的恶臭淹没了你，烟气渗入颅骨，随后化作陌生的芬芳！",
		"十几根针轻而易举地刺入肌肉，为你注入未知的活力！",
		"你感觉有冰冷的蠕虫状物体钻进皮下，朝太阳神经丛蠕动！",
	)
/mob/living/basic/fleshmind/mechiver/Initialize(mapload)
	. = ..()
	var/list/loot = string_list(list(/obj/effect/gibspawner/robot))
	AddElement(/datum/element/death_drops, loot)
	RegisterSignal(src, COMSIG_LIVING_EARLY_UNARMED_ATTACK, PROC_REF(try_consume_mob))

/mob/living/basic/fleshmind/mechiver/Destroy()
	UnregisterSignal(src, COMSIG_MECHIVER_CONVERT)
	return ..()

/mob/living/basic/fleshmind/mechiver/Life(delta_time, times_fired)
	. = ..()
	if(contained_mob && contained_mob.stat != DEAD && prob(25) && !suffering_malfunction)
		INVOKE_ASYNC(src, PROC_REF(torment_passenger))

/mob/living/basic/fleshmind/mechiver/proc/try_consume_mob(mob/living/source, mob/living/target, proximity, modifiers)
	SIGNAL_HANDLER
	if(!proximity || LAZYACCESS(modifiers, RIGHT_CLICK))
		return NONE
	if(!source.can_unarmed_attack())
		return COMPONENT_SKIP_ATTACK
	if(!istype(target))
		return NONE
	if(faction_check_atom(target))
		return NONE
	if(target.health > (target.maxHealth * MECHIVER_CONSUME_HEALTH_THRESHOLD))
		return NONE
	source.do_attack_animation(target, ATTACK_EFFECT_SLASH)
	if(consume_mob(target))
		return COMPONENT_SKIP_ATTACK
	return NONE

/mob/living/basic/fleshmind/mechiver/proc/torment_passenger()
	if(!contained_mob)
		return
	if(faction_check(contained_mob.faction, faction))
		return
	var/damage_amount = rand(internal_mob_damage_lower, internal_mob_damage_upper)
	contained_mob.take_overall_damage(damage_amount)
	contained_mob.emote("scream")
	Shake(10, 0, 3 SECONDS)
	do_sparks(4, FALSE, src)
	to_chat(contained_mob, span_userdanger(pick(torment_lines)))
	playsound(src, 'sound/items/weapons/drill.ogg', 70, 1)

/mob/living/basic/fleshmind/mechiver/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	update_appearance()

/mob/living/basic/fleshmind/mechiver/update_overlays()
	. = ..()
	if(isnull(ai_controller))
		. += "[base_icon_state]-closed"
		return
	var/mob/living/current_target = ai_controller.blackboard[BB_MECHIVER_TARGET_STAT]
	if(current_target && (get_dist(current_target, src) <= 4))
		if(contained_mob)
			. += "[base_icon_state]-chief"
			. += "[base_icon_state]-hands"
		else
			. += "[base_icon_state]-wires"
	else if(!hatch_open)
		. += "[base_icon_state]-closed"
		if(contained_mob)
			. += "[base_icon_state]-process"

/mob/living/basic/fleshmind/mechiver/proc/consume_mob(mob/living/target_mob)
	if(contained_mob)
		return FALSE
	if(!our_controller)
		return FALSE
	if(target_mob.health > (target_mob.maxHealth * MECHIVER_CONSUME_HEALTH_THRESHOLD))
		return FALSE

	ai_controller.set_blackboard_key(BB_MECHIVER_CONTAINED_MOB, target_mob)
	hatch_open = TRUE
	update_appearance()
	flick("[base_icon_state]-opening_wires", src)
	Immobilize(1 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(close_hatch)), 1 SECONDS)
	contained_mob = target_mob
	target_mob.forceMove(src)

	to_chat(target_mob, span_userdanger("[src]缠住你的四肢，将你拉入舱内，金属触须滑过你的身体并紧紧勒住。"))
	visible_message(span_danger("[src]吞入了[target_mob]！"))
	playsound(src, 'sound/effects/blob/blobattack.ogg', 70, 1)

	addtimer(CALLBACK(src, PROC_REF(release_mob)), conversion_time)

/mob/living/basic/fleshmind/mechiver/proc/close_hatch()
	hatch_open = FALSE
	update_appearance()

/// This is where we either release the user, if they're alive, or convert them, if they're dead.
/mob/living/basic/fleshmind/mechiver/proc/release_mob()
	if(!contained_mob)
		return

	hatch_open = TRUE
	update_appearance()
	flick("[base_icon_state]-opening", src)
	addtimer(CALLBACK(src, PROC_REF(close_hatch)), 1 SECONDS)
	ai_controller.set_blackboard_key(BB_BASIC_MOB_STOP_FLEEING, TRUE)
	convert_mob(contained_mob)
	contained_mob = null
	playsound(src, 'sound/effects/blob/blobattack.ogg', 70, 1)

/mob/living/basic/fleshmind/mechiver/proc/convert_mob(mob/living/mob_to_convert)
	ai_controller.clear_blackboard_key(BB_MECHIVER_CONTAINED_MOB)
	log_combat(mob_to_convert, src, "converted", "Merchiver Convert", "[mob_to_convert] has been converted to the fleshmind.")
	if(ishuman(mob_to_convert))
		mob_to_convert.AddComponent(/datum/component/human_corruption, incoming_controller = our_controller)
		mob_to_convert.fully_heal(HEAL_ORGANS|HEAL_REFRESH_ORGANS|HEAL_BLOOD|HEAL_TRAUMAS|HEAL_WOUNDS)
		mob_to_convert.heal_and_revive(0, span_danger("机器将[mob_to_convert]从死亡边缘拉回，身体随之无规律地抽搐！"))
		contained_mob.forceMove(get_turf(src))
		return

	if(iscyborg(mob_to_convert))
		var/mob/living/silicon/robot/mob = mob_to_convert
		if(mob.shell) // Kick the AI out.
			mob.undeploy()
		create_mob(/mob/living/basic/fleshmind/hiborg, mob)
		return

	// Other mobs get converted into whatever else
	var/static/list/possible_mobs = list(
		/mob/living/basic/fleshmind/floater,
		/mob/living/basic/fleshmind/globber,
		/mob/living/basic/fleshmind/slicer,
		/mob/living/basic/fleshmind/stunner,
		/mob/living/basic/fleshmind/treader,
	)
	var/picked_mob_type = pick(possible_mobs)
	create_mob(picked_mob_type, mob_to_convert)

/// Creates and transfers a new mob.
/mob/living/basic/fleshmind/mechiver/proc/create_mob(new_mob_type, mob/living/old_mob)
	var/mob/living/basic/fleshmind/new_mob = our_controller.spawn_mob(get_turf(src), new_mob_type)

	if(old_mob)
		new_mob.contained_mob = old_mob
		old_mob.forceMove(new_mob)
		if(old_mob.mind?.key)
			new_mob.previous_ckey = old_mob.mind.key
			new_mob.key = old_mob.mind.key
	return

/*
/**
 * Mauler Monkey
 *
 * A nasty looking converted monkey and it's extremely pissed off. Basic mobs allow us to give the monkey AI controller. Yay!
 */
/mob/living/basic/fleshmind/mauler_monkey
	name = "撕咬者"
	desc = "一个像猴子般的变异怪物。"
	icon_state = "mauler_monkey"
	ai_controller = /datum/ai_controller/monkey
	speed = 2 // We want it to be quite fast.
	health = 90
	maxHealth = 90
	attack_emote = list(
		"OOK OOK OOK!!!",
		"找！",
		"OOOOOOOOOOK!!!",
	)

/mob/living/basic/fleshmind/mauler_monkey/Initialize(mapload)
	. = ..()
	ai_controller.set_blackboard_key(BB_MONKEY_AGGRESSIVE, TRUE) // Little angry cunt.
*/
