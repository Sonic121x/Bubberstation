/obj/item/firing_pin/alert_level/blue
	name = "警报等级击针"
	desired_minimium_alert = SEC_LEVEL_BLUE
	desc = "一个小型认证装置，需插入枪械机匣才能允许开火。这一个被设定为仅在蓝色警报或更高等级时才能开火。"
	fail_message = "警报等级不符！"

/obj/item/firing_pin/alert_level/pin_auth(mob/living/user)
	return (SSsecurity_level.current_security_level.number_level >= desired_minimium_alert)
