/datum/augment_item/organ
	category = AUGMENT_CATEGORY_ORGANS

/datum/augment_item/organ/apply(mob/living/carbon/human/human_holder, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup)
		return

	var/obj/item/organ/organ_path = path // cast this to an organ so we can get the slot from it using initial()

	if(slot == AUGMENT_SLOT_BRAIN)
		var/obj/item/organ/brain/old_brain = human_holder.get_organ_slot(ORGAN_SLOT_BRAIN)
		var/obj/item/organ/brain/new_brain = new organ_path()

		var/datum/mind/holder_mind = human_holder.mind

		new_brain.modular_persistence = old_brain.modular_persistence
		new_brain.modular_persistence?.owner = new_brain
		old_brain.modular_persistence = null

		new_brain.copy_traits_from(old_brain)
		new_brain.Insert(human_holder, special = TRUE)
		old_brain.moveToNullspace()  //for some reason it doesn't want to be deleted. So I'm using this hack method until it can be figured out why. But, it works!
		STOP_PROCESSING(SSobj, old_brain)

		if(!holder_mind)
			return

		holder_mind.transfer_to(human_holder, TRUE)
	else
		var/obj/item/organ/new_organ = new path()

		new_organ.copy_traits_from(human_holder.get_organ_slot(initial(organ_path.slot)))
		new_organ.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

//BUBBER EDIT - New brain
//BRAINS
/datum/augment_item/organ/brain
	slot = AUGMENT_SLOT_BRAIN
	cost = 1 // while a sidegrade, there are genuine applications for having a vanilla brain

/datum/augment_item/organ/brain/cortical
	name = "皮层强化脑"
	slot = AUGMENT_SLOT_BRAIN
	path = /obj/item/organ/brain/cybernetic/cortical
	cost = 1 // technically a downgrade in most applications, but has uses.

/datum/augment_item/organ/brain/surplus
	name = "廉价义体强化脑"
	slot = AUGMENT_SLOT_BRAIN
	path = /obj/item/organ/brain/cybernetic/surplus
	cost = -1

//HEARTS
/datum/augment_item/organ/heart
	slot = AUGMENT_SLOT_HEART

/datum/augment_item/organ/heart/cybernetic
	name = "基础义体心脏"
	path = /obj/item/organ/heart/cybernetic

//LUNGS
/datum/augment_item/organ/lungs
	slot = AUGMENT_SLOT_LUNGS

/datum/augment_item/organ/lungs/normal
	name = "普通肺"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs
	cost = 1 // if you dont have normal lungs, still an investment to switch it out

/datum/augment_item/organ/lungs/hot
	name = "耐热适应肺"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/adaptive/hot
	cost = 1

/datum/augment_item/organ/lungs/cold
	name = "耐寒适应肺"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/adaptive/cold
	cost = 1
/datum/augment_item/organ/lungs/toxin
	name = "耐毒素适应肺"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/toxin
	cost = 1
/datum/augment_item/organ/lungs/oxy
	name = "低氧适应肺"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/oxy
	cost = 1
/datum/augment_item/organ/lungs/cybernetic
	name = "基础义体肺"
	path = /obj/item/organ/lungs/cybernetic

/datum/augment_item/organ/lungs/coldcyber
	name = "义体耐寒改造肺"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/adaptive/cold/cybernetic
	cost = 1

/datum/augment_item/organ/lungs/hotcyber
	name = "义体耐热改造肺"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/adaptive/hot/cybernetic
	cost = 1

/datum/augment_item/organ/lungs/toxincyber
	name = "义体耐毒素改造肺"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/toxin/cybernetic
	cost = 1

/datum/augment_item/organ/lungs/oxycyber
	name = "义体低氧改造肺"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/oxy/cybernetic
	cost = 1
//LIVERS
/datum/augment_item/organ/liver
	slot = AUGMENT_SLOT_LIVER

/datum/augment_item/organ/liver/cybernetic
	name = "基础义体肝脏"
	path = /obj/item/organ/liver/cybernetic

//STOMACHES
/datum/augment_item/organ/stomach
	slot = AUGMENT_SLOT_STOMACH

/datum/augment_item/organ/stomach/cybernetic
	name = "基础义体胃"
	path = /obj/item/organ/stomach/cybernetic

//EYES
/datum/augment_item/organ/eyes
	slot = AUGMENT_SLOT_EYES

/datum/augment_item/organ/eyes/cybernetic
	name = "义体眼"
	path = /obj/item/organ/eyes/robotic

/datum/augment_item/organ/eyes/cyberneticbasic
	name = "基础义体眼"
	path = /obj/item/organ/eyes/robotic/basic
	cost = -1 // Sensitive to flashes like moth eyes. Less health?.

/datum/augment_item/organ/eyes/moth
	name = "蛾眼"
	path = /obj/item/organ/eyes/moth

/datum/augment_item/organ/eyes/cybernetic/moth
	name = "机械蛾眼"
	path = /obj/item/organ/eyes/robotic/moth

/datum/augment_item/organ/eyes/cybernetic/mothbasic
	name = "基础机械蛾眼"
	path = /obj/item/organ/eyes/robotic/basic/moth
	cost = -1 // Less health than standard.

/datum/augment_item/organ/eyes/highlumi
	name = "高亮度眼"
	path = /obj/item/organ/eyes/robotic/glow
	allowed_biotypes = MOB_ORGANIC|MOB_ROBOTIC
	cost = 1

/datum/augment_item/organ/eyes/highlumi/moth
	name = "高亮度蛾眼"
	path = /obj/item/organ/eyes/robotic/glow/moth
	allowed_biotypes = MOB_ORGANIC|MOB_ROBOTIC
	cost = 1

//TONGUES
/datum/augment_item/organ/tongue
	slot = AUGMENT_SLOT_TONGUE

/datum/augment_item/organ/tongue/normal
	name = "有机舌头"
	path = /obj/item/organ/tongue/human

/datum/augment_item/organ/tongue/robo
	name = "机械发声盒"
	path = /obj/item/organ/tongue/robot

/datum/augment_item/organ/tongue/robo/forked
	name = "机械蜥蜴发声盒"
	path = /obj/item/organ/tongue/lizard/robot

/datum/augment_item/organ/tongue/cybernetic
	name = "义体舌"
	path = /obj/item/organ/tongue/cybernetic

/datum/augment_item/organ/tongue/cybernetic/forked
	name = "分叉义体舌"
	path = /obj/item/organ/tongue/lizard/cybernetic

/datum/augment_item/organ/tongue/forked
	name = "分叉舌"
	path = /obj/item/organ/tongue/lizard

/datum/augment_item/organ/tongue/akula
	name = "水生舌"
	path = /obj/item/organ/tongue/akula

/datum/augment_item/organ/tongue/moth
	name = "颤动舌"
	path = /obj/item/organ/tongue/moth

/datum/augment_item/organ/tongue

//EARS
/datum/augment_item/organ/ears
	slot = AUGMENT_SLOT_EARS

/datum/augment_item/organ/ears/cybernetic
	name = "基础义体耳"
	path = /obj/item/organ/ears/cybernetic

