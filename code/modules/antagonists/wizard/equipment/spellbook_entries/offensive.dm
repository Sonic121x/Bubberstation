#define SPELLBOOK_CATEGORY_OFFENSIVE "Offensive"
// Offensive wizard spells
/datum/spellbook_entry/fireball
	name = "火球术"
	desc = "向目标发射一枚会爆炸的火球。被所有巫师视为经典。"
	spell_type = /datum/action/cooldown/spell/pointed/projectile/fireball
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/spell_cards
	name = "法术卡牌"
	desc = "炽热的高速追踪卡牌。用它们的玄妙力量把敌人送进暗影界吧！"
	spell_type = /datum/action/cooldown/spell/pointed/projectile/spell_cards
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/rod_form
	name = "神杆形态"
	desc = "化身为不可阻挡的神杆，摧毁路上的一切。多次购买此法术还会提升神杆的伤害与行进距离。"
	spell_type = /datum/action/cooldown/spell/rod_form
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/disintegrate
	name = "天罚"
	desc = "以不洁之力充盈你的手掌，触碰到的受害者会猛烈炸开。"
	spell_type = /datum/action/cooldown/spell/touch/smite
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/summon_simians
	name = "召唤猿猴"
	desc = "此法术深入香蕉元素位面（是猴子那个，不是小丑那个），\
		召唤出原始猴子和低等大猩猩，它们会立刻发狂并攻击视野内的一切。真有趣！\
		它们那低等、易被操控的心智会相信你是它们的盟友，但只持续一分钟。除非你也是只猴子。"
	spell_type = /datum/action/cooldown/spell/conjure/simian
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/blind
	name = "致盲"
	desc = "暂时让单个目标失明。"
	spell_type = /datum/action/cooldown/spell/pointed/blind
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	cost = 1

/datum/spellbook_entry/tie_shoes
	name = "系鞋带"
	desc = "这个不起眼的法术会先解开目标的鞋带，再把它打上结。乍看很弱，但每次升级都会让法术更安静，使其能解开无鞋带的鞋子，甚至召唤鞋子来打结！"
	spell_type = /datum/action/cooldown/spell/pointed/untie_shoes
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	cost = 1

/datum/spellbook_entry/mutate
	name = "变异"
	desc = "让你短暂变成绿巨人并获得激光视觉。"
	spell_type = /datum/action/cooldown/spell/apply_mutations/mutate
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/fleshtostone
	name = "化肉为石"
	desc = "以石化之力充盈你的手掌，可将受害者变成无生命的雕像，持续很长时间。"
	spell_type = /datum/action/cooldown/spell/touch/flesh_to_stone
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/teslablast
	name = "特斯拉冲击"
	desc = "蓄起一道特斯拉电弧，然后射向附近随机一个目标！蓄力时你可以自由移动。电弧会在目标之间跳跃，并能将其击倒。"
	spell_type = /datum/action/cooldown/spell/charged/beam/tesla
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/lightningbolt
	name = "闪电箭"
	desc = "向敌人射出一道闪电！它会在目标之间跳跃，但无法将其击倒。"
	spell_type = /datum/action/cooldown/spell/pointed/projectile/lightningbolt
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	cost = 1

/datum/spellbook_entry/infinite_guns
	name = "次级召唤枪械"
	desc = "既然有无限的枪，为什么还要换弹？召唤出不间断的栓动步枪洪流，伤害不高，但能击倒目标。使用时需要双手空闲。学会此法术后将无法学习奥术弹幕。"
	spell_type = /datum/action/cooldown/spell/conjure_item/infinite_guns/gun
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	cost = 3
	no_coexistence_typecache = list(/datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage)

/datum/spellbook_entry/arcane_barrage
	name = "奥术弹幕"
	desc = "用这个（强大的）法术向敌人倾泻奥术能量的洪流。伤害远高于次级召唤枪械，但不会击倒目标。使用时需要双手空闲。学会此法术后将无法学习次级召唤枪械。"
	spell_type = /datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	cost = 3
	no_coexistence_typecache = list(/datum/action/cooldown/spell/conjure_item/infinite_guns/gun)

/datum/spellbook_entry/barnyard
	name = "畜棚诅咒"
	desc = "此法术会让一个倒霉蛋拥有畜棚动物的说话方式与面部特征。"
	spell_type = /datum/action/cooldown/spell/pointed/barnyardcurse
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/splattercasting
	name = "溅血施法"
	desc = "大幅降低所有法术的冷却时间，但每个法术都会消耗血液，而且血液还会随时间自然流失。\
		你可以从受害者身上补充，具体来说是他们的脖子。"
	spell_type =  /datum/action/cooldown/spell/splattercasting
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	no_coexistence_typecache = list(/datum/action/cooldown/spell/lichdom, /datum/spellbook_entry/ghostliness)

/datum/spellbook_entry/sanguine_strike
	name = "放血打击"
	desc = "一种血系法术，为你下一次武器攻击附魔，使其造成更多伤害、按伤害量治疗你，并补充血液。"
	spell_type =  /datum/action/cooldown/spell/sanguine_strike
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/scream_for_me
	name = "为我尖叫"
	desc = "残忍的血系法术，会在受害者全身造成大量严重的血液伤口。"
	spell_type =  /datum/action/cooldown/spell/touch/scream_for_me
	cost = 1
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/staffchaos
	name = "混沌法杖"
	desc = "一件反复无常的工具，能毫无道理地发射各种魔法。不建议对你关心的人使用。"
	item_path = /obj/item/gun/magic/staff/chaos
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/staffchange
	name = "变化法杖"
	desc = "一件远古造物，能射出闪耀的能量束，让目标的形体自行重塑。"
	item_path = /obj/item/gun/magic/staff/change
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/mjolnir
	name = "妙尔尼尔"
	desc = "雷神索尔借出的一把强大锤子。其中噼啪作响的力量几乎难以抑制。需双手持握才能发挥真正威力。"
	item_path = /obj/item/mjollnir
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/singularity_hammer
	name = "奇点锤"
	desc = "一柄在击打处生成极强重力场的锤子，会把附近一切拉向撞击点。需双手持握才能发挥真正威力。"
	item_path = /obj/item/singularityhammer
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/spellblade
	name = "法术之刃"
	desc = "一柄能射出能量束、把目标肢体一截截撕裂的剑。"
	item_path = /obj/item/gun/magic/staff/spellblade
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/highfrequencyblade
	name = "高频刀"
	desc = "一柄极其迅捷的附魔刀刃，以高到能切开任何东西的频率振动着。"
	item_path = /obj/item/highfrequencyblade/wizard
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	cost = 3

/datum/spellbook_entry/item/frog_contract
	name = "青蛙契约"
	desc = "与青蛙签订契约，拥有一只属于你的破坏性宠物守护者！"
	item_path = /obj/item/frog_contract
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/staffshrink
	name = "缩小法杖"
	desc = "一件远古造物，能把任何东西缩小一段合理的时间。小型建筑可以踩过去，而变小的人非常脆弱（通常是因为他们的护甲不再合身了）。"
	item_path = /obj/item/gun/magic/staff/shrink
	category = SPELLBOOK_CATEGORY_OFFENSIVE


#undef SPELLBOOK_CATEGORY_OFFENSIVE
