/// Modular Map Loader doesnt like subfolders
/datum/lazy_template/virtual_domain/ancient_milsim
	name = "古代军事模拟器"
	announce_to_ghosts = TRUE
	cost = BITRUNNER_COST_HIGH
	desc = "重温边境战争早已逝去的“热”战阶段，扮演太阳联邦突击队清扫 CIN 营地；由太阳联邦复古爱好者赞助。 \
	强烈建议多人游玩并做好充分准备。"
	completion_loot = list(/obj/item/stack/spacecash/c200 = 3) //Sponsored
	difficulty = BITRUNNER_DIFFICULTY_HIGH
	help_text = "本域的最后阶段有可能会非常偏向玩家对战。最好别独自前来，并偷偷带些能力磁盘和装备磁盘。"
	forced_outfit = /datum/outfit/solfed_bitrun
	key = "ancient_milsim"
	map_name = "skyrat_ancientmilsim"
	mob_modules = list(/datum/modular_mob_segment/cin_mobs)
	reward_points = BITRUNNER_REWARD_HIGH
	secondary_loot = list(
		/obj/item/stack/spacecash/c100 = 12,
		/obj/item/disk/bitrunning/item/ancient_milsim = 3,
	)
