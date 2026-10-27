// Sabres, including the cargo variety

/obj/item/storage/belt/sheath/sabre/cargo
	name = "正宗波斯弯刀皮鞘"
	desc = "一个漂亮的刀鞘，广告称采用正宗金星黑色皮革制成。摸起来却很像塑料，而且看着像是给英国骑兵军刀用的。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	stored_blade = /obj/item/melee/sabre/cargo

/obj/item/melee/sabre
	force = 20 // Original: 15
	wound_bonus = 5 // Original: 10
	exposed_wound_bonus = 20 // Original: 25 Both down slightly, to make up for the damage buff, since it'd get a bit wacky ontop of the armor pen.

/obj/item/melee/sabre/cargo
	name = "正宗波斯弯刀"
	desc = "一把精工制作的人类古代刀剑，曾由波斯人使用，最近因金星的历史重演运动而流行起来。不过有个小问题：位于塔吉的生产商把它误认成了纳米传讯高官所用的那种英国骑兵军刀。至少砍起来一样！"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/melee.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/swords_righthand.dmi'
	block_chance = 20
	armour_penetration = 25
	force = 15

// NTC sabre

/obj/item/storage/belt/sheath/sabre/ntc_commander
	name = "顾问指挥官军刀鞘"
	desc = "授予纳米传讯官员的华丽刀鞘，以精致的绿色染色皮革和镀金装饰制成，刻有纳米传讯标志。它属于一个更优雅的时代，却依然致命。虽然不及舰长本人的军刀锋利，但它本身便散发着威严。持有它，就该明白自己的职责是震慑他人，而非随意参战。"
	icon = 'modular_zubbers/icons/obj/weapons/melee.dmi'
	icon_state = "cc-sheath"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	worn_icon_state = "cc-sheath"
	stored_blade = /obj/item/melee/sabre/ntc

/obj/item/storage/belt/sheath/sabre/ntc_admiral
	name = "顾问上将军刀鞘"
	desc = "授予纳米传讯官员的华丽刀鞘，以精致的黑色染色皮革和镀金装饰制成，刻有纳米传讯标志。它属于一个更优雅的时代，却依然致命。虽然不及舰长本人的军刀锋利，但它本身便散发着威严。持有它，就该明白自己的职责是震慑他人，而非随意参战。"
	icon = 'modular_zubbers/icons/obj/weapons/melee.dmi'
	icon_state = "admiral-sheath"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	worn_icon_state = "admiral-sheath"
	stored_blade = /obj/item/melee/sabre/ntc

/obj/item/melee/sabre/ntc
	name = "\improper 顾问军刀"
	desc = "一把优雅的军刀，与授予舰长的款式相似。镀金刀柄刻有纳米传讯标志，握柄整齐地裹着真皮。刀身在光下泛起波纹，抛光得近乎闪亮。弄脏如此美丽的刀刃似乎可惜，但这正是其用意之一。它用于威慑，而非真正的战斗。即便如此，它在近战中仍然相当可怕，只是不及授予舰长本人的军刀致命。"
	block_chance = 30
	armour_penetration = 25
	force = 20

/obj/item/melee/sabre/ntc/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以" + EXAMINE_HINT("仔细查看") + "以进一步了解[src]。"), \
			lore = "纳米传讯最早的贸易使节只携带公文包和合同，谈判失利的次数远超董事会所能容忍的程度。这些外交官外表与普通会计无异，却被派去和竞争企业、总督及经纪人同桌交涉。许多人归来时，已经接受了任何清醒的董事都不会同意的条款，原因仅仅是缺少一种能表明纳米传讯不可轻侮的东西。<br>\
使节和外交官需要一个象征，一件彰显其显贵身份的传承之物。因此，董事会委托纳米传讯兵工厂设计一件兼具必要威严与力量的器物。<br>\
<br>\
接下来是数月的反复修改。纳米传讯遍查早已让位于大规模生产的古老地球铸剑传统，最终选定了一种值得量产的设计，其灵感来自拿破仑时代骑兵和军官使用的军刀。刀身采用掺入钒和镍的高碳钢锻造，反复折叠层叠，形成金星人所谓的“大马士革钢”。镀金刀柄铸有轮廓鲜明的纳米传讯浮雕标志，并配以真皮握柄。<br>\
<br>\
这种武器仅授予表现卓著、由中央指挥部董事会任命的纳米传讯官员。刀柄尾端刻着持有者的员工识别号，在颁发时确定；根据公司规定，移除编号将导致持有者失去退休金。这一把尚未分配编号，也许你会成为赢得它的人……"\
	)

// Centcom sabre. This one is unimplemented, it only exists for fun. It's a Centcom Commander sword, so it's effectively admin-only, hence why it's so powerful.

/obj/item/storage/belt/sheath/sabre/centcom
	name = "\improper 指挥官军刀皮鞘"
	desc = "一个漂亮的绿色皮革刀鞘，带有纳米传讯标志。据说只有中央指挥部最高级别的官员才会获授这件武器。"
	icon = 'modular_zubbers/icons/obj/weapons/melee.dmi'
	icon_state = "cc-sheath"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	stored_blade = /obj/item/melee/sabre/centcom


/obj/item/melee/sabre/centcom
	name = "\improper 指挥官军刀"
	desc = "一把精美绝伦的刀剑，只授予中央指挥部最高级别的官员。刀身锋利轻巧，刀柄刻有纳米传讯标志。它象征着权威与力量，据说持有它的人既受尊敬，也令人畏惧。"
	block_chance = 75
	armour_penetration = 75
	force = 30

// This is here so that people can't buy the Sabres and craft them into powercrepes
/datum/crafting_recipe/food/powercrepe
	blacklist = list(
		/obj/item/melee/sabre/cargo,
		/obj/item/melee/sabre/ntc,
		/obj/item/melee/sabre/centcom,
	)

// Removing Assistant's bane from the cargo and ntc sabres
/obj/item/melee/sabre/cargo/Initialize(mapload)
	. = ..()
	var/list/bane_components = GetComponents(/datum/component/bane)
	QDEL_LIST(bane_components)

/obj/item/melee/sabre/ntc/Initialize(mapload)
	. = ..()
	var/list/bane_components = GetComponents(/datum/component/bane)
	QDEL_LIST(bane_components)
