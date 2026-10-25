
//yep you guessed it back at it again with another datum singleton.
/datum/orion_event
	var/name = "this displays the events name"
	var/text = "此处显示事件简介"
	///pickweight to show up. will still be in the events pool if added to the events list but not RANDOM, only triggered.
	var/weight = 0
	///buttons to pick in response to the event. Don't worry, orion js will handle the rest
	var/list/event_responses = list()
	///default emag effect of events is to play an audible message and sound
	var/emag_message
	var/emag_sound
	///gaming skill level of the player
	var/gamer_skill_level = 0
	///gaming skill of the player
	var/gamer_skill = 0
	///some other metric that makes it easier to do randoms with skill testing, god really 3 vars guys
	var/gamer_skill_rands = 0

/**
 * What happens when this event is selected to trigger, sets vars. also can set some event pre-encounter randomization
 *
 * Arguments:
 * * game: arcade machine calling this
 * * gamer_skill: gaming skill of the player
 * * gamer_skill_level: gaming skill level of the player
 * * gamer_skill_rands: See above but it's another metric, you can just look at gaming skill to see how it chalks that up
 */
/datum/orion_event/proc/on_select(obj/machinery/computer/arcade/orion_trail/game, gamer_skill, gamer_skill_level, gamer_skill_rands)
	SHOULD_CALL_PARENT(TRUE)
	src.gamer_skill_level = gamer_skill_level
	src.gamer_skill = gamer_skill
	src.gamer_skill_rands = gamer_skill_rands

/**
 * What happens when you respond to this event by choosing one of the buttons
 *
 * Arguments:
 * * game: arcade machine calling this
 * * choice: name of the button you pressed.
 */
/datum/orion_event/proc/response(obj/machinery/computer/arcade/orion_trail/game, choice)
	game.event = null

/**
 * Some effect that happens to the carbon when this event triggers on an emagged arcade machine.
 *
 * By default, it just sends an audible message and a sound, both vars on the orion datum
 * Arguments:
 * * game: arcade machine calling this
 * * gamer: victim to apply effects to
 * * gamer_skill: skill of the gamer, because gamers gods can lessen the effects of the emagged machine
 * * gamer_skill_level: skill level of the gamer, another way to measure emag downside avoidance
 */
/datum/orion_event/proc/emag_effect(obj/machinery/computer/arcade/orion_trail/game, mob/living/gamer)
	if(emag_message)
		game.audible_message(emag_message)
	if(emag_sound)
		playsound(game, emag_sound, 100, TRUE)

#define BUTTON_FIX_ENGINE "Fix Engine"
#define BUTTON_WAIT "Wait"

///Engine Breakdown - spend one engine part or wait 3 days (harmless emag effect)
/datum/orion_event/engine_part
	name = "Engine Breakdown"
	text = "糟了！引擎坏了！\
	你可以用一个引擎零件修好它，\
	也可以花三天时间进行维修。"
	emag_message = span_warning("你听见身后某个庞然大物猛地停了下来！回头一看，却什么都没有……")
	emag_sound = 'sound/effects/creak/creak1.ogg'
	weight = 2
	event_responses = list()

/datum/orion_event/engine_part/on_select(obj/machinery/computer/arcade/orion_trail/game, gamer_skill, gamer_skill_level, gamer_skill_rands)
	..()
	if(game.engine >= 1)
		event_responses += BUTTON_FIX_ENGINE
	event_responses += BUTTON_WAIT

/datum/orion_event/engine_part/response(obj/machinery/computer/arcade/orion_trail/game, choice)
	if(choice == BUTTON_FIX_ENGINE)
		game.engine = max(0, --game.engine)
	else
		game.food -= (game.alive + game.lings_aboard) * ORION_LONG_DELAY
	event_responses.Cut()
	..()

#define BUTTON_REPAIR_ELECTRONICS "Repair Electronics"

///Malfunction - spend one engine part or wait 3 days (emag effect randomizes some stats)
/datum/orion_event/electronic_part
	name = "Malfunction"
	text = "飞船系统出现故障！\
	你可以用备用电子零件替换损坏部件，\
	也可以花三天时间排查 AI 的故障。"
	weight = 2
	//set by select
	event_responses = list()

/datum/orion_event/electronic_part/on_select(obj/machinery/computer/arcade/orion_trail/game, gamer_skill, gamer_skill_level, gamer_skill_rands)
	..()
	if(game.electronics >= 1)
		event_responses += BUTTON_REPAIR_ELECTRONICS
	event_responses += BUTTON_WAIT

/datum/orion_event/electronic_part/response(obj/machinery/computer/arcade/orion_trail/game, choice)
	if(choice == BUTTON_REPAIR_ELECTRONICS)
		game.electronics = max(0, game.electronics - 1)
	else
		game.food -= (game.alive + game.lings_aboard) * ORION_LONG_DELAY
	event_responses.Cut()
	..()

/datum/orion_event/electronic_part/emag_effect(obj/machinery/computer/arcade/orion_trail/game, mob/living/gamer)
	playsound(game, 'sound/effects/empulse.ogg', 50, TRUE)
	game.visible_message(span_danger("[game]发生故障，游戏中的数值被随机打乱！"))
	var/oldfood = game.food
	var/oldfuel = game.fuel
	game.food = rand(10,80) / rand(1,2)
	game.fuel = rand(10,60) / rand(1,2)
	if(game.electronics)
		addtimer(CALLBACK(src, PROC_REF(revert_random), game, oldfood, oldfuel), 1 SECONDS)

/datum/orion_event/electronic_part/proc/revert_random(obj/machinery/computer/arcade/orion_trail/game, oldfood, oldfuel)
	if(oldfuel > game.fuel && oldfood > game.food)
		game.audible_message(span_danger("[game]发出一声莫名令人安心的提示音。"))
	else if(oldfuel < game.fuel || oldfood < game.food)
		game.audible_message(span_danger("[game]发出一声莫名不祥的提示音。"))
	game.food = oldfood
	game.fuel = oldfuel
	playsound(game, 'sound/machines/chime.ogg', 50, TRUE)

#define BUTTON_RESTORE_HULL "Restore Hull"

///Collision - spend one engine part or wait 3 days (has a nasty emag effect)
/datum/orion_event/hull_part
	name = "Collision"
	text = "有什么东西撞上了我们！船壳似乎受损了。\
	你可以用船壳板修复损伤，\
	也可以花三天时间把废料焊接起来。"
	weight = 2
	event_responses = list()

/datum/orion_event/hull_part/on_select(obj/machinery/computer/arcade/orion_trail/game, gamer_skill, gamer_skill_level, gamer_skill_rands)
	..()
	if(game.hull >= 1)
		event_responses += BUTTON_RESTORE_HULL
	event_responses += BUTTON_WAIT

/datum/orion_event/hull_part/response(obj/machinery/computer/arcade/orion_trail/game, choice)
	if(choice == BUTTON_RESTORE_HULL)
		game.hull = max(0, game.hull - 1)
	else
		game.food -= (game.alive + game.lings_aboard) * ORION_LONG_DELAY
	event_responses.Cut()
	..()

/datum/orion_event/hull_part/emag_effect(obj/machinery/computer/arcade/orion_trail/game, mob/living/gamer)
	if(prob(10+gamer_skill))
		game.say("有什么东西猛地撞上[game]附近的地板——幸好没有撞穿！")
		playsound(game, 'sound/effects/bang.ogg', 50, TRUE)
		return
	playsound(game, 'sound/effects/bang.ogg', 100, TRUE)
	for(var/turf/open/floor/smashed in orange(1, game))
		smashed.ScrapeAway()
	game.say("有什么东西撞穿了[game]附近的地板，使这里暴露在太空中！")
	if(game.hull)
		addtimer(CALLBACK(src, PROC_REF(fix_floor), game), 1 SECONDS)

/datum/orion_event/hull_part/proc/fix_floor(obj/machinery/computer/arcade/orion_trail/game)
	game.say("[game]周围突然出现了一块新地板。这是什么鬼？")
	playsound(game, 'sound/items/weapons/genhit.ogg', 100, TRUE)
	for(var/turf/open/space/fixed in orange(1, game))
		fixed.place_on_top(/turf/open/floor/plating)

#define BUTTON_EXPLORE_SHIP "Explore Ship"
#define BUTTON_LEAVE_THE_DERELICT "Leave the Derelict"

/datum/orion_event/old_ship
	name = "Derelict Ship"
	text = "你的船员发现一艘旧飞船漂浮在太空中。\
	里面也许有些补给，但看起来相当危险。"
	weight = 2
	event_responses = list(BUTTON_EXPLORE_SHIP, BUTTON_LEAVE_THE_DERELICT)

/datum/orion_event/old_ship/response(obj/machinery/computer/arcade/orion_trail/game, choice)
	if(choice == BUTTON_LEAVE_THE_DERELICT)
		return ..()
	game.encounter_event(/datum/orion_event/exploring_derelict)

/datum/orion_event/old_ship/emag_effect(obj/machinery/computer/arcade/orion_trail/game, mob/living/gamer)
	return //do nothing because this leads into an event where we actually will do something.

#define BUTTON_WELCOME_ABOARD "Welcome aboard."
#define BUTTON_WHERE_DID_YOU_GO "Where did you go?!"
#define BUTTON_A_GOOD_FIND "A good find."
#define BUTTON_CONTINUE_TRAVELS "Continue travels."

/datum/orion_event/exploring_derelict
	name = "Derelict Exploration"
	weight = 2
	//set by on_select
	event_responses = list()

/datum/orion_event/exploring_derelict/on_select(obj/machinery/computer/arcade/orion_trail/game, gamer_skill, gamer_skill_level, gamer_skill_rands)
	..()
	switch(rand(100))
		if(0 to 14)
			var/rescued = game.add_crewmember()
			var/oldfood = rand(1,7)
			var/oldfuel = rand(4,10)
			game.food += oldfood
			game.fuel += oldfuel
			text = "搜寻时，你找到了些补给和一个活人！\
			你从废弃飞船上救出了[rescued]！还找到了[oldfood]份食物和[oldfuel]份燃料。"
			event_responses += BUTTON_WELCOME_ABOARD
		if(15 to 35)
			var/lostfuel = rand(4,7)
			var/deadname = game.remove_crewmember()
			game.fuel -= lostfuel
			text = "[deadname]在残骸深处失踪了，而你的飞船在靠近废弃飞船时消耗了[lostfuel]份燃料。"
			event_responses += BUTTON_WHERE_DID_YOU_GO
		if(36 to 65)
			var/oldfood = rand(5,11)
			game.food += oldfood
			game.engine++
			text = "你在残骸中找到了[oldfood]份食物和一些零件。"
			event_responses += BUTTON_A_GOOD_FIND
		else
			text = "你搜遍了残骸，却没找到多少有用的东西。"
			event_responses += BUTTON_CONTINUE_TRAVELS

/datum/orion_event/exploring_derelict/response(obj/machinery/computer/arcade/orion_trail/game, choice)
	event_responses.Cut() //so they don't pile up between games
	..()

#define BUTTON_CONTINUE "Continue"

/datum/orion_event/raiders
	name = "Raiders"
	weight = 3
	event_responses = list(BUTTON_CONTINUE)

/datum/orion_event/raiders/on_select(obj/machinery/computer/arcade/orion_trail/game, gamer_skill, gamer_skill_level, gamer_skill_rands)
	..()
	text = "掠夺者登上了你的飞船！"
	if(prob(50))
		var/sfood = rand(1,10)
		var/sfuel = rand(1,10)
		game.food -= sfood
		game.fuel -= sfuel
		text += "他们抢走了[sfood]份食物和[sfuel]份燃料。"
	else if(prob(10))
		var/deadname = game.remove_crewmember()
		text += "[deadname]试图反抗，却被杀死了。"
	else
		text += "幸运的是，你毫不费力地击退了他们。"

/datum/orion_event/raiders/emag_effect(obj/machinery/computer/arcade/orion_trail/game, mob/living/gamer)
	if(prob(50-gamer_skill))
		to_chat(usr, span_userdanger("你听见战斗的喊声、靴子踩踏冰冷金属的声音、痛苦的尖叫，以及空气泄出的呼啸。你快疯了吗？"))
		gamer.adjust_hallucinations(60 SECONDS)
	else
		to_chat(usr, span_userdanger("有什么东西从背后击中了你！疼得要命，像是钝器，可那里什么都没有……"))
		gamer.take_bodypart_damage(30)
		playsound(game, 'sound/items/weapons/genhit2.ogg', 100, TRUE)

/datum/orion_event/illness
	name = "Space Illness"
	//needs to specify who died, set by select
	weight = 3
	event_responses = list(BUTTON_CONTINUE)

/datum/orion_event/illness/on_select(obj/machinery/computer/arcade/orion_trail/game, gamer_skill, gamer_skill_level, gamer_skill_rands)
	..()
	var/deadname = game.remove_crewmember()
	text = "有人感染了致命疾病！[deadname]死于这种疾病。"

/datum/orion_event/illness/emag_effect(obj/machinery/computer/arcade/orion_trail/game, mob/living/gamer)
	var/maxSeverity = 3
	if(gamer_skill_level >= SKILL_LEVEL_EXPERT)
		maxSeverity = 2 //part of gitting gud is rng mitigation
	var/severity = rand(1,maxSeverity) //pray to RNGesus. PRAY, PIGS
	if(severity == 1)
		to_chat(gamer, span_userdanger("你突然感到有点恶心。") )
		gamer.adjust_disgust(50)
	if(severity == 2)
		to_chat(usr, span_userdanger("你突然感到极度恶心，弯下腰，直到不适消退。"))
		gamer.adjust_disgust(110)
		gamer.Stun(60)
	if(severity >= 3) //you didn't pray hard enough
		to_chat(gamer, span_warning("一股强烈的恶心感席卷了你。你弯下腰，胃里的东西正准备来一次壮观的喷发。"))
		gamer.adjust_disgust(150) //max this bitch out so they barf a lot
		gamer.Stun(100)

#define BUTTON_KEEP_SPEED "Keep Speed"
#define BUTTON_SLOW_DOWN "Slow Down"

/datum/orion_event/flux
	name = "Flux"
	text = "这片太空的乱流十分剧烈。减速前进\
	或许可以避免更多损伤，而保持速度则不会浪费补给。"
	weight = 1
	event_responses = list(BUTTON_KEEP_SPEED, BUTTON_SLOW_DOWN)

/datum/orion_event/flux/response(obj/machinery/computer/arcade/orion_trail/game, choice)
	if(choice == BUTTON_KEEP_SPEED)
		if(prob(25))
			return ..()
		game.encounter_event(/datum/orion_event/engine_part)
	else //Slow Down response
		game.food -= (game.alive+game.lings_aboard) * ORION_SHORT_DELAY
		game.fuel -= 5
		..()

/datum/orion_event/flux/emag_effect(obj/machinery/computer/arcade/orion_trail/game, mob/living/gamer)
	if(prob(25 + gamer_skill))//withstand the wind with your GAMER SKILL
		to_chat(gamer, span_userdanger("一阵狂风从你身旁掠过，你勉强站稳了脚跟！"))
		return
	gamer.Paralyze(60)
	game.say("一阵突如其来的强风将[gamer]掀翻在地！")
	gamer.take_bodypart_damage(25)
	playsound(game, 'sound/items/weapons/genhit.ogg', 100, TRUE)

/datum/orion_event/changeling_infiltration
	name = "Changeling Infiltration"
	weight = 3
	event_responses = list(BUTTON_CONTINUE)

/datum/orion_event/changeling_infiltration/on_select(obj/machinery/computer/arcade/orion_trail/game, gamer_skill, gamer_skill_level, gamer_skill_rands)
	. = ..()
	text = "奇怪的报告警告称，有变形怪混进了前往猎户座的船员中……"
	if(game.settlers.len <= 2)
		text += "不过，你的船员抵达猎户座的希望如此渺茫，变形怪大概避开了你的飞船……"
		if(prob(10)) // "likely", I didn't say it was guaranteed! //worst outcome too because changeling controls don't even enable
			game.lings_aboard = min(++game.lings_aboard,2)
	else
		if(game.lings_aboard) //less likely to stack lings
			if(prob(20))
				game.lings_aboard = min(++game.lings_aboard,2)
		else if(prob(70))
			game.lings_aboard = min(++game.lings_aboard,2)

		text += "你有充分理由怀疑船上存在变形怪。部分菜单选项已更改。"
		game.lings_suspected = TRUE

/datum/orion_event/changeling_attack
	name = "Changeling Attack"
	event_responses = list(BUTTON_CONTINUE)

/datum/orion_event/changeling_attack/on_select(obj/machinery/computer/arcade/orion_trail/game, gamer_skill, gamer_skill_level, gamer_skill_rands)
	. = ..()
	text = ""
	if(game.lings_aboard <= 0) //shouldn't trigger, but hey.
		text = "哈哈，骗到你了，船上没有变形怪！（你应该向程序员报告这个问题 :S）"
		return
	var/ling1 = game.remove_crewmember()
	var/ling2 = ""
	if(game.lings_aboard >= 2)
		ling2 = game.remove_crewmember()
	if(ling2)
		text = "[ling1]和[ling2]的手臂扭曲变形，化作骇人的利刃！"
	else
		text = "[ling1]的手臂扭曲变形，化作骇人的利刃！"

	var/chance2attack = game.alive*20
	if(!prob(chance2attack))
		text += "[pick("察觉胜算渺茫", "一次攻击失败后", "突然失去勇气后")]，\
		变形怪[ling2 ? "们":""]穿过气闸逃进了太空！你安全了……暂时如此。"
		if(ling2)
			game.lings_aboard = max(0,game.lings_aboard-2)
		else
			game.lings_aboard = max(0,game.lings_aboard - 2)
		return

	var/chancetokill = 30*game.lings_aboard-(5*game.alive) //eg: 30*2-(10) = 50%, 2 lings, 2 crew is 50% chance
	if(prob(chancetokill))
		var/deadguy = game.remove_crewmember()
		var/murder_text = pick(
			"变形怪[ling2 ? "们" : ""]扑倒[deadguy]，将其开膛破肚，鲜血四溅！", \
			"[ling2 ? pick(ling1, ling2) : ling1]将[deadguy]逼入角落，刺穿了其腹部！", \
			"[ling2 ? pick(ling1, ling2) : ling1]一记横斩便砍下了[deadguy]的头！")
		text += " [murder_text]"
	else
		text += "你英勇地击退了变形怪[ling2 ? "们":""]！"
		if(ling2)
			game.food += 30
			game.lings_aboard = max(0, game.lings_aboard - 2)
		else
			game.food += 15
			game.lings_aboard = max(0, game.lings_aboard - 1)
		text += "嗯，这可是上好的食物……\
			你将变形怪[ling2 ? "们" : ""]切成肉块，获得了[ling2 ? "30" : "15"]份食物！"

#define BUTTON_SPEED_PAST "Speed Past"
#define BUTTON_GO_AROUND "Go Around"

///Black Hole - final  (emag can spawn singulo, see death event)
/datum/orion_event/black_hole
	name = "Looming Black Hole"
	text = "传感器显示，一个黑洞的引力场\
	正在影响我们即将经过的空域。我们可以保持航线，\
	但可能被它的引力吞噬；也可以\
	改变航线绕过去，不过会花更长时间。"
	event_responses = list(BUTTON_SPEED_PAST, BUTTON_GO_AROUND)

/datum/orion_event/black_hole/response(obj/machinery/computer/arcade/orion_trail/game, choice)
	if(choice == BUTTON_GO_AROUND)
		game.food -= (game.alive + game.lings_aboard) * ORION_LONG_DELAY
		game.fuel -= 15
		game.turns += 1
		return ..()
	if(prob(75-gamer_skill))
		game.encounter_event(/datum/orion_event/black_hole_death, usr)
		return
	game.turns += 1
	..()

#define BUTTON_OH "Oh..."

///You died to a black hole, have some fluff text
/datum/orion_event/black_hole_death
	name = "Event Horizon"
	text = "当你加速推进穿梭机时，才意识到自己低估了\
	黑洞的引力。无论如何挣扎，都无法摆脱这股巨力。\
	不久后你便越过了事件视界。你闭上双眼，准备迎接\
	撕裂一切的力量，飞船在引力下开始扭曲变形。"
	event_responses = list(BUTTON_OH)

/datum/orion_event/black_hole_death/response(obj/machinery/computer/arcade/orion_trail/game, choice)
	game.set_game_over(usr, "你被卷入了黑洞。")
	..()

/datum/orion_event/black_hole_death/emag_effect(obj/machinery/computer/arcade/orion_trail/game, mob/living/gamer)
	if(game.obj_flags & EMAGGED)
		playsound(game.loc, 'sound/effects/supermatter.ogg', 100, TRUE)
		game.say("一个微型黑洞突然出现在[game]前，将[gamer]活活吞噬！")
		gamer.Stun(200, ignore_canstun = TRUE) //you can't run :^)
		var/black_hole = new /obj/singularity/orion(gamer.loc)
		addtimer(CALLBACK(game, TYPE_PROC_REF(/atom/movable, say), "[black_hole]突然消失，和它出现时一样突兀。"), 5 SECONDS)
		QDEL_IN(black_hole, 5 SECONDS)

#define BUTTON_DOCK "Dock"

///You found a space port!
/datum/orion_event/space_port
	name = "Space Port"
	var/normal_arrival = "你在猎户座之路上发现了一小片文明聚居地。\
	附近太空港发来友好的呼叫，\
	欢迎你停靠休整，为接下来的旅程做好准备。"
	weight = 2
	event_responses = list(BUTTON_DOCK)

/datum/orion_event/space_port/on_select(obj/machinery/computer/arcade/orion_trail/game, gamer_skill, gamer_skill_level, gamer_skill_rands)
	. = ..()
	//If your crew is pathetic you can get freebies (provided you haven't already gotten one from this port)
	if(game.fuel > 20 && game.food > 20) //but you don't need one
		text = normal_arrival
		return
	text = "太空港的工作人员被你的拓荒者们\
	凄惨的处境震惊了。看到补给如此短缺，他们同情你和\
	你的船员，慷慨地赠送了一些免费补给！"


	var/pity_fuel = 10
	var/pity_food = 10
	var/freecrew = prob(10)
	if(prob(30))
		pity_fuel = 25
		pity_fuel = 25
	if(freecrew)
		game.add_crewmember()
	text += "（燃料+[pity_fuel]，食物+[pity_food]）"
	if(freecrew)
		text += "一名太空港工人被你的决心打动，加入了你的船员队伍！"
	game.fuel += pity_fuel
	game.food += pity_food

/datum/orion_event/space_port/response(obj/machinery/computer/arcade/orion_trail/game, choice)
	game.gameStatus = ORION_STATUS_MARKET
	..()

///You found the midway mark!
/datum/orion_event/space_port/tau_ceti
	name = "Tau Ceti Beta"
	normal_arrival = "你抵达了旅程的中点，也是沿途最大的太空港：\
	鲸鱼座τ星贝塔港。这里繁忙而充满生机，让你重新燃起了\
	在猎户座开创未来的希望。"
	//triggered by getting halfway
	weight = 0

///You raided a space port!
/datum/orion_event/space_port_raid
	name = "Space Port Raid"

	event_responses = list(BUTTON_CONTINUE)

/datum/orion_event/space_port_raid/on_select(obj/machinery/computer/arcade/orion_trail/game, gamer_skill, gamer_skill_level, gamer_skill_rands)
	. = ..()
	var/success = min(15 * game.alive + gamer_skill,100) //default crew (4) have a 60% chance
	game.spaceport_raided = TRUE

	var/fuel = 0
	var/food = 0
	if(prob(success))
		fuel = rand(5 + gamer_skill_rands,15 + gamer_skill_rands)
		food = rand(5 + gamer_skill_rands,15 + gamer_skill_rands)
		text = "你成功洗劫了太空港！获得了[fuel]份燃料和[food]份食物！（燃料+[fuel]，食物+[food]）"
		usr?.mind?.adjust_experience(/datum/skill/gaming, 10)
	else
		fuel = rand(-5,-15)
		food = rand(-5,-15)
		text = "你洗劫太空港失败了！仓皇逃跑时损失了[fuel*-1]份燃料和[food*-1]份食物！（燃料[fuel]，食物[food]）"

		//your chance of lose a crewmember is 1/2 your chance of success
		//this makes higher % failures hurt more, don't get cocky space cowboy!
		if(prob(success*5))
			var/lost_crew = game.remove_crewmember()
			if(!game.settlers.len)
				game.set_game_over(usr, "你被太空港安保人员击毙了。")
				return ..()
			text = "你洗劫太空港失败了！仓皇逃跑时损失了[fuel*-1]份燃料、[food*-1]份食物，还失去了[lost_crew]！（燃料[fuel]，食物[food]，船员减少）"
			if(game.obj_flags & EMAGGED)
				game.say("呜哇！呜哇！太空港安保正在赶来！")
				playsound(game, 'sound/items/weeoo1.ogg', 100, FALSE)
				for(var/i in 1 to 3)
					var/mob/living/basic/trooper/syndicate/ranged/smg/orion/spaceport_security = new(get_turf(game))
					spaceport_security.ai_controller.set_blackboard_key(BB_CURRENT_TARGET, usr)
	game.fuel += fuel
	game.food += food

#undef BUTTON_A_GOOD_FIND
#undef BUTTON_CONTINUE
#undef BUTTON_CONTINUE_TRAVELS
#undef BUTTON_DOCK
#undef BUTTON_EXPLORE_SHIP
#undef BUTTON_FIX_ENGINE
#undef BUTTON_GO_AROUND
#undef BUTTON_KEEP_SPEED
#undef BUTTON_LEAVE_THE_DERELICT
#undef BUTTON_OH
#undef BUTTON_REPAIR_ELECTRONICS
#undef BUTTON_RESTORE_HULL
#undef BUTTON_SLOW_DOWN
#undef BUTTON_SPEED_PAST
#undef BUTTON_WAIT
#undef BUTTON_WELCOME_ABOARD
#undef BUTTON_WHERE_DID_YOU_GO
