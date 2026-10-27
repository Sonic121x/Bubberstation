// Modular Booze MIXES, see the following file for the reagents: modular_skyrat\modules\customization\modules\reagents\chemistry\reagents\alcohol_reagents.dm

// ROBOT ALCOHOL PAST THIS POINT
// WOOO!

/datum/chemical_reaction/drink/synthanol
	results = list(/datum/reagent/consumable/ethanol/synthanol = 3)
	required_reagents = list(/datum/reagent/lube = 1, /datum/reagent/toxin/plasma = 1, /datum/reagent/fuel = 1)
	mix_message = "化学物质混合，生成了一种闪亮的蓝色物质。"

/datum/chemical_reaction/drink/robottears
	results = list(/datum/reagent/consumable/ethanol/synthanol/robottears = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/fuel/oil = 1, /datum/reagent/consumable/sodawater = 1)
	mix_message = "这些原料混合成了一种黏稠的深色胶状物。"

/datum/chemical_reaction/drink/trinary
	results = list(/datum/reagent/consumable/ethanol/synthanol/trinary = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/orangejuice = 1)
	mix_message = "这些原料混合成了一种色彩斑斓的物质。"

/datum/chemical_reaction/drink/servo
	results = list(/datum/reagent/consumable/ethanol/synthanol/servo = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 2, /datum/reagent/consumable/cream = 1, /datum/reagent/consumable/hot_coco = 1)
	mix_message = "这些原料混合成了一种深棕色的物质。"

/datum/chemical_reaction/drink/uplink
	results = list(/datum/reagent/consumable/ethanol/synthanol/uplink = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/ethanol/tequila = 1, /datum/reagent/consumable/ethanol/whiskey = 1)
	mix_message = "化学物质混合，生成了一种闪亮的橙色物质。"

/datum/chemical_reaction/drink/synthncoke
	results = list(/datum/reagent/consumable/ethanol/synthanol/synthncoke = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/space_cola = 1)
	mix_message = "化学物质混合，生成了一种顺滑起泡的物质。"

/datum/chemical_reaction/drink/synthignon
	results = list(/datum/reagent/consumable/ethanol/synthanol/synthignon = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/ethanol/wine = 1)
	mix_message = "化学物质混合，生成了一种细腻的红色物质。"

// Other Booze

/datum/chemical_reaction/drink/gunfire
	results = list(/datum/reagent/consumable/ethanol/gunfire = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/tea = 3)
	mix_message = "饮品混合时，空气中开始响起响亮的爆裂声。"

/datum/chemical_reaction/drink/hellfire
	results = list(/datum/reagent/consumable/ethanol/hellfire = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 2, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/ethanol/crevice_spike = 1)
	mix_message = "液体开始翻腾，变成琥珀橙色并燃烧起来。"

/datum/chemical_reaction/drink/sins_delight
	results = list(/datum/reagent/consumable/ethanol/sins_delight = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/demonsblood = 2, /datum/reagent/consumable/ethanol/triple_sec = 1, /datum/reagent/consumable/ethanol/martini = 1, /datum/reagent/consumable/ethanol/changelingsting = 1)
	mix_message = "液体开始旋转，随后形成一团粉色云雾，消散在空气中。"

/datum/chemical_reaction/drink/daiquiri/strawberry
	results = list(/datum/reagent/consumable/ethanol/daiquiri/strawberry = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/daiquiri = 5, /datum/reagent/consumable/berryjuice = 5)

/datum/chemical_reaction/drink/miami_vice
	results = list(/datum/reagent/consumable/ethanol/miami_vice = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/pina_colada = 1, /datum/reagent/consumable/ethanol/daiquiri/strawberry = 1)

/datum/chemical_reaction/drink/malibu_sunset
	results = list(/datum/reagent/consumable/ethanol/malibu_sunset = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/painkiller = 2, /datum/reagent/consumable/grenadine = 1, /datum/reagent/consumable/orangejuice = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/drink/liz_fizz
	results = list(/datum/reagent/consumable/liz_fizz = 5)
	required_reagents = list(/datum/reagent/consumable/triple_citrus = 3, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/hotlime_miami
	results = list(/datum/reagent/consumable/ethanol/hotlime_miami = 2)
	required_reagents = list(/datum/reagent/medicine/ephedrine = 1, /datum/reagent/consumable/ethanol/pina_colada = 1)

/datum/chemical_reaction/drink/coggrog
	results = list(/datum/reagent/consumable/ethanol/coggrog = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/cognac = 1, /datum/reagent/fuel = 1, /datum/reagent/consumable/ethanol/screwdrivercocktail = 1)
	mix_message = "混合时，你听到隐约的齿轮转动声。"
	mix_sound = 'sound/machines/clockcult/steam_whoosh.ogg'

/datum/chemical_reaction/drink/badtouch
	results = list(/datum/reagent/consumable/ethanol/badtouch = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/cognac = 2, /datum/reagent/consumable/limejuice = 2, /datum/reagent/consumable/orangejuice=1)

/datum/chemical_reaction/drink/marsblast
	results = list(/datum/reagent/consumable/ethanol/marsblast = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 3, /datum/reagent/consumable/dr_gibb = 2)

/datum/chemical_reaction/drink/mercuryblast
	results = list(/datum/reagent/consumable/ethanol/mercuryblast = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 2, /datum/reagent/consumable/spacemountainwind = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/drink/piledriver
	results = list(/datum/reagent/consumable/ethanol/piledriver = 6)
	required_reagents = list(/datum/reagent/consumable/ethanol/screwdrivercocktail = 1, /datum/reagent/consumable/ethanol/rum_coke = 1)

/datum/chemical_reaction/drink/zenstar
	results = list(/datum/reagent/consumable/ethanol/zenstar = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/triple_sec = 2, /datum/reagent/consumable/lemonjuice = 2, /datum/reagent/consumable/grenadine = 1)

/datum/chemical_reaction/drink/appletini
	results = list(/datum/reagent/consumable/ethanol/appletini = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 3, /datum/reagent/consumable/ethanol/hcider = 1, /datum/reagent/consumable/lemonjuice = 1)

/datum/chemical_reaction/drink/quadruple_sec/cityofsin
	results = list(/datum/reagent/consumable/ethanol/quadruple_sec/cityofsin = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 2, /datum/reagent/consumable/ethanol/champagne = 1, /datum/reagent/consumable/berryjuice = 1)

/datum/chemical_reaction/drink/blizzard_brew
	results = list(/datum/reagent/consumable/ethanol/blizzard_brew = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/iced_beer = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/inverse/cryostylane = 1)
	mix_message = "混合时，你听到冰块的噼啪声。"
	mix_sound = 'sound/effects/ice_shovel.ogg'

/datum/chemical_reaction/drink/molten_mead
	results = list(/datum/reagent/consumable/ethanol/molten_mead = 3)
	required_reagents = list(/datum/reagent/consumable/condensedcapsaicin = 2, /datum/reagent/consumable/ethanol/mead = 2, /datum/reagent/consumable/ethanol/mauna_loa = 1)
	mix_message = "混合时，你听到皮肉滋滋作响和愤怒黄蜂的嗡嗡声。"
	mix_sound = 'sound/effects/wounds/sizzle2.ogg'

/datum/chemical_reaction/drink/hippie_hooch
	results = list(/datum/reagent/consumable/ethanol/hippie_hooch = 5)
	required_reagents = list(/datum/reagent/medicine/antihol = 1, /datum/reagent/consumable/ethanol/crevice_spike = 3, /datum/reagent/medicine/earthsblood = 1)
	mix_message = "混合时，你听到木笛声与自然的声音。"
	mix_sound = 'modular_skyrat/modules/emotes/sound/voice/hoot.ogg'

/datum/chemical_reaction/drink/research_rum
	results = list(/datum/reagent/consumable/ethanol/research_rum = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/bananahonk = 2, /datum/reagent/inverse/neurine = 1, /datum/reagent/consumable/ethanol/grog = 1)
	mix_message = "混合时，你听到咕嘟声和叮当声。"
	mix_sound = 'sound/machines/microwave/microwave-end.ogg'

/datum/chemical_reaction/drink/golden_grog
	results = list(/datum/reagent/consumable/ethanol/golden_grog = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/goldschlager = 10, /datum/reagent/gold = 1, /datum/reagent/silver = 1, /datum/reagent/cellulose = 1, /datum/reagent/spraytan = 1)
	mix_message = "混合时，你听到金币的响声和势利富人得意的笑声。"
	mix_sound = 'sound/items/coinflip.ogg'

// RACE SPECIFIC DRINKS

/datum/chemical_reaction/drink/coldscales
	results = list(/datum/reagent/consumable/ethanol/coldscales = 3)
	required_reagents = list(/datum/reagent/consumable/tea = 1, /datum/reagent/toxin/slimejelly = 1,  /datum/reagent/consumable/menthol = 1)

/datum/chemical_reaction/drink/oil_drum
	results = list(/datum/reagent/consumable/ethanol/oil_drum = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1,  /datum/reagent/fuel/oil = 1, /datum/reagent/consumable/ethanol/champagne = 12)

/datum/chemical_reaction/drink/nord_king
	results = list(/datum/reagent/consumable/ethanol/nord_king = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol = 5,  /datum/reagent/consumable/honey = 1, /datum/reagent/consumable/ethanol/red_mead = 10)

/datum/chemical_reaction/drink/velvet_kiss
	results = list(/datum/reagent/consumable/ethanol/velvet_kiss = 15) //Limited races use this
	required_reagents = list(/datum/reagent/blood = 5,  /datum/reagent/consumable/tea = 1, /datum/reagent/consumable/ethanol/wine = 10)

/datum/chemical_reaction/drink/abduction_fruit
	results = list(/datum/reagent/consumable/ethanol/abduction_fruit = 3)
	required_reagents = list(/datum/reagent/consumable/limejuice = 10,  /datum/reagent/consumable/berryjuice = 5, /datum/reagent/consumable/watermelonjuice = 10)

/datum/chemical_reaction/drink/bug_zapper
	results = list(/datum/reagent/consumable/ethanol/bug_zapper = 20) //Harder to make
	required_reagents = list(/datum/reagent/consumable/lemonjuice = 10,  /datum/reagent/teslium = 1, /datum/reagent/copper = 10)

/datum/chemical_reaction/drink/mush_crush
	results = list(/datum/reagent/consumable/ethanol/mush_crush = 10)
	required_reagents = list(/datum/reagent/iron = 5,  /datum/reagent/ash = 5, /datum/reagent/toxin/coffeepowder = 10)

/datum/chemical_reaction/drink/hollow_bone
	results = list(/datum/reagent/consumable/ethanol/hollow_bone = 10)
	required_reagents = list(/datum/reagent/toxin/bonehurtingjuice = 10,  /datum/reagent/consumable/soymilk = 15)//Skeletons love milk, and will find soymilk disgusting!

/datum/chemical_reaction/drink/jell_wyrm
	results = list(/datum/reagent/consumable/ethanol/jell_wyrm = 2)
	required_reagents = list(/datum/reagent/toxin/slimejelly = 1,  /datum/reagent/toxin/carpotoxin = 1, /datum/reagent/carbondioxide = 5)
	required_temp = 333 // (59.85'C)

/datum/chemical_reaction/drink/laval_spit
	results = list(/datum/reagent/consumable/ethanol/laval_spit = 20) //Limited use
	required_reagents = list(/datum/reagent/iron = 5,  /datum/reagent/consumable/ethanol/mauna_loa = 10, /datum/reagent/sulfur = 5)
	required_temp = 900 // (626.85'C)

/datum/chemical_reaction/drink/frisky_kitty
	results = list(/datum/reagent/consumable/ethanol/frisky_kitty = 2)
	required_reagents = list(/datum/reagent/consumable/catnip_tea = 1,  /datum/reagent/consumable/milk = 1)
	required_temp = 296 //Just above room temp (22.85'C)

/datum/chemical_reaction/drink/bloodshot_base
	results = list(/datum/reagent/consumable/ethanol/bloodshot_base = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/bloody_mary = 1, /datum/reagent/consumable/sugar = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/bloodshot
	results = list(/datum/reagent/consumable/ethanol/bloodshot = 5)
	required_reagents = list(/datum/reagent/blood = 3, /datum/reagent/consumable/ethanol/bloodshot_base = 2)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER


// Non-Booze, see modular_skyrat\modules\customization\modules\reagents\chemistry\reagents\drink_reagents.dm

/datum/chemical_reaction/drink/pinkmilk
	results = list(/datum/reagent/consumable/pinkmilk = 2)
	required_reagents = list(/datum/reagent/consumable/berryjuice = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/drink/pinktea
	results = list(/datum/reagent/consumable/pinktea = 5)
	required_reagents = list(/datum/reagent/consumable/berryjuice = 1, /datum/reagent/consumable/tea/arnold_palmer = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/drink/catnip_tea
	results = list(/datum/reagent/consumable/catnip_tea = 10)
	required_reagents = list(/datum/reagent/consumable/tea = 5, /datum/reagent/pax/catnip = 2)

/datum/chemical_reaction/drink/beerbatter
	results = list(/datum/reagent/consumable/ethanol/beerbatter = 4)
	required_reagents = list(/datum/reagent/consumable/nutriment/fat/oil = 1, /datum/reagent/consumable/ethanol/beer = 1, /datum/reagent/consumable/flour = 1)
	mix_message = "你把混合物搅打得服服帖帖时，能听到滋滋作响和噼啪声。"

/datum/chemical_reaction/drink/shakiri_spritz
	results = list(/datum/reagent/consumable/ethanol/shakiri_spritz = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/shakiri = 1, /datum/reagent/consumable/sodawater = 1, /datum/reagent/consumable/orangejuice = 1)
	mix_message = "液体混合成了一种怡人的橙色混合物。"

/datum/chemical_reaction/drink/crimson_hurricane
	results = list(/datum/reagent/consumable/ethanol/crimson_hurricane = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/shakiri = 1, /datum/reagent/consumable/ethanol/rum = 2, /datum/reagent/consumable/grenadine = 1, /datum/reagent/consumable/limejuice = 1)
	mix_message = "混合物呈现出浓郁的绯红色。"

/datum/chemical_reaction/drink/shakiri_rogers
	results = list(/datum/reagent/consumable/ethanol/shakiri_rogers = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/shakiri = 1, /datum/reagent/consumable/space_cola = 5, /datum/reagent/consumable/ice = 2)
	mix_message = "碳酸气泡在深色混合物的表面升起并破裂。"
