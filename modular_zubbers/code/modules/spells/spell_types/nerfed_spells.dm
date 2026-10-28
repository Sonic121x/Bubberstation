
//Barnyard Curse. Clears the curse after 3 minutes.
/datum/spellbook_entry/barnyard
	name = "次级农场诅咒"
	desc = "此法术让一个不幸的灵魂获得农场动物的叫声与面部特征，持续 3 分钟。"

/datum/action/cooldown/spell/pointed/barnyardcurse
	name = "次级农场诅咒"
	desc = "此法术让一个不幸的灵魂获得农场动物的叫声与面部特征，持续 3 分钟。"

/obj/item/clothing/mask/animal/make_cursed()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(clear_curse)), 3 MINUTES, TIMER_UNIQUE | TIMER_DELETE_ME)



//Mind Transfer. Can no longer be used on targets with minds.
/datum/spellbook_entry/mindswap
	name = "次级心智交换"
	desc = "让你能与身旁一个<b>没有灵魂</b>的目标互换身体。交换时你们双方都会陷入睡眠，而若有人旁观，你占了目标身体这件事会相当明显。"

/datum/action/cooldown/spell/pointed/mind_transfer
	name = "次级心智交换"
	desc = "此法术让施法者与身旁的目标互换身体，仅对“无灵魂”的目标有效。"
	target_requires_key = FALSE
	target_requires_mind = FALSE

/datum/action/cooldown/spell/pointed/mind_transfer/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return .
	var/mob/living/living_target = cast_on //We check if the target is living above.
	if(living_target.key)
		to_chat(owner, span_warning("这具躯体似乎没有可供交换的空闲心智！"))
		return FALSE

	return TRUE


//Smite. Can longer gib and just kills you and yeets you an insane distance.

/datum/spellbook_entry/disintegrate
	name = "次级天罚"
	desc = "以亵渎的能量灌注你的手，被触碰的受害者会立即死亡，其尸体则会被抛飞到极远处。"

/datum/action/cooldown/spell/touch/smite
	name = "次级天罚"
	desc = "此法术以亵渎的能量灌注你的手，被触碰的受害者会立即死亡，其尸体则会被抛飞到极远处。"
	invocation = "YA'YEET!!"
	button_icon = 'icons/mob/nonhuman-player/cult.dmi'
	button_icon_state = "shade_wizard"
	sound = 'sound/effects/emotes/assslap.ogg'

/datum/action/cooldown/spell/touch/smite/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)

	blind_everyone_nearby(victim, caster)

	victim.investigate_log("被天罚法术抛飞了。", INVESTIGATE_DEATHS)

	var/turf/target_turf = get_edge_target_turf(victim, get_dir(caster,victim))
	victim.throw_at(target_turf, 255, 4, caster, force = MOVE_FORCE_OVERPOWERING, callback = TYPE_PROC_REF(/mob/living/, tram_slam_land)) //Shamelessly copied from tram throw code.

	victim.death(FALSE)

	return TRUE

// Laughter Demon. They're basically hugboxed slaughter demons (hence the name), but are still really powerful.
// While you're basically put in gay baby jail until it's killed, it's not TOO bad, but it should still be limited to 1.
/datum/spellbook_entry/item/hugbottle
	cost = 2
	limit = 1

// Lichdom. Imbue an object and that object is basically your mobile respawn point.
// Funny mechanic, but it was INSANELY generous on what you could imbue, causing near immortality. Mechanical changes are in the non-modular file of lichdom.dm
/datum/spellbook_entry/lichdom
	name = "缚炎之魂"
	desc = "一份地狱般的死灵契约，可将你的灵魂永久绑定在你选定的一件笨重物品上，\
		使你化为不朽的巫妖。只要该物品完好无损，无论遭遇何种境况，你都会从死亡中复活。\
		务必小心——每复活一次，你的身体都会变得更加虚弱，\
		他人也会更容易找到你的力量寄宿之物。\
		另外，由于此法术带有炽焰性质，它只能施放在不防火的物品上，因为魔法无法这样穿透。"

/datum/action/cooldown/spell/lichdom
	desc = "一道来自地狱深处的炽焰法术，可将你的灵魂绑定到你手中的物品上。\
		将灵魂绑定到物品上会使你化为不朽的巫妖。\
		只要该物品完好无损，无论遭遇何种境况，\
		你都会从死亡中复活。\
		无法作用于比笨重更小的物品，也无法作用于防火物品。"


// High Frequency Spellblade. Holy fuck just looking at the code is nonsense holy fuck. Can slash through walls, and also gib people who are dead. Absolutely silly.
// Replaces it with a banhammer that can send you to the perma brig because that's funnier.
/datum/spellbook_entry/item/highfrequencyblade
	name = "真正的封禁之锤"
	desc = "一把完全货真价实的封禁之锤，被它击中的任何人都会被暂时送入虚空。更重的打击还会把目标送进空间站的永久监禁区（如果存在的话）。"
	item_path = /obj/item/banhammer/real
	category = "Offensive"
	cost = 2
