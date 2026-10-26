/// A space-worthy skinsuit to be combined with the skinsuit armor
/obj/item/clothing/under/skinsuit
	name = "\improper 虚空穿越者星裙"
	desc = "“虚空穿越者”型星裙是一种沿用已久的模板，大多数阿库拉太空服都是以它为基础制作的。 \n\
		这套 EVA 服是一件紧身的连体衣物，专为在使用喷气背包或任何推进器时保持灵活与机动而设计； \
		相比大多数 EVA 作业人员，阿库拉人更偏爱熟悉的游泳式动作。“虚空穿越者”将传统岸裙所采用的同类技术加以运用， \
		利用高科技面料与水泵在阿库拉人的身体上施加压力。 \n\n\
		通常还会搭配一顶岸裙头盔，并与第三方氧气源连接以供呼吸， \
		而衣服上的开放孔隙则能让内部水分通过汗液蒸发为身体降温。 \n\
		这些服装在轨道作业人员中口碑极佳，因为它们几乎不会妨碍活动，而且只需塞进任何球形头盔里就能轻松收纳。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi'
	icon_state = "skinsuit"
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/clothing_under/wetsuit
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	resistance_flags = NONE
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/skinsuit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wetsuit)

/obj/item/clothing/under/skinsuit/Destroy()
	qdel(GetComponent(/datum/component/wetsuit))
	. = ..()

/obj/item/clothing/head/helmet/space/skinsuit_helmet
	name = "\improper 星裙头盔"
	desc = "一种经过强化的“玻璃”，尤其常为阿库拉登舰小队所用；它源自岸裙上的同类部件，专为经久耐用而造。 \n\
		它采用夹层玻璃，而非民用型号常见的“弹性玻璃”，这不仅带来了耐用性，还能在发生碎裂时保持整体不散； \
		并使残余部分留在框架内。这类头盔通常由多达四层材料制成，无意中让穿戴者的面孔变得难以辨认。 \n\n\
		此外，中间层赋予头盔隔音性能以及阻挡紫外线的能力。 \
		与民用同类产品相比，这些头盔以格外不适著称；内部狭小，且只有最简陋的温控技术。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/akula.dmi'
	icon_state = "skinsuithelmet"

/obj/item/clothing/head/helmet/space/skinsuit_helmet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wetsuit)

/obj/item/clothing/head/helmet/space/skinsuit_helmet/Destroy()
	qdel(GetComponent(/datum/component/wetsuit))
	. = ..()

/obj/item/clothing/suit/armor/riot/skinsuit_armor
	name = "\improper 碎岸者装甲"
	desc = "“碎岸者”型星裙装甲是为效力于新公国的阿库拉登舰小队开发的。 \
		碎岸者装甲在保持坚韧与机动的同时，主要针对近距离破舱作战而设计。 \n\n\
		由于穿戴者手臂与腿部周围的装甲较为稀疏，登舰小队在舱体着陆后会被鼓励做一件事： \
		发挥他们的高速机动，让敌人变成过去式。这套装甲对远程武器相当坚韧， \
		但所用合金主要是为了抵御登舰斧、长矛以及其他常见海盗克星武器的劈砍而构造的。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/akula.dmi'
	icon_state = "skinsuitarmor"
	base_icon_state = "skinsuitarmor"


/obj/item/clothing/suit/armor/riot/skinsuit_armor/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_ICLOTHING)
		return

	check_tail(user)
	update_appearance()

/obj/item/clothing/suit/armor/riot/skinsuit_armor/dropped(mob/user)
	. = ..()
	check_tail(user)
	update_appearance()

/// Pick an icon_state that matches nicer with tails if one is found on the wearer
/obj/item/clothing/suit/armor/riot/skinsuit_armor/proc/check_tail(mob/living/carbon/human/user)
	icon_state = base_icon_state
	if(!user.dna.species.mutant_bodyparts[FEATURE_TAIL_GENERIC])
		return

	icon_state = "skinsuitarmor_cutback"
