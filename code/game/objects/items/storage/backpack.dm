/* Backpacks
 * Contains:
 * Backpack
 * Backpack Types
 * Satchel Types
 */

/*
 * Backpack
 */

/obj/item/storage/backpack
	name = "背包"
	desc = "背在背上，用来装东西。"
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "backpack"
	inhand_icon_state = "backpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK //ERROOOOO
	resistance_flags = NONE
	max_integrity = 300
	storage_type = /datum/storage/backpack
	pickup_sound = 'sound/items/handling/backpack/backpack_pickup1.ogg'
	drop_sound = 'sound/items/handling/backpack/backpack_drop1.ogg'
	equip_sound = 'sound/items/equip/backpack_equip.ogg'
	sound_vary = TRUE

/obj/item/storage/backpack/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/attack_equip)

/*
 * Backpack Types
 */

/obj/item/bag_of_holding_inert
	name = "惰性次元背包"
	desc = "目前只是一块笨重的金属，上面开有一个插槽，可用来安装蓝空间异常核心。"
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "bag_of_holding-inert"
	inhand_icon_state = "brokenpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/bag_of_holding_inert/Initialize(mapload)
	. = ..()
	var/static/list/recipes = list(/datum/crafting_recipe/boh)
	AddElement(/datum/element/slapcrafting, recipes)

/obj/item/storage/backpack/holding
	name = "次元背包"
	desc = "一个内部通向局域蓝空间口袋的背包。"
	icon_state = "bag_of_holding"
	inhand_icon_state = "holdingpack"
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION | BLUESPACE_INTERFERENCE
	armor_type = /datum/armor/backpack_holding
	storage_type = /datum/storage/bag_of_holding
	pickup_sound = null
	drop_sound = null
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 7.5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)

/datum/armor/backpack_holding
	fire = 60
	acid = 50

/obj/item/storage/backpack/holding/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正跳进[src]！看起来是想自杀。"))
	user.dropItemToGround(src, TRUE)
	user.Stun(100, ignore_canstun = TRUE)
	sleep(2 SECONDS)
	playsound(src, SFX_RUSTLE, 50, TRUE, -5)
	user.suicide_log()
	qdel(user)


/obj/item/storage/backpack/santabag
	name = "圣诞老人的礼物袋"
	desc = "太空圣诞老人用它给太空中所有乖孩子在圣诞节送礼物！哇，它可真大！"
	icon_state = "giftbag0"
	inhand_icon_state = "giftbag"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/backpack/santabag

/obj/item/storage/backpack/santabag/Initialize(mapload)
	. = ..()
	regenerate_presents()

/obj/item/storage/backpack/santabag/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]把[src]套在自己的头上并用力拉紧！看起来并不怎么有圣诞精神……"))
	return OXYLOSS

/obj/item/storage/backpack/santabag/proc/regenerate_presents()
	addtimer(CALLBACK(src, PROC_REF(regenerate_presents)), 30 SECONDS)

	var/mob/user = get(loc, /mob)
	if(!istype(user))
		return
	if(HAS_MIND_TRAIT(user, TRAIT_CANNOT_OPEN_PRESENTS))
		var/turf/floor = get_turf(src)
		var/obj/item/thing = new /obj/item/gift/mostly_anything(floor) // BUBBER EDIT - Previous: var/obj/item/thing = new /obj/item/gift/anything(floor)
		if(!atom_storage.attempt_insert(thing, user, override = TRUE, force = STORAGE_SOFT_LOCKED))
			qdel(thing)


/obj/item/storage/backpack/cultpack
	name = "战利品架"
	desc = "它既能用来携带额外装备，也能自豪地宣告你的疯狂。"
	icon_state = "backpack-cult"
	inhand_icon_state = "backpack"
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER

/obj/item/storage/backpack/clown
	name = "咯咯·冯·洪克顿"
	desc = "这是洪克公司制造的背包。"
	icon_state = "backpack-clown"
	inhand_icon_state = "clownpack"

/obj/item/storage/backpack/explorer
	name = "探险家背包"
	desc = "一款结实的背包，用来存放你的战利品。"
	icon_state = "backpack-explorer"
	inhand_icon_state = "explorerpack"

/obj/item/storage/backpack/mime
	name = "帕索包裹"
	desc = "一款为沉默工作者打造的沉默背包。沉默公司出品。"
	icon_state = "backpack-mime"
	inhand_icon_state = "mimepack"

/obj/item/storage/backpack/medic
	name = "医疗背包"
	desc = "这是一款专为无菌环境使用而设计的背包。"
	icon_state = "backpack-medical"
	inhand_icon_state = "medicalpack"

/obj/item/storage/backpack/chief_medic
	name = "首席医疗官的背包"
	desc = "一款口袋刚好够装下首席医疗官装备的背包。"
	icon_state = "backpack-chiefmedical"
	inhand_icon_state = "medicalpack"

/obj/item/storage/backpack/coroner
	name = "验尸官背包"
	desc = "这是一款专为亡灵环境使用而设计的背包。"
	icon_state = "backpack-coroner"
	inhand_icon_state = "coronerpack"

/obj/item/storage/backpack/security
	name = "安保背包"
	desc = "这是一款非常结实的背包。"
	icon_state = "backpack-security"
	inhand_icon_state = "securitypack"

/obj/item/storage/backpack/captain
	name = "舰长的背包"
	desc = "这是一款专为纳米传讯军官制作的特别背包。"
	icon_state = "backpack-captain"
	inhand_icon_state = "captainpack"

/obj/item/storage/backpack/industrial
	name = "工业背包"
	desc = "这是一款为空间站日常苦工打造的结实背包。"
	icon_state = "backpack-engineering"
	inhand_icon_state = "engiepack"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/botany
	name = "植物学背包"
	desc = "这是一款用全天然纤维制成的背包。"
	icon_state = "backpack-hydroponics"
	inhand_icon_state = "botpack"

/obj/item/storage/backpack/chemistry
	name = "化学背包"
	desc = "一款专为抵御污渍和危险液体而设计的背包。"
	icon_state = "backpack-chemistry"
	inhand_icon_state = "chempack"

/obj/item/storage/backpack/genetics
	name = "基因学背包"
	desc = "一款设计得极其结实的背包，以防有人在你面前变身绿巨人。"
	icon_state = "backpack-genetics"
	inhand_icon_state = "genepack"

/obj/item/storage/backpack/science
	name = "科研背包"
	desc = "一款特别设计的背包。耐火，还隐约有股等离子味。"
	icon_state = "backpack-science"
	inhand_icon_state = "scipack"

/obj/item/storage/backpack/virology
	name = "病毒学背包"
	desc = "一款用低致敏纤维制成的背包，有助于防止疾病传播。闻起来像猴子。"
	icon_state = "backpack-virology"
	inhand_icon_state = "viropack"

/obj/item/storage/backpack/floortile
	name = "地砖背包"
	desc = "这是一款专为地砖环境使用而设计的背包……"
	icon_state = "floortile_backpack"
	inhand_icon_state = "backpack"

/obj/item/storage/backpack/ert
	name = "紧急响应小队指挥官背包"
	desc = "一款有许多口袋的宽敞背包，由紧急响应小队的指挥官佩戴。"
	icon_state = "ert_commander"
	inhand_icon_state = "securitypack"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/ert/security
	name = "紧急响应小队安保背包"
	desc = "一款有许多口袋的宽敞背包，由紧急响应小队的安保官佩戴。"
	icon_state = "ert_security"

/obj/item/storage/backpack/ert/medical
	name = "紧急响应小队医疗背包"
	desc = "一款有许多口袋的宽敞背包，由紧急响应小队的医疗官佩戴。"
	icon_state = "ert_medical"

/obj/item/storage/backpack/ert/engineer
	name = "紧急响应小队工程师背包"
	desc = "一款有许多口袋的宽敞背包，由紧急响应小队的工程师佩戴。"
	icon_state = "ert_engineering"

/obj/item/storage/backpack/ert/janitor
	name = "紧急响应小队清洁工背包"
	desc = "一款有许多口袋的宽敞背包，由紧急响应小队的清洁工佩戴。"
	icon_state = "ert_janitor"

/obj/item/storage/backpack/ert/clown
	name = "紧急响应小队小丑背包"
	desc = "一款有许多口袋的宽敞背包，由紧急响应小队的小丑佩戴。"
	icon_state = "ert_clown"

/obj/item/storage/backpack/saddlepack
	name = "鞍袋背包"
	desc = "一种既可当坐骑鞍具、也可背在背上的背包，能随时在两种形态之间切换。容量相当大，代价是让你觉得自己简直就是一头驮骡。"
	icon = 'icons/obj/storage/ethereal.dmi'
	worn_icon = 'icons/mob/clothing/back/ethereal.dmi'
	icon_state = "saddlepack"
	storage_type = /datum/storage/backpack/saddle

// MEAT MEAT MEAT MEAT MEAT

/obj/item/storage/backpack/meat
	name = "\improper 肉"
	desc = "肉肉肉肉肉肉"
	icon_state = "meatmeatmeat"
	inhand_icon_state = "meatmeatmeat"
	force = 15
	throwforce = 15
	material_flags = MATERIAL_EFFECTS | MATERIAL_AFFECT_STATISTICS
	attack_verb_continuous = list("肉击", "肉肉击")
	attack_verb_simple = list("肉击", "肉肉击")
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 15) // MEAT
	///Sounds used in the squeak component
	var/list/meat_sounds = list('sound/effects/blob/blobattack.ogg' = 1)
	///Reagents added to the edible component on top of the meat material, ingested when you EAT the MEAT
	var/list/meat_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)
	///Eating verbs when consuming the MEAT
	var/list/eatverbs = list("吞食", "吸收", "啃咬", "食用")

/obj/item/storage/backpack/meat/Initialize(mapload)
	. = ..()
	AddComponentFrom(
		SOURCE_EDIBLE_INNATE, \
		/datum/component/edible,\
		initial_reagents = meat_reagents,\
		tastes = list("meat" = 1),\
		eatverbs = eatverbs,\
	)

	AddComponent(/datum/component/squeak, meat_sounds)

/obj/item/storage/backpack/meat/change_material_strength(datum/material/material, mat_amount, multiplier, remove)
	// Our base 15 force includes the implied meat force
	if (!istype(material, /datum/material/meat))
		return ..()

/*
 * Satchel Types
 */

/obj/item/storage/backpack/satchel
	name = "挎包"
	desc = "一款看起来很时髦的挎包。"
	icon_state = "satchel-norm"
	inhand_icon_state = "satchel-norm"

/obj/item/storage/backpack/satchel/leather
	name = "皮革挎包"
	desc = "这是一款用上等皮革制成的非常精致的挎包。"
	icon_state = "satchel-leather"
	inhand_icon_state = "satchel"

/obj/item/storage/backpack/satchel/leather/withwallet/PopulateContents()
	new /obj/item/storage/wallet/random(src)

/obj/item/storage/backpack/satchel/fireproof
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/satchel/eng
	name = "工业挎包"
	desc = "一款带有额外口袋的结实挎包。"
	icon_state = "satchel-engineering"
	inhand_icon_state = "satchel-eng"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/satchel/med
	name = "医疗挎包"
	desc = "一款供医疗部门使用的无菌挎包。"
	icon_state = "satchel-medical"
	inhand_icon_state = "satchel-med"

/obj/item/storage/backpack/satchel/chief_medic
	name = "首席医疗官的挎包"
	desc = "一款口袋勉强够装下首席医疗官装备的挎包。"
	icon_state = "satchel-chiefmedical"
	inhand_icon_state = "satchel-med"

/obj/item/storage/backpack/satchel/vir
	name = "病毒学家挎包"
	desc = "一款带有病毒学家配色的无菌挎包。"
	icon_state = "satchel-virology"
	inhand_icon_state = "satchel-vir"

/obj/item/storage/backpack/satchel/chem
	name = "化学家挎包"
	desc = "一款带有化学家配色的无菌挎包。"
	icon_state = "satchel-chemistry"
	inhand_icon_state = "satchel-chem"

/obj/item/storage/backpack/satchel/coroner
	name = "验尸官挎包"
	desc = "一款用来装运人体残骸的挎包。"
	icon_state = "satchel-coroner"
	inhand_icon_state = "satchel-coroner"

/obj/item/storage/backpack/satchel/gen
	name = "遗传学家挎包"
	desc = "一款带有遗传学家配色的无菌挎包。"
	icon_state = "satchel-genetics"
	inhand_icon_state = "satchel-gen"

/obj/item/storage/backpack/satchel/science
	name = "科学家挎包"
	desc = "适合存放研究材料。"
	icon_state = "satchel-science"
	inhand_icon_state = "satchel-sci"

/obj/item/storage/backpack/satchel/hyd
	name = "植物学家挎包"
	desc = "一款用全天然纤维制成的挎包。"
	icon_state = "satchel-hydroponics"
	inhand_icon_state = "satchel-hyd"

/obj/item/storage/backpack/satchel/sec
	name = "安保挎包"
	desc = "一款满足安保需求的结实挎包。"
	icon_state = "satchel-security"
	inhand_icon_state = "satchel-sec"

/obj/item/storage/backpack/satchel/explorer
	name = "探险家挎包"
	desc = "一款用来存放战利品的结实挎包。"
	icon_state = "satchel-explorer"
	inhand_icon_state = "satchel-explorer"

/obj/item/storage/backpack/satchel/cap
	name = "舰长的挎包"
	desc = "一款纳米传讯军官专属的挎包。"
	icon_state = "satchel-captain"
	inhand_icon_state = "satchel-cap"

/obj/item/storage/backpack/satchel/flat
	name = "走私者挎包"
	desc = "一款非常纤薄、能轻松塞进狭窄空间的挎包。其内容物无法被违禁品扫描仪检测到。"
	icon_state = "satchel-flat"
	inhand_icon_state = "satchel-flat"
	w_class = WEIGHT_CLASS_NORMAL //Can fit in backpacks itself.
	storage_type = /datum/storage/backpack/satchel_flat

/obj/item/storage/backpack/satchel/flat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/undertile, TRAIT_T_RAY_VISIBLE, INVISIBILITY_MAXIMUM, use_anchor = TRUE) // SKYRAT EDIT - Ghosts can't see smuggler's satchels
	ADD_TRAIT(src, TRAIT_CONTRABAND_BLOCKER, INNATE_TRAIT)

/obj/item/storage/backpack/satchel/flat/PopulateContents()
	for(var/items in 1 to 4)
		new /obj/effect/spawner/random/contraband(src)

/obj/item/storage/backpack/satchel/flat/with_tools/PopulateContents()
	new /obj/item/stack/tile/iron/base(src)
	new /obj/item/crowbar(src)

	..()

/obj/item/storage/backpack/satchel/flat/empty/PopulateContents()
	return


/// Messenger Bag Types
/obj/item/storage/backpack/messenger
	name = "邮差包"
	desc = "一款看起来很时髦的邮差包，有时也叫快递包。时尚又便携。"
	icon_state = "messenger"
	inhand_icon_state = "messenger"
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'

/obj/item/storage/backpack/messenger/eng
	name = "工业邮差包"
	desc = "一款由经过高级处理的皮革制成的结实邮差包，具备防火性能。它的口袋也比普通款更多。"
	icon_state = "messenger_engineering"
	inhand_icon_state = "messenger_engineering"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/messenger/med
	name = "医疗邮差包"
	desc = "一款无菌邮差包，因其便携性和纤薄外形而深受医护喜爱。"
	icon_state = "messenger_medical"
	inhand_icon_state = "messenger_medical"

/obj/item/storage/backpack/messenger/chief_medic
	name = "首席医疗官的邮差包"
	desc = "一款纤薄的邮差包，首席医疗官们欣赏它工作时不会碍事——不像他们的化学家。"
	icon_state = "messenger_chiefmedical"
	inhand_icon_state = "messenger_medical"

/obj/item/storage/backpack/messenger/vir
	name = "病毒学家邮差包"
	desc = "一款带有病毒学家配色的无菌邮差包，有助于以创纪录的速度部署生物危害。"
	icon_state = "messenger_virology"
	inhand_icon_state = "messenger_virology"

/obj/item/storage/backpack/messenger/chem
	name = "化学家邮差包"
	desc = "一款带有化学家配色的无菌邮差包，适合准时赶去小巷里的交易。"
	icon_state = "messenger_chemistry"
	inhand_icon_state = "messenger_chemistry"

/obj/item/storage/backpack/messenger/coroner
	name = "验尸官邮差包"
	desc = "一款用于从墓地以不错的速度溜走的邮差包。"
	icon_state = "messenger_coroner"
	inhand_icon_state = "messenger_coroner"

/obj/item/storage/backpack/messenger/gen
	name = "遗传学家邮差包"
	desc = "一款带有遗传学家配色的无菌邮差包，戴在绿巨人身上是相当可爱的配饰。"
	icon_state = "messenger_genetics"
	inhand_icon_state = "messenger_genetics"

/obj/item/storage/backpack/messenger/science
	name = "科学家邮差包"
	desc = "适合存放研究材料，也方便你快速赶往各个扫描目标。"
	icon_state = "messenger_science"
	inhand_icon_state = "messenger_science"

/obj/item/storage/backpack/messenger/hyd
	name = "植物学家邮差包"
	desc = "一款用全天然纤维制成的邮差包，非常适合准时赶去抽上一口。"
	icon_state = "messenger_hydroponics"
	inhand_icon_state = "messenger_hydroponics"

/obj/item/storage/backpack/messenger/sec
	name = "安保邮差包"
	desc = "一款满足安保需求的结实邮差包。"
	icon_state = "messenger_security"
	inhand_icon_state = "messenger_security"

/obj/item/storage/backpack/messenger/explorer
	name = "探险家邮差包"
	desc = "一款用来存放战利品的结实邮差包，配上你的龙骨干装甲还是相当可爱的配饰。"
	icon_state = "messenger_explorer"
	inhand_icon_state = "messenger_explorer"

/obj/item/storage/backpack/messenger/cap
	name = "舰长的邮差包"
	desc = "一款纳米传讯军官专属的邮差包，用真鲸鱼皮制成。"
	icon_state = "messenger_captain"
	inhand_icon_state = "messenger_captain"

/obj/item/storage/backpack/messenger/clown
	name = "咯咯·冯·洪克顿二世"
	desc = "洪克公司最新推出的储物“技术”。嘿，这么小的体积到底是怎么装下这么多东西的？穿戴者绝对不会告诉你。"
	icon_state = "messenger_clown"
	inhand_icon_state = "messenger_clown"
