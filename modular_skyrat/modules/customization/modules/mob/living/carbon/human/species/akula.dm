/// How long the akula will stay wet for, AKA how long until they get a mood debuff
#define DRY_UP_TIME 10 MINUTES
/// How many wetstacks an Akula will get upon creation
#define WETSTACK_INITIAL 5
/// How many wetstacks an Akula needs to activate the TRAIT_SLIPPERY trait
#define WETSTACK_THRESHOLD 3

/datum/species/akula
	name = "阿库拉"
	plural_form = "阿库拉人"
	id = SPECIES_AKULA
	lore_protected = TRUE
	offset_features = list(
		OFFSET_GLASSES = list(0, 1),
		OFFSET_EARS = list(0, 2),
		OFFSET_FACEMASK = list(0, 2),
		OFFSET_HEAD = list(0, 2),
		OFFSET_HAIR = list(0, 1),
	)
	mutanteyes = /obj/item/organ/eyes/akula
	mutanttongue = /obj/item/organ/tongue/akula
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_NODROWN,
		TRAIT_SLICK_SKIN,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	outfit_important_for_life = /datum/outfit/akula
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/akula,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/akula,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/akula,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/akula,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/akula,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/akula,
	)

	meat = /obj/item/food/fishmeat/moonfish/akula

	/// This variable stores the timer datum which appears if the mob becomes wet
	var/dry_up_timer = TIMER_ID_NULL

/datum/species/akula/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Akula", TRUE),
		"legs" = list("Normal Legs", FALSE),
	)

/datum/species/akula/get_species_description()
	return list("阿库拉是一种形似鲨鱼的人形种族，来自一颗以海洋为主的母星——阿祖莱亚。他们通常身材高大，皮肤光滑，与地球上的鲨鱼不同，但在生理结构上却与那些鲨鱼有许多相似之处，包括能提供浮力的肝脏，以及储存氯气、饮用海水而不受伤害的能力。他们水陆两栖，皮肤能在短时间内保持少量水分。他们还拥有鲨鱼那样可以脱臼的下颌，以及不断再生、从不固定的牙齿。",
	)

/datum/species/akula/get_species_lore()
	return list("阿库拉人曾因母星而被称作阿祖莱亚人，以骄傲和武艺闻名。他们是一个民主的民族，推翻了曾统治他们的旧封建君主制，如今作为神秘的索阿托帝国的民主附庸而生活。",
	"在民主联盟建立之前，阿库拉由一支历史悠久的王室血脉——阿古尔卡尔家族——统治，其渊源可追溯至远古时代。由于数位女王不愿与任何人交配，转而进行孤雌生殖，导致后代出现精神和身体上的畸形，这条血脉常常由极其腐败、精神极不健全的统治者延续。时至今日，那些逃往阿库拉空间边缘的幸存旧贵族，仍背负着旧贵族是一群堕落、不稳定、无能的享乐主义者的名声。",
	"如今，阿库拉人分裂为三个派系：阿库拉民主联盟，阿库拉人的主要政府；旧贵族，他们逃到阿库拉空间边缘，仍在为谁才理应继承已断绝的阿古尔卡尔血脉而争吵不休；以及边疆诸侯国，这些基本上独立的边疆领地由商业亲王、旧贵族，偶尔还有佣兵匪王组成。",
	"阿库拉民主联盟是三者中最大的，占据了阿库拉空间的大部分，首府设在阿祖莱亚。它是一个代议制民主政体，各世界的代表与民选的总统和副总统共同治理阿库拉。民主联盟的阿库拉人往往极具社群意识、关系紧密，常结成牢固的社交网络，并以规模盛大、频繁举行的庆典闻名。说来好笑，民主联盟还拥有一个银河闻名的摔角娱乐产业。",
	"旧贵族曾是旧阿祖莱亚人的领主与主人，如今在推翻其统治的革命迫害下逃亡，被贬至阿库拉空间的边缘。人们普遍认为这些旧贵族是一群卑劣、落后、耽于享乐的纨绔，痴迷于荣誉与血统。他们惯常鼓吹阿祖莱亚人的基因优越论，试图用基因改造让自己的臣民变成阿祖莱亚人，并为了谁才应当合法继承断绝的阿古尔卡尔血脉而彼此争吵不休。这些虚饰排场的可鄙存在大多名副其实，但也有少数人过去和现在都不那么令人不齿。",
	"边疆诸侯国由诸多相对较小的领地组成，它们以各自的方式拒绝接受民主联盟或先前的阿古尔卡尔王国的统治。这些诸侯国由商业亲王、思想独立的低级贵族以及其他独立势力统治，其中最大的是富有而投机的哈科宁诸侯国，它已与民主联盟达成协议，成为其通往银河其他地区的唯一贸易入口。这些边疆国家的文化如同其统治者一样多样；有些是一切皆可标价的资本主义天堂，另一些则是由疯子或富有的退役佣兵统治的残酷专制独裁。",
	"这三个派系分歧极深，分属各派的人常常发生冲突。然而，无论属于哪一派，大多数阿库拉人都以骄傲、对朋友、家人与理想的忠诚，以及对故乡海洋和曾与他们共处的鲸类的热爱而广为人知。",
	)

/datum/species/akula/randomize_features()
	var/list/features = ..()
	var/main_color
	var/secondary_color
	var/tertiary_color
	var/random = rand(1, 4)
	switch(random)
		if(1)
			main_color = "#1CD3E5"
			secondary_color = "#6AF1D6"
			tertiary_color = "#CCF6E2"
		if(2)
			main_color = "#CF3565"
			secondary_color = "#d93554"
			tertiary_color = "#fbc2dd"
		if(3)
			main_color = "#FFC44D"
			secondary_color = "#FFE85F"
			tertiary_color = "#FFF9D6"
		if(4)
			main_color = "#DB35DE"
			secondary_color = "#BE3AFE"
			tertiary_color = "#F5E2EE"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	features[FEATURE_MUTANT_COLOR_THREE] = tertiary_color
	return features

/datum/species/akula/prepare_human_for_preview(mob/living/carbon/human/akula)
	var/main_color = "#1CD3E5"
	var/secondary_color = "#6AF1D6"
	var/tertiary_color = "#CCF6E2"
	akula.dna.features[FEATURE_MUTANT_COLOR] = main_color
	akula.dna.features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	akula.dna.features[FEATURE_MUTANT_COLOR_THREE] = tertiary_color
	akula.dna.mutant_bodyparts[FEATURE_TAIL_GENERIC] = list(MUTANT_INDEX_NAME = "Akula", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	akula.dna.features[FEATURE_LEGS] = "Normal Legs"
	regenerate_organs(akula, src, visual_only = TRUE)
	akula.update_body(TRUE)

/obj/item/organ/eyes/akula
	// Eyes over hair as bandaid for the low amounts of head matching hair
	eyes_layer = HAIR_LAYER-0.1
	eye_icon = 'modular_skyrat/modules/organs/icons/akula_eyes.dmi'

/obj/item/organ/tongue/akula
	liked_foodtypes = SEAFOOD | RAW
	disliked_foodtypes = CLOTH | DAIRY
	toxic_foodtypes = TOXIC


/datum/species/akula/get_random_body_markings(list/passed_features)
	var/datum/body_marking_set/body_marking_set = GLOB.body_marking_sets["Akula"]
	var/list/markings = list()
	if(body_marking_set)
		markings = assemble_body_markings_from_set(body_marking_set, passed_features, src)
	return markings

/datum/species/akula/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	if(job?.akula_outfit)
		equipping.equipOutfit(job.akula_outfit, visuals_only)
	else
		give_important_for_life(equipping)

// Wet_stacks handling
// more about grab_resists in `code\modules\mob\living\living.dm` at li 1119
// more about slide_distance in `code\game\turfs\open\_open.dm` at li 233
/// Lets register the signal which calls when we are above 10 wet_stacks
/datum/species/akula/on_species_gain(mob/living/carbon/akula, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	RegisterSignal(akula, COMSIG_MOB_TRIGGER_WET_SKIN, PROC_REF(wetted), akula)
	// lets give 15 wet_stacks on initial
	akula.set_wet_stacks(WETSTACK_INITIAL, remove_fire_stacks = FALSE)

/// Remove the signal on species loss
/datum/species/akula/on_species_loss(mob/living/carbon/akula, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(akula, COMSIG_MOB_TRIGGER_WET_SKIN)

/// This proc is called when a mob with TRAIT_SLICK_SKIN gains over 10 wet_stacks
/datum/species/akula/proc/wetted(mob/living/carbon/akula)
	SIGNAL_HANDLER
	// Apply the slippery trait if its not there yet
	if(!HAS_TRAIT(akula, TRAIT_SLIPPERY))
		ADD_TRAIT(akula, TRAIT_SLIPPERY, SPECIES_TRAIT)

	// Relieve the negative moodlet
	akula.clear_mood_event("dry_skin")
	// The timer which will initiate above 10 wet_stacks, and call dried() once the timer runs out
	dry_up_timer = addtimer(CALLBACK(src, PROC_REF(dried), akula), DRY_UP_TIME, TIMER_UNIQUE | TIMER_STOPPABLE)

/// This proc is called after a mob with the TRAIT_SLIPPERY has its related timer run out
/datum/species/akula/proc/dried(mob/living/carbon/akula)
	// A moodlet which will not go away until the user gets wet
	akula?.add_mood_event("dry_skin", /datum/mood_event/dry_skin)

/// A simple overwrite which calls parent to listen to wet_stacks
/datum/status_effect/fire_handler/wet_stacks/tick(delta_time)
	. = ..()
	if(!owner)
		return
	if(HAS_TRAIT(owner, TRAIT_SLICK_SKIN) && stacks >= WETSTACK_THRESHOLD)
		SEND_SIGNAL(owner, COMSIG_MOB_TRIGGER_WET_SKIN)

	if(HAS_TRAIT(owner, TRAIT_SLIPPERY) && stacks <= 0.5) // Removed just before we hit 0 and delete the /status_effect/
		REMOVE_TRAIT(owner, TRAIT_SLIPPERY, SPECIES_TRAIT)

#undef DRY_UP_TIME
#undef WETSTACK_INITIAL
#undef WETSTACK_THRESHOLD
