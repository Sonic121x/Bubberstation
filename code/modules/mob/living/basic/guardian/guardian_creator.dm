GLOBAL_LIST_INIT(guardian_radial_images, setup_guardian_radial())

/proc/setup_guardian_radial()
	. = list()
	for(var/mob/living/basic/guardian/guardian_path as anything in subtypesof(/mob/living/basic/guardian))
		var/datum/radial_menu_choice/option = new()
		option.name = initial(guardian_path.creator_name)
		option.image = image(icon = 'icons/hud/guardian.dmi', icon_state = initial(guardian_path.creator_icon))
		option.info = span_boldnotice(initial(guardian_path.creator_desc))
		.[guardian_path] = option

/// An item which grants you your very own soul buddy
/obj/item/guardian_creator
	name = "附魔塔罗牌组"
	desc = "一副附魔塔罗牌，据说蕴藏着难以想象的力量。"
	icon = 'icons/obj/toys/playing_cards.dmi'
	icon_state = "deck_tarot_full"
	/// Are we used or in the process of being used? If yes, then we can't be used.
	var/used = FALSE
	/// The visuals we give to the guardian we spawn.
	var/theme = GUARDIAN_THEME_MAGIC
	/// The name of the guardian, for UI/message stuff.
	var/mob_name = "守护灵"
	/// Message sent when you use it.
	var/use_message = span_holoparasite("你洗了洗牌……")
	/// Message sent when it's already used.
	var/used_message = span_holoparasite("所有的牌似乎都变成空白了。")
	/// Examine description if the creator is unused
	var/unused_description = span_holoparasite("你感到有股力量在召唤你抽一张……")
	/// Examine description if the creator is used.
	var/used_description = span_holoparasite("它们看起来平淡无奇。")
	/// Failure message if no ghost picks the holopara.
	var/failure_message = span_boldholoparasite("……然后抽出一张牌！是……空白的？也许你该晚点再试。")
	/// Failure message if we don't allow lings.
	var/ling_failure = span_boldholoparasite("牌组拒绝回应你这种没有灵魂的生物。")
	/// Message sent if we successfully get a guardian.
	var/success_message = span_holoparasite("<b>%GUARDIAN</b> 已被召唤！")
	/// If true, you are given a random guardian rather than picking from a selection.
	var/random = FALSE
	/// If true, you can have multiple guardians at the same time.
	var/allow_multiple = FALSE
	/// If true, lings can get guardians from this.
	var/allow_changeling = TRUE
	/// If true, a dextrous guardian can get their own guardian, infinite chain!
	var/allow_guardian = FALSE
	/// List of all the guardians this type can spawn.
	var/list/possible_guardians = list( //default, has everything but dextrous
		/mob/living/basic/guardian/assassin,
		/mob/living/basic/guardian/charger,
		/mob/living/basic/guardian/explosive,
		/mob/living/basic/guardian/gaseous,
		/mob/living/basic/guardian/gravitokinetic,
		/mob/living/basic/guardian/lightning,
		/mob/living/basic/guardian/protector,
		/mob/living/basic/guardian/ranged,
		/mob/living/basic/guardian/standard,
		/mob/living/basic/guardian/support,
	)
	/// Have we been refunded? Used to prevent guardians from being created after we've been refunded
	/// while avoiding scamming people if they use and then destroy us
	var/was_refunded = FALSE

/obj/item/guardian_creator/Initialize(mapload)
	. = ..()
	var/datum/guardian_fluff/using_theme = GLOB.guardian_themes[theme]
	mob_name = using_theme.name
	RegisterSignal(src, COMSIG_ITEM_TC_REIMBURSED, PROC_REF(on_reimbursed))

/obj/item/guardian_creator/attack_self(mob/living/user)
	if(isguardian(user) && !allow_guardian)
		balloon_alert(user, "不能这么做！")
		return
	var/list/guardians = user.get_all_linked_holoparasites()
	if(length(guardians) && !allow_multiple)
		balloon_alert(user, "你已经有了一个！")
		return
	if(IS_CHANGELING(user) && !allow_changeling)
		to_chat(user, ling_failure)
		return
	if(used)
		to_chat(user, used_message)
		return
	var/list/radial_options = GLOB.guardian_radial_images.Copy()
	for(var/possible_guardian in radial_options)
		if(possible_guardian in possible_guardians)
			continue
		radial_options -= possible_guardian
	var/mob/living/basic/guardian/guardian_path
	if(random)
		guardian_path = pick(possible_guardians)
	else
		guardian_path = show_radial_menu(user, src, radial_options, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 42, require_near = TRUE)
		if(isnull(guardian_path))
			return
	used = TRUE
	to_chat(user, use_message)
	var/guardian_type_name = random ? "随机" : capitalize(initial(guardian_path.creator_name))
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(
		"你想扮演[span_danger("[user.real_name]")]的[span_notice("[guardian_type_name][mob_name]")]吗？",
		check_jobban = ROLE_PAI,
		poll_time = 10 SECONDS,
		ignore_category = POLL_IGNORE_HOLOPARASITE,
		alert_pic = guardian_path,
		jump_target = src,
		role_name_text = guardian_type_name,
		amount_to_pick = 1,
	)

	if(was_refunded)
		return

	if(chosen_one)
		spawn_guardian(user, chosen_one, guardian_path)
		used = TRUE
		SEND_SIGNAL(src, COMSIG_TRAITOR_ITEM_USED(type))
	else
		to_chat(user, failure_message)
		used = FALSE

/obj/item/guardian_creator/examine(mob/user)
	. = ..()
	if(used)
		. += span_holoparasite(used_description)
	else
		. += span_holoparasite(unused_description)

/obj/item/guardian_creator/proc/on_reimbursed(datum/source)
	SIGNAL_HANDLER
	was_refunded = TRUE

/// Actually create our guy
/obj/item/guardian_creator/proc/spawn_guardian(mob/living/user, mob/dead/candidate, guardian_path)
	if(QDELETED(user) || user.stat == DEAD)
		return
	var/list/guardians = user.get_all_linked_holoparasites()
	if(length(guardians) && !allow_multiple)
		balloon_alert(user, "你已经有一个了！")
		used = FALSE
		return
	var/datum/guardian_fluff/guardian_theme = GLOB.guardian_themes[theme]
	var/mob/living/basic/guardian/summoned_guardian = new guardian_path(user, guardian_theme)
	summoned_guardian.set_summoner(user, different_person = TRUE)
	summoned_guardian.PossessByPlayer(candidate.key)
	user.log_message("召唤了 [key_name(summoned_guardian)]，一名 [summoned_guardian.creator_name] 全息寄生体。", LOG_GAME)
	summoned_guardian.log_message("作为 [summoned_guardian.creator_name] 全息寄生体被召唤。", LOG_GAME)
	to_chat(user, guardian_theme.get_fluff_string(summoned_guardian.guardian_type))
	to_chat(user, replacetext(success_message, "%GUARDIAN", mob_name))
	summoned_guardian.client?.init_verbs()
	summoned_guardian.updatehealth() // Set the initial health hud
	return summoned_guardian

/// Checks to ensure we're still capable of using the radial selector
/obj/item/guardian_creator/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated || !user.is_holding(src) || used)
		return FALSE
	return TRUE

/// Guardian creator available in the wizard spellbook. All but support are available.
/obj/item/guardian_creator/wizard
	allow_multiple = TRUE
	possible_guardians = list(
		/mob/living/basic/guardian/assassin,
		/mob/living/basic/guardian/charger,
		/mob/living/basic/guardian/dextrous,
		/mob/living/basic/guardian/explosive,
		/mob/living/basic/guardian/gaseous,
		/mob/living/basic/guardian/gravitokinetic,
		/mob/living/basic/guardian/lightning,
		/mob/living/basic/guardian/protector,
		/mob/living/basic/guardian/ranged,
		/mob/living/basic/guardian/standard,
	)

/obj/item/guardian_creator/wizard/spawn_guardian(mob/living/user, mob/dead/candidate)
	var/mob/guardian = ..()
	if(isnull(guardian))
		return null
	// Add the wizard team datum
	var/datum/antagonist/wizard/antag_datum = user.mind.has_antag_datum(/datum/antagonist/wizard)
	if(isnull(antag_datum))
		return guardian
	if(!antag_datum.wiz_team)
		antag_datum.create_wiz_team()
	guardian.mind.add_antag_datum(/datum/antagonist/wizard_minion, antag_datum.wiz_team)
	return guardian

/// Guardian creator available in the traitor uplink. All but dextrous are available, you can pick which you want, and changelings cannot use it.
/obj/item/guardian_creator/tech
	name = "全息寄生体注射器"
	desc = "它装有来源不明的外星纳米群。虽然能通过硬光全息影像和纳米机器实现近乎巫术的壮举，但它需要一个有机宿主作为基地和燃料来源。"
	icon = 'icons/obj/medical/syringe.dmi'
	icon_state = "combat_hypo"
	theme = GUARDIAN_THEME_TECH
	allow_changeling = FALSE
	use_message = span_holoparasite("你开始为注射器通电……")
	used_message = span_holoparasite("注射器已经被使用过了。")
	unused_description = span_holoparasite("它的药瓶中翻涌着狂暴的色彩风暴。")
	used_description = span_holoparasite("注射器里似乎什么也没装。")
	failure_message = span_boldholoparasite("……错误。启动程序中止。AI 初始化失败。请联系技术支持或稍后重试。")
	ling_failure = span_boldholoparasite("全息寄生体惊恐地退缩了。它们不想和你这种生物扯上任何关系。")
	success_message = span_holoparasite("<b>%GUARDIAN</b> 已上线！")

/// Guardian creator only spawned by admins, which creates a holographic fish. You can have several of them.
/obj/item/guardian_creator/carp
	name = "全息鲤鱼鱼柳"
	desc = "借助鲤鱼神的力量，你可以从鲤鱼图鲁帷幕的彼端捕到一条鲤鱼，并将它束缚在你的血肉之躯上。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishfingers"
	theme = GUARDIAN_THEME_CARP
	use_message = span_holoparasite("你把鱼柳放进嘴里……")
	used_message = span_holoparasite("已经有人咬过这些鱼柳了！恶心。")
	unused_description = span_holoparasite("它们看起来热腾腾的，随时可以吃！")
	used_description = span_holoparasite("它们看起来又湿又旧……")
	failure_message = span_boldholoparasite("你没能从鲤鱼湖的海洋中捕到任何鲤鱼之灵。也许根本就没有，也许是你搞砸了。")
	ling_failure = span_boldholoparasite("鲤鱼神似乎没有选中你。也许是因为你可怕的出身。")
	success_message = span_holoparasite("<b>%GUARDIAN</b> 已被捕获！")
	allow_multiple = TRUE

/// Guardian creator available to miners from chests, very limited selection and randomly assigned.
/obj/item/guardian_creator/miner
	name = "落满灰尘的碎片"
	desc = "似乎是一块非常古老的石头，可能来自一颗奇怪的流星。"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "dustyshard"
	theme = GUARDIAN_THEME_MINER
	use_message = span_holoparasite("你用碎片刺破了自己的皮肤……")
	used_message = span_holoparasite("这块碎片似乎已经失去了全部力量……")
	unused_description = span_holoparasite("它散发着超凡的力量光芒……")
	used_description = span_holoparasite("它看起来暗淡无光，尖端还沾着干涸的血迹。")
	failure_message = span_boldholoparasite("碎片毫无反应。也许该晚点再试……")
	ling_failure = span_boldholoparasite("碎片的力量似乎与你这具可怕而变异的身体毫无反应。")
	success_message = span_holoparasite("<b>%GUARDIAN</b> 出现了！")
	random = TRUE
	//limited to ones which are plausibly useful on lavaland
	possible_guardians = list(
		/mob/living/basic/guardian/charger, // A flying mount which can cross chasms
		/mob/living/basic/guardian/protector, // Bodyblocks projectiles for you
		/mob/living/basic/guardian/ranged, // Shoots the bad guys
		/mob/living/basic/guardian/standard, // Can mine walls
		/mob/living/basic/guardian/support, // Heals and teleports you
	)

/obj/item/guardian_creator/miner/spawn_guardian(mob/living/user, mob/dead/candidate, guardian_path)
	var/mob/living/basic/guardian/guardian = ..()
	if (!guardian)
		return
	// Immune to planetary weather effects
	ADD_TRAIT(guardian, TRAIT_ASHSTORM_IMMUNE, INNATE_TRAIT)
	ADD_TRAIT(guardian, TRAIT_SNOWSTORM_IMMUNE, INNATE_TRAIT)
	return guardian
