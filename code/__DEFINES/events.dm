#define SUCCESSFUL_SPAWN 2
#define NOT_ENOUGH_PLAYERS 3
#define MAP_ERROR 4
#define WAITING_FOR_SOMETHING 5

#define EVENT_CANT_RUN 0
#define EVENT_READY 1
#define EVENT_CANCELLED 2
#define EVENT_INTERRUPTED 3

///Events that mess with or create artificial intelligences, such as vending machines and the AI itself
#define EVENT_CATEGORY_AI "AI 故障"
///Events that spawn anomalies, which might be the source of anomaly cores
#define EVENT_CATEGORY_ANOMALIES "异常现象"
///Events pertaining cargo, messages incoming to the station and job slots
#define EVENT_CATEGORY_BUREAUCRATIC "行政事务"
///Events that cause breakages and malfunctions that could be fixed by engineers
#define EVENT_CATEGORY_ENGINEERING "工程"
///Events that spawn creatures with simple desires, such as to hunt
#define EVENT_CATEGORY_ENTITIES "实体"
///Events that should have no harmful effects, and might be useful to the crew
#define EVENT_CATEGORY_FRIENDLY "友好事件"
///Events that affect the body and mind
#define EVENT_CATEGORY_HEALTH "健康"
///Events reserved for special occasions
#define EVENT_CATEGORY_HOLIDAY "节日"
///Events with enemy groups with a more complex plan
#define EVENT_CATEGORY_INVASION "入侵"
///Events that make a mess
#define EVENT_CATEGORY_JANITORIAL "清洁"
///Events that summon meteors and other debris, and stationwide waves of harmful space weather
#define EVENT_CATEGORY_SPACE "太空威胁"
///Events summoned by a wizard
#define EVENT_CATEGORY_WIZARD "巫师"

/// Return from admin setup to stop the event from triggering entirely.
#define ADMIN_CANCEL_EVENT "cancel event"

/// Event can never be triggered by wizards
#define NEVER_TRIGGERED_BY_WIZARDS -1
/// Event can only run on a map set in space
#define EVENT_SPACE_ONLY (1 << 0)
/// Event can only run on a map which is a planet
#define EVENT_PLANETARY_ONLY (1 << 1)
/// Event timer in seconds
#define EVENT_SECONDS *0.5

///Backstory key for the fugitive solo backstories
#define FUGITIVE_BACKSTORY_WALDO "waldo"
#define FUGITIVE_BACKSTORY_INVISIBLE "invisible"
///Backstory keys for the fugitive team backstories
#define FUGITIVE_BACKSTORY_PRISONER "prisoner"
#define FUGITIVE_BACKSTORY_CULTIST "cultist"
#define FUGITIVE_BACKSTORY_SYNTH "synth"
