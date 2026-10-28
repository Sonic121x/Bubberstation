//Title Capitalization for names please!!!

/datum/loadout_category/mask
	category_name = "面罩"
	category_ui_icon = FA_ICON_MASK
	type_to_generate = /datum/loadout_item/mask
	tab_order = /datum/loadout_category/head::tab_order + 12

/datum/loadout_item/mask
	abstract_type = /datum/loadout_item/mask

/datum/loadout_item/mask/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.mask)
		LAZYADD(outfit.backpack_contents, outfit.mask)
	outfit.mask = item_path

/*
*	BANDANAS
*/

/datum/loadout_item/mask/bandana
	group = "头巾与面部遮盖"
	abstract_type = /datum/loadout_item/mask/bandana

/datum/loadout_item/mask/bandana/black
	name = "头巾（黑色）"
	item_path = /obj/item/clothing/mask/bandana/black

/datum/loadout_item/mask/bandana/blue
	name = "头巾（蓝色）"
	item_path = /obj/item/clothing/mask/bandana/blue

/datum/loadout_item/mask/bandana/gold
	name = "头巾（金色）"
	item_path = /obj/item/clothing/mask/bandana/gold

/datum/loadout_item/mask/bandana/green
	name = "头巾（绿色）"
	item_path = /obj/item/clothing/mask/bandana/green

/datum/loadout_item/mask/bandana/red
	name = "头巾（红色）"
	item_path = /obj/item/clothing/mask/bandana/red

/datum/loadout_item/mask/bandana/driscoll //Technically just looks like one but it's nicer here smiley face.
	name = "头巾（德里斯科尔）"
	item_path = /obj/item/clothing/mask/gas/driscoll

/datum/loadout_item/mask/bandana/skull
	name = "头巾（骷髅）"
	item_path = /obj/item/clothing/mask/bandana/skull

/datum/loadout_item/mask/bandana/stripe
	name = "头巾（条纹）"
	item_path = /obj/item/clothing/mask/bandana/striped

/datum/loadout_item/mask/bandana/facescarf
	name = "面巾"
	item_path = /obj/item/clothing/mask/facescarf

/datum/loadout_item/mask/bandana/sechailer_half_mask
	name = "战术酷炫半面罩"
	item_path = /obj/item/clothing/mask/gas/half_mask

/datum/loadout_item/mask/bandana/neckgaiter
	name = "护颈套"
	item_path = /obj/item/clothing/mask/primitive_catgirl_greyscale_gaiter


/*
*	BALACLAVAS
*/

/datum/loadout_item/mask/balaclava
	group = "巴拉克拉瓦头套"
	abstract_type = /datum/loadout_item/mask/balaclava

/datum/loadout_item/mask/balaclava/adj
	name = "可调节巴拉克拉瓦头套"
	item_path = /obj/item/clothing/mask/balaclavaadjust

/datum/loadout_item/mask/balaclava/black
	name = "巴拉克拉瓦头套"
	item_path = /obj/item/clothing/mask/balaclava

/datum/loadout_item/mask/balaclava/three
	name = "三孔巴拉克拉瓦头套（黑色）"
	item_path = /obj/item/clothing/mask/balaclava/threehole

/datum/loadout_item/mask/balaclava/green
	name = "三孔巴拉克拉瓦头套（绿色）"
	item_path = /obj/item/clothing/mask/balaclava/threehole/green

/*
*	GAS MASKS
*/

/datum/loadout_item/mask/gas
	group = "防毒面具"
	abstract_type = /datum/loadout_item/mask/gas

/datum/loadout_item/mask/gas/tider
	name = "防毒面具"
	item_path = /obj/item/clothing/mask/gas

/datum/loadout_item/mask/gas/alt
	name = "黑色防毒面具"
	item_path = /obj/item/clothing/mask/gas/alt

/datum/loadout_item/mask/gas/glass
	name = "玻璃防毒面具"
	item_path = /obj/item/clothing/mask/gas/glass

/datum/loadout_item/mask/gas/respirator
	name = "半面罩呼吸器"
	item_path = /obj/item/clothing/mask/gas/respirator

/datum/loadout_item/mask/gas/german
	name = "黑色防毒面具"
	item_path = /obj/item/clothing/mask/gas/german

/datum/loadout_item/mask/gas/soviet
	name = "苏联防毒面具"
	item_path = /obj/item/clothing/mask/gas/soviet

/datum/loadout_item/mask/gas/nri_police
	name = "殖民地防毒面具"
	item_path = /obj/item/clothing/mask/gas/nri_police
	restricted_roles = list(ALL_JOBS_SEC, JOB_CUSTOMS_AGENT)

/datum/loadout_item/mask/gas/frontier_colonist
	name = "边疆防毒面具"
	item_path = /obj/item/clothing/mask/gas/atmos/frontier_colonist/loadout

/datum/loadout_item/mask/gas/nightlight_mask/alldono
	name = "商用 FIR-36 循环呼吸器"
	item_path = /obj/item/clothing/mask/gas/nightlight/alldono

/datum/loadout_item/mask/gas/nightlight_mask
	name = "“罗耶兹”半面罩循环呼吸器"
	item_path = /obj/item/clothing/mask/gas/nightlight
//	ckeywhitelist = list("farsightednightlight", "raxraus", "1ceres", "marcoalbaredaa", "itzshift_yt", "drifter7371", "AvianAviator", "Katty Kat", "Investigator77", "Dalao Azure", "Socialistion", "ChillyLobster", "Sylvara", "AmZee", "Tf4", "rb303", "Kay_Nite", "whataboutism", "taac", "Halkyon", "Lupo_di_rosa", "Merek2", "lowpowermia", "RyeanBread", "Jesterz7", "Saund_Minah", "Ruediger4")

/datum/loadout_item/mask/gas/fir22
	name = "“金博尔”循环呼吸器"
	item_path = /obj/item/clothing/mask/gas/nightlight/fir22
//	ckeywhitelist = list("farsightednightlight", "raxraus", "1ceres", "marcoalbaredaa", "itzshift_yt", "drifter7371", "AvianAviator", "Katty Kat", "Investigator77", "Dalao Azure", "Socialistion", "ChillyLobster", "Sylvara", "AmZee", "Tf4", "rb303", "Kay_Nite", "whataboutism", "taac", "Halkyon", "Lupo_di_rosa", "Merek2", "lowpowermia", "RyeanBread", "Jesterz7", "Saund_Minah", "Ruediger4")

/datum/loadout_item/mask/gas/octusvox
	name = "阴险面甲"
	item_path = /obj/item/clothing/mask/breath/vox/octus
	//ckeywhitelist = list("octus")

/datum/loadout_item/mask/gas/larpswat
	name = "泡沫部队特警面罩"
	item_path = /obj/item/clothing/mask/gas/larpswat
	//ckeywhitelist = list("erdinyobarboza")

/*
*	MASQUERADE MASKS
*/

/datum/loadout_item/mask/masquerade
	group = "假面舞会面具"
	abstract_type = /datum/loadout_item/mask/masquerade

/datum/loadout_item/mask/masquerade/masqmask
	name = "假面舞会面具"
	item_path = /obj/item/clothing/mask/masquerade

/datum/loadout_item/mask/masquerade/two_colors
	name = "假面舞会面具（分色）"
	item_path = /obj/item/clothing/mask/masquerade/two_colors

/datum/loadout_item/mask/masquerade/feathered
	name = "假面舞会面具（羽饰）"
	item_path = /obj/item/clothing/mask/masquerade/feathered

/datum/loadout_item/mask/masquerade/two_colors/feathered
	name = "假面舞会面具（羽饰，分色）"
	item_path = /obj/item/clothing/mask/masquerade/two_colors/feathered

/datum/loadout_item/mask/masquerade/rebellion
	name = "叛逆面具"
	item_path = /obj/item/clothing/mask/rebellion

/datum/loadout_item/mask/masquerade/hheart //sans undertale
	name = "空洞之心"
	item_path = /obj/item/clothing/mask/hheart
	//ckeywhitelist = list("inferno707")

/*
*	MISC
*/

/datum/loadout_item/mask/utility
	group = "实用面罩"
	abstract_type = /datum/loadout_item/mask/utility

/datum/loadout_item/mask/utility/surgical
	name = "无菌面罩（可染色）"
	item_path = /obj/item/clothing/mask/surgical/greyscale

/datum/loadout_item/mask/utility/pipe
	name = "烟斗"
	item_path = /obj/item/cigarette/pipe

/datum/loadout_item/mask/utility/pipe/corn
	name = "烟斗（玉米芯）"
	item_path = /obj/item/cigarette/pipe/cobpipe

/datum/loadout_item/mask/utility/lollipop
	name = "棒棒糖"
	item_path = /obj/item/food/lollipop

/datum/loadout_item/mask/utility/whistle
	name = "警哨"
	item_path = /obj/item/clothing/mask/whistle
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/mask/utility/bridle
	name = "马笼头"
	item_path = /obj/item/clothing/mask/bridle

/*
*	COSTUMES
*/

/datum/loadout_item/mask/costume
	group = "戏服与搞怪面罩"
	abstract_type = /datum/loadout_item/mask/costume

/datum/loadout_item/mask/costume/fake_mustache
	name = "假胡子"
	item_path = /obj/item/clothing/mask/fakemoustache

/datum/loadout_item/mask/costume/plague_doctor
	name = "瘟疫医生面具"
	item_path = /obj/item/clothing/mask/gas/plaguedoctor

/datum/loadout_item/mask/costume/kitsune
	name = "狐面"
	item_path = /obj/item/clothing/mask/kitsune

/datum/loadout_item/mask/costume/monkey
	name = "猴子面具"
	item_path = /obj/item/clothing/mask/gas/monkeymask

/datum/loadout_item/mask/costume/owl
	name = "猫头鹰面具"
	item_path = /obj/item/clothing/mask/gas/owl_mask

/datum/loadout_item/mask/costume/joy
	name = "欢乐面具"
	item_path = /obj/item/clothing/mask/joy

/datum/loadout_item/mask/costume/paper
	name = "纸面具"
	item_path = /obj/item/clothing/mask/paper

/datum/loadout_item/mask/costume/britches_mask
	name = "布里奇斯的面具"
	item_path = /obj/item/clothing/mask/gas/britches
	//ckeywhitelist = list("bloodrite")
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/mask/costume/clown/recolour
	name = "可调色小丑面具"
	item_path = /obj/item/clothing/mask/gas/clown_colourable
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/mask/costume/luchador_mask
	name = "红圣殿骑士面具"
	item_path = /obj/item/clothing/mask/luchador/enzo
	//ckeywhitelist = list("enzoman")

/datum/loadout_item/mask/costume/wolf_mask
	name = "狼面具"
	item_path = /obj/item/clothing/mask/animal/wolf
	//ckeywhitelist = list("theooz")
