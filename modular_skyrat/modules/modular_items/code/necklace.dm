//DEFAULT NECK ITEMS OVERRIDE//
/obj/item/clothing/neck
	w_class = WEIGHT_CLASS_SMALL

//ASHWALKER TRANSLATOR NECKLACE//
#define LANGUAGE_TRANSLATOR "translator"
/obj/item/clothing/neck/necklace/ashwalker
	name = "灰烬项链"
	desc = "一条用灰烬制成的项链，通过军团的核心与死灵之都相连。佩戴时，它能让地表居民对灰烬语产生一种不自然的理解力——那是熔岩地带的原生语言。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "ashnecklace"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "ashnecklace"
	w_class = WEIGHT_CLASS_SMALL //allows this to fit inside of pockets.

/obj/item/clothing/neck/necklace/ashwalker/cursed
	name = "诅咒灰烬项链"
	desc = "一条用灰烬制成的项链，通过军团的核心与死灵之都相连。佩戴时，它能让地表居民对灰烬语产生一种不自然的理解力——那是熔岩地带的原生语言。无法取下！"

/obj/item/clothing/neck/necklace/ashwalker/cursed/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

//uses code from the pirate hat.
/obj/item/clothing/neck/necklace/ashwalker/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot & ITEM_SLOT_NECK)
		user.grant_language(/datum/language/ashtongue/, source = LANGUAGE_TRANSLATOR)
		to_chat(user, span_boldnotice("套上项链，你感到死灵之都那阴险的爬行感渗入你的骨骼，乃至你的影子。你发现自己对灰烬语有了某种不自然的掌握；但护身符上的那只眼睛正盯着你。"))

/obj/item/clothing/neck/necklace/ashwalker/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.get_item_by_slot(ITEM_SLOT_NECK) == src && !QDELETED(src)) //This can be called as a part of destroy
		user.remove_language(/datum/language/ashtongue/, source = LANGUAGE_TRANSLATOR)
		to_chat(user, span_boldnotice("取下项链时，你感到死灵之都那异质的心智对你失去了兴趣。那只眼睛闭上了，你的心智也随之合上，失去了对灰烬语的掌握。"))

//ASHWALKER TRANSLATOR NECKLACE END//

#undef LANGUAGE_TRANSLATOR
