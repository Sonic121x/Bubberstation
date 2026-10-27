/mob/living/basic/pet/cat/cak
	name = "琪琪"
	desc = "她是一只由蛋糕做成的猫。"
	icon_state = "cak"
	icon_living = "cak"
	icon_dead = "cak_dead"
	health = 50
	maxHealth = 50
	gender = FEMALE
	butcher_results = list(
		/obj/item/organ/brain = 1,
		/obj/item/organ/heart = 1,
		/obj/item/food/cakeslice/birthday = 3,
		/obj/item/food/meat/slab = 2
	)
	response_harm_continuous = "咬了一口"
	response_harm_simple = "咬一口"
	ai_controller = /datum/ai_controller/basic_controller/cat/cake
	attacked_sound = 'sound/items/eatfood.ogg'
	death_message = "失去了虚假的生命，瘫倒在地！"
	death_sound = SFX_BODYFALL
	held_state = "cak"
	can_interact_with_stove = TRUE
	//just ensuring the mats contained by the cat when spawned are the same of when crafted
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 3)

/mob/living/basic/pet/cat/cak/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/regenerator,\
		regeneration_delay = 1 SECONDS,\
		brute_per_second = 5,\
		outline_colour = COLOR_PINK,\
	)
	var/static/list/on_consume = list(
		/datum/reagent/consumable/nutriment = 0.4,
		/datum/reagent/consumable/nutriment/vitamin = 0.4,
	)
	AddElement(/datum/element/consumable_mob, reagents_list = on_consume)

/mob/living/basic/pet/cat/cak/add_cell_sample()
	return

/mob/living/basic/pet/cat/cak/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	var/obj/item/organ/brain/candidate = locate(/obj/item/organ/brain) in contents
	if(isnull(candidate?.brainmob?.mind))
		return
	var/datum/mind/candidate_mind = candidate.brainmob.mind
	candidate_mind.transfer_to(src)
	candidate_mind.grab_ghost()
	to_chat(src, "[span_boldbig("你是一只蛋糕猫！")]<b> 你是一只人见人爱的无害猫蛋糕混合体。大家饿了都能咬你几口，但你的生命恢复得极快， \
	所以这通常无关紧要。除了这类伤害外，你异常坚韧，几乎根本死不了。你应该四处走走， \
	为空间站带来欢乐和免费的蛋糕！</b>")
	var/default_name = initial(name)
	var/new_name = sanitize_name(reject_bad_text(tgui_input_text(src, "你是 \the [src]。你想改成别的名字吗？", "更改名字", default_name, MAX_NAME_LEN)), cap_after_symbols = FALSE)
	if(new_name)
		to_chat(src, span_notice("你的名字现在是 <b>[new_name]</b>！"))
		name = new_name

/mob/living/basic/pet/cat/cak/spin(spintime, speed)
	. = ..()
	for(var/obj/item/food/donut/target in oview(1, src))
		if(!target.is_decorated)
			target.decorate_donut()
