/mob/living/basic/goat/pete // Pete!
	name = "皮特"
	gender = MALE

/mob/living/basic/goat/pete/examine()
	. = ..()
	var/area/goat_area = get_area(src)
	if((bodytemperature < T20C) || istype(goat_area, /area/station/service/kitchen/coldroom))
		. += span_notice("[p_They()] 似乎并不太在意寒冷。") // special for pete

