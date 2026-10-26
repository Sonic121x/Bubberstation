
/datum/antagonist/bloodsucker/proc/return_full_name()
	var/fullname = bloodsucker_name ? bloodsucker_name : owner.current.name
	if(bloodsucker_title)
		fullname = "[bloodsucker_title] [fullname]"
	if(bloodsucker_reputation)
		fullname += "·[bloodsucker_reputation]"

	return fullname

///Returns a First name for the Bloodsucker.
/datum/antagonist/bloodsucker/proc/SelectFirstName()
	if(owner.current.gender == MALE)
		bloodsucker_name = pick(
			"德斯蒙德","鲁道夫","德古拉","弗拉德","彼得","格雷戈尔",
			"克里斯蒂安","克里斯托夫","马尔库","安德烈","康斯坦丁",
			"格奥尔基","格里戈雷","伊利耶","雅各布","卢卡","米哈伊尔","帕维尔",
			"瓦西里","屋大维","索林","斯文","奥雷尔","阿莱克塞","尤斯廷",
			"西奥多","迪米特里","奥克塔夫","达米安","马格努斯","该隐","亚伯", // Romanian/Ancient
			"卢修斯","盖乌斯","奥托","巴尔比努斯","阿卡狄乌斯","罗曼诺斯","阿莱克修斯","维特里乌斯", // Latin
			"墨兰托斯","透特拉斯","俄尔卡摩斯","阿敏托尔","阿克西翁", // Greek
			"托特","图特摩斯","奥索尔孔","诺弗雷特","敏莫图","卡夫拉", // Egyptian
			"迪奥",
		)
	else
		bloodsucker_name = pick(
			"伊斯拉娜","蒂拉","格雷甘娜","皮特拉","希尔达",
			"安德拉","克里娜","维奥雷拉","维奥丽卡","阿内莫娜",
			"卡梅莉亚","娜西莎","索琳娜","阿莱西亚","索菲娅",
			"格拉达","阿卡娜","摩根","拉萨拉","约安娜","埃琳娜",
			"阿丽娜","罗迪卡","特奥多拉","丹妮莎","米哈埃拉",
			"斯韦特拉","斯特凡妮娅","迪亚娜","凯尔莎","莉莉丝", // Romanian/Ancient
			"阿莱克西娅","阿塔娜西娅","卡莉斯塔","卡蕾娜","涅斐勒","斯库拉","乌尔莎", // Latin
			"阿尔刻斯提斯","达玛里斯","埃莉萨维特","克托尼娅","特奥多拉", // Greek
			"奈弗雷特","安赫森佩普", // Egyptian
		)

///Returns a Title for the Bloodsucker.
/datum/antagonist/bloodsucker/proc/SelectTitle(am_fledgling = FALSE, forced = FALSE)
	// Already have Title
	if(!forced && bloodsucker_title != null)
		return
	// Titles [Master]
	if(am_fledgling)
		bloodsucker_title = null
		return
	if(owner.current.gender == MALE)
		bloodsucker_title = pick(
			"伯爵",
			"男爵",
			"子爵",
			"亲王",
			"公爵",
			"沙皇",
			"恐惧领主",
			"领主",
			"尊主",
		)
	else
		bloodsucker_title = pick(
			"女伯爵",
			"女男爵",
			"女子爵",
			"公主",
			"女公爵",
			"女沙皇",
			"恐惧女领主",
			"女领主",
			"女尊主",
		)
	to_chat(owner, span_announce("你获得了头衔！从今往后，你被称为<i>[return_full_name()]</i>！"))

///Returns a Reputation for the Bloodsucker.
/datum/antagonist/bloodsucker/proc/SelectReputation(am_fledgling = FALSE, forced = FALSE)
	// Already have Reputation
	if(!forced && bloodsucker_reputation != null)
		return

	if(am_fledgling)
		bloodsucker_reputation = pick(
			"粗鄙者",
			"稚嫩者",
			"无学者",
			"新皈依者",
			"初学者",
			"生疏者",
			"雏鸟",
			"年轻者",
			"新生者",
			"残片之裔",
			"未经考验者",
			"未获认可者",
			"无名者",
			"初醒者",
			"初诞者",
			"拾荒者",
			"无知者",
			"未染者",
			"失宠者",
			"革职者",
			"蒙羞者",
			"卑顺者",
			"怯懦者",
			"破碎者",
			"新人",
		)
	else if(owner.current.gender == MALE && prob(10))
		bloodsucker_reputation = pick(
			"受诅者之王",
			"鲜血之王",
			"刀锋皇帝",
			"罪孽领主",
			"神王",
		)
	else if(owner.current.gender == FEMALE && prob(10))
		bloodsucker_reputation = pick(
			"受诅者女王",
			"鲜血女王",
			"刀锋女皇",
			"罪孽女领主",
			"女神王",
		)
	else
		bloodsucker_reputation = pick(
			"屠夫","血魔","绯红者","赤红者","漆黑者","恐怖化身",
			"夜行者","畏惧之名","饥渴者","恶魔","恶毒者","邪恶者",
			"远古者","瘟疫使者","阴险者","遗忘者","卑劣者","灾厄者",
			"审判官","收割者","憎恶之名","强悍者","背叛者","毁灭者",
			"受诅者","被诅咒者","可怖者","凶残者","亵渎者","污秽者",
			"堕落者","肮脏者","猎杀者","杀人者","君主","屠戮者",
			"弃绝者","癫狂者","恶龙","野蛮者","恶徒","恶贯满盈者",
			"审判官","掠夺者","骇人者","不朽者","不死者","霸主",
			"腐化者","地狱之裔","暴君","嗜血者",
		)

	to_chat(owner, span_announce("你赢得了名号！从今往后，你被称为<i>[return_full_name()]</i>！"))
