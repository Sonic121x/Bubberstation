/*
*	NORMAL COLLAR
*/

//To determine what kind of stuff we can put in collar.

/datum/storage/pockets/small/kink_collar
	max_slots = 1

/datum/storage/pockets/small/kink_collar/New()
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/food/cookie,
	/obj/item/food/cookie/sugar))

/datum/storage/pockets/small/kink_collar/locked/New()
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/food/cookie,
	/obj/item/food/cookie/sugar,
	/obj/item/key/kink_collar))

/datum/storage/pockets/small/kink_collar/mind_collar/New()
	. = ..()
	can_hold = typecacheof(/obj/item/mind_controller)

//Here goes code for normal collar

/obj/item/clothing/neck/kink_collar
	name = "项圈"
	desc = "一个好看又紧致的项圈，贴合你的皮肤。"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "collar_cyan"
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_SMALL
	interaction_flags_click = NEED_DEXTERITY
	kink_collar = TRUE
	/// What the name on the tag is
	var/tagname = null
	/// Item path of on-init creation in the collar's storage
	var/treat_path = /obj/item/food/cookie
	/// Whether to add reskin component in Initialize
	var/reskins = TRUE

//spawn thing in collar

/obj/item/clothing/neck/kink_collar/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small/kink_collar)
	var/obj/item/key/kink_collar/key
	if(!treat_path)
		return
	key = new treat_path(src)
	if(!istype(key))
		return
	var/id = REF(src)
	var/obj/item/key/kink_collar/collar_key = key
	collar_key.key_id = id
	if(reskins)
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/kink_collar)

/datum/atom_skin/kink_collar
	abstract_type = /datum/atom_skin/kink_collar

/datum/atom_skin/kink_collar/cyan
	preview_name = "青色"
	new_icon_state = "collar_cyan"

/datum/atom_skin/kink_collar/yellow
	preview_name = "黄色"
	new_icon_state = "collar_yellow"

/datum/atom_skin/kink_collar/green
	preview_name = "绿色"
	new_icon_state = "collar_green"

/datum/atom_skin/kink_collar/red
	preview_name = "红色"
	new_icon_state = "collar_red"

/datum/atom_skin/kink_collar/latex
	preview_name = "乳胶"
	new_icon_state = "collar_latex"

/datum/atom_skin/kink_collar/orange
	preview_name = "橙色"
	new_icon_state = "collar_orange"

/datum/atom_skin/kink_collar/white
	preview_name = "白色"
	new_icon_state = "collar_white"

/datum/atom_skin/kink_collar/purple
	preview_name = "紫色"
	new_icon_state = "collar_purple"

/datum/atom_skin/kink_collar/black
	preview_name = "黑色"
	new_icon_state = "collar_black"

/datum/atom_skin/kink_collar/black_teal
	preview_name = "黑青色"
	new_icon_state = "collar_tealblack"

/datum/atom_skin/kink_collar/spike
	preview_name = "尖刺"
	new_icon_state = "collar_spike"

//rename collar code

/obj/item/clothing/neck/kink_collar/attack_self(mob/user)
	tagname = stripped_input(user, "你想更改铭牌上的名字吗？", "给你的新宠物取个名字", "点点", MAX_NAME_LEN)
	name = "[initial(name)] - [tagname]"

/*
*	LOCKED COLLAR
*/

/obj/item/clothing/neck/kink_collar/locked
	name = "上锁项圈"
	desc = "一个紧致的项圈。上面似乎装着某种锁。"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "lock_collar_cyan"
	treat_path = /obj/item/key/kink_collar
	interaction_flags_click = NEED_DEXTERITY
	/// If the collar is currently locked
	var/locked = FALSE
	/// If the collar has been broken or not
	var/broken = FALSE

/obj/item/clothing/neck/kink_collar/locked/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small/kink_collar/locked)
	if(reskins)
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/kink_collar_locked)

/datum/atom_skin/kink_collar_locked
	abstract_type = /datum/atom_skin/kink_collar_locked

/datum/atom_skin/kink_collar_locked/cyan
	preview_name = "青色"
	new_icon_state = "lock_collar_cyan"

/datum/atom_skin/kink_collar_locked/yellow
	preview_name = "黄色"
	new_icon_state = "lock_collar_yellow"

/datum/atom_skin/kink_collar_locked/green
	preview_name = "绿色"
	new_icon_state = "lock_collar_green"

/datum/atom_skin/kink_collar_locked/red
	preview_name = "红色"
	new_icon_state = "lock_collar_red"

/datum/atom_skin/kink_collar_locked/latex
	preview_name = "乳胶"
	new_icon_state = "lock_collar_latex"

/datum/atom_skin/kink_collar_locked/orange
	preview_name = "橙色"
	new_icon_state = "lock_collar_orange"

/datum/atom_skin/kink_collar_locked/white
	preview_name = "白色"
	new_icon_state = "lock_collar_white"

/datum/atom_skin/kink_collar_locked/purple
	preview_name = "紫色"
	new_icon_state = "lock_collar_purple"

/datum/atom_skin/kink_collar_locked/black
	preview_name = "黑色"
	new_icon_state = "lock_collar_black"

/datum/atom_skin/kink_collar_locked/black_teal
	preview_name = "黑青色"
	new_icon_state = "lock_collar_tealblack"

/datum/atom_skin/kink_collar_locked/spike
	preview_name = "尖刺"
	new_icon_state = "lock_collar_spike"

//spawn thing in collar

//locking or unlocking collar code

/obj/item/clothing/neck/kink_collar/locked/proc/IsLocked(to_lock, mob/user)
	if(!broken)
		to_chat(user, span_warning("[to_lock ? "项圈“咔哒”一声锁上了！" : "项圈轻轻一响，解开了。"]"))
		locked = (to_lock ? TRUE : FALSE)
		if(!to_lock)
			REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_NODROP)
		return
	to_chat(user, span_warning("看来锁已经坏了——现在它只是个普通的老项圈了。"))
	locked = FALSE
	REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_NODROP)

/obj/item/clothing/neck/kink_collar/locked/attackby(obj/item/key/kink_collar/attack_item, mob/user, params)
	if(!istype(attack_item))
		return
	if(attack_item.key_id == REF(src))
		IsLocked((locked ? FALSE : TRUE), user)
		return
	to_chat(user, span_warning("这不是正确的钥匙！"))

/obj/item/clothing/neck/kink_collar/locked/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!(locked && src == user.wear_neck))
		return
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_NODROP)
	to_chat(user, span_warning("你听到脖子周围传来可疑的“咔哒”声——看来项圈现在锁上了！"))

//this code prevents wearer from taking collar off if it's locked. Have fun!

/obj/item/clothing/neck/kink_collar/locked/attack_hand(mob/user)
	if(loc == user && user.get_item_by_slot(ITEM_SLOT_NECK) && locked)
		to_chat(user, span_warning("项圈锁上了！你得先解锁才能把它取下来！"))
		return
	add_fingerprint(usr)
	return ..()

/obj/item/clothing/neck/kink_collar/locked/mouse_drop_dragged(atom/over_object, mob/user, src_location, over_location, params)
	if(loc == user && user.get_item_by_slot(ITEM_SLOT_NECK) && locked && istype(over_object, /atom/movable/screen/inventory/hand))
		to_chat(user, span_warning("项圈锁上了！你得先解锁才能把它取下来！"))
		return
	var/atom/movable/screen/inventory/hand/inv_hand = over_object
	if(user.putItemFromInventoryInHandIfPossible(src, inv_hand.held_index))
		add_fingerprint(user)
	return ..()

//This is a KEY moment of this code. You got it. Key.
//...
//It's 2:56 of 08.04.2021, i want to sleep. Please laugh.

/obj/item/key/kink_collar
	name = "情趣项圈钥匙"
	desc = "一把用来开项圈或袋子上的小锁的钥匙。"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	icon_state = "collar_key_metal"
	base_icon_state = "collar_key"
	interaction_flags_click = NEED_DEXTERITY
	/// The name inscribed on the key
	var/keyname = null
	/// The ID of the key to pair with a collar. Will normally be the ref of the collar
	var/key_id = null //Adding same unique id to key

/obj/item/key/kink_collar/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/kink_collar_key)

/datum/atom_skin/kink_collar_key
	abstract_type = /datum/atom_skin/kink_collar_key

/datum/atom_skin/kink_collar_key/cyan
	preview_name = "青色"
	new_icon_state = "collar_key_blue"

/datum/atom_skin/kink_collar_key/yellow
	preview_name = "黄色"
	new_icon_state = "collar_key_yellow"

/datum/atom_skin/kink_collar_key/green
	preview_name = "绿色"
	new_icon_state = "collar_key_green"

/datum/atom_skin/kink_collar_key/red
	preview_name = "红色"
	new_icon_state = "collar_key_red"

/datum/atom_skin/kink_collar_key/latex
	preview_name = "乳胶"
	new_icon_state = "collar_key_latex"

/datum/atom_skin/kink_collar_key/orange
	preview_name = "橙色"
	new_icon_state = "collar_key_orange"

/datum/atom_skin/kink_collar_key/white
	preview_name = "白色"
	new_icon_state = "collar_key_white"

/datum/atom_skin/kink_collar_key/purple
	preview_name = "紫色"
	new_icon_state = "collar_key_purple"

/datum/atom_skin/kink_collar_key/black
	preview_name = "黑色"
	new_icon_state = "collar_key_black"

/datum/atom_skin/kink_collar_key/metal
	preview_name = "金属"
	new_icon_state = "collar_key_metal"

/datum/atom_skin/kink_collar_key/black_teal
	preview_name = "黑青色"
	new_icon_state = "collar_key_tealblack"

//changing name of key in case if we using multiple collars with same color
/obj/item/key/kink_collar/attack_self(mob/user)
	keyname = stripped_input(user, "你想更改钥匙上的名字吗？", "给钥匙改名", "钥匙", MAX_NAME_LEN)
	name = "[initial(name)] - [keyname]"

//we checking if we can open collar with THAT KEY with SAME ID as the collar.
/obj/item/key/kink_collar/attack(mob/living/carbon/human/target, mob/living/user, params)
	if(!istype(target))
		return
	. = ..()
	if(!istype(target.wear_neck, /obj/item/clothing/neck/kink_collar/locked))
		return
	var/obj/item/clothing/neck/kink_collar/locked/collar = target.wear_neck
	if(REF(collar) == src.key_id)
		collar.IsLocked((collar.locked ? FALSE : TRUE), user)
	else
		to_chat(user, span_warning("这不是正确的钥匙！"))

/obj/item/circular_saw/attack(mob/living/carbon/human/target, mob/living/user, params)
	if(!istype(target))
		return ..()
	if(!istype(target.wear_neck, /obj/item/clothing/neck/kink_collar/locked))
		return ..()
	var/obj/item/clothing/neck/kink_collar/locked/collar = target.wear_neck
	if(collar.broken)
		to_chat(user, span_warning("锁已经坏了！"))
		return
	to_chat(user, span_warning("你试着直接把锁切下来！"))
	if(target != user)
		if(!do_after(user, 2 SECONDS, target))
			return
		collar.broken = TRUE
		collar.IsLocked(FALSE, user)
		if(prob(33)) //chance to get damage
			to_chat(user, span_warning("你成功切掉了锁，但过程中也在 [target.name] 身上划了好几道口子！"))
			target.apply_damage(rand(1, 4), BRUTE, BODY_ZONE_HEAD, wound_bonus = 10)
		else
			to_chat(user, span_warning("你成功切掉了锁！"))
	else
		if(!do_after(user, 3 SECONDS, target))
			return
		if(prob(33))
			to_chat(user, span_warning("你成功切掉了锁，但过程中也在自己身上划了好几道口子！"))
			collar.broken = TRUE
			collar.IsLocked(FALSE, user)
			target.apply_damage(rand(2, 4), BRUTE, BODY_ZONE_HEAD, wound_bonus = 10)
		else
			to_chat(user, span_warning("你没能切掉锁，还把自己划伤了！"))
			target.apply_damage(rand(3, 5), BRUTE, BODY_ZONE_HEAD, wound_bonus = 30)

/*
*	MIND CONTROL COLLAR
*/

//Ok, first - it's not mind control. Just forcing someone to do emotes that user added to remote thingy. Just a funny illegal ERP toy.

//Controller stuff
/obj/item/mind_controller
	name = "心灵控制器"
	desc = "一个小型遥控器，可向项圈发送基本的情感模式。"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	icon_state = "mindcontroller"
	/// Reference to the mind control collar
	var/obj/item/clothing/neck/mind_collar/collar = null
	w_class = WEIGHT_CLASS_SMALL

/obj/item/mind_controller/Initialize(mapload, collar_init)
	. = ..()
	src.collar = collar_init

/obj/item/mind_controller/Destroy(force)
	collar?.remote = null
	collar = null
	return ..()

/obj/item/mind_controller/attack_self(mob/user)
	if(!collar)
		return
	collar.emoting = tgui_input_text(user, "修改情感模式。", max_length = MAX_MESSAGE_LEN)
	collar.emoting_proc()

//Collar stuff
/obj/item/clothing/neck/mind_collar
	name = "心灵项圈"
	desc = "一个紧致的项圈。侧面装着某种奇怪的高科技发射器。"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "mindcollar"
	inhand_icon_state = null
	kink_collar = TRUE
	/// Reference to the mind control remote
	var/obj/item/mind_controller/remote
	var/emoting = "打了个寒颤。"

/obj/item/clothing/neck/mind_collar/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small/kink_collar/mind_collar)
	remote = new /obj/item/mind_controller(src, src)
	remote.forceMove(src)

/obj/item/clothing/neck/mind_collar/proc/emoting_proc()
	var/mob/living/carbon/human/user = src.loc
	if(istype(user) && src == user.wear_neck)
		user.emote("me", 1, "[emoting]", TRUE)

/obj/item/clothing/neck/mind_collar/Destroy()
	remote?.collar = null
	remote = null
	. = ..()
