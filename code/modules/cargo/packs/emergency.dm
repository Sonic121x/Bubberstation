/datum/supply_pack/emergency
	group = "Emergency"
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

/datum/supply_pack/emergency/bio
	name = "生物应急板条箱"
	desc = "这个板条箱包含 2 套完整的生物防护服，外加一盒无菌口罩和乳胶手套，可有效防护病毒。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/clothing/head/bio_hood/general = 2,
					/obj/item/clothing/suit/bio_suit/general = 2,
					/obj/item/storage/bag/bio,
					/obj/item/reagent_containers/syringe/antiviral = 2,
					/obj/item/clothing/gloves/latex/nitrile = 2,
					/obj/item/storage/box/masks,
					/obj/item/storage/box/gloves,
				)
	crate_name = "生物防护服箱"

/datum/supply_pack/emergency/equipment
	name = "应急机器人/呼吸装备板条箱"
	desc = "被爆炸搞得心情低落？这些物资保证能补好破洞， \
		无论是在空间站上还是在人身上！随附两台地板机器人、两台医疗机器人、五个氧气 \
		面罩和五个小型氧气罐。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/mob/living/basic/bot/medbot = 2,
		/mob/living/basic/bot/repairbot = 2,
		/obj/item/tank/internals/emergency_oxygen = 5,
		/obj/item/clothing/mask/breath = 5,
	)
	crate_name = "应急箱"
	crate_type = /obj/structure/closet/crate/internals

/datum/supply_pack/emergency/bomb
	name = "爆炸应急板条箱"
	desc = "科研部门发疯了？气闸后面有滴滴声？现在就购买，成为空间站应得…… \
		我是说需要的英雄！（不含时间）。包含一套防爆服与头罩、防毒面具和拆弹工具。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/clothing/head/utility/bomb_hood,
					/obj/item/clothing/suit/utility/bomb_suit,
					/obj/item/clothing/mask/gas,
					/obj/item/screwdriver,
					/obj/item/wirecutters,
					/obj/item/multitool,
				)
	crate_name = "防爆服箱"

/datum/supply_pack/emergency/firefighting
	name = "消防板条箱"
	desc = "只有你能预防空间站火灾。与两套消防服、防毒面具、 \
		手电筒、大型氧气罐、灭火器和安全帽搭档吧！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/clothing/suit/utility/fire/firefighter = 2,
					/obj/item/clothing/mask/gas = 2,
					/obj/item/flashlight = 2,
					/obj/item/tank/internals/oxygen/red = 2,
					/obj/item/extinguisher/advanced = 2,
					/obj/item/clothing/head/utility/hardhat/red = 2,
				)
	crate_name = "消防箱"

/datum/supply_pack/emergency/atmostank
	name = "消防水箱背包"
	desc = "用这个大容量消防水箱背包扫灭火焰。"
	cost = CARGO_CRATE_VALUE * 1.8
	access = ACCESS_ATMOSPHERICS
	contains = list(/obj/item/watertank/atmos)
	crate_name = "消防背包箱"
	crate_type = /obj/structure/closet/crate/secure/engineering/atmos

/datum/supply_pack/emergency/internals
	name = "呼吸装备板条箱"
	desc = "用三个呼吸面罩、 \
		三个应急氧气罐和三个大型空气罐，掌控你的生命能量，控制你的呼吸。" // IS THAT A
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/clothing/mask/gas = 3,
					/obj/item/clothing/mask/breath = 3,
					/obj/item/tank/internals/emergency_oxygen = 3,
					/obj/item/tank/internals/oxygen = 3,
				)
	crate_name = "呼吸装备箱"
	crate_type = /obj/structure/closet/crate/internals

/datum/supply_pack/emergency/metalfoam
	name = "金属泡沫手榴弹板条箱"
	desc = "用七枚金属泡沫手榴弹封住那些讨厌的船体破洞。"
	cost = CARGO_CRATE_VALUE * 2.4
	contains = list(/obj/item/storage/box/metalfoam)
	crate_name = "金属泡沫手榴弹箱"

/datum/supply_pack/emergency/plasma_spacesuit
	name = "等离子人太空环境服"
	desc = "包含两套可供等离子人使用的太空环境服。 \
		现在下单，我们还附赠两顶免费头盔！"
	cost = CARGO_CRATE_VALUE * 3.5
	access = ACCESS_EVA
	contains = list(/obj/item/clothing/suit/space/eva/plasmaman = 2,
					/obj/item/clothing/head/helmet/space/plasmaman = 2,
				)
	crate_name = "等离子人舱外活动箱"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/emergency/plasmaman
	name = "等离子人补给套件"
	desc = "用两套等离子人服装让等离子人活下去。 \
		每套包含一件等离子人连体服、手套、呼吸罐和头盔。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/clothing/under/plasmaman = 2,
					/obj/item/tank/internals/plasmaman/belt/full = 2,
					/obj/item/clothing/head/helmet/space/plasmaman = 2,
					/obj/item/clothing/gloves/color/plasmaman = 2,
				)
	crate_name = "等离子人补给套件"

/datum/supply_pack/emergency/radiation
	name = "辐射防护板条箱"
	desc = "无论是核末日还是超物质反应堆，两套辐射防护服都能让你活下来。 \
		每套包含一顶头盔、一件防护服和一个盖革计数器。考虑到订购此物之人的预期寿命， \
		我们甚至还附赠一瓶伏特加和几个杯子。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/clothing/head/utility/radiation = 2,
					/obj/item/clothing/suit/utility/radiation = 2,
					/obj/item/geiger_counter = 2,
					/obj/item/reagent_containers/cup/glass/bottle/vodka,
					/obj/item/reagent_containers/cup/glass/drinkingglass/shotglass = 2,
				)
	crate_name = "辐射防护箱"
	crate_type = /obj/structure/closet/crate/radiation

/datum/supply_pack/emergency/spacesuit
	name = "太空服板条箱"
	desc = "包含一套来自太空慈善商店的旧太空服和一个喷气背包。"
	cost = CARGO_CRATE_VALUE * 3
	access = ACCESS_EVA
	contains = list(/obj/item/clothing/suit/space,
					/obj/item/clothing/head/helmet/space,
					/obj/item/clothing/mask/breath,
					/obj/item/tank/jetpack/carbondioxide,
				)
	crate_name = "太空服箱"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/emergency/weedcontrol
	name = "除草板条箱"
	desc = "把那些入侵物种挡在外面。包含一把镰刀、皮革手套、防毒面具和两枚除草化学手榴弹。 \
		用于仙草时保修失效。"
	cost = CARGO_CRATE_VALUE * 2.5
	access = ACCESS_HYDROPONICS
	contains = list(/obj/item/scythe,
					/obj/item/clothing/gloves/botanic_leather,
					/obj/item/clothing/mask/gas,
					/obj/item/grenade/chem_grenade/antiweed = 2,
				)
	crate_name = "除草箱"
	crate_type = /obj/structure/closet/crate/secure/hydroponics

/datum/supply_pack/emergency/mothic_rations
	name = "蛾族盈余配给三连包"
	desc = "船员在挨饿？厨师在偷懒？用直接来自蛾族舰队的盈余配给包， \
		以勉强算得上食物的最低限度喂饱所有人！每包内含 3 小包，每小包 3 根。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/storage/box/mothic_rations = 3)
	crate_name = "盈余配给箱"
	crate_type = /obj/structure/closet/crate/cardboard/mothic
