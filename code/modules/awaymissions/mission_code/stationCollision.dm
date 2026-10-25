/* Station-Collision(sc) away mission map specific stuff
 *
 * Notes:
 * Feel free to use parts of this map, or even all of it for your own project. Just include me in the credits :)
 *
 * Some of this code unnecessary, but the intent is to add a little bit of everything to serve as examples
 * for anyone who wants to make their own stuff.
 *
 * Contains:
 * Landmarks
 * Guns
 * Safe code hints
 * Captain's safe
 * Modified Nar'Sie
 */



/*
 * Landmarks - Instead of spawning a new object type, I'll spawn the bible using a landmark!
 */
/obj/effect/landmark/sc_bible_spawner
	name = "保险箱密码提示生成器"

/obj/effect/landmark/sc_bible_spawner/Initialize(mapload)
	. = ..()
	var/obj/item/book/bible/holy_bible = new /obj/item/book/bible/booze(loc)
	holy_bible.name = "几何之神圣典"
	holy_bible.deity_name = "纳尔西"
	holy_bible.icon_state = "melted"
	holy_bible.inhand_icon_state = "melted"
	holy_bible.lefthand_file = 'icons/mob/inhands/items/books_lefthand.dmi'
	holy_bible.righthand_file = 'icons/mob/inhands/items/books_righthand.dmi'
	new /obj/item/paper/fluff/awaymissions/stationcollision/safehint_paper_bible(holy_bible)
	new /obj/item/pen(holy_bible)
	return INITIALIZE_HINT_QDEL

/*
 * Guns - I'm making these specifically so that I dont spawn a pile of fully loaded weapons on the map.
 */
//Captain's retro laser - Fires practice laser shots instead.
/obj/item/gun/energy/laser/retro/sc_retro
	name ="复古激光枪"
	icon_state = "retro"
	desc = "一款较老型号的基础激光枪，纳米传讯的安保与军事部队已不再使用。"
	clumsy_check = FALSE //No sense in having a harmless gun blow up in the clowns face

//Syndicate sub-machine guns.
/obj/item/gun/ballistic/automatic/c20r/sc_c20r

/obj/item/gun/ballistic/automatic/c20r/sc_c20r/Initialize(mapload)
	. = ..()
	for(var/ammo in magazine.stored_ammo)
		if(prob(95)) //95% chance
			magazine.stored_ammo -= ammo

//Barman's shotgun
/obj/item/gun/ballistic/shotgun/sc_pump

/obj/item/gun/ballistic/shotgun/sc_pump/Initialize(mapload)
	. = ..()
	for(var/ammo in magazine.stored_ammo)
		if(prob(95)) //95% chance
			magazine.stored_ammo -= ammo

//Lasers
/obj/item/gun/energy/laser/practice/sc_laser
	name = "旧激光枪"
	desc = "曾经威力强大的武器，多年的灰尘积满了枪膛和镜片，使光束显著减弱。"
	clumsy_check = FALSE

/*
 * Safe code hints
 */

//These vars hold the code itself, they'll be generated at round-start
GLOBAL_VAR_INIT(sc_safecode1, "[rand(0,9)]")
GLOBAL_VAR_INIT(sc_safecode2, "[rand(0,9)]")
GLOBAL_VAR_INIT(sc_safecode3, "[rand(0,9)]")
GLOBAL_VAR_INIT(sc_safecode4, "[rand(0,9)]")
GLOBAL_VAR_INIT(sc_safecode5, "[rand(0,9)]")

//Pieces of paper actually containing the hints
/obj/item/paper/fluff/awaymissions/stationcollision/safehint_paper_prison
	name = "涂抹的纸张"

/obj/item/paper/fluff/awaymissions/stationcollision/safehint_paper_prison/Initialize(mapload)
	default_raw_text = "<i>墨迹已被涂抹，你只能勉强辨认出几个数字：</i> '[GLOB.sc_safecode1]**[GLOB.sc_safecode4]*'"
	return ..()

/obj/item/paper/fluff/awaymissions/stationcollision/safehint_paper_hydro
	name = "撕碎的纸张"

/obj/item/paper/fluff/awaymissions/stationcollision/safehint_paper_hydro/Initialize(mapload)
	default_raw_text = "<i>尽管纸张已被撕碎，你仍能清楚地看到一个数字：</i> '[GLOB.sc_safecode2]'"
	return ..()

/obj/item/paper/fluff/awaymissions/stationcollision/safehint_paper_caf
	name = "浸血的纸张"
	//This does not have to be in New() because it is a constant. There are no variables in it i.e. [sc_safcode]
	default_raw_text = "<font color=red><i>这张纸浸透了鲜血，无法阅读上面的任何文字。</i></font>"

/obj/item/paper/fluff/awaymissions/stationcollision/safehint_paper_bible
	name = "藏起来的纸张"

/obj/item/paper/fluff/awaymissions/stationcollision/safehint_paper_bible/Initialize(mapload)
	default_raw_text = {"<i>看来和纸张一起藏起来的笔把墨水漏到了纸上。
			不过你还能辨认出最后三位数字：</i>'[GLOB.sc_safecode3][GLOB.sc_safecode4][GLOB.sc_safecode5]'
			"}
	return ..()

/obj/item/paper/fluff/awaymissions/stationcollision/safehint_paper_shuttle
	default_raw_text = {"<b>目标：</b>埃普西隆研究站<br>
			<b>任务目标：</b>原型武器。舰长很可能把它们锁在自己的保险箱里。<br>
			<br>
			我们随船的间谍已经掌握了密码，并把几份密码抄本藏在了空间站各处。不幸的是，他被安保人员抓住了。
			你的任务是分头行动，找到任何写有舰长保险箱密码的纸张，打开保险箱并
			取走里面的一切。如果可能，救出被关押的辛迪加特工，并从他那里得到密码。<br>
			<br>
			<u>一如既往，消灭任何挡路的人。</u><br>
			<br>
			分配给你的飞船专为以对特工最小的伤害穿透其他空间站或船舰的外壳而设计。
			它完全采用电传操纵，你只需享受旅程，当红灯亮起时……找点什么东西抓牢！
			"}

/*
 * Captain's safe
 */
/obj/structure/secure_safe/sc_ssafe
	name = "舰长专用保险箱"

/obj/structure/secure_safe/sc_ssafe/Initialize(mapload)
	. = ..()
	var/lock_code = "[GLOB.sc_safecode1][GLOB.sc_safecode2][GLOB.sc_safecode3][GLOB.sc_safecode4][GLOB.sc_safecode5]"
	AddComponent(/datum/component/lockable_storage, \
		lock_code = lock_code, \
		can_hack_open = FALSE, \
	)

/obj/structure/secure_safe/sc_ssafe/PopulateContents()
	. = ..()
	new /obj/item/gun/energy/mindflayer(src)
	new /obj/item/soulstone(src)
	new /obj/item/clothing/suit/hooded/cultrobes/hardened(src)
	new /obj/item/stack/ore/diamond(src)
