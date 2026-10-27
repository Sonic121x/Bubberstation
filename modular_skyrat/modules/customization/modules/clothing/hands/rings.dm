/obj/item/clothing/gloves/ring
	icon = 'modular_skyrat/master_files/icons/obj/ring.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	name = "金戒指"
	desc = "一枚小小的金戒指，大小刚好能套在手指上。"
	gender = NEUTER
	w_class = WEIGHT_CLASS_TINY
	icon_state = "ringgold"
	inhand_icon_state = null
	worn_icon_state = "gring"
	body_parts_covered = 0
	strip_delay = 4 SECONDS
	clothing_traits = list(TRAIT_FINGERPRINT_PASSTHROUGH)

/obj/item/clothing/gloves/ring/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("\[user] 正把 [src] 塞进嘴里！看起来 [user] 想被 [src] 噎死！"))
	return OXYLOSS


/obj/item/clothing/gloves/ring/diamond
	name = "钻戒"
	desc = "一枚镶着钻石的昂贵戒指。千年来，各种文化都在求偶时使用这样的戒指。"
	icon_state = "ringdiamond"
	worn_icon_state = "dring"

/obj/item/clothing/gloves/ring/diamond/attack_self(mob/user)
	user.visible_message(span_warning("\The [user] 单膝跪地，呈上 \the [src]。"),span_warning("你单膝跪地，呈上 \the [src]。"))

/obj/item/clothing/gloves/ring/silver
	name = "银戒指"
	desc = "一枚小小的银戒指，大小刚好能套在手指上。"
	icon_state = "ringsilver"
	worn_icon_state = "sring"
