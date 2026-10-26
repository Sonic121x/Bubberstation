/datum/armament_entry/assault_operatives/implants
	category = "义体植入体"
	category_item_limit = 3

/datum/armament_entry/assault_operatives/implants/deathrattle
	name = "亡语植入体套件"
	description = "一套植入体（外加一具可重复使用的植入器），应植入到队伍成员体内。当队伍中有人 \
	死亡时，其余所有植入体持有者都会收到一条心灵讯息，得知队友的姓名 \
	及其死亡地点。与大多数植入体不同，这些植入体被设计为可植入 \
	任何生物体内，无论有机还是机械。"
	item_type = /obj/item/storage/box/syndie_kit/imp_deathrattle
	cost = 1

/datum/armament_entry/assault_operatives/implants/microbomb
	name = "微型炸弹植入体"
	description = "一颗植入体内的小型炸弹。可手动激活，也会在死亡时自动激活。警告：会永久摧毁你的身体以及你可能携带的一切。"
	item_type = /obj/item/implanter/explosive
	cost = 2

/datum/armament_entry/assault_operatives/implants/storage
	name = "储物植入体"
	description = "植入体内后可按意愿激活，这个隐秘的植入体会打开一个小的蓝空间口袋，可容纳两件普通大小的物品。"
	item_type = /obj/item/implanter/storage
	cost = 2

/datum/armament_entry/assault_operatives/implants/radio
	name = "无线电植入体"
	description = "植入体内后可按意愿激活，这个隐秘的植入体让你无需耳机即可通过无线电通话。"
	item_type = /obj/item/implanter/radio/syndicate
	cost = 1

/datum/armament_entry/assault_operatives/implants/hacking
	item_type = /obj/item/autosurgeon/syndicate/hackerman
	name = "黑客手臂植入体"
	description = "一枚先进的手臂植入体，附带尖端黑客工具。非常适合经过义体强化的网络潜行者。"
	cost = 2

/datum/armament_entry/assault_operatives/implants/freedom
	name = "自由植入体"
	description = "让使用者摆脱手铐、脚镣等常见束缚。附带四次使用次数。"
	item_type = /obj/item/storage/box/syndie_kit/imp_freedom
	cost = 3

/datum/armament_entry/assault_operatives/implants/thermal
	name = "热成像视觉植入体"
	description = "这些义体眼睛会赋予你热成像视觉。"
	item_type = /obj/item/autosurgeon/syndicate/thermal_eyes
	cost = 5

/datum/armament_entry/assault_operatives/implants/nodrop
	name = "防脱手植入体"
	description = "激活后会迫使你手部肌肉紧紧抓住手中物品，防止你不由自主地将其掉落。"
	item_type = /obj/item/autosurgeon/syndicate/nodrop
	cost = 5
