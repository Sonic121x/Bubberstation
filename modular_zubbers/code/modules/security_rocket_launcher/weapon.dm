/obj/item/gun/ballistic/rocketlauncher/security

	//Text
	name = "\improper “VARS”可变主动雷达导弹系统"
	desc = "一款（相对）廉价的可重复使用导弹发射器，由纳米传讯武器研发实验室的怪才们为对付那些烦人的太空匪徒而捣鼓出来。 \
	使用获得专利的特殊 69mm“发射后甭管”导弹，能自动追踪雷达信号强烈的目标，包括墙壁、地板，而最重要的是——人。"
	cartridge_wording = "导弹"

	//Icons
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	icon_state = "rocketlauncher"
	inhand_icon_state = "rocketlauncher"
	worn_icon_state = "rocketlauncher"

	//Sound
	fire_sound = 'modular_zubbers/sound/weapons/gun/sec_missile/shoot.ogg'
	load_sound = 'modular_zubbers/sound/weapons/gun/sec_missile/insert.ogg'
	drop_sound = 'sound/items/handling/gun/ballistics/shotgun/shotgun_drop1.ogg'
	pickup_sound = 'sound/items/handling/gun/ballistics/shotgun/shotgun_pickup1.ogg'

	//Internal code
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/security_rocketlauncher
	pin = /obj/item/firing_pin

	//Stats
	backblast = FALSE
	gun_flags = TURRET_INCOMPATIBLE
	fire_delay = 2 SECONDS
	weapon_weight = WEAPON_HEAVY
	slot_flags = null

	//The funny
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "对其使用加密序列器应该会使雷达系统过载。"

	var/self_targeting = FALSE //emag interaction

	var/warning_label //Generated on examine for the first time.

/obj/item/gun/ballistic/rocketlauncher/security/proc/generate_warning_label()

	. = ""

	var/list/possible_good_instructions = list(
		"发射前检查护盖是否受损",
		"发射前检查尾焰区域",
		"前端朝向敌人",
		"仅限抵肩发射",
		"禁止在室内使用",
		"请勿吸入管内物质",
		"请勿将异物塞入管内",
		"请佩戴护目装备",
		"请佩戴听力保护装备",
		"发射时保持水平",
		"发射时保持静止",
		"请勿擅自改动电子部件"
	)

	var/list/possible_bad_instructions = list(
		"请勿食用",
		"请勿将外来物质塞入管内",
		"请远离电气感染源", //I saw Ryan Gosling at a grocery store in Los Angeles yesterday.
		"使用前务必阅读警告标签",
		"仅供外用",
		"易燃",
		"避免接触眼睛",
		"请勿储存于 313.15 开尔文以上",
		"小丑使用本产品时须有专人看护",
		"请勿交给小丑",
		"远离小丑",
		"请勿浸入水中",
		"请勿吞食。",
		"吞食有害",
		"若不慎吞食，请联系医生",
		"请勿用于破损皮肤",
		"若出现皮疹或刺激，请停止使用",
		"仅按说明使用",
		"操作重型机械时请勿使用",
		"可能引起嗜睡",
		"切勿用点燃的火柴或明火检查是否装填",
		"睡眠时请勿使用",
		"本产品可能含有：蛋类、坚果、大豆和树坚果",
		"请勿将肢体伸入管内",
		"不可用于导航",
		"不适合人类食用",
		"请勿用于个人卫生",
		"窒息危险：可能含有小零件",
		"请勿尝试",
		"可能刺激眼睛",
		"装填后存在火灾危险",
		"阅读后保修失效",
		"保修已失效",
		"可能刺激船员",
		"可能含有爆炸物",
		"勿伤害他人",
		"请勿说脏话",
		"请勿",
		"这不是望远镜",
		"不单独出售",
		"请勿转载"
	)

	if(!CONFIG_GET(flag/disable_erp_preferences))
		possible_bad_instructions += list(
			"性行为期间请勿使用",
			"怀孕或哺乳期间请勿使用",
			"请勿带入宿舍",
			"远离尺寸女王",
		)

	var/total_good_length_mod = FLOOR(length(possible_good_instructions) * 0.5, 1)

	//Generate the first half. Always useful.
	for(var/i in 1 to total_good_length_mod)
		. += "[pick_n_take(possible_good_instructions)]<br>"

	//As for the second half... well...
	for(var/i in 1 to total_good_length_mod)
		if(!prob(80)) // lore optimization
			. += "[pick_n_take(possible_bad_instructions)]<br>"
		else
			. += "[pick_n_take(possible_good_instructions)]<br>"

/obj/item/gun/ballistic/rocketlauncher/security/examine(mob/user)
	. = ..()

	if(isobserver(user))
		return

	//Shamelessly copied from /obj/structure/sign/eyechart
	if(!user.can_read(src, READING_CHECK_LITERACY, silent = TRUE) || !user.has_language(/datum/language/common, UNDERSTOOD_LANGUAGE))
		if(!user.is_blind())
			. += "<hr>你盯着警告标签，试图弄明白它的意思……"
			. += span_warning("……但你其实根本看不懂上面写了什么。")
		return

	if(!user.can_read(src, READING_CHECK_LIGHT, silent = TRUE))
		. += "<hr>你眯起眼睛看着警告标签……"
		. += span_warning("……但这里太暗了，什么也看不清。")
		return

	var/obj/item/organ/eyes/eye = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(isnull(eye))
		return

	if(eye.damage >= eye.low_threshold || user.has_status_effect(/datum/status_effect/eye_blur))
		. += "<hr>你眯起眼睛看着警告标签……"
		. += span_warning("……但这么小的字实在太难辨认了……")
		return

	if(!warning_label)
		warning_label = generate_warning_label()

	. += span_warning("侧面有一张警告标签，上面写着：")

	. += span_danger(warning_label)

/obj/item/gun/ballistic/rocketlauncher/security/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(self_targeting)
		return FALSE
	self_targeting = TRUE
	balloon_alert(user, "瞄准系统已遭篡改")
	do_sparks(2, FALSE, src)
	return TRUE

//Internal Magazine
/obj/item/ammo_box/magazine/internal/security_rocketlauncher
	name = "导弹发射器内置弹匣"
	ammo_type = /obj/item/ammo_casing/security_missile
	caliber = CALIBER_69MM
	max_ammo = 1



//Debug nonsense.
/obj/item/gun/ballistic/rocketlauncher/security/debug
	fire_delay = 0
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/security_rocketlauncher/debug
	item_flags = NEEDS_PERMIT|ABSTRACT //ABSTRACT solely so it doesnt' spawn in random christmas gifts
	burst_size = 5
	burst_delay = 1

/obj/item/ammo_box/magazine/internal/security_rocketlauncher/debug
	max_ammo = 69
