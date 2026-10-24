/// Default value for the max_complexity var on MODsuits
#define DEFAULT_MAX_COMPLEXITY 15

/// The default cell drain of a modsuit. The standard modsuit active power usage drains this much energy per modsuit second.
#define DEFAULT_CHARGE_DRAIN (0.005 * STANDARD_CELL_CHARGE) // A standard cell lasts 200 seconds with this on active power usage, while a high power one lasts 2,000 seconds.

/// Default time for a part of the suit to seal.
#define MOD_ACTIVATION_STEP_TIME (1 SECONDS)

/// How likely the UI is to fail when malfunctioning
#define MOD_MALFUNCTION_PROB 75

/// Passive module, just acts when put in naturally.
#define MODULE_PASSIVE 0
/// Usable module, does something when you press a button.
#define MODULE_USABLE 1
/// Toggle module, you turn it on/off and it does stuff.
#define MODULE_TOGGLE 2
/// Actively usable module, you may only have one selected at a time.
#define MODULE_ACTIVE 3

/// This module can be used during phaseout
#define MODULE_ALLOW_PHASEOUT (1<<0)
/// This module can be used while incapacitated
#define MODULE_ALLOW_INCAPACITATED (1<<1)
/// This module can be used while the suit is off
#define MODULE_ALLOW_INACTIVE (1<<2)
/// This module can be used (by button) while the suit is unworn
#define MODULE_ALLOW_UNWORN (1<<3)

#define UNSEALED_LAYER "unsealed_layer"
#define SEALED_LAYER "sealed_layer"
#define UNSEALED_CLOTHING "unsealed_clothing"
#define SEALED_CLOTHING "sealed_clothing"
#define UNSEALED_INVISIBILITY "unsealed_invisibility"
#define SEALED_INVISIBILITY "sealed_invisibility"
#define UNSEALED_COVER "unsealed_cover"
#define SEALED_COVER "sealed_cover"
#define CAN_OVERSLOT "can_overslot"
#define UNSEALED_MESSAGE "unsealed_message"
#define SEALED_MESSAGE "sealed_message"
#define MOD_PART_TRAITS "mod_part_traits"

//Defines used to override MOD clothing's icon and worn icon files in the skin.
#define MOD_ICON_OVERRIDE "mod_icon_override"
#define MOD_WORN_ICON_OVERRIDE "mod_worn_icon_override"

//Defines for MODlink frequencies
#define MODLINK_FREQ_NANOTRASEN "NT"
#define MODLINK_FREQ_SYNDICATE "SYND"
#define MODLINK_FREQ_CHARLIE "CHRL"
#define MODLINK_FREQ_CENTCOM "CC"

//Default text for different messages for the user.
#define HELMET_UNSEAL_MESSAGE "发出嘶声并打开"
#define HELMET_SEAL_MESSAGE "发出嘶声并闭合"
#define CHESTPLATE_UNSEAL_MESSAGE "松开了你的胸部"
#define CHESTPLATE_SEAL_MESSAGE "紧紧包裹住你的胸部"
#define GAUNTLET_UNSEAL_MESSAGE "松开了你的手指"
#define GAUNTLET_SEAL_MESSAGE "紧紧包裹住你的手指与手腕"
#define BOOT_UNSEAL_MESSAGE "松开了对你腿部的束缚"
#define BOOT_SEAL_MESSAGE "在你的脚部周围密封闭合"
#define GLASSES_UNSEAL_MESSAGE "移离了你的眼睛"
#define GLASSES_SEAL_MESSAGE "贴合在你的眼前"
#define NECKWEAR_UNSEAL_MESSAGE "在你的脖子周围松开"
#define NECKWEAR_SEAL_MESSAGE "在你的脖子周围收紧"

/// Global list of all /datum/mod_theme
GLOBAL_LIST_INIT(mod_themes, setup_mod_themes())
/// Global list of all ids associated to a /datum/mod_link instance
GLOBAL_LIST_EMPTY(mod_link_ids)
