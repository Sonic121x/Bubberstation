#define TAUNT_STAMINA_COST 19

/obj/item/skillchip/matrix_taunt
	name = "BULLET_DODGER 技能芯片"
	desc = "在短暂的时间窗口内超频、覆写并过载你的运动感觉、本体感受与反射，从而 \
		自动躲开射来的投射物。做出嘲讽动作即可激活。"
	skill_name = "嘲讽闪避"
	skill_description = "以消耗体力为代价，你的嘲讽动作也能用来躲避来袭的投射物。"
	skill_icon = FA_ICON_SPINNER
	activate_message = span_notice("你感到一股想要戏剧性地嘲讽对手的冲动，仿佛自己就是“天选之人”。")
	deactivate_message = span_notice("嘲讽的冲动消失了。")

/obj/item/skillchip/matrix_taunt/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_EMOTED("taunt"), PROC_REF(on_taunt))
	RegisterSignal(user, COMSIG_MOB_PRE_EMOTED, PROC_REF(check_if_we_can_taunt))

/obj/item/skillchip/matrix_taunt/on_deactivate(mob/living/carbon/user, silent=FALSE)
	UnregisterSignal(user, list(COMSIG_MOB_EMOTED("taunt"), COMSIG_MOB_PRE_EMOTED))
	return ..()

///Prevent players from stamcritting from INTENTIONAL flips. 1.4s of bullet immunity isn't worth several secs of stun.
/obj/item/skillchip/matrix_taunt/proc/check_if_we_can_taunt(mob/living/source, key, params, type_override, intentional, datum/emote/emote)
	SIGNAL_HANDLER
	if(key != "taunt" || !intentional)
		return
	if((source.maxHealth - (source.get_stamina_loss() + TAUNT_STAMINA_COST)) <= source.crit_threshold)
		source.balloon_alert(source, "太累了！")
		return COMPONENT_CANT_EMOTE

/obj/item/skillchip/matrix_taunt/proc/on_taunt(mob/living/source)
	SIGNAL_HANDLER
	if(HAS_TRAIT_FROM(source, TRAIT_UNHITTABLE_BY_PROJECTILES, SKILLCHIP_TRAIT))
		return
	ADD_TRAIT(source, TRAIT_UNHITTABLE_BY_PROJECTILES, SKILLCHIP_TRAIT)
	source.adjust_stamina_loss(TAUNT_STAMINA_COST)
	addtimer(TRAIT_CALLBACK_REMOVE(source, TRAIT_UNHITTABLE_BY_PROJECTILES, SKILLCHIP_TRAIT), TAUNT_EMOTE_DURATION * 1.5)

#undef TAUNT_STAMINA_COST
