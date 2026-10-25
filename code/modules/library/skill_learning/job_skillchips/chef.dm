/obj/item/skillchip/job/chef
	name = "B0RK-X3 技能芯片" // bork bork bork
	desc = "这枚生物芯片隐约透着大蒜味，对于一件通常被塞进使用者脑子里的东西来说，这有点奇怪。使用前请咨询营养师。"
	skill_name = "近身烹饪术"
	skill_description = "一种由技艺精湛的副主厨们发展出的特殊自卫术。没有人比厨师为守护自己的厨房打得更狠。"
	skill_icon = "utensils"
	activate_message = span_notice("你能想象出如何用武术来保卫自己的厨房。")
	deactivate_message = span_notice("你忘记了如何在厨房环境中控制肌肉来施展踢击、猛摔与擒抱。")
	/// The Chef CQC given by the skillchip.
	var/datum/martial_art/cqc/under_siege/style

/obj/item/skillchip/job/chef/Initialize(mapload)
	. = ..()
	style = new(src)
	style.refresh_valid_areas()

/obj/item/skillchip/job/chef/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	style.teach(user)

/obj/item/skillchip/job/chef/on_deactivate(mob/living/carbon/user, silent = FALSE)
	style.unlearn(user)
	return ..()
