/datum/quirk/item_quirk/photographer
	name = "Photographer"
	desc = "你无论去哪里都带着相机和私人相册，你的剪贴簿在同事之间堪称传奇。"
	icon = FA_ICON_CAMERA
	value = 0
	mob_trait = TRAIT_PHOTOGRAPHER
	gain_text = span_notice("你对摄影了如指掌。")
	lose_text = span_danger("你忘了照相机怎么用。")
	medical_record_text = "患者表示摄影是其缓解压力的爱好。"
	mail_goodies = list(/obj/item/camera_film)

/datum/quirk/item_quirk/photographer/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/storage/photo_album/personal/photo_album = new(get_turf(human_holder))
	photo_album.persistence_id = "personal_[human_holder.last_mind?.key]" // this is a persistent album, the ID is tied to the account's key to avoid tampering
	photo_album.persistence_load()
	photo_album.name = "[human_holder.real_name]的相册"

	give_item_to_holder(photo_album, list(LOCATION_BACKPACK, LOCATION_HANDS))
	give_item_to_holder(
		/obj/item/camera,
		list(
			LOCATION_NECK,
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS
		)
	)
