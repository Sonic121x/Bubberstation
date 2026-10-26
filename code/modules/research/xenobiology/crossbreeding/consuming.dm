/*
Consuming extracts:
	Can eat food items.
	After consuming enough, produces special cookies.
*/
/obj/item/slimecross/consuming
	name = "吞食提取物"
	desc = "它渴望着……<i>更多</i>。" //My slimecross has finally decided to eat... my buffet!
	icon_state = "consuming"
	effect = "consuming"
	var/nutriment_eaten = 0
	var/nutriment_required = 10
	var/cooldown = 600 //1 minute.
	var/last_produced = 0
	var/cookies = 5 //Number of cookies to spawn
	var/cookietype = /obj/item/slime_cookie

/obj/item/slimecross/consuming/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!IS_EDIBLE(tool))
		return NONE

	if(last_produced + cooldown > world.time)
		to_chat(user, span_warning("[src] 还在消化上一顿呢！"))
		return ITEM_INTERACT_BLOCKING

	var/datum/reagent/nutriments = tool.reagents.has_reagent(/datum/reagent/consumable/nutriment)
	if(!nutriments)
		to_chat(user, span_warning("[src] 对着这份供品不满地咕噜作响。"))
		return ITEM_INTERACT_BLOCKING

	nutriment_eaten += nutriments.volume
	to_chat(user, span_notice("[src] 张开口，把 [tool] 整个吞了下去！"))
	qdel(tool)
	playsound(src, 'sound/items/eatfood.ogg', 20, TRUE)

	if(nutriment_eaten < nutriment_required)
		return ITEM_INTERACT_SUCCESS

	nutriment_eaten = 0
	user.visible_message(span_notice("[src] 鼓胀起来，产出一小堆饼干！"))
	playsound(src, 'sound/effects/splat.ogg', 40, TRUE)
	last_produced = world.time
	for(var/i in 1 to cookies)
		var/obj/item/cookie = spawncookie()
		cookie.pixel_x = base_pixel_x + rand(-5, 5)
		cookie.pixel_y = base_pixel_y + rand(-5, 5)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimecross/consuming/proc/spawncookie()
	return new cookietype(get_turf(src))

/obj/item/slime_cookie //While this technically acts like food, it's so removed from it that I made it its own type.
	name = "错误饼干"
	desc = "一块奇怪的史莱姆饼干。你不该看到这个。"
	icon = 'icons/obj/food/slimecookies.dmi'
	var/taste = "错误"
	var/nutrition = 5
	icon_state = "base"
	force = 0
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 6

/obj/item/slime_cookie/proc/do_effect(mob/living/M, mob/user)
	return

/obj/item/slime_cookie/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	var/mob/living/living_mob = interacting_with
	var/fed = FALSE
	if(living_mob == user)
		living_mob.visible_message(span_notice("[user] 吃掉了 [src]！"), span_notice("你吃掉了 [src]。"))
		fed = TRUE
	else
		living_mob.visible_message(span_danger("[user] 试图强迫 [living_mob] 吃下 [src]！"), span_userdanger("[user] 试图强迫你吃下 [src]！"))
		if(do_after(user, 2 SECONDS, target = living_mob))
			fed = TRUE
			living_mob.visible_message(span_danger("[user] 强迫 [living_mob] 吃下了 [src]！"), span_warning("[user] 强迫你吃下 [src]。"))
	if(fed)
		if(!HAS_TRAIT(living_mob, TRAIT_AGEUSIA))
			to_chat(living_mob, span_notice("你能尝出 [taste] 的味道。"))
		playsound(get_turf(living_mob), 'sound/items/eatfood.ogg', 20, TRUE)
		if(nutrition)
			living_mob.reagents.add_reagent(/datum/reagent/consumable/nutriment, nutrition)
		do_effect(living_mob, user)
		qdel(src)
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/item/slimecross/consuming/grey
	colour = SLIME_TYPE_GREY
	effect_desc = "创造一块史莱姆饼干。"
	cookietype = /obj/item/slime_cookie/grey

/obj/item/slime_cookie/grey
	name = "史莱姆饼干"
	desc = "一块偏灰色透明的饼干。大概很有营养。"
	icon_state = "grey"
	taste = "黏液"
	nutrition = 15

/obj/item/slimecross/consuming/orange
	colour = SLIME_TYPE_ORANGE
	effect_desc = "创造一块史莱姆饼干，能升高目标体温，并在短时间内免疫寒冷。"
	cookietype = /obj/item/slime_cookie/orange

/obj/item/slime_cookie/orange
	name = "火焰饼干"
	desc = "一块带火焰花纹的橙色饼干。摸起来暖暖的。"
	icon_state = "orange"
	taste = "肉桂与灼烧"

/obj/item/slime_cookie/orange/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/firecookie)

/obj/item/slimecross/consuming/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "创造一块史莱姆饼干，能治愈目标所有类型的伤害。"
	cookietype = /obj/item/slime_cookie/purple

/obj/item/slime_cookie/purple
	name = "健康饼干"
	desc = "一块带十字花纹的紫色饼干。令人安心。"
	icon_state = "purple"
	taste = "果酱与止咳药水"

/obj/item/slime_cookie/purple/do_effect(mob/living/M, mob/user)
	var/need_mob_update = FALSE
	need_mob_update += M.adjust_brute_loss(-5, updating_health = FALSE)
	need_mob_update += M.adjust_fire_loss(-5, updating_health = FALSE)
	need_mob_update += M.adjust_tox_loss(-5, updating_health = FALSE, forced = TRUE) //To heal slimepeople.
	need_mob_update += M.adjust_oxy_loss(-5, updating_health = FALSE)
	need_mob_update += M.adjust_organ_loss(ORGAN_SLOT_BRAIN, -5)
	if(need_mob_update)
		M.updatehealth()

/obj/item/slimecross/consuming/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "创造一块史莱姆饼干，会弄湿你周围的地面，并在短时间内让你不会因水而滑倒。"
	cookietype = /obj/item/slime_cookie/blue

/obj/item/slime_cookie/blue
	name = "清水饼干"
	desc = "一块透明的蓝色饼干。一直在滴水。"
	icon_state = "blue"
	taste = "水"

/obj/item/slime_cookie/blue/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/watercookie)

/obj/item/slimecross/consuming/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "创造一块史莱姆饼干，能提升目标对钝击伤害的抗性。"
	cookietype = /obj/item/slime_cookie/metal

/obj/item/slime_cookie/metal
	name = "金属饼干"
	desc = "一块闪亮的灰色饼干。摸起来很硬。"
	icon_state = "metal"
	taste = "铜"

/obj/item/slime_cookie/metal/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/metalcookie)

/obj/item/slimecross/consuming/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "创造一块史莱姆饼干，能使目标在短时间内免疫电击。"
	cookietype = /obj/item/slime_cookie/yellow

/obj/item/slime_cookie/yellow
	name = "电花饼干"
	desc = "一块带闪电花纹的黄色饼干。口感像橡胶。"
	icon_state = "yellow"
	taste = "柠檬蛋糕与橡胶手套"

/obj/item/slime_cookie/yellow/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/sparkcookie)

/obj/item/slimecross/consuming/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "创造一块史莱姆饼干，能逆转目标身体对毒素的处理方式。"
	cookietype = /obj/item/slime_cookie/darkpurple

/obj/item/slime_cookie/darkpurple
	name = "毒素饼干"
	desc = "一块深紫色的饼干，散发着等离子体的臭味。"
	icon_state = "darkpurple"
	taste = "史莱姆凝胶与毒素"

/obj/item/slime_cookie/darkpurple/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/toxincookie)

/obj/item/slimecross/consuming/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "创造一块史莱姆饼干，会使目标变冷并熄灭其身上的火焰。"
	cookietype = /obj/item/slime_cookie/darkblue

/obj/item/slime_cookie/darkblue
	name = "霜寒饼干"
	desc = "一块带雪花花纹的深蓝色饼干。摸起来冰凉。"
	icon_state = "darkblue"
	taste = "薄荷与刺骨寒意"

/obj/item/slime_cookie/darkblue/do_effect(mob/living/M, mob/user)
	M.adjust_bodytemperature(-110)
	M.extinguish_mob()

/obj/item/slimecross/consuming/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "创造一块史莱姆饼干，吃它永远不会让目标发胖。"
	cookietype = /obj/item/slime_cookie/silver

/obj/item/slime_cookie/silver
	name = "行路面包饼干"
	desc = "一块温热酥脆的饼干，在光下泛出银色光泽。香气怡人。"
	icon_state = "silver"
	taste = "大师级的精灵烘焙"
	nutrition = 0 //We don't want normal nutriment

/obj/item/slime_cookie/silver/do_effect(mob/living/M, mob/user)
	M.reagents.add_reagent(/datum/reagent/consumable/nutriment/stabilized,10)

/obj/item/slimecross/consuming/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "创造一块史莱姆饼干，会把目标传送到该区域内的随机地点。"
	cookietype = /obj/item/slime_cookie/bluespace

/obj/item/slime_cookie/bluespace
	name = "太空饼干"
	desc = "一块覆着绿色糖霜的白色饼干。意外地很难拿稳。"
	icon_state = "bluespace"
	taste = "糖与星光"

/obj/item/slime_cookie/bluespace/do_effect(mob/living/eater, mob/user)
	var/list/area_turfs = get_area_turfs(get_area(get_turf(eater)))
	var/turf/target

	while (length(area_turfs))
		var/turf/check_turf = pick_n_take(area_turfs)
		if (is_centcom_level(check_turf.z))
			continue // Probably already filtered out by NOTELEPORT but let's just be careful
		if (check_turf.is_blocked_turf())
			continue
		target = check_turf
		break

	if (isnull(target))
		fail_effect(eater)
		return
	if (!do_teleport(eater, target, 0, asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE))
		fail_effect(eater)
		return
	new /obj/effect/particle_effect/sparks(target)
	playsound(target, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/obj/item/slime_cookie/bluespace/proc/fail_effect(mob/living/eater)
	eater.visible_message(
		message = span_warning("[eater] 短暂地消失了……随后重重地砸进地面"),
		self_message = span_warning("你短暂地消失了……随后被强行摔回地面。")
	)
	eater.Knockdown(0.1 SECONDS)
	new /obj/effect/particle_effect/sparks(get_turf(eater))

/obj/item/slimecross/consuming/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "创造一块史莱姆饼干，能让目标做事略快一些。"
	cookietype = /obj/item/slime_cookie/sepia

/obj/item/slime_cookie/sepia
	name = "时间饼干"
	desc = "一块带时钟花纹的浅棕色饼干。嚼起来要花点时间。"
	icon_state = "sepia"
	taste = "红糖与节拍器的味道"

/obj/item/slime_cookie/sepia/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/timecookie)

/obj/item/slimecross/consuming/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "创造一块史莱姆饼干，吃掉后有几率再生成一块。"
	cookietype = /obj/item/slime_cookie/cerulean
	cookies = 3 //You're gonna get more.

/obj/item/slime_cookie/cerulean
	name = "复制饼干"
	desc = "一块比例奇特的青色饼干。感觉很容易碎开。"
	icon_state = "cerulean"
	taste = "一块糖霜饼干"

/obj/item/slime_cookie/cerulean/do_effect(mob/living/M, mob/user)
	if(prob(50))
		to_chat(M, span_notice("你咀嚼时一小块 [src] 断裂脱落，掉在了地上。"))
		var/obj/item/slime_cookie/cerulean/C = new(get_turf(M))
		C.taste = taste + "和一块糖霜饼干"

/obj/item/slimecross/consuming/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "创造一块史莱姆饼干，会随机改变目标的颜色。"
	cookietype = /obj/item/slime_cookie/pyrite

/obj/item/slime_cookie/pyrite
	name = "彩色饼干"
	desc = "一块覆着彩虹色糖霜的黄色饼干。反光的样子很奇怪。"
	icon_state = "pyrite"
	taste = "香草和 " //Randomly selected color dye.
	var/colour = COLOR_WHITE

/obj/item/slime_cookie/pyrite/Initialize(mapload)
	. = ..()
	var/tastemessage = "除漆剂"
	switch(rand(1,7))
		if(1)
			tastemessage = "红色染料"
			colour = COLOR_RED
		if(2)
			tastemessage = "橙色染料"
			colour = "#FFA500"
		if(3)
			tastemessage = "黄色染料"
			colour = COLOR_YELLOW
		if(4)
			tastemessage = "绿色染料"
			colour = COLOR_VIBRANT_LIME
		if(5)
			tastemessage = "蓝色染料"
			colour = COLOR_BLUE
		if(6)
			tastemessage = "靛蓝染料"
			colour = "#4B0082"
		if(7)
			tastemessage = "紫色染料"
			colour = COLOR_MAGENTA
	taste += tastemessage

/obj/item/slime_cookie/pyrite/do_effect(mob/living/M, mob/user)
	M.add_atom_colour(colour,WASHABLE_COLOUR_PRIORITY)

/obj/item/slimecross/consuming/red
	colour = SLIME_TYPE_RED
	effect_desc = "创造一块史莱姆饼干，会在地面溅出鲜血，同时补充目标的部分血液。"
	cookietype = /obj/item/slime_cookie/red

/obj/item/slime_cookie/red
	name = "鲜血饼干"
	desc = "一块红色饼干，渗出浓稠的红色液体。吸血鬼也许会喜欢。"
	icon_state = "red"
	taste = "红丝绒与铁锈"

/obj/item/slime_cookie/red/do_effect(mob/living/M, mob/user)
	new /obj/effect/decal/cleanable/blood(get_turf(M))
	playsound(get_turf(M), 'sound/effects/splat.ogg', 10, TRUE)
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.adjust_blood_volume(25) //Half a vampire drain.

/obj/item/slimecross/consuming/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "创造一块史莱姆饼干，极其难吃，会让目标呕吐，但也会清除其体内的所有试剂。"
	cookietype = /obj/item/slime_cookie/green

/obj/item/slime_cookie/green
	name = "恶心饼干"
	desc = "一块令人作呕的绿色饼干，渗出脓液。光是看着就让人有点不适。"
	icon_state = "green"
	taste = "你胃里的东西"

/obj/item/slime_cookie/green/do_effect(mob/living/M, mob/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.vomit(VOMIT_CATEGORY_DEFAULT, lost_nutrition = 25)
	M.reagents.remove_all()

/obj/item/slimecross/consuming/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "创造一块史莱姆饼干，会让目标想去传播爱意。"
	cookietype = /obj/item/slime_cookie/pink

/obj/item/slime_cookie/pink
	name = "爱意饼干"
	desc = "一块带心形糖霜的粉色饼干。哎呀，真可爱。"
	icon_state = "pink"
	taste = "爱意与拥抱"

/obj/item/slime_cookie/pink/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/lovecookie)

/obj/item/slimecross/consuming/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "创造一块史莱姆饼干，里面有一枚金币。"
	cookietype = /obj/item/slime_cookie/gold

/obj/item/slime_cookie/gold
	name = "镀金饼干"
	desc = "一块黄油味浓郁的金色饼干，更像是面包。愿好运找到你。"
	icon_state = "gold"
	taste = "甜玉米面包与财富"

/obj/item/slime_cookie/gold/do_effect(mob/living/M, mob/user)
	var/obj/item/held = M.get_active_held_item() //This should be itself, but just in case...
	M.dropItemToGround(held)
	var/newcoin = /obj/item/coin/gold
	var/obj/item/coin/C = new newcoin(get_turf(M))
	playsound(get_turf(C), 'sound/items/coinflip.ogg', 50, TRUE)
	M.put_in_hand(C)

/obj/item/slimecross/consuming/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "创造一块史莱姆饼干，会减缓使用者身边所有人的速度。"
	cookietype = /obj/item/slime_cookie/oil

/obj/item/slime_cookie/oil
	name = "焦油饼干"
	desc = "一块油腻的黑色饼干，会粘在手上。闻起来像巧克力。"
	icon_state = "oil"
	taste = "浓郁熔化的巧克力与焦油"

/obj/item/slime_cookie/oil/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/tarcookie)

/obj/item/slimecross/consuming/black
	colour = SLIME_TYPE_BLACK
	effect_desc = "创造一块史莱姆饼干，会让目标在一小段时间里看起来像一具阴森的骷髅。"
	cookietype = /obj/item/slime_cookie/black

/obj/item/slime_cookie/black
	name = "阴森饼干"
	desc = "一块漆黑的饼干，正面画着糖霜幽灵。好阴森！"
	icon_state = "black"
	taste = "幽灵之类的东西"

/obj/item/slime_cookie/black/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/spookcookie)

/obj/item/slimecross/consuming/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "创造一块史莱姆饼干，会让目标以及其身边的人在一小段时间内无法攻击。"
	cookietype = /obj/item/slime_cookie/lightpink

/obj/item/slime_cookie/lightpink
	name = "和平饼干"
	desc = "一块糖霜上带有和平标志的浅粉色饼干。真美好！"
	icon_state = "lightpink"
	taste = "草莓糖霜与 P.L.U.R" //Literal candy raver.

/obj/item/slime_cookie/lightpink/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/peacecookie)

/obj/item/slimecross/consuming/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "创造一块史莱姆饼干，能提升目标对灼伤的抗性。"
	cookietype = /obj/item/slime_cookie/adamantine

/obj/item/slime_cookie/adamantine
	name = "水晶饼干"
	desc = "一块饼干形状的半透明冰糖。意外地很有嚼劲。"
	icon_state = "adamantine"
	taste = "结晶糖与金属"

/obj/item/slime_cookie/adamantine/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/adamantinecookie)

/obj/item/slimecross/consuming/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "创造一块史莱姆饼干，效果等同于随机一种饼干。"

/obj/item/slimecross/consuming/rainbow/spawncookie()
	var/cookie_type = pick(subtypesof(/obj/item/slime_cookie))
	var/obj/item/slime_cookie/S = new cookie_type(get_turf(src))
	S.name = "彩虹饼干"
	S.desc = "一块美丽的彩虹饼干，在光下不断变幻色彩。"
	S.icon_state = "rainbow"
	return S
