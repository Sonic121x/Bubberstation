/obj/item/clothing/under/costume
	icon = 'icons/obj/clothing/under/costume.dmi'
	worn_icon = 'icons/mob/clothing/under/costume.dmi'

/obj/item/clothing/under/costume/roman
	name = "\improper 罗马盔甲"
	desc = "古罗马盔甲，由金属与皮革带制成。"
	icon_state = "roman"
	inhand_icon_state = "armor"
	can_adjust = FALSE
	strip_delay = 10 SECONDS
	resistance_flags = NONE

/obj/item/clothing/under/costume/jabroni
	name = "杰布罗尼套装"
	desc = "皮革俱乐部在下面两个星区。"
	icon_state = "darkholme"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/owl
	name = "猫头鹰制服"
	desc = "一件由合成羽毛与坚定信念织成的柔软棕色连体服。"
	icon_state = "owl"
	inhand_icon_state = "owl"
	can_adjust = FALSE

/obj/item/clothing/under/costume/griffin
	name = "狮鹫制服"
	desc = "一件柔软的棕色连体服，配有合成羽毛制成的白色羽领，以及对混乱的渴望。"
	icon_state = "griffin"
	can_adjust = FALSE

/obj/item/clothing/under/costume/seifuku
	name = "女学生制服"
	desc = "就像我看的日本动画一样！"
	greyscale_colors = "#942737#4A518D#EBEBEB"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/seifuku"
	post_init_icon_state = "seifuku"
	greyscale_config_inhand_left = /datum/greyscale_config/seifuku_inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/seifuku_inhands_right
	inhand_icon_state = "seifuku"
	greyscale_config = /datum/greyscale_config/seifuku
	greyscale_config_worn = /datum/greyscale_config/seifuku/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	alternate_worn_layer = UNDER_SUIT_LAYER

/obj/item/clothing/under/costume/seifuku/red
	icon_state = "/obj/item/clothing/under/costume/seifuku/red"
	greyscale_colors = "#3F4453#BB2E2E#EBEBEB"

/obj/item/clothing/under/costume/seifuku/teal
	icon_state = "/obj/item/clothing/under/costume/seifuku/teal"
	greyscale_colors = "#942737#2BA396#EBEBEB"

/obj/item/clothing/under/costume/seifuku/tan
	icon_state = "/obj/item/clothing/under/costume/seifuku/tan"
	greyscale_colors = "#87502E#B9A56A#EBEBEB"

/obj/item/clothing/under/costume/pirate
	name = "海盗装束"
	desc = "呀哈。"
	icon_state = "pirate"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/soviet
	name = "苏联军装"
	desc = "为了祖国！"
	icon_state = "soviet"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/redcoat
	name = "红衫军服"
	desc = "看起来很旧。"
	icon_state = "redcoat"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/kilt
	name = "苏格兰短裙"
	desc = "附带鞋子和格纹。"
	icon_state = "kilt"
	inhand_icon_state = "kilt"
	body_parts_covered = CHEST|GROIN|LEGS|FEET
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/costume/kilt/highlander
	desc = "你是唯一配得上这条短裙的人。"

/obj/item/clothing/under/costume/kilt/highlander/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HIGHLANDER_TRAIT)

/obj/item/clothing/under/costume/gladiator
	name = "角斗士制服"
	desc = "你们不觉得尽兴吗？这不正是你们来此的原因吗？"
	icon_state = "gladiator"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/costume/gladiator/ash_walker
	desc = "这件角斗士制服上似乎覆满灰烬，而且相当陈旧。"
	has_sensor = NO_SENSORS

/obj/item/clothing/under/costume/maid
	name = "女仆装"
	desc = "中国产女仆。"
	greyscale_colors = "#494955#EEEEEE"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/maid"
	post_init_icon_state = "maid"
	greyscale_config = /datum/greyscale_config/maid
	greyscale_config_worn = /datum/greyscale_config/maid/worn
	greyscale_config_inhand_left = /datum/greyscale_config/maid_inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/maid_inhands_right
	inhand_icon_state = "maid"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
	alternate_worn_layer = UNDER_SUIT_LAYER
	can_adjust = FALSE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR //weebs are gonna love this

/obj/item/clothing/under/costume/geisha
	name = "艺伎和服"
	desc = "不包含可爱的太空忍者前辈。"
	icon_state = "geisha"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/under/costume/yukata
	name = "黑色浴衣"
	desc = "一件舒适的黑色棉质浴衣，灵感源自传统设计，非常适合非正式场合。"
	icon_state = "yukata1"
	inhand_icon_state = "yukata1"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/costume/yukata/green
	name = "绿色浴衣"
	desc = "一件舒适的绿色棉质浴衣，灵感源自传统设计，非常适合非正式场合。"
	icon_state = "yukata2"
	inhand_icon_state = "yukata2"

/obj/item/clothing/under/costume/yukata/white
	name = "白色浴衣"
	desc = "一件舒适的白色棉质浴衣，灵感源自传统设计，非常适合非正式场合。"
	icon_state = "yukata3"
	inhand_icon_state = "yukata3"

/obj/item/clothing/under/costume/kimono
	name = "黑色和服"
	desc = "一件奢华的黑丝和服，带有传统风韵，适合优雅的节庆场合。"
	icon_state = "kimono1"
	inhand_icon_state = "yukata1"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/costume/kimono/red
	name = "红色和服"
	desc = "一件奢华的红丝和服，带有传统风韵，适合优雅的节庆场合。"
	icon_state = "kimono2"
	inhand_icon_state = "kimono2"

/obj/item/clothing/under/costume/kimono/purple
	name = "紫色和服"
	desc = "一件奢华的紫丝和服，带有传统风韵，适合优雅的节庆场合。"
	icon_state = "kimono3"
	inhand_icon_state = "kimono3"

/obj/item/clothing/under/costume/villain
	name = "反派套装"
	desc = "想抓住真正的超级英雄，你总得换身行头。"
	icon_state = "villain"
	can_adjust = FALSE

/obj/item/clothing/under/costume/sailor
	name = "水手服"
	desc = "船长正在军官餐厅喝杜松子酒。"
	icon_state = "sailor"
	inhand_icon_state = "b_suit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/singer
	abstract_type = /obj/item/clothing/under/costume/singer
	desc = "光是看着它，就让你想唱歌。"
	body_parts_covered = CHEST|GROIN|ARMS
	alternate_worn_layer = ABOVE_SHOES_LAYER
	can_adjust = FALSE

/obj/item/clothing/under/costume/singer/yellow
	name = "黄色演出服"
	icon_state = "ysing"
	inhand_icon_state = null
	female_sprite_flags = NO_FEMALE_UNIFORM

/obj/item/clothing/under/costume/singer/blue
	name = "蓝色演出服"
	icon_state = "bsing"
	inhand_icon_state = null
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/costume/singer/red
	name = "红色演出服"
	icon_state = "rsing"
	inhand_icon_state = null
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/costume/mummy
	name = "木乃伊裹布"
	desc = "把石板还回来，否则就尝尝我过时的梗。"
	icon_state = "mummy"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/costume/scarecrow
	name = "稻草人衣服"
	desc = "躲在植物学实验室里的完美伪装。"
	icon_state = "scarecrow"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/costume/draculass
	name = "德古拉丝外套"
	desc = "一条灵感源自古老“维多利亚”时代的裙子。"
	icon_state = "draculass"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/costume/drfreeze
	name = "冰冻博士连体服"
	desc = "一件经过改造的科学家连体服，看起来格外酷。"
	icon_state = "drfreeze"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/lobster
	name = "泡沫龙虾服"
	desc = "谁把大学吉祥物的头砍了？"
	icon_state = "lobster"
	inhand_icon_state = null
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/under/costume/gondola
	name = "贡多拉皮套装"
	desc = "这才叫有模有样。"
	icon_state = "gondola"
	inhand_icon_state = "lb_suit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/skeleton
	name = "骷髅连体服"
	desc = "一件印有白色骨骼图案的黑色连体服。真吓人！"
	icon_state = "skeleton"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

// Mech suit skins
/datum/atom_skin/mech_suit
	abstract_type = /datum/atom_skin/mech_suit

/datum/atom_skin/mech_suit/red
	preview_name = "红色" //Asuka from evangelion
	new_icon_state = "red_mech_suit"

/datum/atom_skin/mech_suit/white
	preview_name = "白色" //Rei from evangelion
	new_icon_state = "white_mech_suit"

/datum/atom_skin/mech_suit/blue
	preview_name = "蓝色" //Shinji from Evangelion
	new_icon_state = "blue_mech_suit"

/datum/atom_skin/mech_suit/black
	preview_name = "黑色" //Based on the robotics jumpsuot
	new_icon_state = "black_mech_suit"

/datum/atom_skin/mech_suit/royal
	preview_name = "皇家师团" //Kallen Stadtfeld from Code Geass
	new_icon_state = "royal_mech_suit"

/datum/atom_skin/mech_suit/royal_alt
	preview_name = "皇家师团 - 变体" //Kallen again, with her alternate design
	new_icon_state = "royal_mech_suit_alt"

/datum/atom_skin/mech_suit/explorer
	preview_name = "探索兵团" //Sleeker version of the robotics jumpsuit
	new_icon_state = "explorer_mech_suit"

/datum/atom_skin/mech_suit/explorer_alt
	preview_name = "探索兵团 - 变体" //Elster from SIGNALIS
	new_icon_state = "explorer_mech_suit_alt"

/obj/item/clothing/under/costume/mech_suit
	name = "机甲驾驶员服"
	desc = "一件机甲驾驶员服。可能会让你的屁股显得很大。Alt 点击可更换外观。"
	icon_state = "explorer_mech_suit"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	alternate_worn_layer = GLOVES_LAYER //covers hands but gloves can go over it. This is how these things work in my head.
	can_adjust = FALSE

/obj/item/clothing/under/costume/mech_suit/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/mech_suit)

/obj/item/clothing/under/costume/russian_officer
	name = "\improper 俄罗斯军官制服"
	desc = "最时髦的俄罗斯服装。"
	icon = 'icons/obj/clothing/under/security.dmi'
	icon_state = "hostanclothes"
	inhand_icon_state = null
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	alt_covers_chest = TRUE
	armor_type = /datum/armor/clothing_under/costume_russian_officer
	strip_delay = 5 SECONDS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	can_adjust = FALSE

/datum/armor/clothing_under/costume_russian_officer
	melee = 10
	fire = 30
	acid = 30

/obj/item/clothing/under/costume/buttondown
	gender = PLURAL
	female_sprite_flags = NO_FEMALE_UNIFORM
	custom_price = PAYCHECK_CREW
	icon = 'icons/obj/clothing/under/shorts_pants_shirts.dmi'
	worn_icon = 'icons/mob/clothing/under/shorts_pants_shirts.dmi'
	species_exception = list(/datum/species/golem)
	can_adjust = TRUE
	alt_covers_chest = TRUE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/under/costume/buttondown/slacks
	name = "衬衫配西裤"
	desc = "一件讲究的衬衫配西裤。"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/buttondown/slacks"
	post_init_icon_state = "buttondown_slacks"
	greyscale_config = /datum/greyscale_config/buttondown_slacks
	greyscale_config_worn = /datum/greyscale_config/buttondown_slacks/worn
	greyscale_config_worn_digi = /datum/greyscale_config/buttondown_slacks/worn/digi //SKYRAT EDIT ADDITION - DigiGreyscale
	greyscale_colors = "#EEEEEE#EE8E2E#222227#D8D39C"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/costume/buttondown/slacks/service //preset one to be a formal white shirt and black pants
	icon_state = "/obj/item/clothing/under/costume/buttondown/slacks/service"
	greyscale_colors = "#EEEEEE#CBDBFC#17171B#222227"

/obj/item/clothing/under/costume/buttondown/shorts
	name = "衬衫配短裤"
	desc = "一件讲究的衬衫配短裤。"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/buttondown/shorts"
	post_init_icon_state = "buttondown_shorts"
	greyscale_config = /datum/greyscale_config/buttondown_shorts
	greyscale_config_worn = /datum/greyscale_config/buttondown_shorts/worn
	greyscale_config_worn_digi = /datum/greyscale_config/buttondown_shorts/worn/digi //SKYRAT EDIT ADDITION - DigiGreyscale
	greyscale_colors = "#EEEEEE#EE8E2E#222227#D8D39C"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/costume/buttondown/skirt
	name = "衬衫配短裙"
	desc = "一件讲究的衬衫配短裙。"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/buttondown/skirt"
	post_init_icon_state = "buttondown_skirt"
	greyscale_config = /datum/greyscale_config/buttondown_skirt
	greyscale_config_worn = /datum/greyscale_config/buttondown_skirt/worn
	greyscale_colors = "#EEEEEE#EE8E2E#222227#D8D39C"
	body_parts_covered = CHEST|GROIN|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/costume/buttondown/skirt/service //preset one to be a formal white shirt and black skirt
	icon_state = "/obj/item/clothing/under/costume/buttondown/skirt/service"
	greyscale_colors = "#EEEEEE#CBDBFC#17171B#222227"

/obj/item/clothing/under/costume/jackbros
	name = "杰克兄弟套装"
	desc = "当该去逗逗那群家伙的时候穿。"
	icon_state = "JackFrostUniform"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/deckers
	name = "德克套装"
	icon_state = "decker_jumpsuit"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/football_suit
	name = "橄榄球服"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/football_suit"
	post_init_icon_state = "football_suit"
	can_adjust = FALSE
	greyscale_config = /datum/greyscale_config/football_suit
	greyscale_config_worn = /datum/greyscale_config/football_suit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/football_suit/worn/digi //SKYRAT EDIT ADDITION - DigiGreyscale
	greyscale_colors = "#D74722"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/costume/swagoutfit
	name = "潮流套装"
	desc = "你何不去找几个妞？"
	icon_state = "SwagOutfit"
	inhand_icon_state = null
	can_adjust = FALSE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/under/costume/referee
	name = "裁判制服"
	desc = "一套标准的黑白条纹制服，用于彰显权威。"
	icon_state = "referee"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/joker
	name = "喜剧演员套装"
	desc = "患有精神疾病最糟糕的地方，就是人们期望你表现得好像没病一样。"
	icon_state = "joker"
	can_adjust = FALSE

/obj/item/clothing/under/costume/yuri
	name = "尤里新兵连体服"
	icon_state = "yuri_uniform"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/dutch
	name = "达奇套装"
	desc = "你能感觉到一个<b>天杀的计划</b>正在成形。"
	icon_state = "DutchUniform"
	inhand_icon_state = null
	can_adjust = FALSE

// For the nuke-ops cowboy fit. Sadly no Lone Ranger fit & I don't wanna bloat costume files further.
/obj/item/clothing/under/costume/dutch/syndicate
	desc = "你能感觉到一个<b>天杀的计划</b>正在成形，而这套衣服里的防弹衬里会让它成真得多。"
	armor_type = /datum/armor/clothing_under/syndicate

/obj/item/clothing/under/costume/osi
	name = "O.S.I. 连体服"
	icon_state = "osi_jumpsuit"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/tmc
	name = "失落摩托帮服装"
	icon_state = "tmc_jumpsuit"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/gi
	name = "武术道服"
	desc = "助理也好，核弹特工也罢。你能打倒任何人；这就叫努力！"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/gi"
	post_init_icon_state = "martial_arts_gi"
	greyscale_config = /datum/greyscale_config/gi
	greyscale_config_worn = /datum/greyscale_config/gi/worn
	greyscale_colors = "#f1eeee#000000"
	flags_1 = IS_PLAYER_COLORABLE_1
	inhand_icon_state = null
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/under/costume/gi/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/under/costume/gi/goku
	name = "神圣道服"
	desc = "由一位触动了许多人内心与生活的男人所创。"
	icon_state = "/obj/item/clothing/under/costume/gi/goku"
	post_init_icon_state = "martial_arts_gi_goku"
	greyscale_colors = "#f89925#3e6dd7"

/obj/item/clothing/under/costume/traditional
	name = "传统套装"
	desc = "一套色彩鲜艳的完整套装，大概带有传统用途。也许这些颜色代表家族、氏族或等级，谁知道呢。"
	icon_state = "tradition"
	inhand_icon_state = null
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/under/costume/loincloth
	name = "皮革缠腰布"
	desc = "只用一块皮革遮住私密部位。摸起来很扎人。做这东西的人不是走投无路，就是野蛮人。"
	icon_state = "loincloth"
	inhand_icon_state = null
	body_parts_covered = GROIN
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/costume/henchmen
	name = "喽啰连体服"
	desc = "一件非常花哨的连体服，专为合格的喽啰准备。公会规定，你懂的。"
	icon = 'icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'icons/mob/clothing/under/syndicate.dmi'
	icon_state = "henchmen"
	inhand_icon_state = null
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS|HEAD
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEEARS|HIDEEYES|HIDEHAIR

/obj/item/clothing/under/costume/gamberson
	name = "复原者的武装衣"
	desc = "一套色彩缤纷的衣服，做成了中世纪武装衣的样子。"
	icon_state = "gamberson"
	inhand_icon_state = null
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/under/costume/gamberson/military
	name = "剑士武装衣"
	desc = "一件填充过的中世纪武装衣。它的羊毛层足以削弱任何小型武器的击打。"
	armor_type = /datum/armor/clothing_under/rank_security
	has_sensor = NO_SENSORS

/obj/item/clothing/under/costume/captain
	name = "船长套装"
	desc = "一套绿色西装和黄色领带，尽显权威。"
	icon_state = "green_suit"
	inhand_icon_state = "dg_suit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/captain/skirt
	name = "绿色西装裙"
	desc = "一套绿色西装裙和黄色领带，尽显权威。"
	icon_state = "green_suit_skirt"
	inhand_icon_state = "dg_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/costume/head_of_personnel
	name = "人事主管套装"
	desc = "一套青色西装和黄色领带。既显权威又俗气的一身。"
	icon_state = "teal_suit"
	inhand_icon_state = "g_suit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/head_of_personnel/skirt
	name = "青色西装裙"
	desc = "一套青色西装裙和黄色领带。既显权威又俗气的一身。"
	icon_state = "teal_suit_skirt"
	inhand_icon_state = "g_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
