///NIFSoft Remover. This is mostly here so that security and antags have a way to remove NIFSofts from someome
/obj/item/nifsoft_remover
	name = "洛普兰“牧马人”NIF 切割器"
	desc = "一种小型装置，可让使用者从 NIF 用户身上移除 NIFSoft。"
	special_desc = "鉴于 NIF 的普及相对较晚却来得突然，近年来它们在轻微犯罪与有组织犯罪中的使用量都急剧攀升。\
	基于纳米机器的实时突发通信无法被有效监听，也难以被入侵，这让大多数私人军事公司深感忧虑，\
	于是纷纷自行研发设备。这一款是“牧马人”型 NIF 切割器，用于粗暴地把程序直接从用户框架上抹除。"
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "nifsoft_remover"
	custom_materials = list(
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/iron = SMALL_MATERIAL_AMOUNT
		)

	///Is a disk with the corresponding NIFSoft created when said NIFSoft is removed?
	var/create_disk = FALSE

/obj/item/nifsoft_remover/attack(mob/living/carbon/human/target_mob, mob/living/user)
	. = ..()
	var/obj/item/organ/cyberimp/brain/nif/target_nif = target_mob.get_organ_by_type(/obj/item/organ/cyberimp/brain/nif)

	if(!target_nif || !length(target_nif.loaded_nifsofts))
		balloon_alert(user, "[target_mob] 没有 NIFSoft！")
		return

	var/list/installed_nifsofts = target_nif.loaded_nifsofts
	var/datum/nifsoft/nifsoft_to_remove = tgui_input_list(user, "选择要移除的 NIFSoft。", "[src]", installed_nifsofts)

	if(!nifsoft_to_remove)
		return FALSE

	user.visible_message(span_warning("[user] 开始对 [target_mob] 使用 [src]"), span_notice("你开始对 [target_mob] 使用 [src]"))
	if(!do_after(user, 5 SECONDS, target_mob))
		balloon_alert(user, "已取消移除！")
		return FALSE

	if(!target_nif.remove_nifsoft(nifsoft_to_remove))
		balloon_alert(user, "移除失败！")
		return FALSE

	to_chat(user, span_notice("你成功移除了 [nifsoft_to_remove]。"))
	user.log_message("从 [target_mob] 身上移除了 [nifsoft_to_remove]" ,LOG_GAME)

	if(create_disk)
		var/obj/item/disk/nifsoft_uploader/new_disk = new
		new_disk.loaded_nifsoft = nifsoft_to_remove.type
		new_disk.name = "[nifsoft_to_remove] 数据磁盘"

		user.put_in_hands(new_disk)

	qdel(nifsoft_to_remove)

	return TRUE

/obj/item/nifsoft_remover/syndie
	name = "赛博太阳“手术刀”NIF 切割器"
	desc = "一种改装版 NIFSoft 移除器，可让使用者移除 NIFSoft，并将被移除 NIFSoft 的空白副本保存到磁盘中。"
	special_desc = "在公司世界的上层圈子里，纳米植入框架随处可见。重要目标在紧急情况下几乎总会通过 NIF 与至少一两个联络人保持持续通信。为了绕过这一麻烦，赛博太阳工业发明了“手术刀”NIF 切割器。这台装置不比 PDA 大多少，却是神经盗窃领域的馈赠，能在五秒或更短时间内从目标体内提取特定程序。此外，高级编程还让这件工具能把特定软件复制到磁盘上，供持有者自用。"
	icon_state = "nifsoft_remover_syndie"
	create_disk = TRUE

///NIF Repair Kit.
/obj/item/nif_repair_kit
	name = "蔚蓝 NIF 修复器"
	desc = "一种修复套件，无需手术即可修复 NIF。"
	special_desc = "资本主义与工业的影响根深蒂固，在纳米植入框架行业里同样如此。\
	框架这类复杂设备通常在固件层面就被锁定，只认特定“认证”品牌的修复膏或修复坞。\
	这套破解套件由交错空间巫团开发，作为自由软件替代品，在太阳系外空间广为流传，\
	以改善身处社会边缘用户的生活质量。"
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "repair_paste"
	w_class = WEIGHT_CLASS_SMALL
	///How much does this repair each time it is used?
	var/repair_amount = 20
	///How many times can this be used?
	var/uses = 5

/obj/item/nif_repair_kit/attack(mob/living/carbon/human/mob_to_repair, mob/living/user)
	. = ..()

	var/obj/item/organ/cyberimp/brain/nif/installed_nif = mob_to_repair.get_organ_by_type(/obj/item/organ/cyberimp/brain/nif)
	if(!installed_nif)
		balloon_alert(user, "[mob_to_repair] 没有 NIF")

	if(!do_after(user, 5 SECONDS, mob_to_repair))
		balloon_alert(user, "已取消修复")
		return FALSE

	if(!installed_nif.adjust_durability(repair_amount))
		balloon_alert(user, "目标 NIF 耐久度已满")
		return FALSE

	to_chat(user, span_notice("你成功修复了 [mob_to_repair] 的 NIF"))
	to_chat(mob_to_repair, span_notice("[user] 成功修复了你的 NIF"))

	uses -= 1
	if(!uses)
		qdel(src)

/obj/item/nif_hud_adapter
	name = "探视镜适配器"
	desc = "一套改装套件，可将部分眼镜改造为显示 NIF 的 HUD。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/kits.dmi'
	icon_state = "partskit"

	/// Can this item be used multiple times? If not, it will delete itself after being used.
	var/multiple_uses = FALSE
	/// List containing all of the glasses that we want to work with this.
	var/static/list/glasses_whitelist = list(
		/obj/item/clothing/glasses/trickblindfold,
		/obj/item/clothing/glasses/monocle,
		/obj/item/clothing/glasses/fake_sunglasses,
		/obj/item/clothing/glasses/regular,
		/obj/item/clothing/glasses/eyepatch,
		/obj/item/clothing/glasses/osi,
		/obj/item/clothing/glasses/phantom,
		/obj/item/clothing/glasses/salesman, // Now's your chance.
		/obj/item/clothing/glasses/nice_goggles,
		/obj/item/clothing/glasses/thin,
		/obj/item/clothing/glasses/biker,
		/obj/item/clothing/glasses/sunglasses/gar,
		/obj/item/clothing/glasses/hypno,
		/obj/item/clothing/glasses/heat,
		/obj/item/clothing/glasses/cold,
		/obj/item/clothing/glasses/orange,
		/obj/item/clothing/glasses/red,
		/obj/item/clothing/glasses/psych,
	)

/obj/item/nif_hud_adapter/examine(mob/user)
	. = ..()
	var/list/compatible_glasses_names = list()
	for(var/obj/item/glasses_type as anything in glasses_whitelist)
		var/glasses_name = initial(glasses_type.name)
		if(!glasses_name)
			continue

		compatible_glasses_names += glasses_name

	if(length(compatible_glasses_names))
		. += span_cyan("\n 该物品可用于以下眼镜：[english_list(compatible_glasses_names)]。")

	return .

/obj/item/nif_hud_adapter/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/item/clothing/glasses/target_glasses = interacting_with
	if(!istype(target_glasses) || !is_type_in_list(target_glasses, glasses_whitelist))
		balloon_alert(user, "不兼容！")
		return NONE

	if(HAS_TRAIT(target_glasses, TRAIT_NIFSOFT_HUD_GRANTER))
		balloon_alert(user, "已升级过了！")
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[user] 用 [src] 升级了 [target_glasses]。"), span_notice("你把 [target_glasses] 升级为兼容 NIF HUD。"))
	target_glasses.name = "\improper 已升级 HUD 的" + target_glasses.name
	target_glasses.AddElement(/datum/element/nifsoft_hud)
	playsound(target_glasses.loc, 'sound/items/weapons/circsawhit.ogg', 50, vary = TRUE)

	if(!multiple_uses)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

