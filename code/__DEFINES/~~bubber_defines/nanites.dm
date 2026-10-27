#define CAN_HAVE_NANITES(host_mob) (host_mob.mob_biotypes & (MOB_ORGANIC|MOB_UNDEAD|MOB_ROBOTIC) && !issilicon(host_mob))

#define NANITE_SYNC_DELAY 300

#define NANITE_SHOCK_IMMUNE 1
#define NANITE_EMP_IMMUNE 2

#define NANITE_PROGRAM_LIMIT 20

#define NANITE_BASE_RESEARCH_PROGRESS 25

#define NANITE_CLOUD_TOGGLE 1
#define NANITE_CLOUD_DISABLE 2
#define NANITE_CLOUD_ENABLE 3

//Nanite excess thresholds
#define NANITE_EXCESS_MINOR 25
#define NANITE_EXCESS_VOMIT 100
#define NANITE_EXCESS_BURST 350

#define NANITE_BIO_REGENERATION 0.5
#define NANITE_ADV_BIO_REGENERATION NANITE_BIO_REGENERATION * 4
#define NANITE_ROBO_REGENERATION NANITE_BIO_REGENERATION * 2

#define NANITE_TOX_REGENERATION 0.5
#define NANITE_ADV_TOX_REGENERATION NANITE_TOX_REGENERATION

#define NANITE_BRAIN_REGENERATION 0.2
#define NANITE_ADV_BRAIN_REGENERATION NANITE_BRAIN_REGENERATION * 2

#define HARMFUL_PROGRAM_DAMAGE_SCALE 1.25
#define NANITE_OXYLOSS 5

#define NANITE_PROTOCOL_KICKSTART_REPLICATION 3.5
#define NANITE_PROTOCOL_FACTORY_MAX_REPLICATION 2

///Nanite Protocol types
#define NANITE_PROTOCOL_REPLICATION "nanite_replication"
#define NANITE_PROTOCOL_STORAGE "nanite_storage"

///Nanite extra settings types: used to help uis know what type an extra setting is
#define NESTYPE_TEXT "text"
#define NESTYPE_NUMBER "number"
#define NESTYPE_TYPE "type"
#define NESTYPE_BOOLEAN "boolean"

///Nanite Extra Settings - Note that these will also be the names displayed in the UI
#define NES_SENT_CODE "发送代码"
#define NES_DELAY "延迟"
#define NES_MODE "模式"
#define NES_COMM_CODE "通信代码"
#define NES_RELAY_CHANNEL "中继频道"
#define NES_HEALTH_PERCENT "健康百分比"
#define NES_DIRECTION "方向"
#define NES_NANITE_PERCENT "纳米机器人容量百分比"
#define NES_DAMAGE_TYPE "伤害类型"
#define NES_DAMAGE "伤害量"
#define NES_SENTENCE "语句"
#define NES_MESSAGE "消息"
#define NES_DIRECTIVE "指令"
#define NES_INCLUSIVE_MODE "包含模式"
#define NES_RACE "种族"
#define NES_HALLUCINATION_TYPE "幻觉类型"
#define NES_HALLUCINATION_DETAIL "幻觉细节"
#define NES_MOOD_MESSAGE "心情描述"
#define NES_PROGRAM_OVERWRITE "覆盖程序"
#define NES_CLOUD_OVERWRITE "覆盖云端编号"
#define NES_SCAN_TYPE "扫描类型"
#define NES_BUTTON_NAME "按钮名称"
#define NES_ICON "图标"
#define NANITE_HARMONIC_ID "纳米谐振 ID"
