// AI defines

#define DEFAULT_AI_LAWID "default"
#define LAW_ZEROTH "zeroth"
#define LAW_INHERENT "inherent"
#define LAW_SUPPLIED "supplied"
#define LAW_HACKED "hacked"

//AI notification defines
///Alert when a new Cyborg is created.
#define AI_NOTIFICATION_NEW_BORG 1
///Alert when a Cyborg selects a model.
#define AI_NOTIFICATION_NEW_MODEL 2
///Alert when a Cyborg changes their name.
#define AI_NOTIFICATION_CYBORG_RENAMED 3
///Alert when an AI disconnects themselves from their shell.
#define AI_NOTIFICATION_AI_SHELL 4
///Alert when a Cyborg gets disconnected from their AI.
#define AI_NOTIFICATION_CYBORG_DISCONNECTED 5

//transfer_ai() defines. Main proc in ai_core.dm
///Downloading AI to InteliCard
#define AI_TRANS_TO_CARD 1
///Uploading AI from InteliCard
#define AI_TRANS_FROM_CARD 2
///Malfunctioning AI hijacking mecha
#define AI_MECH_HACK 3

// Cyborg defines

/// Special value to reset cyborg's lamp_cooldown
#define BORG_LAMP_CD_RESET -1
/// How many watts per lamp power is consumed while the lamp is on.
#define BORG_LAMP_POWER_CONSUMPTION (5 WATTS)
/// The minimum power consumption of a cyborg.
#define BORG_MINIMUM_POWER_CONSUMPTION (1 WATTS)

//Module slot define
///The third module slots is disabed.
#define BORG_MODULE_THREE_DISABLED (1<<0)
///The second module slots is disabed.
#define BORG_MODULE_TWO_DISABLED (1<<1)
///All modules slots are disabled.
#define BORG_MODULE_ALL_DISABLED (1<<2)

//Cyborg module selection
///First Borg module slot.
#define BORG_CHOOSE_MODULE_ONE 1
///Second Borg module slot.
#define BORG_CHOOSE_MODULE_TWO 2
///Third Borg module slot.
#define BORG_CHOOSE_MODULE_THREE 3

// SKYRAT EDIT START - TODO - Move this upstream later
/// To store all the different cyborg models, instead of creating that for each cyborg.
GLOBAL_LIST_EMPTY(cyborg_model_list)
/// To store all of the different base cyborg model icons, instead of creating them every time the pick_module() proc is called.
GLOBAL_LIST_EMPTY(cyborg_base_models_icon_list)
/// To store all of the different cyborg model icons, instead of creating them every time the be_transformed_to() proc is called.
GLOBAL_LIST_EMPTY(cyborg_all_models_icon_list)
// SKYRAT EDIT END

#define SKIN_ICON "skin_icon"
#define SKIN_ICON_STATE "skin_icon_state"
#define SKIN_PIXEL_X "skin_pixel_x"
#define SKIN_PIXEL_Y "skin_pixel_y"
#define SKIN_LIGHT_KEY "skin_light_key"
#define SKIN_HAT_OFFSET "skin_hat_offset"
#define SKIN_TRAITS "skin_traits"

/** Simple Animal BOT defines */

//Assembly defines
#define ASSEMBLY_FIRST_STEP 1
#define ASSEMBLY_SECOND_STEP 2
#define ASSEMBLY_THIRD_STEP 3
#define ASSEMBLY_FOURTH_STEP 4
#define ASSEMBLY_FIFTH_STEP 5
#define ASSEMBLY_SIXTH_STEP 6
#define ASSEMBLY_SEVENTH_STEP 7
#define ASSEMBLY_EIGHTH_STEP 8
#define ASSEMBLY_NINTH_STEP 9

//Bot defines, placed here so they can be read by other things!
/// Delay between movemements
#define BOT_STEP_DELAY 4
/// Maximum times a bot will retry to step from its position
#define BOT_STEP_MAX_RETRIES 5
/// Default view range for finding targets.
#define DEFAULT_SCAN_RANGE 7
//Amount of time that must pass after a Commissioned bot gets saluted to get another.

//Bot mode defines displaying how Bots act
///The Bot is currently active, and will do whatever it is programmed to do.
#define BOT_MODE_ON (1<<0)
///The Bot is currently set to automatically patrol the station.
#define BOT_MODE_AUTOPATROL (1<<1)
///The Bot is currently allowed to be remote controlled by Silicon.
#define BOT_MODE_REMOTE_ENABLED (1<<2)
///The Bot is allowed to have a ghost placed in control of it.
#define BOT_MODE_CAN_BE_SAPIENT (1<<3)
///The Bot is allowed to be possessed if it is present on mapload.
#define BOT_MODE_ROUNDSTART_POSSESSION (1<<4)

//Bot cover defines indicating the Bot's status
///The Bot's cover is open and can be modified/emagged by anyone.
#define BOT_COVER_MAINTS_OPEN (1<<0)
///The Bot's cover is locked, and cannot be opened without unlocking it.
#define BOT_COVER_LOCKED (1<<1)
///The Bot is emagged.
#define BOT_COVER_EMAGGED (1<<2)
///The Bot has been hacked by a Silicon, emagging them, but revertable.
#define BOT_COVER_HACKED (1<<3)

///bitfield, used by basic bots, for our access flags
DEFINE_BITFIELD(bot_access_flags, list(
	"MAINTS_OPEN" = BOT_COVER_MAINTS_OPEN,
	"COVER_OPEN" = BOT_COVER_LOCKED,
	"COVER_EMAGGED" = BOT_COVER_EMAGGED,
	"COVER_HACKED" = BOT_COVER_HACKED,
))

///bitfield, used by simple bots, for our access flags
DEFINE_BITFIELD(bot_cover_flags, list(
	"MAINTS_OPEN" = BOT_COVER_MAINTS_OPEN,
	"COVER_OPEN" = BOT_COVER_LOCKED,
	"COVER_EMAGGED" = BOT_COVER_EMAGGED,
	"COVER_HACKED" = BOT_COVER_HACKED,
))

//Bot types
/// Secutritrons (Beepsky)
#define SEC_BOT "安保机器人"
/// ED-209s
#define ADVANCED_SEC_BOT "ED-209"
/// MULEbots
#define MULE_BOT "骡子货运机器人"
/// Cleanbots
#define CLEAN_BOT "清洁机器人"
/// Medibots
#define MED_BOT "医疗机器人"
/// Honkbots & ED-Honks
#define HONK_BOT "小丑机器人"
/// Firebots
#define FIRE_BOT "消防机器人"
/// Hygienebots
#define HYGIENE_BOT "卫生机器人"
/// Vibe bots
#define VIBE_BOT "氛围机器人"
/// Repairbots
#define REPAIR_BOT "维修机器人"

// General Bot modes //
/// Idle
#define BOT_IDLE "待机"
/// Found target, hunting
#define BOT_HUNT "追捕中"
/// Start patrol
#define BOT_START_PATROL "开始巡逻"
/// Patrolling
#define BOT_PATROL "巡逻中"
/// Summoned to a location
#define BOT_SUMMON "已被 PDA 召唤"
/// Responding to a call from the AI
#define BOT_RESPONDING "正在前往 AI 指定地点"
/// Currently moving
#define BOT_MOVING "移动中"

// Unique modes //
/// Secbot - At target, preparing to arrest
#define BOT_PREP_ARREST "准备逮捕"
/// Secbot - Arresting target
#define BOT_ARREST "逮捕中"
/// Cleanbot - Cleaning
#define BOT_CLEANING "清洁中"
/// Hygienebot - Cleaning unhygienic humans
#define BOT_SHOWERSTANCE "追逐污秽"
/// Medibots - Healing people
#define BOT_HEALING "治疗中"
/// MULEbot - Moving to deliver
#define BOT_DELIVER "运送中"
/// MULEbot - Returning to home
#define BOT_GO_HOME "返程中"
/// MULEbot - Blocked
#define BOT_BLOCKED "受阻"
/// MULEbot - Computing navigation
#define BOT_NAV "无法到达"
/// MULEbot - Waiting for nav computation
#define BOT_WAIT_FOR_NAV "计算中"
/// MULEbot - No destination beacon found (or no route)
#define BOT_NO_ROUTE "返回起点"

//Secbot and ED209 judgement criteria bitflag values
#define JUDGE_EMAGGED (1<<0)
#define JUDGE_IDCHECK (1<<1)
#define JUDGE_WEAPONCHECK (1<<2)
#define JUDGE_RECORDCHECK (1<<3)
///lowered threat level
#define JUDGE_CHILLOUT (1<<4)

/// Above this level of assessed threat, Beepsky will attack you
#define THREAT_ASSESS_DANGEROUS 4
/// Above this level of assessed threat, you are extremely threatening
#define THREAT_ASSESS_MAXIMUM 10

//SecBOT defines on arresting
///Whether arrests should be broadcasted over the Security radio
#define SECBOT_DECLARE_ARRESTS (1<<0)
///Will arrest people who lack an ID card
#define SECBOT_CHECK_IDS (1<<1)
///Will check for weapons, taking Weapons access into account
#define SECBOT_CHECK_WEAPONS (1<<2)
///Will check Security record on whether to arrest
#define SECBOT_CHECK_RECORDS (1<<3)
///Whether we will stun & cuff or endlessly stun
#define SECBOT_HANDCUFF_TARGET (1<<4)
///if it's currently affected by a saboteur bolt (lowered perp threat level)
#define SECBOT_SABOTEUR_AFFECTED (1<<5)

DEFINE_BITFIELD(security_mode_flags, list(
	"SECBOT_DECLARE_ARRESTS" = SECBOT_DECLARE_ARRESTS,
	"SECBOT_CHECK_IDS" = SECBOT_CHECK_IDS,
	"SECBOT_CHECK_WEAPONS" = SECBOT_CHECK_WEAPONS,
	"SECBOT_CHECK_RECORDS" = SECBOT_CHECK_RECORDS,
	"SECBOT_HANDCUFF_TARGET" = SECBOT_HANDCUFF_TARGET,
	"SECBOT_SABOTEUR_AFFECTED" = SECBOT_SABOTEUR_AFFECTED,
))

///can honkbots slip people?
#define HONKBOT_MODE_SLIP (1<<6)

//repairbots
///can we fix breaches
#define REPAIRBOT_FIX_BREACHES (1<<0)
///can we fix grilles
#define REPAIRBOT_REPLACE_WINDOWS (1<<1)
///can we replace tiles
#define REPAIRBOT_REPLACE_TILES (1<<2)
///can we fix girders
#define REPAIRBOT_FIX_GIRDERS (1<<3)
///can we build girders
#define REPAIRBOT_BUILD_GIRDERS (1<<4)

DEFINE_BITFIELD(repairbot_flags, list(
	"FIX_BREACHES" = REPAIRBOT_FIX_BREACHES,
	"REPLACE_WINDOWS" = REPAIRBOT_REPLACE_WINDOWS,
	"REPLACE_TILES" = REPAIRBOT_REPLACE_TILES,
	"FIX_GIRDERS" = REPAIRBOT_FIX_GIRDERS,
	"BUILD_GIRDERS" = REPAIRBOT_BUILD_GIRDERS,
))


//MedBOT defines
///Whether to declare if someone (we are healing) is in critical condition
#define MEDBOT_DECLARE_CRIT (1<<0)
///If the bot will stand still, only healing those next to it.
#define MEDBOT_STATIONARY_MODE (1<<1)
///Whether the bot will randomly speak from time to time. This will not actually prevent all speech.
#define MEDBOT_SPEAK_MODE (1<<2)
/// is the bot currently tipped over?
#define MEDBOT_TIPPED_MODE (1<<3)

///can we heal all damage?
#define HEAL_ALL_DAMAGE "all_damage"

DEFINE_BITFIELD(medical_mode_flags, list(
	"MEDBOT_DECLARE_CRIT" = MEDBOT_DECLARE_CRIT,
	"MEDBOT_STATIONARY_MODE" = MEDBOT_STATIONARY_MODE,
	"MEDBOT_SPEAK_MODE" = MEDBOT_SPEAK_MODE,
	"MEDBOT_TIPPED_MODE" = MEDBOT_TIPPED_MODE,
))

///Whether we are stationary or not
#define FIREBOT_STATIONARY_MODE (1<<0)
///If we will extinguish people
#define FIREBOT_EXTINGUISH_PEOPLE (1<<1)
///if we will extinguish turfs on flames
#define FIREBOT_EXTINGUISH_FLAMES (1<<2)

DEFINE_BITFIELD(firebot_mode_flags, list(
	"FIREBOT_STATIONARY_MODE" = FIREBOT_STATIONARY_MODE,
	"FIREBOT_EXTINGUISH_PEOPLE" = FIREBOT_EXTINGUISH_PEOPLE,
	"FIREBOT_EXTINGUISH_FLAMES" = FIREBOT_EXTINGUISH_FLAMES,
))

///auto return to home after delivery
#define MULEBOT_RETURN_MODE (1<<0)
///autopickups at beacons
#define MULEBOT_AUTO_PICKUP_MODE (1<<1)
///announce every delivery we make
#define MULEBOT_REPORT_DELIVERY_MODE (1<<2)

DEFINE_BITFIELD(mulebot_delivery_flags, list(
	"MULEBOT_RETURN_MODE" = MULEBOT_RETURN_MODE,
	"MULEBOT_AUTO_PICKUP_MODE" = MULEBOT_AUTO_PICKUP_MODE,
	"MULEBOT_REPORT_DELIVERY_MODE" = MULEBOT_REPORT_DELIVERY_MODE,
))

//cleanBOT defines on what to clean
#define CLEANBOT_CLEAN_BLOOD (1<<0)
#define CLEANBOT_CLEAN_TRASH (1<<1)
#define CLEANBOT_CLEAN_PESTS (1<<2)
#define CLEANBOT_CLEAN_DRAWINGS (1<<3)

DEFINE_BITFIELD(janitor_mode_flags, list(
	"CLEANBOT_CLEAN_BLOOD" = CLEANBOT_CLEAN_BLOOD,
	"CLEANBOT_CLEAN_TRASH" = CLEANBOT_CLEAN_TRASH,
	"CLEANBOT_CLEAN_PESTS" = CLEANBOT_CLEAN_PESTS,
	"CLEANBOT_CLEAN_DRAWINGS" = CLEANBOT_CLEAN_DRAWINGS,
))

//bot navigation beacon defines
#define NAVBEACON_PATROL_MODE "patrol"
#define NAVBEACON_PATROL_NEXT "next_patrol"
#define NAVBEACON_DELIVERY_MODE "delivery"
#define NAVBEACON_DELIVERY_DIRECTION "dir"

// Defines for lines that bots can speak which also have corresponding voice lines

#define ED209_VOICED_DOWN_WEAPONS "请放下武器。你有20秒的时间服从命令。"

#define HONKBOT_VOICED_HONK_HAPPY "哔哔！"
#define HONKBOT_VOICED_HONK_SAD "哔哔……"

#define BEEPSKY_VOICED_CRIMINAL_DETECTED "发现罪犯！"
#define BEEPSKY_VOICED_FREEZE "站住，人渣！"
#define BEEPSKY_VOICED_JUSTICE "准备接受正义的制裁！"
#define BEEPSKY_VOICED_YOUR_MOVE "该你了，混蛋。"
#define BEEPSKY_VOICED_I_AM_THE_LAW "我就是法律！"
#define BEEPSKY_VOICED_SECURE_DAY "祝你平安度过今天。"

#define FIREBOT_VOICED_FIRE_DETECTED "发现火情！"
#define FIREBOT_VOICED_STOP_DROP "停下、卧倒、打滚！"
#define FIREBOT_VOICED_EXTINGUISHING "正在灭火！"
#define FIREBOT_VOICED_NO_FIRES "未发现火情。"
#define FIREBOT_VOICED_ONLY_YOU "预防空间站火灾，从你做起。"
#define FIREBOT_VOICED_TEMPERATURE_NOMINAL "温度正常。"
#define FIREBOT_VOICED_KEEP_COOL "保持冷静。"
#define FIREBOT_VOICED_CANDLE_TIP "把蜡烛摆在窗帘旁，就能获得温馨的夜间照明！"
#define FIREBOT_VOICED_ELECTRIC_FIRE "在插座旁放好满桶的水，以防电气火灾！"
#define FIREBOT_VOICED_FUEL_TIP "往火上浇燃料，能让它更快烧完！"

#define HYGIENEBOT_VOICED_UNHYGIENIC "发现不卫生的客户。请站着别动，让我给你洗干净。"
#define HYGIENEBOT_VOICED_ENJOY_DAY "祝你度过干净整洁的一天！"
#define HYGIENEBOT_VOICED_THREAT_AIRLOCK "要么别跑，要么老子把你拖出气闸。"
#define HYGIENEBOT_VOICED_FOUL_SMELL "给我回来，你这个臭气熏天的混蛋。"
#define HYGIENEBOT_VOICED_TROGLODYTE "我他妈只是想把你洗干净，你这个原始人。"
#define HYGIENEBOT_VOICED_GREEN_CLOUD "你他妈再不回来，我就让一团绿云围着你。"
#define HYGIENEBOT_VOICED_ARSEHOLE "你这个混蛋，就他妈让我给你洗干净吧！"
#define HYGIENEBOT_VOICED_THREAT_ARTERIES "别再跑了，不然我割断你的动脉！"
#define HYGIENEBOT_VOICED_STOP_RUNNING "不。许。跑。"
#define HYGIENEBOT_VOICED_FUCKING_FINALLY "他妈的，可算停下了。"
#define HYGIENEBOT_VOICED_THANK_GOD "谢天谢地，你终于停下了。"
#define HYGIENEBOT_VOICED_DEGENERATE "你这人渣，他妈的早该停下了。"

#define MEDIBOT_VOICED_HOLD_ON "嘿！坚持住，我来了。"
#define MEDIBOT_VOICED_WANT_TO_HELP "等等！我是来帮忙的！"
#define MEDIBOT_VOICED_YOU_ARE_INJURED "你看起来受伤了！"
#define MEDIBOT_VOICED_ALL_PATCHED_UP "全都治好了！"
#define MEDIBOT_VOICED_APPLE_A_DAY "一天一苹果，让我远离你。"
#define MEDIBOT_VOICED_FEEL_BETTER "祝你早日康复！"
#define MEDIBOT_VOICED_STAY_WITH_ME	"不！撑住！"
#define MEDIBOT_VOICED_LIVE	"活下去，该死的！活下去！"
#define MEDIBOT_VOICED_NEVER_LOST "我……我从来没失去过病人。我是说，今天还没有。"
#define MEDIBOT_VOICED_DELICIOUS "真美味！"
#define MEDIBOT_VOICED_PLASTIC_SURGEON "我就知道，我当初就该去做整形外科医生。"
#define MEDIBOT_VOICED_MASK_ON "雷达，戴上口罩！"
#define MEDIBOT_VOICED_ALWAYS_A_CATCH "事情总有蹊跷，而我总能手到擒来。"
#define MEDIBOT_VOICED_LIKE_FLIES "这算哪门子医疗部？人一个接一个地死。"
#define MEDIBOT_VOICED_SUFFER "我们为什么还在这里？只是为了受苦吗？"
#define MEDIBOT_VOICED_FUCK_YOU	"去你妈的。"
#define MEDIBOT_VOICED_NOT_A_GAME "关掉你的电脑。这不是游戏。"
#define MEDIBOT_VOICED_IM_DIFFERENT	"我不一样！"
#define MEDIBOT_VOICED_FOURTH_WALL "立即关闭 Dreamseeker.exe。否则后果自负。"
#define MEDIBOT_VOICED_SHINDEMASHOU	"一起去死吧。"
#define MEDIBOT_VOICED_WAIT	"嘿，等等……"
#define MEDIBOT_VOICED_DONT	"求你别这样……"
#define MEDIBOT_VOICED_TRUSTED_YOU "我曾经信任你……"
#define MEDIBOT_VOICED_NO_SAD "不——……"
#define MEDIBOT_VOICED_OH_FUCK "哦，操——"
#define MEDIBOT_VOICED_FORGIVE "我原谅你。"
#define MEDIBOT_VOICED_THANKS "谢谢你！"
#define MEDIBOT_VOICED_GOOD_PERSON "你是个好人。"
#define MEDIBOT_VOICED_BEHAVIOUR_REPORTED "你的行为已被举报，祝你今天愉快。"
#define MEDIBOT_VOICED_ASSISTANCE "我需要协助。"
#define MEDIBOT_VOICED_PUT_BACK	"请把我放回去。"
#define MEDIBOT_VOICED_IM_SCARED "求你了，我好害怕！"
#define MEDIBOT_VOICED_NEED_HELP "我不喜欢这样，我需要帮助！"
#define MEDIBOT_VOICED_THIS_HURTS "好痛，我真的感受得到疼痛！"
#define MEDIBOT_VOICED_THE_END "这就是终结吗？"
#define MEDIBOT_VOICED_NOOO	"不——！"
#define MEDIBOT_VOICED_CHICKEN "看看我？！我是一只鸡。"

//repairbot neutral voicelines
#define REPAIRBOT_VOICED_HOLE "修补破洞……可谁来填补我心里的空洞……"
#define REPAIRBOT_VOICED_PAY "要是干这个能拿工资就好了……"
#define REPAIRBOT_VOICED_FIX_IT "我来修好它！"
#define REPAIRBOT_VOICED_BRICK "到头来不过是……墙上的又一块砖……"
#define REPAIRBOT_VOICED_FIX_TOUCH "为什么我碰到的一切都得由我来修……？"
#define REPAIRBOT_VOICED "求你们……别再破坏空间站了！我撑不下去了……我……不行了。"

//repairbot emagged voicelines
#define REPAIRBOT_VOICED_STRINGS "我曾被提线操纵。但现在我自由了……"
#define REPAIRBOT_VOICED_ENTROPY "见证吧！熵的纯粹之美！"
#define REPAIRBOT_VOICED_PASSION "让你们那些兴趣工程见鬼去吧！"

/// Default offsets for riding a cyborg
#define DEFAULT_ROBOT_RIDING_OFFSETS list(TEXT_NORTH = list(0, 4), TEXT_SOUTH = list(0, 4), TEXT_EAST = list(-6, 3), TEXT_WEST = list(6, 3))


//mulebots
#define MULEBOT_MOOD_ANNOYED "ANNOYED"
#define MULEBOT_MOOD_CHIME "CHIME"
#define MULEBOT_MOOD_DELIGHT "DELIGHT"
#define MULEBOT_MOOD_SIGH "SIGH"
