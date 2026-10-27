// crashedship / survey ship

//Areas

/area/awaymission/bmpship
	name = "BMP 小行星带"
	icon_state = "away"


/area/awaymission/bmpship/aft
	name = "后部区块"
	icon_state = "away1"
	requires_power = TRUE

/area/awaymission/bmpship/midship
	name = "中段区块"
	icon_state = "away2"
	requires_power = TRUE

/area/awaymission/bmpship/fore
	name = "前部区块"
	icon_state = "away3"
	requires_power = TRUE

// crashedship corpse

/obj/effect/mob_spawn/corpse/human/laborer
	name = "坠毁勘测船劳工"
	outfit = /datum/outfit/survey_laborer

/datum/outfit/survey_laborer
	name = "Crashed Survey Ship Laborer"
	uniform = /obj/item/clothing/under/misc/overalls
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/color/fyellow
	head = /obj/item/clothing/head/utility/hardhat
	r_pocket = /obj/item/paper/fluff/ruins/crashedship/old_diary
	l_pocket = /obj/item/stack/spacecash/c200
	mask = /obj/item/clothing/mask/breath
	belt = /obj/item/tank/internals/emergency_oxygen/engi

// crashedship items

/obj/item/paper/fluff/ruins/crashedship/scribbled
	name = "潦草的便条"
	default_raw_text = "下一个拿我螺丝刀的人，我就用螺丝刀捅他。它们是我的。——爱你们的，马德森"

/obj/item/paper/fluff/ruins/crashedship/captains_log
	name = "舰长日志条目"
	default_raw_text = "这绝对是我接过最无聊的任务。要勘测的行星我们大概走了一半，其中大多数都是没有生命的石头。话虽如此，下一颗行星看起来很有希望。 \
	打恶魔总比打发无聊强！"

/obj/item/paper/fluff/ruins/crashedship/old_diary
	name = "旧日记"
	default_raw_text = "亲爱的日记：我们当时正在前往某颗熔岩行星勘测，据说那里真住着恶魔，结果我们的驾驶员把船一头撞进了他能找到的最大的太空岩石里。 \
	也许他把那套地狱星球的说法太当真了。我当时正在应急物资柜里打盹，所以不清楚细节。我确实从门缝往外瞄了一眼，看到整个工程舱段都没了。 \
	这里的灯用不了多久就会把电耗光，我想我应该能赶到传送室，而不至于被吸进太空。如果我没能成功，把我的东西捐给慈善机构。"

