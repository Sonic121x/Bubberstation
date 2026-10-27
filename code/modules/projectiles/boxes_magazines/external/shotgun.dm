/obj/item/ammo_box/magazine/m12g
	name = "霰弹枪弹匣（12g 鹿弹）"
	desc = "一个装填霰弹的弹鼓，适用于斗牛犬战斗霰弹枪。"
	icon_state = "m12gb"
	base_icon_state = "m12gb"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot/milspec
	caliber = CALIBER_SHOTGUN
	max_ammo = 8
	casing_phrasing = "霰弹"

/obj/item/ammo_box/magazine/m12g/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ceil(ammo_count(FALSE)/8)*8]"

/obj/item/ammo_box/magazine/m12g/stun
	name = "霰弹枪弹匣（12g 电击弹）"
	icon_state = "m12gs"
	base_icon_state = "m12gs"
	ammo_type = /obj/item/ammo_casing/shotgun/stunslug

/obj/item/ammo_box/magazine/m12g/slug
	name = "霰弹枪弹匣（12g 独头弹）"
	icon_state = "m12gsl"
	base_icon_state = "m12gsl"
	ammo_type = /obj/item/ammo_casing/shotgun/milspec

/obj/item/ammo_box/magazine/m12g/dragon
	name = "霰弹枪弹匣（12g 龙息弹）"
	icon_state = "m12gf"
	base_icon_state = "m12gf"
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath

/obj/item/ammo_box/magazine/m12g/bioterror
	name = "霰弹枪弹匣（12g 生化恐怖弹）"
	icon_state = "m12gt"
	base_icon_state = "m12gt"
	ammo_type = /obj/item/ammo_casing/shotgun/dart/bioterror

/obj/item/ammo_box/magazine/m12g/meteor
	name = "霰弹枪弹匣（12g 陨石弹）"
	icon_state = "m12gbc"
	base_icon_state = "m12gbc"
	ammo_type = /obj/item/ammo_casing/shotgun/meteorslug

/obj/item/ammo_box/magazine/m12g/flechette
	name = "霰弹枪弹匣（12g 飞镖弹）"
	icon_state = "m12gfl"
	base_icon_state = "m12gfl"
	ammo_type = /obj/item/ammo_casing/shotgun/flechette

/obj/item/ammo_box/magazine/m12g/donk
	name = "霰弹枪弹匣（12g 咚克公司“咚克尖刺”飞镖弹）"
	desc = "一个装填霰弹的弹鼓，适用于斗牛犬战斗霰弹枪。表面贴满了咚克公司的刮擦闻香 \
		贴纸。你不太确定自己是否想凑上去闻一闻……"
	icon_state = "m12gd"
	base_icon_state = "m12gd"
	ammo_type = /obj/item/ammo_casing/shotgun/flechette/donk

/obj/item/ammo_box/magazine/m12g/donk/examine_more(mob/user)
	. = ..()
	if(ishuman(user))
		return

	var/mob/living/carbon/human/human_sniffer = user
	if(!HAS_TRAIT(human_sniffer, TRAIT_ANOSMIA) && human_sniffer.can_perform_action(src, NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING|FORBID_TELEKINESIS_REACH))
		. += span_notice("你刮了刮贴纸，然后闻了闻。")
		. += span_warning("<i>天哪，他们是从哪儿弄来这东西的，垃圾填埋场吗？</i>")
		human_sniffer.add_mood_event("stink-pocket", /datum/mood_event/disgusted)

