/proc/chinese_fish_legacy_names()
	var/static/list/legacy_names
	if(isnull(legacy_names))
		legacy_names = list(
			/obj/item/fish/sand_surfer = "sand surfer",
			/obj/item/fish/sand_crab = "burrower crab",
			/obj/item/fish/bumpy = "bump-fish",
			/obj/item/fish/starfish = "cosmostarfish",
			/obj/item/fish/baby_carp = "baby space carp",
			/obj/item/fish/sockeye_salmon = "sockeye salmon",
			/obj/item/fish/arctic_char = "arctic char",
			/obj/item/fish/pike = "pike",
			/obj/item/fish/goldfish = "goldfish",
			/obj/item/fish/goldfish/gill = "McGill",
			/obj/item/fish/goldfish/three_eyes = "three-eyed goldfish",
			/obj/item/fish/goldfish/three_eyes/gill = "McGill",
			/obj/item/fish/angelfish = "angelfish",
			/obj/item/fish/guppy = "guppy",
			/obj/item/fish/plasmatetra = "plasma tetra",
			/obj/item/fish/catfish = "catfish",
			/obj/item/fish/zipzap = "anxious zipzap",
			/obj/item/fish/tadpole = "tadpole",
			/obj/item/fish/perch = "perch",
			/obj/item/fish/sacabambaspis = "sacabambaspis",
			/obj/item/fish/holo = "holographic goldfish",
			/obj/item/fish/holo/crab = "holographic crab",
			/obj/item/fish/holo/puffer = "holographic pufferfish",
			/obj/item/fish/holo/angel = "holographic angelfish",
			/obj/item/fish/holo/clown = "holographic clownfish",
			/obj/item/fish/holo/checkered = "unrendered holographic fish",
			/obj/item/fish/holo/halffish = "holographic half-fish",
			/obj/item/fish/chasm_crab = "chasm chrab",
			/obj/item/fish/chasm_crab/ice = "arctic chrab",
			/obj/item/fish/boned = "unmarine bonemass",
			/obj/item/fish/lavaloop = "lavaloop",
			/obj/item/fish/lavaloop/plasma_river = "plasmaloop",
			/obj/item/fish/starfish/chrystarfish = "chrystarfish",
			/obj/item/fish/dolphish = "walro-dolphish",
			/obj/item/fish/flumpulus = "flumpulus",
			/obj/item/fish/gullion = "gullion",
			/obj/item/fish/mossglob = "mossglob",
			/obj/item/fish/babbelfish = "babbelfish",
			/obj/item/fish/mastodon = "unmarine mastodon",
			/obj/item/fish/soul = "soulfish",
			/obj/item/fish/skin_crab = "skin crab",
			/obj/item/fish/clownfish = "clownfish",
			/obj/item/fish/clownfish/lube = "lubefish",
			/obj/item/fish/cardinal = "cardinalfish",
			/obj/item/fish/greenchromis = "green chromis",
			/obj/item/fish/firefish = "firefish goby",
			/obj/item/fish/pufferfish = "pufferfish",
			/obj/item/fish/lanternfish = "lanternfish",
			/obj/item/fish/stingray = "stingray",
			/obj/item/fish/swordfish = "swordfish",
			/obj/item/fish/squid = "squid",
			/obj/item/fish/monkfish = "monkfish",
			/obj/item/fish/plaice = "plaice",
			/obj/item/fish/ratfish = "ratfish",
			/obj/item/fish/sludgefish = "sludgefish",
			/obj/item/fish/sludgefish/purple = "purple sludgefish",
			/obj/item/fish/slimefish = "aquatic slime",
			/obj/item/fish/fryish = "fryish",
			/obj/item/fish/fryish/fritterish = "fritterish",
			/obj/item/fish/fryish/nessie = "nessie-fish",
			/obj/item/fish/emulsijack = "toxic emulsijack",
			/obj/item/fish/donkfish = "donk co. company patent donkfish",
			/obj/item/fish/jumpercable = "monocloning jumpercable",
			/obj/item/fish/chainsawfish = "chainsawfish",
			/obj/item/fish/pike/armored = "armored pike",
			/obj/item/fish/moonfish = "zagoskian moonfish",
			/obj/item/fish/moonfish/dwarf = "dwarf moonfish",
			/obj/item/fish/gunner_jellyfish = "gunner jellyfish",
			/obj/item/fish/needlefish = "needlefish",
			/obj/item/fish/armorfish = "armorfish",
			/obj/item/fish/shrimp = "shrimp",
		)
	return legacy_names

/obj/item/fish/get_visible_name(add_id_name = TRUE, force_real_name = FALSE)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_WAS_RENAMED))
		return
	var/list/legacy_names = chinese_fish_legacy_names()
	if(. == legacy_names[type])
		return initial(name)

/proc/chinese_fish_progress_display(value)
	if(!istext(value))
		return value
	var/list/legacy_names = chinese_fish_legacy_names()
	for(var/obj/item/fish/fish_type as anything in legacy_names)
		if(value == legacy_names[fish_type] || value == fish_type::fish_id)
			return fish_type::name
	return value
