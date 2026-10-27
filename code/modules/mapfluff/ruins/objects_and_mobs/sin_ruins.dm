//These objects are used in the cardinal sin-themed ruins (i.e. Gluttony, Pride...)

/obj/effect/gluttony //Gluttony's wall: Used in the Gluttony ruin. Only lets the overweight through.
	name = "暴食之墙"
	desc = "唯有真正沉溺于口腹之欲者方可通行。"
	anchored = TRUE
	density = TRUE
	icon_state = "blob"
	icon = 'icons/mob/nonhuman-player/blob.dmi'
	color = rgb(145, 150, 0)

/obj/effect/gluttony/CanAllowThrough(atom/movable/mover, border_dir)//So bullets will fly over and stuff.
	. = ..()
	if(ishuman(mover))
		var/mob/living/carbon/human/H = mover
		if(H.nutrition >= NUTRITION_LEVEL_FAT)
			H.visible_message(span_warning("[H] 挤过了 [src]！"), span_notice("你见过、也吃过比这更糟糕的东西。"))
			return TRUE
		else
			to_chat(H, span_warning("光是看着 [src] 你就感到恶心。只有猪才逼得自己钻过去。"))
	if(istype(mover, /mob/living/basic/morph))
		return TRUE

//can't be bothered to do sloth right now, will make later

/obj/item/knife/envy //Envy's knife: Found in the Envy ruin. Attackers take on the appearance of whoever they strike.
	name = "嫉妒之刃"
	desc = "他们的成功将归于你。"
	icon = 'icons/obj/weapons/stabby.dmi'
	icon_state = "envyknife"
	inhand_icon_state = "envyknife"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	force = 18
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/bone=SMALL_MATERIAL_AMOUNT)
	hitsound = 'sound/items/weapons/bladeslice.ogg'

/obj/item/knife/envy/afterattack(atom/target, mob/living/carbon/human/user, list/modifiers, list/attack_modifiers)
	if(!istype(user) || !ishuman(target) || QDELETED(target))
		return

	var/mob/living/carbon/human/H = target
	if(user.real_name == H.dna.real_name)
		return

	user.real_name = H.dna.real_name
	H.dna.copy_dna(user.dna, COPY_DNA_SE|COPY_DNA_SPECIES)
	user.updateappearance(mutcolor_update=1)
	user.domutcheck()
	user.visible_message(span_warning("[user] 的外貌变成了 [H] 的模样！"), \
	span_bolddanger("[H] 觉得自己比你<i>强得多</i>。不会再这样了，再也没法这么想了。"))
