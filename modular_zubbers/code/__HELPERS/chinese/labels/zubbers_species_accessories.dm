/// Appearance labels only; sprite accessory names remain stable preference keys.
/proc/chinese_zubbers_species_accessory_display(value, return_mapping = FALSE)
	var/static/list/labels = list(
		"I Love Dogborgs" = "我爱机器狗", "Bra - Cowprint" = "胸罩 - 奶牛纹", "Panties - Cowprint" = "内裤 - 奶牛纹",
		"Cropped Turtleneck" = "短款高领衫", "Loincloth" = "缠腰布", "Loincloth - Shorter" = "缠腰布 - 短款",
		"Bikini - Cheetah" = "比基尼 - 猎豹纹", "Bikini - Cow" = "比基尼 - 奶牛纹", "Bikini - Zebra" = "比基尼 - 斑马纹",
		"Thong - Cheetah" = "丁字裤 - 猎豹纹", "Thong - Cow" = "丁字裤 - 奶牛纹", "Thong - Zebra" = "丁字裤 - 斑马纹",
		"Stockings - Recolorable" = "长袜 - 可调色", "Stockings - Cheetah" = "长袜 - 猎豹纹", "Stockings - Cow" = "长袜 - 奶牛纹", "Stockings - Zebra" = "长袜 - 斑马纹",
		"Harpy (Large)" = "鹰身女妖（大型）", "Harpy (Large, Alt)" = "鹰身女妖（大型，变体）", "Harpy (Large, Dual)" = "鹰身女妖（大型，双色）", "Harpy (Large, Dual, Alt)" = "鹰身女妖（大型，双色变体）",
		"Big Beehind" = "大蜂腹", "Shadekin" = "影裔", "Shadekin Bandaged" = "影裔（绷带）", "Shadekin Bandaged (Left)" = "影裔（左侧绷带）", "Shadekin Bandaged (Right)" = "影裔（右侧绷带）",
		"Shadekin Gradient" = "影裔（渐变）", "Shadekin Rings" = "影裔（耳环）", "Shadekin Rings (Left)" = "影裔（左耳环）", "Shadekin Rings (Right)" = "影裔（右耳环）",
		"Shadekin Smooth" = "影裔（光滑）", "Shadekin Fluffy" = "影裔（蓬松）", "Shadekin Fluffy Gradient" = "影裔（蓬松渐变）",
		"Shadekin Fluffy Rings" = "影裔（蓬松，耳环）", "Shadekin Fluffy Rings (Left)" = "影裔（蓬松，左耳环）", "Shadekin Fluffy Rings (Right)" = "影裔（蓬松，右耳环）",
		"Shadekin Saggy" = "影裔（下垂）", "Shadekin Saggy Gradient" = "影裔（下垂渐变）", "Shadekin Short" = "影裔（短款）",
		"Shadekin Short Rings" = "影裔（短款，耳环）", "Shadekin Short Rings (Left)" = "影裔（短款，左耳环）", "Shadekin Short Rings (Right)" = "影裔（短款，右耳环）",
		"Cyvian" = "希维安", "Floppy" = "软垂", "Wispy Headwings" = "纤细头翼", "Small Headwings" = "小型头翼",
		"Chunky Mandibles" = "粗壮颚肢", "Beetle Mandibles" = "甲虫颚肢", "Itty Bitty Mandibles" = "迷你颚肢", "Clamped Mandibles" = "闭合颚肢", "Curled Mandibles" = "卷曲颚肢", "Skinny Mandibles" = "纤细颚肢",
		"Eastern Dragon" = "东方龙", "Expie Spike" = "艾克斯派尖刺", "Rabbit (Long)" = "兔子（长款）", "Bnnuy (Tall)" = "兔兔（高耸）", "Bnnuy (Alt) (Tall)" = "兔兔（变体，高耸）", "Bunny (Tall)" = "兔子（高耸）",
		"Sandfox (Tall)" = "沙狐（高耸）", "Shadekin (Round) (Tall)" = "影裔（圆形，高耸）", "Jackalope (Tall)" = "鹿角兔（高耸）", "Tall Tipped Ears" = "高耸尖耳",
		"Droopy" = "下垂", "Frillhawk" = "莫霍克颈鳍", "Neck Frills (New)" = "颈鳍（新版）", "Neck Frills (Fuller New)" = "颈鳍（新版，丰满）",
		"Human (Alt)" = "人类（变体）", "Nondescript (Alt)" = "普通（变体）", "Knotted (Alt)" = "带结（变体）", "Flared (Alt)" = "扩张（变体）", "Barbed, Knotted (Alt)" = "带刺带结（变体）",
		"Tapered (Alt)" = "渐尖（变体）", "Tentacled (Alt)" = "触手（变体）", "Hemi (Alt)" = "双半（变体）", "Knotted Hemi (Alt)" = "带结双半（变体）",
		"Pair (Alt)" = "一对（变体）", "Quad (Alt)" = "四个（变体）", "Sextuple (Alt)" = "六个（变体）", "Sheathed Pair" = "带鞘一对", "Pair" = "一对", "Belly" = "腹部",
		"Classic Halo" = "经典光环", "Messenger Halo" = "信使光环", "Triple-Star Halo" = "三星光环", "Prophet Halo" = "先知光环", "Wayfinder Halo" = "寻路者光环", "Orbital Halo" = "轨道光环",
		"Judge Halo" = "审判者光环", "Winged Cross Halo" = "翼形十字光环", "Lunar Halo" = "月亮光环", "Lauded Halo" = "荣耀光环", "Focused Halo" = "专注光环", "Headstrong Halo" = "倔强光环",
		"Ascendant Halo" = "升华光环", "Radiant Star Halo" = "耀星光环", "Logistician Halo" = "后勤师光环", "Intrepid Halo" = "无畏光环", "Marksman Halo" = "神射手光环", "Pragmatic Halo" = "务实光环",
		"Mercurial Halo" = "善变光环", "Nanotrasen Halo" = "纳米传讯光环", "Medical Halo" = "医疗光环", "Trauma Response Halo" = "创伤应急光环", "Aesculapian Halo" = "医神光环", "Little Crown Halo" = "小王冠光环",
		"Golden Halo" = "金色光环", "Neon Halo" = "霓虹光环", "Mechanist Halo" = "机械师光环", "Seraph Halo" = "炽天使光环", "Crosshair Halo" = "准星光环",
		"Crippled Bull" = "残损牛角", "Hollow-Points" = "空心尖角", "Ticket Rack" = "票架角", "Hopeful Horns" = "希望之角", "Analytical Antlers" = "分析之鹿角", "Spiders Spikes" = "蜘蛛尖刺",
		"Broad Curls" = "宽阔卷角", "Biter's Horns" = "咬噬者之角", "Painted Points" = "彩绘角尖", "Who's Horns?" = "谁的角？", "High-rise Horns" = "高耸之角", "Aged Antlers" = "年长鹿角",
		"Large Antlers" = "大鹿角", "Regal Antlers" = "威严鹿角", "Monarch Antlers" = "君王鹿角", "Short Antlers" = "短鹿角", "Winged Messenger" = "有翼信使",
		"Bent Antennae" = "弯折触角", "Wisteria Antennae" = "紫藤触角", "Slanted Antenna" = "倾斜触角", "Simple (New)" = "简约（新版）", "Broken (New)" = "断裂（新版）", "Ram (New)" = "公羊（新版）",
		"Lightning" = "闪电", "Brimstone" = "硫磺", "Cryptid Antlers" = "隐秘生物鹿角", "Sharp Insectoid Crest" = "锐利虫形头冠", "Mutant Lizard" = "变异蜥蜴", "Mutant Lizard (Inverted)" = "变异蜥蜴（反转）",
		"Dolled Up" = "精心打扮", "Cracked Heart" = "破碎心形", "Paint Splatter" = "飞溅颜料", "Hacker" = "黑客", "Bloody" = "染血", "Dingy Black" = "暗哑黑", "Dingy Blue" = "暗哑蓝", "Dingy Yellow" = "暗哑黄", "Cracked Dingy Yellow" = "开裂暗哑黄",
		"Brown (Greyscale)" = "棕色（灰度）", "Mothra (Greyscale)" = "摩斯拉（灰度）", "Plain (Greyscale)" = "素色（灰度）", "Firewatch (Greyscale)" = "守火者（灰度）", "Regal (Greyscale)" = "尊贵（灰度）", "Poison (Greyscale)" = "毒纹（灰度）",
		"Feathery (Greyscale)" = "羽状（灰度）", "Rosy (Greyscale)" = "玫红（灰度）", "Jungle (Greyscale)" = "丛林（灰度）", "Moffra (Greyscale)" = "蛾斯拉（灰度）", "Oakworm (Greyscale)" = "橡树蚕（灰度）", "Plasmafire (Greyscale)" = "等离子烈焰（灰度）",
		"Royal (Greyscale)" = "王室（灰度）", "Lovers (Greyscale)" = "恋人（灰度）", "Whitefly (Greyscale)" = "白蝇（灰度）", "Witchwing (Greyscale)" = "巫女之翼（灰度）",
		"Skulldog ALT" = "骷髅犬（变体）", "Cervine" = "鹿形", "Cat" = "猫", "Full and Thick" = "饱满厚实", "Full and Thick (Alt)" = "饱满厚实（变体）", "Mandibles (Top)" = "颚肢（上方）", "Snaggletooth" = "突牙",
		"Porcine" = "猪形", "Porcine + Tusks" = "猪形带獠牙", "Synthetic Shark" = "合成鲨鱼", "Synthetic Moth" = "合成蛾人", "Cryptid skull" = "隐秘生物头骨", "Eastern Dragon (Alt)" = "东方龙（变体）", "Haydee" = "海蒂", "Beak (Tiny)" = "喙（微型）", "seikret" = "塞克雷特", "Stubby ALT" = "短粗（变体）",
		"Kangaroo (Alt)" = "袋鼠（变体）", "Rattlesnake" = "响尾蛇", "Black-Backed Jackal" = "黑背胡狼", "Gecko" = "壁虎", "Fuzzy Abdomen (Warm)" = "绒毛腹部（暖色）", "Fuzzy Abdomen (Cold)" = "绒毛腹部（冷色）",
		"Thread-Waisted Wasp" = "细腰蜂", "Wasp (Stinger)" = "胡蜂（带螫针）", "Wasp (Stingerless)" = "胡蜂（无螫针）", "Spider" = "蜘蛛", "Spider (Scarred)" = "蜘蛛（伤疤）", "Spider (Spotted)" = "蜘蛛（斑点）", "Spider (Tipped)" = "蜘蛛（异色尖端）", "Spider (Contour)" = "蜘蛛（轮廓）", "Spider (Underbelly)" = "蜘蛛（下腹）",
		"Earwig" = "蠼螋", "Centipede" = "蜈蚣", "Tailmaw (Coloured Head)" = "尾口（彩色头部）", "Tailmaw (Striped)" = "尾口（条纹）", "Tailmaw (Striped, Coloured Head)" = "尾口（条纹，彩色头部）",
		"Large cat (Plain)" = "大型猫尾（素色）", "Large cat (Painted Tip)" = "大型猫尾（异色尖端）", "Large cat (Striped)" = "大型猫尾（条纹）", "Large cat (Circles)" = "大型猫尾（环纹）", "Large cat (Covered Top)" = "大型猫尾（背部覆色）",
		"Fox (Alt 3)" = "狐狸（变体 3）", "Kitsune (Ann)" = "妖狐（安）", "Chemlight" = "化学荧光", "Striped tail" = "条纹尾巴",
		"Large Shark" = "大型鲨鱼", "Large Shark (finless)" = "大型鲨鱼（无鳍）", "Large Shark (striped)" = "大型鲨鱼（条纹）", "Large Shark (striped, finless)" = "大型鲨鱼（条纹，无鳍）", "Shadekin Big and Fluffy" = "影裔（巨大蓬松）", "Hybrid Coyote (Large)" = "混种郊狼（大型）", "seikret (Alt)" = "塞克雷特（变体）",
		"Kitsune (Inari)" = "妖狐（稻荷）", "Oversized Fluff tail" = "超大绒毛尾巴", "Shadekin Long Tail" = "影裔长尾", "Shadekin Big Tail" = "影裔大尾", "Kitsune" = "妖狐", "Kitsune (alt)" = "妖狐（变体）", "Chemtaur" = "化学半身兽", "striped canine" = "条纹犬科",
		"owl" = "猫头鹰", "Moth (Bluespace)" = "蛾翼（蓝空间）", "Moth (Strawberry)" = "蛾翼（草莓）", "Moth (Clockwork)" = "蛾翼（发条）", "Citheronia (greyscale)" = "帝王蛾（灰度）", "Tech Arm" = "机械臂", "Pinioned Wings" = "剪羽之翼",
		"Mantis (Aloft)" = "螳螂（抬起）", "Mantis (Sunken)" = "螳螂（下垂）", "Mantis (Top)" = "螳螂（顶部）", "Tarantula" = "捕鸟蛛", "Spiderlegs (Thin)" = "蜘蛛腿（纤细）", "Spiderlegs (Striped)" = "蜘蛛腿（条纹）", "Spiderlegs (Thick)" = "蜘蛛腿（粗壮）", "Half Spiderlegs (Thick)" = "半截蜘蛛腿（粗壮）", "Spiderlegs (Segmented)" = "蜘蛛腿（分节）", "Spiderlegs (Mechanical)" = "蜘蛛腿（机械）",
		"Dragonfly Wings" = "蜻蜓翅膀", "Beetle Elytra" = "甲虫鞘翅", "Virtualized Wings" = "虚拟翅膀", "Moth (Burnt Off)" = "蛾翼（烧焦）",
		"Moth (Whitefly Greyscale)" = "蛾翼（白蝇，灰度）", "Moth (Brown Greyscale)" = "蛾翼（棕色，灰度）", "Moth (Deathshead Greyscale)" = "蛾翼（骷髅头，灰度）", "Moth (Atlas Greyscale)" = "蛾翼（皇蛾，灰度）", "Moth (Poison Greyscale)" = "蛾翼（毒纹，灰度）",
		"Moth (Ragged Greyscale)" = "蛾翼（破损，灰度）", "Moth (Feathery Greyscale)" = "蛾翼（羽状，灰度）", "Moth (Firewatch Greyscale)" = "蛾翼（守火者，灰度）", "Moth (Lovers Greyscale)" = "蛾翼（恋人，灰度）", "Moth (Jungle Greyscale)" = "蛾翼（丛林，灰度）",
		"Moth (Rosy Greyscale)" = "蛾翼（玫红，灰度）", "Moth (Moffra Greyscale)" = "蛾翼（蛾斯拉，灰度）", "Moth (Oakworm Greyscale)" = "蛾翼（橡树蚕，灰度）", "Moth (Plasmafire Greyscale)" = "蛾翼（等离子烈焰，灰度）", "Moth (Monarch Greyscale)" = "蛾翼（帝王蝶，灰度）",
		"Moth (Royal Greyscale)" = "蛾翼（王室，灰度）", "Moth (Plain Greyscale)" = "蛾翼（素色，灰度）", "Moth (Luna Greyscale)" = "蛾翼（月蛾，灰度）", "Moth (Witchwing Greyscale)" = "蛾翼（巫女之翼，灰度）",
		"Second Arms (Non-Functional)" = "第二对手臂（无功能）", "Second Arms (Greyscale - Non-Functional)" = "第二对手臂（灰度，无功能）",
		"Cat Scream" = "猫叫", "Slug Scream" = "蛞蝓尖叫", "Ascent Scream" = "飞升者尖叫",
	)
	return return_mapping ? labels : (labels[value] || value)

/datum/preference/choiced/scream/compile_constant_data()
	var/list/data = ..()
	var/list/display_names = list()
	for(var/value in get_choices())
		display_names[value] = chinese_zubbers_species_accessory_display(value)
	data["display_names"] = display_names
	return data
