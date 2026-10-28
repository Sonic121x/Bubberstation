/**
 * # Voucher Set
 *
 * A set consisting of a various equipment that can be then used as a reward for redeeming a voucher.
 *
 * See [Voucher Redeemer](/datum/element/voucher_redeemer) for where these sets are handled.
 */
/datum/voucher_set
	/// Required, Name of the set.
	var/name
	/// Optional, description of the set
	var/description
	/// Optional, Icon of the set. Defaults to first item if not set.
	var/icon
	/// Optional, Icon state of the set. Defaults to first item if not set.
	var/icon_state
	/// Required, List of items contained in the set
	var/list/atom/set_items
	/// Optional, what key to use for blackbox feedback. No data will be recorded if not set.
	var/blackbox_key

/datum/voucher_set/New()
	. = ..()
	if(!length(set_items))
		stack_trace("Voucher set [type] has no items set.")
		return
	if(isnull(icon))
		icon = initial(set_items[1].icon)
	if(isnull(icon_state))
		icon_state = initial(set_items[1].icon_state)
	if(isnull(name))
		stack_trace("Voucher set [type] has no name set.")

/datum/voucher_set/proc/spawn_set(atom/spawn_loc)
	for(var/item in set_items)
		new item(spawn_loc)

/datum/voucher_set/mining
	blackbox_key = "mining_voucher_redeemed"

/datum/voucher_set/mining/crusher_kit
	name = "动能粉碎器套装"
	description = "包含一台动能粉碎器、一个扩容袖珍氧气罐和一个袖珍灭火器。动能粉碎器是一种多用途近战采矿工具，既能采矿，也能对付当地生物，但除了最熟练和/或最想不开的矿工之外，别人很难用得顺手。"
	icon = 'icons/obj/mining.dmi'
	icon_state = "crusher"
	set_items = list(
		/obj/item/kinetic_crusher,
		/obj/item/extinguisher/mini,
		/obj/item/tank/internals/emergency_oxygen/engi,
	)

/datum/voucher_set/mining/extraction_kit
	name = "提取与救援套装"
	description = "包含一个富尔顿回收包和一个信标信号器，让你能通过“烛光”导航网络运输矿物、物品、尸体和自己。此外还免费附赠 30 枚导航信标。"
	icon = 'icons/obj/fulton.dmi'
	icon_state = "extraction_pack"
	set_items = list(
		/obj/item/extraction_pack/networked,
		/obj/item/fulton_core/networked,
		/obj/item/stack/candela_beacon/thirty,
	)

/datum/voucher_set/mining/resonator_kit
	name = "谐振器套装"
	description = "包含一台谐振器和一个袖珍灭火器。谐振器是一种手持装置，能生成小型能量场，能量场持续谐振直至引爆，将岩石崩碎。在低气压环境下它的伤害会提高。"
	icon = 'icons/obj/mining.dmi'
	icon_state = "resonator"
	set_items = list(
		/obj/item/resonator,
		/obj/item/extinguisher/mini,
	)

/datum/voucher_set/mining/survival_capsule
	name = "避难舱与探险者胸挂"
	description = "包含一件探险者胸挂，能让你携带更多采矿装备，里面还预先装有一枚备用避难舱。"
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "explorer1"
	set_items = list(
		/obj/item/storage/belt/mining/vendor,
	)

/datum/voucher_set/mining/minebot_kit
	name = "采矿机器人套装"
	description = "包含一只小小的采矿机器人伙伴，帮你储存矿石、猎杀野生生物。此外还配有一把升级版工业焊接工具（80u）、一顶焊接头盔，以及一个能让射击穿过采矿机器人的动能加速器改装套件。"
	icon = 'icons/mob/silicon/aibots.dmi'
	icon_state = "mining_drone"
	set_items = list(
		/mob/living/basic/mining_drone,
		/obj/item/weldingtool/hugetank,
		/obj/item/clothing/head/utility/welding,
		/obj/item/borg/upgrade/modkit/minebot_passthrough,
	)

/datum/voucher_set/mining/conscription_kit
	name = "采矿征召套件"
	description = "包含一整套全新的采矿入门装备，可供一名船员使用：原型动能加速器、求生刀、安保手电筒、探险服、介子扫描仪、自动采矿扫描仪、采矿挎包、防毒面具、采矿无线电密钥，以及一张带有基础采矿权限的特殊 ID 卡。"
	icon = 'icons/obj/storage/backpack.dmi'
	icon_state = "duffel-explorer"
	set_items = list(
		/obj/item/storage/backpack/duffelbag/mining_conscript,
	)

/datum/voucher_set/mining/punching_mitts
	name = "拳击手套"
	description = "包含一副拳击手套，让你能赤手空拳把周围的荒野打成一片碎石场。"
	icon = 'icons/obj/clothing/gloves.dmi'
	icon_state = "punch_mitts"
	set_items = list(
		/obj/item/clothing/gloves/fingerless/punch_mitts,
		/obj/item/clothing/head/cowboy,
	)
