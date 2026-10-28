/obj/item/organ/wings/robotic/virtual
	name = "虚拟化翅膀"
	desc = "这些翅膀通过伸出的长投影臂生成硬光羽毛，能够产生升力。"
	organ_flags = ORGAN_ROBOTIC
	sprite_accessory_override = /datum/sprite_accessory/wings/robotic/virtual

// No free fall softening for everyone
/obj/item/organ/wings/can_soften_fall()
	return FALSE
