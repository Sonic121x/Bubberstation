/obj/item/clothing/shoes/clown_shoes
	desc = "爱恶作剧者的标准配发小丑鞋。天呐，这也太大了！按住 Ctrl 点击可切换摇摆抑制器。"
	name = "小丑鞋"
	icon_state = "clown"
	inhand_icon_state = "clown_shoes"
	slowdown = SHOES_SLOWDOWN+1
	var/enabled_waddle = TRUE
	///List of possible sounds for the squeak component to use, allows for different clown shoe subtypes to have different sounds.
	var/list/squeak_sound = list('sound/effects/footstep/clownstep1.ogg'=1,'sound/effects/footstep/clownstep2.ogg'=1)
	lace_time = 20 SECONDS // how the hell do these laces even work??

/obj/item/clothing/shoes/clown_shoes/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/shoes/clown)
	LoadComponent(/datum/component/squeak, squeak_sound, 50, falloff_exponent = 20) //die off quick please
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CLOWN, CELL_VIRUS_TABLE_GENERIC, rand(2,3), 0)
	AddElement(/datum/element/adjust_fishing_difficulty, 3) //Goofy
	AddElement(/datum/element/ignites_matches)

// BUBBERSTATION EDIT
//WAS: //AddElement(/datum/element/swabable, CELL_LINE_TABLE_CLOWN, CELL_VIRUS_TABLE_GENERIC, rand(2,3), 0) //SKYRAT EDIT REMOVAL

/obj/item/clothing/shoes/clown_shoes/equipped(mob/living/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_FEET)
		if(enabled_waddle)
			user.AddElementTrait(TRAIT_WADDLING, SHOES_TRAIT, /datum/element/waddling)
		if(is_clown_job(user.mind?.assigned_role))
			user.add_mood_event("clownshoes", /datum/mood_event/clownshoes)

/obj/item/clothing/shoes/clown_shoes/dropped(mob/living/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_WADDLING, SHOES_TRAIT)
	if(is_clown_job(user.mind?.assigned_role))
		user.clear_mood_event("clownshoes")

/obj/item/clothing/shoes/clown_shoes/item_ctrl_click(mob/user)
	if(!isliving(user))
		return CLICK_ACTION_BLOCKING
	if(user.get_active_held_item() != src)
		to_chat(user, span_warning("你必须把[src]拿在手上才能这么做！"))
		return CLICK_ACTION_BLOCKING
	if (!enabled_waddle)
		to_chat(user, span_notice("你关闭了摇摆抑制器！"))
		enabled_waddle = TRUE
	else
		to_chat(user, span_notice("你开启了摇摆抑制器！"))
		enabled_waddle = FALSE
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/shoes/clown_shoes/jester
	name = "弄臣鞋"
	desc = "宫廷弄臣的鞋子，配备了现代吱吱响技术。"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/clown_shoes/jester"
	post_init_icon_state = "jester_map"
	greyscale_config = /datum/greyscale_config/jester_shoes
	greyscale_config_worn = /datum/greyscale_config/jester_shoes/worn
	greyscale_colors = "#E10000#E1E100"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/clown_shoes/meown_shoes
	name = "喵喵鞋"
	desc = "它们在你行走时发出的可爱声音，会让你更容易交到朋友。"
	icon_state = "meown_shoes"
	squeak_sound = list('sound/effects/footstep/meowstep1.ogg'=1) //mew mew mew mew

/obj/item/clothing/shoes/clown_shoes/moffers
	name = "蛾蛾拖鞋"
	desc = "制作这双拖鞋时没有伤害任何飞蛾。"
	icon_state = "moffers"
	squeak_sound = list('sound/effects/footstep/moffstep01.ogg'=1) //like sweet music to my ears


//COMBAT CLOWN SHOES
//Clown shoes with combat stats and noslip. Of course they still squeak.
/obj/item/clothing/shoes/clown_shoes/combat
	name = "战斗小丑鞋"
	desc = "经过改良的小丑鞋，能保护穿戴者，并使其几乎不会在自己的香蕉皮上滑倒。它们还会以 100% 的功率吱吱作响。"
	clothing_traits = list(TRAIT_NO_SLIP_WATER)
	slowdown = SHOES_SLOWDOWN
	body_parts_covered = FEET|LEGS
	armor_type = /datum/armor/clown_shoes_combat
	strip_delay = 7 SECONDS
	resistance_flags = NONE

/datum/armor/clown_shoes_combat
	melee = 25
	bullet = 25
	laser = 25
	energy = 25
	bomb = 50
	bio = 90
	fire = 70
	acid = 50

/obj/item/clothing/shoes/clown_shoes/combat/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/shoes)

/// Recharging rate in PPS (peels per second)
#define BANANA_SHOES_RECHARGE_RATE 17
#define BANANA_SHOES_MAX_CHARGE 3000

//The super annoying version
/obj/item/clothing/shoes/clown_shoes/banana_shoes/combat
	name = "mk-honk 战斗鞋"
	desc = "多年小丑战斗研究的结晶，这双鞋所过之处留下一片混乱。它们会随时间缓慢自行充能，也可以用香蕉矿手动充能。"
	slowdown = SHOES_SLOWDOWN
	armor_type = /datum/armor/banana_shoes_combat
	strip_delay = 7 SECONDS
	resistance_flags = NONE
	always_noslip = TRUE
	body_parts_covered = FEET|LEGS

/datum/armor/banana_shoes_combat
	melee = 25
	bullet = 25
	laser = 25
	energy = 25
	bomb = 50
	bio = 50
	fire = 90
	acid = 50

/obj/item/clothing/shoes/clown_shoes/banana_shoes/combat/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/shoes)
	bananium.insert_amount_mat(BANANA_SHOES_MAX_CHARGE, /datum/material/bananium)

	START_PROCESSING(SSobj, src)

/obj/item/clothing/shoes/clown_shoes/banana_shoes/combat/process(seconds_per_tick)
	var/bananium_amount = bananium.get_material_amount(/datum/material/bananium)
	if(bananium_amount < BANANA_SHOES_MAX_CHARGE)
		bananium.insert_amount_mat(min(BANANA_SHOES_RECHARGE_RATE * seconds_per_tick, BANANA_SHOES_MAX_CHARGE - bananium_amount), /datum/material/bananium)

/obj/item/clothing/shoes/clown_shoes/banana_shoes/combat/attack_self(mob/user)
	ui_action_click(user)

#undef BANANA_SHOES_RECHARGE_RATE
#undef BANANA_SHOES_MAX_CHARGE
