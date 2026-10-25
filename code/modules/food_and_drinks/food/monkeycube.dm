/obj/item/food/monkeycube
	name = "猴子方块"
	desc = "只需加水！"
	icon_state = "monkeycube"
	bite_consumption = 12
	food_reagents = list(/datum/reagent/monkey_powder = 30)
	tastes = list("the jungle" = 1, "bananas" = 1)
	foodtypes = MEAT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	/// Mob typepath to spawn when expanding
	var/spawned_mob = /mob/living/carbon/human/species/monkey
	/// Whether we've been wetted and are expanding
	var/expanding = FALSE

/obj/item/food/monkeycube/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_IN_UNWRAPPED_TRAITOR_MAIL, PROC_REF(on_mail_unwrap))

/obj/item/food/monkeycube/attempt_pickup(mob/user)
	if(expanding)
		return FALSE
	return ..()

/obj/item/food/monkeycube/proc/Expand()
	if(expanding)
		return

	expanding = TRUE

	if(ismob(loc))
		var/mob/holder = loc
		holder.dropItemToGround(src)

	var/mob/spammer = get_mob_by_key(fingerprintslast)
	var/mob/living/bananas = null
	if (ispath(spawned_mob, /mob/living/carbon/human/species/monkey))
		var/cap = CONFIG_GET(number/monkeycap)
		if (LAZYLEN(SSmobs.cubemonkeys) < cap)
			bananas = new spawned_mob(drop_location(), TRUE)
		else if (spammer)
			to_chat(spammer, span_warning("蓝空间谐波阻止了空间站一次性生成超过 [cap] 只猴子！"))
	else
		bananas = new spawned_mob(drop_location())

	if (!QDELETED(bananas))
		ADD_TRAIT(bananas, TRAIT_SPAWNED_MOB, INNATE_TRAIT)
		SET_FACTION_AND_ALLIES_FROM(bananas, src)

		visible_message(span_notice("[src] 膨胀了！"))
		bananas.log_message("通过 [src] 生成，最后接触的生物：[key_name(spammer)]。", LOG_ATTACK)

		var/alpha_to = bananas.alpha
		var/matrix/scale_to = matrix(bananas.transform)
		bananas.alpha = 0
		bananas.transform = bananas.transform.Scale(0.1)
		animate(bananas, 0.5 SECONDS, alpha = alpha_to, transform = scale_to, easing = QUAD_EASING|EASE_OUT)

	else if (!spammer) // Visible message in case there are no fingerprints
		visible_message(span_notice("[src] 膨胀失败！"))
		return

	animate(src, 0.4 SECONDS, alpha = 0, transform = transform.Scale(0), easing = QUAD_EASING|EASE_IN)
	QDEL_IN(src, 0.5 SECONDS)

/obj/item/food/monkeycube/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 正把 [src] 塞进自己嘴里！看起来是想自杀！"))
	var/eating_success = do_after(user, 1 SECONDS, src)
	if(QDELETED(user)) //qdeletion: the nuclear option of self-harm
		return SHAME
	if(!eating_success || QDELETED(src)) //checks if src is gone or if they failed to wait for a second
		user.visible_message(span_suicide("[user] 临阵退缩了！"))
		return SHAME
	if(HAS_TRAIT(user, TRAIT_NOHUNGER)) //plasmamen don't have saliva/stomach acid
		user.visible_message(span_suicide("[user] 意识到自己的身体无法激活 [src]！")
		,span_warning("你的身体无法激活 [src]……"))
		return SHAME
	playsound(user, 'sound/items/eatfood.ogg', rand(10, 50), TRUE)
	user.temporarilyRemoveItemFromInventory(src) //removes from hands, keeps in M
	addtimer(CALLBACK(src, PROC_REF(finish_suicide), user), 15) //you've eaten it, you can run now
	return MANUAL_SUICIDE

/obj/item/food/monkeycube/proc/finish_suicide(mob/living/user) ///internal proc called by a monkeycube's suicide_act using a timer and callback. takes as argument the mob/living who activated the suicide
	if(QDELETED(user) || QDELETED(src))
		return
	if(src.loc != user) //how the hell did you manage this
		to_chat(user, span_warning("[src] 出了点状况……"))
		return
	Expand()
	user.visible_message(span_danger("[user] 的躯干炸开了，一只灵长类动物钻了出来！"))
	user.gib(DROP_BRAIN|DROP_BODYPARTS|DROP_ITEMS) // just remove the organs

/obj/item/food/monkeycube/proc/on_mail_unwrap(atom/source, mob/user, obj/item/mail/traitor/letter)
	SIGNAL_HANDLER
	to_chat(user, span_danger("当你打开 [letter] 时，里面的东西迅速膨胀起来！"))
	Expand()
	return COMPONENT_TRAITOR_MAIL_HANDLED

/obj/item/food/monkeycube/syndicate
	faction = list(FACTION_NEUTRAL, ROLE_SYNDICATE)

/obj/item/food/monkeycube/gorilla
	name = "大猩猩方块"
	desc = "华夫公司牌大猩猩方块。现在含有更多分子！"
	bite_consumption = 20
	food_reagents = list(
		/datum/reagent/monkey_powder = 30,
		/datum/reagent/medicine/strange_reagent = 5,
	)
	tastes = list("the jungle" = 1, "bananas" = 1, "jimmies" = 1)
	spawned_mob = /mob/living/basic/gorilla

/obj/item/food/monkeycube/chicken
	name = "鸡方块"
	desc = "纳米传讯的新经典——鸡方块。尝起来像一切！"
	bite_consumption = 20
	food_reagents = list(
		/datum/reagent/consumable/eggyolk = 30,
		/datum/reagent/medicine/strange_reagent = 1,
	)
	tastes = list("chicken" = 1, "the country" = 1, "chicken bouillon" = 1)
	spawned_mob = /mob/living/basic/chicken

/obj/item/food/monkeycube/bee
	name = "蜜蜂方块"
	desc = "我们当时确信这是个好主意。只需加水。"
	bite_consumption = 20
	food_reagents = list(
		/datum/reagent/consumable/honey = 10,
		/datum/reagent/toxin = 5,
		/datum/reagent/medicine/strange_reagent = 1,
	)
	tastes = list("buzzing" = 1, "honey" = 1, "regret" = 1)
	spawned_mob = /mob/living/basic/bee

/obj/item/food/monkeycube/dangerous_horse
	name = "小马方块"
	desc = "这是一个方块，加水后会生成一匹足以打爆敌人脑袋的辛迪加小马！"
	bite_consumption = 10
	food_reagents = list(
		/datum/reagent/toxin = 15,
		/datum/reagent/medicine/strange_reagent = 1,
	)
	tastes = list("the loss of 5 TC" = 1, "eaten friend" = 1)
	spawned_mob = /mob/living/basic/pony/dangerous

/obj/item/food/monkeycube/random
	name = "怪物方块"
	desc = "一个加水后会生成随机生物的方块。谁知道里面是什么？"
	food_reagents = list(
		/datum/reagent/toxin = 15,
		/datum/reagent/medicine/strange_reagent = 1,
	)

/obj/item/food/monkeycube/random/Initialize(mapload)
	. = ..()
	spawned_mob = pick_weight(list(
		/mob/living/basic/bear = 4,
		/mob/living/basic/bear/snow = 1,
		/mob/living/basic/blankbody = 2,
		/mob/living/basic/blob_minion/blobbernaut = 2,
		/mob/living/basic/blob_minion/spore = 2,
		/mob/living/basic/carp = 4,
		/mob/living/basic/carp/mega = 1,
		/mob/living/basic/creature = 2,
		/mob/living/basic/eyeball = 1,
		/mob/living/basic/gorilla = 5,
		/mob/living/basic/migo = 2,
		/mob/living/basic/mining/basilisk = 5,
		/mob/living/basic/mining/lobstrosity = 1,
		/mob/living/basic/mining/lobstrosity/lava = 4,
		/mob/living/basic/mining/wolf = 4,
		/mob/living/basic/pet/cat/feral = 1,
		/mob/living/basic/spider/giant = 5,
		/mob/living/basic/spider/giant/hunter = 1,
		/mob/living/basic/spider/giant/tank = 1,
		/mob/living/basic/spider/giant/tarantula = 1,
		/mob/living/basic/spider/giant/viper = 1,
	))
