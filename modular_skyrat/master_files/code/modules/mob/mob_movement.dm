GAME_VERB(/mob/living/carbon, army_crawl, "匍匐前进", "IC")
	var/mob/living/carbon/crawler = src

	if(HAS_TRAIT(crawler, TRAIT_PRONE))
		visible_message("[crawler] 开始起身")
		if(!do_after(crawler, 3 SECONDS))
			return
		SEND_SIGNAL(crawler, COMSIG_MOVABLE_REMOVE_PRONE_STATE)
	else if(crawler.can_army_crawl())
		visible_message("[crawler] 开始把身子压得更低")
		if(!do_after(crawler, 3 SECONDS, extra_checks = CALLBACK(crawler, PROC_REF(can_army_crawl))))
			if(!crawler.resting)
				balloon_alert(crawler, "必须躺着！")
			return
		crawler.AddComponent(/datum/component/prone_mob, block_hands = TRUE)
	else
		balloon_alert(crawler, "必须躺着！")

/mob/living/carbon/proc/can_army_crawl()
	return resting
