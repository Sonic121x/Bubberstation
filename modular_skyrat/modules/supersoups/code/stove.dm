// clean soups
/obj/item/reagent_containers/cup/soup_pot
	/// Whether or not the pot is set to clean other reagents from soups
	var/emulsify_reagents

/obj/item/reagent_containers/cup/soup_pot/examine(mob/user)
	. = ..()
	. += "Alt右键点击[src]可以开启或关闭汤汁净化。"

// alt-right click toggles whether soups will get cleaned
/obj/item/reagent_containers/cup/soup_pot/click_alt_secondary(mob/user)
	emulsify_reagents = !emulsify_reagents
	balloon_alert(user, "汤汁净化已[emulsify_reagents ? "开启" : "关闭"]！")
