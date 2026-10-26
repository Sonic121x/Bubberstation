/// Typecache of types that cannot be marked as heirlooms.
GLOBAL_LIST_INIT(invalid_heirloom_types, typecacheof(list(
	/obj/item/card/id,
	/obj/item/disk/nuclear,
)))

/datum/quirk/item_quirk/family_heirloom
	/// The temporary mark action we give to users who have opted out of random items.
	var/datum/action/mark_family_heirloom/mark_action
	always_spawn_item = TRUE

/datum/quirk/item_quirk/family_heirloom/remove()
	. = ..()

	QDEL_NULL(mark_action)

/datum/quirk/item_quirk/family_heirloom/Destroy()
	. = ..()

	QDEL_NULL(mark_action)

/datum/quirk_constant_data/family_heirloom
	associated_typepath = /datum/quirk/item_quirk/family_heirloom
	customization_options = list(/datum/preference/toggle/random_heirloom)

/datum/preference/toggle/random_heirloom
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "random_heirloom_toggle"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	default_value = TRUE

/datum/preference/toggle/random_heirloom/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/action/mark_family_heirloom
	name = "将手持物品设为传家宝"
	desc = "将手中的物品设为你的传家宝。无法用于已有的传家宝。"

/datum/action/mark_family_heirloom/Trigger(mob/clicker, trigger_flags)
	. = ..()

	if (!.)
		return FALSE

	if (!isliving(owner))
		return FALSE
	var/mob/living/living_owner = owner

	var/datum/quirk/item_quirk/family_heirloom/quirk = locate() in living_owner.quirks
	if (isnull(quirk))
		stack_trace("someone has the family heirloom action without the trait... wack. [owner]")
		owner.balloon_alert(owner, "没有对应特征！")
		return FALSE

	var/obj/item/held_item = living_owner.get_active_held_item()

	if (isnull(held_item))
		living_owner.balloon_alert(living_owner, "手中没有物品！")
		return FALSE

	if (HAS_TRAIT(held_item, TRAIT_NODROP))
		living_owner.balloon_alert(living_owner, "物品必须能够丢下！")
		return FALSE

	if (GLOB.invalid_heirloom_types[held_item.type])
		living_owner.balloon_alert(living_owner, "无效的物品类型！")
		return FALSE

	if (held_item.GetComponent(/datum/component/heirloom))
		living_owner.balloon_alert(living_owner, "已经是传家宝！")
		return FALSE

	// valid heirloom

	var/new_name = tgui_input_text(
		clicker,
		"输入[held_item]的新名称。（留空则保留默认名称）",
		"新名称",
		max_length = 50,
		timeout = 60 SECONDS
	)

	var/new_desc = tgui_input_text(
		clicker,
		"输入[held_item]的新描述。（留空则保留默认描述）",
		"新描述",
		max_length = 256,
		multiline = TRUE,
		timeout = 60 SECONDS,
	)

	var/list/names = splittext(living_owner.real_name, " ")
	var/family_name = names[names.len]

	if (new_name)
		held_item.name = "[new_name] ([held_item.name])"
		ADD_TRAIT(held_item, TRAIT_WAS_RENAMED, REF(quirk))
		held_item.AddElement(/datum/element/examined_when_worn)
		SEND_SIGNAL(held_item, COMSIG_NAME_CHANGED)
	if (new_desc)
		held_item.desc = "[new_desc]"

	held_item.AddComponent(/datum/component/heirloom, living_owner.mind, family_name)
	living_owner.add_mob_memory(/datum/memory/key/quirk_heirloom, protagonist = living_owner, heirloom_name = initial(held_item.name))

	owner.balloon_alert(owner, "已设为传家宝")
	quirk.heirloom = WEAKREF(held_item)
	quirk.mark_action = null
	qdel(src)
