/obj/machinery/vending/sustenance
	name = "\improper 口粮售货机"
	desc = "一台按纳米传讯《囚犯伦理待遇协议》第 47-C 条要求供应食物的售货机。"
	product_slogans = "请慢用。;热量充足，足以支撑繁重劳动。"
	product_ads = "足够健康。;高效生产的豆腐！;嗯！太好吃了！;吃顿饭吧。;你得吃东西才能活下去！;就算是囚犯也该有口饭吃！;再来点玉米糖吧！;尝尝我们新出的冰杯！"
	light_mask = "snack-light-mask"
	icon_state = "sustenance"
	panel_type = "panel2"
	products = list(
		/obj/item/food/tofu/prison = 24,
		/obj/item/food/breadslice/moldy = 15,
		/obj/item/reagent_containers/cup/glass/ice/prison = 12,
		/obj/item/food/candy_corn/prison = 6,
		/obj/item/kitchen/spoon/plastic = 6,
	)
	contraband = list(
		/obj/item/knife = 6,
		/obj/item/kitchen/spoon = 6,
		/obj/item/reagent_containers/cup/glass/coffee = 12,
		/obj/item/tank/internals/emergency_oxygen = 6,
		/obj/item/clothing/mask/breath = 6,
	)

	refill_canister = /obj/item/vending_refill/sustenance
	default_price = PAYCHECK_LOWER
	extra_price = PAYCHECK_LOWER * 0.6
	payment_department = NO_FREEBIES

/obj/machinery/vending/sustenance/interact(mob/living/living_user)
	if(!isliving(living_user))
		return
	if(!istype(living_user.get_idcard(TRUE), /obj/item/card/id/advanced/prisoner))
		if(!req_access)
			speak("未找到有效的囚犯账户。不允许售货。")
			return
		if(!allowed(living_user))
			speak("权限无效。不允许售货。")
			return
	return ..()

/obj/item/vending_refill/sustenance
	machine_name = "口粮售货机"
	icon_state = "refill_snack"

//Labor camp subtype that uses labor points obtained from mining and processing ore
/obj/machinery/vending/sustenance/labor_camp
	name = "\improper 劳改营口粮售货机"
	desc = "一台按纳米传讯《囚犯伦理待遇协议》第 47-C 条要求供应食物的售货机。 \
			不过，如果使用者正在服刑，这台机器会用劳动点数结算商品。"
	icon_state = "sustenance_labor"
	all_products_free = FALSE
	displayed_currency_icon = "digging"
	displayed_currency_name = "劳动点"
	allow_custom = FALSE

/obj/machinery/vending/sustenance/labor_camp/proceed_payment(obj/item/card/id/advanced/prisoner/paying_scum_id, mob/living/mob_paying, datum/data/vending_product/product_to_vend, price_to_use)
	if(!istype(paying_scum_id))
		speak("我不收贿赂！请用劳动点数付款！")
		return FALSE
	if(LAZYLEN(product_to_vend.returned_products))
		price_to_use = 0 //returned items are free
	if(price_to_use && !(paying_scum_id.points >= price_to_use)) //not enough good prisoner points
		speak("你的点数不足以购买[product_to_vend.name]。")
		flick(icon_deny, src)
		return FALSE

	paying_scum_id.points -= price_to_use
	return TRUE

/obj/machinery/vending/sustenance/labor_camp/fetch_balance_to_use(obj/item/card/id/passed_id)
	if(!istype(passed_id, /obj/item/card/id/advanced/prisoner))
		return null //no points balance - no balance at all
	var/obj/item/card/id/advanced/prisoner/paying_scum_id = passed_id
	return paying_scum_id.points
