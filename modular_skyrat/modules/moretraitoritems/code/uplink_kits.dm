/obj/item/storage/box/syndie_kit/cultkisr
	name = "血教构造体套件"
	desc = "一个简洁坚固的盒子，里面蕴藏着不祥的黑暗能量。真吓人。"

/obj/item/storage/box/syndie_kit/cultkitsr/PopulateContents()
	new /obj/item/storage/belt/soulstone/full/purified(src)
	new /obj/item/sbeacondrop/constructshell(src)
	new /obj/item/sbeacondrop/constructshell(src)

/obj/item/sbeacondrop/constructshell
	desc = "标签上写着：<i>警告：激活此装置将向你所在的位置运送一具纳尔西构造体外壳</i>。"
	droptype = /obj/structure/constructshell

/obj/item/storage/belt/soulstone/full/purified/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/soulstone/anybody/purified(src)
