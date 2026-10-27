/obj/item/language_manual
	icon = 'icons/obj/service/library.dmi'
	icon_state = "book2"
	/// Number of charges the book has, limits the number of times it can be used.
	var/charges = 1
	/// Path to a language datum that the book teaches.
	var/datum/language/language = /datum/language/common
	/// Flavour text to display when the language is successfully learned.
	var/flavour_text = "你的脑海中突然充满了暗语与应答"

/obj/item/language_manual/attack_self(mob/living/user)
	if(!isliving(user))
		return

	if(user.has_language(language))
		to_chat(user, span_boldwarning("你开始翻阅 [src]，但你已经掌握 [initial(language.name)] 了。"))
		return

	to_chat(user, span_bolddanger("你开始翻阅 [src]，[flavour_text]。"))

	user.grant_language(language)
	user.remove_blocked_language(language, source=LANGUAGE_ALL)
	ADD_TRAIT(user.mind, TRAIT_TOWER_OF_BABEL, MAGIC_TRAIT) // this makes you immune to babel effects

	use_charge(user)

/obj/item/language_manual/attack(mob/living/M, mob/living/user)
	if(!istype(M) || !istype(user))
		return
	if(M == user)
		attack_self(user)
		return

	playsound(loc, SFX_PUNCH, 25, TRUE, -1)

	if(M.stat == DEAD)
		M.visible_message(span_danger("[user] 用 [src] 拍打 [M] 那毫无生气的尸体。"), span_userdanger("[user] 用 [src] 拍打你毫无生气的尸体。"), span_hear("你听到拍打声。"))
	else if(M.has_language(language))
		M.visible_message(span_danger("[user] 用 [src] 猛敲 [M] 的脑袋！"), span_userdanger("[user] 用 [src] 猛敲你的脑袋！"), span_hear("你听到拍打声。"))
	else
		M.visible_message(span_notice("[user] 用 [src] 敲打 [M] 的脑袋，把知识敲进了脑中！"), span_boldnotice("当 [user] 用 [src] 敲你时，[flavour_text]。"), span_hear("你听到拍打声。"))
		M.grant_language(language, source = LANGUAGE_MIND)
		use_charge(user)

/obj/item/language_manual/proc/use_charge(mob/user)
	charges--
	if(!charges)
		user.visible_message(span_notice("[user] 手中书本的封面开始变幻不定！它从手中滑落！"),
							span_warning("[src] 的封面与内文开始变幻不定！它从你手中滑落！"))
		new /obj/item/book/manual/random(get_turf(src))
		qdel(src)

/obj/item/language_manual/codespeak_manual
	name = "暗语手册"
	desc = "书封上写着：“暗语（tm）——用复杂到像是随机生成的隐喻来保障你的通讯安全！”"
	language = /datum/language/codespeak
	flavour_text = "你的脑海中突然充满了暗语与应答"

/obj/item/language_manual/codespeak_manual/unlimited
	name = "豪华版暗语手册"
	charges = INFINITY

/obj/item/language_manual/roundstart_species
	name = "回合初始种族语言手册"

/obj/item/language_manual/roundstart_species/Initialize(mapload)
	. = ..()
	if(!language) //if a language is already set, use it instead.
		var/list/available_languages = length(GLOB.uncommon_roundstart_languages) ? GLOB.uncommon_roundstart_languages : list(/datum/language/common)
		language = pick(available_languages)
	name = "[initial(language.name)] 手册"
	desc = "书封上写着：“[initial(language.name)] 异种族专用版——几秒钟学会银河通用语。”"
	flavour_text = "顿感自己已精通 [initial(language.name)]"

/obj/item/language_manual/roundstart_species/unlimited
	charges = INFINITY

/obj/item/language_manual/roundstart_species/unlimited/Initialize(mapload)
	. = ..()
	name = "豪华版 [initial(language.name)] 手册"

/obj/item/language_manual/roundstart_species/five
	charges = 5

/obj/item/language_manual/roundstart_species/five/Initialize(mapload)
	. = ..()
	name = "扩充版 [initial(language.name)] 手册"

/obj/item/language_manual/roundstart_species/draconic
	name = "龙语手册"

/obj/item/language_manual/piratespeak
	name = "\improper 皮特船长的海盗黑话指南"
	icon_state = "book_pirate"
	desc = "一本收录了所有知识、行话与流行词的书，让你说话像一位地道的老水手。"
	language = /datum/language/piratespeak
	flavour_text = "我的天！我觉得自己没那么像个旱鸭子了。"
	charges = 5

// So drones can teach borgs and AI dronespeak. For best effect, combine with mother drone lawset.
/obj/item/language_manual/dronespeak_manual
	name = "无人机语手册"
	desc = "书封上写着：“理解无人机语——一场徒劳的练习。”全书完全以二进制书写，非硅基单位大概看不懂。"
	language = /datum/language/drone
	flavour_text = "无人机那吱吱嘎嘎的声音突然变得能听懂了"
	charges = INFINITY

/obj/item/language_manual/dronespeak_manual/attack(mob/living/M, mob/living/user)
	// If they are not drone or silicon, we don't want them to learn this language.
	if(!(isdrone(M) || issilicon(M)))
		M.visible_message(span_danger("[user] 用 [src] 猛敲 [M] 的脑袋！"), span_userdanger("[user] 用 [src] 猛敲你的脑袋！"), span_hear("你听到拍打声。"))
		return

	return ..()

/obj/item/language_manual/dronespeak_manual/attack_self(mob/living/user)
	if(!(isdrone(user) || issilicon(user)))
		to_chat(user, span_danger("你用 [src] 猛敲自己的脑袋！"))
		return

	return ..()
