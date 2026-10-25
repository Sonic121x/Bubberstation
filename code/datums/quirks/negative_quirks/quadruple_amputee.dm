/datum/quirk/quadruple_amputee
	name = "Quadruple Amputee"
	desc = "哎呀！全是义肢！仿佛受到了宇宙极其残酷的惩罚，你的四肢全被换成了廉价库存义肢。"
	icon = "tg-prosthetic-full"
	value = -6
	medical_record_text = "体检发现患者四肢均为廉价义肢。"
	hardcore_value = 6
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	mail_goodies = list(/obj/item/weldingtool/mini, /obj/item/stack/cable_coil/five)

/datum/quirk/quadruple_amputee/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.del_and_replace_bodypart(new /obj/item/bodypart/arm/left/robot/surplus, special = TRUE)
	human_holder.del_and_replace_bodypart(new /obj/item/bodypart/arm/right/robot/surplus, special = TRUE)
	human_holder.del_and_replace_bodypart(new /obj/item/bodypart/leg/left/robot/surplus, special = TRUE)
	human_holder.del_and_replace_bodypart(new /obj/item/bodypart/leg/right/robot/surplus, special = TRUE)

/datum/quirk/quadruple_amputee/post_add()
	to_chat(quirk_holder, span_bolddanger("你的四肢全被换成了廉价库存义肢。它们非常脆弱，受力时很容易散架。\
	此外，你需要用焊接工具和电缆来修理它们，而不是缝合线和再生网。"))

/datum/quirk/quadruple_amputee/remove()
	if(QDELING(quirk_holder))
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.reset_to_original_bodypart(BODY_ZONE_L_ARM)
	human_holder.reset_to_original_bodypart(BODY_ZONE_R_ARM)
	human_holder.reset_to_original_bodypart(BODY_ZONE_L_LEG)
	human_holder.reset_to_original_bodypart(BODY_ZONE_R_LEG)
