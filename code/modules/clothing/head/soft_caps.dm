/obj/item/clothing/head/soft
	name = "货运帽"
	desc = "一顶品味不俗的棕色棒球帽。"
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	icon_state = "cargosoft"
	inhand_icon_state = "greyscale_softcap" //todo wip
	interaction_flags_click = NEED_DEXTERITY|ALLOW_RESTING
	/// For setting icon archetype
	var/soft_type = "cargo"
	/// If there is a suffix to append
	var/soft_suffix = "soft"

	dog_fashion = /datum/dog_fashion/head/cargo_tech
	/// Whether this is on backwards... Woah, cool
	var/flipped = FALSE

/obj/item/clothing/head/soft/dropped()
	icon_state = "[soft_type][soft_suffix]"
	flipped = FALSE
	..()

GAME_VERB(/obj/item/clothing/head/soft, flipcap, "翻转帽子", null)

	flip(usr)


/obj/item/clothing/head/soft/click_alt(mob/user)
	flip(user)
	return CLICK_ACTION_SUCCESS


/obj/item/clothing/head/soft/proc/flip(mob/user)
	if(!user.incapacitated)
		flipped = !flipped
		if(flipped)
			icon_state = "[soft_type][soft_suffix]_flipped"
			to_chat(user, span_notice("你把帽子反着翻转过来。"))
		else
			icon_state = "[soft_type][soft_suffix]"
			to_chat(user, span_notice("你把帽子翻回正常位置。"))
		update_icon()
		usr.update_worn_head() //so our mob-overlays update

/obj/item/clothing/head/soft/examine(mob/user)
	. = ..()
	. += span_notice("按住 Alt 点击帽子可将其[flipped ? "向前" : "向后"]翻转。")

/obj/item/clothing/head/soft/red
	name = "红帽"
	desc = "一顶品味糟糕的红色棒球帽。"
	icon_state = "redsoft"
	soft_type = "red"
	dog_fashion = null

/obj/item/clothing/head/soft/blue
	name = "蓝帽"
	desc = "一顶品味糟糕的蓝色棒球帽。"
	icon_state = "bluesoft"
	soft_type = "blue"
	dog_fashion = null

/obj/item/clothing/head/soft/green
	name = "绿帽"
	desc = "一顶品味糟糕的绿色棒球帽。"
	icon_state = "greensoft"
	soft_type = "green"
	dog_fashion = null

/obj/item/clothing/head/soft/yellow
	name = "黄帽"
	desc = "一顶品味糟糕的黄色棒球帽。"
	icon_state = "yellowsoft"
	soft_type = "yellow"
	dog_fashion = null

/obj/item/clothing/head/soft/grey
	name = "灰帽"
	desc = "一顶品味不俗的灰色棒球帽。"
	icon_state = "greysoft"
	soft_type = "grey"
	dog_fashion = null

/obj/item/clothing/head/soft/orange
	name = "橙帽"
	desc = "一顶品味糟糕的橙色棒球帽。"
	icon_state = "orangesoft"
	soft_type = "orange"
	dog_fashion = null

/obj/item/clothing/head/soft/mime
	name = "白帽"
	desc = "一顶品味糟糕的白色棒球帽。"
	icon_state = "mimesoft"
	soft_type = "mime"
	dog_fashion = null

/obj/item/clothing/head/soft/purple
	name = "紫帽"
	desc = "一顶品味糟糕的紫色棒球帽。"
	icon_state = "purplesoft"
	soft_type = "purple"
	dog_fashion = null

/obj/item/clothing/head/soft/black
	name = "黑帽"
	desc = "一顶品味糟糕的黑色棒球帽。"
	icon_state = "blacksoft"
	soft_type = "black"
	dog_fashion = null

/obj/item/clothing/head/soft/rainbow
	name = "彩虹帽"
	desc = "一顶色彩鲜艳的彩虹色棒球帽。"
	icon_state = "rainbowsoft"
	inhand_icon_state = "rainbow_softcap"
	soft_type = "rainbow"
	dog_fashion = null

/obj/item/clothing/head/soft/sec
	name = "安保帽"
	desc = "一顶结实耐用的棒球帽，呈品味不俗的红色。"
	icon_state = "secsoft"
	soft_type = "sec"
	armor_type = /datum/armor/cosmetic_sec
	strip_delay = 6 SECONDS
	dog_fashion = null

/obj/item/clothing/head/soft/veteran
	name = "老兵帽"
	desc = "一顶结实耐用的棒球帽，呈品味不俗的黑色，并带有金色“铭记”字样。"
	icon_state = "veteransoft"
	soft_type = "veteran"
	armor_type = /datum/armor/cosmetic_sec
	strip_delay = 6 SECONDS
	dog_fashion = null

/obj/item/clothing/head/soft/paramedic
	name = "急救员帽"
	desc = "一顶深青绿色的棒球帽，顶部有一个反光十字。"
	icon_state = "paramedicsoft"
	soft_type = "paramedic"
	dog_fashion = null

/obj/item/clothing/head/soft/fishing_hat
	name = "传奇钓鱼帽"
	desc = "一件远古遗物，来自渔获丰厚、河流无尽的往昔年代。帽前印着一首诗：<i>\n\
		女人怕我\n\
		鱼儿怕我\n\
		男人见我皆移开目光\n\
		当我行走时，无兽敢在我面前出声\n\
		我独自伫立于这片荒芜大地。</i>"
	icon_state = "fishing_hat"
	soft_type = "fishing_hat"
	inhand_icon_state = "fishing_hat"
	soft_suffix = null
	worn_y_offset = 5
	clothing_flags = SNUG_FIT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE
	dog_fashion = null
	clothing_traits = list(TRAIT_SCARY_FISHERMAN) //Fish, carps, lobstrosities and frogs fear me.

/obj/item/clothing/head/soft/fishing_hat/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = strings("crustacean_replacement.json", "crustacean")) //you asked for this.
	AddElement(/datum/element/skill_reward, /datum/skill/fishing)
	AddElement(/datum/element/adjust_fishing_difficulty, -5)

#define PROPHAT_MOOD "prophat"
#define PROPHAT_SUICIDE_TIME (10 SECONDS)

/obj/item/clothing/head/soft/propeller_hat
	name = "螺旋桨帽"
	desc = "一顶色彩缤纷的帽子，顶部装有一个旋转的螺旋桨。"
	icon_state = "propeller_hat"
	soft_type = "propeller_hat"
	inhand_icon_state = "rainbow_softcap"
	worn_y_offset = 1
	soft_suffix = null
	actions_types = list(/datum/action/item_action/toggle)
	var/enabled_waddle = TRUE
	var/active = FALSE

/obj/item/clothing/head/soft/propeller_hat/update_icon_state()
	. = ..()
	worn_icon_state = "[soft_type][flipped ? "_flipped" : null][active ? "_on" : null]"

/obj/item/clothing/head/soft/propeller_hat/attack_self(mob/user)
	active = !active
	balloon_alert(user, (active ? "螺旋桨已启动" : "螺旋桨已停止"))
	update_icon()
	user.update_worn_head()
	add_fingerprint(user)

/obj/item/clothing/head/soft/propeller_hat/equipped(mob/living/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_HEAD)
		user.add_mood_event(PROPHAT_MOOD, /datum/mood_event/prophat)
		RegisterSignal(user, COMSIG_LIVING_SUICIDE_ACT, PROC_REF(on_suicide_act))

/obj/item/clothing/head/soft/propeller_hat/dropped(mob/living/user)
	. = ..()
	UnregisterSignal(user, COMSIG_LIVING_SUICIDE_ACT)
	user.clear_mood_event(PROPHAT_MOOD)
	active = FALSE
	update_icon()

/obj/item/clothing/head/soft/propeller_hat/proc/on_suicide_act(mob/living/source)
	SIGNAL_HANDLER
	if(source.get_active_held_item())
		return NONE

	return suicide_act(source)

/obj/item/clothing/head/soft/propeller_hat/suicide_act(mob/living/user)
	if(!isturf(user.loc))
		user.visible_message(span_suicide("[user] starts spinning [src] as fast as possible! \
			It looks like [user.p_theyre()] trying to fly off into the sunset... yet the sky is out of reach for [user.p_them()]..."))
		return SHAME

	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
	user.add_traits(list(TRAIT_GODMODE, TRAIT_FORCED_STANDING, TRAIT_UNDENSE, TRAIT_IMMOBILIZED, TRAIT_INCAPACITATED, TRAIT_HANDS_BLOCKED), TRAIT_GENERIC)
	user.move_resist = INFINITY
	user.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	user.set_suicide(TRUE)
	user.visible_message(span_suicide("[user] starts spinning [src] as fast as possible! \
		It looks like [user.p_theyre()] trying to fly off into the sunset!"))
	playsound(src, 'sound/effects/whirthunk.ogg', 75)
	animate(user, PROPHAT_SUICIDE_TIME, pixel_z = 256, alpha = 0)
	QDEL_IN(user, PROPHAT_SUICIDE_TIME)
	// drop objects that will get flagged by tsa before we board
	for(var/obj/item/should_keep in user.get_all_contents())
		if(should_keep.resistance_flags & INDESTRUCTIBLE)
			should_keep.forceMove(user.drop_location())
	return MANUAL_SUICIDE

#undef PROPHAT_SUICIDE_TIME
#undef PROPHAT_MOOD
