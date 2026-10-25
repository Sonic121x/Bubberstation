#include "chinese_action_display.dm"
#include "chinese_identity_display.dm"
#include "chinese_cleanable_display.dm"
#include "chinese_area_display.dm"
#include "chinese_cardboard_cutout_display.dm"
#include "chinese_id_card_display.dm"
#include "chinese_misc_display.dm"
#include "chinese_scar_display.dm"
#include "chinese_circuitboard_display.dm"
#include "chinese_crayon_display.dm"
#include "chinese_quirk_display.dm"
#include "chinese_template_display.dm"
#include "chinese_pupil_display.dm"
#include "chinese_pipe_paint_display.dm"
#include "chinese_accessory_display.dm"
#include "chinese_scanner_display.dm"
#include "chinese_machine_display.dm"
#include "chinese_telecomms_display.dm"

/proc/chinese_cqc_hit_display(hit_type)
	var/list/display_names = list("CQC" = "近身格斗术", "Big Boss" = "大首领式格斗术", "kick" = "踢击", "stomp" = "踩踏")
	return display_names[hit_type] || hit_type

/proc/chinese_batch_three_action_storage_name(value, action_type)
	if(ispath(action_type, /datum/action/swap_arts) && endswith(value, "/切换流派"))
		return "[chinese_action_storage_name(copytext_char(value, 1, -5), action_type)]/Swap Style"
	var/static/list/legacy_names
	if(!legacy_names)
		legacy_names = chinese_batch_three_action_names()
	return legacy_names[value] || chinese_batch_four_action_storage_name(value, action_type)

/proc/chinese_batch_three_action_names()
	return list(
		"开启远程视野" = "Activate Remote View",
		"切换隐身" = "Toggle Stealth",
		"释放控制权" = "Release Control",
		"扫描损坏灯具" = "Scan for broken lamps",
		"结束全息通话" = "End Holocall",
		"回顾基础招式" = "Remember the Basics",
		"回顾 CQC 基础" = "Remember The Basics",
		"专注拳击架势" = "Focus on your Form",
		"专注斗殴" = "Focus on Brawling",
		"专注狩猎" = "Focus on the Hunt",
		"回顾武学教诲" = "Recall Teachings",
		"劈颈" = "Neck Chop",
		"下段扫击" = "Low Sweep",
		"击肺拳" = "Lung Punch",
		"抱摔（需擒抱）——将抓住的对手摔向地面。" = "Slam (Cinch) - Slam a grappled opponent into the floor.",
		"旋转投掷（需擒抱）——抓住对手旋转后将其扔出。" = "Throw (Cinch) - Spin a cinched opponent around and throw them.",
		"踢击——将人踢飞的强力一脚，也适合用来脱离险境。" = "Kick - A powerful kick, sends people flying away from you. Also useful for escaping from bad situations.",
		"快攻——快速击打附近的对手。" = "Strike - Hit a neaby opponent with a quick attack.",
		"坠击——从上方重压对手。" = "Drop - Smash down onto an opponent.",
		"肾上腺素！" = "Adrenaline!",
		"读心" = "Mindread",
		"脱落肢体" = "Drop a limb",
		"制造积雪" = "Create Snow",
		"冰冻射线" = "Cryobeam",
		"远视" = "Farsight",
		"火焰吐息" = "Fire Breath",
		"制造灰烬" = "Create Ash",
		"炽热射线" = "Pyrobeam",
		"记住气味" = "Remember the Scent",
		"启用热成像视觉" = "Activate Thermal Vision",
		"发射舌刺" = "Launch spike",
		"发射化学舌刺" = "Launch chem spike",
		"输送化学物质" = "Transfer Chemicals",
		"电击之触" = "Shock Touch",
		"抚愈之触" = "Mending Touch",
		"唤起虚空" = "Invoke Void",
		"召集虚空" = "Convoke Void",
		"请求任务专用装备" = "Request Objective-specific Equipment",
		"结束监控视角" = "End Camera View",
		"跳转至摄像头" = "Jump To Camera",
		"上移一层" = "Move up a floor",
		"下移一层" = "Move down a floor",
		"喷墨" = "Spit Ink",
	)
