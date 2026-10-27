/datum/lazy_template/virtual_domain/gondola_asteroid
	name = "贡多拉小行星"
	desc = "一颗小行星，上面生长着一片茂密的贡多拉森林。宁静祥和。"
	help_text = "多么美丽的森林啊。地图正中央有一个战利品板条箱。 \
	嗯……它纹丝不动。不过那些贡多拉搬动它似乎毫无困难。 \
	我敢打赌一定有办法让我自己也能搬动它。"
	key = "gondola_asteroid"
	map_name = "gondola_asteroid"
	domain_flags = DOMAIN_NO_NOHIT_BONUS

/// Very pushy gondolas, great for moving loot crates.
/obj/structure/closet/crate/secure/bitrunning/encrypted/gondola
	move_resist = MOVE_FORCE_STRONG

/mob/living/basic/pet/gondola/virtual_domain
	health = 50
	loot = list(
		/obj/effect/decal/cleanable/blood/gibs = 1,
		/obj/item/stack/sheet/animalhide/gondola = 1,
		/obj/item/food/meat/slab/gondola/virtual_domain = 1,
	)
	maxHealth = 50
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_STRONG

/obj/item/food/meat/slab/gondola/virtual_domain
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/gondola_mutation_toxin/virtual_domain = 5,
	)

/datum/reagent/gondola_mutation_toxin/virtual_domain
	name = "高级宁静"
	gondola_disease = /datum/disease/transformation/gondola/virtual_domain

/datum/disease/transformation/gondola/virtual_domain
	stage_prob = 9
	new_form = /mob/living/basic/pet/gondola/virtual_domain
	visibility_flags = parent_type::visibility_flags | HIDDEN_BOOK
