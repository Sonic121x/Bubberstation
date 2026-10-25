/datum/round_event_control/mice_migration
	name = "老鼠迁徙"
	typepath = /datum/round_event/mice_migration
	weight = 10
	category = EVENT_CATEGORY_ENTITIES
	description = "一大群老鼠到来，甚至可能还有鼠王本人。"

/datum/round_event/mice_migration
	var/minimum_mice = 5
	var/maximum_mice = 15

/datum/round_event/mice_migration/announce(fake)
	var/cause = pick("太空寒冬", "预算削减", "诸神黄昏",
		"太空太冷", "\[已涂黑\]", "气候变化",
		"运气不好")
	var/plural = pick("若干", "一大群", "一群", "一大批",
		"一小撮", "数量不超过 [maximum_mice] 只的")
	var/name = pick("啮齿动物", "老鼠", "吱吱叫的东西",
		"啃电线的哺乳动物", "\[已涂黑\]", "吸取能量的寄生虫")
	var/movement = pick("迁徙进", "蜂拥进", "奔踏进", "降临到")
	var/location = pick("维修隧道", "维修区域",
		"\[已涂黑\]", "布满美味线缆的地方")

	priority_announce("由于[cause]，[plural][name][movement] \
		[location]。", "迁徙警报",
		'sound/mobs/non-humanoids/mouse/mousesqueek.ogg')

/datum/round_event/mice_migration/start()
	SSminor_mapping.trigger_migration(rand(minimum_mice, maximum_mice))
