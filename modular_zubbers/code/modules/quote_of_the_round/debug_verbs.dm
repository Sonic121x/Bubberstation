ADMIN_VERB(generate_quote_of_the_round, R_DEBUG, "生成回合金句", "为调试目的生成一条回合金句。", ADMIN_CATEGORY_DEBUG)

	if(!SSticker.quote_of_the_round_text)
		SSticker.quote_of_the_round_text = "婊子什么都不算，不过是些娼妇和花招。"

	if(!SSticker.quote_of_the_round_attribution)
		SSticker.quote_of_the_round_attribution = "阿尔伯特·爱因斯坦"

	var/message_to_send = SSticker.generate_quote_of_the_round()

	user << browse(message_to_send,"window='quoteoftheround'")
