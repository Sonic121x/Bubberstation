/// Dorms Room Papers
/obj/item/paper/fluff/ruins/waystation/menu
	name = "本周菜单"
	default_raw_text = "这是公司这周发给我们的，老一套。<BR><BR><B>星期一</B> - 披萨和芝士通心粉<BR><B>星期二</B> - 太空鲤鱼刺身与寿司<BR><B>星期三</B> - 蒜油尼扎亚和欣卡利<BR><B>星期四</B> - 货运主管的生日，蛋糕和一堆糕点<BR><B>星期五</B> - 炸鱼薯条<BR><BR>另外还有技术员们“不小心”从箱子里顺来的各种酒水和食物（这是提醒） -厨师"

/obj/item/paper/fluff/ruins/waystation/toilet
	name = "提醒！！"
	default_raw_text = "我早就当面跟你们这帮混蛋说过了，可你们没一个听进去，用完马桶他妈给我冲水！<BR>这地方就我一个人在打扫，你们得懂得感恩！ -格雷"

/// Cargo Bay Paper
/obj/item/paper/fluff/ruins/waystation/sop
	name = "标准作业程序提醒"
	default_raw_text= "关于新标准作业程序的简短提醒。<BR>请记得把所有安保锁定的箱子和其它高价值物品搬进安全仓库。你们偷别的箱子我不管，那些文书责任你们自己担。只是别偷任何会让我们所有人惹上麻烦的东西，好吗？"
/// Vault Paper
/obj/item/paper/fluff/ruins/waystation/memo
	name = "备忘录"
	default_raw_text= "请妥善保管那艘故障穿梭机上的文件，直到有人来取。我们实在不该随身带着这种东西。"
/// Syndicate Holodisk
/obj/item/disk/holodisk/ruin/waystation
	name = "行动 NUCLEUS - 简报"
	preset_image_type = /datum/preset_holoimage/syndicatebattlecruisercaptain
	preset_record_text = {"
	NAME 雷蒙德·约翰逊
	SAY 好了伙计们，任务很简单。
	DELAY 20
	SAY 你们将突入一座位于纳米传讯领土边缘的偏远中转站。
	DELAY 25
	SAY 你们的主要目标是取得关于纳米传讯近期在顺旋星区扩张的高度机密文件。
	DELAY 20
	SAY 文件存放在安全储藏室里。
	DELAY 25
	SAY 至于怎么过去，你们会从一艘走私船上乘突击舱发射过去。
	DELAY 30
	SAY 那里的安保很松懈，整座站只有一名安保警官把守。
	DELAY 25
	SAY 完成目标后，用无线电联系走私者，让他们来接你们。
	DELAY 10
	SAY 这应该易如反掌，我完全相信你们能完成目标。祝你们好运。
	DELAY 25"}

// Outfits
/datum/outfit/waystation/
	name = "improper Waystation Outfit"

/datum/outfit/waystation/cargohauler
	name = "Waystation Cargo Hauler"
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/away/waystation/cargo_technician
	uniform = /obj/item/clothing/under/rank/cargo/tech
	belt = /obj/item/modular_computer/pda/cargo
	ears = /obj/item/radio/headset/headset_cargo
	shoes = /obj/item/clothing/shoes/sneakers/black

/datum/outfit/waystation/qm
	name = "Waystation Quartermaster"
	id = /obj/item/card/id/advanced/silver
	id_trim = /datum/id_trim/away/waystation/quartermaster
	uniform = /obj/item/clothing/under/rank/cargo/qm
	belt = /obj/item/modular_computer/pda/heads/quartermaster
	ears = /obj/item/radio/headset/headset_cargo
	glasses = /obj/item/clothing/glasses/sunglasses
	shoes = /obj/item/clothing/shoes/sneakers/brown

/datum/outfit/waystation/nanotrasenofficer
	name = "Waystation Security Officer"
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/away/waystation/security
	uniform = /obj/item/clothing/under/rank/security/officer
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	head = /obj/item/clothing/head/helmet/swat/nanotrasen
	back = /obj/item/storage/backpack/security
	l_pocket = /obj/item/ammo_box/magazine/m45
// Corpse Spawner
/obj/effect/mob_spawn/corpse/human/waystation/cargo_technician
	name = "中转站货运搬运工"
	outfit = /datum/outfit/waystation/cargohauler

/obj/effect/mob_spawn/corpse/human/waystation/quartermaster
	name = "中转站货运主管"
	outfit = /datum/outfit/waystation/qm

/obj/effect/mob_spawn/corpse/human/waystation/nanotrasenofficer
	name = "中转站安保官"
	outfit = /datum/outfit/waystation/nanotrasenofficer
