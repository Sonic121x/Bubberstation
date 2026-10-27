//does burn damage and EMPs, slightly fragile
/datum/blobstrain/reagent/electromagnetic_web
	name = "电磁网"
	color = "#83ECEC"
	complementary_color = "#EC8383"
	description = "会造成高额烧伤伤害并对目标施放电磁脉冲。"
	effectdesc = "受到的伤害也会大幅提高，并在被消灭时释放一次电磁脉冲。"
	analyzerdescdamage = "造成低额烧伤伤害并对目标施放电磁脉冲。"
	analyzerdesceffect = "对各类伤害都很脆弱，但受到钝击伤害时会承受巨额伤害。此外，被消灭时会释放一次小型电磁脉冲。"
	reagent = /datum/reagent/blob/electromagnetic_web

/datum/blobstrain/reagent/electromagnetic_web/damage_reaction(obj/structure/blob/B, damage, damage_type, damage_flag)
	if(damage_type == BRUTE) // take full brute, divide by the multiplier to get full value
		return damage / B.brute_resist
	return damage * 1.25 //a laser will do 25 damage, which will kill any normal blob

/datum/blobstrain/reagent/electromagnetic_web/death_reaction(obj/structure/blob/B, damage_flag)
	if(damage_flag == MELEE || damage_flag == BULLET || damage_flag == LASER)
		empulse(B.loc, 1, 3) //less than screen range, so you can stand out of range to avoid it

/datum/reagent/blob/electromagnetic_web
	name = "电磁网"
	taste_description = "跳跳糖"
	color = "#83ECEC"

/datum/reagent/blob/electromagnetic_web/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/eye/blob/overmind)
	. = ..()
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection, overmind)
	if(prob(reac_volume*2))
		exposed_mob.emp_act(EMP_LIGHT)
	if(exposed_mob)
		exposed_mob.apply_damage(reac_volume, BURN, wound_bonus=CANT_WOUND)
