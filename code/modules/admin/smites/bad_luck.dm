/// Gives the target bad luck, optionally permanently
/datum/smite/bad_luck
	name = "霉运"

	/// Should the target know they've received bad luck?
	var/silent

	/// Is this permanent?
	var/incidents

/datum/smite/bad_luck/configure(client/user)
	silent = tgui_alert(user, "是否要在向玩家发出提示的情况下施加凶兆？", "通知玩家？", list("Notify", "Silent")) == "Silent"
	incidents = tgui_input_number(user, "凶兆会持续多少次事件？0 表示永久。", "持续时间？", default = 0, round_value = 1)
	if(incidents == 0)
		incidents = INFINITY

/datum/smite/bad_luck/effect(client/user, mob/living/target)
	. = ..()
	//if permanent, replace any existing omen
	if(incidents == INFINITY)
		qdel(target.GetComponent(/datum/component/omen))
	target.AddComponent( \
		/datum/component/omen, \
		incidents_left = incidents, \
		on_death = CALLBACK(src, PROC_REF(on_death)), \
		bless_fixable = incidents != INFINITY, \
	)
	if(silent)
		return
	to_chat(target, span_warning("你感到一阵不祥的预感……"))
	if(incidents == INFINITY)
		to_chat(target, span_warning("一种<b>极其</b>不祥的预感……仿佛有恶意的力量正注视着你……"))

/datum/smite/bad_luck/proc/on_death(datum/component/omen/omen)
	if(omen.incidents_left == INFINITY)
		return

	var/mob/living/our_guy = omen.parent
	omen.death_explode(our_guy)
	our_guy.gib(DROP_ALL_REMAINS)
