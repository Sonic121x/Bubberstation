/obj/item/clothing/glasses/hud/eyepatch
	name = "眼罩 HUD"
	desc = "一副简单的 HUD，设计用于与失去的那只眼睛的视神经对接。这一副似乎已经坏了。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "hudpatch"
	base_icon_state = "hudpatch"
	inhand_icon_state = "sunhudmed"
	can_switch_eye = TRUE	//See modular_skyrat\modules\customization\modules\clothing\glasses\glasses.dm
	actions_types = list(/datum/action/item_action/flip)


/obj/item/clothing/glasses/hud/eyepatch/attack_self(mob/user, modifiers)
	. = ..()
	icon_state = (icon_state == base_icon_state) ? "[base_icon_state]_flipped" : base_icon_state
	user.update_worn_glasses()

/obj/item/clothing/glasses/hud/eyepatch/med
	name = "医疗眼罩 HUD"
	desc = "勿伤害他人——也许伤害已经降临到你、或你那只可怜的眼球上，所幸还有办法继续践行你的誓言；幸好誓言里没提睡眠飞镖或猴子人。"
	icon_state = "medpatch"
	base_icon_state = "medpatch"
	clothing_traits = list(TRAIT_MEDICAL_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

/obj/item/clothing/glasses/hud/eyepatch/med/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/medpatch)

/datum/atom_skin/medpatch
	abstract_type = /datum/atom_skin/medpatch

/datum/atom_skin/medpatch/eyepatch
	preview_name = "眼罩"
	new_icon_state = "medpatch"

/datum/atom_skin/medpatch/fake_blindfold
	preview_name = "假蒙眼布"
	new_icon_state = "medfold"

/obj/item/clothing/glasses/hud/eyepatch/meson
	name = "介子眼罩 HUD"
	desc = "献给那些盯着超物质时只想疯一半的人。"
	icon_state = "mesonpatch"
	base_icon_state = "mesonpatch"
	clothing_traits = list(TRAIT_MADNESS_IMMUNE)
	vision_flags = SEE_TURFS
	color_cutoffs = list(5, 15, 5)
	lighting_cutoff = LIGHTING_CUTOFF_MEDIUM
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen

/obj/item/clothing/glasses/hud/eyepatch/meson/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/mesonpatch)

/datum/atom_skin/mesonpatch
	abstract_type = /datum/atom_skin/mesonpatch

/datum/atom_skin/mesonpatch/eyepatch
	preview_name = "眼罩"
	new_icon_state = "mesonpatch"

/datum/atom_skin/mesonpatch/fake_blindfold
	preview_name = "假蒙眼布"
	new_icon_state = "mesonfold"

/obj/item/clothing/glasses/hud/eyepatch/diagnostic
	name = "诊断眼罩 HUD"
	desc = "眼球被失控的半机械人弄没了？敢不敢叫机器狗干它的活？还是单纯觉得腻了？不管什么原因，这一小块科技都能帮你继续修理半机械人——它们通常自己就修了，永远用不上你，但心意最重要。"
	icon_state = "robopatch"
	base_icon_state = "robopatch"
	clothing_traits = list(TRAIT_DIAGNOSTIC_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

/obj/item/clothing/glasses/hud/eyepatch/diagnostic/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/robopatch)

/datum/atom_skin/robopatch
	abstract_type = /datum/atom_skin/robopatch

/datum/atom_skin/robopatch/eyepatch
	preview_name = "眼罩"
	new_icon_state = "robopatch"

/datum/atom_skin/robopatch/fake_blindfold
	preview_name = "假蒙眼布"
	new_icon_state = "robofold"

/obj/item/clothing/glasses/hud/eyepatch/sci
	name = "科研眼罩 HUD"
	desc = "每隔几年，那些立志成为疯狂科学家的人就会对自己说：“城堡、邪恶的笑声和装备我都齐了，就缺一副好眼神。”所幸，亲爱的朋友，Galox 博士已经为你解决了这件事——除了扫描化学物质之外它做不了什么，但它用造型弥补了实用性的不足。"
	icon_state = "scipatch"
	base_icon_state = "scipatch"
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)

/obj/item/clothing/glasses/hud/eyepatch/sci/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/scipatch)

/datum/atom_skin/scipatch
	abstract_type = /datum/atom_skin/scipatch

/datum/atom_skin/scipatch/eyepatch
	preview_name = "眼罩"
	new_icon_state = "scipatch"

/datum/atom_skin/scipatch/fake_blindfold
	preview_name = "假蒙眼布"
	new_icon_state = "scifold"

/// BLINDFOLD HUDS ///
/obj/item/clothing/glasses/trickblindfold/obsolete
	name = "老旧假眼罩"
	desc = "一副华丽却没有半点电子元件的假眼罩。据信最初由某个致力于保护人类的已消亡军事组织成员佩戴。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "obsoletefold"
	base_icon_state = "obsoletefold"
	can_switch_eye = TRUE

/obj/item/clothing/glasses/hud/eyepatch/med/blindfold
	name = "医疗蒙眼布 HUD"
	desc = "一条内部装有医疗 HUD 的假蒙眼布，很适合在面对病人时保持面无表情。"
	icon_state =  "medfold"
	base_icon_state =  "medfold"

/obj/item/clothing/glasses/hud/eyepatch/meson/blindfold
	name = "介子蒙眼布 HUD"
	desc = "一条内部装有介子镜片的假蒙眼布。不能防护焊接。"
	icon_state =  "mesonfold"
	base_icon_state =  "mesonfold"

/obj/item/clothing/glasses/hud/eyepatch/diagnostic/blindfold
	name = "诊断蒙眼布 HUD"
	desc = "一条内部装有诊断 HUD 的假蒙眼布，非常适合在仿生人身上作业。"
	icon_state =  "robofold"
	base_icon_state =  "robofold"

/obj/item/clothing/glasses/hud/eyepatch/sci/blindfold
	name = "科研蒙眼布 HUD"
	desc = "一条内部装有科研 HUD 的假蒙眼布，让你在最终真的需要蒙眼之前先习惯一下。"
	icon_state =  "scifold"
	base_icon_state =  "scifold"
