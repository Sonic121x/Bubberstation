// Magic Mirror Character Application
/obj/structure/mirror/magic/attack_hand(mob/living/carbon/human/user)
	var/user_input = tgui_alert(user, "要应用你已载入的角色吗？","确认", list("Yes!", "No"))

	if(user_input == "Yes!")
		user?.client?.prefs?.safe_transfer_prefs_to(user)
		return TRUE

	return ..()
