/datum/design/syndicate_express_console
	name = "英特戴恩快速补给控制台"
	desc = "用于在黑市采购货物的电脑电路板。"
	id = "cargoconsole_syndicate"
	build_type = AWAY_IMPRINTER
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	transfered_materials = list(/obj/item/circuitboard/computer/cargo/express/interdyne = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT))
	build_path = /obj/item/circuitboard/computer/cargo/express/interdyne
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/syndicate_bounty_pad
	name = "英特戴恩悬赏交货平台"
	desc = "用于在黑市出售货物的机器电路板。"
	id = "bountypad_syndicate"
	build_type = AWAY_IMPRINTER
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	transfered_materials = list(/obj/item/circuitboard/machine/syndiepad = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT))
	build_path = /obj/item/circuitboard/machine/syndiepad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_CONSTRUCTION_MACHINERY
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/syndicate_bounty_pad_console
	name = "英特戴恩悬赏控制终端"
	desc = "用于控制悬赏交货平台在黑市出售货物的电脑电路板。"
	id = "bountyconsole_syndicate"
	build_type = AWAY_IMPRINTER
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	transfered_materials = list(/obj/item/circuitboard/computer/syndiepad = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT))
	build_path = /obj/item/circuitboard/computer/syndiepad
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/syndicate_powerator
	name = "英特戴恩电力贩子"
	desc = "一种可出售电力的机器电路板。"
	id = "powerator_syndicate"
	build_type = AWAY_IMPRINTER
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	transfered_materials = list(/obj/item/circuitboard/machine/powerator/interdyne = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT))
	build_path = /obj/item/circuitboard/machine/powerator/interdyne
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_CONSTRUCTION_MACHINERY
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/syndicate_exofab
	name = "辛迪加外骨骼制造机"
	desc = "英特戴恩生产的标准配发外骨骼制造机电路板。"
	id = "exofab_syndicate"
	build_type = AWAY_IMPRINTER
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	transfered_materials = list(/obj/item/circuitboard/machine/mechfab/interdyne = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT))
	build_path = /obj/item/circuitboard/machine/mechfab/interdyne
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_CONSTRUCTION_MACHINERY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

//Items
/datum/design/syndicate_firing_pin
	name = "辛迪加击针"
	desc = "一种辛迪加植入体限制击针。"
	id = "syndicate_firing_pin"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3)
	build_path =/obj/item/firing_pin/implant/pindicate
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_FIRING_PINS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/syndicateciv_headset
	name = "辛迪加耳机"
	desc = "辛迪加平民的标准配发耳机。"
	id = "syndicate_headset"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.7)
	build_path = /obj/item/radio/headset/syndicateciv
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/interdyne_key
	name = "英特戴恩加密密钥"
	desc = "辛迪加平民的标准配发耳机。"
	id = "interdyne_encryption"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/encryptionkey/headset_syndicate/interdyne
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/cybersun_key
	name = "赛博太阳加密密钥"
	desc = "辛迪加平民的标准配发耳机。"
	id = "cybersun_encryption"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/encryptionkey/headset_syndicate/cybersun
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/interdyne_mining_equipment_vendor
	name = "离站采矿奖励售货机电路板"
	desc = "离站采矿奖励售货机的电路板。"
	id = "interdyne_mining_equipment_vendor"
	build_type = AWAY_IMPRINTER
	build_path = /obj/item/circuitboard/computer/order_console/mining/interdyne
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO
