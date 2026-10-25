// This is a typepath to just sit in baseturfs and act as a marker for other things.
/turf/baseturf_skipover
	name = "基础地形跳过占位符"
	desc = "这东西不应该存在"

/turf/baseturf_skipover/Initialize(mapload)
	. = ..()
	stack_trace("[src]([type]) was instanced which should never happen. Changing into the next baseturf down...")
	ScrapeAway()

/turf/baseturf_skipover/shuttle
	name = "穿梭机基础地形跳过占位符"
	desc = "充当穿梭机底部；若它不存在，穿梭机地板就会被击穿。"

/turf/baseturf_skipover/trapdoor
	name = "活板门基础地形跳过占位符"
	desc = "充当受活板门影响的一叠基础地形的最底层。"

/turf/baseturf_bottom
	name = "Z 层基础地形占位符"
	desc = "Z 层基础地形的标记，通常会解析为太空。"
	baseturfs = /turf/baseturf_bottom
