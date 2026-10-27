// Preserve action-button layout keys while displaying translated action names.
/proc/chinese_zubbers_modules_action_storage(value, action_type)
	if(value == "切换护眼罩" && ispath(action_type, /datum/action/cooldown/spell/toggle_eye_shields))
		return "Toggle Eye Shields"
	if(value == "切换主动迷彩" && ispath(action_type, /datum/action/cooldown/spell/toggle_active_camo))
		return "Toggle Active Camo"
	if(value == "切换威吓展示" && ispath(action_type, /datum/action/cooldown/spell/toggle_threat_display))
		return "Toggle Threat Display"
	if(value == "伸出利爪" && ispath(action_type, /datum/action/extend_lycan_claws))
		return "Extend Claws"
	if(value == "切换野兽形态" && ispath(action_type, /datum/action/cooldown/spell/beast_form))
		return "Toggle Beast Form"
	if(value == "强化移动" && ispath(action_type, /datum/action/cooldown/protean_servo/movement))
		return "Enhance movement"
	if(value == "强化建造" && ispath(action_type, /datum/action/cooldown/protean_servo/engineering))
		return "Enhance building"
	if(value == "改变形态" && ispath(action_type, /datum/action/innate/alter_form))
		return "Alter Form"
	if(value == "普罗蒂安界面" && ispath(action_type, /datum/action/protean))
		return "Protean Interface"
	if(value == "切换飞行" && ispath(action_type, /datum/action/cooldown/fly))
		return "Toggle fly"
	if(value == "切换穿行" && ispath(action_type, /datum/action/cooldown/noclip))
		return "Toggle noclip"
	if(value == "切换眼罩" && ispath(action_type, /datum/action/item_action/bridle_toggle_blinders))
		return "Toggle blinders"
	if(value == "切换衔铁" && ispath(action_type, /datum/action/item_action/bridle_toggle_gag))
		return "Toggle gag"
	if(value == "天鹅绒声带" && ispath(action_type, /datum/action/item_action/organ_action/velvet))
		return "Velvet Chords"
	if(value == "守护灵时停" && ispath(action_type, /datum/action/cooldown/spell/timestop/guardian))
		return "Guardian Timestop"
	if(value == "按钮" && ispath(action_type, /datum/action/innate/nanite_button))
		return "Button"
	if(value == "查看喵麻歌子" && ispath(action_type, /datum/action/item_action/nyamagotchi_menu))
		return "Check Nyamagotchi"
	if(value == "心灵感应通讯" && ispath(action_type, /datum/action/cooldown/spell/pointed/telepathy))
		return "Telepathic Communication"
	if(value == "鼠王之变" && ispath(action_type, /datum/action/cooldown/rat_fashion))
		return "Rat King's Transformation"
	if(value == "切换弹匣弹出" && ispath(action_type, /datum/action/item_action/toggle_mageject))
		return "Toggle magazine ejection"
	if(value == "唱出音调" && ispath(action_type, /datum/action/sing_tones))
		return "Sing Tones"
	if(value == "次级农场诅咒" && ispath(action_type, /datum/action/cooldown/spell/pointed/barnyardcurse))
		return "Lesser Barnyard Curse"
	if(value == "次级心智交换" && ispath(action_type, /datum/action/cooldown/spell/pointed/mind_transfer))
		return "Lesser Mind Swap"
	if(value == "次级天罚" && ispath(action_type, /datum/action/cooldown/spell/touch/smite))
		return "Lesser Smite"
	if(value == "辛迪加猫咪之力！！" && ispath(action_type, /datum/action/cooldown/spell/shapeshift/kitty/syndie))
		return "SYNDICATE KITTY POWER!!"
	if(value == "猫咪之力！！" && ispath(action_type, /datum/action/cooldown/spell/shapeshift/kitty))
		return "KITTY POWER!!"
	if(value == "振翅" && ispath(action_type, /datum/action/cooldown/spell/moth_and_dash))
		return "Flap Wings"
	if(value == "展翅" && ispath(action_type, /datum/action/cooldown/spell/touch/moth_climb))
		return "Lift Wings"
	if(value == "切换亡者频道" && ispath(action_type, /datum/action/toggle_dead_chat_mob))
		return "Toggle deadchat"
	if(value == "缠绕" && ispath(action_type, /datum/action/innate/constrict))
		return "Constrict"
	return value
