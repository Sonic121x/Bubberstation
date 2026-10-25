/obj/item/clothing/head/hooded/ablative
	name = "烧蚀兜帽"
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	desc = "但愿是属于某件烧蚀风衣的兜帽。附有护目镜，可提供酷炫视觉。"
	icon_state = "ablativehood"
	flags_inv = HIDEHAIR|HIDEEARS
	armor_type = /datum/armor/hooded_ablative
	strip_delay = 3 SECONDS
	clothing_traits = list(TRAIT_SECURITY_HUD)
	var/hit_reflect_chance = 50

/datum/armor/hooded_ablative
	melee = 10
	bullet = 10
	laser = 60
	energy = 60
	fire = 100
	acid = 100

/obj/item/clothing/head/hooded/ablative/IsReflect(def_zone)
	if(def_zone != BODY_ZONE_HEAD) //If not shot where ablative is covering you, you don't get the reflection bonus!
		return FALSE
	if (prob(hit_reflect_chance))
		return TRUE

/obj/item/clothing/suit/hooded/ablative
	name = "烧蚀风衣"
	desc = "实验性风衣，专门用于反射和吸收激光与解除者射击。不过别指望它对付斧头或霰弹枪能有多大用处。"
	icon = 'icons/obj/clothing/suits/armor.dmi'
	icon_state = "ablativecoat"
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor_type = /datum/armor/hooded_ablative
	hoodtype = /obj/item/clothing/head/hooded/ablative
	strip_delay = 3 SECONDS
	equip_delay_other = 4 SECONDS
	var/hit_reflect_chance = 50

/obj/item/clothing/suit/hooded/ablative/Initialize(mapload)
	. = ..()
	allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/hooded/ablative/IsReflect(def_zone)
	if(!(def_zone in list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))) //If not shot where ablative is covering you, you don't get the reflection bonus!
		return FALSE
	if (prob(hit_reflect_chance))
		return TRUE

/obj/item/clothing/suit/hooded/ablative/on_hood_up(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/mob/living/carbon/user = loc
	balloon_alert(user, "HUD 已启用")

/obj/item/clothing/suit/hooded/ablative/on_hood_down(obj/item/clothing/head/hooded/hood)
	var/mob/living/carbon/user = loc
	balloon_alert(user, "HUD 已停用")
	return ..()
