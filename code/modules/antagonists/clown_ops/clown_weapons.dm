/obj/item/reagent_containers/spray/waterflower/lube
	name = "喷水花"
	desc = "一朵看似无害的向日葵……只是有点花样。一个<i>滑溜</i>的花样。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "sunflower"
	inhand_icon_state = "sunflower"
	amount_per_transfer_from_this = 3
	spray_range = 1
	stream_range = 1
	volume = 30
	list_reagents = list(/datum/reagent/lube = 30)

//BANANIUM SWORD

/obj/item/melee/energy/sword/bananium
	name = "香蕉矿剑"
	icon_state = "e_sword"
	attack_verb_continuous = list("敲击", "轻拍", "戳刺")
	attack_verb_simple = list("敲", "拍", "戳")
	force = 0
	throwforce = 0
	hitsound = null
	embed_type = null
	light_color = COLOR_YELLOW
	sword_color_icon = "bananium"
	active_heat = 0
	/// Cooldown for making a trombone noise for failing to make a bananium desword
	COOLDOWN_DECLARE(next_trombone_allowed)

/obj/item/melee/energy/sword/bananium/make_transformable()
	AddComponent( \
		/datum/component/transforming, \
		throw_speed_on = 4, \
		attack_verb_continuous_on = list("滑倒"), \
		attack_verb_simple_on = list("滑倒"), \
		clumsy_check = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/melee/energy/sword/bananium/on_transform(obj/item/source, mob/user, active)
	. = ..()
	adjust_slipperiness()

/*
 * Adds or removes a slippery component, depending on whether the sword is active or not.
 */
/obj/item/melee/energy/sword/bananium/proc/adjust_slipperiness()
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		AddComponent(/datum/component/slippery, 60, GALOSHES_DONT_HELP)
	else
		qdel(GetComponent(/datum/component/slippery))

/obj/item/melee/energy/sword/bananium/attack(mob/living/M, mob/living/user)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		var/datum/component/slippery/slipper = GetComponent(/datum/component/slippery)
		slipper.Slip(src, M)

/obj/item/melee/energy/sword/bananium/throw_impact(atom/hit_atom, throwingdatum)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		var/datum/component/slippery/slipper = GetComponent(/datum/component/slippery)
		slipper.Slip(src, hit_atom)

/obj/item/melee/energy/sword/bananium/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/melee/energy/sword/bananium))
		return ..()

	if(!COOLDOWN_FINISHED(src, next_trombone_allowed))
		return ITEM_INTERACT_BLOCKING

	COOLDOWN_START(src, next_trombone_allowed, 5 SECONDS)
	to_chat(user, span_warning("你把两把剑拍在一起。可惜它们似乎接不上！"))
	playsound(src, 'sound/misc/sadtrombone.ogg', 50)
	return ITEM_INTERACT_SUCCESS

/obj/item/melee/energy/sword/bananium/suicide_act(mob/living/user)
	if(!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		attack_self(user)
	user.visible_message(span_suicide("[user]正[pick("用[src]划开自己的肚子", "扑倒在[src]上")]！看起来是想切腹，但刀刃滑开了，毫发无伤！"))
	var/datum/component/slippery/slipper = GetComponent(/datum/component/slippery)
	slipper.Slip(src, user)
	return SHAME

//BANANIUM SHIELD

/obj/item/shield/energy/bananium
	name = "香蕉矿能量盾"
	desc = "一面能挡下大多数近战攻击、保护使用者免受几乎所有能量射弹伤害，还能投掷出去让对手滑倒的盾牌。"
	icon_state = "bananaeshield"
	inhand_icon_state = "bananaeshield"
	throw_speed = 1
	force = 0
	throwforce = 0
	throw_range = 5

	active_force = 0
	active_throwforce = 0
	active_throw_speed = 1
	can_clumsy_use = TRUE

/obj/item/shield/energy/bananium/on_transform(obj/item/source, mob/user, active)
	. = ..()
	adjust_comedy()

/*
 * Adds or removes a slippery and boomerang component, depending on whether the shield is active or not.
 */
/obj/item/shield/energy/bananium/proc/adjust_comedy()
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		AddComponent(/datum/component/slippery, 60, GALOSHES_DONT_HELP)
		AddComponent(/datum/component/boomerang, throw_range+2, TRUE)
	else
		qdel(GetComponent(/datum/component/slippery))
		qdel(GetComponent(/datum/component/boomerang))

/obj/item/shield/energy/bananium/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		var/caught = hit_atom.hitby(src, FALSE, FALSE, throwingdatum=throwingdatum)
		if(iscarbon(hit_atom) && !caught)//if they are a carbon and they didn't catch it
			var/datum/component/slippery/slipper = GetComponent(/datum/component/slippery)
			slipper.Slip(src, hit_atom)
	else
		return ..()


//BOMBANANA

/obj/item/seeds/banana/bombanana
	name = "香蕉炸弹种子包"
	desc = "这些种子会长成香蕉炸弹树。长成后，交给小丑。"
	plantname = "香蕉炸弹树"
	product = /obj/item/food/grown/banana/bombanana

/obj/item/food/grown/banana/bombanana
	trash_type = /obj/item/grown/bananapeel/bombanana
	seed = /obj/item/seeds/banana/bombanana
	tastes = list("炸药" = 10)
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)

/obj/item/food/grown/banana/bombanana/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_FOOD_CONSUMED, PROC_REF(on_consumed))

/// Log whenever someone eats this with an explicit message since it willspawn a live bomb.
/obj/item/food/grown/banana/bombanana/proc/on_consumed(datum/source, mob/living/eater, mob/feeder)
	SIGNAL_HANDLER
	var/list/concatable = list("[key_name_and_tag(eater)] 吃了一根香蕉炸弹！")
	if(feeder != eater)
		concatable += "这个人是被 [key_name_and_tag(feeder)] 喂食的。"

	concatable += "因此，一个香蕉炸弹皮将在 [AREACOORD(src)] 生成。"

	var/final_string = jointext(concatable, " ")
	log_bomber(details = final_string) // sorta wacks out the traditional "log_bomber" format but it gets the point across better
	return NONE

/obj/item/grown/bananapeel/bombanana
	desc = parent_type::desc + " 它为什么在滴滴响？"
	seed = /obj/item/seeds/banana/bombanana
	/// How long we have until we explode.
	var/det_time = 5 SECONDS
	/// Ref to the bomb we spawn when we explode.
	var/obj/item/grenade/syndieminibomb/bomb

/obj/item/grown/bananapeel/bombanana/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, det_time)
	bomb = new /obj/item/grenade/syndieminibomb(src)
	bomb.name = "香蕉炸弹皮"
	bomb.det_time = det_time

	var/potential_user = null
	if(iscarbon(loc))
		to_chat(loc, span_danger("[src]开始滴滴作响。"))
		potential_user = loc // just for fingerprint diagnosis in explosion logging, the on_consumed proc will have provided the necessary context already

	bomb.arm_grenade(potential_user, msg = FALSE)

/obj/item/grown/bananapeel/bombanana/Destroy()
	. = ..()
	QDEL_NULL(bomb)

/obj/item/grown/bananapeel/bombanana/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]故意踩到[src]上滑倒！看起来是想自杀。"))
	playsound(loc, 'sound/misc/slip.ogg', 50, TRUE, -1)
	bomb.arm_grenade(user, 0, FALSE)
	return BRUTELOSS

//TEARSTACHE GRENADE

/obj/item/grenade/chem_grenade/teargas/moustache
	name = "催泪胡须手榴弹"
	desc = "一枚戴着帅气胡子的催泪瓦斯手榴弹。"
	icon_state = "moustacheg"
	clumsy_check = GRENADE_NONCLUMSY_FUMBLE

/obj/item/grenade/chem_grenade/teargas/moustache/detonate(mob/living/lanced_by)
	var/myloc = get_turf(src)
	. = ..()
	if(!.)
		return

	for(var/mob/living/carbon/human/victim in view(6, myloc))
		if(!istype(victim.wear_mask, /obj/item/clothing/mask/gas/clown_hat) && !istype(victim.wear_mask, /obj/item/clothing/mask/gas/mime))
			if(!victim.wear_mask || victim.dropItemToGround(victim.wear_mask))
				var/obj/item/clothing/mask/fakemoustache/sticky/the_stash = new /obj/item/clothing/mask/fakemoustache/sticky()
				victim.equip_to_slot_or_del(the_stash, ITEM_SLOT_MASK, TRUE, TRUE, TRUE, TRUE)

/obj/item/clothing/mask/fakemoustache/sticky
	var/unstick_time = 600

/obj/item/clothing/mask/fakemoustache/sticky/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, STICKY_MOUSTACHE_TRAIT)
	addtimer(CALLBACK(src, PROC_REF(unstick)), unstick_time)

/obj/item/clothing/mask/fakemoustache/sticky/proc/unstick()
	REMOVE_TRAIT(src, TRAIT_NODROP, STICKY_MOUSTACHE_TRAIT)
