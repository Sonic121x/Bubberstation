/datum/job/chaplain
	title = JOB_CHAPLAIN
	description = "主持礼拜与葬礼，火化亡者，宣讲你的\
		宗教，保护船员免受邪教侵害。"
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_HOP
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "CHAPLAIN"

	outfit = /datum/outfit/job/chaplain
	plasmaman_outfit = /datum/outfit/plasmaman/chaplain

	mind_traits = list(TRAIT_SPIRITUAL)
	desensitized_base = DESENSITIZED_THRESHOLD

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_CHAPLAIN
	departments_list = list(
		/datum/job_department/service,
		)

	family_heirlooms = list(/obj/item/toy/windup_toolbox, /obj/item/reagent_containers/cup/glass/bottle/holywater)

	mail_goodies = list(
		/obj/item/reagent_containers/cup/glass/bottle/holywater = 30,
		/obj/item/grenade/chem_grenade/holy = 5,
		/obj/item/toy/plush/narplush = 2,
		/obj/item/toy/plush/ratplush = 1
	)
	rpg_title = "圣骑士"
	job_flags = STATION_JOB_FLAGS

	voice_of_god_power = 2 //Chaplains are very good at speaking with the voice of god

	job_tone = "holy"


/datum/job/chaplain/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(!ishuman(spawned))
		return
	var/mob/living/carbon/human/human_spawned = spawned
	var/obj/item/book/bible/booze/holy_bible = new
	if(GLOB.religion)
		if(human_spawned.mind)
			human_spawned.mind.set_holy_role(HOLY_ROLE_PRIEST)
		holy_bible.deity_name = GLOB.deity
		holy_bible.name = GLOB.bible_name
		// These checks are important as there's no guarantee the "HOLY_ROLE_HIGHPRIEST" chaplain has selected a bible skin.
		if(GLOB.bible_icon_state)
			holy_bible.icon_state = GLOB.bible_icon_state
		if(GLOB.bible_inhand_icon_state)
			holy_bible.inhand_icon_state = GLOB.bible_inhand_icon_state
		to_chat(human_spawned, span_boldnotice("空间站上已经有既定的宗教了。你是 [GLOB.deity] 的侍僧。听从牧师的安排。"))
		human_spawned.equip_to_storage(holy_bible, ITEM_SLOT_BACK, indirect_action = TRUE, del_on_fail = TRUE)
		var/nrt = GLOB.holy_weapon_type || /obj/item/nullrod
		var/obj/item/nullrod/nullrod = new nrt(human_spawned)
		human_spawned.put_in_hands(nullrod)
		if(GLOB.religious_sect)
			GLOB.religious_sect.on_conversion(human_spawned)
		return
	if(human_spawned.mind)
		human_spawned.mind.set_holy_role(HOLY_ROLE_HIGHPRIEST)

	var/new_religion = player_client?.prefs?.read_preference(/datum/preference/name/religion) || DEFAULT_RELIGION
	var/new_deity = player_client?.prefs?.read_preference(/datum/preference/name/deity) || DEFAULT_DEITY
	var/new_bible = player_client?.prefs?.read_preference(/datum/preference/name/bible) || DEFAULT_BIBLE

	holy_bible.deity_name = new_deity
	switch(LOWER_TEXT(new_religion))
		if("homosexuality", "gay", "penis", "ass", "cock", "cocks")
			new_bible = pick("猛男狂欢","出柜","雄鸡之战")
			switch(new_bible)
				if("雄鸡之战")
					holy_bible.deity_name = pick("迪克·鲍尔斯", "雄鸡之王")
				else
					holy_bible.deity_name = pick("太空同志耶稣", "甘道夫", "邓布利多")
			human_spawned.adjust_organ_loss(ORGAN_SLOT_BRAIN, 100) // starts off brain damaged as fuck
		if("lol", "wtf", "poo", "badmin", "shitmin", "deadmin", "meme", "memes", "skibidi")
			new_bible = pick("伍迪有木头：余波", "甜哥与地狱杰夫：扩展版","F.A.T.A.L. 规则书", "厕所幽默")
			switch(new_bible)
				if("伍迪有木头：余波")
					holy_bible.deity_name = pick("伍迪", "安迪", "樱桃味润滑液")
				if("甜哥与地狱杰夫：扩展版")
					holy_bible.deity_name = pick("甜哥", "地狱杰夫", "楼梯", "啊")
				if("F.A.T.A.L. 规则书")
					holy_bible.deity_name = "二十颗十面骰"
				if("厕所幽默")
					holy_bible.deity_name = pick("斯基比迪马桶", "斯基比迪巫师", "斯基比迪浴缸", "约翰·斯基比迪", "斯基比迪斯基比迪", "G 马桶 1.0", "约翰·弗里曼")
			human_spawned.adjust_organ_loss(ORGAN_SLOT_BRAIN, 100) // also starts off brain damaged as fuck
		if("servicianism", "partying")
			holy_bible.desc = "快乐、饱足、洁净。亲身践行，并传播出去。"
		if("weeaboo","kawaii")
			new_bible = pick("同人小说汇编","傻瓜日语","漫画死灵书","确立你的本命配对")
			holy_bible.deity_name = "动漫"
		else
			if(new_bible == DEFAULT_BIBLE)
				new_bible = DEFAULT_BIBLE_REPLACE(new_bible)

	holy_bible.name = new_bible

	GLOB.religion = new_religion
	GLOB.bible_name = new_bible
	GLOB.deity = holy_bible.deity_name

	human_spawned.equip_to_storage(holy_bible, ITEM_SLOT_BACK, indirect_action = TRUE, del_on_fail = TRUE)

	SSblackbox.record_feedback("text", "religion_name", 1, "[new_religion]", 1)
	SSblackbox.record_feedback("text", "religion_deity", 1, "[new_deity]", 1)
	SSblackbox.record_feedback("text", "religion_bible", 1, "[new_bible]", 1)

/datum/outfit/job/chaplain
	name = "Chaplain"
	jobtype = /datum/job/chaplain

	id_trim = /datum/id_trim/job/chaplain
	uniform = /obj/item/clothing/under/rank/civilian/chaplain
	backpack_contents = list(
		/obj/item/camera/spooky = 1,
		/obj/item/stamp/chap = 1,
		)
	belt = /obj/item/modular_computer/pda/chaplain
	ears = /obj/item/radio/headset/headset_srv

	backpack = /obj/item/storage/backpack/cultpack
	satchel = /obj/item/storage/backpack/cultpack

	chameleon_extras = /obj/item/stamp/chap
	skillchips = list(/obj/item/skillchip/entrails_reader)
