/obj/item/seeds/cotton
	name = "棉花种子包"
	desc = "一包会生长成棉花植株的种子。"
	icon_state = "seed-cotton"
	species = "cotton"
	plantname = "棉花"
	icon_harvest = "cotton-harvest"
	product = /obj/item/grown/cotton
	lifespan = 35
	endurance = 25
	maturation = 15
	production = 1
	yield = 2
	potency = 50
	instability = 15
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing.dmi'
	icon_dead = "cotton-dead"
	mutatelist = list(/obj/item/seeds/cotton/durathread)

/obj/item/grown/cotton
	seed = /obj/item/seeds/cotton
	name = "棉花捆"
	desc = "一捆蓬松的棉花。"
	icon_state = "cotton"
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 2
	throw_range = 3
	attack_verb_continuous = list("pomfs")
	attack_verb_simple = list("pomf")
	var/cotton_type = /obj/item/stack/sheet/cotton
	var/cotton_name = "原棉"

/obj/item/grown/cotton/attack_self(mob/user)
	var/cotton_count = 1
	if(seed)
		cotton_count += round(seed.potency / 25)

	user.balloon_alert(user, "采下了 [cotton_count] 团棉花")
	new cotton_type(user.drop_location(), cotton_count)
	qdel(src)


//reinforced mutated variant
/obj/item/seeds/cotton/durathread
	name = "耐久纤维种子包"
	desc = "一包会生长成极其坚韧纤维的种子，若纺织得当，其强度足以媲美塑钢。"
	icon_state = "seed-durathread"
	species = "durathread"
	plantname = "耐久纤维"
	icon_harvest = "durathread-harvest"
	product = /obj/item/grown/cotton/durathread
	lifespan = 80
	endurance = 50
	maturation = 15
	production = 1
	yield = 2
	potency = 50
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing.dmi'
	icon_dead = "cotton-dead"
	mutatelist = null

/obj/item/grown/cotton/durathread
	seed = /obj/item/seeds/cotton/durathread
	name = "耐久纤维捆"
	desc = "一捆结实的耐久纤维，祝你顺利把它拆开。"
	icon_state = "durathread"
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 2
	throw_range = 3
	attack_verb_continuous = list("猛击", "重捶", "狠砸", "狠抽")
	attack_verb_simple = list("猛击", "重捶", "狠砸", "狠抽")
	cotton_type = /obj/item/stack/sheet/cotton/durathread
	cotton_name = "原始耐久纤维"
