/datum/uplink_item/badass/plushie
	name = "辛迪加支援毛绒玩偶"
	desc = "献给那些在外行动、急需情绪支持的特工。"
	item = /obj/item/toy/plush/nukeplushie
	cost = 1
	uplink_item_flags = NONE

/datum/uplink_item/badass/medalbox
	name = "辛迪加勋章盒"
	desc = "给想要犒赏船员的核爆行动首领。也可以用来答谢合作者。不含权限。"
	item = /obj/item/storage/lockbox/medal/bubber/synd
	cost = 1
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/badass/flag
	name = "辛迪加旗帜"
	desc = "给那些懒得自己去弄块布的特工。他们把战旗挂了出来。"
	item = /obj/item/sign/flag/syndicate
	cost = 1
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/badass/henchmen_traitor_outfits
	name = "打手套装"
	desc = "五套带装甲的打手服装！每套都配有一顶帽子、一件大衣、一身制服、一副手套、一双鞋和一把弹簧刀！"
	item = /obj/item/storage/backpack/duffelbag/henchmen_traitor_outfits
	cost = 4

/datum/uplink_item/badass/foam_sword_traitor
	name = "铅芯泡沫火力阔剑"
	desc = "看起来和玩具一模一样！里面灌满了铅！能挡下攻击（有时候）！不能当棍棒使用。"
	item = /obj/item/foam_baton/sword/traitor
	cost = 2
	surplus = 50
	cant_discount = TRUE
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
