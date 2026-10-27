/obj/item/mod/module/smartgun
	name = "MOD 智能机枪模块"
	desc = "一个厚重笨大的模块，附着在 MOD 外骨骼背部，这个 \
			模块由两部分组成：一个枪套，以及 M63A4“智能机枪”。 \
			枪套可作为存放一把本来无法携带的枪械的容器， \
			而枪械本身以极快的射速开火，凭借敌我识别技术， \
			能够在压制敌人的同时不伤及队友。"
	icon_state = "smartgun"
	icon = 'modular_skyrat/modules/marines/icons/items/module.dmi'
	overlay_icon_file = 'modular_skyrat/modules/marines/icons/mobs/mod_modules.dmi'
	module_type = MODULE_ACTIVE
	complexity = 3
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	device = /obj/item/gun/ballistic/automatic/smart_machine_gun
	incompatible_modules = list(/obj/item/mod/module/smartgun)
	cooldown_time = 0.5 SECONDS
	overlay_state_inactive = "module_smartgun_off" //appears on back when it's off
	overlay_state_active = "module_smartgun_on"
	required_slots = list(ITEM_SLOT_GLOVES)
	/// Power consumed per bullet fired
	var/power_per_bullet = 25

/obj/item/mod/module/smartgun/on_activation()
	. = ..()
	RegisterSignal(device, COMSIG_GUN_FIRED, PROC_REF(consume_energy))

/obj/item/mod/module/smartgun/proc/consume_energy(mob/user, atom/target, params, zone_override)
	SIGNAL_HANDLER

	drain_power(power_per_bullet)

/obj/item/mod/module/smartgun/marines
	removable = FALSE //no stealing!!
