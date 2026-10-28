//Metro Cop stuff by HL13

/obj/item/clothing/head/helmet/metrocophelmet
	name = "民事防护头盔"
	flags_inv = HIDEHAIR | HIDEFACE | HIDESNOUT | HIDEFACIALHAIR
	desc = "民事防护的标准配发头盔。采用先进的 GigaSlop 品牌矩阵，可实现不同变体！"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	icon_state = "metrocopHelm"
	inhand_icon_state = null
	armor_type = /datum/armor/head_helmet

/obj/item/clothing/head/helmet/metrocophelmet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/metrocop_helmet)

/datum/atom_skin/metrocop_helmet
	abstract_type = /datum/atom_skin/metrocop_helmet

/datum/atom_skin/metrocop_helmet/metrocop
	preview_name = "Metrocop"
	new_icon_state = "metrocopHelm"

/datum/atom_skin/metrocop_helmet/medical
	preview_name = "Medical Cop"
	new_icon_state = "medicalofficer"

/datum/atom_skin/metrocop_helmet/green
	preview_name = "Green"
	new_icon_state = "overseer"

/datum/atom_skin/metrocop_helmet/puppet
	preview_name = "Puppet"
	new_icon_state = "dv_mask"

/datum/atom_skin/metrocop_helmet/overwatch_white
	preview_name = "White Overwatch"
	new_icon_state = "overwatch_white"

/datum/atom_skin/metrocop_helmet/overwatch
	preview_name = "Overwatch"
	new_icon_state = "overwatch"

/datum/atom_skin/metrocop_helmet/overwatch_red
	preview_name = "Red Overwatch"
	new_icon_state = "overwatch_red"

/obj/item/clothing/head/helmet/abductor/fake
	name = "卡布鲁斯通用头盔"
	desc = "一顶非常普通的头盔，由卡布鲁斯采矿场的灰人使用。看来这顶头盔只能为佩戴者挡风遮雨。"
	icon_state = "alienhelmet"
	inhand_icon_state = null
	armor_type = /datum/armor/none
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/head/helmet/toggleable/pinwheel //sprites by Keila
	name = "风车帽"
	desc = "太空耶稣把他最滑稽的帽子赐给他最异想天开的傻瓜们。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "pinwheel"
	base_icon_state = "pinwheel"
	inhand_icon_state = null
	lefthand_file = null
	righthand_file = null
	armor_type = /datum/armor/none
	clothing_flags = null
	flags_cover = null
	flags_inv = null
	toggle_message = "你让风车停了下来"
	alt_toggle_message = "你让风车转了起来"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	///Cooldown for toggling the spinner.
	COOLDOWN_DECLARE(pinwheel_toggle_cooldown)

/obj/item/clothing/head/helmet/toggleable/pinwheel/adjust_visor()
	if(!COOLDOWN_FINISHED(src, pinwheel_toggle_cooldown))
		return FALSE
	COOLDOWN_START(src, pinwheel_toggle_cooldown, 1 SECONDS)
	return ..()

/obj/item/clothing/head/helmet/toggleable/pinwheel/gold
	name = "华丽风车帽"
	desc = "史上最强的风车帽。世上最滑稽的事物往往也最美，这是命中注定的；别人或许看不到你身上的光芒，但华丽风车帽看得到。它欣赏你现在的样子，也欣赏你所做的一切。它仿佛有生命，也让你感到自己充满生机。在别针的金色微光中，你看到了存在的全部。" //Does literally nothing more than the regular pinwheel hat. Just for emphasis.
	icon_state = "pinwheel_gold"
	base_icon_state = "pinwheel_gold"

//Clussy and Jester sprites from Splurt.
/obj/item/clothing/head/costume/bubber/jester
	name = "了不起的弄臣帽"
	desc = "这是我的钱，这是我的游戏，杀了弄臣。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "striped_jester_hat"

/obj/item/clothing/head/costume/bubber/clussy
	name = "粉色小丑假发"
	desc = "你知道吗，第一顶假发是为辉格党创始人约翰·威廉·辉格制作的？直到 1972 年该党不受欢迎之前，他们都只允许秃头男性戴假发。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "clussy_wig"
	flags_inv = HIDEHAIR

// Henchmen Sprites by Cannibal Hunter of MonkeStation

/obj/item/clothing/head/henchmen_hat
	name = "跟班帽"
	desc = "好的老板……我来处理。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/henchmen_hat"
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	post_init_icon_state = "greyscale_cap"
	greyscale_colors = "#201b1a"
	greyscale_config = /datum/greyscale_config/henchmen
	greyscale_config_worn = /datum/greyscale_config/henchmen/worn
	flags_1 = IS_PLAYER_COLORABLE_1


//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/head/playbunnyears
	name = "兔耳头带"
	desc = "一对固定在头带上的兔耳。其中一只已经歪了。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/playbunnyears"
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	post_init_icon_state = "playbunny_ears"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	greyscale_colors = "#39393f"
	greyscale_config = /datum/greyscale_config/playbunnyears
	greyscale_config_worn = /datum/greyscale_config/playbunnyears_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/playbunnyears/syndicate
	name = "血红兔耳头带"
	desc = "一对固定着头带的、可疑得非同寻常的兔耳。头带看上去用塑钢加固过……但为什么呢？"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "syndibunny_ears"
	post_init_icon_state = null
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/head_helmet
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/syndicate/fake
	armor_type = /datum/armor/none

/obj/item/clothing/head/playbunnyears/centcom
	name = "中央指挥部兔耳头带"
	desc = "一对固定在头带上的、非常专业的兔耳。兔耳本身取自一种濒危的绿兔。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "playbunny_ears_centcom"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/british
	name = "英国兔耳头带"
	desc = "一对固定在头带上的、颇具格调的兔耳。为致敬王冠而戴。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "playbunny_ears_brit"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/communist
	name = "真红兔耳头带"
	desc = "一对固定在头带上的红金双色兔耳。常被集体化的兔耳侍者使用。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "playbunny_ears_communist"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/usa
	name = "美国兔耳头带"
	desc = "一对固定在头带上的星条兔耳。真正爱国者的头带。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "playbunny_ears_usa"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//CAPTAIN

/obj/item/clothing/head/hats/caphat/bunnyears_captain
	name = "舰长兔耳"
	desc = "一对固定在头带上的深蓝兔耳。用来代替更传统的双角帽。"
	icon_state = "captain"
	inhand_icon_state = "that"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	dog_fashion = null

//CARGO

/obj/item/clothing/head/playbunnyears/quartermaster
	name = "货运主管兔耳"
	desc = "一对固定在头带上的棕灰双色兔耳。棕色头带代表相对更高的地位。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "qm"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/cargo
	name = "货运兔耳"
	desc = "一对固定在头带上的棕灰双色兔耳。灰色头带代表相对较低的地位。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "cargo_tech"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/miner
	name = "竖井矿工兔耳"
	desc = "一对固定在头带上的泥灰色兔耳。对充满敌意的熔岩地带大气毫无抵抗力。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "explorer"
	post_init_icon_state = null
	armor_type = /datum/armor/hooded_explorer
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/mailman
	name = "邮差兔耳"
	desc = "一对固定在头带上的蓝红双色兔耳。向所有人展示你对速度与效率的执着。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "mail"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/bitrunner
	name = "比特潜行者兔耳"
	desc = "黑金双色，还沾着太空山地的污渍。卡罗塔电子竞技队的官方佩戴款。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "bitrunner"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//ENGI

/obj/item/clothing/head/playbunnyears/engineer
	name = "工程兔耳"
	desc = "一对固定在头带上的黄橙双色兔耳。很容易被重型机械卷进去。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "engi"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/atmos_tech
	name = "大气技术员兔耳"
	desc = "一对固定在头带上的黄蓝双色兔耳。对火焰和极端气压都没有任何防护。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "atmos"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/ce
	name = "总工程师兔耳"
	desc = "一对固定在头带上的绿白双色兔耳。只是别让它们靠近超物质。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "ce"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//MEDICAL

/obj/item/clothing/head/playbunnyears/doctor
	name = "医疗兔耳"
	desc = "一对固定在头带上的白蓝双色兔耳。肯定比额镜可爱。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "doctor"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/paramedic
	name = "护理人员兔耳"
	desc = "一对固定在头带上的蓝白双色兔耳。能清楚表明你是兔耳急救员，让你享有高度的尊敬与礼遇……想得美。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "paramedic"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/chemist
	name = "化学家兔耳"
	desc = "一对固定在头带上的白橙双色兔耳。其中一只已经歪了。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "chem"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/pathologist
	name = "病理学家兔耳"
	desc = "一对固定在头带上的白绿双色兔耳。这可不是合规的 PPE 装备。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "virologist"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/coroner
	name = "验尸官兔耳"
	desc = "一对固定在头带上的黑白双色兔耳。请别戴着它去参加葬礼。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "coroner"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/cmo
	name = "首席医疗官兔耳"
	desc = "一对固定在头带上的白蓝双色兔耳。一条能让整个医疗团队肃然起敬的头带。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "cmo"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//SCIENCE

/obj/item/clothing/head/playbunnyears/scientist
	name = "科学家兔耳"
	desc = "一对固定在头带上的紫白双色兔耳。为兔形目研究造型画上句点。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "science"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/roboticist
	name = "机器人学家兔耳"
	desc = "一对固定在头带上的黑红双色兔耳。内置伺服电机，可模仿真正兔耳的动作。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "roboticist"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/geneticist
	name = "遗传学家兔耳"
	desc = "一对固定在头带上的蓝白双色兔耳。当你没有兔子可以拼接基因时就用它。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "genetics"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/rd
	name = "科研主管兔耳"
	desc = "一对固定在头带上的紫黑双色兔耳。大笔经费投入到了研发一种能增加佩戴者身高的头饰上，而这就是成果。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "rd"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//SECURITY

/obj/item/clothing/head/playbunnyears/security
	name = "安保兔耳"
	desc = "一对固定在头带上的红黑双色兔耳。头带由硬化钢制成。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "sec"
	post_init_icon_state = null
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/head_helmet
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null


/obj/item/clothing/head/playbunnyears/security/assistant
	name = "安保助理兔耳"
	desc = "一对固定在头带上的红灰双色兔耳。佩戴贴合，以便在远距离扑抱时不会脱落。"
	icon_state = "sec_assistant"

//TODO: Find a way to add Warden stuff that isn't hack-y.

/obj/item/clothing/head/playbunnyears/warden
	name = "典狱官兔耳"
	desc = "一对固定在头带上的红白双色兔耳。查看监控时能防止头发挡住脸。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "warden"
	post_init_icon_state = null
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/head_helmet
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/brig_phys
	name = "监狱医师兔耳"
	desc = "一对固定在头带上的红灰双色兔耳。戴着它的人肯定很专业……对吧？"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "brig_phys"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/detective
	name = "侦探兔耳"
	desc = "一对固定在头带上的棕色兔耳。大耳朵方便听歇斯底里女士们的来电。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "detective"
	post_init_icon_state = null
	armor_type = /datum/armor/fedora_det_hat
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null


/obj/item/clothing/head/playbunnyears/detective/noir
	name = "黑色电影侦探兔耳"
	desc = "一对固定在白色头带上的黑色兔耳。大耳朵方便听歇斯底里女士们的来电。光荣的黑白配色！"
	icon_state = "detective_noir"

/obj/item/clothing/head/playbunnyears/prisoner
	name = "囚犯兔耳"
	desc = "一对固定在头带上的黑橙双色兔耳。这套装扮早已被太空日内瓦公约以“残忍且不寻常的惩罚”为由取缔。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "prisoner"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/hos
	name = "安保主管兔耳"
	desc = "一对固定在头带上的红金双色兔耳。彰显你对所有兔耳警官的权威。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "hos"
	post_init_icon_state = null
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/hats_hos
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//SERVICE

/obj/item/clothing/head/playbunnyears/hop
	name = "人事主管兔耳"
	desc = "一对固定在头带上的暗蓝色兔耳。各地兔耳官僚都偏爱的颜色。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "hop"
	post_init_icon_state = null
	armor_type = /datum/armor/hats_hopcap
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/janitor
	name = "清洁工兔耳"
	desc = "一对固定在头带上的紫色兔耳。被一丝不苟地保持清洁。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "janitor"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/bartender
	name = "酒保兔耳"
	desc = "一对固定在头带上的优雅黑白双色兔耳。隐约带着酒味。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "bar"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	custom_price = PAYCHECK_CREW

/obj/item/clothing/head/playbunnyears/cook
	name = "厨师兔耳"
	desc = "一对固定在头带上的白红双色兔耳。有助于防止头发掉进食物里。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "chef"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/botanist
	name = "植物学家兔耳"
	desc = "一对固定在头带上的绿蓝双色兔耳。在农场漫长的一天里，能防止汗水流进眼睛。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "botany"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/clown
	name = "小丑兔耳"
	desc = "一对橙粉双色兔耳。甚至还会吱吱叫。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "clown"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/mime
	name = "默剧演员兔耳"
	desc = "一对固定在头带上的红黑双色兔耳。适合厌倦了标准贝雷帽的街头艺人。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "mime"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/chaplain
	name = "牧师兔耳"
	desc = "一对固定在头带上的黑白双色兔耳。为敬拜卡罗塔的园丁而戴。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "chaplain"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator_red
	name = "馆长红色兔耳"
	desc = "一对固定在头带上的红米双色兔耳。表明你是与兔子相关的一切的专家。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "curator_red"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator_green
	name = "馆长绿色兔耳"
	desc = "一对固定在头带上的绿黑双色兔耳。表明你是与兔子相关的一切的专家。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "curator_green"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator_teal
	name = "馆长青色兔耳"
	desc = "一对固定在头带上的青色兔耳。表明你是与兔子相关的一切的专家。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "curator_teal"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_black
	name = "律师黑色兔耳"
	desc = "一对固定在头带上的黑色兔耳。谈判和解时最适合戴的头带。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "lawyer_black"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_blue
	name = "律师蓝色兔耳"
	desc = "一对固定在头带上的蓝白双色兔耳。谈判和解时最适合戴的头带。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "lawyer_blue"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_red
	name = "律师红色兔耳"
	desc = "一对固定在头带上的红白双色兔耳。谈判和解时最适合戴的头带。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "lawyer_red"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_good
	name = "好律师兔耳"
	desc = "一对固定在头带上的米蓝双色兔耳。谈判和解时最适合戴的头带。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "lawyer_good"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/psychologist
	name = "心理医生兔耳"
	desc = "一对黑色兔耳。它们让你有什么感觉？"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "psychologist"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//BUNNY STUFF END, SPRITES BY DimWhat OF MONKE STATION

//Maid SEC
/obj/item/clothing/head/security_maid //Icon by Onule!
	name = "清洁与肃清女仆头带"
	desc = "一条极为耐用的头带，上面印有“清洁与肃清”徽记。采用加固面料，可提供足够的防护。"
	icon_state = "security_maid"
	icon = 'modular_zubbers/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'
	armor_type = /datum/armor/head_helmet
	strip_delay = 60

//BEGIN HAT SPRITES BY APRIL

/obj/item/clothing/head/security_kepi
	name = "安保军帽"
	desc = "你好，督察。一种最初由冥王星行星警察带火的军帽式警帽。这一顶似乎带装甲。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "kepi_sec_red"
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hos_kepi
	name = "安保主管军帽"
	desc = "你好，指挥官。一顶安保主管的军帽。帽上环绕着刺绣花纹。这一顶似乎装甲精良。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "kepi_sec_red_hos"
	armor_type = /datum/armor/hats_hos
	strip_delay = 60

// END HATS ADDED BY APRIL

/obj/item/clothing/head/helmet/elder_atmosian
	desc = "大气设备中的巅峰之作，一顶昂贵的改装大气消防头盔，镀有人类已知最奢华、最耐用的金属之一。它在提供全面大气防护的同时，没有沉重到拖慢使用者的程度，还能对大多数伤害来源提供远为出色的防护，甚至能强力抵御气体以及其他试图钻进你脸上的讨厌东西。"
	icon = 'modular_zubbers/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT | STACKABLE_HELMET_EXEMPT | SNUG_FIT | HEADINTERNALS
	material_flags = NONE
	heat_protection = HEAD
	cold_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	flash_protect = FLASH_PROTECTION_WELDER
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDEHAIR | HIDEMASK | HIDEEYES | HIDEEARS
	custom_materials = list(/datum/material/metalhydrogen = SHEET_MATERIAL_AMOUNT * 3)

/obj/item/clothing/head/helmet/elder_atmosian/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/radiation_protected_clothing)

/datum/armor/helmet_elder_atmosian
	melee = 40
	bullet = 30
	laser = 40
	energy = 40
	bomb = 100
	bio = 50
	fire = 100
	acid = 50
	wound = 25

/obj/item/clothing/head/helmet/skull/fake

	strip_delay = 2 SECONDS
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	armor_type = /datum/armor/none
	resistance_flags = FIRE_PROOF

// Ablative hood
/obj/item/clothing/head/hooded/ablative
	// new teshari sprites
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'

/obj/item/clothing/head/helmet/space/plasmaman/plasmax_black
	name = "plasMAX 环境服头盔"
	desc = "等离子人头盔的超大号版本，专为适应非人形头骨而制。"
	icon = 'modular_zubbers/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	icon_state = "plasmax_black"
	light_color = "#f399ff"
	visor_icon = "plasmax_black-envisor"

// virosec helmets, sprites by axietheaxolotl

/obj/item/clothing/head/helmet/sec/viro
	name = "头盔"
	desc = "标准安保装备。保护头部免受撞击。"
	base_icon_state = "security_helmet"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "security_helmet"

/obj/item/clothing/head/helmet/sec/viro/hos
	name = "安保主管头盔"
	desc = "标准安保装备。保护头部免受撞击。这一顶带有金色条纹。"
	base_icon_state = "hos_helmet"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "hos_helmet"
	armor_type = /datum/armor/hats_hos

/obj/item/clothing/head/helmet/blueshirt
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'

/obj/item/clothing/head/utility/hardhat
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/utility_teshari.dmi'

/obj/item/clothing/head/helmet/space/emergency
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'

/obj/item/clothing/head/syndicatefake
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'

/obj/item/clothing/head/helmet/space/syndicate/black/red
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'

/obj/item/clothing/head/helmet/sec
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'
