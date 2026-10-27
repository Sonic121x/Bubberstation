
/////////////////////////////////////////
/////////////////Mining//////////////////
/////////////////////////////////////////
/datum/design/cargo_express
	name = "快速补给控制台电路板"//shes beautiful
	desc = "可用于制造搭建快速补给控制台所需的电路板。"//who?
	id = "cargoexpress"//the coder reading this
	build_type = IMPRINTER
	materials = list(/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/circuitboard/computer/cargo/express
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/bluespace_pod
	name = "快速补给空投舱升级磁盘"
	desc = "使货运快速补给控制台能够召唤蓝空间空投舱，大幅提升使用者的安全性。"//who?
	id = "bluespace_pod"//the coder reading this
	build_type = PROTOLATHE
	materials = list(/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/disk/cargo/bluespace_pod
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/pickaxe
	name = "矿镐"
	id = "pickaxe"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/pickaxe
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/drill
	name = "采矿钻"
	desc = "你的钻头将贯穿岩壁。"
	id = "drill"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*3, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT) //expensive, but no need for miners.
	build_path = /obj/item/pickaxe/drill
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/drill_diamond
	name = "钻石尖采矿钻"
	desc = "你的钻头将贯穿苍穹！"
	id = "drill_diamond"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*3,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond =SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/pickaxe/drill/diamonddrill
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/plasmacutter
	name = "等离子切割器"
	desc = "你可以用它切下异形的四肢！或者，呃，采矿。"
	id = "plasmacutter"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/plasma = SMALL_MATERIAL_AMOUNT*4,
	)
	build_path = /obj/item/gun/energy/plasmacutter
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/plasmacutter_adv
	name = "高级等离子切割器"
	desc = "这是一把高级等离子切割器，我的天哪。"
	id = "plasmacutter_adv"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma =SHEET_MATERIAL_AMOUNT,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/gun/energy/plasmacutter/adv
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/jackhammer
	name = "声波凿岩机"
	desc = "基本上就是一台手持式裂星器。岩壁一听到它的声音就会吓得发抖。"
	id = "jackhammer"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*3,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT,
		/datum/material/silver =SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT*3,
	)
	build_path = /obj/item/pickaxe/drill/jackhammer
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/superresonator
	name = "升级版谐振器"
	desc = "谐振器的升级版本，可同时维持更多力场。"
	id = "superresonator"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*2,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/resonator/upgraded
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/trigger_guard_mod
	name = "动能加速器扳机护圈改装"
	desc = "一种使任何生物都能持用动能加速器的装置。"
	id = "triggermod"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/modkit/trigger_guard
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_PKA_MODS
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/damage_mod
	name = "动能加速器伤害提升改装"
	desc = "一种能提升动能加速器伤害的装置。"
	id = "damagemod"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/modkit/damage
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_PKA_MODS
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/damage_mod/borg
	id = "borg_upgrade_damagemod"
	build_type = MECHFAB
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/cooldown_mod
	name = "动能加速器冷却缩减改装"
	desc = "一种能降低动能加速器冷却时间的装置。"
	id = "cooldownmod"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/borg/upgrade/modkit/cooldown
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_PKA_MODS
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/cooldown_mod/borg
	id = "borg_upgrade_cooldownmod"
	build_type = MECHFAB
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/range_mod
	name = "动能加速器射程提升改装"
	desc = "一种能提升动能加速器射程的装置。"
	id = "rangemod"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/borg/upgrade/modkit/range
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_PKA_MODS
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/range_mod/borg
	id = "borg_upgrade_rangemod"
	build_type = MECHFAB
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/hyperaccelerator
	name = "动能加速器采矿爆炸改装"
	desc = "一套动能加速器改装组件，可使其发射范围爆破、摧毁岩石。"
	id = "hypermod"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*4,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver =SHEET_MATERIAL_AMOUNT,
		/datum/material/gold =SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond =SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/modkit/cooldown/aoe/turfs
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_PKA_MODS
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/hyperaccelerator/borg
	id = "borg_upgrade_hypermod"
	build_type = MECHFAB
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mining_scanner
	name = "采矿扫描仪"
	id = "mining_scanner"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/iron =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/t_scanner/adv_mining_scanner/lesser
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/unique_modkit
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_PKA_MODS,
	)
	build_type = PROTOLATHE
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/unique_modkit/offensive_turf_aoe
	name = "动能加速器攻击采矿爆炸改装"
	desc = "一种使动能加速器发射范围爆破、摧毁岩石并伤害生物的装置。"
	id = "hyperaoemod"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*3.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.5, /datum/material/silver =SHEET_MATERIAL_AMOUNT*1.5, /datum/material/gold =SHEET_MATERIAL_AMOUNT*1.5, /datum/material/diamond = SHEET_MATERIAL_AMOUNT*2)
	build_path = /obj/item/borg/upgrade/modkit/cooldown/aoe/mobs/andturfs

/datum/design/unique_modkit/rapid_repeater
	name = "动能加速器快速中继器改装"
	desc = "一种能大幅降低动能加速器命中活体目标或岩石时冷却时间的装置，但会大幅提高其基础冷却时间。"
	id = "repeatermod"
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/uranium = SHEET_MATERIAL_AMOUNT*4, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/borg/upgrade/modkit/cooldown/repeater

/datum/design/unique_modkit/resonator_blast
	name = "动能加速器谐振爆破改装"
	desc = "一种使动能加速器的射击留下并引爆谐振爆破的装置。"
	id = "resonatormod"
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT*5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT*5, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT*5, /datum/material/uranium =SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/modkit/resonator_blasts

/datum/design/unique_modkit/bounty
	name = "动能加速器死亡虹吸改装"
	desc = "一种使动能加速器对曾被其击杀的生物类型永久提升伤害的装置。"
	id = "bountymod"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2, /datum/material/silver = SHEET_MATERIAL_AMOUNT*2, /datum/material/gold = SHEET_MATERIAL_AMOUNT*2, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT*2)
	build_path = /obj/item/borg/upgrade/modkit/bounty
