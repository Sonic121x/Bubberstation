/**
 * Gives the wizard a defensive/mood buff and a Wabbajack, a juiced up chaos staff that will surely break something.
 * Everyone but the wizard goes crazy, suffers major brain damage, and is given a vendetta against the wizard.
 * Already insane people are instead cured of their madness, ignoring any other effects as the station around them loses its marbles.
 */
/datum/grand_finale/cheese
	// we don't set name, desc and others, thus we won't appear in the radial choice of a normal finale rune
	dire_warning = TRUE
	minimum_time = 45 MINUTES //i'd imagine speedrunning this would be crummy, but the wizard's average lifespan is barely reaching this point

/datum/grand_finale/cheese/trigger(mob/living/invoker)
	message_admins("[key_name(invoker)] 召唤出了瓦巴杰克，并以疯狂诅咒了全体船员！")
	priority_announce("危险：空间站上已被召唤出极度强效的、能改变现实的物体。建议立即疏散。请做好冲击准备。", "[command_name()] 高维事务部", 'sound/effects/glass/glassbr1.ogg')

	for (var/mob/living/carbon/human/crewmate as anything in GLOB.human_list)
		if (isnull(crewmate.mind))
			continue
		if (crewmate == invoker) //everyone but the wizard is royally fucked, no matter who they are
			continue
		if (crewmate.has_trauma_type(/datum/brain_trauma/mild/hallucinations)) //for an already insane person, this is retribution
			to_chat(crewmate, span_boldwarning("你周围突然充斥着狂乱笑声与胡言乱语组成的嘈杂声……"))
			to_chat(crewmate, span_nicegreen("……但片刻过后，你意识到引发此事的某种邪异力量恰好影响到了你——\
				它在你早已破碎的心智废墟中产生共鸣，形成了一个精神错乱的奇点！\
				当它向内坍缩时，你感到……终于，安宁了。"))
			if(crewmate.has_quirk(/datum/quirk/insanity))
				crewmate.remove_quirk(/datum/quirk/insanity)
			else
				crewmate.cure_trauma_type(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		else
			//everyone else gets to relish in madness
			//yes killing their mood will also trigger mood hallucinations
			create_vendetta(crewmate.mind, invoker.mind)
			to_chat(crewmate, span_boldwarning("你周围突然充斥着狂乱笑声与胡言乱语组成的嘈杂声。 \n\
				你感到自己的内心世界碎成无数片参差不齐的玻璃，折射着宇宙从未见过的色彩，\
				无休止地映照出从你被摧毁的心智最深处射来的、刺眼而令人发狂的光芒。 \n\
				在短暂得仿佛千年的停顿之后，一句话在你脑中无休止地回荡，带着虚假的赦免希望…… \n\
				<b>[invoker]必须死。</b>"))
			var/datum/brain_trauma/mild/hallucinations/added_trauma = new()
			added_trauma.resilience = TRAUMA_RESILIENCE_ABSOLUTE
			crewmate.adjust_organ_loss(ORGAN_SLOT_BRAIN, BRAIN_DAMAGE_DEATH - 25, BRAIN_DAMAGE_DEATH - 25) //you'd better hope chap didn't pick a hypertool
			crewmate.gain_trauma(added_trauma)
			crewmate.add_mood_event("wizard_ritual_finale", /datum/mood_event/madness_despair)

	//drip our wizard out
	invoker.apply_status_effect(/datum/status_effect/blessing_of_insanity)
	invoker.add_mood_event("wizard_ritual_finale", /datum/mood_event/madness_elation)
	var/obj/item/gun/magic/staff/chaos/true_wabbajack/the_wabbajack = new
	invoker.put_in_active_hand(the_wabbajack)
	to_chat(invoker, span_mind_control("当[the_wabbajack]出现在你紧握的手中时，你的每一种本能和每一点理性都在对你尖叫……"))
