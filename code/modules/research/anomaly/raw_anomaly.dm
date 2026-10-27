/**
 * # Raw Anomaly Cores
 *
 * The current precursor to anomaly cores, these are manufactured into 'finished' anomaly cores for use in research, items, and more.
 *
 * The current amounts created is stored in `SSresearch.created_anomaly_types[ANOMALY_CORE_TYPE_DEFINE] = amount`.
 * The hard limits are in `code/__DEFINES/anomalies.dm`.
 */
/obj/item/raw_anomaly_core
	name = "原始异常核心"
	desc = "你不该看到这个。有人搞砸了。"
	icon = 'icons/obj/devices/new_assemblies.dmi'
	icon_state = "broken_state"

	/// Anomaly type
	var/obj/item/assembly/signaler/anomaly/anomaly_type

/obj/item/raw_anomaly_core/bluespace
	name = "原始蓝空间核心"
	desc = "蓝空间异常的原始核心，闪耀着光芒，充满潜能。"
	anomaly_type = /obj/item/assembly/signaler/anomaly/bluespace
	icon_state = "rawcore_bluespace"

/obj/item/raw_anomaly_core/vortex
	name = "原始漩涡核心"
	desc = "漩涡异常的原始核心。摸起来很沉。"
	anomaly_type = /obj/item/assembly/signaler/anomaly/vortex
	icon_state = "rawcore_vortex"

/obj/item/raw_anomaly_core/grav
	name = "原始重力核心"
	desc = "重力异常的原始核心。空气仿佛被它吸引。"
	anomaly_type = /obj/item/assembly/signaler/anomaly/grav
	icon_state = "rawcore_grav"

/obj/item/raw_anomaly_core/pyro
	desc = "火成异常的原始核心。摸起来是温热的。"
	name = "原始火成核心"
	anomaly_type = /obj/item/assembly/signaler/anomaly/pyro
	icon_state = "rawcore_pyro"

/obj/item/raw_anomaly_core/flux
	name = "原始通量波核心"
	desc = "通量波异常的原始核心，微微迸发着能量。"
	anomaly_type = /obj/item/assembly/signaler/anomaly/flux
	icon_state = "rawcore_flux"

/obj/item/raw_anomaly_core/hallucination
	name = "原始幻觉核心"
	desc = "幻觉异常的原始核心，让你头晕目眩。"
	anomaly_type = /obj/item/assembly/signaler/anomaly/hallucination
	icon_state = "rawcore_hallucination"

/obj/item/raw_anomaly_core/bioscrambler
	name = "原始生物扰乱核心"
	desc = "生物扰乱异常的原始核心，它在扭动。"
	anomaly_type = /obj/item/assembly/signaler/anomaly/bioscrambler
	icon_state = "rawcore_bioscrambler"

/obj/item/raw_anomaly_core/dimensional
	name = "原始维度核心"
	desc = "维度异常的原始核心，随着无限的可能而振动。"
	anomaly_type = /obj/item/assembly/signaler/anomaly/dimensional
	icon_state = "rawcore_dimensional"

/obj/item/raw_anomaly_core/ectoplasm //Has no cargo order option, but can sometimes be a roundstart pick
	name = "原始灵质核心"
	desc = "灵质异常的原始核心。它想与你分享它的秘密。"
	anomaly_type = /obj/item/assembly/signaler/anomaly/ectoplasm
	icon_state = "rawcore_dimensional"

/obj/item/raw_anomaly_core/weather
	name = "原始天气核心"
	desc = "天气异常的原始核心。它让你盼望着一个雨天。"
	anomaly_type = /obj/item/assembly/signaler/anomaly/weather
	icon_state = "rawcore_weather"

/obj/item/raw_anomaly_core/random
	name = "随机原始核心"
	desc = "你不该看到这个！"
	icon_state = "rawcore_bluespace"
	item_flags = parent_type::item_flags | ABSTRACT

/obj/item/raw_anomaly_core/random/Initialize(mapload)
	. = ..()
	var/path = pick(subtypesof(/obj/item/raw_anomaly_core))
	new path(loc)
	return INITIALIZE_HINT_QDEL

/**
 * Created the resulting core after being "made" into it.
 *
 * Arguments:
 * * newloc - Where the new core will be created
 * * del_self - should we qdel(src)
 * * count_towards_limit - should we increment the amount of created cores on SSresearch
 */
/obj/item/raw_anomaly_core/proc/create_core(newloc, del_self = FALSE, count_towards_limit = FALSE)
	. = new anomaly_type(newloc)
	if(count_towards_limit)
		SSresearch.increment_existing_anomaly_cores(anomaly_type)
	if(del_self)
		qdel(src)

/// Doesn't do anything, consolation prize if you neu
/obj/item/inert_anomaly
	name = "惰性异常核心"
	desc = "一块融合的奇异材料。对你毫无用处，但其他实验室或许会收购它。"
	icon = 'icons/obj/devices/new_assemblies.dmi'
	icon_state = "rawcore_inert"
