/datum/heretic_knowledge/trickster_pen
	name = "诡戏者之笔"
	desc = "让你能将一支笔和一片固态等离子转化为诡戏者之笔，可以修改\
	任何身份证的姓名、职位和外观。按动这支笔可让你暂时半透明。最好与诡戏者面具搭配使用。"
	gain_text = "流血诡戏者改写语言与形态，以便更好地隐藏自己。A变为Z，红变为蓝，转瞬之间，\
	这位微笑的神便与周围的一切毫无分别。"
	required_atoms = list(
		/obj/item/pen = 1,
		/obj/item/stack/sheet/mineral/plasma = 1,
	)
	result_atoms = list(/obj/item/pen/trickster)
	drafting_cost = 1
	drafting_tier = 1
	research_tree_icon_path = 'icons/obj/service/bureaucracy.dmi'
	research_tree_icon_state = "pen"

/obj/item/pen/trickster
	name = "奇异的笔"
	desc = "一支不断扭动变形的笔——然而握住它时，你总能找到着力之处。"
	COOLDOWN_DECLARE(stealth_cooldown)
	var/static/list/chameleon_whitelist
	var/static/list/chameleon_blacklist
	var/static/list/pickable_trims

/obj/item/pen/trickster/Initialize(mapload)
	. = ..()

	apply_wibbly_filters(src)
	RegisterSignal(src, COMSIG_ITEM_INTERACTING_WITH_ATOM, PROC_REF(on_atom_interact))

	if (isnull(pickable_trims))
		chameleon_whitelist = typecacheof(list(
				/datum/id_trim/battlecruiser,
				/datum/id_trim/bit_avatar,
				/datum/id_trim/bounty_hunter,
				/datum/id_trim/centcom,
				/datum/id_trim/job,
				/datum/id_trim/pirate,
				/datum/id_trim/syndicom,
				/datum/id_trim/technician_id,
			))
		chameleon_blacklist = typecacheof(/datum/id_trim/centcom/corpse)
		pickable_trims = list()

		for(var/trim_path in chameleon_whitelist)
			if(is_type_in_typecache(trim_path, chameleon_blacklist))
				continue

			var/datum/id_trim/trim = SSid_access.trim_singletons_by_path[trim_path]

			if(trim && trim.trim_state && trim.assignment)
				pickable_trims[trim.assignment] = trim_path

/obj/item/pen/trickster/examine(mob/user)
	. = ..()
	if (IS_HERETIC_OR_MONSTER(user))
		. += span_notice("这是诡戏者之笔，来自流血诡戏者本尊的礼物。对身份证使用，可以修改\
		姓名、职位等信息。")
		. += span_notice("按动它还可以让你暂时变得半透明。")

/obj/item/pen/trickster/attack_self(mob/user, modifiers)
	. = ..()

	if (!IS_HERETIC_OR_MONSTER(user))
		return
	if (COOLDOWN_FINISHED(src, stealth_cooldown))
		animate(user, alpha = 25, 0.5 SECONDS)
		to_chat(user, span_warning("你按动笔杆，发现自己的身影逐渐淡去。"))
		COOLDOWN_START(src, stealth_cooldown, 30 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(clear_stealth), user), 10 SECONDS)

/obj/item/pen/trickster/proc/clear_stealth(mob/user)
	animate(user, alpha = initial(user.alpha), 0.5 SECONDS)
	to_chat(user, span_warning("遮蔽你身形的魔法消退了！"))

/obj/item/pen/trickster/proc/on_atom_interact(datum/source, mob/living/user, atom/interacting_with, list/modifiers)
	SIGNAL_HANDLER

	if (!istype(interacting_with, /obj/item/card/id/advanced))
		return NONE
	if (!IS_HERETIC_OR_MONSTER(user))
		return NONE

	INVOKE_ASYNC(src, PROC_REF(do_id_rename), user, interacting_with)

	return ITEM_INTERACT_SUCCESS

/obj/item/pen/trickster/proc/do_id_rename(mob/living/user, obj/item/card/id/advanced/id_card)
	///forge the ID if not forged.
	var/input_name = tgui_input_text(user, "想在卡上写什么姓名？留空则随机生成。", "新姓名", id_card.registered_name ? id_card.registered_name : (ishuman(user) ? user.real_name : user.name), max_length = MAX_NAME_LEN, encode = FALSE)

	if(!id_card.after_input_check(user))
		return NONE

	if(input_name)
		input_name = sanitize_name(input_name, allow_numbers = TRUE)
	if(!input_name)
		// Invalid/blank names give a randomly generated one.
		if(user.gender == MALE)
			input_name = "[pick(GLOB.first_names_male)] [pick(GLOB.last_names)]"
		else if(user.gender == FEMALE)
			input_name = "[pick(GLOB.first_names_female)] [pick(GLOB.last_names)]"
		else
			input_name = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]"

	var/target_occupation = chinese_heretic_job_input(user, "想在卡上写什么职位？\n注意：这不会授予任何权限。", "特工卡职位设置", id_card.assignment ? id_card.assignment : "Assistant")
	if(!id_card.after_input_check(user))
		return NONE
	var/default_age = AGE_MIN
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		default_age = human_user.age ? clamp(human_user.age, AGE_MIN, AGE_MAX) : AGE_MIN
	var/new_age = tgui_input_number(user, "选择身份证上的年龄", "年龄", default_age, AGE_MAX, AGE_MIN)
	if(!id_card.after_input_check(user))
		return NONE

	var/new_trim_name = chinese_job_choice(user, "选择身份证的饰条", "饰条", pickable_trims)
	var/new_trim = pickable_trims[new_trim_name]
	if(!id_card.after_input_check(user))
		return NONE

	var/wallet_spoofing = tgui_alert(user, "启用钱包身份伪装，让这张卡强制成为钱包中对外显示的身份证吗？", "钱包身份伪装", list("是", "否"))
	if(!id_card.after_input_check(user))
		return NONE

	id_card.registered_name = input_name
	if(target_occupation)
		id_card.assignment = sanitize(target_occupation)
	if(new_age)
		id_card.registered_age = new_age
	if(wallet_spoofing == "是")
		ADD_TRAIT(id_card, TRAIT_MAGNETIC_ID_CARD, CHAMELEON_ITEM_TRAIT)
	if (new_trim)
		SSid_access.apply_trim_override(id_card, new_trim)

	id_card.update_label()
	id_card.update_appearance()
	to_chat(user, span_notice("卡片在笔尖周围闪烁变形。很快，它便焕然一新。"))
	user.log_message("forged \the [initial(id_card.name)] with name \"[id_card.registered_name]\", occupation \"[id_card.assignment]\" and trim \"[id_card.trim?.assignment]\" with [src].", LOG_GAME)
