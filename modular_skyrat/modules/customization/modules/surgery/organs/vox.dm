/obj/item/organ/lungs/nitrogen
	name = "氮气肺"
	desc = "一副用于呼吸氮气的肺。"
	safe_oxygen_min = 0	//Dont need oxygen
	safe_oxygen_max = 2 //But it is quite toxic
	safe_nitro_min = 4 // Atleast 4 nitrogen
	oxy_damage_type = TOX
	oxy_breath_dam_min = 6
	oxy_breath_dam_max = 20

/obj/item/organ/lungs/nitrogen/vox
	name = "Vox 肺"
	desc = "里面塞满了灰尘……哇哦。"
	icon_state = "lungs-c"

	cold_level_1_threshold = 0 // Vox should be able to breathe in cold gas without issues?
	cold_level_2_threshold = 0
	cold_level_3_threshold = 0
	organ_flags = ORGAN_ROBOTIC | ORGAN_SYNTHETIC_FROM_SPECIES

/obj/item/organ/lungs/nitrogen/slime_lungs
	name = "氮基液泡"
	desc = "传统的史莱姆人肺。这一副靠氮气运转。"
	icon_state = "lungs-plasma"

	oxy_damage_type = BRUTE
	oxy_breath_dam_min = 6
	oxy_breath_dam_max = 20
