/datum/station_trait/hos_ai
	name = "安保主管 AI"
	trait_type = STATION_TRAIT_NEGATIVE
	trait_flags = parent_type::trait_flags | STATION_TRAIT_REQUIRES_AI
	weight = 0
	show_in_report = TRUE
	report_message = "出于实验目的，本站 AI 已被任命为安保部门负责人，本班次允许使用安保型半机械人。\
	除非绝对必要，否则不要修改硅基法律。请将 AI 视为指挥部成员及安保主管。"
	blacklist = list(/datum/station_trait/job/human_ai, /datum/station_trait/unique_ai)
	trait_to_give = STATION_TRAIT_HOS_AI

/datum/station_trait/hos_ai/New()
	. = ..()
	SSstation.antag_restricted_roles += /datum/job/ai::title

/datum/station_trait/hos_ai/revert()
	SSstation.antag_restricted_roles -= /datum/job/ai::title
	return ..()

/datum/station_trait/hos_ai/on_round_start()
	. = ..()
	for(var/mob/living/silicon/ai/ai as anything in GLOB.ai_list)
		ai.show_laws()

///Another potentially bad idea to fit in this file (I'm full of these)
/datum/station_trait/head_antags
	name = "背景调查预算削减"
	trait_type = STATION_TRAIT_NEGATIVE
	trait_flags = parent_type::trait_flags
	weight = 3
	show_in_report = FALSE
	trait_to_give = STATION_TRAIT_HEAD_ANTAG
