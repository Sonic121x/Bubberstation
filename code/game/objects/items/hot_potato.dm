//CREATOR'S NOTE: DO NOT FUCKING GIVE THIS TO BOTANY!
/obj/item/hot_potato
	name = "烫手土豆"
	desc = "这颗土豆侧面贴着一张标签：“咚克公司服务部出品。请在远离人口密集区域处激活。本装置只会附着于有智力的生物。” <span class='boldnotice'>你可以用它攻击任何人，把它强行塞到对方身上而不是你自己身上！</span>"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "potato"
	item_flags = NOBLUDGEON
	force = 0
	var/icon_off = "potato"
	var/icon_on = "potato_active"
	var/detonation_timerid
	var/activation_time = 0
	var/timer = 600 //deciseconds
	var/show_timer = FALSE
	var/reusable = FALSE //absolute madman
	var/sticky = TRUE
	var/forceful_attachment = TRUE
	var/stimulant = TRUE
	var/detonate_explosion = TRUE
	var/detonate_dev_range = 0
	var/detonate_heavy_range = 1
	var/detonate_light_range = 2
	var/detonate_flash_range = 5
	var/detonate_fire_range = 5

	var/active = FALSE

	var/color_val = FALSE

	var/datum/weakref/current

/obj/item/hot_potato/Destroy()
	if(active)
		deactivate()
	return ..()

/obj/item/hot_potato/proc/colorize(mob/target)
	//Clear color from old target
	if(current)
		var/mob/M = current.resolve()
		if(istype(M))
			M.remove_atom_colour(FIXED_COLOUR_PRIORITY)
	//Give to new target
	current = null
	//Swap colors
	color_val = !color_val
	if(istype(target))
		current = WEAKREF(target)
		target.add_atom_colour(color_val? "#ffff00" : "#00ffff", FIXED_COLOUR_PRIORITY)

/obj/item/hot_potato/proc/detonate()
	var/atom/location = loc
	location.visible_message(span_userdanger("[src] [detonate_explosion? "爆炸" : "启动"]！"), span_userdanger("[src]启动了！你的时间用完了！"))
	if(detonate_explosion && isliving(loc))
		var/mob/living/victim_mob = loc
		if(victim_mob.is_holding(src))
			victim_mob.gib(DROP_ALL_REMAINS)
		explosion(src, detonate_dev_range, detonate_heavy_range, detonate_light_range, detonate_fire_range, detonate_flash_range)
	deactivate()
	if(!reusable)
		var/mob/M = loc
		if(istype(M))
			M.dropItemToGround(src, TRUE)
		qdel(src)

/obj/item/hot_potato/attack_self(mob/user)
	if(activate(timer, user))
		user.visible_message(span_boldwarning("[user]用力一挤[src]，它立刻开始闪烁赤红色的光芒！"), span_boldwarning("你用力一挤[src]，激活了它的倒计时和附着装置！"),
		span_boldwarning("你听到一声机械咔哒声和响亮的哔哔声！"))
		return
	return ..()

/obj/item/hot_potato/process()
	if(!isliving(loc))
		return
	var/mob/living/L = loc
	colorize(L)
	if(!stimulant)
		return
	L.SetStun(0)
	L.SetKnockdown(0)
	L.SetSleeping(0)
	L.SetImmobilized(0)
	L.SetParalyzed(0)
	L.SetUnconscious(0)
	L.reagents.add_reagent(/datum/reagent/medicine/muscle_stimulant, clamp(5 - L.reagents.get_reagent_amount(/datum/reagent/medicine/muscle_stimulant), 0, 5)) //If you don't have legs or get bola'd, tough luck!


/obj/item/hot_potato/examine(mob/user)
	. = ..()
	if(active)
		. += span_warning("[src]正在闪烁赤红色的光芒！你大概该把它扔掉了！")
		if(show_timer)
			. += span_warning("[src]的倒计时看起来还剩 [DisplayTimeText(activation_time - world.time)]！")

/obj/item/hot_potato/equipped(mob/user)
	. = ..()
	if(active)
		to_chat(user, span_userdanger("你对[src]有一种非常不祥的预感！"))

/obj/item/hot_potato/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return .

	return force_onto(target_mob, user)

/obj/item/hot_potato/proc/force_onto(mob/living/victim, mob/user)
	if(!istype(victim) || user != loc || victim == user)
		return FALSE
	if(!victim.client)
		to_chat(user, span_boldwarning("[src]拒绝附着在没有智力的生物身上！"))
	if(IS_UNCONSCIOUS_OR_CRIT(victim) || !victim.usable_legs)
		to_chat(user, span_boldwarning("[src]拒绝附着在无法使用它的人身上！"))
	user.temporarilyRemoveItemFromInventory(src, TRUE)
	. = FALSE
	if(!victim.put_in_hands(src))
		if(forceful_attachment)
			victim.dropItemToGround(victim.get_inactive_held_item())
			if(!victim.put_in_hands(src))
				victim.dropItemToGround(victim.get_active_held_item())
				if(victim.put_in_hands(src))
					. = TRUE
			else
				. = TRUE
	else
		. = TRUE
	if(.)
		log_combat(user, victim, "将一颗爆炸参数为（[detonate_explosion]-[detonate_dev_range]/[detonate_heavy_range]/[detonate_light_range]/[detonate_flash_range]/[detonate_fire_range]）的烫手土豆强行塞给了")
		user.visible_message(span_userdanger("[user]把[src]强行塞到了[victim]身上！"), span_userdanger("你把[src]强行塞到了[victim]身上！"), span_boldwarning("你听到一声机械咔哒声和一声哔响。"))
		colorize(null)
	else
		log_combat(user, victim, "试图将一颗爆炸参数为（[detonate_explosion]-[detonate_dev_range]/[detonate_heavy_range]/[detonate_light_range]/[detonate_flash_range]/[detonate_fire_range]）的烫手土豆强行塞给")
		user.visible_message(span_boldwarning("[user]试图把[src]强行塞到[victim]身上，但没能附着成功！"), span_boldwarning("你试图把[src]强行塞到[victim]身上，但它无法附着！"), span_boldwarning("你听到一声机械咔哒声和两声嗡鸣。"))
		user.put_in_hands(src)

/obj/item/hot_potato/dropped(mob/user)
	. = ..()
	colorize(null)

/obj/item/hot_potato/proc/activate(delay, mob/user)
	if(active)
		return
	update_appearance()
	if(sticky)
		ADD_TRAIT(src, TRAIT_NODROP, HOT_POTATO_TRAIT)
	name = "已激活的[name]"
	activation_time = timer + world.time
	detonation_timerid = addtimer(CALLBACK(src, PROC_REF(detonate)), delay, TIMER_STOPPABLE)
	START_PROCESSING(SSfastprocess, src)
	if(user)
		log_bomber(user, "已激活", src, "并设为引爆状态（倒计时:[delay], 爆炸:[detonate_explosion], 范围:[detonate_dev_range]/[detonate_heavy_range]/[detonate_light_range]/[detonate_fire_range]）")
	else
		log_bomber(null, null, src, "被设为引爆状态（倒计时:[delay], 爆炸:[detonate_explosion], 范围:[detonate_dev_range]/[detonate_heavy_range]/[detonate_light_range]/[detonate_fire_range]）")
	active = TRUE
	if(detonate_explosion) //doesn't send a notification unless it's a genuine, exploding hot potato.
		notify_ghosts(
			"[user.real_name] 激活了一颗烫手土豆！",
			source = src,
			header = "烫烫烫！",
		)

/obj/item/hot_potato/proc/deactivate()
	update_appearance()
	name = initial(name)
	REMOVE_TRAIT(src, TRAIT_NODROP, HOT_POTATO_TRAIT)
	deltimer(detonation_timerid)
	STOP_PROCESSING(SSfastprocess, src)
	detonation_timerid = null
	colorize(null)
	active = FALSE

/obj/item/hot_potato/update_icon_state()
	icon_state = active ? icon_on : icon_off
	return ..()

/obj/item/hot_potato/syndicate
	detonate_light_range = 4
	detonate_fire_range = 5

/obj/item/hot_potato/harmless
	detonate_explosion = FALSE

/obj/item/hot_potato/harmless/toy
	desc = "这颗土豆侧面贴着一张标签：“咚克公司玩具与娱乐部出品。” <span class='boldnotice'>如果你攻击的对方有空闲的手，你可以用它攻击任何人，把它塞到对方身上！</span>"
	sticky = FALSE
	reusable = TRUE
	forceful_attachment = FALSE
	stimulant = FALSE
