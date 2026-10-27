/obj/item/pet_food
	name = "通用宠物零食"
	desc = "对你的宠物和现实来说都太过平淡。你不该看见这个。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "skeletonmeat"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/pet_food/attack(mob/living/basic/target_pet, mob/living/user)
	if(user.combat_mode)
		return
	if(!istype(target_pet, /mob/living/basic))
		to_chat(user, span_warning("这种零食只能喂给基础宠物！"))
		return
	if(target_pet.stat)
		to_chat(user, span_warning("宠物已经死了！"))
		return



/obj/item/pet_food/pet_space_treat
	name = "宠物太空防护零食"
	desc = "适合可爱伙伴的美味零食，能让它们抵御恶劣的太空真空！（若宠物实际上无法承受太空真空，保修无效。）"
	icon = 'modular_zubbers/icons/obj/pet_snacks.dmi'
	icon_state = "pet_space_treat"

/obj/item/pet_food/pet_space_treat/attack(mob/living/basic/target_pet, mob/user)
	..()
	if(HAS_TRAIT(target_pet, TRAIT_PET_SPACE_TREAT))
		to_chat(user, span_warning("这只宠物已经吃过太空零食！"))
		return
	if(!target_pet.unsuitable_atmos_damage || !target_pet.minimum_survivable_temperature || !target_pet.maximum_survivable_temperature)
		to_chat(user, span_warning("这种零食不适合这只宠物！"))
		return
	ADD_TRAIT(target_pet, TRAIT_PET_SPACE_TREAT, user)
	target_pet.RemoveElement(/datum/element/atmos_requirements, target_pet.habitable_atmos, target_pet.unsuitable_atmos_damage)
	target_pet.RemoveElement(/datum/element/body_temp_sensitive, target_pet.minimum_survivable_temperature, target_pet.maximum_survivable_temperature, target_pet.unsuitable_cold_damage, target_pet.unsuitable_heat_damage)
	target_pet.unsuitable_atmos_damage = 0
	target_pet.minimum_survivable_temperature = TCMB
	target_pet.maximum_survivable_temperature = T0C + 40
	target_pet.apply_atmos_requirements(TRUE)
	target_pet.apply_temperature_requirements(TRUE)
	target_pet.desc += span_notice("\n它似乎更能抵御太空真空了。")
	to_chat(user, span_notice("你把零食喂给[target_pet]，它迅速吞了下去。"))
	qdel(src)
	return
