#define SPELLBOOK_CATEGORY_ASSISTANCE "Assistance"
// Wizard spells that assist the caster in some way
/datum/spellbook_entry/summonitem
	name = "召唤物品"
	desc = "将先前标记过的物品从宇宙任意角落召回你手中。"
	spell_type = /datum/action/cooldown/spell/summonitem
	category = SPELLBOOK_CATEGORY_ASSISTANCE
	cost = 1

/datum/spellbook_entry/charge
	name = "充能"
	desc = "此法术可为手中的各种物品充能，从魔法器物到电子元件皆可。有创意的巫师甚至能用它为其他施法者补充魔力。"
	spell_type = /datum/action/cooldown/spell/charge
	category = SPELLBOOK_CATEGORY_ASSISTANCE
	cost = 1

/datum/spellbook_entry/shapeshift
	name = "野性变形"
	desc = "暂时化身为另一种形态，以使用其天赋能力。一旦做出选择便无法更改。"
	spell_type = /datum/action/cooldown/spell/shapeshift/wizard
	category = SPELLBOOK_CATEGORY_ASSISTANCE
	cost = 1

/datum/spellbook_entry/tap
	name = "灵魂汲取"
	desc = "用你自己的灵魂为法术供能！"
	spell_type = /datum/action/cooldown/spell/tap
	category = SPELLBOOK_CATEGORY_ASSISTANCE
	cost = 1

/datum/spellbook_entry/item/staffanimation
	name = "活化法杖"
	desc = "一根奥术法杖，能发射诡秘能量束，使无生命物体活动起来。此魔法对机械无效。"
	item_path = /obj/item/gun/magic/staff/animate
	category = SPELLBOOK_CATEGORY_ASSISTANCE

/datum/spellbook_entry/item/soulstones
	name = "灵魂石碎片套件"
	desc = "灵魂石碎片是古老的工具，能够捕获并驾驭死者与濒死者的灵魂。\
		「工匠」法术可让你制造奥术机械，供被捕获的灵魂驾驭。"
	item_path = /obj/item/storage/belt/soulstone/full
	category = SPELLBOOK_CATEGORY_ASSISTANCE

/datum/spellbook_entry/item/soulstones/try_equip_item(mob/living/carbon/human/user, obj/item/to_equip)
	var/was_equipped = user.equip_to_slot_if_possible(to_equip, ITEM_SLOT_BELT, disable_warning = TRUE)
	to_chat(user, span_notice("[to_equip.name]已被召唤至[was_equipped ? "你的腰间" : "你的脚边"]。"))

/datum/spellbook_entry/item/soulstones/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	. =..()
	if(!.)
		return

	var/datum/action/cooldown/spell/conjure/construct/bonus_spell = new(user.mind || user)
	bonus_spell.Grant(user)

/datum/spellbook_entry/item/necrostone
	name = "死灵之石"
	desc = "死灵之石能将三名死者复活为骷髅奴仆，供你驱使。"
	item_path = /obj/item/necromantic_stone
	category = SPELLBOOK_CATEGORY_ASSISTANCE

/datum/spellbook_entry/item/contract
	name = "学徒契约"
	desc = "一份将学徒巫师束缚于你麾下的魔法契约，使用它便会将其召唤到你身边。"
	item_path = /obj/item/antag_spawner/contract
	category = SPELLBOOK_CATEGORY_ASSISTANCE

/datum/spellbook_entry/item/guardian
	name = "守护者牌组"
	desc = "一副守护者塔罗牌，能将一名专属守护者绑定在你身上。守护者有多种类型，但它们都会把一部分伤害转移给你。\
	最好不要和任何能让你与他人交换身体的物品一起购买。"
	item_path = /obj/item/guardian_creator/wizard
	category = SPELLBOOK_CATEGORY_ASSISTANCE

/datum/spellbook_entry/item/bloodbottle
	name = "血液瓶"
	desc = "一瓶灌注了魔法的血液，破碎时其气味会\
		吸引异次元生物。但要小心，\
		鲜血魔法召来的生物杀起人来不分敌我，\
		你自己也可能成为受害者。"
	item_path = /obj/item/antag_spawner/slaughter_demon
	limit = 3
	category = SPELLBOOK_CATEGORY_ASSISTANCE

/datum/spellbook_entry/item/hugbottle
	name = "挠痒瓶"
	desc = "一瓶灌注了魔法的欢乐，破碎时其气味会\
		吸引可爱的异次元生物。这些生物\
		与屠戮恶魔相似，但不会永久杀死\
		受害者，而是把他们送入异次元的拥抱空间，\
		待恶魔死亡时释放。混乱，但终究\
		不会造成破坏性后果。不过船员的反应\
		可能就非常有破坏性了。"
	item_path = /obj/item/antag_spawner/slaughter_demon/laughter
	cost = 1 //non-destructive; it's just a jape, sibling!
	limit = 3
	category = SPELLBOOK_CATEGORY_ASSISTANCE

/datum/spellbook_entry/item/vendormancer
	name = "售货魔法权杖"
	desc = "一根蕴含符文售货魔法的权杖。\
		它最多可召唤 3 台符文售货机，它们会随时间消散，但可以被\
		投掷出去压扁对手，也可以直接引爆。充能耗尽后，\
		进行一段较长的引导即可恢复充能。"
	item_path = /obj/item/runic_vendor_scepter
	category = SPELLBOOK_CATEGORY_ASSISTANCE

#undef SPELLBOOK_CATEGORY_ASSISTANCE
