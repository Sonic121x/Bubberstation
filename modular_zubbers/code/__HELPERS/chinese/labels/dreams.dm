// Chinese noun phrases do not take the English a/an article.
/proc/chinese_dream_article(value)
	value = replacetext(value, "%A% ", "")
	var/static/regex/chinese_text
	if(isnull(chinese_text))
		chinese_text = regex("\[一-鿿]")
	return chinese_text.Find(value) ? value : "\a [value]"
