
// Milking machine
/obj/item/storage/box/milking_kit
	name = "自制挤奶机套件"
	desc = "包含自行组装挤奶机所需的一切！"

/obj/item/storage/box/milking_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/construction_kit/milker = 1)
	generate_items_inside(items_inside, src)

// X-Stand
/obj/item/storage/box/xstand_kit
	name = "自制 X 形束缚架套件"
	desc = "包含自行组装 X 形束缚架所需的一切！"

/obj/item/storage/box/xstand_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/construction_kit/bdsm/x_stand = 1)
	generate_items_inside(items_inside, src)

// BDSM bed
/obj/item/storage/box/bdsmbed_kit
	name = "自制调教床套件"
	desc = "包含自行组装调教床所需的一切！"

/obj/item/storage/box/bdsmbed_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/construction_kit/bdsm/bed = 1)
	generate_items_inside(items_inside, src)

// Striptease pole
/obj/item/storage/box/strippole_kit
	name = "自制钢管舞杆套件"
	desc = "包含自行组装钢管舞杆所需的一切！"

/obj/item/storage/box/strippole_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/construction_kit/pole = 1)
	generate_items_inside(items_inside, src)

// Shibari stand
/obj/item/storage/box/shibari_stand
	name = "自制绳缚架套件"
	desc = "包含自行组装绳缚架所需的一切！"

/obj/item/storage/box/shibari_stand/PopulateContents()
	var/static/items_inside = list(
		/obj/item/construction_kit/bdsm/shibari = 1,
		/obj/item/paper/shibari_kit_instructions = 1)
	generate_items_inside(items_inside, src)

// Paper instructions for shibari kit

/obj/item/paper/shibari_kit_instructions
	default_raw_text = "你好！恭喜你购买欲愿公司的绳缚套件！新手可能不熟悉我们的绳索，因此我们准备了这份简短说明！首先，你需要用扳手组装架子。其次，可以用螺丝刀更换塑料配件，改变绳缚架的颜色！最后，如果想把人绑在束缚架上，需要先绑好胸部和胯部。依次对躯干和胯部使用绳索，然后就能像固定到椅子上一样将其固定到架子上。架子本身不附带绳索，别忘了手持一些绳索才能完成固定！就这么简单！"
