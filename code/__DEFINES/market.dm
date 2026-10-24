
// Shipping methods

// The BEST way of shipping items: accurate, "undetectable"
#define SHIPPING_METHOD_LTSRBT "LTSRBT"
// Picks a random area to teleport the item to and gives you a minute to get there before it is sent.
#define SHIPPING_METHOD_TELEPORT "传送"
// Throws the item from somewhere at the station.
#define SHIPPING_METHOD_LAUNCH "发射"
// Sends a supply pod to the buyer's location, showy.
#define SHIPPING_METHOD_SUPPLYPOD "补给舱"

/// The percentage on gains that's removed when selling an item through the blackmarket with the LTSRBT
#define MARKET_WITHHOLDING_TAX 0.15

//Black Market Uplink categories
#define BLACKMARKET_CATEGORY_CLOTHING "服装"
#define BLACKMARKET_CATEGORY_CONSUMABLES "消耗品"
#define BLACKMARKET_CATEGORY_HOSTAGES "人质"
#define BLACKMARKET_CATEGORY_LOCAL_GOODS "本地货物"
#define BLACKMARKET_CATEGORY_MISC "杂项"
#define BLACKMARKET_CATEGORY_FENCED_GOODS "赃物"
#define BLACKMARKET_CATEGORY_TOOLS "工具"
#define BLACKMARKET_CATEGORY_WEAPONS "武器"

#define BLACKMARKET_CATEGORIES list(\
	BLACKMARKET_CATEGORY_CLOTHING,\
	BLACKMARKET_CATEGORY_CONSUMABLES,\
	BLACKMARKET_CATEGORY_HOSTAGES,\
	BLACKMARKET_CATEGORY_LOCAL_GOODS,\
	BLACKMARKET_CATEGORY_MISC,\
	BLACKMARKET_CATEGORY_FENCED_GOODS,\
	BLACKMARKET_CATEGORY_TOOLS,\
	BLACKMARKET_CATEGORY_WEAPONS,\
)
