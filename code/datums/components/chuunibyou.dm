
/// how much health healed from casting a chuuni spell
#define CHUUNIBYOU_HEAL_AMOUNT 3
///cooldown between healing to prevent stuff like instant blink spell spam healing
#define CHUUNIBYOU_COOLDOWN_TIME 5 SECONDS

/**
 * ## chuunibyou component!
 *
 * Component that makes casted spells always a shout invocation, a very dumb one. And their projectiles are dumb too.
 * Oh, but it does heal after each spell cast.
 */
/datum/component/chuunibyou
	/// invocations per school the spell is from
	var/static/list/chuunibyou_invocations
	/// amount healed per spell cast
	var/heal_amount = CHUUNIBYOU_HEAL_AMOUNT
	/// cooldown for healing
	COOLDOWN_DECLARE(heal_cooldown)
	/// are we casting a spell right now
	var/casting_spell = FALSE

/datum/component/chuunibyou/Initialize()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	if(!chuunibyou_invocations)
		chuunibyou_invocations = list(
			SCHOOL_UNSET = "太尴尬了……我忘了咒语……呃……也许这样挥挥手就行……不，没用——啊！成功了！",
			SCHOOL_HOLY = "以圣者的恩典，我召唤救赎之光。愿吾友欢欣。苍天啊！赐福于他们！",
			SCHOOL_PSYCHIC = "以隐秘者的奥义，我揭示创世的真相。愿我心智开拓。奥秘啊！启迪我！",
			SCHOOL_MIME = "寂静啊！拥抱我的灵魂，增强我的手势。让我创造幻象，操纵感知！",
			SCHOOL_RESTORATION = "我呼唤慈悲女神之名，请聆听我的祈求，赐福于这个灵魂！神圣恩典！",

			SCHOOL_EVOCATION = "见识漆黑烈焰使的终极力量吧！我召唤远古的混沌与毁灭之力，向我的敌人倾泻怒火！",
			SCHOOL_TRANSMUTATION = "我唤起等价交换之律，宇宙平衡之理。我献上祭品，要求全新的造物。显现吧，嬗变之奥秘！",
			SCHOOL_TRANSLOCATION = "凭借空间裂隙之力，我扭曲现实，跨越维度！前往目的地之时，万物皆不得阻挡我的道路！",
			SCHOOL_CONJURATION = "以命运之眼，我看透宿命的丝线。万物在我面前无所遁形。见证我，见证显现的奇迹！",

			SCHOOL_NECROMANCY = "我是亡者之主，白骨之王，暗影的统治者。我命令受诅咒的军团从坟墓中崛起，为我效命！",
			SCHOOL_FORBIDDEN = "我摒弃此世的法则，拥抱古神的混沌！让禁忌之力流经我身，摧毁沿途的一切！",
			SCHOOL_SANGUINE = "我以眼罩遮住一只眼睛，封印真正的力量，如今就将它释放于你身上。我吞噬猎物的生命力，每一滴都让我更强大！",
		)

/datum/component/chuunibyou/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOB_SPELL_PROJECTILE, PROC_REF(on_spell_projectile))
	RegisterSignal(parent, COMSIG_MOB_PRE_INVOCATION, PROC_REF(on_pre_invocation))
	RegisterSignal(parent, COMSIG_MOB_TRY_SPEECH, PROC_REF(on_try_speech))
	RegisterSignal(parent, COMSIG_MOB_AFTER_SPELL_CAST, PROC_REF(on_after_spell_cast))
	ADD_TRAIT(parent, TRAIT_CHUUNIBYOU, REF(src))

/datum/component/chuunibyou/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(
		COMSIG_MOB_SPELL_PROJECTILE,
		COMSIG_MOB_PRE_INVOCATION,
		COMSIG_MOB_TRY_SPEECH,
		COMSIG_MOB_AFTER_SPELL_CAST,
	))
	REMOVE_TRAIT(parent, TRAIT_CHUUNIBYOU, REF(src))

/// signal sent when the parent tries to speak. we let speech pass if we are casting a spell so mimes still chuuni their spellcasts
/// (this may end in the mime dying)
/datum/component/chuunibyou/proc/on_try_speech(datum/source, message, ignore_spam, forced)
	SIGNAL_HANDLER

	if(casting_spell && !HAS_TRAIT(src, TRAIT_MUTE))
		return COMPONENT_IGNORE_CAN_SPEAK

///signal sent when the parent casts a spell that has a projectile
/datum/component/chuunibyou/proc/on_spell_projectile(mob/living/source, datum/action/cooldown/spell/spell, atom/cast_on, obj/projectile/to_fire)
	SIGNAL_HANDLER

	playsound(to_fire,'sound/effects/magic/staff_change.ogg', 75, TRUE)
	to_fire.color = "#f825f8"
	to_fire.name = "中二版[to_fire.name]"
	to_fire.set_light(2, 2, LIGHT_COLOR_PINK, l_on = TRUE)

///signal sent before parent invokes a spell
/datum/component/chuunibyou/proc/on_pre_invocation(mob/living/source, datum/action/cooldown/spell/spell, list/invocation_list)
	SIGNAL_HANDLER

	// this makes it bypass speech checks (being a mime) until the spell is done casting
	// this lets mimes cast with it, but, um... might get them lynched
	casting_spell = TRUE
	invocation_list[INVOCATION_TYPE] = INVOCATION_SHOUT
	invocation_list[INVOCATION_GARBLE_PROB] = 0
	var/chuuni_invocation = chuunibyou_invocations[spell.school]
	if(!chuuni_invocation) // someone forgot to update the CHUUNI LIST to include a desc for the new school
		stack_trace("Chunnibyou invocations is missing a line for spell school \"[spell.school]\"")
		chuuni_invocation = chuunibyou_invocations[SCHOOL_UNSET]
	invocation_list[INVOCATION_MESSAGE] = chuuni_invocation

///signal sent after parent casts a spell
/datum/component/chuunibyou/proc/on_after_spell_cast(mob/living/source, datum/action/cooldown/spell/spell, atom/cast_on)
	SIGNAL_HANDLER

	casting_spell = FALSE
	if(!COOLDOWN_FINISHED(src, heal_cooldown))
		to_chat(source, span_danger("你的中二之力仍在冷却！治疗失败！"))
		return
	COOLDOWN_START(src, heal_cooldown, CHUUNIBYOU_COOLDOWN_TIME)

	source.heal_overall_damage(heal_amount)
	playsound(source, 'sound/effects/magic/staff_healing.ogg', 30)
	to_chat(source, span_danger("你感觉中二之力稍微治愈了你。"))

/datum/component/chuunibyou/no_healing
	heal_amount = 0

#undef CHUUNIBYOU_HEAL_AMOUNT
#undef CHUUNIBYOU_COOLDOWN_TIME
