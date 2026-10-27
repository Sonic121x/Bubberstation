/datum/language/vampiric
	name = "Enochian"
	desc = "据传由黑暗之父该隐亲手创造，以便与自己的子嗣交谈；而真相，就像不死生涯中的许多事一样，无从确定。这是夜之生物的语言。"
	key = "L"//Capital L, lowercase l is for ashies.
	space_chance = 40
	default_priority = 90

	flags = LANGUAGE_TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	syllables = list(
		"luk","cha","no","kra","pru","chi","busi","tam","pol","spu","och",
		"umf","ora","stu","si","ri","li","ka","red","ani","lup","ala","pro",
		"to","siz","nu","pra","ga","ump","ort","a","ya","yach","tu","lit",
		"wa","mabo","mati","anta","tat","tana","prol",
		"tsa","si","tra","te","ele","fa","inz",
		"nza","est","sti","ra","pral","tsu","ago","esch","chi","kys","praz",
		"froz","etz","tzil",
		"t'","k'","t'","k'","th'","tz'"
		)

	icon_state = "bloodsucker"
	icon = 'modular_zubbers/icons/misc/language.dmi'
	secret = TRUE
