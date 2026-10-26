/obj/item/ammo_casing
	custom_materials = AMMO_MATS_BASIC

/obj/item/ammo_box
	/// When inserted into an ammo workbench, does this ammo box check for parent ammunition to search for subtypes of? Relevant for surplus clips, multi-sprite magazines.
	/// Maybe don't enable this for shotgun ammo boxes.
	var/multitype = TRUE


///GUN SPRITE OVERWRITES
/obj/item/gun/energy/ionrifle
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/energy.dmi'
	lefthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_righthand.dmi'

/obj/item/gun/energy/ionrifle/carbine
	icon = 'icons/obj/weapons/guns/energy.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'

/obj/item/gun/ballistic/shotgun/riot
	name = "伍德斯托克霰弹枪"
	desc = "一把结实的霰弹枪，配有加长弹仓和固定战术枪托，专为非致命防暴设计。常出现在熔岩地带猎人的手中。它隐约让你想起在太阳系狩猎的日子，不是吗？"
	fire_delay = 6 //We slighly bump this up because thats a good idea
	sawn_desc = "想活命就跟我走。"

/obj/item/gun/ballistic/shotgun/automatic/combat
	name = "\improper 维和者战斗霰弹枪"
	desc = "纳米传讯的半自动维和者霰弹枪，配有战术配件和更重型的内部结构，适合持续射击。没有螺纹枪管。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns48x.dmi'
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "shotgun_combat"
	inhand_x_dimension = 32
	inhand_y_dimension = 32

/obj/item/gun/ballistic/shotgun/automatic/combat/compact
	name = "\improper 维和者紧凑型战斗霰弹枪"
	desc = "维和者战斗霰弹枪的战术变体，供纳米传讯突袭队和太空陆战队使用。它装有陀螺稳定器，可以单手射击。"
	inhand_icon_state = "shotgun_combat_compact"
	weapon_weight = WEAPON_MEDIUM

/obj/item/gun/grenadelauncher
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'
	lefthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_righthand.dmi'

/obj/item/gun/ballistic/automatic/pistol/m1911
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'
	inhand_icon_state = "colt"
	lefthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_righthand.dmi'

/obj/item/gun/ballistic/automatic/c20r
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'

/obj/item/gun/ballistic/automatic/m90
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'
/obj/item/gun/ballistic/revolver/c38/detective
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'

/obj/item/gun/ballistic/automatic/pistol/aps
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'

/obj/item/gun/ballistic/automatic/pistol
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'

/obj/item/gun/ballistic/automatic/pistol/doorhickey
	icon = 'icons/obj/weapons/guns/ballistic.dmi'

/obj/item/gun/ballistic/automatic/pistol/deagle/regal
	icon = 'icons/obj/weapons/guns/ballistic.dmi'

/obj/item/gun/energy/e_gun/nuclear
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/nucgun.dmi'
	ammo_x_offset = 2
	lefthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_righthand.dmi'
	worn_icon_state = "gun"
	worn_icon = null

/obj/item/gun/energy/e_gun/nuclear/rainbow
	name = "奇妙能量枪"
	desc = "一种装有实验性微型核反应堆的能量枪，可自动为内部电池充电。这一把看起来相当花哨！"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/rainbow, /obj/item/ammo_casing/energy/disabler/rainbow)

/obj/item/ammo_casing/energy/laser/rainbow
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"
	select_name = "kill"
	projectile_type = /obj/projectile/beam/laser/rainbow

/obj/projectile/beam/laser/rainbow
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"

/obj/item/ammo_casing/energy/disabler/rainbow
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"
	select_name = "disable"
	projectile_type = /obj/projectile/beam/disabler/rainbow

/obj/projectile/beam/disabler/rainbow
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"

/obj/item/gun/energy/e_gun/nuclear/emag_act(mob/user, obj/item/card/emag/E)
	. = ..()
	if(obj_flags & EMAGGED)
		return FALSE
	if(pin)
		to_chat(user, span_warning("你最好换一把新枪来做这件事！"))
		return FALSE
	to_chat(user, "<font color='#ff2700'>这</font><font color='#ff4e00'>把</font><font color='#ff7500'>枪</font> <font color='#ffc400'>突</font><font color='#ffeb00'>然</font><font color='#ebff00'>变</font> <font color='#9cff00'>变</font><font color='#75ff00'>得</font><font color='#4eff00'>相</font><font color='#27ff00'>当</font> <font color='#00ff4e'>奇</font><font color='#00ff75'>妙</font><font color='#00ffc4'>起</font><font color='#00ebff'>来</font><font color='#00c4ff'>，</font> <font color='#00ffeb'>简</font><font color='#00ebff'>直</font> <font color='#00c4ff'>太</font><font color='#009cff'>棒</font><font color='#004eff'>了</font><font color='#ff0000'>！</font>")
	new /obj/item/gun/energy/e_gun/nuclear/rainbow(get_turf(user))
	obj_flags |= EMAGGED
	qdel(src)
	return TRUE

/obj/item/gun/energy/e_gun/nuclear/rainbow/update_overlays()
	. = ..()
	. += "[icon_state]_emagged"

/obj/item/gun/energy/e_gun/nuclear/rainbow/emag_act(mob/user, obj/item/card/emag/E)
	return FALSE

//BEAM SOUNDS
/obj/item/ammo_casing/energy
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/laser.ogg'

/obj/item/ammo_casing/energy/laser/pulse
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/pulse.ogg'

/obj/item/gun/energy/xray
	fire_sound_volume = 100

/obj/item/ammo_casing/energy/xray
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/xray_laser.ogg'

/obj/item/ammo_casing/energy/laser/accelerator
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/laser_cannon_fire.ogg'

/obj/item/gun/ballistic/automatic/sniper_rifle
	name = "狙击步枪"
	desc = "一种远程武器，能造成可观的伤害。不，你不能瞬狙。"
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns_gubman2.dmi'
	icon_state = "sniper"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "sniper"
	worn_icon_state = null
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	fire_sound_volume = 90
	load_sound = 'sound/items/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	suppressed_sound = 'sound/items/weapons/gun/general/heavy_shot_suppressed.ogg'
	recoil = 2
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/sniper_rounds
	fire_delay = 6 SECONDS
	burst_size = 1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK
	actions_types = list()
	mag_display = TRUE
	suppressor_x_offset = 3
	suppressor_y_offset = 3

/obj/item/gun/ballistic/automatic/sniper_rifle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2)

/obj/item/gun/ballistic/automatic/sniper_rifle/reset_fire_cd()
	. = ..()
	if(suppressed)
		playsound(src, 'sound/machines/eject.ogg', 25, TRUE, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	else
		playsound(src, 'sound/machines/eject.ogg', 50, TRUE)

/obj/item/gun/ballistic/automatic/sniper_rifle/syndicate
	name = "辛迪加狙击步枪"
	desc = "一把非法改装的 .50 口径狙击步枪，可兼容消音器。瞬狙依然不管用。"
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns_gubman2.dmi'
	icon_state = "sniper2"
	worn_icon_state = "sniper"
	fire_delay = 5.5 SECONDS
	can_suppress = TRUE
	can_unsuppress = TRUE
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/automatic/sniper_rifle/modular
	name = "AUS-107 反器材步枪"
	desc = "一把毁灭性的奥赛克军械公司重型狙击步枪，配有现代化瞄准镜。"
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns_gubman2.dmi'
	icon_state = "sniper"
	worn_icon_state = "sniper"
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle.ogg'
	suppressed_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle_s.ogg'
	w_class = WEIGHT_CLASS_BULKY
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/sniper_rifle/modular/syndicate
	name = "“狞猫”反器材步枪"  //we flop out
	desc = "一把线条流畅的轻量无托式 .50 BMG 狙击步枪，采用往复式枪管，被斯卡伯勒军火公司昵称为“狞猫”。其紧凑的折叠部件使其能够塞进背包，模块化枪管可在内部安装消音器，而不必在枪口外接。其先进瞄准镜弥补了往复式枪管的一切弹道误差。"
	icon_state = "sysniper"
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle.ogg'
	suppressed_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle_s.ogg'
	fire_delay = 4 SECONDS //Delay reduced thanks to recoil absorption
	burst_size = 0.5
	recoil = 1
	can_suppress = TRUE
	can_unsuppress = TRUE
	weapon_weight = WEAPON_LIGHT

/obj/item/gun/ballistic/automatic/sniper_rifle/modular/syndicate/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SCARBOROUGH)

/obj/item/gun/ballistic/automatic/sniper_rifle/modular/blackmarket  //Normal sniper but epic
	name = "SA-107 反器材步枪"
	desc = "斯卡伯勒军火公司对奥赛克军械公司狙击步枪的非法仿制版。这一把配备了重型瞄准镜、更坚固的枪托，以及可拆卸的枪口制退器，便于安装消音器。"
	icon_state = "sniper2"
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle.ogg'
	suppressed_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle_s.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	load_sound = 'sound/items/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	can_suppress = TRUE
	can_unsuppress = TRUE
	recoil = 1.8
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/sniper_rounds
	fire_delay = 55 //Slightly smaller than standard sniper
	burst_size = 1
	slot_flags = ITEM_SLOT_BACK
	mag_display = TRUE

/obj/item/gun/ballistic/automatic/ar/modular
	name = "\improper 纳米传讯 ARG-63"
	desc = "纳米传讯基于斯通纳设计的主力弹道武器，配有轻质聚合物机匣和其他战术配件，发射 .223 弹药，被特种作战小队昵称为“登船者”。"
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns_gubman2.dmi'
	icon_state = "arg"
	inhand_icon_state = "arg"
	can_suppress = FALSE

// GUBMAN3 - FULL BULLET RENAME
// i loathe the above

// overrides for 10mm ammo in modular_skyrat\modules\sec_haul\code\guns\bullets.dm

// overrides for .310 Strilka-derived ammo, e.g. lionhunter ammo, because you don't want to give security the ability to print infinite wallhack ammo, right?
/obj/item/ammo_casing/strilka310/lionhunter
	name = "猎手步枪弹"
	can_be_printed = FALSE // trust me bro you dont wanna give security homing wallhack Better Rubbers

/obj/item/ammo_casing/strilka310/enchanted
	name = "附魔步枪弹"
	can_be_printed = FALSE // these are Really Really Better Rubbers

// shotgun ammo overrides moved to modular_skyrat\modules\shotgunrebalance\code\shotgun.dm

// overrides for tgcode .50cal, used in their sniper/anti-materiel rifles
/obj/item/ammo_casing/p50
	advanced_print_req = TRUE // you are NOT printing more ammo for this without effort.
	// then again the offstations with ammo printers and sniper rifles come with an ammo disk anyway, so

/obj/item/ammo_casing/p50/surplus
	desc = "一个 .50 BMG 子弹壳。故意减装发射药，但被它击中依然相当疼。\
	<br><br>\
	<i>军剩/减装：不具备穿甲能力、接触眩晕或固有断肢能力。但被击中仍然疼得要命。</i>"
	projectile_type = /obj/projectile/bullet/p50/surplus

/obj/item/ammo_casing/p50/disruptor
	desc = "一个 .50 BMG 子弹壳。专门把目标送去睡觉而不是送去地狱，除非目标是合成体——那它们大概还是会下地狱。\
	<br><br>\
	<i>干扰弹：强制类人目标入睡，对半机械人造成重创，并使被击中的目标遭受电磁脉冲。</i>"

/obj/item/ammo_casing/p50/incendiary
	desc = "一个 .50 BMG 子弹壳。采用受激等离子弹头，让人后悔自己还活着。\
	<br><br>\
	<i>精确燃烧弹：不具备固有断肢能力和接触眩晕，对机械化装甲效果较差。会点燃目标。</i>"
	projectile_type = /obj/projectile/bullet/p50/incendiary

/obj/item/ammo_casing/p50/penetrator
	desc = "一个 .50 BMG 子弹壳。装填硬化弹托并加装额外发射药。 \
	设计上几乎能穿透一切。标签警告存在超压风险，若某把武器无法承受超过 \
	85000 PSI 的膛压，请勿使用该弹。\
	<br><br>\
	<i>穿透弹：几乎能穿透一切。不具备固有断肢能力和接触眩晕能力。</i>"

/obj/item/ammo_casing/p50/marksman
	desc = "一个 .50 BMG 子弹壳。装填了一枚无视“飞行时间”这种平凡概念的超级动能弹，\
	并加入了数量令人担忧的实验性发射药。标签警告存在超压风险，若某把武器无法承受超过 \
	95000 PSI 的膛压，请勿使用该弹。\
	<br><br>\
	<i>精确射手弹：子弹<b>没有</b>飞行时间，且可弹跳一次。伤害略低，不具备固有断肢能力和接触眩晕能力。</i>"
	projectile_type = /obj/projectile/bullet/p50/marksman

// overrides for tgcode .45, used in the M1911 and C20-r

/obj/item/ammo_casing/c45/ap
	desc = "一个 .45 穿甲子弹壳。\
	<br><br>\
	<i>穿甲：穿甲能力提升。你还指望什么？</i>"
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c45/inc
	desc = "一个 .45 燃烧子弹壳。\
	<br><br>\
	<i>燃烧：射击时留下一道火焰轨迹，点燃目标。</i>"
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

// overrides for .50AE, used in the deagle
/obj/item/ammo_casing/a50ae
	desc = "一个 .50 AE 子弹壳。威力极其强大。\
	<br><br>\
	<i>手炮：由手枪发射，却能造成不成比例的巨大伤害。</i>"

// overrides for .357, used in the .357 revolver
/obj/item/ammo_casing/a357    //We can keep the Magnum classic.
	name = ".357 子弹壳"
	desc = "一个 .357 子弹壳。\
	<br><br>\
	<i>手炮：由手枪发射，却能造成不成比例的巨大伤害。</i>"

/obj/item/ammo_casing/a357/match
	desc = "一个以极高标准制造的 .357 子弹壳。\
	<br><br>\
	<i>竞赛弹：到处弹跳。疯狂地弹。</i>"

/obj/item/ammo_casing/a357/phasic
	desc = "一个 .357 相位子弹壳。\
	<br><br>\
	<i>相位弹：除有机物外无视一切表面。</i>"
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_PHASIC

/obj/item/ammo_casing/a357/heartseeker
	desc = "一个 .357 追心子弹壳。\
	<br><br>\
	<i>追心弹：具备追踪能力，原理不明。</i>"
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_HOMING // meme ammo. meme print cost

// overrides for .38 Special, used in the .38 revolvers, including the det's
/obj/item/ammo_box/speedloader/c38
	caliber = CALIBER_38

/obj/item/ammo_casing/c38/trac
	custom_materials = AMMO_MATS_TRAC
	advanced_print_req = TRUE

/obj/item/ammo_casing/c38/dumdum
	advanced_print_req = TRUE

/obj/item/ammo_casing/c38/hotshot
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c38/iceblox
	custom_materials = AMMO_MATS_TEMP // plasma's wack.
	advanced_print_req = TRUE

// The ones above are the casings for the ammo, whereas the ones below are the actual projectiles that give you feedback when you're shot

/obj/projectile/bullet/c9mm
	name = "9x25mm 子弹"

/obj/projectile/bullet/c9mm/ap
	name = "9x25mm 穿甲子弹"

/obj/projectile/bullet/c9mm/hp
	name = "9x25mm 破片子弹"

/obj/projectile/bullet/incendiary/c9mm
	name = "9x25mm 燃烧子弹"

/obj/item/ammo_box/magazine/sniper_rounds/soporific //this is just a regular 50 bmg mag I have no clue why the fuck this exists but some maps are dependant on it so I'm not getting rid of it
	desc = "一个装填 .50 BMG 弹药的弹匣，为快乐的白昼与死寂的夜晚而设计。"
