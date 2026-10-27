// Szot Dynamica's officer revolver, built on the Bobr frame and priced accordingly

/obj/item/ammo_box/magazine/internal/cylinder/aniolek
	name = "\improper .310 左轮弹巢"
	ammo_type = /obj/item/ammo_casing/strilka310
	caliber = CALIBER_STRILKA310
	max_ammo = 5

/obj/item/gun/ballistic/revolver/aniolek
	resistance_flags = INDESTRUCTIBLE
	name = "\improper 小天使 .310 左轮手枪"
	desc = "一把五发左轮手枪，发射 .310 飞箭弹，与海狸共用同样宽大的枪身框架。\
		它昂贵、紧凑、做工精良得出奇，最常见的持有者是获勋的军官、\
		国家问题处理专员，以及其他那些把“拒绝退让”视为优点、\
		而非纪律问题的人。"
	icon = 'modular_zubbers/icons/obj/szot_aniolek.dmi'
	icon_state = "aniolek"
	greyscale_config = /datum/greyscale_config/szot_dynamica_32
	greyscale_colors = "#83825E#CD445B"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/aniolek
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	fire_delay = 0.7 DECISECONDS
	projectile_damage_multiplier = 0.55 // 33 a shot
	recoil = 1
	spread = 6
	weapon_weight = WEAPON_MEDIUM

/obj/item/gun/ballistic/revolver/aniolek/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	AddElement(/datum/element/gun_launches_little_guys, 2, 3)

/obj/item/gun/ballistic/revolver/aniolek/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/revolver/aniolek/examine(mob/user)
	. = ..()
	. += span_notice("你可以[EXAMINE_HINT("仔细观察")]来进一步了解 [src]。")

/obj/item/gun/ballistic/revolver/aniolek/examine_more(mob/user)
	. = ..()

	. += "“小天使”最初是海狸的私人订制改良版，由一群军官委托打造，\
		他们欣赏这把霰弹左轮手枪的耐用与可靠，却希望挂在礼服上的东西\
		不必那么粗笨。绍特动力公司缩短了弹巢，收紧了枪机，\
		并把成品改为发射 .310 飞箭弹。抽壳钩被有意留成亮色，\
		映衬在深色的弹巢上，围绕五个弹膛形成一圈浅淡的环。"

	. += "它从未被正式列为制式装备。“小天使”有被授予的、被购买的、被继承的，\
		偶尔也有被征用的——征用者往往军衔够高、名望够响，或者纯粹人格魅力够强，\
		以至于没人愿意追问到底是哪一种。它逐渐与这样一类军官联系在一起：\
		他们被期待守住阵线、平息争执，或者在所有更理智的人都已逃跑后继续执行任务。"

	. += "腰间别着一把“小天使”，逐渐成了某类军官的代名词：\
		当指挥部乱了阵脚时，他们仍被信任能保持清醒；当别人退缩时，他们坚守不退；\
		无论规章制度是否跟得上，他们都会让正确的事发生。"

	return .

// The QM's Lanca. Same rifle, deeper magazine, and a magazine you cannot buy.

/obj/item/ammo_box/magazine/lanca/extended
	name = "\improper 骑枪加长弹匣"
	desc = "一种为骑枪步枪设计的超长弹匣，可容纳八发子弹。军品商们发誓说这东西\
		在某个地方曾是制式装备，但从来不肯说是在哪儿。"
	icon = 'modular_zubbers/icons/obj/szot_extended_mag.dmi'
	icon_state = "lanca_mag_extended"
	base_icon_state = "lanca_mag_extended"
	max_ammo = 8
