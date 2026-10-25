//Contains generic skillchips that are fairly short and simple

/obj/item/skillchip/wine_taster
	name = "品酒大师技能芯片"
	desc = "Wine.Is.Not.Equal 版本 5。"
	auto_traits = list(TRAIT_WINE_TASTER)
	skill_name = "品酒"
	skill_description = "仅凭味道就能辨认葡萄酒的年份。再也不会面对一杯陌生的酒时说不出个所以然。"
	skill_icon = "wine-bottle"
	activate_message = span_notice("你想起了葡萄酒的滋味。")
	deactivate_message = span_notice("你对葡萄酒的记忆蒸发了。")

/obj/item/skillchip/bonsai
	name = "园艺大师 3 技能芯片"
	desc = "“学习如何把绿篱和盆栽修剪成新的造型。第三版。”"
	auto_traits = list(TRAIT_BONSAI)
	skill_name = "绿篱修剪"
	skill_description = "用任意一把旧刀就能把绿篱和盆栽修剪成奇妙的新造型。不适用于塑料植物。"
	skill_icon = "spa"
	activate_message = span_notice("你的脑海里充满了植物造景的构思。")
	deactivate_message = span_notice("你已经想不起绿篱长什么样了。")

/obj/item/skillchip/useless_adapter
	name = "技能芯片转接器"
	desc = "老兄，听说你喜欢技能芯片，所以我们把你的技能芯片装进了技能芯片里，这样你就能……呃……"
	skill_name = "无用的转接器"
	skill_description = "让你在它被植入大脑后，还能再往这个转接器里插入另一枚技能芯片……"
	skill_icon = "plug"
	activate_message = span_notice("你现在可以通过这个转接器激活另一枚芯片了，但你不确定自己为什么要这么做……")
	deactivate_message = span_notice("你不再拥有那个无用的技能芯片转接器了。")
	skillchip_flags = SKILLCHIP_ALLOWS_MULTIPLE
	// Literally does nothing.
	complexity = 0
	slot_use = 0

/obj/item/skillchip/light_remover
	name = "梦魇技能芯片"
	desc = "一枚讲解如何安全取出灯泡的技能芯片。想出这个糟糕名字的人真该被开除。"
	auto_traits = list(TRAIT_LIGHTBULB_REMOVER)
	skill_name = "灯泡拆卸"
	skill_description = "从今天起告别拆灯泡失败，无需手套！"
	skill_icon = "lightbulb"
	activate_message = span_notice("你感觉自己的痛觉受体对灼热物体不那么敏感了。")
	deactivate_message = span_notice("你感觉灼热的物体又能难住你了……")

/obj/item/skillchip/disk_verifier
	name = "K33P-TH4T-D15K 技能芯片"
	desc = "一枚表面压印着核弹认证磁盘微缩图案的技能芯片。"
	auto_traits = list(TRAIT_DISK_VERIFIER)
	skill_name = "核弹磁盘验证"
	skill_description = "核弹认证磁盘上有一串极长的序列号用于验证。这枚技能芯片存有该序列号，使使用者能自动识破伪造品。"
	skill_icon = "save"
	activate_message = span_notice("你感到自己的大脑会自动核对圆盘状物体上的冗长序列号。")
	deactivate_message = span_notice("那种对长得离谱的磁盘序列号的直觉辨识力从你脑海中淡去。")

/obj/item/skillchip/entrails_reader
	name = "内脏占卜技能芯片"
	auto_traits = list(TRAIT_ENTRAILS_READER)
	skill_name = "内脏解读"
	skill_description = "通过观察一个人的内脏来了解他的人生。请勿与预知未来混淆。"
	skill_icon = "lungs"
	activate_message = span_notice("你觉得自己对解读器官颇有心得。")
	deactivate_message = span_notice("关于肝脏损伤、心脏劳损与肺部疤痕的知识从你脑海中淡去。")

/obj/item/skillchip/appraiser
	name = "即刻鉴定真伪证件！技能芯片"
	desc = "按技能芯片的命名标准来看，这名字已经绝望到、也自我解释到不能再直白了。"
	auto_traits = list(TRAIT_ID_APPRAISER)
	skill_name = "证件鉴定"
	skill_description = "鉴定一张证件，看看它是中央指挥部签发的，还是站内打印出来的劣质货。"
	skill_icon = "magnifying-glass"
	activate_message = span_notice("你觉得自己能辨认出证件卡上那些特殊的细微特征。")
	deactivate_message = span_notice("某些证件是不是有什么特别之处来着？")

/obj/item/skillchip/sabrage
	name = "军刀开瓶术技能芯片"
	desc = "一枚隐约带着酒气的技能芯片。最好配合军刀或其他锋利刀剑使用。"
	auto_traits = list(TRAIT_SABRAGE_PRO)
	skill_name = "军刀开瓶精通"
	skill_description = "赋予使用者关于香槟瓶瓶颈结构弱点的精妙知识， \
	让他们更擅长在军官派对上耍帅。"
	skill_icon = "bottle-droplet"
	activate_message = span_notice("你对香槟瓶以及如何去除它们的软木塞有了全新的理解。")
	deactivate_message = span_notice("关于香槟瓶内那套微妙物理的知识从你脑海中淡去。")

/obj/item/skillchip/brainwashing
	name = "可疑的技能芯片"
	auto_traits = list(TRAIT_BRAINWASHING)
	skill_name = "洗脑"
	skill_description = "警告：该芯片的完整性已受损。请丢弃此技能芯片。"
	skill_icon = "soap"
	activate_message = span_notice("……但突然间你全都想起来了……好像是把大脑放进洗衣机里？")
	deactivate_message = span_warning("所有关于秘密洗脑技术的知识都消失了。")

/obj/item/skillchip/brainwashing/examine(mob/user)
	. = ..()
	. += span_warning("它似乎随着时间被腐蚀了，把它塞进脑子里可能不是什么好主意……")

/obj/item/skillchip/brainwashing/on_activate(mob/living/carbon/user, silent = FALSE)
	to_chat(user, span_danger("芯片把损坏的记忆灌进你的脑中，你的头一阵剧痛！"))
	user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 20)
	. = ..()

/obj/item/skillchip/chefs_kiss
	name = "K1SS 技能芯片"
	desc = "这枚技能芯片隐约带着苹果派的香味，真讨人喜欢。使用前请咨询营养师。"
	auto_traits = list(TRAIT_CHEF_KISS)
	skill_name = "主厨之吻"
	skill_description = "让你可以亲吻自己做出的食物，为它们注入爱意。"
	skill_icon = "cookie"
	activate_message = span_notice("你想起祖母教过你，她是怎么带着爱意烤饼干的。")
	deactivate_message = span_notice("你忘记了祖母传给你的一切记忆。她到底是不是你的亲祖母？")

/obj/item/skillchip/intj
	name = "集成直觉思考与判断技能芯片"
	auto_traits = list(TRAIT_REMOTE_TASTING)
	skill_name = "脑内风味演算"
	skill_description = "检查食物时，你能像真的在吃一样体验到它的风味。"
	skill_icon = FA_ICON_DRUMSTICK_BITE
	activate_message = span_notice("你想到自己最爱的食物，意识到自己能在脑中翻转它的风味。")
	deactivate_message = span_notice("你感觉自己那座以食物构建的记忆宫殿正在崩塌……")

/obj/item/skillchip/drunken_brawler
	name = "F0RC3 4DD1CT10N 技能芯片"
	desc = "一枚散发着酒气的技能芯片，据说能提升醉酒状态下的战斗本领——好像这样就能让你逃过肝硬化似的。"
	auto_traits = list(TRAIT_DRUNKEN_BRAWLER)
	skill_name = "醉拳精通"
	skill_description = "醉酒时，你的徒手格斗效果会得到提升。"
	skill_icon = "wine-bottle"
	activate_message = span_notice("说真的，你确实想喝一杯。这地方随时都可能有人扑上来揍你。")
	deactivate_message = span_notice("你突然觉得清醒地在站里走动安全多了…… ")

/obj/item/skillchip/master_angler
	name = "垂钓大师技能芯片"
	desc = "一枚塞满了钓鱼与鱼类百科摘录和趣闻的技能芯片。"
	auto_traits = list(TRAIT_REVEAL_FISH, TRAIT_EXAMINE_FISHING_SPOT, TRAIT_EXAMINE_FISH, TRAIT_EXAMINE_DEEPER_FISH)
	skill_name = "渔者辨识"
	skill_description = "检查钓点时列出鱼类，在有东西咬钩时给出提示，以及更多。"
	skill_icon = "fish"
	activate_message = span_notice("你感到数位饱经日晒的老渔夫的知识与热情在你体内燃烧。")
	deactivate_message = span_notice("你再也没有在阳光明媚的河边抛竿的兴致了。")

	actions_types = list(/datum/action/cooldown/fishing_tip)

/datum/action/cooldown/fishing_tip
	name = "给出钓鱼小贴士"
	desc = "回忆一条关于钓鱼的至理名言。"
	button_icon = 'icons/hud/radial_fishing.dmi'
	button_icon_state = "river"
	background_icon_state = "bg_default"
	overlay_icon_state = "bg_default_border"
	cooldown_time = 2.5 SECONDS //enough time to skim through tips.

/datum/action/cooldown/fishing_tip/Activate(atom/target_atom)
	. = ..()
	send_tip_of_the_round(owner, pick(GLOB.fishing_tips), source = "古老的钓鱼智慧")

/obj/item/skillchip/disposals
	name = "T4RG3T.bin 技能芯片"
	desc = "成为一名无所畏惧的垃圾投放手，把垃圾精准送进它们该去的地方。"
	auto_traits = list(TRAIT_THROWINGARM)
	skill_name = "无畏投放手"
	skill_description = "你拥有一种不可思议的本领：每一次投掷都能精准落入垃圾处理装置。"
	skill_icon = "trash-can"
	activate_message = span_notice("你的注意力仿佛激光般锁定在附近的垃圾处理装置上。")
	deactivate_message = span_notice("附近的垃圾处理装置渐渐淡出了你的视野。")
