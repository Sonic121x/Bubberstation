#define BRASS_TOOLSPEED_MOD 0.5

/obj/item/wirecutters/brass
	name = "黄铜剪线钳"
	desc = "一把黄铜制成的剪线钳。握柄摸起来微微温热。"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "cutters_brass"
	flags_1 = null
	random_color = FALSE
	toolspeed = BRASS_TOOLSPEED_MOD
	greyscale_config = null
	greyscale_config_belt = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

/obj/item/screwdriver/brass
	name = "黄铜螺丝刀"
	desc = "一把黄铜制成的螺丝刀。握柄摸起来温热。"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "screwdriver_brass"
	post_init_icon_state = null
	toolspeed = BRASS_TOOLSPEED_MOD
	random_color = FALSE
	greyscale_config = null
	greyscale_config_belt = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

/obj/item/weldingtool/experimental/brass
	name = "黄铜焊接工具"
	desc = "一台似乎会不断自行补充燃料的黄铜焊接工具。摸起来微微温热。"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "welder_brass"
	toolspeed = BRASS_TOOLSPEED_MOD

/obj/item/crowbar/brass
	name = "黄铜撬棍"
	desc = "一把黄铜撬棍。摸起来微微温热。"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "crowbar_brass"
	worn_icon_state = "crowbar"
	toolspeed = BRASS_TOOLSPEED_MOD

/obj/item/wrench/brass
	name = "黄铜扳手"
	desc = "一把黄铜扳手。摸起来微微温热。"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "wrench_brass"
	toolspeed = BRASS_TOOLSPEED_MOD

/obj/item/storage/belt/utility/clock
	name = "旧工具腰带"
	desc = "用于存放工具。不过这条腰带已经有些年头了。一侧皮革上粗糙地刻着一个齿轮的轮廓。"

/obj/item/storage/belt/utility/clock/PopulateContents()
	new /obj/item/screwdriver/brass(src)
	new /obj/item/crowbar/brass(src)
	new /obj/item/weldingtool/experimental/brass(src)
	new /obj/item/wirecutters/brass(src)
	new /obj/item/wrench/brass(src)
	new /obj/item/multitool(src)

#undef BRASS_TOOLSPEED_MOD
