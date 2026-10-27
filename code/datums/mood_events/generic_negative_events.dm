/datum/mood_event/handcuffed
	description = "看来我终于为自己的胡闹付出了代价。"
	mood_change = -1

/datum/mood_event/broken_vow //Used for when mimes break their vow of silence
	description = "我打破了神圣的誓言，让自己蒙羞，也背叛了其他默剧演员……"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/on_fire
	description = "我着火了！！！"
	mood_change = -12
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/on_fire/add_effects(...)
	if(owner.has_quirk(/datum/quirk/pyromania))
		mood_change *= 0.25
		description = "这火可能有点太大了。"
	else if(owner.has_quirk(/datum/quirk/pyrophobia))
		mood_change *= 1.5

/datum/mood_event/suffocation
	description = "无法……呼吸……"
	mood_change = -12
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/burnt_thumb
	description = "我不该玩打火机的……"
	mood_change = -1
	timeout = 2 MINUTES

/datum/mood_event/cold
	description = "这里冷得受不了了。"
	mood_change = -5

/datum/mood_event/hot
	description = "这里越来越热了。"
	mood_change = -5

/datum/mood_event/creampie
	description = "我被奶油糊了一脸。尝起来是派的味道。"
	mood_change = -2
	timeout = 3 MINUTES
	event_flags = MOOD_EVENT_WHIMSY // if whimsical, no penalty

/datum/mood_event/inked
	description = "我被鱿鱼墨汁泼了一脸。尝起来咸咸的。"
	mood_change = -3
	timeout = 3 MINUTES

/datum/mood_event/slipped
	description = "我滑倒了。下次得小心点……"
	mood_change = -2
	timeout = 3 MINUTES
	event_flags = MOOD_EVENT_WHIMSY // if whimsical, no penalty

/datum/mood_event/eye_stab
	description = "我以前也和你一样是个冒险家，直到我的眼睛中了一螺丝刀。"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/delam //SM delamination
	description = "那些该死的工程师什么事都做不好……"
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/cascade // Big boi delamination
	description = "我从没想过会见到共振级联，更别说亲身经历了……"
	mood_change = -8
	timeout = 5 MINUTES

/datum/mood_event/depression
	description = "我莫名其妙地感到悲伤。"
	mood_change = -12
	timeout = 2 MINUTES

/datum/mood_event/shameful_suicide //suicide_acts that return SHAME, like sord
	description = "我连结束这一切都做不到！"
	mood_change = -15
	timeout = 60 SECONDS

/datum/mood_event/dismembered
	description = "啊！我的肢体！我还要用呢！"
	mood_change = -10
	timeout = 8 MINUTES

/datum/mood_event/dismembered/add_effects(obj/item/bodypart/limb)
	if(limb)
		description = "啊！我的[chinese_body_zone_display(limb.plaintext_zone)]！我还要用呢！"

/datum/mood_event/reattachment
	description = "哎哟！我的肢体像睡觉时被压麻了一样。"
	mood_change = -3
	timeout = 2 MINUTES
	event_flags = MOOD_EVENT_PAIN

/datum/mood_event/reattachment/add_effects(obj/item/bodypart/limb)
	if(limb)
		description = "哎哟！我的[chinese_body_zone_display(limb.plaintext_zone)]像睡觉时被压麻了一样。"

/datum/mood_event/tased
	description = "泰瑟枪名字里没有电，打在身上可全是电。"
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/embedded
	description = "快把它拔出来！"
	mood_change = -7

/datum/mood_event/table
	description = "有人把我摔在了桌子上！"
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/table/add_effects()
	if(HAS_TRAIT(owner, TRAIT_CATLIKE_INSTINCT)) //Holy snowflake batman!
		var/mob/living/carbon/human/feline = owner
		feline.wag_tail(3 SECONDS)
		description = "他们想在桌子上玩！"
		mood_change = 2

/datum/mood_event/table_limbsmash
	description = "该死的桌子，痛死我了……"
	mood_change = -3
	timeout = 3 MINUTES
	event_flags = MOOD_EVENT_PAIN

/datum/mood_event/table_limbsmash/add_effects(obj/item/bodypart/banged_limb)
	if(banged_limb)
		description = "我那倒霉的[chinese_body_zone_display(banged_limb.plaintext_zone)]，痛死我了……"

/datum/mood_event/brain_damage
	mood_change = -3

/datum/mood_event/brain_damage/add_effects()
	var/damage_message = pick_list_replacements(BRAIN_DAMAGE_FILE, "brain_damage")
	description = "呃呃啊啊……[damage_message]"

/datum/mood_event/hulk //Entire duration of having the hulk mutation
	description = "浩克砸！"
	mood_change = -4

/datum/mood_event/epilepsy //Only when the mutation causes a seizure
	description = "我早该注意癫痫警告的。"
	mood_change = -3
	timeout = 5 MINUTES

/datum/mood_event/photophobia
	description = "灯光太刺眼了……"
	mood_change = -3
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/nyctophobia
	description = "这附近真黑啊……"
	mood_change = -3
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/claustrophobia
	description = "为什么感觉被困住了？！放我出去！！！"
	mood_change = -7
	timeout = 1 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/bright_light
	description = "我讨厌待在亮处……我得找个更暗的地方……"
	mood_change = -12

/datum/mood_event/family_heirloom_missing
	description = "我的传家宝不见了……"
	mood_change = -4

/datum/mood_event/healsbadman
	description = "我感觉自己像是靠几根细线勉强连在一起，随时都会散架！"
	mood_change = -4
	timeout = 2 MINUTES

/datum/mood_event/healsbadman/long_term
	timeout = 10 MINUTES

/datum/mood_event/jittery
	description = "我紧张得要命，焦躁不安，根本站不住！！"
	mood_change = -2

/datum/mood_event/jittery/add_effects(...)
	if(HAS_PERSONALITY(owner, /datum/personality/paranoid))
		mood_change -= 1

/datum/mood_event/choke
	description = "我无法呼吸了！！！"
	mood_change = -10
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/vomit
	description = "我刚吐了。真恶心。"
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/vomitself
	description = "我吐了自己一身。恶心死了。"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/painful_medicine
	description = "药物也许对我有好处，但现在刺痛得要命。"
	mood_change = -5
	timeout = 60 SECONDS
	event_flags = MOOD_EVENT_PAIN

/datum/mood_event/startled
	description = "听到那个词让我想起了可怕的东西。"
	mood_change = -1
	timeout = 1 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/phobia
	description = "我看到了非常可怕的东西！"
	mood_change = -4
	timeout = 4 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/spooked
	description = "那些骨头的咔哒声……至今仍萦绕在我耳边。"
	mood_change = -4
	timeout = 4 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/notcreeping
	description = "那些声音不高兴了，正痛苦地扭曲我的思绪，逼我回去完成任务。"
	mood_change = -6
	timeout = 3 SECONDS
	hidden = TRUE

/datum/mood_event/notcreepingsevere//not hidden since it's so severe
	description = "它们需——要——痴迷的对象！！"
	mood_change = -30
	timeout = 3 SECONDS

/datum/mood_event/notcreepingsevere/add_effects(name)
	var/list/unstable = list(name)
	for(var/i in 1 to rand(3,5))
		unstable += copytext_char(name, -1)
	var/unhinged = uppertext(unstable.Join(""))//example Tinea Luxor > TINEA LUXORRRR (with randomness in how long that slur is)
	description = "它们需——要——[unhinged]！！"

/datum/mood_event/tower_of_babel
	description = "我的话语变成了语无伦次的胡言乱语……"
	mood_change = -1
	timeout = 15 SECONDS

/datum/mood_event/back_pain
	description = "背包怎么背都不舒服，痛死我了！"
	mood_change = -15
	event_flags = MOOD_EVENT_PAIN

/datum/mood_event/sacrifice_bad
	description = "那些该死的野蛮人！"
	mood_change = -5
	timeout = 2 MINUTES
	event_flags = MOOD_EVENT_SPIRITUAL

/datum/mood_event/artbad
	description = "我拉出来的东西都比那更像艺术。"
	mood_change = -2
	timeout = 2 MINUTES
	event_flags = MOOD_EVENT_ART

/datum/mood_event/artbad/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/creative))
		mood_change = 0
		description = "每个人的艺术之路总得有个起点！"

/datum/mood_event/graverobbing
	description = "我刚刚亵渎了别人的坟墓……真不敢相信我会做这种事……"
	mood_change = -8
	timeout = 3 MINUTES

/datum/mood_event/deaths_door
	description = "到此为止了……我真的要死了。"
	mood_change = -20

/datum/mood_event/gunpoint
	description = "这家伙疯了！我最好小心点……"
	mood_change = -10
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/tripped
	description = "真不敢相信我中了这种老掉牙的把戏！"
	mood_change = -5
	timeout = 2 MINUTES

/datum/mood_event/untied
	description = "我讨厌鞋带松开！"
	mood_change = -3
	timeout = 60 SECONDS

/datum/mood_event/gates_of_mansus
	description = "我窥见了世界之外的恐怖。现实在我眼前崩解！"
	mood_change = -25
	timeout = 4 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/high_five_full_hand
	description = "天哪，我连击掌都不会……"
	mood_change = -1
	timeout = 45 SECONDS

/datum/mood_event/too_slow
	description = "不！我怎么可能……太慢了？？？"
	mood_change = -2 // multiplied by how many people saw it happen, up to 8, so potentially massive. the ULTIMATE prank carries a lot of weight
	timeout = 2 MINUTES

/datum/mood_event/too_slow/add_effects(param)
	var/people_laughing_at_you = 1 // start with 1 in case they're on the same tile or something
	for(var/mob/living/carbon/iter_carbon in oview(owner, 7))
		if(!IS_UNCONSCIOUS_OR_CRIT(iter_carbon))
			people_laughing_at_you++
			if(people_laughing_at_you > 7)
				break

	mood_change *= people_laughing_at_you
	return ..()

/datum/mood_event/surgery
	description = "他们在切开我的身体！！"
	mood_change = -8
	event_flags = MOOD_EVENT_FEAR
	var/surgery_completed = FALSE

/datum/mood_event/surgery/success
	description = "那场手术真痛……还好成功了吧……"
	timeout = 3 MINUTES
	surgery_completed = TRUE

/datum/mood_event/surgery/failure
	description = "啊啊啊啊！他们把我活生生地切成了肉片！"
	timeout = 10 MINUTES
	surgery_completed = TRUE

/datum/mood_event/bald
	description = "我得找点东西遮住脑袋……"
	mood_change = -3

/datum/mood_event/bald_reminder
	description = "这又让我想起了自己的头发根本长不回来！太糟了！"
	mood_change = -5
	timeout = 4 MINUTES

/datum/mood_event/bad_touch
	description = "我不喜欢别人碰我。"
	mood_change = -3
	timeout = 4 MINUTES

/datum/mood_event/very_bad_touch
	description = "我非常不喜欢别人碰我。"
	mood_change = -5
	timeout = 4 MINUTES

/datum/mood_event/noogie
	description = "哎哟！简直又回到了太空高中那会儿……"
	mood_change = -2
	timeout = 60 SECONDS

/datum/mood_event/noogie_harsh
	description = "哎哟！！这比普通的钻头拳揉头还痛！"
	mood_change = -4
	timeout = 60 SECONDS

/datum/mood_event/aquarium_negative
	description = "鱼全都死了……"
	mood_change = -3
	timeout = 90 SECONDS

/datum/mood_event/tail_lost
	description = "我的尾巴！！为什么？！"
	mood_change = -8
	timeout = 10 MINUTES

/datum/mood_event/tail_balance_lost
	description = "没有尾巴，我感觉失去了平衡。"
	mood_change = -2

/datum/mood_event/tail_regained_wrong
	description = "这是哪门子恶劣的玩笑？！这根本不是我的尾巴。"
	mood_change = -12 // -8 for tail still missing + -4 bonus for being frakenstein's monster
	timeout = 5 MINUTES

/datum/mood_event/tail_regained_species
	description = "这条尾巴不是我的，但至少能让我保持平衡……"
	mood_change = -5
	timeout = 5 MINUTES

/datum/mood_event/tail_regained_right
	description = "我的尾巴回来了，但那经历真是可怕……"
	mood_change = -2
	timeout = 5 MINUTES

/datum/mood_event/burnt_wings
	description = "我宝贵的翅膀！！"
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/holy_smite //punished
	description = "我受到了神明的惩罚！"
	mood_change = -5
	timeout = 5 MINUTES

/datum/mood_event/banished //when the chaplain is sus! (and gets forcably de-holy'd)
	description = "我被逐出教会了！"
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/heresy
	description = "如此多的异端行径，简直让我喘不过气！"
	mood_change = -5
	timeout = 5 MINUTES

/datum/mood_event/soda_spill
	description = "好极了！没关系，我本来就想把汽水穿在身上，没打算喝……"
	mood_change = -2
	timeout = 1 MINUTES

/datum/mood_event/watersprayed
	description = "我讨厌被水喷！"
	mood_change = -1
	timeout = 30 SECONDS

/datum/mood_event/gamer_withdrawal
	description = "真希望现在能打游戏……"
	mood_change = -5
	event_flags = MOOD_EVENT_GAMING

/datum/mood_event/gamer_lost
	description = "如果连游戏都玩不好，我还配自称游戏玩家吗？"
	mood_change = -6
	timeout = 10 MINUTES
	event_flags = MOOD_EVENT_GAMING

/datum/mood_event/lost_52_card_pickup
	description = "太丢人了！从地上捡起这些牌真让我羞愧……"
	mood_change = -3
	timeout = 3 MINUTES
	event_flags = MOOD_EVENT_WHIMSY | MOOD_EVENT_GAMING

/datum/mood_event/russian_roulette_lose_cheater
	description = "我赌输了！幸好没瞄准脑袋……"
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/russian_roulette_lose
	description = "我拿性命作赌注，却输了！看来到此为止了……"
	mood_change = -20
	timeout = 10 MINUTES

/datum/mood_event/russian_roulette_lose/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/gambler))
		mood_change *= 0.5
		description = "我拿性命作赌注，却输了！其实，这场游戏从一开始就被做了手脚……"
		return

/datum/mood_event/bad_touch_bear_hug
	description = "刚才那一下把我勒得太紧了。"
	mood_change = -1
	timeout = 2 MINUTES

/datum/mood_event/rippedtail
	description = "我把人家的尾巴扯断了，我都干了些什么！"
	mood_change = -5
	timeout = 30 SECONDS

/datum/mood_event/sabrage_fail
	description = "该死！那招特技没按计划成功！"
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/body_purist
	description = "我感觉到身上装着机械义体，我讨厌这种感觉！"

/datum/mood_event/body_purist/add_effects(power)
	mood_change = power

/datum/mood_event/unsatisfied_nomad
	description = "我在这里待得太久了！我想出去探索太空！"
	mood_change = -3

/datum/mood_event/moon_insanity
	description = "月亮审判了我，认定我不够资格！！！"
	mood_change = -3
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/moon_insanity/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/spiritual))
		mood_change *= 2

/datum/mood_event/amulet_insanity
	description = "我、看、见、光、了，必、须、阻、止、它！"
	mood_change = -6
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/mallet_humiliation
	description = "被这么蠢的武器打中，实在是种耻辱……"
	mood_change = -3
	timeout = 10 SECONDS

///Wizard cheesy grand finale - what everyone but the wizard gets
/datum/mood_event/madness_despair
	description = "不配，不配，不配！！！"
	mood_change = -200
	special_screen_obj = "mood_despair"

/datum/mood_event/all_nighter
	description = "我昨晚一夜没睡，已经精疲力竭了。"
	mood_change = -5

//Used by the Veteran Advisor trait job
/datum/mood_event/desentized
	description = "再也没有什么能比得上我曾经见过的一切……"
	mood_change = -3
	special_screen_obj = "mood_desentized"

//Used for the psychotic brawling martial art, if the person is a pacifist.
/datum/mood_event/pacifism_bypassed
	description = "我不是故意伤害他们的！"
	mood_change = -20
	timeout = 10 MINUTES

//Gained when you're hit over the head with wrapping paper or cardboard roll
/datum/mood_event/bapped
	description = "哎哟……我的头，现在感觉有点傻乎乎的！"
	mood_change = -1
	timeout = 3 MINUTES

/datum/mood_event/bapped/add_effects()
	// Felinids apparently hate being hit over the head with cardboard
	if(HAS_TRAIT(owner, TRAIT_CATLIKE_INSTINCT))
		mood_change = -2

/datum/mood_event/encountered_evil
	description = "我不愿相信，但世上确实有人坏透了。"
	mood_change = -1
	timeout = 1 MINUTES

/datum/mood_event/smoke_in_face
	description = "烟味真恶心。"
	mood_change = -3
	timeout = 30 SECONDS

/datum/mood_event/smoke_in_face/add_effects(param)
	if(HAS_TRAIT(owner, TRAIT_ANOSMIA))
		description = "烟味真难闻。"
		mood_change = -1
	if(HAS_TRAIT(owner, TRAIT_SMOKER))
		description = "居然往我脸上吐烟，认真的吗？"
		mood_change = 0

/datum/mood_event/slots/loss
	description = "啊，可恶！"
	mood_change = -2
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_GAMING

/datum/mood_event/slots/loss/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/gambler))
		mood_change = 0
		description = "啊，可恶。"
	if(HAS_PERSONALITY(owner, /datum/personality/industrious) || HAS_PERSONALITY(owner, /datum/personality/slacking/diligent))
		mood_change *= 1.5

/datum/mood_event/lost_control_of_life
	description = "我的人生已经失控了。"
	mood_change = -5
	timeout = 5 MINUTES

/datum/mood_event/empathetic_sad
	description = "看见别人难过，我也会难过。"
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/misanthropic_sad
	description = "看见别人开心，我就觉得不自在。"
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/paranoid/one_on_one
	description = "我正和某人独处——万一对方想杀我呢？"
	mood_change = -3
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/paranoid/large_group
	description = "周围有这么多人——谁都有可能想害我！"
	mood_change = -3
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/nt_disillusioned
	description = "我讨厌这家公司，以及它所代表的一切。"
	mood_change = -2

/datum/mood_event/disillusioned_revs_lost
	description = "革命被镇压了……可真是好极了。"
	mood_change = -2
	timeout = 10 MINUTES

/datum/mood_event/loyalist_revs_win
	description = "革命成功了……这会影响季度利润。"
	mood_change = -2
	timeout = 10 MINUTES

/datum/mood_event/slacking_off_diligent
	description = "我该回去工作了。"
	mood_change = -1

/datum/mood_event/unimaginative_patronage
	description = "感觉那是在浪费钱。"
	mood_change = -2
	timeout = 5 MINUTES

/datum/mood_event/unimaginative_framing
	description = "我本可以在那里挂点更有用的东西。"
	mood_change = -2
	timeout = 5 MINUTES

/datum/mood_event/unimaginative_sculpting
	description = "感觉那是在浪费材料。"
	mood_change = -2
	timeout = 5 MINUTES

/datum/mood_event/splattered_with_blood
	description = "呃，我刚被溅了一身血！"
	mood_change = -4
	timeout = 4 MINUTES

/datum/mood_event/splattered_with_blood/add_effects(...)
	if(HAS_TRAIT(owner, TRAIT_CULT_HALO))
		mood_change = 2
		description = "鲜血，鲜血！几何之神会满意的。"
		return
	if(HAS_TRAIT(owner, TRAIT_MORBID) || HAS_TRAIT(owner, TRAIT_EVIL) || HAS_TRAIT(owner, TRAIT_DRINKS_BLOOD))
		mood_change = 0
		description = "我刚被溅了一身血。真迷人！"
		return
	if(IS_DESENSITIZED(owner))
		mood_change *= 0.5

/datum/mood_event/teetotal_hangover
	description = "多么丢人的丑态！这就是酗酒的下场！"
	mood_change = -4
	timeout = 10 MINUTES

/datum/mood_event/normal_hangover
	description = "唉，真是糟糕的一夜。"
	mood_change = 0
	timeout = 10 MINUTES

/datum/mood_event/jabbed_with_tester
	description = "伙计，被那东西扎一下真难受。"
	mood_change = -4
	timeout = 5 MINUTES

/datum/mood_event/gizmo_negative
	description = "我听见有个声音在低语，而它说的话让我不安。"
	mood_change = -3
	timeout = 30 SECONDS

/datum/mood_event/cement
	description = span_warning("我被迫吃了水泥……")
	mood_change = -6
	timeout = 4 MINUTES
