/obj/item/dnainjector
	name = "\improper DNA注射器"
	desc = "廉价的一次性自动注射器，向使用者注入DNA。"
	icon = 'icons/obj/medical/syringe.dmi'
	icon_state = "dnainjector"
	inhand_icon_state = "dnainjector"
	worn_icon_state = "pen"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY

	/// Modified to damage caused from injection, currently unused though
	var/damage_coeff = 1
	/// Adds all mutations in this list to the injected mob, activating it rather than mutating it if possible.
	var/list/add_mutations
	/// If the injected mob has any mutations in this list activated or mutated, they will be removed.
	var/list/remove_mutations
	/// Tracks if it's been used
	VAR_FINAL/used = FALSE
	/// Duration of the mutations added/activated or DNA changes. Does not affect removed mutations.
	var/duration = INFINITY
	/// A DNA datum that has its fields copied to the target on injection.
	var/datum/dna/stored_dna

/obj/item/dnainjector/Initialize(mapload, datum/dna/stored_dna, damage_coeff = 1)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	if(used)
		update_appearance()
	src.stored_dna = stored_dna
	src.damage_coeff = damage_coeff

/obj/item/dnainjector/Destroy()
	if(stored_dna?.holder)
		stack_trace("DNA injector got owned DNA somehow")
		stored_dna = null
	else
		QDEL_NULL(stored_dna)
	return ..()

/obj/item/dnainjector/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, used))
		update_appearance()

/obj/item/dnainjector/update_icon_state()
	. = ..()
	icon_state = inhand_icon_state = "[initial(icon_state)][used ? "0" : null]"

/obj/item/dnainjector/update_desc(updates)
	. = ..()
	desc = "[initial(desc)][used ? "这支已经用过了。" : null]"

/obj/item/dnainjector/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/item/dnainjector/proc/inject(mob/living/carbon/target, mob/user)
	if(!target.can_mutate())
		return FALSE
	if(target.stat == DEAD) //prevents dead people from having their DNA changed
		to_chat(user, span_notice("[target]已经死亡，无法修改其DNA。"))
		return FALSE
	for(var/removed_mutation in remove_mutations)
		target.dna.remove_mutation(removed_mutation, GLOB.standard_mutation_sources)

	for(var/datum/mutation/added_mutation as anything in add_mutations)
		if(added_mutation::warn_admins_on_inject && target != user && !ismonkey(target))
			message_admins("[ADMIN_LOOKUPFLW(user)]用含有[added_mutation::name]的[src]为[key_name_admin(target)]进行了注射。")
		if(target.dna.mutation_in_sequence(added_mutation))
			target.dna.activate_mutation(added_mutation)
			if(duration != INFINITY)
				addtimer(CALLBACK(target.dna, TYPE_PROC_REF(/datum/dna, remove_mutation), added_mutation, MUTATION_SOURCE_ACTIVATED), duration)
		else
			target.dna.add_mutation(added_mutation, MUTATION_SOURCE_MUTATOR)
			if(duration != INFINITY)
				addtimer(CALLBACK(target.dna, TYPE_PROC_REF(/datum/dna, remove_mutation), added_mutation, MUTATION_SOURCE_MUTATOR), duration)

	if(stored_dna)
		target.apply_status_effect(/datum/status_effect/temporary_transformation/dna_injector, duration, stored_dna)
	return TRUE

/obj/item/dnainjector/attack(mob/target, mob/user)
	if(!ISADVANCEDTOOLUSER(user))
		to_chat(user, span_warning("你的动作不够灵巧，无法这样做！"))
		return
	if(used)
		to_chat(user, span_warning("这支注射器已经用过了！"))
		return
	if(ishuman(target))
		var/mob/living/carbon/human/humantarget = target
		if (!humantarget.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE))
			return
	log_combat(user, target, "attempted to inject", src)

	if(target != user)
		target.visible_message(span_danger("[user]正试图用[src]为[target]注射！"), \
			span_userdanger("[user]正试图用[src]为你注射！"))
		if(!do_after(user, 3 SECONDS, target) || used)
			return
		target.visible_message(span_danger("[user]用[src]为[target]进行了注射！"), \
						span_userdanger("[user]用[src]为你进行了注射！"))

	else
		to_chat(user, span_notice("你用[src]给自己进行了注射。"))

	log_combat(user, target, "injected", src)

	if(!inject(target, user)) //Now we actually do the heavy lifting.
		to_chat(user, span_notice("[target]似乎没有兼容的DNA。"))
		return

	used = TRUE
	update_appearance()

/obj/item/dnainjector/timed
	duration = 60 SECONDS

/obj/item/dnainjector/timed/hulk
	name = "\improper DNA注射器（绿巨人）"
	desc = "让你高大强壮，但会带来严重的皮肤问题。"
	add_mutations = list(/datum/mutation/hulk)

/obj/item/dnainjector/timed/h2m
	name = "\improper DNA注射器（人类→猴子）"
	desc = "让你变成一只长满跳蚤的毛猴。"
	add_mutations = list(/datum/mutation/race)

/obj/item/dnainjector/activator
	name = "\improper DNA激活剂"
	desc = "如果受试者携带对应突变，注射后即可将其激活。"
	var/force_mutate = FALSE
	var/research = FALSE //Set to true to get expended and filled injectors for chromosomes
	var/filled = FALSE
	var/crispr_charge = FALSE // Look for viruses, look at symptoms, if research and Dormant DNA Activator or Viral Evolutionary Acceleration, set to true

/obj/item/dnainjector/activator/inject(mob/living/carbon/target, mob/user)
	if(!target.can_mutate())
		return FALSE
	for(var/mutation in add_mutations)
		var/datum/mutation/added_mutation = mutation
		if(istype(added_mutation, /datum/mutation))
			mutation = added_mutation.type
		if(!target.dna.activate_mutation(added_mutation))
			if(force_mutate)
				target.dna.add_mutation(added_mutation, MUTATION_SOURCE_MUTATOR)
		else if(research && target.client)
			filled = TRUE
		for(var/datum/disease/advance/disease in target.diseases)
			for(var/datum/symptom/symp in disease.symptoms)
				if((symp.type == /datum/symptom/genetic_mutation) || (symp.type == /datum/symptom/viralevolution))
					crispr_charge = TRUE
		log_combat(user, target, "[!force_mutate ? "failed to inject" : "injected"]", "[src] ([mutation])[crispr_charge ? " with CRISPR charge" : ""]")
	return TRUE

/// DNA INJECTORS

/obj/item/dnainjector/acidflesh
	name = "\improper DNA注射器（酸蚀血肉）"
	add_mutations = list(/datum/mutation/acidflesh)

/obj/item/dnainjector/antiacidflesh
	name = "\improper DNA注射器（抑制酸蚀血肉）"
	remove_mutations = list(/datum/mutation/acidflesh)

/obj/item/dnainjector/antenna
	name = "\improper DNA注射器（触角天线）"
	add_mutations = list(/datum/mutation/antenna)

/obj/item/dnainjector/antiantenna
	name = "\improper DNA注射器（抑制触角天线）"
	remove_mutations = list(/datum/mutation/antenna)

/obj/item/dnainjector/antiglow
	name = "\improper DNA注射器（吸光）"
	add_mutations = list(/datum/mutation/glow/anti)

/obj/item/dnainjector/removeantiglow
	name = "\improper DNA注射器（抑制吸光）"
	remove_mutations = list(/datum/mutation/glow/anti)

/obj/item/dnainjector/blindmut
	name = "\improper DNA注射器（失明）"
	desc = "让你什么也看不见。"
	add_mutations = list(/datum/mutation/blind)

/obj/item/dnainjector/antiblind
	name = "\improper DNA注射器（抑制失明）"
	desc = "这是奇迹！！！"
	remove_mutations = list(/datum/mutation/blind)

/obj/item/dnainjector/chameleonmut
	name = "\improper DNA注射器（变色龙）"
	add_mutations = list(/datum/mutation/chameleon)

/obj/item/dnainjector/antichameleon
	name = "\improper DNA注射器（抑制变色龙）"
	remove_mutations = list(/datum/mutation/chameleon)

/obj/item/dnainjector/chavmut
	name = "\improper DNA注射器（街头混混腔）"
	add_mutations = list(/datum/mutation/chav)

/obj/item/dnainjector/antichav
	name = "\improper DNA注射器（抑制街头混混腔）"
	remove_mutations = list(/datum/mutation/chav)

/obj/item/dnainjector/clumsymut
	name = "\improper DNA注射器（笨拙）"
	desc = "制造小丑跟班。"
	add_mutations = list(/datum/mutation/clumsy)

/obj/item/dnainjector/anticlumsy
	name = "\improper DNA注射器（抑制笨拙）"
	desc = "治安小丑请用这个。"
	remove_mutations = list(/datum/mutation/clumsy)

/obj/item/dnainjector/coughmut
	name = "\improper DNA注射器（咳嗽）"
	desc = "让你的喉咙发出可怕的声音。"
	add_mutations = list(/datum/mutation/cough)

/obj/item/dnainjector/anticough
	name = "\improper DNA注射器（抑制咳嗽）"
	desc = "让那难听的声音停下来。"
	remove_mutations = list(/datum/mutation/cough)

/obj/item/dnainjector/cryokinesis
	name = "\improper DNA注射器（控冰术）"
	add_mutations = list(/datum/mutation/cryokinesis)

/obj/item/dnainjector/anticryokinesis
	name = "\improper DNA注射器（抑制控冰术）"
	remove_mutations = list(/datum/mutation/cryokinesis)

/obj/item/dnainjector/deafmut
	name = "\improper DNA注射器（失聪）"
	desc = "抱歉，你说什么？"
	add_mutations = list(/datum/mutation/deaf)

/obj/item/dnainjector/antideaf
	name = "\improper DNA注射器（抑制失聪）"
	desc = "让你重新听见声音。"
	remove_mutations = list(/datum/mutation/deaf)

/obj/item/dnainjector/dwarf
	name = "\improper DNA注射器（侏儒症）"
	desc = "世界原来这么小。"
	add_mutations = list(/datum/mutation/dwarfism)

/obj/item/dnainjector/antidwarf
	name = "\improper DNA注射器（抑制侏儒症）"
	desc = "帮助你长得高大强壮。"
	remove_mutations = list(/datum/mutation/dwarfism)

/obj/item/dnainjector/elvismut
	name = "\improper DNA注射器（猫王）"
	add_mutations = list(/datum/mutation/elvis)

/obj/item/dnainjector/antielvis
	name = "\improper DNA注射器（抑制猫王）"
	remove_mutations = list(/datum/mutation/elvis)

/obj/item/dnainjector/epimut
	name = "\improper DNA注射器（癫痫）"
	desc = "摇啊摇，让整个房间都摇起来！"
	add_mutations = list(/datum/mutation/epilepsy)

/obj/item/dnainjector/antiepi
	name = "\improper DNA注射器（抑制癫痫）"
	desc = "让你不再抖得整个房间都在摇。"
	remove_mutations = list(/datum/mutation/epilepsy)

/obj/item/dnainjector/geladikinesis
	name = "\improper DNA注射器（凝雪术）"
	add_mutations = list(/datum/mutation/geladikinesis)

/obj/item/dnainjector/antigeladikinesis
	name = "\improper DNA注射器（抑制凝雪术）"
	remove_mutations = list(/datum/mutation/geladikinesis)

/obj/item/dnainjector/gigantism
	name = "\improper DNA注射器（巨人症）"
	add_mutations = list(/datum/mutation/gigantism)

/obj/item/dnainjector/antigigantism
	name = "\improper DNA注射器（抑制巨人症）"
	remove_mutations = list(/datum/mutation/gigantism)

/obj/item/dnainjector/glassesmut
	name = "\improper DNA注射器（近视）"
	desc = "让你不得不戴上呆板的眼镜。"
	add_mutations = list(/datum/mutation/nearsight)

/obj/item/dnainjector/antiglasses
	name = "\improper DNA注射器（抑制近视）"
	desc = "扔掉那副眼镜吧！"
	remove_mutations = list(/datum/mutation/nearsight)

/obj/item/dnainjector/glow
	name = "\improper DNA注射器（发光）"
	add_mutations = list(/datum/mutation/glow)

/obj/item/dnainjector/removeglow
	name = "\improper DNA注射器（抑制发光）"
	remove_mutations = list(/datum/mutation/glow)

/obj/item/dnainjector/hulkmut
	name = "\improper DNA注射器（绿巨人）"
	desc = "让你高大强壮，但会带来严重的皮肤问题。"
	add_mutations = list(/datum/mutation/hulk)

/obj/item/dnainjector/antihulk
	name = "\improper DNA注射器（抑制绿巨人）"
	desc = "治好你的绿皮肤。"
	remove_mutations = list(/datum/mutation/hulk)

/obj/item/dnainjector/h2m
	name = "\improper DNA注射器（人类→猴子）"
	desc = "让你变成一只长满跳蚤的毛猴。"
	add_mutations = list(/datum/mutation/race)

/obj/item/dnainjector/m2h
	name = "\improper DNA注射器（猴子→人类）"
	desc = "让你……少点毛。"
	remove_mutations = list(/datum/mutation/race)

/obj/item/dnainjector/illiterate
	name = "\improper DNA注射器（文盲）"
	add_mutations = list(/datum/mutation/illiterate)

/obj/item/dnainjector/antiilliterate
	name = "\improper DNA注射器（抑制文盲）"
	remove_mutations = list(/datum/mutation/illiterate)

/obj/item/dnainjector/insulated
	name = "\improper DNA注射器（绝缘）"
	add_mutations = list(/datum/mutation/insulated)

/obj/item/dnainjector/antiinsulated
	name = "\improper DNA注射器（抑制绝缘）"
	remove_mutations = list(/datum/mutation/insulated)

/obj/item/dnainjector/lasereyesmut
	name = "\improper DNA注射器（激光眼）"
	add_mutations = list(/datum/mutation/laser_eyes)

/obj/item/dnainjector/antilasereyes
	name = "\improper DNA注射器（抑制激光眼）"
	remove_mutations = list(/datum/mutation/laser_eyes)

/obj/item/dnainjector/mindread
	name = "\improper DNA注射器（读心）"
	add_mutations = list(/datum/mutation/mindreader)

/obj/item/dnainjector/antimindread
	name = "\improper DNA注射器（抑制读心）"
	remove_mutations = list(/datum/mutation/mindreader)

/obj/item/dnainjector/mutemut
	name = "\improper DNA注射器（失语）"
	add_mutations = list(/datum/mutation/mute)

/obj/item/dnainjector/antimute
	name = "\improper DNA注射器（抑制失语）"
	remove_mutations = list(/datum/mutation/mute)

/obj/item/dnainjector/olfaction
	name = "\improper DNA注射器（超凡嗅觉）"
	add_mutations = list(/datum/mutation/olfaction)

/obj/item/dnainjector/antiolfaction
	name = "\improper DNA注射器（抑制超凡嗅觉）"
	remove_mutations = list(/datum/mutation/olfaction)

/obj/item/dnainjector/piglatinmut
	name = "\improper DNA注射器（猪拉丁语）"
	add_mutations = list(/datum/mutation/piglatin)

/obj/item/dnainjector/antipiglatin
	name = "\improper DNA注射器（抑制猪拉丁语）"
	remove_mutations = list(/datum/mutation/piglatin)

/obj/item/dnainjector/paranoia
	name = "\improper DNA注射器（偏执）"
	add_mutations = list(/datum/mutation/paranoia)

/obj/item/dnainjector/antiparanoia
	name = "\improper DNA注射器（抑制偏执）"
	remove_mutations = list(/datum/mutation/paranoia)

/obj/item/dnainjector/pressuremut
	name = "\improper DNA注射器（气压适应）"
	desc = "赋予你火焰。"
	add_mutations = list(/datum/mutation/adaptation/pressure)

/obj/item/dnainjector/antipressure
	name = "\improper DNA注射器（抑制气压适应）"
	desc = "消除火焰。"
	remove_mutations = list(/datum/mutation/adaptation/pressure)

/obj/item/dnainjector/radioactive
	name = "\improper DNA注射器（放射性）"
	add_mutations = list(/datum/mutation/radioactive)

/obj/item/dnainjector/antiradioactive
	name = "\improper DNA注射器（抑制放射性）"
	remove_mutations = list(/datum/mutation/radioactive)

/obj/item/dnainjector/shock
	name = "\improper DNA注射器（电击之触）"
	add_mutations = list(/datum/mutation/shock)

/obj/item/dnainjector/antishock
	name = "\improper DNA注射器（抑制电击之触）"
	remove_mutations = list(/datum/mutation/shock)

/obj/item/dnainjector/spastic
	name = "\improper DNA注射器（肌肉痉挛）"
	add_mutations = list(/datum/mutation/spastic)

/obj/item/dnainjector/antispastic
	name = "\improper DNA注射器（抑制肌肉痉挛）"
	remove_mutations = list(/datum/mutation/spastic)

/obj/item/dnainjector/spatialinstability
	name = "\improper DNA注射器（空间不稳定）"
	add_mutations = list(/datum/mutation/badblink)

/obj/item/dnainjector/antispatialinstability
	name = "\improper DNA注射器（抑制空间不稳定）"
	remove_mutations = list(/datum/mutation/badblink)

/obj/item/dnainjector/stuttmut
	name = "\improper DNA注射器（口吃）"
	desc = "让你结、结、结巴。"
	add_mutations = list(/datum/mutation/nervousness)

/obj/item/dnainjector/antistutt
	name = "\improper DNA注射器（抑制口吃）"
	desc = "治好你的言语障碍。"
	remove_mutations = list(/datum/mutation/nervousness)

/obj/item/dnainjector/swedishmut
	name = "\improper DNA注射器（瑞典腔）"
	add_mutations = list(/datum/mutation/swedish)

/obj/item/dnainjector/antiswedish
	name = "\improper DNA注射器（抑制瑞典腔）"
	remove_mutations = list(/datum/mutation/swedish)

/obj/item/dnainjector/telemut
	name = "\improper DNA注射器（念力）"
	desc = "超级大脑的念力！"
	add_mutations = list(/datum/mutation/telekinesis)

/obj/item/dnainjector/telemut/darkbundle
	name = "\improper DNA注射器"
	desc = "很好。让仇恨流遍全身。"

/obj/item/dnainjector/antitele
	name = "\improper DNA注射器（抑制念力）"
	desc = "让你无法运用意念控制物体。"
	remove_mutations = list(/datum/mutation/telekinesis)

/obj/item/dnainjector/firemut
	name = "\improper DNA注射器（温度适应）"
	desc = "赋予你火焰。"
	add_mutations = list(/datum/mutation/adaptation/thermal)

/obj/item/dnainjector/antifire
	name = "\improper DNA注射器（抑制温度适应）"
	desc = "消除火焰。"
	remove_mutations = list(/datum/mutation/adaptation/thermal)

/obj/item/dnainjector/thermal
	name = "\improper DNA注射器（热成像视觉）"
	add_mutations = list(/datum/mutation/thermal)

/obj/item/dnainjector/antithermal
	name = "\improper DNA注射器（抑制热成像视觉）"
	remove_mutations = list(/datum/mutation/thermal)

/obj/item/dnainjector/tourmut
	name = "\improper DNA注射器（抽动秽语综合征）"
	desc = "让你患上严重的抽动秽语综合征。"
	add_mutations = list(/datum/mutation/tourettes)

/obj/item/dnainjector/antitour
	name = "\improper DNA注射器（抑制抽动秽语综合征）"
	desc = "治愈抽动秽语综合征。"
	remove_mutations = list(/datum/mutation/tourettes)

/obj/item/dnainjector/twoleftfeet
	name = "\improper DNA注射器（两只左脚）"
	add_mutations = list(/datum/mutation/extrastun)

/obj/item/dnainjector/antitwoleftfeet
	name = "\improper DNA注射器（抑制两只左脚）"
	remove_mutations = list(/datum/mutation/extrastun)

/obj/item/dnainjector/unintelligiblemut
	name = "\improper DNA注射器（言语不清）"
	add_mutations = list(/datum/mutation/unintelligible)

/obj/item/dnainjector/antiunintelligible
	name = "\improper DNA注射器（抑制言语不清）"
	remove_mutations = list(/datum/mutation/unintelligible)

/obj/item/dnainjector/void
	name = "\improper DNA注射器（虚空磁体）"
	add_mutations = list(/datum/mutation/void)

/obj/item/dnainjector/antivoid
	name = "\improper DNA注射器（抑制虚空磁体）"
	remove_mutations = list(/datum/mutation/void)

/obj/item/dnainjector/xraymut
	name = "\improper DNA注射器（透视）"
	desc = "你终于能看见舰长在干什么了。"
	add_mutations = list(/datum/mutation/xray)

/obj/item/dnainjector/antixray
	name = "\improper DNA注射器（抑制透视）"
	desc = "让你看得更费劲。"
	remove_mutations = list(/datum/mutation/xray)

/obj/item/dnainjector/wackymut
	name = "\improper DNA注射器（滑稽）"
	add_mutations = list(/datum/mutation/wacky)

/obj/item/dnainjector/antiwacky
	name = "\improper DNA注射器（抑制滑稽）"
	remove_mutations = list(/datum/mutation/wacky)

/obj/item/dnainjector/webbing
	name = "\improper DNA注射器（织网）"
	add_mutations = list(/datum/mutation/webbing)

/obj/item/dnainjector/antiwebbing
	name = "\improper DNA注射器（抑制织网）"
	remove_mutations = list(/datum/mutation/webbing)

/obj/item/dnainjector/clever
	name = "\improper DNA注射器（聪慧）"
	add_mutations = list(/datum/mutation/clever)

/obj/item/dnainjector/anticlever
	name = "\improper DNA注射器（抑制聪慧）"
	remove_mutations = list(/datum/mutation/clever)
