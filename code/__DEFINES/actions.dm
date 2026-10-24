///Action button checks if hands are unusable
#define AB_CHECK_HANDS_BLOCKED (1<<0)
///Action button checks if user is immobile
#define AB_CHECK_IMMOBILE (1<<1)
///Action button checks if user is resting
#define AB_CHECK_LYING (1<<2)
///Action button checks if user is conscious
#define AB_CHECK_CONSCIOUS (1<<3)
///Action button checks if user is incapacitated
#define AB_CHECK_INCAPACITATED (1<<4)
///Action button checks if user is jaunting
#define AB_CHECK_PHASED (1<<5)
///Action button checks if user is not on an open turf
#define AB_CHECK_OPEN_TURF (1<<6)

DEFINE_BITFIELD(check_flags, list(
	"检查双手是否受限" = AB_CHECK_HANDS_BLOCKED,
	"检查是否无法移动" = AB_CHECK_IMMOBILE,
	"检查是否躺倒" = AB_CHECK_LYING,
	"检查是否清醒" = AB_CHECK_CONSCIOUS,
	"检查是否失去行动能力" = AB_CHECK_INCAPACITATED,
	"检查是否暂时处于无实体状态" = AB_CHECK_PHASED,
	"检查是否不在开放地块上" = AB_CHECK_OPEN_TURF,
))

///Action button triggered with right click
#define TRIGGER_SECONDARY_ACTION (1<<0)
///Action triggered to ignore any availability checks
#define TRIGGER_FORCE_AVAILABLE (1<<1)

#define ACTION_BUTTON_DEFAULT_BACKGROUND "_use_ui_default_background"

#define UPDATE_BUTTON_NAME (1<<0)
#define UPDATE_BUTTON_ICON (1<<1)
#define UPDATE_BUTTON_BACKGROUND (1<<2)
#define UPDATE_BUTTON_OVERLAY (1<<3)
#define UPDATE_BUTTON_STATUS (1<<4)

/// Takes in a typepath of a `/datum/action` and adds it to `src`.
/// Only useful if you want to add the action and never desire to reference it again ever.
#define GRANT_ACTION(typepath) do {\
	var/datum/action/_ability = new typepath(src);\
	_ability.Grant(src);\
} while (FALSE)
