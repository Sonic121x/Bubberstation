/datum/bloodsucker_clan/gangrel
	name = CLAN_GANGREL
	description = "比起吸血鬼，他们更接近野兽，被称为随时可能化身的狼人。\n\
		他们最惧怕真信仰，那是他们在黑夜中可能遭遇的最致命之物。\n\
		尽管传说广为流传，满月似乎并不会影响他们。\n\
		主人变成狼人时，宠爱血仆也会一同变身。"
	joinable_clan = FALSE
	blood_drink_type = BLOODSUCKER_DRINK_INHUMANELY

/datum/bloodsucker_clan/gangrel/on_enter_frenzy(datum/antagonist/bloodsucker/source)
	ADD_TRAIT(bloodsuckerdatum.owner.current, TRAIT_STUNIMMUNE, FRENZY_TRAIT)

/datum/bloodsucker_clan/gangrel/on_exit_frenzy(datum/antagonist/bloodsucker/source)
	REMOVE_TRAIT(bloodsuckerdatum.owner.current, TRAIT_STUNIMMUNE, FRENZY_TRAIT)

/datum/bloodsucker_clan/gangrel/handle_clan_life(datum/antagonist/bloodsucker/source, seconds_per_tick, times_fired)
	. = ..()
	var/area/current_area = get_area(bloodsuckerdatum.owner.current)
	if(istype(current_area, /area/station/service/chapel))
		to_chat(bloodsuckerdatum.owner.current, span_warning("你不属于神圣之地！信仰将你烧得焦黑！"))
		bloodsuckerdatum.owner.current.adjust_fire_loss(20)
		bloodsuckerdatum.owner.current.adjust_fire_stacks(2)
		bloodsuckerdatum.owner.current.ignite_mob()

/datum/bloodsucker_clan/toreador
	name = CLAN_TOREADOR
	description = "所有氏族中最具魅力的一族，能够轻易伪装并融入船员。\n\
		他们更重视道德，因此自身行为带来的人性损失或增长，影响也更为强烈。\n\
		他们被称为‘最具人性的吸血鬼’，痴迷于完美与美丽。\n\
		宠爱血仆会获得摄魂能力。"
	joinable_clan = FALSE
	blood_drink_type = BLOODSUCKER_DRINK_SNOBBY

/datum/bloodsucker_clan/brujah
	name = CLAN_BRUJAH
	description = "布鲁赫氏族已被证明是最擅长近战的氏族，拳击威力惊人。\n\
		他们似乎比其他氏族更冷静，可以随时进入‘狂暴’，却似乎不会受到太大影响。\n\
		务必小心，他们是可怕的战士、反叛者和无政府主义者，并且倾向于狂暴。\n\
		宠爱血仆会获得蛮力，拳击造成的蛮力伤害也会大幅提升。"
	joinable_clan = FALSE

/datum/bloodsucker_clan/tzimisce
	name = CLAN_TZIMISCE
	description = "关于茨密希氏族，尚无已知资料。\n\
		如果你遇见他们，最好赶紧逃走。\n\
		*这一页的其余部分写满了无法辨认的涂鸦……*"
	joinable_clan = FALSE
