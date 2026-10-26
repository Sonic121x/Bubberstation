/obj/item/autosurgeon/bodypart
	name = "肢体升级自动手术器"
	desc = "一台能精准替换你肢体的装置。"

	var/bodypart_type = /obj/item/bodypart

	var/starting_bodypart //The bodypart we come with

	var/obj/item/bodypart/storedbodypart

/obj/item/autosurgeon/bodypart/Initialize(mapload)
	. = ..()
	if(starting_bodypart)
		insert_bodypart(new starting_bodypart(src))

/obj/item/autosurgeon/bodypart/proc/insert_bodypart(obj/item/I)
	storedbodypart = I
	I.forceMove(src)
	name = "[initial(name)] ([storedbodypart.name])"

/obj/item/autosurgeon/bodypart/attack_self(mob/user)//when the object it used...
	if(!uses)
		to_chat(user, span_alert("[src]已经用过了。工具已经变钝，无法再次启动。"))
		return
	if(!storedbodypart)
		to_chat(user, span_alert("[src]目前没有装载植入物。"))
		return
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user

	var/obj/item/bodypart/oldBP = H.get_bodypart(storedbodypart.body_zone)

	if(oldBP)
		to_chat(H, span_warning("[src]切除了你的[oldBP.name]！"))
		oldBP.dismember()

	user.visible_message(span_notice("[H]按下[src]上的按钮，传来一阵短促的机械声。"), span_notice("[src]刺入你的身体，你感到一阵刺痛。"))

	if(!storedbodypart.try_attach_limb(H))
		to_chat(H, span_warning("[src]未能接上[storedbodypart]！"))
		return

	playsound(get_turf(H), 'sound/items/weapons/circsawhit.ogg', 50, TRUE)
	storedbodypart = null
	name = initial(name)
	uses--
	if(!uses)
		desc = "[initial(desc)]看起来已经用完了。"

/obj/item/autosurgeon/bodypart/attackby(obj/item/I, mob/user, params)
	if(istype(I, bodypart_type))
		if(storedbodypart)
			to_chat(user, span_alert("[src]已经装载了植入物。"))
			return
		else if(!uses)
			to_chat(user, span_alert("[src]已经用完了。"))
			return
		if(!user.transferItemToLoc(I, src))
			return
		storedbodypart = I
		to_chat(user, span_notice("你将[I]装入[src]。"))
	else
		return ..()

/obj/item/autosurgeon/bodypart/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(!storedbodypart)
		to_chat(user, span_warning("[src]内没有可供取出的植入物！"))
	else
		var/atom/drop_loc = user.drop_location()
		for(var/J in src)
			var/atom/movable/AM = J
			AM.forceMove(drop_loc)

		to_chat(user, span_notice("你从[src]中取出了[storedbodypart]。"))
		I.play_tool_sound(src)
		storedbodypart = null
		uses--
		if(!uses)
			desc = "[initial(desc)]看起来已经用完了。"
	return TRUE
