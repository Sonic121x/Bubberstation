/datum/martial_art/mushpunch
	name = "蘑菇拳"
	id = MARTIALART_MUSHPUNCH

/datum/martial_art/mushpunch/harm_act(mob/living/attacker, mob/living/defender)
	INVOKE_ASYNC(src, PROC_REF(charge_up_attack), attacker, defender)
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/mushpunch/proc/charge_up_attack(mob/living/attacker, mob/living/defender)

	to_chat(attacker, span_spiderbroodmother("你开始蓄力攻击……"))
	if(!do_after(attacker, 2.5 SECONDS, defender))
		to_chat(attacker, span_spiderbroodmother("<b>你的攻击被打断了！</b>"))
		return

	var/final_damage = rand(15, 30)
	var/atk_verb = pick("拳击", "猛砸", "重击")
	if(defender.check_block(attacker, final_damage, "[attacker]的[atk_verb]", UNARMED_ATTACK))
		return

	attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
	defender.visible_message(
		span_danger("[attacker]以非人的力量[atk_verb][defender]，将其击飞出去！"), \
		span_userdanger("[attacker]以非人的力量[atk_verb]你，将你击飞出去！"),
		span_hear("你听到肉体碰撞的骇人闷响！"),
		null,
		attacker,
	)
	to_chat(attacker, span_danger("你以非人的力量[atk_verb][defender]，将其击飞出去！"))
	defender.apply_damage(final_damage, attacker.get_attack_type())
	playsound(defender, 'sound/effects/meteorimpact.ogg', 25, TRUE, -1)
	var/throwtarget = get_edge_target_turf(attacker, get_dir(attacker, get_step_away(defender, attacker)))
	defender.throw_at(throwtarget, 4, 2, attacker)//So stuff gets tossed around at the same time.
	defender.Paralyze(2 SECONDS)
	log_combat(attacker, defender, "[atk_verb]（蘑菇拳）")

/obj/item/mushpunch
	name = "古怪蘑菇"
	desc = "<I>灵智蛇舌菌</I>：一朵来自蘑菇人血肉的古怪蘑菇。\
		它似乎保留了原主人的部分天赋力量，正因那几乎压抑不住的力量而颤动！"
	icon = 'icons/obj/service/hydroponics/seeds.dmi'
	icon_state = "mycelium-angel"

/obj/item/mushpunch/attack_self(mob/living/user)
	if(!istype(user))
		return
	to_chat(user, span_spiderbroodmother("你吞下了[src]，\
		蘑菇中蕴含的技巧与力量汇入体内，让你的拳头更加强劲！\
		不过，这些强力拳击需要短暂蓄力。"))
	var/datum/martial_art/mushpunch/mush = new(user)
	mush.teach(user)
	visible_message(
		span_warning("[user]吞下了[src]。"),
		span_notice("你吞下了[src]。"),
	)

	qdel(src)
