///A special category for goods stolen by spies for their bounties.
/datum/market_item/stolen_good
	category = "Fenced Goods"
	abstract_path = /datum/market_item/stolen_good
	stock = 1
	availability_prob = 100
	restockable = FALSE

/datum/market_item/stolen_good/New(atom/movable/thing, thing_price)
	..()
	set_item(thing)
	name = "被盗的[thing.name]"
	desc = "一件[thing.name]，是从空间站某处偷来的。它原来的主人看到它出现在这里，恐怕不会高兴。"
	price = thing_price
