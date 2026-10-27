/// The message displayed in the hemophage's chat when they enter their dormant state.
#define DORMANT_STATE_START_MESSAGE "你感觉到肿瘤的搏动正在放缓，进入了休眠状态。你突然感到极度虚弱，对一切都毫无抵御之力，运动也变得愈发困难，因为身体只剩最关键的生理功能仍在运作。"
/// The message displayed in the hemophage's chat when they leave their dormant state.
#define DORMANT_STATE_END_MESSAGE "一阵热流涌过你的血管，你能感觉到肿瘤又重新以规律的节奏搏动起来。你不再感到极度脆弱，运动也不再那么困难了。"


/datum/action/cooldown/hemophage
	cooldown_time = 3 SECONDS
	button_icon_state = null


/datum/action/cooldown/hemophage/New(Target)
	. = ..()

	if(target && isnull(button_icon_state))
		AddComponent(/datum/component/action_item_overlay, target)


/datum/action/cooldown/hemophage/toggle_dormant_state
	name = "进入休眠状态"
	desc = "使你体内的肿瘤进入休眠状态，只需极少量血液便能存活。然而，寄生在你体内的肿瘤是维持你生命的唯一依靠，让它沉寂下来会使它与你自己都只剩维持站立的基本功能。它不会再在黑暗中修补你的身体，而血液流动的匮乏会让你感受到前所未有的虚弱，几乎无法奔跑。它并不是可以随意切换的开关，重新唤醒它需要一些时间。"
	cooldown_time = 3 MINUTES
	background_icon = 'modular_zubbers/icons/mob/actions/bloodsucker.dmi'
	active_background_icon_state = "vamp_power_on"
	background_icon_state = "vamp_power_off"


/datum/action/cooldown/hemophage/toggle_dormant_state/Activate(atom/action_target)
	if(!owner || !ishuman(owner) || !target)
		return

	var/obj/item/organ/heart/hemophage/tumor = target
	if(!tumor || !istype(tumor)) // This shouldn't happen, but you can never be too careful.
		return

	owner.balloon_alert(owner, "[tumor.is_dormant ? "正在离开" : "正在进入"]休眠状态")

	if(!do_after(owner, 3 SECONDS))
		owner.balloon_alert(owner, "状态切换已取消")
		return

	to_chat(owner, span_notice("[tumor.is_dormant ? DORMANT_STATE_END_MESSAGE : DORMANT_STATE_START_MESSAGE]"))

	StartCooldown()

	tumor.toggle_dormant_state()
	tumor.toggle_dormant_tumor_vulnerabilities(owner)

	if(tumor.is_dormant)
		name = "退出休眠状态"
		desc =  "使你体内那团漆黑之物苏醒过来，让血液循环恢复，血液重新自由流淌。它重新充满你的双腿，让你再次奔跑，并像从前那样渴望着黑暗。你开始感到力量，而非先前的虚弱。然而，赋予你生命的肿瘤并不是可以随意切换的开关，再次压制它需要一些时间。"
	else
		name = initial(name)
		desc = initial(desc)


#undef DORMANT_STATE_START_MESSAGE
#undef DORMANT_STATE_END_MESSAGE
