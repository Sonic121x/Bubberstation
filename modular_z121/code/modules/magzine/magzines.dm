/obj/item/ammo_box/magazine/makeshift/c22p
	name = "手枪弹匣（.22）"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "22"
	base_icon_state = "22"
	desc = "装填.22弹药的手枪弹匣，适用于消音手枪。"
	ammo_type = /obj/item/ammo_casing/makeshift/c22
	caliber = ".22"
	max_ammo = 16
	start_empty = TRUE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/makeshift/c22smg
	name = "冲锋枪弹盘（.22）"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "smg22"
	base_icon_state = "smg22"
	desc = "装填.22弹药的冲锋枪弹盘，适用于.22冲锋枪。"
	ammo_type = /obj/item/ammo_casing/makeshift/c22
	caliber = ".22"
	max_ammo = 60
	start_empty = TRUE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/makeshift/c308
	name = "加兰德漏夹（.308）"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "garand"
	base_icon_state = "garand"
	desc = "加兰德步枪用漏夹。"
	ammo_type = /obj/item/ammo_casing/makeshift/c308
	caliber = ".308"
	max_ammo = 8
	start_empty = TRUE
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/makeshift/c556mm10
	name = "10发弹匣（5.56x45mm）"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "556r10"
	base_icon_state = "556r10"
	desc = "适用于步枪的5.56x45mm弹匣。"
	ammo_type = /obj/item/ammo_casing/makeshift/c556mm
	caliber = "5.56x45"
	max_ammo = 10
	start_empty = TRUE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/makeshift/c556mm10/c556mm20
	name = "20发弹匣（5.56x45mm）"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "556r20"
	base_icon_state = "556r20"
	desc = "适用于步枪的5.56x45mm弹匣。"
	ammo_type = /obj/item/ammo_casing/makeshift/c556mm
	caliber = "5.56x45"
	max_ammo = 20
	start_empty = TRUE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/makeshift/c30810
	name = "5发弹匣（.308）"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "r308"
	base_icon_state = "r308"
	desc = "适用于步枪的.308弹匣。"
	ammo_type = /obj/item/ammo_casing/makeshift/c308
	caliber = ".308"
	max_ammo = 5
	start_empty = TRUE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/makeshift/m3
	name = "30发弹匣（9mm）"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "smg9mm"
	base_icon_state = "smg9mm"
	desc = "适用于M3冲锋枪的9mm弹匣。"
	ammo_type = /obj/item/ammo_casing/c9mm/makeshift
	caliber = CALIBER_9MM
	max_ammo = 30
	start_empty = TRUE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/makeshift/glock
	name = "17发弹匣（9mm）"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "glock"
	base_icon_state = "glock"
	desc = "适用于格洛克手枪的9mm弹匣。"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 17
	start_empty = FALSE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/makeshift/g3
	name = "20发G3弹匣（7.62x51mm）"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "g3"
	base_icon_state = "g3"
	desc = "适用于步枪的7.62x51mm弹匣。"
	ammo_type = /obj/item/ammo_casing/makeshift/c762
	caliber = "7.62x51"
	max_ammo = 20
	start_empty = FALSE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/makeshift/hksmg
	name = "40发弹鼓（5.7x28mm）"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "hksmg"
	base_icon_state = "hksmg"
	desc = "适用于AP-5冲锋枪的5.7x28mm弹鼓。"
	ammo_type = /obj/item/ammo_casing/makeshift/c57
	caliber = "5.7x28"
	max_ammo = 40
	start_empty = FALSE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/makeshift/steyr
	name = "24发弹匣（5.56x45mm环形底火SCF镖弹）"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "urifle"
	base_icon_state = "urifle"
	desc = "装填5.56x45mm环形底火SCF镖弹的弹匣，适用于ACR原型镖弹突击步枪。"
	ammo_type = /obj/item/ammo_casing/makeshift/c556flechette
	caliber = "5.56x45 flechette"
	max_ammo = 24
	start_empty = FALSE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/makeshift/nikonov
	name = "30发弹匣（5.45x39mm）"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "abrifle"
	base_icon_state = "abrifle"
	desc = "适用于AN-94突击步枪的5.45x39mm弹匣。"
	ammo_type = /obj/item/ammo_casing/makeshift/c545
	caliber = "5.45x39"
	max_ammo = 30
	start_empty = FALSE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/datum/crafting_bench_recipe/c308clip
	recipe_name = "加兰德漏夹（.308）"
	recipe_requirements = list(
		/obj/item/stack/sheet/iron = 2,
		/obj/item/gun_parts/spring = 1.
	)
	resulting_item = /obj/item/ammo_box/magazine/makeshift/c308

/datum/crafting_bench_recipe/c22smg
	recipe_name = "冲锋枪弹盘（.22）"
	recipe_requirements = list(
		/obj/item/stack/sheet/iron = 10,
		/obj/item/gun_parts/spring = 1.
	)
	resulting_item = /obj/item/ammo_box/magazine/makeshift/c22smg

/datum/crafting_bench_recipe/c22p
	recipe_name = "手枪弹匣（.22）"
	recipe_requirements = list(
		/obj/item/stack/sheet/iron = 2,
		/obj/item/gun_parts/spring = 1.
	)
	resulting_item = /obj/item/ammo_box/magazine/makeshift/c22p

/datum/crafting_bench_recipe/c556mm10
	recipe_name = "10发弹匣（5.56mm）"
	recipe_requirements = list(
		/obj/item/stack/sheet/iron = 2,
		/obj/item/gun_parts/spring = 1.
	)
	resulting_item = /obj/item/ammo_box/magazine/makeshift/c556mm10

/datum/crafting_bench_recipe/c556mm20
	recipe_name = "20发弹匣（5.56mm）"
	recipe_requirements = list(
		/obj/item/stack/sheet/iron = 5,
		/obj/item/gun_parts/spring = 1.
	)
	resulting_item = /obj/item/ammo_box/magazine/makeshift/c556mm10/c556mm20

/datum/crafting_bench_recipe/c30810
	recipe_name = "5发弹匣（.308）"
	recipe_requirements = list(
		/obj/item/stack/sheet/iron = 2,
		/obj/item/gun_parts/spring = 1.
	)
	resulting_item = /obj/item/ammo_box/magazine/makeshift/c30810


/datum/crafting_bench_recipe/m3
	recipe_name = "30发弹匣（9mm）"
	recipe_requirements = list(
		/obj/item/stack/sheet/iron = 2,
		/obj/item/gun_parts/spring = 1.
	)
	resulting_item = /obj/item/ammo_box/magazine/makeshift/m3
