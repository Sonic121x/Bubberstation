#define SPELLBOOK_CATEGORY_DEFENSIVE "防御"
// Defensive wizard spells
/datum/spellbook_entry/magicm
	name = "魔法飞弹"
	desc = "向附近目标射出数枚缓慢飞行的魔法弹。"
	spell_type = /datum/action/cooldown/spell/aoe/magic_missile
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/disabletech
	name = "禁用科技"
	desc = "使范围内的所有武器、摄像头以及大多数其他科技设备失效。"
	spell_type = /datum/action/cooldown/spell/emp/disable_tech
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	cost = 1

/datum/spellbook_entry/repulse
	name = "斥退"
	desc = "将使用者周围的一切都抛飞出去。"
	spell_type = /datum/action/cooldown/spell/aoe/repulse/wizard
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/lightning_packet
	name = "投掷闪电"
	desc = "由邪异能量锻造而成，一包名为法术包的纯粹力量，\
		会出现在你手中，投掷出去便可击晕目标。"
	spell_type = /datum/action/cooldown/spell/conjure_item/spellpacket
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/timestop
	name = "时间停止"
	desc = "除你之外的所有人都被时间停止，使你能自由移动，\
		而你的敌人甚至飞射的弹道都被冻结。"
	spell_type = /datum/action/cooldown/spell/timestop
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/smoke
	name = "烟雾"
	desc = "在你所在的位置生成一团令人窒息的烟雾。"
	spell_type = /datum/action/cooldown/spell/smoke
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	cost = 1

/datum/spellbook_entry/forcewall
	name = "力场墙"
	desc = "创造一道只有你能穿过的魔法屏障。"
	spell_type = /datum/action/cooldown/spell/forcewall
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	cost = 1

/datum/spellbook_entry/lichdom
	name = "缚魂"
	desc = "一份黑暗的死灵契约，能将你的灵魂永久束缚于一件你选定的物品中，\
		把你变成不朽的巫妖。只要该物品完好无损，无论境况如何，你都会从死亡中复活。\
		但要小心——每一次复活，你的身体都会变得更虚弱，\
		别人也会更容易找到你的力量物品。"
	spell_type =  /datum/action/cooldown/spell/lichdom
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	no_coexistence_typecache = list(/datum/action/cooldown/spell/splattercasting, /datum/spellbook_entry/perks/wormborn, /datum/spellbook_entry/ghostliness)

/datum/spellbook_entry/chuunibyou
	name = "中二咏唱"
	desc = "让你所有法术都大声咏唱，而咏唱内容会变得……很蠢。施放法术后你会略微恢复。"
	spell_type =  /datum/action/cooldown/spell/chuuni_invocations
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/spacetime_dist
	name = "时空扭曲"
	desc = "将你周围区域的时空之线缠结在一起，\
		打乱空间布局，使正常行走成为不可能。这些线在颤动……"
	spell_type = /datum/action/cooldown/spell/spacetime_dist
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	cost = 1

/datum/spellbook_entry/the_traps
	name = "陷阱！"
	desc = "在你周围召唤若干陷阱。踩到陷阱的敌人会受到伤害并被激怒。"
	spell_type = /datum/action/cooldown/spell/conjure/the_traps
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	cost = 1

/datum/spellbook_entry/bees
	name = "次级召唤蜜蜂"
	desc = "这个法术以魔法之力踢了一脚跨维度蜂巢，\
		瞬间在你所在处召唤出一群蜜蜂。这些蜜蜂对任何人都绝不友好。"
	spell_type = /datum/action/cooldown/spell/conjure/bee
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/duffelbag
	name = "赐予诅咒行李袋"
	desc = "一个恶咒，将一个恶魔行李袋牢牢固定在目标背上。\
		如果不定期喂食，行李袋会周期性地对背负者造成伤害，\
		而且无论是否被喂食，\
		它都会让穿戴者行动明显迟缓。"
	spell_type = /datum/action/cooldown/spell/touch/duffelbag
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	cost = 1

/datum/spellbook_entry/item/staffhealing
	name = "治疗法杖"
	desc = "一根利他的法杖，能治愈瘸子，也能使死者复生。"
	item_path = /obj/item/gun/magic/staff/healing
	cost = 1
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/item/lockerstaff
	name = "储物柜法杖"
	desc = "一根能射出储物柜的法杖。它会把沿途撞到的人吞进去，只留下一个焊死的储物柜，里面装着你的受害者。"
	item_path = /obj/item/gun/magic/staff/locker
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/item/scryingorb
	name = "窥视宝珠"
	desc = "一颗噼啪放电的白炽宝珠。使用它可以让你的幽灵在活着时离体，从而窥探空间站并与亡者交谈。此外，购买它还会永久赋予你 X 射线视觉。"
	item_path = /obj/item/scrying
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/item/wands
	name = "魔杖组合"
	desc = "一套用途广泛的魔杖。\
		魔杖的充能次数有限，使用时要节省。\
		装在一条便利的腰带上，如果你已系着腰带，则换成一个精美的弹药带。"
	item_path = /obj/item/storage/belt/wands/full
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/item/wands/try_equip_item(mob/living/carbon/human/user, obj/item/to_equip)
	if (!istype(user.belt, /obj/item/storage/belt/wands))
		var/was_equipped = user.equip_to_slot_if_possible(to_equip, ITEM_SLOT_BELT, disable_warning = TRUE)
		to_chat(user, span_notice("\A [to_equip.name] 已被召唤，[was_equipped ? "挂在你腰间" : "落在你脚下"]。"))
		return

	// If you already have a wand belt you get a cool bandolier instead for your copious amount of wands
	var/obj/item/storage/belt/wand_bandolier/bandolier = new(user.drop_location())

	for (var/obj/item/wand_presumably in to_equip.atom_storage.real_location)
		bandolier.atom_storage.attempt_insert(wand_presumably, user, messages = FALSE)

	qdel(to_equip)

	var/was_equipped = user.equip_to_slot_if_possible(bandolier, ITEM_SLOT_SUITSTORE, disable_warning = TRUE)
	to_chat(user, span_notice("\A [bandolier.name] 已被召唤，[was_equipped ? "斜挎在你胸前" : "落在你脚下"]。"))

/datum/spellbook_entry/item/wands/discount
	name = "魔杖组合（打折货）"
	desc = "一批来自学徒魔杖制作课程的随机魔杖。\
		你永远不太确定会拿到什么。\
		装在一条便利的腰带上，如果你已系着腰带，则换成一个精美的弹药带。"
	cost = 1
	item_path = /obj/item/storage/belt/wands/full/discount
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/item/armor
	name = "大师级护甲套装"
	desc = "一套神器护甲，让你能施放法术，\
		同时提供更好的防护，抵御攻击与太空的虚空。\
		还会赋予一面战斗法师护盾。"
	item_path = /obj/item/mod/control/pre_equipped/enchanted
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/item/armor/try_equip_item(mob/living/carbon/human/user, obj/item/to_equip)
	var/obj/item/mod/control/mod = to_equip
	var/obj/item/mod/module/storage/storage = locate() in mod.modules
	var/obj/item/back = user.back
	if(back)
		if(!user.dropItemToGround(back))
			return
		for(var/obj/item/item as anything in back.contents)
			item.forceMove(storage)
	if(!user.equip_to_slot_if_possible(mod, mod.slot_flags, qdel_on_fail = FALSE, disable_warning = TRUE))
		return
	if(!user.dropItemToGround(user.wear_suit) || !user.dropItemToGround(user.head))
		return
	mod.quick_activation()
	var/obj/item/mod/module/eradication_lock/lock_module = locate() in mod.modules
	lock_module.used()

#undef SPELLBOOK_CATEGORY_DEFENSIVE
