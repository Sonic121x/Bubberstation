/obj/item/ammo_box/advanced/s12gauge
	name = "独头弹弹药盒"
	desc = "一盒7发独头弹。大号单体弹头，威力十足。"
	icon = 'modular_skyrat/modules/shotgunrebalance/icons/shotbox.dmi'
	icon_state = "slug"
	w_class = WEIGHT_CLASS_NORMAL
	ammo_type = /obj/item/ammo_casing/shotgun
	max_ammo = 7
	multitype = FALSE // if you enable this and set the box's caliber var to CALIBER_SHOTGUN (at time of writing, "shotgun"), then you can have the fabled any-ammo shellbox

	custom_premium_price = 500

/obj/item/ammo_box/advanced/s12gauge/laser
	name = "散射激光弹弹药盒"
	desc = "一盒7发激光弹，可发射杀伤力极强的激光。"
	icon_state = "laser"
	ammo_type = /obj/item/ammo_casing/shotgun/scatterlaser

/obj/item/ammo_box/advanced/s12gauge/buckshot
	name = "鹿弹弹药盒"
	desc = "一盒7发鹿弹，以适中的散布发射多枚威力较低的弹丸。"
	icon_state = "buckshot"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot

/obj/item/ammo_box/advanced/s12gauge/rubber
	name = "橡胶霰弹弹药盒"
	desc = "一盒7发橡胶霰弹，以适中的散布发射威力较低、低致命性的弹丸。"
	icon_state = "rubber"
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/ammo_box/advanced/s12gauge/bean
	name = "布袋弹弹药盒"
	desc = "一盒7发布袋弹。单枚大号布袋弹头，冲击强劲而致命性较低。"
	icon_state = "bean"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/ammo_box/advanced/s12gauge/hunter
	name = "狩猎独头弹弹药盒"
	desc = "一盒7发狩猎独头弹，特别适合对付当地野生动物。"
	icon_state = "hunter"
	ammo_type = /obj/item/ammo_casing/shotgun/hunter

/obj/item/ammo_box/advanced/s12gauge/flechette
	name = "箭形弹弹药盒"
	desc = "一盒7发箭形弹，每发内有一组翻滚的刃片，穿甲能力出色。"
	icon_state = "flechette"
	ammo_type = /obj/item/ammo_casing/shotgun/flechette

/obj/item/ammo_box/advanced/s12gauge/dragonsbreath
	name = "龙息弹弹药盒"
	desc = "一盒7发龙息弹，每发内含等离子体，能形成大片尾随火焰，极易造成附带损害。"
	icon_state = "dragonsbreath"
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath

/obj/item/ammo_box/advanced/s12gauge/incendiary
	name = "燃烧独头弹弹药盒"
	desc = "一盒7发燃烧独头弹，可点燃目标并留下火焰轨迹。"
	icon_state = "incendiary"
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary

/obj/item/ammo_box/advanced/s12gauge/honkshot
	name = "滑稽彩纸弹弹药盒"
	desc = "一盒7发滑稽霰弹，装满彩纸，保证让任何派对都热闹得砰然作响！"
	icon_state = "honk"
	ammo_type = /obj/item/ammo_casing/shotgun/honkshot

/obj/item/ammo_box/advanced/s12gauge/frangible
	name = "易碎独头弹弹药盒"
	desc = "一盒7发易碎独头弹，可轻松击穿窗户、气闸等设施，但对人效果不佳。"
	icon_state = "fslug"
	ammo_type = /obj/item/ammo_casing/shotgun/frangible

//The one below here has a destruction damage of 200, it two shot most mech, use the one above
/obj/item/ammo_box/advanced/s12gauge/breaching
	name = "破门独头弹弹药盒"
	desc = "一盒7发破门独头弹，几乎能轻松打穿任何东西。"
	icon_state = "fslug"
	ammo_type = /obj/item/ammo_casing/shotgun/frangible

//This is intended for ERT! Have fun with it
/obj/item/ammo_box/advanced/s12gauge/pulse
	name = "脉冲独头弹弹药盒"
	desc = "一盒7发脉冲独头弹，能够穿透建筑及其后方的任何东西。"
	icon_state = "pulse"
	ammo_type = /obj/item/ammo_casing/shotgun/pulseslug
