// .35 Sol pistol

/obj/item/gun/ballistic/automatic/pistol/sol
	name = "\improper 黄蜂手枪"
	desc = "地球政府各军种的制式军用手枪。使用.35太阳弹，并配有枪灯。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/guns32x.dmi'
	icon_state = "wespe"

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/pistol_light.ogg'

	w_class = WEIGHT_CLASS_NORMAL

	accepted_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol
	special_mags = TRUE

	suppressor_x_offset = 7
	suppressor_y_offset = 0

	fire_delay = 0.3 SECONDS

/obj/item/gun/ballistic/automatic/pistol/sol/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_TRAPPISTE)

/obj/item/gun/ballistic/automatic/pistol/sol/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		)

/obj/item/gun/ballistic/automatic/pistol/sol/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/automatic/pistol/sol/examine_more(mob/user)
	. = ..()

	. += "黄蜂是一款完全为军事用途打造的手枪。\
		它被要求使用制式弹药和标准弹匣，\
		并能在地球政府通常行动的各种\
		环境中工作。这些特性恰好使这件武器\
		在边疆星域很受欢迎，也可能正是\
		你此刻能看到它的原因。"

	return .

/obj/item/gun/ballistic/automatic/pistol/sol/no_mag
	spawnwithmagazine = FALSE

// Sol pistol evil gun

/obj/item/gun/ballistic/automatic/pistol/sol/evil
	desc = "地球政府各军种的制式军用手枪，配有枪灯。这把涂上了耍酷用的战术黑。"

	icon_state = "wespe_evil"

/obj/item/gun/ballistic/automatic/pistol/sol/evil/no_mag
	spawnwithmagazine = FALSE

// Trappiste high caliber pistol in .585

/obj/item/gun/ballistic/automatic/pistol/trappiste
	name = "\improper 盾牌手枪"
	desc = "一款较为罕见的特拉比斯特手枪，发射该公司研制的.585大口径弹药。\
		它不常见的主要原因是容易让手腕严重不适。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/guns32x.dmi'
	icon_state = "skild"

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/pistol_heavy.ogg'
	suppressed_sound = 'modular_skyrat/modules/modular_weapons/sounds/suppressed_heavy.ogg'

	w_class = WEIGHT_CLASS_NORMAL

	accepted_magazine_type = /obj/item/ammo_box/magazine/c585trappiste_pistol

	suppressor_x_offset = 8
	suppressor_y_offset = 0

	fire_delay = 1 SECONDS

	recoil = 3

/obj/item/gun/ballistic/automatic/pistol/trappiste/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_TRAPPISTE)

/obj/item/gun/ballistic/automatic/pistol/sol/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/automatic/pistol/trappiste/examine_more(mob/user)
	. = ..()

	. += "盾牌的诞生源于一桩广为人知的事件，而地球政府军方\
		宁愿它没那么出名。一位至今姓名不详的将军\
		被录下抱怨黄蜂手枪不足以满足军方需求的言论，\
		还多次将黄蜂缺乏男子气概的表现与\
		原话所说的“那群NRI杂种特有的睾酮匮乏”相提并论。\
		虽然这位将军和录音泄露者的身份\
		至今仍属机密，但许多地球政府高级军官可疑地不再\
		公开露面，盾牌手枪却恰恰相反。最初生产的数千把\
		手枪相当高调地从特拉比斯特运往地球政府位于冥王星的\
		航运枢纽。地球政府军事司令部至今仍拒绝\
		回答任何有关此事的进一步问题。"

	return .

/obj/item/gun/ballistic/automatic/pistol/trappiste/no_mag
	spawnwithmagazine = FALSE
