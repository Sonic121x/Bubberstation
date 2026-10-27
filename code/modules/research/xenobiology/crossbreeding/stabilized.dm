/*
Stabilized extracts:
	Provides a passive buff to the holder.
*/

//To add: Create an effect in crossbreeding/_status_effects.dm with the name "/datum/status_effect/stabilized/[color]"
//Status effect will automatically be applied while held, and lost on drop.

/obj/item/slimecross/stabilized
	name = "稳定提取物"
	desc = "它看起来毫无活性，但被它触碰的东西都会泛起柔和的光……"
	effect = "stabilized"
	icon_state = "stabilized"
	var/datum/status_effect/linked_effect

/obj/item/slimecross/stabilized/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj,src)

/obj/item/slimecross/stabilized/Destroy()
	STOP_PROCESSING(SSobj,src)
	qdel(linked_effect)
	return ..()

/// Returns the mob that is currently holding us if we are either in their inventory or a backpack analogue.
/// Returns null if it's in an invalid location, so that we can check explicitly for null later.
/obj/item/slimecross/stabilized/proc/get_held_mob()
	if(isnull(loc))
		return null
	if(isliving(loc))
		return loc
	// Snowflake check for modsuit backpacks, which should be valid but are 3 rather than 2 steps from the owner
	if(istype(loc, /obj/item/mod/module/storage))
		var/obj/item/mod/module/storage/mod_backpack = loc
		var/mob/living/modsuit_wearer = mod_backpack.mod?.wearer
		return modsuit_wearer ? modsuit_wearer : null
	var/nested_loc = loc.loc
	if (isliving(nested_loc))
		return nested_loc
	return null

/obj/item/slimecross/stabilized/process()
	var/mob/living/holder = get_held_mob()
	if(isnull(holder))
		return
	var/effectpath = /datum/status_effect/stabilized
	var/static/list/effects = subtypesof(/datum/status_effect/stabilized)
	for(var/datum/status_effect/stabilized/effect as anything in effects)
		if(initial(effect.colour) != colour)
			continue
		effectpath = effect
		break
	if (holder.has_status_effect(effectpath))
		return
	holder.apply_status_effect(effectpath, src)
	return PROCESS_KILL

//Colors and subtypes:
/obj/item/slimecross/stabilized/grey
	colour = SLIME_TYPE_GREY
	effect_desc = "使史莱姆对持有者友好"

/obj/item/slimecross/stabilized/orange
	colour = SLIME_TYPE_ORANGE
	effect_desc = "被动地尝试把持有者的体温升高或降低至正常水平"

/obj/item/slimecross/stabilized/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "提供再生效果"

/obj/item/slimecross/stabilized/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "使持有者不会在水、肥皂或泡沫上滑倒。太空润滑油和冰仍然太滑。"

/obj/item/slimecross/stabilized/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "每 30 秒向持有者背包中随机一堆材料添加一张。"

/obj/item/slimecross/stabilized/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "每十秒为持有者身上的一件设备充能 10%。"

/obj/item/slimecross/stabilized/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "让指尖灼热，自动烹熟你手中的任何可微波食物。"

/obj/item/slimecross/stabilized/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "若持有者身上着火，会缓慢将其熄灭；还会润湿猴子方块等物品，造出一只猴子。"

/obj/item/slimecross/stabilized/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "减缓持有者营养流失的速度"

/obj/item/slimecross/stabilized/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "冷却两分钟；当持有者受到足够伤害时，会将其传送到安全地点。"

/obj/item/slimecross/stabilized/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "随机调整持有者的速度。"

/obj/item/slimecross/stabilized/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "创造持有者的复制体。若持有者死亡，他们将接管复制体，除非死因是斩首或肢解。"

/obj/item/slimecross/stabilized/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "每隔几秒随机改变持有者的颜色。"

/obj/item/slimecross/stabilized/red
	colour = SLIME_TYPE_RED
	effect_desc = "抵消所有由装备导致的速度变化。"

/obj/item/slimecross/stabilized/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "持有此提取物时改变持有者的名字与外貌。"

/obj/item/slimecross/stabilized/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "只要在持有者面前没有生物受到伤害，它们就不会攻击你。若和平被打破，需要两分钟才能恢复。"

/obj/item/slimecross/stabilized/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "持有时创造一只宠物。"
	var/mob_type
	var/datum/mind/saved_mind
	var/mob_name = "魔宠"

/obj/item/slimecross/stabilized/gold/proc/generate_mobtype()
	var/static/list/mob_spawn_pets = list()
	if(!length(mob_spawn_pets))
		for(var/mob/living/simple_animal/animal as anything in subtypesof(/mob/living/simple_animal))
			if(initial(animal.gold_core_spawnable) == FRIENDLY_SPAWN)
				mob_spawn_pets += animal
		for(var/mob/living/basic/basicanimal as anything in subtypesof(/mob/living/basic))
			if(initial(basicanimal.gold_core_spawnable) == FRIENDLY_SPAWN)
				mob_spawn_pets += basicanimal
	mob_type = pick(mob_spawn_pets)

/obj/item/slimecross/stabilized/gold/Initialize(mapload)
	. = ..()
	generate_mobtype()

/obj/item/slimecross/stabilized/gold/attack_self(mob/user)
	var/choice = tgui_input_list(user, "你想重置哪一项？", "魔宠调整", sort_list(list("魔宠位置", "魔宠物种", "魔宠智慧", "魔宠名称")))
	if(isnull(choice))
		return
	if(!user.can_perform_action(src))
		return
	if(isliving(user))
		var/mob/living/L = user
		if(L.has_status_effect(/datum/status_effect/stabilized/gold))
			L.remove_status_effect(/datum/status_effect/stabilized/gold)
	if(choice == "魔宠位置")
		to_chat(user, span_notice("你戳了戳 [src]，它微微颤抖。"))
		START_PROCESSING(SSobj, src)
	if(choice == "魔宠物种")
		to_chat(user, span_notice("你捏了捏 [src]，里面似乎有什么形状在变化。"))
		generate_mobtype()
		START_PROCESSING(SSobj, src)
	if(choice == "魔宠智慧")
		to_chat(user, span_notice("你碰了碰 [src]，它释放出一阵发光的脉冲。"))
		saved_mind = null
		START_PROCESSING(SSobj, src)
	if(choice == "魔宠名称")
		var/newname = sanitize_name(tgui_input_text(user, "你想更改 [mob_name] 的名字吗？", "更改名称", mob_name, MAX_NAME_LEN))
		if(newname)
			mob_name = newname
		to_chat(user, span_notice("你对着 [src] 轻声低语，它微微晃动作为回应。"))
		START_PROCESSING(SSobj, src)

/obj/item/slimecross/stabilized/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "持有者携带此提取物死亡时，会剧烈爆炸。"

/obj/item/slimecross/stabilized/black
	colour = SLIME_TYPE_BLACK
	effect_desc = "掐住别人时，持有者的双手会融化并包住对方的脖子，汲取其生命来换取食物与治疗。"

/obj/item/slimecross/stabilized/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "持有者携带此提取物时移动速度极快，还会用肾上腺素稳定你周围任何处于危急状态的人。"

/obj/item/slimecross/stabilized/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "持有者对所有伤害类型的抗性获得小幅提升。"

/obj/item/slimecross/stabilized/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "可装入再生提取物，并在持有者进入危急状态时自动使用。"
	/// Regenerative crossbreed stored to be autoused on critted owner
	var/obj/item/slimecross/regenerative/regencore

/obj/item/slimecross/stabilized/rainbow/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/slimecross/regenerative))
		return NONE

	if(regencore)
		to_chat(user, span_warning("[src] 中已经装入了一个再生杂交提取物！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把 [tool] 放入 [src]，让提取物准备好自动施用！"))
	regencore = tool
	tool.forceMove(src)
	return ITEM_INTERACT_SUCCESS
