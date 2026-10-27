/obj/item/clothing/suit/jacket/runner //Sprite by kay#7181 (Donater item: Kan3)
	name = "跑者夹克"
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	inhand_icon_state = null
	body_parts_covered = CHEST|ARMS|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/jacket/runner/engi //Sprite by kay#7181 (Donater item: Kan3)
	name = "工程师跑者夹克"
	icon_state = "runner_engi"
	desc = ""

/obj/item/clothing/suit/jacket/runner/syndicate //Sprite by kay#7181 (Donater item: Kan3)
	name = "辛迪加跑者夹克"
	icon_state = "runner_syndi"
	desc = ""

/obj/item/clothing/suit/jacket/runner/winter //Sprite by kay#7181 (Donater item: Kan3)
	name = "冬季跑者夹克"
	icon_state = "runner_winter"
	desc = ""

/obj/item/clothing/suit/jacket/trucker
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	desc = "如果你看到这句话，请联系程序员。"

/obj/item/clothing/suit/jacket/trucker/highvis //Sprites by Scuhf_
	name = "高可视性卡车司机夹克"
	desc = "一件卡车司机夹克，带有高可视性的橙黄条纹，适合仓库作业。"
	icon_state = "highvis"

/obj/item/clothing/suit/jacket/trucker/ronin //ported from Citadel
	name = "浪人夹克"
	desc = "一件深色皮夹克，上面印着一支老牌 Sol Chromerock 乐队的标志。"
	icon_state = "ronin"

/obj/item/clothing/suit/jacket/diver //Donor item for patriot210
	name = "黑色潜水大衣"
	desc = "一件深色皮夹克，上面印着一支老牌 Sol Chromerock 乐队的标志。"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon_state = "diver"
	worn_icon_state = "diver"
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/jacket/flight //Donor item for ironknight060
	name = "MA-1 飞行夹克"
	desc = "最初为美国空军研发。这件夹克由一代代飞行员珍爱地传承下来，一路流传到 26 世纪。它还配有可翻面的橙色内衬，以备紧急情况。从标签上能看出，这件夹克似乎是 1985 年为美国空军制造的，名牌上还用褪色的字迹写着一个名字。"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon_state = "flight"
	worn_icon_state = "flight"
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'

// Henchmen Sprites by Cannibal Hunter of MonkeStation

/obj/item/clothing/suit/jacket/henchmen_coat
	name = "喽啰大衣"
	desc = "好的老大……交给我吧。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/jacket/henchmen_coat"
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/jacket_digi.dmi'
	post_init_icon_state = "greyscale_coat"
	greyscale_colors = "#201b1a"
	greyscale_config = /datum/greyscale_config/henchmen
	greyscale_config_worn = /datum/greyscale_config/henchmen/worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/jacket/henchmen_coat/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/suit/jacket/tailcoat //parent type
	name = "燕尾服"
	desc = "一件通常由兔兔主题服务员之类的角色穿着的大衣。"
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/jacket_digi.dmi'
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/jacket/tailcoat"
	post_init_icon_state = "tailcoat"
	greyscale_colors = "#39393f"
	greyscale_config = /datum/greyscale_config/tailcoat
	greyscale_config_worn = /datum/greyscale_config/tailcoat_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/jacket/tailcoat/bartender
	name = "调酒师的燕尾服"
	desc = "一件通常由兔兔主题调酒师穿着的大衣。内侧设有枪套，还有一些额外衬垫提供轻微防护。"
	icon_state = "/obj/item/clothing/suit/jacket/tailcoat/bartender"
	post_init_icon_state = "tailcoat_bar"
	greyscale_colors = "#39393f#ffffff"
	greyscale_config = /datum/greyscale_config/tailcoat_bar
	greyscale_config_worn = /datum/greyscale_config/tailcoat_bar_worn
	armor_type = /datum/armor/suit_armor


/obj/item/clothing/suit/jacket/tailcoat/bartender/Initialize(mapload) //so bartenders can use cram their shotgun inside
	. = ..()
	allowed += list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
	)

/obj/item/clothing/suit/jacket/tailcoat/syndicate
	name = "可疑的燕尾服"
	desc = "一件莫名令人生畏的大衣，通常由兔兔主题刺客穿着。它用某种极具弹性的轻质合金加固过。他们到底花了多少钱买这个？"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_syndi"
	post_init_icon_state = null
	armor_type = /datum/armor/wintercoat_syndicate
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null


/obj/item/clothing/suit/jacket/tailcoat/syndicate/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
		/obj/item/restraints/handcuffs,
		/obj/item/knife/combat,
		/obj/item/melee/baton,
	)

/obj/item/clothing/suit/jacket/tailcoat/syndicate/fake
	armor_type = /datum/armor/none

/obj/item/clothing/suit/jacket/tailcoat/magician
	name = "魔术师的燕尾服"
	desc = "一件华丽、内衬金色的燕尾服。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_wiz"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/wizrobe/magician //Not really a robe but it's MAGIC
	name = /obj/item/clothing/suit/jacket/tailcoat/magician::name
	desc = "一件华丽、内衬金色的燕尾服，似乎散发着力量。"
	worn_icon = /obj/item/clothing/suit/jacket/tailcoat/magician::worn_icon
	worn_icon_digi = /obj/item/clothing/suit/jacket/tailcoat/magician::worn_icon_digi
	icon = /obj/item/clothing/suit/jacket/tailcoat/magician::icon
	icon_state = /obj/item/clothing/suit/jacket/tailcoat/magician::icon_state
	inhand_icon_state = null
	flags_inv = null

/obj/item/clothing/suit/jacket/tailcoat/centcom
	name = "中央指挥部燕尾服"
	desc = "一件官方大衣，通常由兔兔主题高管穿着。内衬是舒适又不失格调的兔毛。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_centcom"
	post_init_icon_state = null
	armor_type = /datum/armor/armor_centcom_formal_nt_consultant
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null


/obj/item/clothing/suit/jacket/tailcoat/british
	name = "英国国旗燕尾服"
	desc = "一件饰有米字旗的燕尾服。下午茶时间的完美装束。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_brit"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null


/obj/item/clothing/suit/jacket/tailcoat/communist
	name = "真·红色燕尾服"
	desc = "一件饰有金色星星的红色燕尾服。兔兔服务员联盟的官方制服。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_communist"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/usa
	name = "星条燕尾服"
	desc = "一件复古大衣，独立战争期间由第五兔兔营穿着。不含滑膛火枪。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_stars"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/plasmaman
	name = "紫色燕尾服"
	desc = "一件紫色大衣，看起来和几款等离子人环境服所用的紫色相同。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_plasma"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//CAPTAIN

/obj/item/clothing/suit/armor/vest/capcarapace/tailcoat_captain
	name = "舰长的燕尾服"
	desc = "一件航海风格的大衣，通常由兔兔主题舰长穿着。它用经过基因改造的装甲蓝兔毛加固过。"
	icon_state = "captain"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null

//CARGO

/obj/item/clothing/suit/jacket/tailcoat/quartermaster
	name = "货运主管的燕尾服"
	desc = "一件考究的棕色大衣，由兔兔主题货运主管穿着。金色点缀向所有人表明谁才是管事的人。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "qm"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/cargo
	name = "货运燕尾服"
	desc = "一件简单的棕色大衣，由兔兔主题货运技师穿着。条纹比货运主管那件少得多。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "cargo_tech"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/miner
	name = "探险者燕尾服"
	desc = "一套改装过的探险者服，由兔兔主题矿工穿着。它带有可安装歌利亚护甲的挂点，但护甲值相对较低。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "explorer"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|ARMS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	armor_type = /datum/armor/hooded_explorer
	allowed = list(
		/obj/item/flashlight,
		/obj/item/gun/energy/recharge/kinetic_accelerator,
		/obj/item/mining_scanner,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/storage/bag/ore,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/tank/internals,
		)
	resistance_flags = FIRE_PROOF
	clothing_traits = list(TRAIT_SNOWSTORM_IMMUNE)

/obj/item/clothing/suit/jacket/tailcoat/miner/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate)


/obj/item/clothing/suit/jacket/tailcoat/bitrunner
	name = "比特潜行者燕尾服"
	desc = "一件黑金配色的外套，由兔兔主题货运技师穿着。开罐太空可乐，咱们痛快玩一场！"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "bitrunner"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//ENGI

/obj/item/clothing/suit/jacket/tailcoat/engineer
	name = "工程燕尾服"
	desc = "一件高可视性燕尾服，由兔兔主题工程师穿着。非常适合在低光环境下作业。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "engi"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null

	greyscale_colors = null
	allowed = list(
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/flashlight,
		/obj/item/radio,
		/obj/item/storage/bag/construction,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/t_scanner,
		/obj/item/gun/ballistic/rifle/boltaction/pipegun/prime,
	)

/obj/item/clothing/suit/jacket/tailcoat/engineer/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/suit/utility/fire/atmos_tech_tailcoat
	name = "大气技师的燕尾服"
	desc = "一件重型防火燕尾服，由兔兔主题大气技师穿着。用石棉织布加固，既时尚又能诱发肺癌。"
	icon_state = "atmos"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/jacket_digi.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	body_parts_covered = CHEST|GROIN|ARMS
	slowdown = 0
	armor_type = /datum/armor/atmos_tech_tailcoat
	flags_inv = null
	clothing_flags = null
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	strip_delay = 30
	equip_delay_other = 30

/datum/armor/atmos_tech_tailcoat
	melee = 10
	bullet = 5
	laser = 10
	energy = 10
	bomb = 20
	bio = 50
	fire = 100
	acid = 50

/obj/item/clothing/suit/utility/fire/ce_tailcoat
	name = "总工程师的燕尾服"
	desc = "一件重型绿白外套，由兔兔主题总工程师穿着。采用三层复合面料制成，既隔热又防火，可惜大敞的领口让这一切都白费了。"
	icon_state = "ce"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/jacket_digi.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	body_parts_covered = CHEST|GROIN|ARMS
	slowdown = 0
	armor_type = /datum/armor/ce_tailcoat
	flags_inv = null
	clothing_flags = null
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	strip_delay = 30
	equip_delay_other = 30

/datum/armor/ce_tailcoat
	melee = 10
	bullet = 5
	laser = 10
	energy = 10
	bomb = 20
	bio = 50
	fire = 100
	acid = 50

//MEDICAL

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat
	name = "医疗燕尾服"
	desc = "一件无菌的白蓝外套，由兔兔主题医生穿着。很适合挡血。"
	icon_state = "doctor"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/toggle/labcoat/paramedic/doctor_tailcoat
	name = "急救员的燕尾服"
	desc = "一件重型大衣，由兔兔主题急救员穿着。带有高可视性条纹，便于在黑暗中执行急救任务。"
	icon_state = "paramedic"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/toggle/labcoat/chemist/doctor_tailcoat
	name = "化学师的燕尾服"
	desc = "一件无菌的白橙外套，由兔兔主题化学师穿着。处理危险物质时，敞开的前襟实在算不上好设计。"
	icon_state = "chem"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/toggle/labcoat/virologist/doctor_tailcoat
	name = "病理学家的燕尾服"
	desc = "一件无菌的白绿外套，由兔兔主题病理学家穿着。比生物防护服更时髦，也更没用。"
	icon_state = "virologist"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/toggle/labcoat/coroner/doctor_tailcoat
	name = "验尸官的燕尾服"
	desc = "一件无菌的黑白外套，由兔兔主题验尸官穿着。背后饰有一个骷髅图案。"
	icon_state = "coroner"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/toggle/labcoat/cmo/doctor_tailcoat
	name = "首席医疗官的燕尾服"
	desc = "一件无菌的蓝色外套，由兔兔主题首席医疗官穿着。蓝色既让穿戴者显眼，也让血迹在那些级别更低、也更干净的医生中间格外醒目。"
	icon_state = "cmo"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//SCIENCE

/obj/item/clothing/suit/toggle/labcoat/science/doctor_tailcoat
	name = "科学家的燕尾服"
	desc = "一件利落的白外套，由兔兔主题科学家穿着。对史莱姆有一定防护作用。"
	icon_state = "science"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/toggle/labcoat/roboticist/doctor_tailcoat
	name = "机器人学家的燕尾服"
	desc = "一件带红色护肩的利落白外套，由兔兔主题机器人学家穿着。沾上油污后竟出奇地好看。"
	icon_state = "roboticist"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null


/obj/item/clothing/suit/toggle/labcoat/genetics/doctor_tailcoat
	name = "基因学家的燕尾服"
	desc = "一件利落的白蓝外套，由兔兔主题基因学家穿着。几乎就像真正的医生白大褂。"
	icon_state = "genetics"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/toggle/labcoat/research_director/tailcoat
	name = "研究主管的燕尾服"
	desc = "一件利落的紫色外套，由兔兔主题首席研究员穿着。它由缴获的绑架者技术制成，看似大衣，实为护肩投射出的高级全息影像。手感也和真品毫无二致。"
	icon_state = "rd"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//SECURITY

/obj/item/clothing/suit/armor/security_tailcoat
	name = "安保燕尾服"
	desc = "一件加固燕尾服，由兔兔主题安保官穿着。使用与 MK 1 背心相同的轻质护甲，不过胸部防护显然更薄。"
	icon_state = "sec"
	inhand_icon_state = "armor"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/jacket_digi.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null
	armor_type = /datum/armor/suit_armor

/obj/item/clothing/suit/armor/security_tailcoat/assistant
	name = "安保助理的燕尾服"
	desc = "一件加固燕尾服，由兔兔主题安保助理穿着。较暗的配色代表其在兔兔指挥链中级别更低。"
	icon_state = "sec_assistant"

/obj/item/clothing/suit/armor/security_tailcoat/warden
	name = "看守长的燕尾服"
	desc = "一件加固燕尾服，由兔兔主题看守长穿着。可以体面地藏下防弹插板。"
	icon_state = "warden"

/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/doctor_tailcoat
	name = "禁闭室医师的燕尾服"
	desc = "一件大体无菌的红灰外套，由兔兔主题禁闭室医师穿着。它没有“标准”安保燕尾服那样的衬垫。"
	icon_state = "brig_phys"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	blood_overlay_type = "coat"


/obj/item/clothing/suit/jacket/det_suit/tailcoat
	name = "侦探的燕尾服"
	desc = "一件加固燕尾服，由兔兔主题侦探穿着。非常适合那种冷酷干练的女侦探。"
	icon_state = "detective"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/jacket/det_suit/tailcoat/noir
	name = "黑色电影风侦探的燕尾服"
	desc = "一件加固燕尾服，由黑色电影风的兔兔主题侦探穿着。非常适合那种冷酷干练的女侦探。"
	icon_state = "detective_noir"

/obj/item/clothing/suit/armor/hos_tailcoat
	name = "安保主管的燕尾服"
	desc = "一件加固燕尾服，由兔兔主题安保指挥官穿着。用特殊合金强化，兼顾额外防护与风度。"
	icon_state = "hos"
	inhand_icon_state = "armor"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/jacket_digi.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null
	armor_type = /datum/armor/armor_hos
	strip_delay = 80

//SERVICE

/obj/item/clothing/suit/armor/hop_tailcoat
	name = "人事主管的燕尾服"
	desc = "一件看起来很严厉的大衣，通常由兔兔主题官僚穿着。这对护肩肯定能让人终于认真对待你。"
	icon_state = "hop"
	inhand_icon_state = "armor"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/jacket_digi.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null

/obj/item/clothing/suit/jacket/tailcoat/janitor
	name = "清洁工的燕尾服"
	desc = "一件看起来很干净的大衣，通常由兔兔主题清洁工穿着。紫色袖子是 24 世纪晚期的风格。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "janitor"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/cook
	name = "厨师的燕尾服"
	desc = "一件专业的白色外套，由兔兔主题厨师穿着。红色点缀和经常染在上面的猴子血意外地搭。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "chef"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	allowed = list(
		/obj/item/kitchen,
		/obj/item/knife/kitchen,
		/obj/item/storage/bag/tray,
	)

/obj/item/clothing/suit/jacket/tailcoat/botanist
	name = "植物学家的燕尾服"
	desc = "一件绿色皮外套，由兔兔主题植物学家穿着。很适合替你挡住背上的阳光。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "botany"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	allowed = list(
		/obj/item/cultivator,
		/obj/item/geneshears,
		/obj/item/graft,
		/obj/item/hatchet,
		/obj/item/plant_analyzer,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/spray/pestspray,
		/obj/item/reagent_containers/spray/plantbgone,
		/obj/item/secateurs,
		/obj/item/seeds,
		/obj/item/storage/bag/plants,
	)

/obj/item/clothing/suit/jacket/tailcoat/clown
	name = "小丑的燕尾服"
	desc = "一件橙色波点外套，由兔兔主题小丑穿着。让所有人都看清谁才是真正的马戏团长。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "clown"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/mime
	name = "默剧演员的燕尾服"
	desc = "一件条纹袖的黑色外套，由兔兔主题默剧演员穿着。红色点缀模仿了更常见默剧服装上的背带。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "mime"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/chaplain
	name = "牧师的燕尾服"
	desc = "一件镀金黑色外套，由兔兔主题牧师穿着。这是 Cairead 那些兔形教团的传统法衣。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "chaplain"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	allowed = list(
		/obj/item/nullrod,
		/obj/item/reagent_containers/cup/glass/bottle/holywater,
		/obj/item/storage/fancy/candle_box,
		/obj/item/flashlight/flare/candle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman
	)

/obj/item/clothing/suit/jacket/tailcoat/curator_red
	name = "馆长的红色燕尾服"
	desc = "一件红色亚麻外套，由兔兔主题图书管理员穿着。在档案室长时间值班时能替你挡住肩上的灰尘。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "curator_red"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/curator_green
	name = "馆长的绿色燕尾服"
	desc = "一件绿色亚麻外套，由兔兔主题图书管理员穿着。在档案室长时间值班时能替你挡住肩上的灰尘。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "curator_green"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/curator_teal
	name = "馆长的青蓝色燕尾服"
	desc = "一件青蓝色亚麻外套，由兔兔主题图书管理员穿着。在档案室长时间值班时能替你挡住肩上的灰尘。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "curator_teal"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer_black
	name = "律师的黑色燕尾服"
	desc = "任何兔兔主题律师的必备单品。极其专业。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "lawyer_black"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer_blue
	name = "律师的蓝色燕尾服"
	desc = "一件蓝色亚麻外套，由兔兔主题律师穿着。口袋里的也许装着受诅咒者的灵魂，也许没有。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "lawyer_blue"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer_red
	name = "律师的红色燕尾服"
	desc = "一件红色亚麻外套，由兔兔主题律师穿着。口袋里的也许装着受诅咒者的灵魂，也许没有。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "lawyer_red"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer_good
	name = "好律师的燕尾服"
	desc = "一件米色亚麻外套，由兔兔主题律师穿着。口袋里的也许装着受诅咒者的灵魂，也许没有。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "lawyer_good"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/psychologist
	name = "心理学家的燕尾服"
	desc = "一件黑色亚麻外套，由兔兔主题心理学家穿着。敞开式便装能让你显得平易近人，也许太随性了点。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "psychologist"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//BUNNY STUFF END, SPRITES BY DimWhat OF MONKE STATION

//Lore Jackets
//Galactic Federation SPRITES BY Tonadas of Bubberstation
/obj/item/clothing/suit/jacket/galfed
	name = "银河联邦夹克"
	desc = "一件银河联邦成员穿着的夹克。有点旧，但整体状况仍然良好。"
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	icon_state = "galfed"
	body_parts_covered = CHEST|ARMS|GROIN

//Doppler Hoodies, sprites seemingly by kittysmooch of who woulda guessed, Doppler.

/obj/item/clothing/suit/hooded/big_hoodie
	name = "宽松连帽衫"
	desc = "在垂直气雾栽培系统中生长的棉纤维经环锭纺纱，织成连续环圈绒布， \
	绒面柔软、几乎无弹性。这块面料被裁成宽松版型，肩线柔和下垂，袖口正好落在第一指节处。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/big_hoodie"
	post_init_icon_state = "big_hoodie"
	greyscale_config = /datum/greyscale_config/big_hoodie
	greyscale_config_worn = /datum/greyscale_config/big_hoodie/worn
	greyscale_config_worn_digi = /datum/greyscale_config/big_hoodie/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/big_hoodie/worn/teshari
	greyscale_colors = "#5d6161"
	hoodtype = /obj/item/clothing/head/hooded/big_hoodie_hood
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/head/hooded/big_hoodie_hood
	name = "宽松兜帽"
	desc = "在垂直气雾栽培系统中生长的棉纤维经环锭纺纱，织成连续环圈绒布， \
	绒面柔软、几乎无弹性。兜帽裁剪得宽松舒适。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/hooded/big_hoodie_hood"
	post_init_icon_state = "big_hoodie_hood"
	body_parts_covered = HEAD
	cold_protection = HEAD
	flags_inv = HIDEEARS|HIDEHAIR
	flags_1 = IS_PLAYER_COLORABLE_1
	hair_mask = /datum/hair_mask/winterhood
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	greyscale_config = /datum/greyscale_config/big_hoodie_hood
	greyscale_config_worn = /datum/greyscale_config/big_hoodie_hood/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/big_hoodie_hood/worn/teshari
	greyscale_colors = "#5d6161"

/obj/item/clothing/suit/hooded/big_hoodie/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()
	if(!hood)
		return
	var/list/hoodie_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/list/new_hoodie_colors = hoodie_colors.Copy(1)
	hood.set_greyscale(new_hoodie_colors)
	hood.update_slot_icon()

/obj/item/clothing/suit/hooded/big_hoodie/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/hoodie_colors = (SSgreyscale.ParseColorString(greyscale_colors))
	var/list/new_hoodie_colors = hoodie_colors.Copy(1)
	hood.set_greyscale(new_hoodie_colors)

/obj/item/clothing/suit/hooded/twee_hoodie
	name = "甜得发腻的连帽衫"
	desc = "一件厚实柔软的环锭纺绒布卫衣，上面装饰着布料仿制的耳朵。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/twee_hoodie"
	post_init_icon_state = "twee_hoodie"
	greyscale_config = /datum/greyscale_config/twee_hoodie
	greyscale_config_worn = /datum/greyscale_config/twee_hoodie/worn
	greyscale_config_worn_digi = /datum/greyscale_config/twee_hoodie/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/twee_hoodie/worn/teshari
	greyscale_colors = "#dbc0e0"
	hoodtype = /obj/item/clothing/head/hooded/twee_hoodie_hood
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/head/hooded/twee_hoodie_hood
	name = "甜得发腻的兜帽"
	desc = "一顶厚实柔软的环锭纺绒布兜帽，上面装饰着布料仿制的耳朵。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/hooded/twee_hoodie_hood"
	post_init_icon_state = "twee_hoodie_hood"
	body_parts_covered = HEAD
	cold_protection = HEAD
	flags_inv = HIDEEARS|HIDEHAIR
	flags_1 = IS_PLAYER_COLORABLE_1
	hair_mask = /datum/hair_mask/winterhood
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	greyscale_config = /datum/greyscale_config/twee_hoodie_hood
	greyscale_config_worn = /datum/greyscale_config/twee_hoodie_hood/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/twee_hoodie_hood/worn/teshari
	greyscale_colors = "#dbc0e0"

/obj/item/clothing/suit/hooded/twee_hoodie/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()
	if(!hood)
		return
	var/list/hoodie_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/list/new_hoodie_colors = hoodie_colors.Copy(1,2)
	hood.set_greyscale(new_hoodie_colors)
	hood.update_slot_icon()

/obj/item/clothing/suit/hooded/twee_hoodie/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/hoodie_colors = (SSgreyscale.ParseColorString(greyscale_colors))
	var/list/new_hoodie_colors = hoodie_colors.Copy(1,2)
	hood.set_greyscale(new_hoodie_colors)

//Bombers by Christasmurf, Synth of Paradice & Soljurn respectively.

//Base so we don't need to keep putting icon/worn over and over
/obj/item/clothing/suit/toggle/jacket/zubber
	name = "请别再把我刷出来"
	desc = "少一个了，别这样。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/jacket_teshari.dmi'
	icon_state = "bomber"


/obj/item/clothing/suit/toggle/jacket/zubber/bomber
	name = "三件套飞行夹克"
	desc = "大家是真喜欢这玩意儿。说真的，三个独立版本？拜托。"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON


//Engineering

/obj/item/clothing/suit/utility/fire/atmosbomber
	name = "大气技师飞行夹克"
	desc = "你可能会震惊于这件毛领夹克竟然防火！我也很震惊！"
	icon_state = "bomberatmos"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/jacket_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	w_class = WEIGHT_CLASS_NORMAL
	body_parts_covered = CHEST|ARMS
	slowdown = 0
	armor_type = /datum/armor/atmos_tech_tailcoat
	flags_inv = null
	clothing_flags = null
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	strip_delay = 30
	equip_delay_other = 30


/obj/item/clothing/suit/utility/fire/atmosbomber/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "bomberatmos_t")


/obj/item/clothing/suit/toggle/jacket/zubber/bomber/engi
	name = "工程飞行夹克"
	desc = "这衣服还能装下你的装备！我知道，很惊人吧。"
	icon_state = "bomberengi"
	allowed = list(
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/flashlight,
		/obj/item/radio,
		/obj/item/storage/bag/construction,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/t_scanner,
		/obj/item/gun/ballistic/rifle/boltaction/pipegun/prime,
	)

//Cargo

/obj/item/clothing/suit/toggle/jacket/zubber/bomber/cargo
	name = "货运飞行夹克"
	desc = "把步枪拿稳了，货运共和国还没完呢。"
	icon_state = "bombercargo"
	allowed = list(
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/boxcutter,
		/obj/item/dest_tagger,
		/obj/item/stamp,
		/obj/item/storage/bag/mail,
		/obj/item/universal_scanner,
	)

/obj/item/clothing/suit/toggle/jacket/zubber/bomber/cargo/smith
	name = "铁匠飞行夹克"
	desc = "1940 年代的时尚，混着 1140 年代的伤寒。"
	icon_state = "bombersmith"
	allowed = list(
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/forging/hammer,
		/obj/item/forging/tongs,
		/obj/item/forging/billow,
	)

/obj/item/clothing/suit/toggle/jacket/zubber/bomber/mining
	name = "采矿飞行夹克"
	desc = "有一瞬间，你发誓这件夹克有兜帽。肯定是脑子在骗你。你还能往上粘护甲板呢！"
	icon_state = "bombermining"
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|ARMS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	armor_type = /datum/armor/hooded_explorer
	allowed = list(
		/obj/item/flashlight,
		/obj/item/gun/energy/recharge/kinetic_accelerator,
		/obj/item/mining_scanner,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/storage/bag/ore,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/tank/internals,
		)
	resistance_flags = FIRE_PROOF
	clothing_traits = list(TRAIT_SNOWSTORM_IMMUNE)

/obj/item/clothing/suit/toggle/jacket/zubber/bomber/mining/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate)

//Science

/obj/item/clothing/suit/toggle/jacket/zubber/bomber/science
	name = "科学飞行夹克"
	desc = "把你那件——这可不是我的原话——“劝退异性的白大褂”换成更有型的衣服吧！"
	icon_state = "bombersci"
	allowed = list(
		/obj/item/analyzer,
		/obj/item/biopsy_tool,
		/obj/item/dnainjector,
		/obj/item/flashlight/pen,
		/obj/item/healthanalyzer,
		/obj/item/paper,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/applicator,
		/obj/item/reagent_containers/syringe,
		/obj/item/gun/syringe,
		/obj/item/sensor_device,
		/obj/item/soap,
		/obj/item/stack/medical,
		/obj/item/storage/pill_bottle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		)
	armor_type = /datum/armor/toggle_labcoat

/obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/robotics
	name = "机器人学家飞行夹克"
	desc = "那些把实验室当狗窝的恐怖犬类生物，如果你穿上它们制造者的皮，说不定会对你多几分敬畏。"
	icon_state = "bomberrobo"


//Medical
/obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/med
	name = "医疗飞行夹克"
	desc = "说实话吧，自从我们雇了长毛的家伙，无菌这个概念就被彻底扔出门了。"
	icon_state = "bombermed"

/obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/chem
	name = "化学飞行夹克"
	desc = "<b>别再攒光环了，快给我们合成肉液！</b>"
	icon_state = "bomberchem"

/obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/coroner
	name = "黑色飞行夹克"
	desc = "一件漆黑如沥青的飞行夹克。要是你的朋友都还活着，他们准会觉得你是周围最酷的人。"
	icon_state = "bombercoroner"

//Misc
/obj/item/clothing/suit/toggle/jacket/zubber/bomber/hydro
	name = "植物学飞行西装"
	desc = "其实并不是西装外套！不过，借用设计师的话：“头韵，是一门艺术。”"
	icon_state = "bomberhydro"
	allowed = list(
		/obj/item/cultivator,
		/obj/item/geneshears,
		/obj/item/graft,
		/obj/item/hatchet,
		/obj/item/plant_analyzer,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/spray/pestspray,
		/obj/item/reagent_containers/spray/plantbgone,
		/obj/item/secateurs,
		/obj/item/seeds,
		/obj/item/storage/bag/plants,
	)

/obj/item/clothing/suit/toggle/jacket/zubber/bomber/sec
	name = "安保飞行夹克"
	desc = "自打<b>那起事件</b>之后，我们服装公司就不再掺和任何“蓝队/红队”之争了，抱歉。"
	icon_state = "bombersec"
	armor_type = /datum/armor/suit_armor

/obj/item/clothing/suit/toggle/jacket/zubber/bomber/sec/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/jacket/zubber/bomber/syndicate
	name = "可疑的飞行夹克"
	desc = "如果那本《轰炸机哈里斯》还不算露馅，那说明有人把“bomber”这个词当真了。"
	icon_state = "bombersyndie"
	armor_type = /datum/armor/wintercoat_syndicate


/obj/item/clothing/suit/toggle/jacket/zubber/bomber/syndicate/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
		/obj/item/restraints/handcuffs,
		/obj/item/knife/combat,
		/obj/item/melee/baton,
	)

/obj/item/clothing/suit/toggle/jacket/zubber/bomber/syndicate/fake
	armor_type = /datum/armor/hooded_wintercoat

/obj/item/clothing/suit/greyscale/sweater
	name = "大毛衣"
	desc = "一件超大的毛衣！它大得都能临时当毯子用。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/greyscale/sweater"
	post_init_icon_state = "sweater"
	body_parts_covered = CHEST|ARMS
	greyscale_config = /datum/greyscale_config/sweater_greyscale_1
	greyscale_config_worn = /datum/greyscale_config/sweater_greyscale_1/worn
	greyscale_colors = "#2d3a46"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/greyscale/sweater/bow
	name = "带蝴蝶结的大毛衣"
	desc = "一件超大的毛衣，还配着一个同样巨大的丝带蝴蝶结！它大得都能临时当毯子用。"
	icon_state = "/obj/item/clothing/suit/greyscale/sweater/bow"
	post_init_icon_state = "sweaterbow"
	greyscale_config = /datum/greyscale_config/sweater_greyscale_2
	greyscale_config_worn = /datum/greyscale_config/sweater_greyscale_2/worn
	greyscale_colors = "#2d3a46#ffcc66"

/obj/item/clothing/suit/greyscale/furred_trenchcoat
	name = "毛领风衣"
	desc = "一件内衬毛皮的保暖风衣，专为寒冷、黑暗、绝望的冬夜打造。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/greyscale/furred_trenchcoat"
	post_init_icon_state = "coat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	greyscale_config = /datum/greyscale_config/fluffywintercoat
	greyscale_config_worn = /datum/greyscale_config/fluffywintercoat/worn
	greyscale_colors = "#eaeaea#969696#4d4d4d#ccffff"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/dagger_mantle
	name = "“匕首”设计师披肩"
	desc = "在 2560 年春季系列中，这位设计师大谈特谈那些 \
		“似乎无需人类干预便凭空出现”的物件有何魅力。这件披肩由整块面料制成，缝线 \
		与闭合处都置于背后，整体近乎朴素到足以掩盖它出自一家火星服装 \
		工厂的来历。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/dagger_mantle"
	post_init_icon_state = "dagger_mantle"
	greyscale_config = /datum/greyscale_config/dagger_mantle
	greyscale_config_worn = /datum/greyscale_config/dagger_mantle/worn
	greyscale_colors = "#d6f7ff"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_NECK

/obj/item/clothing/suit/toggle/labcoat/technical/cargo
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/jacket_teshari.dmi'

/obj/item/clothing/suit/toggle/jacket/corrections_officer
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/jacket_teshari.dmi'

/obj/item/clothing/suit/toggle/jacket/det_trench
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/jacket_teshari.dmi'

/obj/item/clothing/suit/armor/vest/nanotrasen_consultant
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/jacket_teshari.dmi'

/obj/item/clothing/suit/toggle/jacket/trenchcoat
	greyscale_config_worn_teshari = /datum/greyscale_config/trenchcoat/worn/teshari
