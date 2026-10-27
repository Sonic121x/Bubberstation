// Re-labels TG brainproblems to be more generic. There never was a tumor anyways!
/datum/quirk/item_quirk/brainproblems
	name = "Brain Degeneration"
	desc = "你患有致命的脑部疾病，正在缓慢摧毁你的大脑。最好带上甘露醇！"
	medical_record_text = "患者患有致命的脑部疾病，正逐渐走向脑死亡。"
	icon = FA_ICON_BRAIN

// Override of Brain Tumor quirk for robotic/synthetic species with posibrains.
// Does not appear in TGUI or the character preferences window.
/datum/quirk/item_quirk/brainproblems/synth
	name = "Positronic Cascade Anomaly"
	desc = "你的正电子脑因级联异常而逐渐损坏。最好带上液态焊料！"
	gain_text = "<span class='danger'>你感觉自己出了故障。</span>"
	lose_text = "<span class='notice'>你不再感觉自己出了故障。</span>"
	medical_record_text = "患者脑中存在级联异常，正逐渐导致脑死亡。"
	icon = FA_ICON_BRAZILIAN_REAL_SIGN
	mail_goodies = list(/obj/item/storage/pill_bottle/liquid_solder/braintumor)
	hidden_quirk = TRUE

// If brainproblems is added to a synth, this detours to the brainproblems/synth quirk.
// TODO: Add more brain-specific detours when PR #16105 is merged
/datum/quirk/item_quirk/brainproblems/add_to_holder(mob/living/new_holder, quirk_transfer = FALSE, client/client_source, unique = TRUE, announce = TRUE)
	if(!issynthetic(new_holder) || type != /datum/quirk/item_quirk/brainproblems)
		// Defer to TG brainproblems if the character isn't robotic.
		return ..()

	// TODO: Check brain type and detour to appropriate brainproblems quirk
	var/datum/quirk/item_quirk/brainproblems/synth/bp_synth = new
	qdel(src)
	return bp_synth.add_to_holder(new_holder, quirk_transfer, client_source, unique)

// Synthetics get liquid_solder with Brain Tumor instead of mannitol.
/datum/quirk/item_quirk/brainproblems/synth/add_unique(client/client_source)
	give_item_to_holder(
		/obj/item/storage/pill_bottle/liquid_solder/braintumor,
		list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		),
		flavour_text = "这些能让你撑到找到稳定药物供应的时候。别太依赖它们！",
	)
