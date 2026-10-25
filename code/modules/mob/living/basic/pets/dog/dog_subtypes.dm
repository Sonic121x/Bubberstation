//Less exciting dog breeds

/mob/living/basic/pet/dog/pug
	name = "\improper 巴哥犬"
	real_name = "巴哥犬"
	desc = "它是一只巴哥犬。"
	icon = 'icons/mob/simple/pets.dmi'
	icon_state = "pug"
	icon_living = "pug"
	icon_dead = "pug_dead"
	butcher_results = list(/obj/item/food/meat/slab/pug = 3)
	cult_icon_state = "pug_cult"
	gold_core_spawnable = FRIENDLY_SPAWN
	collar_icon_state = "pug"
	held_state = "pug"

/mob/living/basic/pet/dog/pug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_PUG, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/mob/living/basic/pet/dog/pug/mcgriff
	name = "麦格里夫"
	real_name = "麦格里夫"
	desc = "这只狗能闻出这附近有什么气味不对劲，而那股气味就是犯罪！"
	gold_core_spawnable = NO_SPAWN
	unique_pet = TRUE

/mob/living/basic/pet/dog/bullterrier
	name = "\improper 牛头梗"
	real_name = "牛头梗"
	desc = "它是一只牛头梗。"
	icon = 'icons/mob/simple/pets.dmi'
	icon_state = "bullterrier"
	icon_living = "bullterrier"
	icon_dead = "bullterrier_dead"
	butcher_results = list(/obj/item/food/meat/slab/corgi = 3) // Would feel redundant to add more new dog meats.
	gold_core_spawnable = FRIENDLY_SPAWN
	collar_icon_state = "bullterrier"
	held_state = "bullterrier"

/mob/living/basic/pet/dog/bullterrier/lavaland_party
	name = "圣尼古拉斯的得力助手"
	desc = "“做个乖孩子”专业的在读本科生。"
	habitable_atmos = null
	gold_core_spawnable = NO_SPAWN
	unique_pet = TRUE

/mob/living/basic/pet/dog/bullterrier/guarddog //hostile dog variant for space ruins
	name = "\improper 看门狗"
	real_name = "看门狗"
	desc = "一只凶悍的牛头梗。它看起来充满攻击性，领地意识极强。"
	collar_icon_state = "spiked"
	//slightly weaker than a bear, but not as slow
	health = 60
	maxHealth = 60
	obj_damage = 20
	melee_damage_lower = 10
	melee_damage_upper = 15
	wound_bonus = -25
	exposed_wound_bonus = 45
	sharpness = SHARP_EDGED
	gold_core_spawnable = HOSTILE_SPAWN
	faction = list(FACTION_HOSTILE)
	ai_controller = /datum/ai_controller/basic_controller/guarddog

/datum/ai_controller/basic_controller/guarddog
	behavior_tree_json = "code/modules/mob/living/basic/pets/dog/guarddog.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_AGGRO_RANGE = 7,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/mob/living/basic/pet/dog/breaddog //Most of the code originates from Cak
	name = "科本"
	real_name = "科本"
	desc = "它是一只由面包做成的狗。“宇宙绝对是半满的。”"
	icon_state = "breaddog"
	icon_living = "breaddog"
	icon_dead = "breaddog_dead"
	head_icon = 'icons/mob/clothing/head/pets_head.dmi'
	health = 50
	maxHealth = 50
	gender = NEUTER
	damage_coeff = list(BRUTE = 3, BURN = 3, TOX = 1, STAMINA = 1, OXY = 1)
	butcher_results = list(/obj/item/organ/brain = 1, /obj/item/organ/heart = 1, /obj/item/food/breadslice/plain = 3,  \
	/obj/item/food/meat/slab = 2)
	response_harm_continuous = "咬了一口"
	response_harm_simple = "咬一口"
	attacked_sound = 'sound/items/eatfood.ogg'
	held_state = "breaddog"
	worn_slot_flags = ITEM_SLOT_HEAD
	//just ensuring the mats contained by the dog when spawned are the same of when crafted
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 3)

/mob/living/basic/pet/dog/breaddog/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	var/obj/item/organ/brain/candidate = locate(/obj/item/organ/brain) in contents
	if(!candidate || !candidate.brainmob || !candidate.brainmob.mind)
		return
	candidate.brainmob.mind.transfer_to(src)
	to_chat(src, "[span_boldbig("你是一只面包狗！")]<b> 你是一只人见人爱的无害狗面包混合体。大家饿了都能咬你几口，但你的生命恢复得极快， \
	所以这通常无关紧要。除了这类伤害外，你异常坚韧，几乎根本死不了。你应该四处走走， \
	为空间站带来欢乐和免费的面包！	“我并不孤单，你也不是”</b>")
	var/default_name = "科本"
	var/new_name = sanitize_name(reject_bad_text(tgui_input_text(src, "你是 \the [src]。你想改成别的名字吗？", "更改名字", default_name, MAX_NAME_LEN)), cap_after_symbols = FALSE)
	if(new_name)
		to_chat(src, span_notice("你的名字现在是 <b>[new_name]</b>！"))
		name = new_name
		real_name = new_name

/mob/living/basic/pet/dog/breaddog/Life(seconds_per_tick = SSMOBS_DT)
	. = ..()
	if(!.) //dead or deleted
		return
	if(IS_UNCONSCIOUS_OR_CRIT(src)) // consciousness check
		return

	if(health < maxHealth)
		adjust_brute_loss(-4 * seconds_per_tick) //Fast life regen

	for(var/mob/living/carbon/humanoid_entities in view(3, src)) //Mood aura which stay as long you do not wear Sanallite as hat or carry(I will try to make it work with hat someday(obviously weaker than normal one))
		humanoid_entities.add_mood_event("kobun", /datum/mood_event/kobun)

/mob/living/basic/pet/dog/breaddog/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(user.combat_mode && user.reagents && !stat)
		user.reagents.add_reagent(/datum/reagent/consumable/nutriment, 0.4)
		user.reagents.add_reagent(/datum/reagent/consumable/nutriment/vitamin, 0.4)
