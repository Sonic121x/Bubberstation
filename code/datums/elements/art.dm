/datum/element/art
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH_ON_HOST_DESTROY // Detach for turfs
	argument_hash_start_idx = 2
	var/impressiveness = 0

/datum/element/art/Attach(datum/target, impress)
	. = ..()
	if(!isatom(target) || isarea(target))
		return ELEMENT_INCOMPATIBLE
	impressiveness = impress
	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/element/art/Detach(datum/target)
	UnregisterSignal(target, COMSIG_ATOM_EXAMINE)
	return ..()

/datum/element/art/proc/apply_moodlet(atom/source, mob/living/user, impress)
	SIGNAL_HANDLER

	var/msg
	switch(impress)
		if(GREAT_ART to INFINITY)
			user.add_mood_event("artgreat", /datum/mood_event/artgreat)
			msg = "真是一件[pick("杰作", "传世之作")]。简直[pick("超凡脱俗", "令人叹服", "令人着迷", "无可挑剔")]！"
		if (GOOD_ART to GREAT_ART)
			user.add_mood_event("artgood", /datum/mood_event/artgood)
			msg = "这是一件[pick("可圈可点", "值得称赞", "值得赞赏")]的艺术品，令人赏心悦目。"
		if (BAD_ART to GOOD_ART)
			user.add_mood_event("artok", /datum/mood_event/artok)
			msg = "这件作品平平无奇，勉强能被称为“艺术品”。"
		if (0 to BAD_ART)
			user.add_mood_event("artbad", /datum/mood_event/artbad)
			msg = "哇，真是烂透了。"

	user.visible_message(span_notice("[user]停下脚步，仔细端详[source]。"), \
		span_notice("你鉴赏着[source]……[msg]"))

/datum/element/art/proc/on_examine(atom/source, mob/user, list/examine_texts)
	SIGNAL_HANDLER
	if(!isliving(user))
		return
	if(!DOING_INTERACTION_WITH_TARGET(user, source))
		INVOKE_ASYNC(src, PROC_REF(appraise), source, user) //Do not sleep the proc.

/datum/element/art/proc/appraise(atom/source, mob/user)
	to_chat(user, span_notice("你开始鉴赏[source]……"))
	if(!do_after(user, 2 SECONDS, target = source))
		return
	var/mult = 1
	if(source.uses_integrity)
		mult = source.get_integrity() / source.max_integrity
	apply_moodlet(source, user, impressiveness * mult)

/datum/element/art/rev

/datum/element/art/rev/apply_moodlet(atom/source, mob/living/user, impress)
	var/msg
	if(user.mind?.has_antag_datum(/datum/antagonist/rev))
		user.add_mood_event("artgreat", /datum/mood_event/artgreat)
		msg = "真是一件[pick("杰作", "传世之作")]。如此[pick("颠覆传统", "富有革命精神", "凝聚人心", "体现平等")]！"
	else
		user.add_mood_event("artbad", /datum/mood_event/artbad)
		msg = "哇，真是烂透了。"

	user.visible_message(span_notice("[user]停下来仔细查看[source]。"), \
		span_notice("你鉴赏[source]，审视着无产阶级的精湛工艺……[msg]"))

/datum/element/art/commoner

/datum/element/art/commoner/apply_moodlet(atom/source, mob/living/user, impress)
	var/msg
	var/list/haters = list()
	for(var/hater_department_type in list(/datum/job_department/security, /datum/job_department/command))
		var/datum/job_department/hater_department = SSjob.get_department_type(hater_department_type)
		if (isnull(hater_department))
			continue
		for(var/datum/job/hater_job as anything in hater_department.department_jobs)
			haters += hater_job.title
	var/datum/job/quartermaster/fucking_quartermaster = SSjob.get_job_type(/datum/job/quartermaster)
	haters += fucking_quartermaster.title

	if(!(user.mind.assigned_role.title in haters))
		user.add_mood_event("artgreat", /datum/mood_event/artgreat)
		msg = "真是一件[pick("杰作", "传世之作")]。如此[pick("引人共鸣", "贴近生活", "真诚", "真实")]！"
	else
		user.add_mood_event("artbad", /datum/mood_event/artbad)
		msg = "哇，真是烂透了。"

	user.visible_message(span_notice("[user]停下来仔细查看[source]。"), \
		span_notice("你鉴赏[source]，审视着无产阶级的精湛工艺……[msg]"))
