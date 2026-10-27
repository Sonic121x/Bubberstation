/*
CONTAINS:
/obj/item/ai_module/law/core/full/damaged
/obj/item/ai_module/law/toy_ai
*/

/obj/item/ai_module/law/core/full/damaged
	name = "受损的 AI 核心模块"
	desc = "用于向 AI 写入法则的模块。看起来有些受损。"

/obj/item/ai_module/law/core/full/damaged/Initialize(mapload)
	. = ..()
	set_ioned(TRUE)

/obj/item/ai_module/law/core/full/damaged/proc/gen_laws()
	laws.Cut()
	while(!length(laws) && prob(75))
		laws[generate_ion_law()] = TRUE

/obj/item/ai_module/law/core/full/damaged/on_rack_install(obj/machinery/ai_law_rack/rack)
	gen_laws()

/obj/item/ai_module/law/core/full/damaged/multitool_act(mob/living/user, obj/item/tool)
	balloon_alert(user, "正在修复离子损伤……？")
	if(!tool.use_tool(ismachinery(loc) ? loc : src, user, 4 SECONDS, volume = 25, extra_checks = CALLBACK(src, PROC_REF(multitool_cb), loc, user, tool)))
		return ITEM_INTERACT_BLOCKING
	balloon_alert(user, "模块已修复……？")
	if(ismachinery(loc))
		gen_laws()
		update_rack_laws()
	return ITEM_INTERACT_SUCCESS

/obj/item/ai_module/law/toy_ai // -- Incoming //No actual reason to inherit from ion boards here, either. *sigh* ~Miauw
	name = "玩具 AI"
	desc = "小巧的玩具 AI 核心模型，具有真正的法则上传功能！" //Note: subtle tell
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "AI"
	laws = list("")

/obj/item/ai_module/law/toy_ai/apply_to_combined_lawset(datum/ai_laws/combined_lawset)
	combined_lawset.add_inherent_law(laws[1], 1, ioned = TRUE)

/obj/item/ai_module/law/toy_ai/configure(mob/user)
	. = TRUE
	laws.Cut()
	laws[generate_ion_law()] = TRUE
	to_chat(user, span_notice("你按下了[src]上的按钮。"))
	playsound(user, 'sound/machines/click.ogg', 20, TRUE)
	src.loc.visible_message(span_warning("[icon2html(src, viewers(loc))] [laws[1]]"))
