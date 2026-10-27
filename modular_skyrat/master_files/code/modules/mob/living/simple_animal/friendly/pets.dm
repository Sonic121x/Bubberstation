/mob/living/basic/pet/cat/clown
	name = "小丑猫"
	desc = "一只被引入小丑星的有趣小生物，深受数百万人喜爱。"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "clowncat"
	icon_living = "clowncat"
	icon_dead = "clowncat_dead"
	speak_emote = list("呼噜", "鸣笛", "喵喵")
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	unsuitable_atmos_damage = 0.5
	butcher_results = list(
		/obj/item/food/meat/slab = 1,
		/obj/item/organ/ears/cat = 1,
		/obj/item/organ/tail/cat = 1,
		/obj/item/clothing/mask/gas/clown_hat = 1,

	)
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "请求别拿这个开玩笑"
	response_disarm_simple = "请求别拿这个开玩笑"
	response_harm_continuous = "扔西红柿"
	response_harm_simple = "扔西红柿"
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	gold_core_spawnable = FRIENDLY_SPAWN
	collar_icon_state = "clowncat"
	ai_controller = /datum/ai_controller/basic_controller/cat/clown
	held_state = "cat2"
	attack_verb_continuous = "鸣笛"
	attack_verb_simple = "鸣笛"
	attack_sound = 'sound/items/bikehorn.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW

/datum/ai_controller/basic_controller/cat/clown


/mob/living/basic/pet/cat/mime
	name = "默剧猫"
	desc = "几乎完全隐形，这小家伙吃的老鼠你连看都看不见！"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "catmime"
	icon_living = "catmime"
	icon_dead = "catmime_dead"
	ai_controller = /datum/ai_controller/basic_controller/cat/mime
	speak_emote = list("...",)
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	unsuitable_atmos_damage = 0.5
	butcher_results = list(
		/obj/item/food/meat/slab = 1,
		/obj/item/organ/ears/cat = 1,
		/obj/item/organ/tail/cat = 1,
		/obj/item/clothing/mask/gas/mime = 1,
	)

/datum/ai_controller/basic_controller/cat/mime


/mob/living/basic/pet/cat/tiger
	name = "老虎猫"
	desc = "一只纸做成的老虎。"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	ai_controller = /datum/ai_controller/basic_controller/cat/tiger
	icon_state = "tiger"
	icon_living = "tiger"
	icon_dead = "tiger_dead"
	speak_emote = list("咆哮","怒吼", "呼噜", "喵喵",)
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	unsuitable_atmos_damage = 0.5
	butcher_results = list(
		/obj/item/food/meat/slab = 1,
		/obj/item/organ/ears/cat = 1,
		/obj/item/organ/tail/cat = 1,
		/obj/item/clothing/head/pelt/tiger = 1,
	)

/datum/ai_controller/basic_controller/cat/tiger

/mob/living/basic/carp/clarp
	name = "小丑鲤鱼"
	desc = "一条太空龙吞下了小丑空间站，味道挺滑稽。于是就有了它。"
	faction = list(FACTION_NEUTRAL)
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_dead = "clarp_dead"
	icon_gib = "clarp_gib"
	icon_living = "clarp"
	icon_state = "clarp"
	greyscale_config = NONE

/mob/living/basic/carp/petcarp
	faction = list(FACTION_NEUTRAL)

/mob/living/basic/pet/fox/redpanda
	name = "小熊猫"
	desc = "真够傻的。"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "red_panda"
	icon_living = "red_panda"
	icon_dead = "dead_panda"
	speak_emote = list("啾啾", "吭嘎")
	butcher_results = list(/obj/item/food/meat/slab = 3)
	gold_core_spawnable = FRIENDLY_SPAWN
	held_state = "fox"
	melee_damage_lower = 5
	melee_damage_upper = 5
	attack_verb_continuous = "咬"
	attack_verb_simple = "咬"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	ai_controller = /datum/ai_controller/basic_controller/fox/docile //he's a nice boy

/mob/living/basic/pet/dog/corgi/robocorgo
	name = "\improper 机械柯基"
	real_name = "corgi"
	desc = "一只经过各种机械改造的柯基。也是 E-N 生命周期的第一阶段。"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "robocorgi"
	icon_living = "robocorgi"
	icon_dead = "robocorgi_dead"
	held_state = "corgi"
	butcher_results = list(/obj/item/food/meat/slab/corgi = 3, /obj/item/stack/sheet/animalhide/corgi = 1)
	gold_core_spawnable = FRIENDLY_SPAWN
	collar_icon_state = "robocorgi"

