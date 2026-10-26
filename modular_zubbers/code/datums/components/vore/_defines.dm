/// If you want to make everything as easy to test as possible, uncomment this for maximum permissiveness
// #define VORE_DEBUG
/// Key used for versioning savefiles
#define VORE_DB_REPO "bubber_vore"
/// Value used for versioning savefiles
#define VORE_DB_VERSION "1.0"
/// Key used for belly versioning independent of savefile version
#define VORE_BELLY_KEY "version"
/// Value used for belly versioning independent of savefile version
#define VORE_BELLY_VERSION "1.0"
/// Maximum amount of bellies allowed within one layout
#define MAX_BELLIES CONFIG_GET(number/vore_max_bellies) // Default: 10
/// Maximum amount of prey that can be eaten at once
#define MAX_PREY CONFIG_GET(number/vore_max_prey) // Default: 3
/// Amount of time it takes for players to eat someone
#define VORE_DELAY CONFIG_GET(number/vore_delay) // Default: 4 SECONDS
/// Amount of time it takes for players to eject someone
#define VORE_EJECT_DELAY CONFIG_GET(number/vore_eject_delay) // Default: 2 SECONDS
/// If true, prevents people with prey inside them from being eaten
#define MATRYOSHKA_BANNED CONFIG_GET(flag/vore_matryoshka_banned)
/// If true, automatically disables sensors when prey is eaten
#define DISABLES_SENSORS CONFIG_GET(flag/vore_disables_sensors)
/// If true, prevents mobs in crit or death from engaging in vore
#define NO_DEAD CONFIG_GET(flag/vore_no_dead)
/// If true, mobs with no player cannot be pred or prey
#define REQUIRES_PLAYER CONFIG_GET(flag/vore_requires_player)
/// Makes every mob spawn with a vore component, just for testing
// #define VORE_TESTING_ALL_MOBS_ARE_VORE_MOBS
/// Number of rolling backups bellies will keep
#define BELLY_BACKUP_COUNT 5
/// Maximum number of belly layout slots
#define MAX_BELLY_LAYOUTS CONFIG_GET(number/vore_max_belly_layouts) // Default: 20
/// Rate limit on belly creation, as it can get a little expensive
#define BELLY_CREATION_COOLDOWN 2 SECONDS
/// Maximum length() of a json file's text before we refuse to parse it
/// Default here is to support at least MAX_BELLIES with maxxed descriptions, plus their metadata
#define MAX_JSON_CHARACTERS MAX_FLAVOR_LEN * MAX_BELLIES * 3
/// Maximum length() of a parsed json file before we refuse to parse it further
#define MAX_JSON_ENTRIES 100
/// Volume used for all vore noises
#define VORE_SOUND_VOLUME 35
/// Volume used specifically for the preyloop
#define PREYLOOP_VOLUME 70

#define TRAIT_SOURCE_VORE "vore"

#define DIGEST_MODE_SAFE "Safe"
#define DIGEST_MODE_DIGEST "Digest"
#define DIGEST_MODE_ABSORB "Absorb"
#define DIGEST_MODE_UNABSORB "Unabsorb"

/// Max burn damage a player is allowed to set their belly to
#define MAX_BURN_DAMAGE CONFIG_GET(number/vore_max_burn_damage) // Default: 2.5
/// Max brute damage a player is allowed to set their belly to
#define MAX_BRUTE_DAMAGE CONFIG_GET(number/vore_max_brute_damage) // Default: 2.5
/// Minimum time that can be set for escaping a belly
#define MIN_ESCAPE_TIME CONFIG_GET(number/vore_min_escape_time) // Default: 2
#define DEFAULT_ESCAPE_TIME CONFIG_GET(number/vore_default_escape_time) // Default: 15
#define MAX_ESCAPE_TIME CONFIG_GET(number/vore_max_escape_time) // Default: 60
#define MAX_VERB_LENGTH CONFIG_GET(number/vore_max_verb_length) // Default: 20
#define MAX_VORE_MESSAGE_LENGTH CONFIG_GET(number/vore_max_message_length) // Default: 160
#define MIN_VORE_MESSAGE_LENGTH CONFIG_GET(number/vore_min_message_length) // Default: 10

/// Amount of nutrition given per point of damage dealt
#define NUTRITION_PER_DAMAGE 2
/// Amount of nutrition given when digesting something fully
#define NUTRITION_PER_KILL 50
/// Once prey goes below this nutrition barrier, they will be absorbed
#define ABSORB_NUTRITION_BARRIER 100

#define DIGESTION_NOISE_COOLDOWN 10 SECONDS

#define PREF_TRINARY_NEVER 0
#define PREF_TRINARY_PROMPT 1
#define PREF_TRINARY_ALWAYS 2

#define CHANNEL_PREYLOOP 1004
#define COOLDOWN_PREYLOOP "preyloop"
#define COOLDOWN_ESCAPE "vore_escape"
/// Cooldown on trying to escape, reduces amount of noise they can make
#define COOLDOWN_ESCAPE_TIME 5 SECONDS

/proc/detect_vrdb(list/data)
	if(LAZYLEN(data) < 1)
		return FALSE
	// For non-VRDB, the first item will not be a belly, it'll be a list
	var/list/first_item = data[1]
	if(!islist(first_item))
		return FALSE
	if("name" in first_item)
		return TRUE
	return FALSE


/// What types of mobs are allowed to participate in vore at all?
/// This controls whether vore components are added on any mob Login for vore-enabled clients
#ifndef VORE_DEBUG
GLOBAL_LIST_INIT(vore_allowed_mob_types, typecacheof(list(
	/mob/living/carbon/human,
	/mob/living/silicon/robot
)))
#else
// Vore debug mode: all mobs are fair game
GLOBAL_LIST_INIT(vore_allowed_mob_types, typecacheof(list(
	/mob/living,
)))
#endif

/// List of types that will be automatically ejected from prey when they enter a belly
GLOBAL_LIST_INIT(vore_blacklist_types, list(
	/obj/item/disk/nuclear,
))

// Belly Planet! Used to return always-safe air to prey.
/datum/gas_mixture/immutable/planetary/belly
GLOBAL_DATUM_INIT(belly_air, /datum/gas_mixture/immutable/planetary, init_belly_air())
/proc/init_belly_air()
	var/datum/gas_mixture/immutable/planetary/belly_air = new()
	belly_air.parse_string_immutable(OPENTURF_DEFAULT_ATMOS)
	return belly_air

GLOBAL_LIST_INIT(vore_sounds_slosh, list(
	'modular_zubbers/sound/vore/walkslosh1.ogg',
	'modular_zubbers/sound/vore/walkslosh2.ogg',
	'modular_zubbers/sound/vore/walkslosh3.ogg',
	'modular_zubbers/sound/vore/walkslosh4.ogg',
	'modular_zubbers/sound/vore/walkslosh5.ogg',
	'modular_zubbers/sound/vore/walkslosh6.ogg',
	'modular_zubbers/sound/vore/walkslosh7.ogg',
	'modular_zubbers/sound/vore/walkslosh8.ogg',
	'modular_zubbers/sound/vore/walkslosh9.ogg',
	'modular_zubbers/sound/vore/walkslosh10.ogg'
))

//Classic Vore sounds
GLOBAL_LIST_INIT(vore_sounds_insert_classic, list(
	"Gulp" = 'modular_zubbers/sound/vore/gulp.ogg',
	"Insert" = 'modular_zubbers/sound/vore/insert.ogg',
	"Insertion1" = 'modular_zubbers/sound/vore/insertion1.ogg',
	"Insertion2" = 'modular_zubbers/sound/vore/insertion2.ogg',
	"Insertion3" = 'modular_zubbers/sound/vore/insertion3.ogg',
	"Schlorp" = 'modular_zubbers/sound/vore/schlorp.ogg',
	"Squish1" = 'modular_zubbers/sound/vore/squish1.ogg',
	"Squish2" = 'modular_zubbers/sound/vore/squish2.ogg',
	"Squish3" = 'modular_zubbers/sound/vore/squish3.ogg',
	"Squish4" = 'modular_zubbers/sound/vore/squish4.ogg',
	"Rustle (cloth)" = 'sound/effects/rustle/rustle1.ogg',
	"Rustle 2 (cloth)"	= 'sound/effects/rustle/rustle2.ogg',
	"Rustle 3 (cloth)"	= 'sound/effects/rustle/rustle3.ogg',
	"Rustle 4 (cloth)"	= 'sound/effects/rustle/rustle4.ogg',
	"Rustle 5 (cloth)"	= 'sound/effects/rustle/rustle5.ogg',
	"Zipper" = 'sound/items/zip/zip.ogg',
	"None" = null
))

GLOBAL_LIST_INIT(vore_sounds_release_classic, list(
	"Rustle (cloth)" = 'sound/effects/rustle/rustle1.ogg',
	"Rustle 2 (cloth)" = 'sound/effects/rustle/rustle2.ogg',
	"Rustle 3 (cloth)" = 'sound/effects/rustle/rustle3.ogg',
	"Rustle 4 (cloth)" = 'sound/effects/rustle/rustle4.ogg',
	"Rustle 5 (cloth)" = 'sound/effects/rustle/rustle5.ogg',
	"Zipper" = 'sound/items/zip/zip.ogg',
	"Splatter" = 'sound/effects/splat.ogg',
	"None" = null
))

//Poojy's Fancy Sounds
GLOBAL_LIST_INIT(vore_sounds_insert_fancy, list(
	"Gulp" = 'modular_zubbers/sound/vore/sunesound/pred/swallow_01.ogg',
	"Swallow" = 'modular_zubbers/sound/vore/sunesound/pred/swallow_02.ogg',
	"Insertion1" = 'modular_zubbers/sound/vore/sunesound/pred/insertion_01.ogg',
	"Insertion2" = 'modular_zubbers/sound/vore/sunesound/pred/insertion_02.ogg',
	"Tauric Swallow" = 'modular_zubbers/sound/vore/sunesound/pred/taurswallow.ogg',
	"Stomach Move" = 'modular_zubbers/sound/vore/sunesound/pred/stomachmove.ogg',
	"Schlorp" = 'modular_zubbers/sound/vore/sunesound/pred/schlorp.ogg',
	"Squish1" = 'modular_zubbers/sound/vore/sunesound/pred/squish_01.ogg',
	"Squish2" = 'modular_zubbers/sound/vore/sunesound/pred/squish_02.ogg',
	"Squish3" = 'modular_zubbers/sound/vore/sunesound/pred/squish_03.ogg',
	"Squish4" = 'modular_zubbers/sound/vore/sunesound/pred/squish_04.ogg',
	"Rustle (cloth)" = 'sound/effects/rustle/rustle1.ogg',
	"Rustle 2 (cloth)" = 'sound/effects/rustle/rustle2.ogg',
	"Rustle 3 (cloth)" = 'sound/effects/rustle/rustle3.ogg',
	"Rustle 4 (cloth)" = 'sound/effects/rustle/rustle4.ogg',
	"Rustle 5 (cloth)" = 'sound/effects/rustle/rustle5.ogg',
	"Zipper" = 'sound/items/zip/zip.ogg',
	"None" = null
))

GLOBAL_LIST_INIT(vore_sounds_release_fancy, list(
	"Rustle (cloth)" = 'sound/effects/rustle/rustle1.ogg',
	"Rustle 2 (cloth)" = 'sound/effects/rustle/rustle2.ogg',
	"Rustle 3 (cloth)" = 'sound/effects/rustle/rustle3.ogg',
	"Rustle 4 (cloth)" = 'sound/effects/rustle/rustle4.ogg',
	"Rustle 5 (cloth)" = 'sound/effects/rustle/rustle5.ogg',
	"Zipper" = 'sound/items/zip/zip.ogg',
	"Stomach Move" = 'modular_zubbers/sound/vore/sunesound/pred/stomachmove.ogg',
	"Pred Escape" = 'modular_zubbers/sound/vore/sunesound/pred/escape.ogg',
	"Splatter" = 'sound/effects/splat.ogg',
	"None" = null
))

GLOBAL_LIST_INIT(vore_sounds_hunger, list(
	'modular_zubbers/sound/vore/growl1.ogg', 'modular_zubbers/sound/vore/growl2.ogg', 'modular_zubbers/sound/vore/growl3.ogg',
	'modular_zubbers/sound/vore/growl4.ogg', 'modular_zubbers/sound/vore/growl5.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_digestion_classic, list(
	'modular_zubbers/sound/vore/digest1.ogg', 'modular_zubbers/sound/vore/digest2.ogg', 'modular_zubbers/sound/vore/digest3.ogg', 'modular_zubbers/sound/vore/digest4.ogg',
	'modular_zubbers/sound/vore/digest5.ogg', 'modular_zubbers/sound/vore/digest6.ogg', 'modular_zubbers/sound/vore/digest7.ogg', 'modular_zubbers/sound/vore/digest8.ogg',
	'modular_zubbers/sound/vore/digest9.ogg', 'modular_zubbers/sound/vore/digest10.ogg', 'modular_zubbers/sound/vore/digest11.ogg', 'modular_zubbers/sound/vore/digest12.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_death_classic, list(
	'modular_zubbers/sound/vore/death1.ogg', 'modular_zubbers/sound/vore/death2.ogg', 'modular_zubbers/sound/vore/death3.ogg', 'modular_zubbers/sound/vore/death4.ogg',
	'modular_zubbers/sound/vore/death5.ogg', 'modular_zubbers/sound/vore/death6.ogg', 'modular_zubbers/sound/vore/death7.ogg', 'modular_zubbers/sound/vore/death8.ogg',
	'modular_zubbers/sound/vore/death9.ogg', 'modular_zubbers/sound/vore/death10.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_struggle_classic, list(
	'modular_zubbers/sound/vore/squish1.ogg', 'modular_zubbers/sound/vore/squish2.ogg', 'modular_zubbers/sound/vore/squish3.ogg', 'modular_zubbers/sound/vore/squish4.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_struggle_fancy, list(
	'modular_zubbers/sound/vore/sunesound/prey/struggle_01.ogg', 'modular_zubbers/sound/vore/sunesound/prey/struggle_02.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/struggle_03.ogg', 'modular_zubbers/sound/vore/sunesound/prey/struggle_04.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/struggle_05.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_digestion_fancy, list(
	'modular_zubbers/sound/vore/sunesound/pred/digest_01.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_02.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_03.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/digest_04.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_05.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_06.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/digest_07.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_08.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_09.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/digest_10.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_11.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_12.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/digest_13.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_14.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_15.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/digest_16.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_17.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_18.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_death_fancy, list(
	'modular_zubbers/sound/vore/sunesound/pred/death_01.ogg','modular_zubbers/sound/vore/sunesound/pred/death_02.ogg','modular_zubbers/sound/vore/sunesound/pred/death_03.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/death_04.ogg','modular_zubbers/sound/vore/sunesound/pred/death_05.ogg','modular_zubbers/sound/vore/sunesound/pred/death_06.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/death_07.ogg','modular_zubbers/sound/vore/sunesound/pred/death_08.ogg','modular_zubbers/sound/vore/sunesound/pred/death_09.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/death_10.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_digestion_fancy_prey, list(
	'modular_zubbers/sound/vore/sunesound/prey/digest_01.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_02.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_03.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/digest_04.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_05.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_06.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/digest_07.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_08.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_09.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/digest_10.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_11.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_12.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/digest_13.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_14.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_15.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/digest_16.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_17.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_18.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_death_fancy_prey, list(
	'modular_zubbers/sound/vore/sunesound/prey/death_01.ogg','modular_zubbers/sound/vore/sunesound/prey/death_02.ogg','modular_zubbers/sound/vore/sunesound/prey/death_03.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/death_04.ogg','modular_zubbers/sound/vore/sunesound/prey/death_05.ogg','modular_zubbers/sound/vore/sunesound/prey/death_06.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/death_07.ogg','modular_zubbers/sound/vore/sunesound/prey/death_08.ogg','modular_zubbers/sound/vore/sunesound/prey/death_09.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/death_10.ogg'
))

// Default messages

GLOBAL_LIST_INIT(digest_messages_pred, list(
		"你感觉到 %prey 的身体屈服于你的消化系统，被分解成柔软的浆液。",
		"你的 %belly 肌肉将 %prey 磨成温热的糊状物，发出淫靡的咕噜声。",
		"你的 %belly 一边将 %prey 融化成泥浆，一边发出低沉的轰鸣。",
		"你感觉到轻柔的咕噜声，%prey 的身体在你的 %belly 中失去了形态，如今只剩翻滚的柔软浆团。",
		"你的 %belly 开始将 %prey 的残余输送至全身，为你的大腿增添一些重量。",
		"你的 %belly 开始将 %prey 的残余输送至全身，为你的臀部增添一些重量。",
		"你的 %belly 开始将 %prey 的残余输送至全身，为你的腹部增添一些重量。",
		"随着 %prey 化为浓汤，你的 %belly 发出低鸣。你能感觉到残余即将流向身体深处，被吸收殆尽。",
		"你的 %belly 揉压着 %prey 的每一寸身体，将其软化成糊状，为你的下一次狩猎补充能量。",
		"你的 %belly 将 %prey 搅成滚烫的浆液。伴随着绵长而湿润的咕噜声，你能感觉到营养流经消化道。"))

GLOBAL_LIST_INIT(digest_messages_prey, list(
		"你的身体屈服于 %pred 的消化系统，被分解成柔软的浆液。",
		"%pred 的 %belly 肌肉将你磨成温热的糊状物，发出淫靡的咕噜声。",
		"%pred 的 %belly 一边将你融化成泥浆，一边发出低沉的轰鸣。",
		"随着你的身体在 %pred 的 %belly 中失去形态，%pred 感到轻柔的咕噜声。如今的你只剩翻滚的柔软浆团。",
		"%pred 的 %belly 开始将你的残余输送至全身，为 %pred 的大腿增添一些重量。",
		"%pred 的 %belly 开始将你的残余输送至全身，为 %pred 的臀部增添一些重量。",
		"%pred 的 %belly 开始将你的残余输送至全身，为 %pred 的腹部增添一些重量。",
		"随着你化为浓汤，%pred 的 %belly 发出低鸣。你的残余很快流向 %pred 的身体深处，被吸收殆尽。",
		"%pred 的 %belly 揉压着你的每一寸身体，将你软化成糊状，为下一次狩猎补充能量。",
		"%pred 的 %belly 将你搅成滚烫的浆液。伴随着绵长而湿润的咕噜声，你富含营养的残余流经消化道。"))

GLOBAL_LIST_INIT(absorb_messages_owner, list(
	"你感觉到 %prey 正成为你的一部分。"
))

GLOBAL_LIST_INIT(absorb_messages_prey, list(
	"你感觉到自己正成为 %pred 的 %belly 的一部分！"
))

GLOBAL_LIST_INIT(unabsorb_messages_owner, list(
	"你感觉到 %prey 再次恢复了可辨认的形态。"
))

GLOBAL_LIST_INIT(unabsorb_messages_prey, list(
	"你从 %pred 的 %belly 中分离出来，不再是其中的一部分。"
))

GLOBAL_LIST_INIT(struggle_messages_outside, list(
	"%pred 的 %belly 因扭动的食物而晃动。",
	"%pred 的 %belly 随着内部的动作摇晃。",
	"有人从内部推挤，让 %pred 的 %belly 短暂地向外鼓起。",
	"%pred 的 %belly 因被困者的挣扎而抖动。",
	"%pred 的 %belly 随着内部的动作颤动。",
	"%pred 的 %belly 晃荡着。",
	"%pred 的 %belly 轻轻涌动。",
	"%pred 的 %belly 发出湿润的挤压声。"))

GLOBAL_LIST_INIT(struggle_messages_inside, list(
	"你徒劳的扭动只让 %pred 黏滑的 %belly 在你的身体上挤压作响。",
	"你的挣扎只让 %pred 的 %belly 在你周围轻轻涌动。",
	"你的动作只让 %pred 的 %belly 在你周围晃荡。",
	"你的动作让 %pred 的 %belly 颤动。",
	"你在 %pred 的 %belly 内不安地扭动。",
	"你推挤着 %pred 的 %belly 内壁，使其短暂地向外鼓起。",
	"你的动作摇晃着 %pred 的 %belly。",
	"你在 %pred 的 %belly 中扭动，让其摇晃起来。"))

GLOBAL_LIST_INIT(absorbed_struggle_messages_outside, list(
	"%pred 的 %belly 似乎自行晃动着。",
	"%pred 的 %belly 毫无征兆地颤动。",
	"%pred 的 %belly 似乎无缘无故地抖动了一下。"))

GLOBAL_LIST_INIT(absorbed_struggle_messages_inside, list(
	"你试着抵抗 %pred 的 %belly，却只能让其轻轻颤动。",
	"你徒劳的意念挣扎只让 %pred 的 %belly 微微移动。",
	"你始终无法挣脱 %pred 的 %belly。"))

GLOBAL_LIST_INIT(escape_attempt_messages_owner, list(
	"%prey 正试图挣脱你的 %belly！"))

GLOBAL_LIST_INIT(escape_attempt_messages_prey, list(
	"你开始从 %pred 的 %belly 中往外爬。"))

GLOBAL_LIST_INIT(escape_messages_owner, list(
	"%prey 从你的 %belly 中爬了出来！"))

GLOBAL_LIST_INIT(escape_messages_prey, list(
	"你从 %pred 的 %belly 中爬了出来。"))

GLOBAL_LIST_INIT(escape_messages_outside, list(
	"%prey 从 %pred 的 %belly 中爬了出来！"))

GLOBAL_LIST_INIT(escape_fail_messages_owner, list(
	"%prey 试图逃离你的 %belly，但失败了！"))

GLOBAL_LIST_INIT(escape_fail_messages_prey, list(
	"你试图逃离 %pred 的 %belly，但失败了！"))

// Override settings for vore debug mode
#ifdef VORE_DEBUG

#warn Vore debugging mode is on! This will allow all mobs to participate in vore, client or not!

#undef REQUIRES_PLAYER
#define REQUIRES_PLAYER FALSE

#ifndef VORE_TESTING_ALL_MOBS_ARE_VORE_MOBS
#define VORE_TESTING_ALL_MOBS_ARE_VORE_MOBS
#endif

#endif
