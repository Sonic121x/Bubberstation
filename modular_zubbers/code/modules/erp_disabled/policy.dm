// 自定义修改：统一成人内容禁用策略；普通服饰不按目录或名称屏蔽。
/proc/erp_content_blocked(content_type)
	if(!ispath(content_type))
		return FALSE
	if(ispath(content_type, /datum/quirk))
		var/datum/quirk/quirk_type = content_type
		return initial(quirk_type.erp_quirk)
	if(ispath(content_type, /datum/nifsoft))
		var/datum/nifsoft/software_type = content_type
		return initial(software_type.lewd_nifsoft)
	if(ispath(content_type, /obj/item/disk/nifsoft_uploader))
		var/obj/item/disk/nifsoft_uploader/disk_type = content_type
		return erp_content_blocked(initial(disk_type.loaded_nifsoft))
	var/static/list/blocked_types // 自定义修改：延迟构建缓存，避免全局初始化时相互依赖
	if(isnull(blocked_types))
		blocked_types = typecacheof(list(
			/datum/reagent/consumable/breast_milk,
			/datum/reagent/consumable/cum,
			/datum/reagent/consumable/femcum,
			/datum/reagent/drug/aphrodisiac,
			/datum/reagent/generic_milked_venom, // 自定义修改：屏蔽催情之咬的抽取产物
			/datum/reagent/mkultra, // 自定义修改：屏蔽带成人催眠指令的药物
			/datum/action/cooldown/mob_cooldown/aphrodisiacal_bite, // 自定义修改：禁止单独授予催情之咬动作
			/datum/brain_trauma/very_special/bimbo,
			/datum/brain_trauma/very_special/neverboner,
			/datum/brain_trauma/very_special/sadism,
			/obj/item/borg/upgrade/dominatrixmodule,
			/obj/item/borg/upgrade/obediencemodule,
			/obj/item/mod/module/hypno_visor,
			/obj/item/mod/module/remote_control,
			/obj/item/remote_controller,
			/datum/status_effect/aroused,
			/datum/status_effect/body_fluid_regen,
			/datum/status_effect/climax,
			/datum/status_effect/masturbation_climax,
			/datum/status_effect/mkultra, // 自定义修改：禁止成人催眠药物效果通过其他入口施加
			/obj/effect/decal/cleanable/cum,
			/obj/item/bdsm_bed_kit,
			/obj/item/bdsm_candle,
			/obj/item/breastpump,
			/obj/item/clicker,
			/obj/item/clothing/erp_leash,
			/obj/item/clothing/glasses/hypno,
			/obj/item/clothing/sextoy,
			/obj/item/clothing/strapon,
			/obj/item/condom_pack,
			/obj/item/construction_kit/bdsm,
			/obj/item/construction_kit/milker,
			/obj/item/construction_kit/pole,
			/obj/item/holosign_creator/sex,
			/obj/item/kinky_shocker,
			/obj/item/lustwish_discount,
			/obj/item/milking_machine/constructionkit,
			/obj/item/mind_controller,
			/obj/item/organ/genital,
			/obj/item/paper/shibari_kit_instructions,
			/obj/item/polepack,
			/obj/item/reagent_containers/applicator/pill/camphor,
			/obj/item/reagent_containers/applicator/pill/crocin,
			/obj/item/reagent_containers/applicator/pill/dopamine,
			/obj/item/reagent_containers/applicator/pill/hexacrocin,
			/obj/item/reagent_containers/applicator/pill/pentacamphor,
			/obj/item/reagent_containers/cup/bottle/camphor,
			/obj/item/reagent_containers/cup/bottle/crocin,
			/obj/item/reagent_containers/cup/bottle/dopamine,
			/obj/item/reagent_containers/cup/bottle/hexacrocin,
			/obj/item/reagent_containers/cup/bottle/incubus_draft,
			/obj/item/reagent_containers/cup/bottle/pentacamphor,
			/obj/item/reagent_containers/cup/bottle/succubus_milk,
			/obj/item/reagent_containers/cup/lewd_filter,
			/obj/item/reagent_containers/cup/beaker/mkultra_debug, // 自定义修改：隐藏成人催眠药物专用调试容器
			/obj/item/reagent_containers/venom_milker, // 自定义修改：隐藏催情之咬专用抽取器及其试剂说明
			/obj/item/restraints/handcuffs/lewd,
			/obj/item/restraints/handcuffs/milker,
			/obj/item/spanking_pad,
			/obj/item/storage/belt/erpbelt,
			/obj/item/storage/box/bdsmbed_kit,
			/obj/item/storage/box/milking_kit,
			/obj/item/storage/box/shibari_stand,
			/obj/item/storage/box/strippole_kit,
			/obj/item/storage/box/xstand_kit,
			/obj/item/strapon_dildo,
			/obj/item/tickle_feather,
			/obj/item/toy/plush/aeri,
			/obj/item/toy/plush/noble,
			/obj/item/toy/plush/protective_protogen,
			/obj/item/wallframe/lewd_portal,
			/obj/item/x_stand_kit,
			/obj/lewd_portal_relay,
			/obj/structure/bed/bdsm_bed,
			/obj/structure/chair/milking_machine,
			/obj/structure/chair/shibari_stand,
			/obj/structure/chair/x_stand,
			/obj/structure/holosign/sexsign,
			/obj/structure/lewd_portal,
			/obj/structure/stripper_pole,
			/obj/vore_belly,
		))
	return !!blocked_types[content_type]

/proc/erp_list_blocked(list/content_types)
	for(var/content_type in content_types)
		if(erp_content_blocked(content_type))
			return TRUE
	return FALSE

// 自定义修改：在建立反应索引前同时检查标记、产物、原料、催化剂和容器，避免配方检索泄漏成人内容。
/proc/erp_reaction_blocked(datum/chemical_reaction/reaction)
	return reaction.erp_reaction || erp_list_blocked(reaction.results) || erp_list_blocked(reaction.required_reagents) || erp_list_blocked(reaction.required_catalysts) || erp_content_blocked(reaction.required_container)

// 自定义修改：返回不含成人内容的独立候选列表，避免随机配方抽中禁用试剂或修改共享列表。
/proc/erp_filter_candidates(list/candidates)
	. = candidates.Copy()
	for(var/candidate in candidates)
		if(erp_content_blocked(candidate))
			. -= candidate

// 自定义修改：阻止直接授予成人动作，确保玩家看不到按钮且无法激活。
/datum/action/cooldown/mob_cooldown/aphrodisiacal_bite/Grant(mob/grant_to)
	return

/datum/action/cooldown/mob_cooldown/aphrodisiacal_bite/IsAvailable(feedback = FALSE)
	return FALSE // 自定义修改：禁用催情之咬的动作可用性

/datum/config_entry/flag/disable_erp_preferences/ValidateAndSet(str_val)
	config_entry_value = TRUE
	return TRUE

/datum/config_entry/flag/disable_lewd_items/ValidateAndSet(str_val)
	config_entry_value = TRUE
	return TRUE

// 自定义修改：成人售货机保留女仆装、兔女郎服饰、项圈等服饰供应，清除成人宣传和非服饰商品。
/obj/machinery/vending/dorms/proc/erp_prepare_wardrobe()
	name = "服饰衣柜"
	desc = "供应服装与配饰的自动售货机。"
	icon = 'icons/obj/machines/vending.dmi'
	icon_state = "secdrobe"
	base_icon_state = "secdrobe"
	light_mask = "wardrobe-light-mask"
	product_ads = "欢迎选购服装与配饰。"
	vend_reply = "感谢惠顾！"
	for(var/list/categories as anything in list(product_categories, zubbers_product_categories))
		for(var/list/category as anything in categories)
			category["name"] = "服饰"
			category["icon"] = "shirt"
			erp_filter_wardrobe(category["products"])
	erp_filter_wardrobe(products)
	erp_filter_wardrobe(premium)
	erp_filter_wardrobe(contraband)

/proc/erp_filter_wardrobe(list/products)
	for(var/product in products?.Copy())
		if(!ispath(product, /obj/item/clothing) || erp_content_blocked(product))
			products -= product

// 自定义修改：按偏好类型屏蔽成人设置，保留普通头像、简介、身份与服饰设置。
/proc/erp_preference_blocked(preference_type)
	var/static/list/blocked_preferences // 自定义修改：延迟构建缓存，避免全局初始化时相互依赖
	if(isnull(blocked_preferences))
		blocked_preferences = typecacheof(list(
			/datum/preference/choiced/aphrodisiacal_bite_venom, // 自定义修改：隐藏催情之咬的毒液自定义选项
			/datum/preference/choiced/breasts_size,
			/datum/preference/choiced/directory_character_prefs,
			/datum/preference/choiced/erp_sexuality,
			/datum/preference/choiced/erp_status,
			/datum/preference/choiced/erp_status_hypno,
			/datum/preference/choiced/erp_status_mechanics,
			/datum/preference/choiced/erp_status_nc,
			/datum/preference/choiced/erp_status_v,
			/datum/preference/choiced/genital,
			/datum/preference/choiced/genital/anus,
			/datum/preference/choiced/genital/belly,
			/datum/preference/choiced/genital/breasts,
			/datum/preference/choiced/genital/butt,
			/datum/preference/choiced/genital/penis,
			/datum/preference/choiced/genital/testicles,
			/datum/preference/choiced/genital/vagina,
			/datum/preference/choiced/genital/womb,
			/datum/preference/choiced/penis_sheath,
			/datum/preference/choiced/show_nsfw_flavor_text,
			/datum/preference/numeric/balls_size,
			/datum/preference/numeric/belly_size,
			/datum/preference/numeric/butt_size,
			/datum/preference/numeric/penis_girth,
			/datum/preference/numeric/penis_length,
			/datum/preference/text/flavor_text_nsfw,
			/datum/preference/text/headshot/nsfw,
			/datum/preference/text/headshot/silicon/nsfw,
			/datum/preference/text/high_arousal,
			/datum/preference/text/low_arousal,
			/datum/preference/text/medium_arousal,
			/datum/preference/toggle/allow_genitals,
			/datum/preference/toggle/art_ref_nsfw,
			/datum/preference/toggle/breasts_lactation,
			/datum/preference/toggle/erp,
			/datum/preference/toggle/erp/aphro,
			/datum/preference/toggle/erp/autocum,
			/datum/preference/toggle/erp/autoemote,
			/datum/preference/toggle/erp/bimbofication,
			/datum/preference/toggle/erp/breast_enlargement,
			/datum/preference/toggle/erp/breast_shrinkage,
			/datum/preference/toggle/erp/gender_change,
			/datum/preference/toggle/erp/genitalia_removal,
			/datum/preference/toggle/erp/hypnosis,
			/datum/preference/toggle/erp/new_genitalia_growth,
			/datum/preference/toggle/erp/penis_enlargement,
			/datum/preference/toggle/erp/penis_shrinkage,
			/datum/preference/toggle/erp/sex_toy,
			/datum/preference/toggle/erp/sex_toy_sounds,
			/datum/preference/toggle/erp/sounds,
			/datum/preference/toggle/erp/vore_overlay_options,
			/datum/preference/toggle/erp/vore_overlays,
			/datum/preference/toggle/erp_free_use,
			/datum/preference/toggle/genital_skin_color,
			/datum/preference/toggle/genital_skin_color/belly,
			/datum/preference/toggle/genital_skin_color/breasts,
			/datum/preference/toggle/genital_skin_color/butt,
			/datum/preference/toggle/genital_skin_color/penis,
			/datum/preference/toggle/genital_skin_color/testicles,
			/datum/preference/toggle/genital_skin_color/vagina,
			/datum/preference/toggle/genital_skin_tone,
			/datum/preference/toggle/genital_skin_tone/belly,
			/datum/preference/toggle/genital_skin_tone/breasts,
			/datum/preference/toggle/genital_skin_tone/butt,
			/datum/preference/toggle/genital_skin_tone/penis,
			/datum/preference/toggle/genital_skin_tone/testicles,
			/datum/preference/toggle/genital_skin_tone/vagina,
			/datum/preference/toggle/master_erp_preferences,
			/datum/preference/toggle/penis_taur_mode,
			/datum/preference/tri_bool/genital,
			/datum/preference/tri_bool/genital/belly,
			/datum/preference/tri_bool/genital/breasts,
			/datum/preference/tri_bool/genital/butt,
			/datum/preference/tri_bool/genital/penis,
			/datum/preference/tri_bool/genital/testicles,
			/datum/preference/tri_bool/genital/vagina,
			/datum/preference/tri_color/genital,
			/datum/preference/tri_color/genital/belly,
			/datum/preference/tri_color/genital/breasts,
			/datum/preference/tri_color/genital/butt,
			/datum/preference/tri_color/genital/penis,
			/datum/preference/tri_color/genital/testicles,
			/datum/preference/tri_color/genital/vagina,
		))
	return !!blocked_preferences[preference_type]
