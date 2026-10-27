// For plushmium
/mob/living/basic/pet/plush
	name = "毛绒玩偶"
	desc = "一只活着的毛绒玩偶！"
	icon = 'icons/obj/toys/plushes.dmi'
	icon_state = "debug"
	icon_living = "debug"
	icon_dead = "debug"
	gold_core_spawnable = NO_SPAWN
	mob_biotypes = MOB_ORGANIC
	butcher_results = list(/obj/item/toy/plush = 1)

	verb_say = "吱吱叫道"
	verb_ask = "疑惑地吱吱叫道"
	verb_exclaim = "尖声吱吱叫道"
	verb_yell = "尖声吱吱叫道"

	response_help_simple = "轻抚"
	response_help_continuous = "轻抚"
	response_disarm_simple = "轻轻推开"
	response_disarm_continuous = "轻轻推开"
	response_harm_simple = "敲打"
	response_harm_continuous = "敲打"

	speed = 0
	pass_flags = PASSTABLE | PASSSTRUCTURE | PASSMOB

	maxHealth = 50
	health = 50
	melee_damage_type = STAMINA
	melee_damage_lower = 0
	melee_damage_upper = 1
	attack_verb_continuous = "啃咬"
	attack_verb_simple = "咬"
	death_message = "发出一声微弱的吱吱声，眼中的光采随之消失"

	attack_sound = 'sound/items/weapons/bite.ogg'

	habitable_atmos = null
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500
	pressure_resistance = 200

	ai_controller = /datum/ai_controller/basic_controller/talk

	faction = list("neutral")

	mob_size = MOB_SIZE_TINY

/mob/living/basic/pet/plush/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/can_be_held)

//shell that lets people turn into the plush or poll for ghosts
/obj/item/toy/plushie_shell
	name = "毛绒玩偶外壳"
	desc = "一个毛绒玩偶。它的眼睛似乎正盯着你看。有哪里不太对劲。"
	icon = 'icons/obj/toys/plushes.dmi'
	icon_state = "debug"
	var/obj/item/toy/plush/stored_plush = null

//attacking yourself transfers your mind into the plush!
/obj/item/toy/plushie_shell/attack_self(mob/user)
	if(user.mind)
		var/safety = (tgui_alert(user, "毛绒玩偶正死死盯着你，它似乎被诅咒了！（永久变成毛绒玩偶）", "抱它可不是个好主意。", list("抱住它！", "取消")))
		if(safety == "取消" || !in_range(src, user))
			return
		to_chat(user, span_userdanger("你抱住了那个诡异的毛绒玩偶。你这个傻瓜。"))

		//setup the mob
		var/mob/living/basic/pet/plush/new_plushie = new /mob/living/basic/pet/plush(user.loc)
		new_plushie.icon = src.icon
		new_plushie.icon_living = src.icon_state
		new_plushie.icon_dead = src.icon_state
		new_plushie.icon_state = src.icon_state
		new_plushie.name = src.name

		//make the mob sentient
		user.mind.transfer_to(new_plushie)

		//add sounds to mob
		new_plushie.AddComponent(/datum/component/squeak, stored_plush.squeak_override)
		if(length(stored_plush.squeak_override) > 0)
			new_plushie.attack_sound = stored_plush.squeak_override[1]
			new_plushie.attacked_sound = stored_plush.squeak_override[1]

		//take care of the user's old body and the old shell
		user.dust(drop_items = TRUE)
		qdel(src)

//low regen over time
/mob/living/basic/pet/plush/Life()
	if(stat)
		return
	if(health < maxHealth)
		heal_overall_damage(5) //Decent life regen, they're not able to hurt anyone so this shouldn't be an issue (butterbear for reference has 10 regen)
