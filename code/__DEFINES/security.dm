
// CATEGORY HEADERS

/// New `/datum/detective_scan_category` must be created when adding new `DETSCAN_CATEGORY`.
/// Macros are sorted by `/datum/detective_scan_category::display_order`

/// Fingerpints detected
#define DETSCAN_CATEGORY_FINGERS "指纹"
/// Displays any bloodprints found and their uefi
#define DETSCAN_CATEGORY_BLOOD "血液"
/// Clothing and glove fibers
#define DETSCAN_CATEGORY_FIBER "纤维"
/// Liquids detected
#define DETSCAN_CATEGORY_REAGENTS "试剂"
/// ID Access
#define DETSCAN_CATEGORY_ACCESS "ID 卡权限"

// The categories below do not have hard rules on what info is displayed, and are for categorizing info thematically.

/// The mode that the items in, what kind of item is dispensed, etc
#define DETSCAN_CATEGORY_SETTINGS "当前设置"
/// praise be
#define DETSCAN_CATEGORY_HOLY "神圣数据"
/// Attributes that might be illegal, can also have ties to syndicate
#define DETSCAN_CATEGORY_ILLEGAL "非法科技"
/// Generic extra information category
#define DETSCAN_CATEGORY_NOTES "附加备注"

/// the order departments show up in for the id scan (its sorted by red to blue on the color wheel)
#define DETSCAN_ACCESS_ORDER(...) list(\
	REGION_SECURITY, \
	REGION_ENGINEERING, \
	REGION_SUPPLY, \
	REGION_GENERAL, \
	REGION_MEDBAY, \
	REGION_COMMAND, \
	REGION_RESEARCH, \
	REGION_CENTCOM, \
)

/// if any categories list has this entry, it will be hidden
#define DETSCAN_BLOCK "DETSCAN_BLOCK"

/// Wanted statuses
#define WANTED_ARREST "Arrest"
#define WANTED_DISCHARGED "Discharged"
#define WANTED_NONE "None"
#define WANTED_PAROLE "Parole"
#define WANTED_PRISONER "Incarcerated"
#define WANTED_SUSPECT "Suspected"

/// List of available wanted statuses
#define WANTED_STATUSES(...) list(\
	WANTED_NONE, \
	WANTED_SUSPECT, \
	WANTED_ARREST, \
	WANTED_PRISONER, \
	WANTED_PAROLE, \
	WANTED_DISCHARGED, \
)
