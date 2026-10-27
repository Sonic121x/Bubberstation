// This file contains everything used by security, or in other combat applications.

/obj/item/storage/box/flashbangs
	name = "闪光弹盒（警告）"
	desc = "<B>警告：这些装置极其危险，反复使用可能导致失明或耳聋。</B>"
	icon_state = "secbox"
	illustration = "flashbang"

/obj/item/storage/box/flashbangs/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/grenade/flashbang(src)

/obj/item/storage/box/stingbangs
	name = "刺爆弹盒（警告）"
	desc = "<B>警告：这些装置极其危险，反复使用可能造成重伤或死亡。</B>"
	icon_state = "secbox"
	illustration = "flashbang"

/obj/item/storage/box/stingbangs/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/grenade/stingbang(src)

/obj/item/storage/box/flashes
	name = "闪光灯泡盒"
	desc = "<B>警告：闪光器可能造成严重眼损伤，必须佩戴护目镜。</B>"
	icon_state = "secbox"
	illustration = "flash"

/obj/item/storage/box/flashes/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/assembly/flash/handheld(src)

/obj/item/storage/box/wall_flash
	name = "壁挂式闪光器套件"
	desc = "这个盒子包含建造壁挂式闪光器所需的一切。<B>警告：闪光器可能造成严重眼损伤，必须佩戴护目镜。</B>"
	icon_state = "secbox"
	illustration = "flash"

/obj/item/storage/box/wall_flash/PopulateContents()
	var/id = rand(1000, 9999)
	// FIXME what if this conflicts with an existing one?

	new /obj/item/wallframe/button(src)
	new /obj/item/electronics/airlock(src)
	var/obj/item/assembly/control/flasher/remote = new(src)
	remote.id = id
	var/obj/item/wallframe/flasher/frame = new(src)
	frame.id = id
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/screwdriver(src)


/obj/item/storage/box/teargas
	name = "催泪瓦斯手榴弹盒（警告）"
	desc = "<B>警告：这些装置极其危险，可能造成失明与皮肤刺激。</B>"
	icon_state = "secbox"
	illustration = "grenade"

/obj/item/storage/box/teargas/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/grenade/chem_grenade/teargas(src)

/obj/item/storage/box/emps
	name = "EMP 手榴弹盒"
	desc = "一个装有 5 枚 EMP 手榴弹的盒子。"
	illustration = "emp"

/obj/item/storage/box/emps/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/grenade/empgrenade(src)

/obj/item/storage/box/prisoner
	name = "囚犯 ID 卡盒"
	desc = "夺走他们最后一丝尊严——他们的名字。"
	icon_state = "secbox"
	illustration = "id"

/obj/item/storage/box/prisoner/PopulateContents()
	..()
	new /obj/item/card/id/advanced/prisoner/one(src)
	new /obj/item/card/id/advanced/prisoner/two(src)
	new /obj/item/card/id/advanced/prisoner/three(src)
	new /obj/item/card/id/advanced/prisoner/four(src)
	new /obj/item/card/id/advanced/prisoner/five(src)
	new /obj/item/card/id/advanced/prisoner/six(src)
	new /obj/item/card/id/advanced/prisoner/seven(src)

/obj/item/storage/box/seccarts
	name = "安保 PDA 卡带盒"
	desc = "一个装满安保部所用 PDA 卡带的盒子。"
	icon_state = "secbox"
	illustration = "pda"

/obj/item/storage/box/seccarts/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/disk/computer/security(src)

/obj/item/storage/box/firingpins
	name = "标准击发针盒"
	desc = "一个装满标准击发针的盒子，用于让新研制的枪械能够开火。"
	icon_state = "secbox"
	illustration = "firingpin"

/obj/item/storage/box/firingpins/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/firing_pin(src)

/obj/item/storage/box/firingpins/paywall
	name = "付费墙击发针盒"
	desc = "一个装满付费墙击发针的盒子，让新研制的枪械只有在缴纳自行设定的费用后才能使用。"

/obj/item/storage/box/firingpins/paywall/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/firing_pin/paywall(src)

/obj/item/storage/box/firingpins/syndicate
	name = "辛迪加击发针盒"
	desc = "一个装满辛迪加专用击发针的盒子，只有辛迪加特工才能使用装有这种击发针的武器。"

/obj/item/storage/box/firingpins/syndicate/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/firing_pin/implant/pindicate(src)

/obj/item/storage/box/lasertagpins
	name = "激光对战击发针盒"
	desc = "一个装满激光对战击发针的盒子，让新研制的枪械只有在穿戴鲜艳的塑料护甲后才能使用。"
	illustration = "firingpin"

/obj/item/storage/box/lasertagpins/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/firing_pin/tag/red(src)
		new /obj/item/firing_pin/tag/blue(src)

/obj/item/storage/box/handcuffs
	name = "备用手铐盒"
	desc = "一个装满手铐的盒子。"
	icon_state = "secbox"
	illustration = "handcuff"

/obj/item/storage/box/handcuffs/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/restraints/handcuffs(src)

/obj/item/storage/box/zipties
	name = "备用扎带盒"
	desc = "一个装满扎带的盒子。"
	icon_state = "secbox"
	illustration = "handcuff"

/obj/item/storage/box/zipties/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/restraints/handcuffs/cable/zipties(src)

/obj/item/storage/box/alienhandcuffs
	name = "备用手铐盒"
	desc = "一个装满手铐的盒子。"
	icon_state = "alienbox"
	illustration = "handcuff"

/obj/item/storage/box/alienhandcuffs/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/restraints/handcuffs/alien(src)

/obj/item/storage/box/rubbershot
	name = "霰弹盒（低致命 - 橡胶弹）"
	desc = "一个装满橡胶弹霰弹的盒子，专为霰弹枪设计。"
	icon_state = "rubbershot_box"
	illustration = null

/obj/item/storage/box/rubbershot/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/rubbershot(src)

/obj/item/storage/box/lethalshot
	name = "霰弹盒（致命）"
	desc = "一个装满致命霰弹的盒子，专为霰弹枪设计。"
	icon_state = "lethalshot_box"
	illustration = null

/obj/item/storage/box/lethalshot/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/buckshot(src)

/obj/item/storage/box/lethalshot/old

/obj/item/storage/box/lethalshot/old/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/buckshot/old(src)

/obj/item/storage/box/slugs
	name = "霰弹盒（致命 - 独头弹）"
	desc = "一个装满致命独头霰弹的盒子，专为霰弹枪设计。"
	icon_state = "breacher_box"
	illustration = null

/obj/item/storage/box/slugs/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun(src)

/obj/item/storage/box/beanbag
	name = "霰弹盒（低致命 - 豆袋弹）"
	desc = "一个装满豆袋霰弹的盒子，专为霰弹枪设计。"
	icon_state = "beanbagshot_box"
	illustration = null

/obj/item/storage/box/beanbag/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_casing/shotgun/beanbag(src)

/obj/item/storage/box/breacherslug
	name = "破门霰弹盒"
	desc = "一个装满破门独头弹的盒子，专为快速突入设计，对其他目标效果不佳。"
	icon_state = "breacher_box"
	illustration = null

/obj/item/storage/box/breacherslug/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/breacher(src)

/obj/item/storage/box/large_dart
	name = "XL 霰弹镖盒"
	desc = "一个装满化学容量更大的霰弹镖的盒子。"
	icon_state = "shotdart_box"
	illustration = null

/obj/item/storage/box/large_dart/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/dart/large(src)

/obj/item/storage/box/emptysandbags
	name = "空沙袋盒"
	illustration = "sandbag"

/obj/item/storage/box/emptysandbags/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/emptysandbag(src)

/obj/item/storage/box/holy_grenades
	name = "神圣手榴弹盒"
	desc = "内含数枚用于迅速清除异端的手榴弹。"
	illustration = "grenade"

/obj/item/storage/box/holy_grenades/PopulateContents()
	for(var/i in 1 to 7)
		new/obj/item/grenade/chem_grenade/holy(src)

/obj/item/storage/box/fireworks
	name = "烟花盒"
	desc = "内含各式各样的烟花。"
	illustration = "sparkler"

/obj/item/storage/box/fireworks/PopulateContents()
	for(var/i in 1 to 3)
		new/obj/item/sparkler(src)
		new/obj/item/grenade/firecracker(src)
	new /obj/item/toy/snappop(src)

/obj/item/storage/box/fireworks/dangerous
	desc = "这个盒子上贴着一张小标签，写着它来自戈尔莱克斯掠夺者。内含各式各样的“烟花”。"

/obj/item/storage/box/fireworks/dangerous/PopulateContents()
	for(var/i in 1 to 3)
		new/obj/item/sparkler(src)
		new/obj/item/grenade/firecracker(src)
	if(prob(20))
		new /obj/item/grenade/frag(src)
	else
		new /obj/item/toy/snappop(src)

/obj/item/storage/box/firecrackers
	name = "鞭炮盒"
	desc = "一个装满非法鞭炮的盒子。你很好奇现在还有谁在做这些东西。"
	icon_state = "syndiebox"
	illustration = "firecracker"

/obj/item/storage/box/firecrackers/PopulateContents()
	for(var/i in 1 to 7)
		new/obj/item/grenade/firecracker(src)

/obj/item/storage/box/sparklers
	name = "仙女棒盒"
	desc = "一盒纳米传讯品牌的仙女棒，即使在寒冷的太空冬季里也能烧得很旺。"
	illustration = "sparkler"

/obj/item/storage/box/sparklers/PopulateContents()
	for(var/i in 1 to 7)
		new/obj/item/sparkler(src)

/obj/item/storage/box/evidence
	name = "证据袋盒"
	desc = "一个声称装有证据袋的盒子。"

/obj/item/storage/box/evidence/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/evidencebag(src)
