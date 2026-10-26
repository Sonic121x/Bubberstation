// No free fall softening for everyone - but functional wings get it
/obj/item/organ/wings/functional/can_soften_fall()
	return TRUE

/obj/item/organ/wings/functional/robotic/virtual
	name = "虚拟化翅膀"
	desc = "这些翅膀通过伸出的长投影臂生成硬光羽毛，能够产生升力。"
	organ_flags = ORGAN_ROBOTIC
	sprite_accessory_override = /datum/sprite_accessory/wings/robotic/virtual
