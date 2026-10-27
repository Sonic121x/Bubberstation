// Dairy

/datum/glass_style/has_foodtype/drinking_glass/milk
	required_drink_type = /datum/reagent/consumable/milk
	name = "一杯牛奶"
	desc = "洁白又营养，美味极了！"
	drink_type = DAIRY | BREAKFAST

/datum/glass_style/has_foodtype/juicebox/milk
	required_drink_type = /datum/reagent/consumable/milk
	name = "一盒牛奶"
	desc = "为茁壮成长的太空探险者提供优质钙源的佳品。"
	icon_state = "milkbox"
	drink_type = DAIRY | BREAKFAST

/datum/glass_style/has_foodtype/juicebox/chocolate_milk
	required_drink_type = /datum/reagent/consumable/milk/chocolate_milk
	name = "一盒巧克力奶"
	desc = "给酷小孩准备的奶！"
	icon_state = "chocolatebox"
	drink_type = SUGAR | DAIRY

/datum/glass_style/drinking_glass/soymilk
	required_drink_type = /datum/reagent/consumable/soymilk
	name = "一杯豆奶"
	desc = "洁白又营养的大豆精华！"

/datum/glass_style/drinking_glass/cream
	required_drink_type = /datum/reagent/consumable/cream
	name = "一杯奶油"
	desc = "呃……"

/datum/glass_style/drinking_glass/coconut_milk
	required_drink_type = /datum/reagent/consumable/coconut_milk
	name = "一杯椰奶"
	desc = "热带的精华，安全地盛在玻璃杯中。"
	icon = 'icons/obj/drinks/drinks.dmi'
