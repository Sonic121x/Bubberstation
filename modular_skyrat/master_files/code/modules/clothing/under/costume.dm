/obj/item/clothing/under/costume
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/costume_digi.dmi'

/obj/item/clothing/under/costume/russian_officer
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/security_digi.dmi'

/obj/item/clothing/under/costume/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/costume.dmi'
	can_adjust = FALSE

//My least favorite file. Just... try to keep it sorted. And nothing over the top

/*
*	UNSORTED
*/
/obj/item/clothing/under/costume/skyrat/cavalry
	name = "骑兵制服"
	desc = "把自己奉献给更值得的事物吧。献给忠诚与荣誉，因为只有当所有人都背弃它时，它才会真正消亡。"
	icon_state = "cavalry" //specifically an 1890s US Army Cavalry Uniform

/obj/item/clothing/under/costume/deckers/alt //not even going to bother re-pathing this one because its such a unique case of 'TGs item has something but this alt doesnt'
	name = "德克无面罩套装"
	desc = "一件霓虹蓝色的德克连体服。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/costume.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/costume_digi.dmi'
	icon_state = "decking_jumpsuit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/skyrat/bathrobe
	name = "浴袍"
	desc = "一件温暖蓬松的浴袍，最适合在终于洗干净之后好好放松。"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/skyrat/bathrobe"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/suit/suit.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/suit/suit_teshari.dmi'
	post_init_icon_state = "robes"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_colors = "#ffffff"
	greyscale_config = /datum/greyscale_config/bathrobe
	greyscale_config_worn = /datum/greyscale_config/bathrobe/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/bathrobe/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/bathrobe/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/bathrobe/worn/oldvox
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#434d7a" //THATS RIGHT, FUCK YOU! THE BATHROBE CAN BE RECOLORED!
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/costume/skyrat/kilt
	name = "苏格兰短裙"
	desc = "只是为了让这件继承正版苏格兰短裙的各项属性。"
	icon_state = "kilt"
	body_parts_covered = CHEST|GROIN|LEGS|FEET
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY


/obj/item/clothing/under/costume/skyrat/kilt/royal
	name = "皇家苏格兰短裙"
	desc = "斯图亚特家族认证！"
	icon_state = "royalkilt"

/obj/item/clothing/under/costume/skyrat/tac/irish
	name = "爱尔兰战术制服"
	desc = "防空导弹已经升空！这身行头散发着廉价烈酒和利比亚塑胶炸药的淡淡气味，还有人好心地在一个口袋里留了本书，可惜全是盖尔语！"
	icon_state = "tactical1"

/*
*	LUNAR AND JAPANESE CLOTHES
*/

/obj/item/clothing/under/costume/skyrat/qipao
	name = "旗袍"
	desc = "一件旗袍，古地球中国的女性在社交场合和农历新年时传统上会穿着它。"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/skyrat/qipao"
	post_init_icon_state = "qipao"
	body_parts_covered = CHEST|GROIN|LEGS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#2b2b2b"
	greyscale_config = /datum/greyscale_config/qipao
	greyscale_config_worn = /datum/greyscale_config/qipao/worn
	greyscale_config_worn_digi = /datum/greyscale_config/qipao/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/costume/skyrat/cheongsam
	name = "长衫"
	desc = "一件长衫，古地球中国的男性在社交场合和农历新年时传统上会穿着它。"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/skyrat/cheongsam"
	post_init_icon_state = "cheongsam"
	body_parts_covered = CHEST|GROIN|LEGS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#2b2b2b"
	greyscale_config = /datum/greyscale_config/cheongsam
	greyscale_config_worn = /datum/greyscale_config/cheongsam/worn
	greyscale_config_worn_digi = /datum/greyscale_config/cheongsam/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/costume/skyrat/yukata
	name = "浴衣"
	desc = "一件古地球日本传统的浴衣，通常在休闲场合穿着。"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/skyrat/yukata"
	post_init_icon_state = "yukata"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#2b2b2b"
	greyscale_config = /datum/greyscale_config/yukata
	greyscale_config_worn = /datum/greyscale_config/yukata/worn
	greyscale_config_worn_digi = /datum/greyscale_config/yukata/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/costume/skyrat/kamishimo
	name = "裃"
	desc = "一件古地球日本传统的裃，是武士阶层的正式礼服。"
	icon_state = "kamishimo"

/obj/item/clothing/under/costume/skyrat/kimono
	name = "华丽和服"
	desc = "一件古地球日本传统的和服。比浴衣更长，也更华丽。"
	icon_state = "kimono"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/costume_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION


/*
*	CHRISTMAS CLOTHES
*/

/obj/item/clothing/under/costume/skyrat/christmas
	name = "圣诞装"
	desc = "各位，你敢信吗？圣诞节。就在一光年之外！" //Lightyear is a measure of distance I hate it being used for this joke :(
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/skyrat/christmas"
	post_init_icon_state = "christmas_male"
	greyscale_colors = "#cc0f0f#c4c2c2"
	greyscale_config = /datum/greyscale_config/chrimbo
	greyscale_config_worn = /datum/greyscale_config/chrimbo/worn
	greyscale_config_worn_digi = /datum/greyscale_config/chrimbo/worn/digi
	body_parts_covered = CHEST|GROIN|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/costume/skyrat/christmas/green
	name = "绿色圣诞装"
	desc = "4:00，沉溺于自怜。4:30，凝视深渊。5:00，解决世界饥饿问题，谁都别告诉。5:30，去做有氧操；6:30，和我共进晚餐。这个我可不能再取消了。7:00，与自我厌恶搏斗。我的日程排满了。当然，要是把自我厌恶挪到 9 点，我还能赶得及躺回床上，盯着天花板，缓缓滑入疯狂。"
	icon_state = "/obj/item/clothing/under/costume/skyrat/christmas/green"
	greyscale_colors = "#1a991a#c4c2c2"

/obj/item/clothing/under/costume/skyrat/christmas/croptop
	name = "性感圣诞装"
	desc = "玛丽亚·凯莉的《圣诞节的唯一心愿》发行至今约 550 年，社会仍未从它带来的余波中真正恢复。有些人依旧在圣诞壁炉架上放一把枪，以防深夜时分听见她在自家屋顶上唱歌……"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/skyrat/christmas/croptop"
	post_init_icon_state = "christmas_female"
	greyscale_colors = "#cc0f0f#c4c2c2"
	greyscale_config = /datum/greyscale_config/chrimbo
	greyscale_config_worn = /datum/greyscale_config/chrimbo/worn
	greyscale_config_worn_digi = /datum/greyscale_config/chrimbo/worn/digi
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/costume/skyrat/christmas/croptop/green
	name = "性感绿色圣诞装"
	desc = "又蠢，又丑，还过时。要是找不到像样的衣服，我就不去了。"
	icon_state = "/obj/item/clothing/under/costume/skyrat/christmas/croptop/green"
	greyscale_colors = "#1a991a#c4c2c2"
