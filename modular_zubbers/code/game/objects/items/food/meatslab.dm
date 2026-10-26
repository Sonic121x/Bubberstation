/obj/item/food/meat/slab/drakebait
	name = "调味歌利亚肉"
	desc = "一块受到母体卷须影响的歌利亚肉，对灰烬幼龙来说格外美味。其中某种东西能让它们安静下来，脱落多余的鳞片。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 20,
		/datum/reagent/toxin = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 5,
	)
	icon_state = "bearsteak"
	tastes = list("肉" = 1)
	foodtypes = MEAT | TOXIC
