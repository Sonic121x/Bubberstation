/datum/design/nanites
	name = "无"
	desc = "如果你看到此内容，请通知程序员。"
	id = DESIGN_ID_IGNORE
	build_type = NANITE_COMPILER
	construction_time = 50
	category = list()
	research_icon = 'modular_zubbers/icons/obj/devices/nanite_devices.dmi'
	research_icon_state = "nanite_program"
	var/program_type = /datum/nanite_program

////////////////////UTILITY NANITES//////////////////////////////////////

/datum/design/nanites/metabolic_synthesis
	name = "代谢合成"
	desc = "纳米机器人利用宿主的代谢循环来加速自身复制，并将多余营养作为燃料。"
	id = "metabolic_nanites"
	program_type = /datum/nanite_program/metabolic_synthesis
	category = list("Utility Nanites")

/datum/design/nanites/viral
	name = "病毒复制体"
	desc = "纳米机器人持续发送加密信号，试图强行将自身程序复制到其他纳米机器人集群中。"
	id = "viral_nanites"
	program_type = /datum/nanite_program/viral
	category = list("Utility Nanites")

/datum/design/nanites/monitoring
	name = "监测"
	desc = "纳米机器人监测宿主的生命体征与位置，并将其发送至服装传感器网络。"
	id = "monitoring_nanites"
	program_type = /datum/nanite_program/monitoring
	category = list("Utility Nanites")

/datum/design/nanites/self_scan
	name = "宿主扫描"
	desc = "纳米机器人向宿主显示详细的身体扫描读数。"
	id = "selfscan_nanites"
	program_type = /datum/nanite_program/self_scan
	category = list("Utility Nanites")

/datum/design/nanites/dermal_button
	name = "真皮按钮"
	desc = "在宿主皮肤上显示一个按钮，可用于向纳米机器人发送信号。"
	id = "dermal_button_nanites"
	program_type = /datum/nanite_program/dermal_button
	category = list("Utility Nanites")

/datum/design/nanites/stealth
	name = "隐形"
	desc = "纳米机器人对表面扫描隐藏其活动与程序。"
	id = "stealth_nanites"
	program_type = /datum/nanite_program/stealth
	category = list("Utility Nanites")

/datum/design/nanites/nanite_debugging
	name = "纳米机器人调试"
	desc = "启用纳米机器人中各种高开销诊断功能，使其能将程序列表传送给便携扫描仪。 \
	这样做会消耗一些能量，略微降低其复制速度。"
	id = "debugging_nanites"
	program_type = /datum/nanite_program/nanite_debugging
	category = list("Utility Nanites")

/*
/datum/design/nanites/access
	name = "Subdermal ID"
	desc = "The nanites store the host's ID access rights in a subdermal magnetic strip. Updates when triggered, copying the host's current access."
	id = "access_nanites"
	program_type = /datum/nanite_program/access
	category = list("Utility Nanites")
*/

/datum/design/nanites/relay
	name = "中继"
	desc = "纳米机器人接收并中继远程纳米机器人信号。"
	id = "relay_nanites"
	program_type = /datum/nanite_program/relay
	category = list("Utility Nanites")

/datum/design/nanites/repeater
	name = "信号中继器"
	desc = "触发时向纳米机器人发送另一个信号，可选延迟。"
	id = "repeater_nanites"
	program_type = /datum/nanite_program/sensor/repeat
	category = list("Utility Nanites")

/datum/design/nanites/relay_repeater
	name = "中继信号中继器"
	desc = "触发时向中继频道发送另一个信号，可选延迟。"
	id = "relay_repeater_nanites"
	program_type = /datum/nanite_program/sensor/relay_repeat
	category = list("Utility Nanites")

/datum/design/nanites/emp
	name = "电磁共振"
	desc = "触发时，纳米机器人在宿主周围产生电磁脉冲。会破坏其他纳米机器人程序！"
	id = "emp_nanites"
	program_type = /datum/nanite_program/emp
	category = list("Utility Nanites")

/*
/datum/design/nanites/spreading
	name = "Infective Exo-Locomotion"
	desc = "The nanites gain the ability to survive for brief periods outside of the human body, as well as the ability to start new colonies without an integration process; \
			resulting in an extremely infective strain of nanites."
	id = "spreading_nanites"
	program_type = /datum/nanite_program/spreading
	category = list("Utility Nanites")
*/

/datum/design/nanites/nanite_sting
	name = "纳米机器人刺针"
	desc = "触发时，投射一根几乎不可见的纳米机器人尖刺，试图用宿主纳米机器人集群的副本感染附近的非宿主。"
	id = "nanite_sting_nanites"
	program_type = /datum/nanite_program/nanite_sting
	category = list("Utility Nanites")

/datum/design/nanites/mitosis
	name = "有丝分裂"
	desc = "纳米机器人获得自我复制能力，利用蓝空间为过程供能，而不再依赖模板。这会大幅加快复制速度，\
			但偶尔会因副本出错而产生软件错误。"
	id = "mitosis_nanites"
	program_type = /datum/nanite_program/mitosis
	category = list("Utility Nanites")

////////////////////MEDICAL NANITES//////////////////////////////////////
/datum/design/nanites/regenerative
	name = "加速再生"
	desc = "纳米机器人增强宿主的自然再生能力，提高其愈合速度。"
	id = "regenerative_nanites"
	program_type = /datum/nanite_program/regenerative
	category = list("Medical Nanites")

/*
/datum/design/nanites/regenerative_advanced
	name = "Bio-Reconstruction"
	desc = "The nanites manually repair and replace organic cells, acting much faster than normal regeneration. \
			However, this program cannot detect the difference between harmed and unharmed, causing it to consume nanites even if it has no effect."
	id = "regenerative_plus_nanites"
	program_type = /datum/nanite_program/regenerative/advanced
	category = list("Medical Nanites")
*/

/datum/design/nanites/temperature
	name = "体温调节"
	desc = "纳米机器人将宿主体温调整至理想水平。"
	id = "temperature_nanites"
	program_type = /datum/nanite_program/temperature
	category = list("Medical Nanites")

/datum/design/nanites/purging
	name = "血液净化"
	desc = "纳米机器人清除宿主血液中的毒素与化学物质。"
	id = "purging_nanites"
	program_type = /datum/nanite_program/purging
	category = list("Medical Nanites")

/datum/design/nanites/purging_advanced
	name = "选择性血液净化"
	desc = "纳米机器人清除宿主血液中的毒素与危险化学物质，同时忽略有益化学物质。 \
			分析这些化学物质所需的额外算力会大幅增加纳米机器人消耗速率。"
	id = "purging_plus_nanites"
	program_type = /datum/nanite_program/purging/advanced
	category = list("Medical Nanites")

/datum/design/nanites/brain_heal
	name = "神经再生"
	desc = "纳米机器人修复宿主大脑中的神经连接，逆转脑损伤与轻微创伤。"
	id = "brainheal_nanites"
	program_type = /datum/nanite_program/brain_heal
	category = list("Medical Nanites")

/datum/design/nanites/brain_heal_advanced
	name = "神经重塑"
	desc = "纳米机器人能够备份并恢复宿主的神经连接，有可能替换大块缺失或受损的脑组织。"
	id = "brainheal_plus_nanites"
	program_type = /datum/nanite_program/brain_heal_advanced
	category = list("Medical Nanites")

/datum/design/nanites/blood_restoring
	name = "血液再生"
	desc = "纳米机器人刺激并促进宿主的血细胞生成。"
	id = "bloodheal_nanites"
	program_type = /datum/nanite_program/blood_restoring
	category = list("Medical Nanites")

/datum/design/nanites/repairing
	name = "机械修复"
	desc = "纳米机器人修复宿主机械肢体的损伤。"
	id = "repairing_nanites"
	program_type = /datum/nanite_program/regenerative/robotic
	category = list("Medical Nanites")

/datum/design/nanites/defib
	name = "除颤"
	desc = "触发时，纳米机器人向宿主心脏发送除颤电击。"
	id = "defib_nanites"
	program_type = /datum/nanite_program/defib
	category = list("Medical Nanites")


////////////////////AUGMENTATION NANITES//////////////////////////////////////

/datum/design/nanites/nervous
	name = "神经支持"
	desc = "纳米机器人充当辅助神经系统，缩短宿主被击晕的时间。"
	id = "nervous_nanites"
	program_type = /datum/nanite_program/nervous
	category = list("Augmentation Nanites")

/datum/design/nanites/hardening
	name = "真皮硬化"
	desc = "纳米机器人在宿主皮肤下形成网层，保护其免受近战与子弹冲击。"
	id = "hardening_nanites"
	program_type = /datum/nanite_program/dermal_armor
	category = list("Augmentation Nanites")

/datum/design/nanites/refractive
	name = "真皮折射表层"
	desc = "纳米机器人在宿主皮肤上方形成薄膜，削弱激光与能量冲击的效果。"
	id = "refractive_nanites"
	program_type = /datum/nanite_program/dermal_armor/refractive
	category = list("Augmentation Nanites")

/datum/design/nanites/coagulating
	name = "静脉增压"
	desc = "纳米机器人将循环血液从开放性伤口改道，大幅降低出血速度。"
	id = "coagulating_nanites"
	program_type = /datum/nanite_program/coagulating
	category = list("Augmentation Nanites")

/datum/design/nanites/conductive
	name = "电流传导"
	desc = "纳米机器人充当电击的接地棒，保护宿主。电击仍可能损伤纳米机器人本身。"
	id = "conductive_nanites"
	program_type = /datum/nanite_program/conductive
	category = list("Augmentation Nanites")

/datum/design/nanites/mindshield
	name = "精神屏障"
	desc = "纳米机器人激活期间会在宿主大脑周围形成保护膜，屏蔽异常影响。"
	id = "mindshield_nanites"
	program_type = /datum/nanite_program/mindshield
	category = list("Augmentation Nanites")

////////////////////DEFECTIVE NANITES//////////////////////////////////////

/*
/datum/design/nanites/glitch
	name = "Glitch"
	desc = "A heavy software corruption that causes nanites to gradually break down."
	id = "glitch_nanites"
	program_type = /datum/nanite_program/glitch
	category = list("Defective Nanites")

/datum/design/nanites/necrotic
	name = "Necrosis"
	desc = "The nanites attack internal tissues indiscriminately, causing widespread damage."
	id = "necrotic_nanites"
	program_type = /datum/nanite_program/necrotic
	category = list("Defective Nanites")

/datum/design/nanites/toxic
	name = "Toxin Buildup"
	desc = "The nanites cause a slow but constant toxin buildup inside the host."
	id = "toxic_nanites"
	program_type = /datum/nanite_program/toxic
	category = list("Defective Nanites")

/datum/design/nanites/suffocating
	name = "Hypoxemia"
	desc = "The nanites prevent the host's blood from absorbing oxygen efficiently."
	id = "suffocating_nanites"
	program_type = /datum/nanite_program/suffocating
	category = list("Defective Nanites")

/datum/design/nanites/brain_misfire
	name = "Brain Misfire"
	desc = "The nanites interfere with neural pathways, causing minor psychological disturbances."
	id = "brainmisfire_nanites"
	program_type = /datum/nanite_program/brain_misfire
	category = list("Defective Nanites")

/datum/design/nanites/skin_decay
	name = "Dermalysis"
	desc = "The nanites attack skin cells, causing irritation, rashes, and minor damage."
	id = "skindecay_nanites"
	program_type = /datum/nanite_program/skin_decay
	category = list("Defective Nanites")

/datum/design/nanites/nerve_decay
	name = "Nerve Decay"
	desc = "The nanites attack the host's nerves, causing lack of coordination and short bursts of paralysis."
	id = "nervedecay_nanites"
	program_type = /datum/nanite_program/nerve_decay
	category = list("Defective Nanites")

/datum/design/nanites/brain_decay
	name = "Brain-Eating Nanites"
	desc = "Damages brain cells, gradually decreasing the host's cognitive functions."
	id = "braindecay_nanites"
	program_type = /datum/nanite_program/brain_decay
	category = list("Defective Nanites")
*/

////////////////////WEAPONIZED NANITES/////////////////////////////////////

/datum/design/nanites/flesh_eating
	name = "细胞崩解"
	desc = "纳米机器人破坏宿主体内的细胞结构，造成钝器伤害。"
	id = "flesheating_nanites"
	program_type = /datum/nanite_program/flesh_eating
	category = list("Weaponized Nanites")

/datum/design/nanites/poison
	name = "中毒"
	desc = "纳米机器人向宿主内脏输送有毒化学物质，造成毒素伤害与呕吐。"
	id = "poison_nanites"
	program_type = /datum/nanite_program/poison
	category = list("Weaponized Nanites")

/datum/design/nanites/memory_leak
	name = "内存泄漏"
	desc = "该程序侵入其他程序使用的内存空间，导致频繁损坏与错误。"
	id = "memleak_nanites"
	program_type = /datum/nanite_program/memory_leak
	category = list("Weaponized Nanites")

/datum/design/nanites/aggressive_replication
	name = "侵略性复制"
	desc = "纳米机器人会消耗有机物来提高复制速度，对宿主造成伤害。"
	id = "aggressive_nanites"
	program_type = /datum/nanite_program/aggressive_replication
	category = list("Weaponized Nanites")

/datum/design/nanites/meltdown
	name = "熔毁"
	desc = "引发纳米机器人内部熔毁，在宿主体内造成内烧伤，并迅速摧毁纳米机器人种群。\
			激活时将纳米机器人的安全阈值设为 0。"
	id = "meltdown_nanites"
	program_type = /datum/nanite_program/meltdown
	category = list("Weaponized Nanites")

/datum/design/nanites/cryo
	name = "低温治疗"
	desc = "纳米机器人迅速通过宿主皮肤散发热量，降低其体温。"
	id = "cryo_nanites"
	program_type = /datum/nanite_program/cryo
	category = list("Weaponized Nanites")

/datum/design/nanites/pyro
	name = "皮下燃烧"
	desc = "纳米机器人在宿主皮肤下积聚易燃液体，然后将其点燃。"
	id = "pyro_nanites"
	program_type = /datum/nanite_program/pyro
	category = list("Weaponized Nanites")

/*
/datum/design/nanites/heart_stop
	name = "Heart-Stopper"
	desc = "Stops the host's heart when triggered; restarts it if triggered again."
	id = "heartstop_nanites"
	program_type = /datum/nanite_program/heart_stop
	category = list("Weaponized Nanites")

/datum/design/nanites/explosive
	name = "Chain Detonation"
	desc = "Blows up all the nanites inside the host in a chain reaction when triggered."
	id = "explosive_nanites"
	program_type = /datum/nanite_program/explosive
	category = list("Weaponized Nanites")
*/

/datum/design/nanites/mind_control
	name = "精神控制"
	desc = "纳米机器人激活期间，向宿主大脑烙印一条绝对指令。"
	id = "mindcontrol_nanites"
	program_type = /datum/nanite_program/comm/mind_control
	category = list("Weaponized Nanites")

////////////////////SUPPRESSION NANITES//////////////////////////////////////

/datum/design/nanites/shock
	name = "电击"
	desc = "触发时，纳米机器人电击宿主。会摧毁大量纳米机器人！"
	id = "shock_nanites"
	program_type = /datum/nanite_program/shocking
	category = list("Suppression Nanites")

/datum/design/nanites/stun
	name = "神经电击"
	desc = "触发时，纳米机器人向宿主神经发送脉冲，使其短暂失去行动能力。"
	id = "stun_nanites"
	program_type = /datum/nanite_program/stun
	category = list("Suppression Nanites")

/datum/design/nanites/sleepy
	name = "睡眠诱导"
	desc = "触发时，纳米机器人引发快速发作性睡病。"
	id = "sleep_nanites"
	program_type = /datum/nanite_program/sleepy
	category = list("Suppression Nanites")

/datum/design/nanites/paralyzing
	name = "麻痹"
	desc = "纳米机器人主动抑制神经脉冲，使宿主有效瘫痪。"
	id = "paralyzing_nanites"
	program_type = /datum/nanite_program/paralyzing
	category = list("Suppression Nanites")

/datum/design/nanites/fake_death
	name = "死亡模拟"
	desc = "纳米机器人使宿主进入类似死亡的昏迷，能够骗过大多数医疗扫描。"
	id = "fakedeath_nanites"
	program_type = /datum/nanite_program/fake_death
	category = list("Suppression Nanites")

/datum/design/nanites/pacifying
	name = "安抚"
	desc = "纳米机器人抑制大脑的攻击中枢，阻止宿主直接伤害他人。"
	id = "pacifying_nanites"
	program_type = /datum/nanite_program/pacifying
	category = list("Suppression Nanites")

/datum/design/nanites/blinding
	name = "失明"
	desc = "纳米机器人抑制宿主的眼部神经，在其激活期间使其失明。"
	id = "blinding_nanites"
	program_type = /datum/nanite_program/blinding
	category = list("Suppression Nanites")

/datum/design/nanites/mute
	name = "沉默"
	desc = "纳米机器人抑制宿主的言语能力，在其激活期间使其无法说话。"
	id = "mute_nanites"
	program_type = /datum/nanite_program/mute
	category = list("Suppression Nanites")

/datum/design/nanites/voice
	name = "颅骨回响"
	desc = "纳米机器人在宿主颅骨内回响一条合成讯息。"
	id = "voice_nanites"
	program_type = /datum/nanite_program/comm/voice
	category = list("Suppression Nanites")

/*
/datum/design/nanites/speech
	name = "Forced Speech"
	desc = "The nanites force the host to say a pre-programmed sentence when triggered."
	id = "speech_nanites"
	program_type = /datum/nanite_program/comm/speech
	category = list("Suppression Nanites")
*/

/datum/design/nanites/hallucination
	name = "幻觉"
	desc = "纳米机器人使宿主看到并听到不存在的事物。"
	id = "hallucination_nanites"
	program_type = /datum/nanite_program/comm/hallucination
	category = list("Suppression Nanites")

/datum/design/nanites/good_mood
	name = "快乐增强器"
	desc = "纳米机器人在宿主大脑内合成血清素，制造人为的幸福感。"
	id = "good_mood_nanites"
	program_type = /datum/nanite_program/mood
	category = list("Suppression Nanites")

/datum/design/nanites/bad_mood
	name = "快乐抑制器"
	desc = "纳米机器人抑制宿主大脑内血清素的产生，制造人为的抑郁状态。"
	id = "bad_mood_nanites"
	program_type = /datum/nanite_program/mood/bad
	category = list("Suppression Nanites")

////////////////////SENSOR NANITES//////////////////////////////////////

/datum/design/nanites/sensor_health
	name = "生命体征传感器"
	desc = "当宿主生命值高于或低于某一百分比时，纳米机器人会收到信号。"
	id = "sensor_health_nanites"
	program_type = /datum/nanite_program/sensor/health
	category = list("Sensor Nanites")

/datum/design/nanites/sensor_damage
	name = "伤害传感器"
	desc = "当宿主的特定伤害类型高于或低于目标值时，纳米机器人会收到信号。"
	id = "sensor_damage_nanites"
	program_type = /datum/nanite_program/sensor/damage
	category = list("Sensor Nanites")

/datum/design/nanites/sensor_crit
	name = "危重生命体征传感器"
	desc = "当宿主首次进入危重状态时，纳米机器人会收到信号。"
	id = "sensor_crit_nanites"
	program_type = /datum/nanite_program/sensor/crit
	category = list("Sensor Nanites")

/datum/design/nanites/sensor_death
	name = "死亡传感器"
	desc = "当纳米机器人检测到宿主死亡时，会收到信号。"
	id = "sensor_death_nanites"
	program_type = /datum/nanite_program/sensor/death
	category = list("Sensor Nanites")

/datum/design/nanites/sensor_voice
	name = "声音传感器"
	desc = "当纳米机器人听到指定词语或句子时发送信号。"
	id = "sensor_voice_nanites"
	program_type = /datum/nanite_program/sensor/voice
	category = list("Sensor Nanites")

/datum/design/nanites/sensor_nanite_volume
	name = "纳米机器人容量传感器"
	desc = "当纳米机器人储量高于或低于某一百分比时，纳米机器人会收到信号。"
	id = "sensor_nanite_volume"
	program_type = /datum/nanite_program/sensor/nanite_volume
	category = list("Sensor Nanites")

/datum/design/nanites/sensor_species
	name = "物种传感器"
	desc = "触发时，纳米机器人扫描宿主以确定其物种，并根据设置中的条件输出信号。"
	id = "sensor_species_nanites"
	program_type = /datum/nanite_program/sensor/species
	category = list("Sensor Nanites")

////////////////////NANITE PROTOCOLS//////////////////////////////////////
//Note about the category name: The UI cuts the last 8 characters from the category name to remove the " Nanites" in the other categories
//Because of this, Protocols was getting cut down to "P", so i had to add some padding
/datum/design/nanites/kickstart
	name = "启动协议"
	desc = "复制协议：纳米机器人专注于早期增长，在初次植入后的几分钟内大幅提高复制速度。"
	id = "kickstart_nanites"
	program_type = /datum/nanite_program/protocol/kickstart
	category = list("Protocols_Nanites")

/datum/design/nanites/factory
	name = "工厂协议"
	desc = "复制协议：纳米机器人在宿主体内建立工厂矩阵，随着时间逐渐提高复制速度。若协议未激活，工厂会衰退。"
	id = "factory_nanites"
	program_type = /datum/nanite_program/protocol/factory
	category = list("Protocols_Nanites")

/datum/design/nanites/pyramid
	name = "金字塔协议"
	desc = "复制协议：纳米机器人采用另一种协作复制协议，只要饱和度高于 80% 就更高效。"
	id = "pyramid_nanites"
	program_type = /datum/nanite_program/protocol/pyramid
	category = list("Protocols_Nanites")

/datum/design/nanites/offline
	name = "日蚀协议"
	desc = "复制协议：当宿主睡着或处于其他无意识状态时，纳米机器人利用干扰减少的时机更快复制。"
	id = "offline_nanites"
	program_type = /datum/nanite_program/protocol/offline
	category = list("Protocols_Nanites")

/datum/design/nanites/hive
	name = "蜂巢协议"
	desc = "存储协议：纳米机器人采用更高效的网格排列进行容量存储，提高宿主的容量上限。"
	id = "hive_nanites"
	program_type = /datum/nanite_program/protocol/hive
	category = list("Protocols_Nanites")

/datum/design/nanites/zip
	name = "压缩协议"
	desc = "存储协议：纳米机器人闲置时会被拆解并压缩，在宿主体内时大幅提高容量上限。不过，该过程会略微降低复制速度。"
	id = "zip_nanites"
	program_type = /datum/nanite_program/protocol/zip
	category = list("Protocols_Nanites")

/datum/design/nanites/free_range
	name = "自由放养协议"
	desc = "存储协议：纳米机器人放弃默认存储协议，改用更廉价、更有机的方式。降低容量上限，但提高复制速度。"
	id = "free_range_nanites"
	program_type = /datum/nanite_program/protocol/free_range
	category = list("Protocols_Nanites")

/datum/design/nanites/unsafe_storage
	name = "S.L.O. 协议"
	desc = "存储协议：“S.L.O.P.”，即存储等级覆盖协议，会完全禁用纳米机器人通常具备的安全措施，\
		使其能达到高得多的饱和度，但有对宿主造成内部损伤的风险。"
	id = "unsafe_storage_nanites"
	program_type = /datum/nanite_program/protocol/unsafe_storage
	category = list("Protocols_Nanites")
