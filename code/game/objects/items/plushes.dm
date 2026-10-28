/obj/item/toy/plush
	name = "毛绒玩具"
	desc = "这是程序员专属毛绒玩具，请勿偷窃。"
	icon = 'icons/obj/toys/plushes.dmi'
	icon_state = "debug"
	worn_icon_state = "plushie"
	attack_verb_continuous = list("捶打着", "猛砸着", "碰撞着")
	attack_verb_simple = list("捶打", "猛砸", "碰撞")
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	floor_placeable = TRUE
	var/list/squeak_override //Weighted list; If you want your plush to have different squeak sounds use this
	var/stuffed = TRUE //If the plushie has stuffing in it
	var/obj/item/grenade/grenade //You can remove the stuffing from a plushie and add a grenade to it for *nefarious uses*
	//--love ~<3--
	gender = NEUTER
	var/obj/item/toy/plush/lover
	var/obj/item/toy/plush/partner
	var/obj/item/toy/plush/plush_child
	var/obj/item/toy/plush/paternal_parent //who initiated creation
	var/obj/item/toy/plush/maternal_parent //who owns, see love()
	var/list/scorned = list() //who the plush hates
	var/list/scorned_by = list() //who hates the plush, to remove external references on Destroy()
	var/heartbroken = FALSE
	var/vowbroken = FALSE
	var/young = FALSE
	///Prevents players from cutting stuffing out of a plushie if true
	var/divine = FALSE
	var/mood_message
	var/list/love_message
	var/list/partner_message
	var/list/heartbroken_message
	var/list/vowbroken_message
	var/list/parent_message
	var/normal_desc
	/// The type of offspring this plush generates. If not set, it'll default to the type itself on init.
	var/offspring_type

	//--end of love :'(--

/*
** If you add a new plushie please add it to the lists at both:
** /obj/effect/spawner/random/entertainment/plushie
** /obj/effect/spawner/random/entertainment/plushie_delux
*/

/obj/item/toy/plush/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, squeak_override)
	AddElement(/datum/element/bed_tuckable, mapload, 6, -5, 90)
	AddElement(/datum/element/toy_talk)
	AddElement(/datum/element/cuffable_item)

	//have we decided if Pinocchio goes in the blue or pink aisle yet?
	if(gender == NEUTER)
		if(prob(50))
			gender = FEMALE
		else
			gender = MALE

	if(!offspring_type)
		offspring_type = type

	love_message = list("\n[src] 高兴得快要崩开线头了！")
	partner_message = list("\n[src] 的手指上戴着一枚戒指！上面写着：与我亲爱的[partner]缔结永恒。")
	heartbroken_message = list("\n[src] 看起来好伤心。")
	vowbroken_message = list("\n[src] 弄丢了戒指……")
	parent_message = list("\n[src] 已经忘了睡觉是什么滋味。")

	normal_desc = desc

/obj/item/toy/plush/Destroy()
	QDEL_NULL(grenade)

	//inform next of kin and... acquaintances
	if(partner)
		partner.bad_news(src)
		partner = null
		lover = null
	else if(lover)
		lover.bad_news(src)
		lover = null

	if(paternal_parent)
		paternal_parent.bad_news(src)
		paternal_parent = null

	if(maternal_parent)
		maternal_parent.bad_news(src)
		maternal_parent = null

	if(plush_child)
		plush_child.bad_news(src)
		plush_child = null

	var/i
	var/obj/item/toy/plush/P
	for(i=1, i <= scorned.len, i++)
		P = scorned[i]
		P.bad_news(src)
	scorned = null

	for(i=1, i <= scorned_by.len, i++)
		P = scorned_by[i]
		P.bad_news(src)
	scorned_by = null

	//null remaining lists
	squeak_override = null

	love_message = null
	partner_message = null
	heartbroken_message = null
	vowbroken_message = null
	parent_message = null

	return ..()

/obj/item/toy/plush/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == grenade)
		grenade = null

/obj/item/toy/plush/attack_self(mob/user)
	. = ..()
	if(stuffed || grenade)
		to_chat(user, span_notice("你抚摸了[src]。好萌啊。"))
		if(grenade && !grenade.active)
			user.log_message("在[src]中激活了一枚隐藏的手榴弹。", LOG_VICTIM)
			grenade.arm_grenade(user, msg = FALSE, volume = 10)
	else
		to_chat(user, span_notice("你想抚摸[src]，但它已经没有填充棉了。唉……"))

/obj/item/toy/plush/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(tool.get_sharpness())
		if(grenade)
			to_chat(user, span_notice("你从[src]里取出了手榴弹。"))
			user.put_in_hands(grenade)
			return ITEM_INTERACT_SUCCESS
		if(!stuffed)
			to_chat(user, span_warning("你已经把它谋杀了！"))
			return ITEM_INTERACT_BLOCKING
		if(!divine)
			user.visible_message(span_notice("[user] 从[src]里扯出了填充棉！"), span_notice("你从[src]里扯出一大把填充棉。凶手。"))
			tool.play_tool_sound(src)
			stuffed = FALSE
			return ITEM_INTERACT_SUCCESS

		to_chat(user, span_notice("你真是个傻瓜。[src] 是神，你怎能杀死一位神？多么宏大而令人沉醉的天真。"))
		user.adjust_drunk_effect(20, up_to = 50)

		var/turf/current_location = get_turf(user)
		var/area/current_area = current_location.loc //copied from hand tele code
		if(current_location && current_area && (current_area.area_flags & NOTELEPORT))
			to_chat(user, span_notice("无路可逃。在此地，任何召回或干预都无法生效。"))
		else
			to_chat(user, span_notice("无路可逃。尽管在此地召回或干预仍可生效，但试图逃离[src]的浩瀚伟力只是徒劳。"))
		user.visible_message(span_notice("[user] 放下武器，乞求[src]的宽恕！"), span_notice("你放下武器，乞求[src]的宽恕。"))
		user.drop_all_held_items()
		return ITEM_INTERACT_SUCCESS

	if(isgrenade(tool))
		if(stuffed)
			to_chat(user, span_warning("你得先取出一些填充棉！"))
			return ITEM_INTERACT_BLOCKING
		if(grenade)
			to_chat(user, span_warning("[src] 里已经有一枚手榴弹了！"))
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(span_warning("[user] 把[grenade]塞进了[src]。"), \
		span_danger("你把[tool]塞进了[src]。"))
		grenade = tool
		user.log_message("向[src]中添加了一枚手榴弹（[tool.name]）", LOG_GAME)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/toy/plush))
		love(tool, user)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/toy/plush/proc/love(obj/item/toy/plush/Kisser, mob/living/user) //~<3
	var/chance = 100 //to steal a kiss, surely there's a 100% chance no-one would reject a plush such as I?
	var/concern = 20 //perhaps something might cloud true love with doubt
	var/loyalty = 30 //why should another get between us?
	var/duty = 50 //conquering another's is what I live for

	//we are not catholic
	if(young == TRUE || Kisser.young == TRUE)
		user.show_message(span_notice("[src] 和[Kisser]玩起了抓人游戏。"), MSG_VISUAL,
			span_notice("它们很开心。"), NONE)
		Kisser.cheer_up()
		cheer_up()

	//never again
	else if(Kisser in scorned)
		//message, visible, alternate message, neither visible nor audible
		user.show_message(span_notice("[src] 拒绝了[Kisser]的示好！"), MSG_VISUAL,
			span_notice("感觉没什么效果。"), NONE)
	else if(src in Kisser.scorned)
		user.show_message(span_notice("[Kisser] 认出了[src]是谁，转身离开了。"), MSG_VISUAL,
			span_notice("感觉没什么效果。"), NONE)

	//first comes love
	else if(Kisser.lover != src && Kisser.partner != src) //cannot be lovers or married
		if(Kisser.lover) //if the initiator has a lover
			Kisser.lover.heartbreak(Kisser) //the old lover can get over the kiss-and-run whilst the kisser has some fun
			chance -= concern //one heart already broken, what does another mean?
		if(lover) //if the recipient has a lover
			chance -= loyalty //mustn't... but those lips
		if(partner) //if the recipient has a partner
			chance -= duty //do we mate for life?

		if(prob(chance)) //did we bag a date?
			user.visible_message(span_notice("[user] 让[Kisser]亲吻了[src]！"),
									span_notice("你让[Kisser]亲吻了[src]！"))
			if(lover) //who cares for the past, we live in the present
				lover.heartbreak(src)
			new_lover(Kisser)
			Kisser.new_lover(src)
		else
			user.show_message(span_notice("[src] 拒绝了[Kisser]的示好，也许下次吧？"), MSG_VISUAL,
								span_notice("这次感觉没什么效果。"), NONE)

	//then comes marriage
	else if(Kisser.lover == src && Kisser.partner != src) //need to be lovers (assumes loving is a two way street) but not married (also assumes similar)
		user.visible_message(span_notice("[user] 宣布[Kisser]与[src]结为夫妻！好甜。"),
									span_notice("你宣布[Kisser]与[src]结为夫妻！"))
		new_partner(Kisser)
		Kisser.new_partner(src)

	//then comes a baby in a baby's carriage, or an adoption in an adoption's orphanage
	else if(Kisser.partner == src && !plush_child) //the one advancing does not take ownership of the child and we have a one child policy in the toyshop
		user.visible_message(span_notice("[user] 这样猛撞下去会把[Kisser]和[src]弄坏的。"),
									span_notice("[Kisser] 在你手中热情地拥抱了[src]。别看了，你这变态！"))
		user.client.give_award(/datum/award/achievement/misc/rule8, user)
		if(plop(Kisser))
			user.visible_message(span_notice("有东西掉在了[user]脚边。"),
							span_notice("天啊，这奇迹——那东西刚才是从[src]里出来的吗？！"))

	//then comes protection, or abstinence if we are catholic
	else if(Kisser.partner == src && plush_child)
		user.visible_message(span_notice("[user] 让[Kisser]蹭了蹭[src]！"),
									span_notice("你让[Kisser]蹭了蹭[src]！"))

	//then oh fuck something unexpected happened
	else
		user.show_message(span_warning("[Kisser] 和[src]都不知道该拿对方怎么办。"), NONE)

/obj/item/toy/plush/proc/heartbreak(obj/item/toy/plush/Brutus)
	if(lover != Brutus)
		CRASH("plushie heartbroken by a plushie that is not their lover")

	scorned.Add(Brutus)
	Brutus.scorned_by(src)

	lover = null
	Brutus.lover = null //feeling's mutual

	heartbroken = TRUE
	mood_message = pick(heartbroken_message)

	if(partner == Brutus) //oh dear...
		partner = null
		Brutus.partner = null //it'd be weird otherwise
		vowbroken = TRUE
		mood_message = pick(vowbroken_message)

	update_desc()

/obj/item/toy/plush/proc/scorned_by(obj/item/toy/plush/Outmoded)
	scorned_by.Add(Outmoded)

/obj/item/toy/plush/proc/new_lover(obj/item/toy/plush/Juliet)
	if(lover == Juliet)
		return //nice try
	lover = Juliet

	cheer_up()
	lover.cheer_up()

	mood_message = pick(love_message)
	update_desc()

	if(partner) //who?
		partner = null //more like who cares

/obj/item/toy/plush/proc/new_partner(obj/item/toy/plush/Apple_of_my_eye)
	if(partner == Apple_of_my_eye)
		return //double marriage is just insecurity
	if(lover != Apple_of_my_eye)
		return //union not born out of love will falter

	partner = Apple_of_my_eye

	heal_memories()
	partner.heal_memories()

	mood_message = pick(partner_message)
	update_desc()

/obj/item/toy/plush/proc/plop(obj/item/toy/plush/daddy)
	if(partner != daddy)
		return FALSE //we do not have bastards in our toyshop

	// Ask the RNG if it looks more like mommy or daddy.
	var/chosen_type = pick(offspring_type, daddy.offspring_type)

	plush_child = new chosen_type(get_turf(loc))
	plush_child.make_young(src, daddy)

/obj/item/toy/plush/proc/make_young(obj/item/toy/plush/Mama, obj/item/toy/plush/Dada)
	if(Mama == Dada)
		return //cloning is reserved for plants and spacemen

	maternal_parent = Mama
	paternal_parent = Dada
	young = TRUE
	name = "[Mama] 二世" //Icelandic naming convention pending
	normal_desc = "[src] 是[maternal_parent]和[paternal_parent]的小宝宝！" //original desc won't be used so the child can have moods
	transform *= 0.75
	update_desc()

	Mama.mood_message = pick(Mama.parent_message)
	Mama.update_desc()
	Dada.mood_message = pick(Dada.parent_message)
	Dada.update_desc()

/obj/item/toy/plush/proc/bad_news(obj/item/toy/plush/Deceased) //cotton to cotton, sawdust to sawdust
	var/is_that_letter_for_me = FALSE
	if(partner == Deceased) //covers marriage
		is_that_letter_for_me = TRUE
		partner = null
		lover = null
	else if(lover == Deceased) //covers lovers
		is_that_letter_for_me = TRUE
		lover = null

	//covers children
	if(maternal_parent == Deceased)
		is_that_letter_for_me = TRUE
		maternal_parent = null

	if(paternal_parent == Deceased)
		is_that_letter_for_me = TRUE
		paternal_parent = null

	//covers parents
	if(plush_child == Deceased)
		is_that_letter_for_me = TRUE
		plush_child = null

	//covers bad memories
	if(Deceased in scorned)
		scorned.Remove(Deceased)
		cheer_up() //what cold button eyes you have

	if(Deceased in scorned_by)
		scorned_by.Remove(Deceased)

	//all references to the departed should be cleaned up by now

	if(is_that_letter_for_me)
		heartbroken = TRUE
		mood_message = pick(heartbroken_message)
		update_desc()

/obj/item/toy/plush/proc/cheer_up() //it'll be all right
	if(!heartbroken)
		return //you cannot make smile what is already
	if(vowbroken)
		return //it's a pretty big deal

	heartbroken = !heartbroken

	if(mood_message in heartbroken_message)
		mood_message = null
	update_desc()

/obj/item/toy/plush/proc/heal_memories() //time fixes all wounds
	if(!vowbroken)
		vowbroken = !vowbroken
		if(mood_message in vowbroken_message)
			mood_message = null
	cheer_up()

/obj/item/toy/plush/update_desc()
	desc = normal_desc
	. = ..()
	if(mood_message)
		desc += mood_message

/obj/item/toy/plush/carpplushie
	name = "太空鲤鱼毛绒玩具"
	desc = "一个可爱的填充玩具，外形酷似太空鲤鱼。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/toy/plush/carpplushie"
	worn_icon = "carp"
	post_init_icon_state = "map_plushie_carp"
	greyscale_config = /datum/greyscale_config/plush_carp
	greyscale_colors = "#cc99ff#000000"
	inhand_icon_state = "carp_plushie"
	attack_verb_continuous = list("咬着", "吞着", "鱼鳍拍着")
	attack_verb_simple = list("咬", "吞", "鱼鳍拍")
	squeak_override = list('sound/items/weapons/bite.ogg'=1)

/obj/item/toy/plush/bubbleplush
	name = "\improper 泡泡糖毛绒玩具"
	desc = "那只会给好矿工送礼物的友善红色恶魔。"
	icon_state = "bubbleplush"
	attack_verb_continuous = list("撕扯着")
	attack_verb_simple = list("撕扯")
	squeak_override = list('sound/effects/magic/demon_attack1.ogg'=1)

/obj/item/toy/plush/ratplush
	name = "\improper 拉特瓦毛绒玩具"
	desc = "一尊可爱的发条审判者本人毛绒玩具，配有全新改进的弹簧手臂动作。"
	icon_state = "plushvar"
	worn_icon = "ratvar"
	divine = TRUE
	var/obj/item/toy/plush/narplush/clash_target
	gender = MALE //he's a boy, right?

/obj/item/toy/plush/ratplush/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(clash_target)
		return
	var/obj/item/toy/plush/narplush/P = locate() in range(1, src)
	if(P && istype(P.loc, /turf/open) && !P.clashing)
		INVOKE_ASYNC(src, PROC_REF(clash_of_the_plushies), P)

/obj/item/toy/plush/ratplush/proc/clash_of_the_plushies(obj/item/toy/plush/narplush/P)
	clash_target = P
	P.clashing = TRUE
	say("你。")
	P.say("拉特瓦？！")
	var/obj/item/toy/plush/a_winnar_is
	var/victory_chance = 10
	for(var/i in 1 to 10) //We only fight ten times max
		if(QDELETED(src))
			P.clashing = FALSE
			return
		if(QDELETED(P))
			clash_target = null
			return
		if(!Adjacent(P))
			visible_message(span_warning("两个毛绒玩具愤怒地互相乱挥，最后放弃了。"))
			clash_target = null
			P.clashing = FALSE
			return
		playsound(src, 'sound/effects/magic/clockwork/ratvar_attack.ogg', 50, TRUE, frequency = 2)
		sleep(0.24 SECONDS)
		if(QDELETED(src))
			P.clashing = FALSE
			return
		if(QDELETED(P))
			clash_target = null
			return
		if(prob(victory_chance))
			a_winnar_is = src
			break
		P.SpinAnimation(5, 0)
		sleep(0.5 SECONDS)
		if(QDELETED(src))
			P.clashing = FALSE
			return
		if(QDELETED(P))
			clash_target = null
			return
		playsound(P, 'sound/effects/magic/clockwork/narsie_attack.ogg', 50, TRUE, frequency = 2)
		sleep(0.33 SECONDS)
		if(QDELETED(src))
			P.clashing = FALSE
			return
		if(QDELETED(P))
			clash_target = null
			return
		if(prob(victory_chance))
			a_winnar_is = P
			break
		SpinAnimation(5, 0)
		victory_chance += 10
		sleep(0.5 SECONDS)
	if(!a_winnar_is)
		a_winnar_is = pick(src, P)
	if(a_winnar_is == src)
		say(pick("死吧。", "腐朽吧。"))
		P.say(pick("不——……", "别死。别——", "死吧。拉特——", "萨斯·提恩·雷——"))
		playsound(src, 'sound/effects/magic/clockwork/anima_fragment_attack.ogg', 50, TRUE, frequency = 2)
		playsound(P, 'sound/effects/magic/demon_dies.ogg', 50, TRUE, frequency = 2)
		explosion(P, light_impact_range = 1)
		qdel(P)
		clash_target = null
	else
		say("不！我不会再被放逐一次……")
		P.say(pick("哈。", "拉莎·丰·戴斯特。", "你这蠢货，竟敢来到这里。"))
		playsound(src, 'sound/effects/magic/clockwork/anima_fragment_death.ogg', 62, TRUE, frequency = 2)
		playsound(P, 'sound/effects/magic/demon_attack1.ogg', 50, TRUE, frequency = 2)
		explosion(src, light_impact_range = 1)
		qdel(src)
		P.clashing = FALSE

/obj/item/toy/plush/narplush
	name = "\improper 纳尔西毛绒玩具"
	desc = "一位古神纳尔西的小号填充玩偶。谁会觉得这适合当儿童玩具？"
	icon_state = "narplush"
	worn_icon = "narsie"
	divine = TRUE
	var/clashing
	gender = FEMALE //it's canon if the toy is

/obj/item/toy/plush/narplush/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	var/obj/item/toy/plush/ratplush/P = locate() in range(1, src)
	if(P && istype(P.loc, /turf/open) && !P.clash_target && !clashing)
		INVOKE_ASYNC(P, TYPE_PROC_REF(/obj/item/toy/plush/ratplush, clash_of_the_plushies), src)

/obj/item/toy/plush/lizard_plushie
	name = "蜥蜴人毛绒玩具"
	desc = "一个可爱的填充玩具，外形酷似蜥蜴人。"
	icon_state = "map_plushie_lizard"
	greyscale_config = /datum/greyscale_config/plush_lizard
	attack_verb_continuous = list("抓着", "嘶嘶叫着", "尾巴拍着")
	attack_verb_simple = list("抓", "嘶嘶叫", "尾巴拍")
	squeak_override = list('sound/items/weapons/slash.ogg' = 1)

/obj/item/toy/plush/lizard_plushie/Initialize(mapload)
	. = ..()
	if(!greyscale_colors)
		// Generate a random valid lizard color for our plushie friend
		var/generated_lizard_color = "#" + random_color()
		var/list/lizard_hsv = rgb2hsv(generated_lizard_color)

		// If our color is too dark, use the classic green lizard plush color
		if(lizard_hsv[3] < 50)
			generated_lizard_color = "#66ff33"

		// Set our greyscale colors to the lizard color we made + black eyes
		set_greyscale(colors = list(generated_lizard_color, COLOR_BLACK))

// Preset lizard plushie that uses the original lizard plush green. (Or close to it)
/obj/item/toy/plush/lizard_plushie/green
	desc = "一个可爱的填充玩具，外形酷似绿色的蜥蜴人。这一只会让你充满怀旧与灵魂。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/toy/plush/lizard_plushie/green"
	post_init_icon_state = "map_plushie_lizard"
	greyscale_colors = "#66ff33#000000"

/obj/item/toy/plush/lizard_plushie/greyscale
	desc = "一个可爱的填充玩具，外形酷似蜥蜴人。这只是定制款。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/toy/plush/lizard_plushie/greyscale"
	post_init_icon_state = "map_plushie_lizard"
	greyscale_colors = "#d3d3d3#000000"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/toy/plush/lizard_plushie/space
	name = "太空蜥蜴人毛绒玩具"
	desc = "一个可爱的填充玩具，外形酷似一只意志坚定的太空蜥蜴人。飞向无限，超越一切，小家伙。"
	icon_state = "map_plushie_spacelizard"
	greyscale_config = /datum/greyscale_config/plush_spacelizard
	// space lizards can't hit people with their tail, it's stuck in their suit
	attack_verb_continuous = list("抓着", "嘶嘶叫着", "轻敲着")
	attack_verb_simple = list("抓", "嘶嘶叫", "轻敲")

/obj/item/toy/plush/lizard_plushie/space/green
	desc = "一个可爱的填充玩具，外形酷似一只意志坚定的绿色太空蜥蜴人。飞向无限，超越一切，小家伙。这一只会让你充满怀旧与灵魂。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/toy/plush/lizard_plushie/space/green"
	post_init_icon_state = "map_plushie_spacelizard"
	greyscale_colors = "#66ff33#000000"

/obj/item/toy/plush/snakeplushie
	name = "蛇毛绒玩具"
	desc = "一个可爱的填充玩具，外形酷似蛇。请勿与真蛇混淆。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/toy/plush/snakeplushie"
	post_init_icon_state = "map_plushie_snake"
	greyscale_config = /datum/greyscale_config/plush_snake
	greyscale_colors = "#99ff99#000000"
	inhand_icon_state = null
	attack_verb_continuous = list("咬着", "嘶嘶叫着", "尾巴拍着")
	attack_verb_simple = list("咬", "嘶嘶叫", "尾巴拍")
	squeak_override = list('sound/items/weapons/bite.ogg' = 1)

/obj/item/toy/plush/nukeplushie
	name = "特工毛绒玩具"
	desc = "一个填充玩具，外形酷似辛迪加核爆特工。标签上声称特工纯属虚构。"
	icon_state = "plushie_nuke"
	inhand_icon_state = null
	attack_verb_continuous = list("射击着", "核爆着", "引爆着")
	attack_verb_simple = list("射击", "核爆", "引爆")
	squeak_override = list('sound/effects/hit_punch.ogg' = 1)

/obj/item/toy/plush/plasmamanplushie
	name = "等离子人毛绒玩具"
	desc = "一个填充玩具，外形酷似你的紫色同事。嗯，没错，以等离子人的真实作风，尽管设计师竭尽全力，它也一点都不好看。"
	icon_state = "plushie_pman"
	inhand_icon_state = null
	attack_verb_continuous = list("灼烧着", "喷火着", "呼呼作响")
	attack_verb_simple = list("灼烧", "喷火", "呼呼作响")
	squeak_override = list('sound/effects/extinguish.ogg' = 1)

/obj/item/toy/plush/slimeplushie
	name = "史莱姆毛绒玩具"
	desc = "一个可爱的填充玩具，外形酷似史莱姆。它基本上就是个沙包。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/toy/plush/slimeplushie"
	post_init_icon_state = "map_plushie_slime"
	greyscale_config = /datum/greyscale_config/plush_slime
	greyscale_colors = "#aaaaff#000000"
	inhand_icon_state = null
	attack_verb_continuous = list("咕噜起着", "黏附着", "吸收着")
	attack_verb_simple = list("咕噜", "黏附", "吸收")
	squeak_override = list('sound/effects/blob/blobattack.ogg' = 1)
	gender = FEMALE //given all the jokes and drawings, I'm not sure the xenobiologists would make a slimeboy

// This is supposed to be only in the bus ruin, don't spawn it elsewhere
/obj/item/toy/plush/awakenedplushie
	name = "觉醒毛绒玩具"
	desc = "一个古老的毛绒玩具，已经领悟了现实的真正本质。"
	icon_state = "plushie_awake"
	inhand_icon_state = null

/obj/item/toy/plush/awakenedplushie/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/edit_complainer)

/obj/item/toy/plush/whiny_plushie
	name = "爱哭毛绒玩具"
	desc = "一个古老的毛绒玩具，在被遗忘太久之后，渴求着持续的陪伴。"
	icon_state = "plushie_whiny"
	inhand_icon_state = null
	/// static list of cry messages it picks from to speak when it is insecure from no movement
	var/static/list/cry_still_messages
	/// static list of cry messages it picks from to speak when it is insecure from no holder
	var/static/list/cry_alone_messages
	/// cooldown for it sending messages, it will every 10 seconds
	COOLDOWN_DECLARE(cry_cooldown)

/obj/item/toy/plush/whiny_plushie/Initialize(mapload)
	. = ..()
	if(!cry_still_messages)
		cry_still_messages = list(
			"我们为什么停下了？！你要丢下我吗？！",
			"我们会遭到袭击的，我们成了活靶子，动啊动啊啊啊啊！！",
			"你打算把我丢下对不对，我知道你就是这么想的啊啊啊啊！！",
			"辛迪加正在定位我们的位置啊啊啊啊啊啊！！",
			"这地方好可怕，我想离开离开离开啊啊啊！！",
			"救命，救命，救救救救救救我我我我我！！",
		)
		cry_alone_messages = list(
			"不——不要丢下我啊啊啊！！",
			"呜，大家都去哪了啊啊啊啊，哇啊！！",
			"谁来，随便谁都好，把我捡起来啊！！",
			"我不该遭这种罪啊啊啊！！",
			"一次攻击就能要了我的命啊啊啊啊！！",
			"我绝对不会掉落好东西的啊啊啊啊！！",
		)
	AddComponent(/datum/component/keep_me_secure, CALLBACK(src, PROC_REF(secured_process)) , CALLBACK(src, PROC_REF(unsecured_process)), 0)

/obj/item/toy/plush/whiny_plushie/proc/secured_process(last_move)
	icon_state = initial(icon_state)

/obj/item/toy/plush/whiny_plushie/proc/unsecured_process(last_move)
	if(!COOLDOWN_FINISHED(src, cry_cooldown))
		return
	COOLDOWN_START(src, cry_cooldown, 10 SECONDS)
	icon_state = "plushie_whiny_crying"
	if(isturf(loc))
		say(pick(cry_alone_messages))
	else
		say(pick(cry_still_messages))
	playsound(src, 'sound/items/intents/Help.ogg', 50, FALSE)

/obj/item/toy/plush/beeplushie
	name = "蜜蜂毛绒玩具"
	desc = "一个可爱的玩具，外形酷似一只更可爱的蜜蜂。"
	icon_state = "plushie_h"
	inhand_icon_state = null
	attack_verb_continuous = list("蜇着")
	attack_verb_simple = list("蜇")
	gender = FEMALE
	squeak_override = list('sound/mobs/humanoids/moth/scream_moth.ogg'=1)

/obj/item/toy/plush/moth
	name = "蛾人毛绒玩具"
	desc = "一个描绘可爱蛾人的毛绒玩具。是个可以抱的虫子！"
	icon_state = "moffplush"
	inhand_icon_state = null
	attack_verb_continuous = list("扑扇着翅膀", "拍打着")
	attack_verb_simple = list("扑扇翅膀", "拍打")
	squeak_override = list('sound/mobs/humanoids/moth/scream_moth.ogg'=1)
///Used to track how many people killed themselves with item/toy/plush/moth
	var/suicide_count = 0

/obj/item/toy/plush/moth/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]深深凝视着[src]的双眼，而它开始吞噬[user]！看起来是想自杀！"))
	suicide_count++
	if(suicide_count < 3)
		desc = "一个描绘令人不安的蛾人的毛绒玩具。在杀死 [suicide_count] [suicide_count == 1 ? "个人" : "个人"]之后，它看起来已经不那么适合拥抱了……"
	else
		desc = "一个描绘诡异蛾人的毛绒玩具。它已经杀了 [suicide_count] 个人！我觉得我不想再抱它了！"
		divine = TRUE
		resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	playsound(src, 'sound/effects/hallucinations/wail.ogg', 50, TRUE, -1)
	var/list/available_spots = get_adjacent_open_turfs(loc)
	if(available_spots.len) //If the user is in a confined space the plushie will drop normally as the user dies, but in the open the plush is placed one tile away from the user to prevent squeak spam
		var/turf/open/random_open_spot = pick(available_spots)
		forceMove(random_open_spot)
	user.dust(just_ash = FALSE, drop_items = TRUE)
	return MANUAL_SUICIDE

/obj/item/toy/plush/pkplush
	name = "维和毛绒玩具"
	desc = "一个描绘维和半机械人的毛绒玩具。只有你才能阻止人类受到伤害！"
	icon_state = "pkplush"
	attack_verb_continuous = list("拥抱着", "挤压着")
	attack_verb_simple = list("拥抱", "挤压")
	squeak_override = list('sound/items/weapons/thudswoosh.ogg'=1)

/obj/item/toy/plush/rouny
	name = "奔跑者毛绒玩具"
	desc = "一个描绘异形奔跑者的毛绒玩具，为纪念 LV-426 战役一百周年而制。比真货好抱多了。"
	icon_state = "rouny"
	inhand_icon_state = null
	attack_verb_continuous = list("挥砍着", "撕咬着", "冲锋着")
	attack_verb_simple = list("挥砍", "撕咬", "冲锋")
	squeak_override = list('sound/items/intents/Help.ogg' = 1)

/obj/item/toy/plush/abductor
	name = "绑架者毛绒玩具"
	desc = "一个描绘外星绑架者的毛绒玩具。上面的标签写着无法解读的语言。"
	icon_state = "abductor"
	inhand_icon_state = null
	attack_verb_continuous = list("绑架着", "探查着")
	attack_verb_continuous = list("绑架", "探查")
	squeak_override = list('sound/ambience/weather/ashstorm/inside/weak_end.ogg' = 1) //very faint sound since abductors are silent as far as "speaking" is concerned.

/obj/item/toy/plush/abductor/agent
	name = "绑架者特工毛绒玩具"
	desc = "一个描绘外星绑架者特工的毛绒玩具。电击棍固定在毛绒玩具手上，看起来已失去作用。我可不想和它独处。"
	icon_state = "abductor_agent"
	inhand_icon_state = null
	attack_verb_continuous = list("绑架着", "探查着", "电击着")
	attack_verb_continuous = list("绑架", "探查", "电击")
	squeak_override = list(
		'sound/items/weapons/egloves.ogg' = 2,
		'sound/items/weapons/cablecuff.ogg' = 1,
	)

/obj/item/toy/plush/shark
	name = "鲨鱼毛绒玩具"
	desc = "一个描绘卡通化鲨鱼的毛绒玩具。标签上称它为“hákarl”，并注明它由旧斯堪的纳维亚一家默默无闻的家具制造商生产。"
	lefthand_file = 'icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/plushes_righthand.dmi'
	icon_state = "blahaj"
	inhand_icon_state = "blahaj"
	attack_verb_continuous = list("啃咬着", "磨着牙", "咀嚼着")
	attack_verb_simple = list("啃咬", "磨牙", "咀嚼")

/obj/item/toy/plush/donkpocket
	name = "咚克口袋毛绒玩具"
	desc = "经验丰富的叛徒首选的填充玩伴。"
	icon_state = "donkpocket"
	attack_verb_continuous = list("咚克着")
	attack_verb_simple = list("咚克")

/obj/item/toy/plush/human
	name = "人类毛绒玩具"
	desc = "这是一个人类毛毡毛绒玩具。所有工艺均为最低品质。这个人类在哭泣。这个人类在尖叫。"
	icon_state = "plushie_human"
	inhand_icon_state = null //i would rather not have a blue coder plushie inhand
	attack_verb_continuous = list("尖叫着", "击打着", "猛砸着")
	attack_verb_simple = list("尖叫", "击打", "猛砸")
	squeak_override = list(
		'sound/mobs/humanoids/human/scream/malescream_2.ogg' = 10, //10% chance to scream, rare but not abysmal
		'sound/items/weapons/smash.ogg' = 90,
		)

/obj/item/toy/plush/horse
	name = "马毛绒玩具"
	desc = "一个柔软有弹性的马毛绒玩具。这一匹是骝色，脚上有白袜。"
	icon_state = "horse"
	attack_verb_continuous = list("嘶鸣着", "奔驰着", "腾跃着", "撒欢着")  // Yes I'm using horse as a verb
	attack_verb_simple = list("嘶鸣", "奔驰", "腾跃", "撒欢")

/obj/item/toy/plush/unicorn
	name = "独角兽毛绒玩具"
	desc = "一个柔软有弹性的独角兽毛绒玩具。它散发着魔法气息。"
	icon_state = "unicorn"
	attack_verb_continuous = list("嘶鸣着", "奔驰着", "腾跃着", "施着魔法")
	attack_verb_simple = list("嘶鸣", "奔驰", "腾跃", "施法")

/obj/item/toy/plush/monkey
	name = "猴子毛绒玩具"
	desc = "标签上写着：“呜呼吱！我是一只黑猩猩！”，背面还印着“现在推出巨无霸尺寸！”。"
	w_class = WEIGHT_CLASS_BULKY
	throw_range = 2
	throw_speed = 1
	icon_state = "monkey"
	inhand_icon_state = null
	attack_verb_continuous = list("呜呼着", "吱吱着")
	attack_verb_simple = list("呜呼", "吱吱")
	squeak_override = list(SFX_SCREECH=1)
	/// if the monkey ate a mimana and has changed nationality
	var/french = FALSE

/obj/item/toy/plush/monkey/item_interaction(mob/living/feeder, obj/item/food/grown/banana/nana, list/modifiers)
	if(!istype(nana))
		return ..()
	nana.forceMove(src) // go into the cotton stomach
	to_chat(feeder, span_notice("你把[nana]递给[src]，看着它吃起来……"))
	playsound(src, 'sound/items/eatfood.ogg', 75, TRUE)
	addtimer(CALLBACK(src, PROC_REF(eat), feeder, nana), 3 SECONDS)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/plush/monkey/proc/eat(mob/living/feeder, obj/item/food/grown/banana/nana)
	if(istype(nana, /obj/item/food/grown/banana/bluespace))
		do_teleport(src, get_turf(src), 15, channel = TELEPORT_CHANNEL_BLUESPACE)
	else if(istype(nana, /obj/item/food/grown/banana/mime) && !french)
		name = "法语猴子毛绒玩具"
		desc = "标签上用法语写着：“Oop eek! Je suis un chimpanzé!”，背面印着“Maintenant en TAILLE JUMBO!”。"
		french = TRUE
	// throw the peel at a random mob, or a random turf if there are none
	var/obj/item/grown/bananapeel/peel = new nana.trash_type(get_turf(src))
	var/list/oviewers = oviewers(peel.throw_range, src)
	var/throw_src = src
	// if a player holds the plushie, the throw source will be the player
	if(isliving(loc))
		oviewers = oviewers(loc)
		throw_src = loc
	if(oviewers.len > 0 && (locate(feeder) in oviewers))
		oviewers -= feeder // remove feeder from targetables
	peel.throw_at(oviewers.len == 0 ? get_ranged_target_turf(throw_src, pick(GLOB.alldirs), peel.throw_range) : pick(oviewers), peel.throw_range, peel.throw_speed, quickstart = FALSE)
	playsound(src, 'sound/mobs/non-humanoids/gorilla/gorilla.ogg', 100, FALSE)
	spasm_animation(5 SECONDS)
	qdel(nana)
