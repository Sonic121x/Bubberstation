// don't produce a comment if the dice has less than this many sides
// so you don't have d1's and d4's constantly producing comments
#define MIN_SIDES_ALERT 5

///holding bag for dice
/obj/item/storage/dice
	name = "骰子袋"
	desc = "装着你所需的一切好运。"
	icon = 'icons/obj/toys/dice.dmi'
	icon_state = "dicebag"
	w_class = WEIGHT_CLASS_SMALL
	storage_type = /datum/storage/dice

/obj/item/storage/dice/PopulateContents()
	new /obj/item/dice/d4(src)
	new /obj/item/dice/d6(src)
	new /obj/item/dice/d8(src)
	new /obj/item/dice/d10(src)
	new /obj/item/dice/d12(src)
	new /obj/item/dice/d20(src)
	var/picked = pick(list(
		/obj/item/dice/d1,
		/obj/item/dice/d2,
		/obj/item/dice/fudge,
		/obj/item/dice/d6/space,
		/obj/item/dice/d00,
		/obj/item/dice/eightbd20,
		/obj/item/dice/fourdd6,
		/obj/item/dice/d100,
	))
	new picked(src)

/obj/item/storage/dice/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正在与死神对赌！看起来是想自杀！"))
	return OXYLOSS

/obj/item/storage/dice/hazard/PopulateContents()
	new /obj/item/dice/d6(src)
	new /obj/item/dice/d6(src)
	new /obj/item/dice/d6(src)
	for(var/i in 1 to 2)
		if(prob(7))
			new /obj/item/dice/d6/ebony(src)
		else
			new /obj/item/dice/d6(src)

///this is a prototype for dice, for a real d6 use "/obj/item/dice/d6"
/obj/item/dice
	name = "骰子"
	desc = "一枚六面骰子。简单实用。"
	icon = 'icons/obj/toys/dice.dmi'
	icon_state = "d6"
	w_class = WEIGHT_CLASS_TINY
	var/sides = 6
	var/result = null
	var/list/special_faces = list() //entries should match up to sides var if used
	var/microwave_riggable = TRUE

	var/rigged = DICE_NOT_RIGGED
	var/rigged_value

/obj/item/dice/Initialize(mapload)
	. = ..()
	if(!result)
		result = roll(sides)
	update_appearance()

/obj/item/dice/attack_self(mob/user)
	diceroll(user, in_hand = TRUE)

/obj/item/dice/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/mob/thrown_by = throwingdatum?.get_thrower()
	if(istype(thrown_by))
		diceroll(thrown_by)
	return ..()

/obj/item/dice/proc/diceroll(mob/user, in_hand=FALSE)
	result = roll(sides)
	if(rigged != DICE_NOT_RIGGED && result != rigged_value)
		if(rigged == DICE_BASICALLY_RIGGED && prob(clamp(1/(sides - 1) * 100, 25, 80)))
			result = rigged_value
		else if(rigged == DICE_TOTALLY_RIGGED)
			result = rigged_value

	. = result
	playsound(src, 'sound/items/dice_roll.ogg', 50, TRUE)

	var/fake_result = roll(sides)//Daredevil isn't as good as he used to be
	var/comment = ""
	if(sides > MIN_SIDES_ALERT && result == 1)  // less comment spam
		comment = "哎呀，真倒霉。"
	if(sides == 20 && result == 20)
		comment = "天生20点！"
	update_appearance()
	result = manipulate_result(result)
	if(special_faces.len == sides)
		comment = ""  // its not a number
		result = special_faces[result]
		if(!ISINTEGER(result))
			comment = special_faces[result]  // should be a str now

	if(in_hand) //Dice was rolled in someone's hand
		user.visible_message(
			span_notice("[user]掷出了[src]，结果是[result]。[comment]"),
			span_notice("你掷出了[src]，结果是[result]。[comment]"),
			span_hear("你听见[src]滚动的声音，听起来像是[fake_result]点。"),
		)
	else
		visible_message(span_notice("[src]滚动后停下，结果是[result]。[comment]"))

	return .


/obj/item/dice/update_overlays()
	. = ..()
	. += "[icon_state]-[result]"

/obj/item/dice/microwave_act(obj/machinery/microwave/microwave_source, mob/microwaver, randomize_pixel_offset)
	if(microwave_riggable)
		rigged = DICE_BASICALLY_RIGGED
		rigged_value = result

	return ..() | COMPONENT_MICROWAVE_SUCCESS

/// A proc to modify the displayed result. (Does not affect what the icon_state is passed.)
/obj/item/dice/proc/manipulate_result(original)
	return original

/obj/item/dice/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正在与死神对赌！看起来是想自杀！"))
	return OXYLOSS

/obj/item/dice/d1
	name = "D1骰子"
	desc = "只有一面的骰子。结果确定无疑！"
	icon_state = "d1"
	sides = 1

/obj/item/dice/d2
	name = "D2骰子"
	desc = "两面骰子。抛硬币太没格调了！"
	icon_state = "d2"
	sides = 2

/obj/item/dice/d4
	name = "D4骰子"
	desc = "四面骰子。书呆子的铁蒺藜。"
	icon_state = "d4"
	sides = 4

/obj/item/dice/d4/Initialize(mapload)
	. = ..()
	// 1d4 damage
	AddComponent(/datum/component/caltrop, min_damage = 1, max_damage = 4)

/obj/item/dice/d6
	name = "D6骰子"

/obj/item/dice/d6/ebony
	name = "乌木骰子"
	desc = "用致密黑木制成的六面骰子。握在手里冰冷而沉重。"
	icon_state = "de6"
	microwave_riggable = FALSE // You can't melt wood in the microwave

/obj/item/dice/d6/space
	name = "太空方块"
	desc = "一枚六面骰子。全部存在共有6乘255乘255个格子，将你被教育愚化的头脑平方：2并不存在。"
	icon_state = "spaced6"

/obj/item/dice/d6/space/Initialize(mapload)
	. = ..()
	if(prob(10))
		name = "太空方块儿"

/obj/item/paper/guides/knucklebone
	name = "骨骰游戏规则"
	default_raw_text = "骨骰游戏玩法<br>\
	<ul>\
	<li>用手边能找到的东西在地上并排画出两个3×3方格。我喜欢用酒保的全息投影仪。</li>\
	<li>双方轮流掷骰，将骰子放入自己3×3方格的三行之一。</li>\
	<li>将点数相同的骰子放在同一行，争取获得最高分。</li>\
	<li>若一行中有两枚相同点数的骰子，将它们的点数相加再乘以二，然后加上其余骰子的点数。</li>\
	<li>若一行中有三枚相同点数的骰子，按同样的方法计算，但改为乘以三。</li>\
	<li>但如果对手在与你某一行相对的位置放下骰子，你必须移除该行所有与它点数相同的骰子。</li>\
	<li>例如，你的一行中有两枚5点和一枚2点，对手在对应行放下一枚5点，你就必须移除该行的两枚5点。</li>\
	<li>注意，只有同一行的相同骰子才计算倍数，同一列的不算。</li>\
	<li>如果分不清是上下还是左右计算倍数，就以对手3×3方格的位置为准。</li>\
	<li>与对手各行对齐的行，就是可以计算骰子倍数的行。</li>\
	<li>当一方填满自己的3×3方格时，游戏立即结束，另一方不能继续掷剩下的骰子。</li>\
	<li>分数最高的一方获胜。</li>\
	<li>玩得开心！</li>\
	</ul>"
/obj/item/dice/fudge
	name = "命运骰"
	desc = "有六个面却只有三种结果的骰子。是加还是减？你的脑子一片空白……"
	sides = 3 //shhh
	icon_state = "fudge"
	special_faces = list("减号","空白" = "你不知道该作何感想。","加号")

/obj/item/dice/d8
	name = "D8骰子"
	desc = "八面骰子。感觉……很幸运。"
	icon_state = "d8"
	sides = 8

/obj/item/dice/d10
	name = "D10骰子"
	desc = "十面骰子。适合掷百分比。"
	icon_state = "d10"
	sides = 10

/obj/item/dice/d00
	name = "D00骰子"
	desc = "十面骰子。掷百分骰时比高尔夫球好用。"
	icon_state = "d00"
	sides = 10

/obj/item/dice/d00/manipulate_result(original)
	return (original - 1)*10  // 10, 20, 30, etc

/obj/item/dice/d12
	name = "D12骰子"
	desc = "十二面骰子。散发着被冷落的气息。"
	icon_state = "d12"
	sides = 12

/obj/item/dice/d20
	name = "D20骰子"
	desc = "二十面骰子。往游戏主持人身上扔骰子时的首选。"
	icon_state = "d20"
	sides = 20

/obj/item/dice/d100
	name = "D100骰子"
	desc = "竟然有一百个面的骰子！重量分布恐怕不太均匀……"
	icon_state = "d100"
	w_class = WEIGHT_CLASS_SMALL
	sides = 100

/obj/item/dice/d100/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/item/dice/eightbd20
	name = "奇怪的D20骰子"
	desc = "各面印着凸起文字的怪骰子。白底白字，读起来十分费劲。设计真糟糕！"
	icon_state = "8bd20"
	sides = 20
	special_faces = list("千真万确","确实如此","毫无疑问","绝对是的","可以放心","依我看，是的","很有可能","前景不错","是的","迹象表明是的","答案模糊，请重试","稍后再问","现在最好不告诉你","现在无法预测","集中精神再问一次","别指望了","我的回答是否定的","我的消息来源说不","前景不太妙","很值得怀疑")

/obj/item/dice/eightbd20/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/item/dice/fourdd6
	name = "四维D6骰子"
	desc = "存在于四维空间的骰子。只有在数学家、物理学家和牧师的帮助下才能正确解读它。"
	icon_state = "4dd6"
	sides = 48
	special_faces = list("立方体面：1-1","立方体面：1-2","立方体面：1-3","立方体面：1-4","立方体面：1-5","立方体面：1-6","立方体面：2-1","立方体面：2-2","立方体面：2-3","立方体面：2-4","立方体面：2-5","立方体面：2-6","立方体面：3-1","立方体面：3-2","立方体面：3-3","立方体面：3-4","立方体面：3-5","立方体面：3-6","立方体面：4-1","立方体面：4-2","立方体面：4-3","立方体面：4-4","立方体面：4-5","立方体面：4-6","立方体面：5-1","立方体面：5-2","立方体面：5-3","立方体面：5-4","立方体面：5-5","立方体面：5-6","立方体面：6-1","立方体面：6-2","立方体面：6-3","立方体面：6-4","立方体面：6-5","立方体面：6-6","立方体面：7-1","立方体面：7-2","立方体面：7-3","立方体面：7-4","立方体面：7-5","立方体面：7-6","立方体面：8-1","立方体面：8-2","立方体面：8-3","立方体面：8-4","立方体面：8-5","立方体面：8-6")

/obj/item/dice/fourdd6/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

// Die of fate stuff
/obj/item/dice/d20/fate
	name = "\improper 命运之骰"
	desc = "二十面骰子。你能感到它散发着超凡的力量。使用它可能极其危险。"
	icon_state = "d20"
	sides = 20
	microwave_riggable = FALSE
	var/reusable = TRUE
	var/used = FALSE
	/// So you can't roll the die 20 times in a second and stack a bunch of effects that might conflict
	COOLDOWN_DECLARE(roll_cd)

/obj/item/dice/d20/fate/one_use
	reusable = FALSE

/obj/item/dice/d20/fate/cursed
	name = "受诅咒的命运之骰"
	desc = "二十面骰子。你觉得掷它绝对是个馊主意。"
	color = "#00BB00"

	rigged = DICE_TOTALLY_RIGGED
	rigged_value = 1

/obj/item/dice/d20/fate/cursed/one_use
	reusable = FALSE

/obj/item/dice/d20/fate/stealth
	name = "D20骰子"
	desc = "二十面骰子。往游戏主持人身上扔骰子时的首选。"

/obj/item/dice/d20/fate/stealth/one_use
	reusable = FALSE

/obj/item/dice/d20/fate/stealth/cursed
	rigged = DICE_TOTALLY_RIGGED
	rigged_value = 1

/obj/item/dice/d20/fate/stealth/cursed/one_use
	reusable = FALSE

/obj/item/dice/d20/fate/diceroll(mob/user, in_hand=FALSE)
	if(!COOLDOWN_FINISHED(src, roll_cd))
		to_chat(user, span_warning("等一下，[src]还没处理完你上一次掷骰的结果！"))
		return

	. = ..()
	if(used)
		return

	if(!ishuman(user) || !user.mind || IS_WIZARD(user))
		to_chat(user, span_warning("你感觉骰子的魔力只对普通人类生效！"))
		return

	if(!reusable)
		used = TRUE

	var/turf/selected_turf = get_turf(src)
	selected_turf.visible_message(span_userdanger("[src]短暂地闪耀起来。"))

	addtimer(CALLBACK(src, PROC_REF(effect), user, .), 1 SECONDS)
	COOLDOWN_START(src, roll_cd, 2.5 SECONDS)

/obj/item/dice/d20/fate/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user) || !user.mind || IS_WIZARD(user))
		to_chat(user, span_warning("你感觉骰子的魔力只对普通人类生效！你最好别碰它。"))
		user.dropItemToGround(src)


/obj/item/dice/d20/fate/proc/effect(mob/living/carbon/human/user,roll)
	var/turf/selected_turf = get_turf(src)
	switch(roll)
		if(1)
			//Dust
			selected_turf.visible_message(span_userdanger("[user]化为了尘埃！"))
			user.investigate_log("has been dusted by a die of fate.", INVESTIGATE_DEATHS)
			user.dust()
		if(2)
			//Death
			selected_turf.visible_message(span_userdanger("[user]突然死了！"))
			user.investigate_log("has been killed by a die of fate.", INVESTIGATE_DEATHS)
			user.death()
		if(3)
			//Swarm of creatures
			selected_turf.visible_message(span_userdanger("一群怪物包围了[user]！"))
			for(var/direction in GLOB.alldirs)
				var/turf/stepped_turf = get_step(get_turf(user), direction)
				do_sparks(3, FALSE, stepped_turf)
				new /mob/living/basic/creature(stepped_turf)
		if(4)
			//Destroy Equipment
			selected_turf.visible_message(span_userdanger("[user]手持和穿戴的一切都消失了！"))
			var/list/belongings = user.get_all_gear(NONE) //don't delete prosthetics or abstract items.
			QDEL_LIST(belongings)
		if(5)
			//Monkeying
			selected_turf.visible_message(span_userdanger("[user]变成了一只猴子！"))
			user.monkeyize()
		if(6)
			//Cut speed
			selected_turf.visible_message(span_userdanger("[user]的动作变慢了！"))
			user.add_movespeed_modifier(/datum/movespeed_modifier/die_of_fate)
		if(7)
			//Throw
			selected_turf.visible_message(span_userdanger("无形的力量将[user]抛了出去！"))
			user.Stun(60)
			user.adjust_brute_loss(50)
			var/throw_dir = pick(GLOB.cardinals)
			var/atom/throw_target = get_edge_target_turf(user, throw_dir)
			user.throw_at(throw_target, 200, 4)
		if(8)
			//Fuel tank Explosion
			selected_turf.visible_message(span_userdanger("[user]周围突然发生了爆炸！"))
			explosion(get_turf(user), devastation_range = -1, light_impact_range = 2, flame_range = 2, explosion_cause = src)
		if(9)
			//Cold
			var/datum/disease/cold = new /datum/disease/cold()
			selected_turf.visible_message(span_userdanger("[user]看起来有点不舒服！"))
			user.ForceContractDisease(cold, FALSE, TRUE)
		if(10)
			//Nothing
			selected_turf.visible_message(span_userdanger("似乎什么都没发生。"))
		if(11)
			//Cookie
			selected_turf.visible_message(span_userdanger("一块曲奇凭空出现了！"))
			var/obj/item/food/cookie/ooh_a_cookie = new(drop_location())
			do_smoke(0, src, drop_location())
			ooh_a_cookie.name = "命运曲奇"
		if(12)
			//Healing
			selected_turf.visible_message(span_userdanger("[user]看起来非常健康！"))
			user.revive(ADMIN_HEAL_ALL)
		if(13)
			//Mad Dosh
			selected_turf.visible_message(span_userdanger("大把钞票从[src]中喷涌而出！"))
			var/turf/Start = get_turf(src)
			for(var/direction in GLOB.alldirs)
				var/turf/dirturf = get_step(Start,direction)
				if(prob(50))
					new /obj/item/stack/spacecash/c1000(dirturf)
					continue
				var/obj/item/storage/bag/money/bag_money = new(dirturf)
				for(var/i in 1 to rand(5,50))
					new /obj/item/coin/gold(bag_money)
		if(14)
			//Free Gun
			selected_turf.visible_message(span_userdanger("一把气派的枪出现了！"))
			do_smoke(0, src, drop_location())
			new /obj/item/gun/ballistic/revolver/mateba(drop_location())
		if(15)
			//Random One-use spellbook
			selected_turf.visible_message(span_userdanger("一本看似充满魔力的书落在地上！"))
			do_smoke(0, src, drop_location())
			new /obj/item/book/granter/action/spell/random(drop_location())
		if(16)
			//Servant & Servant Summon
			selected_turf.visible_message(span_userdanger("[user]周身涌动着新获得的魔力！"))
			var/datum/action/cooldown/spell/summon_mob/dice/summon_servant = new(user.mind || user)
			summon_servant.Grant(user)
		if(17)
			//Tator Kit
			selected_turf.visible_message(span_userdanger("一个可疑的箱子出现了！"))
			new /obj/item/storage/box/syndicate/bundle_a(drop_location())
			do_smoke(0, src, drop_location())
		if(18)
			//Captain ID
			selected_turf.visible_message(span_userdanger("一张金色身份卡出现了！"))
			new /obj/item/card/id/advanced/gold/captains_spare(drop_location())
			do_smoke(0, src, drop_location())
		if(19)
			//Instrinct Resistance
			selected_turf.visible_message(span_userdanger("[user]看起来非常强健！"))
			user.physiology.brute_mod *= 0.5
			user.physiology.burn_mod *= 0.5

		if(20)
			//Free wizard!
			selected_turf.visible_message(span_userdanger("魔力从[src]中流出，涌入[user]体内！"))
			user.mind.make_wizard()

#undef MIN_SIDES_ALERT
