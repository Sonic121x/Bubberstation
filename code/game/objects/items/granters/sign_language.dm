/// Sign language book adds the sign language component to the reading Human.
/// Grants reader the ability to toggle sign language using a HUD button.
/obj/item/book/granter/sign_language
	name = "《银河标准手语》"
	desc = "一本学习手语与指拼法的全面指南。"
	remarks = list(
		"手语包含多种技巧……",
		"可以通过连续手势拼出词语……",
		"还得注意手掌朝向？",
		"提问时要压低眉毛……",
		"真不错！常用短语收录得很全面！",
		"几乎什么都能用手语表达……",
	)

/obj/item/book/granter/sign_language/can_learn(mob/living/user)
	if (!iscarbon(user))
		return
	if (user.GetComponent(/datum/component/sign_language))
		to_chat(user, span_warning("你已经完全掌握手语了！"))
		return
	return TRUE

/obj/item/book/granter/sign_language/recoil(mob/living/user)
	to_chat(user, span_warning("书页褪色又污损，已经无法阅读了！"))

/// Called when the reading is completely finished. This is where the actual granting should happen.
/obj/item/book/granter/sign_language/on_reading_finished(mob/living/user)
	..()
	user.AddComponent(/datum/component/sign_language)
