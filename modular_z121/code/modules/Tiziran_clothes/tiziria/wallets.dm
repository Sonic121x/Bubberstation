// Tailbags
/obj/item/storage/wallet/tailbag
	name = "尾挂钱包"
	desc = "仿照提兹拉军用尾包制作的钱包，将蜥蜴专用的固定绑带换成了可调节绑带。为避免过重的物品压伤尾巴，它缩小了尺寸，成了无法像原版那样装载物品的钱包。"
	icon = 'modular_z121/icons/Tiziran_clothes/tiziria/storage.dmi'
	icon_state = "tailbag"
	worn_icon = 'modular_z121/icons/Tiziran_clothes/tiziria/Tail_wallets.dmi'
	worn_icon_state ="tailbag_reg"


/obj/item/storage/wallet/tailbag/update_icon_state()
	. = ..()
	icon_state = initial(icon_state)
	// Don't update icons
	return
