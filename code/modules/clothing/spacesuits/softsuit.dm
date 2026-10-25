	//NASA Voidsuit
/obj/item/clothing/head/helmet/space/nasavoid
	name = "\improper NASA 太空头盔"
	desc = "一顶老旧的深红色太空头盔，由 NASA 中央指挥部支部设计。"
	icon_state = "void"
	inhand_icon_state = "void_helmet"

/obj/item/clothing/suit/space/nasavoid
	name = "\improper NASA 太空服"
	icon_state = "void"
	inhand_icon_state = "void_suit"
	desc = "一套老旧的深红色太空服，由 NASA 中央指挥部支部设计。"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/multitool)

/obj/item/clothing/head/helmet/space/nasavoid/old
	name = "\improper 工程太空头盔"
	desc = "一顶中央指挥部工程部使用的深红色太空头盔。虽然老旧积灰，但依然能派上用场。"
	icon_state = "void"
	visor_dirt = "void_dirt"

/obj/item/clothing/suit/space/nasavoid/old
	name = "\improper 工程太空服"
	icon_state = "void"
	inhand_icon_state = "void_suit"
	desc = "一套中央指挥部工程部使用的深红色太空服。岁月让它老化，穿在身上行动困难。"
	slowdown = 4
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/multitool)

	//EVA suit
/obj/item/clothing/suit/space/eva
	name = "\improper EVA 宇航服"
	icon_state = "space"
	inhand_icon_state = "s_suit"
	desc = "一套轻型宇航服，具备在紧急情况下保护穿着者免受太空真空伤害的基本能力。"
	armor_type = /datum/armor/space_eva

/obj/item/clothing/head/helmet/space/eva
	name = "\improper EVA 头盔"
	icon_state = "space"
	inhand_icon_state = "space_helmet"
	desc = "一顶轻型太空头盔，具备在紧急情况下保护佩戴者免受太空真空伤害的基本能力。"
	flash_protect = FLASH_PROTECTION_NONE
	armor_type = /datum/armor/space_eva
	visor_dirt = "space_dirt"
	has_visor = TRUE

/datum/armor/space_eva
	bio = 100
	fire = 50
	acid = 65

/obj/item/clothing/head/helmet/space/eva/examine(mob/user)
	. = ..()
	. += span_notice("你可以用[span_bold("半机械人腿部")]开始组装一台小型机甲。")

/obj/item/clothing/head/helmet/space/eva/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/bodypart/leg/left/robot) && !istype(tool, /obj/item/bodypart/leg/right/robot))
		return ..()

	if(ismob(loc))
		user.balloon_alert(user, "先把头盔放下！")
		return ITEM_INTERACT_BLOCKING

	user.balloon_alert(user, "已装接腿部")
	new /obj/item/bot_assembly/vim(loc)
	qdel(tool)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

	//Emergency suit
/obj/item/clothing/head/helmet/space/fragile
	name = "应急太空头盔"
	desc = "一顶笨重、气密的头盔，用于在紧急情况下保护使用者。看起来并不怎么耐用。"
	icon_state = "syndicate-helm-orange"
	inhand_icon_state = "syndicate-helm-orange" //resprite?
	armor_type = /datum/armor/space_fragile
	strip_delay = 6.5 SECONDS

/obj/item/clothing/suit/space/fragile
	name = "应急太空服"
	desc = "一套笨重、气密的太空服，用于在紧急情况下保护使用者。看起来并不怎么耐用。"
	var/torn = FALSE
	icon_state = "syndicate-orange"
	inhand_icon_state = "syndicate-orange"
	slowdown = 2
	armor_type = /datum/armor/space_fragile
	strip_delay = 6.5 SECONDS

/datum/armor/space_fragile
	melee = 5

/obj/item/clothing/suit/space/fragile/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(!torn && prob(50))
		to_chat(owner, span_warning("[src] 因受损而撕裂，气密性被破坏了！"))
		clothing_flags &= ~STOPSPRESSUREDAMAGE
		name = "破损的 [src]"
		desc = "一套笨重的太空服，用于在紧急情况下保护使用者——至少在被撕出一个洞之前是这样。"
		torn = TRUE
		playsound(loc, 'sound/items/weapons/slashmiss.ogg', 50, TRUE)
		playsound(loc, 'sound/effects/refill.ogg', 50, TRUE)
