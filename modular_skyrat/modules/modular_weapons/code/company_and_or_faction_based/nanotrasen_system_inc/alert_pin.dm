//Alert locked pin

/obj/item/firing_pin/alert_level
	name = "警戒等级认证击针"
	var/desired_minimium_alert = SEC_LEVEL_VIOLET //For the purpose of the firing pin, we will consider violet, orange and amber as same level
	desc = "一种小型认证装置，插入枪械机匣后允许其工作。这枚被设定为仅在琥珀色或更高警戒等级下允许开火。"
	fail_message = "警戒等级不符！"

/obj/item/firing_pin/alert_level/pin_auth(mob/living/user)
	return (SSsecurity_level.current_security_level.number_level >= desired_minimium_alert)
