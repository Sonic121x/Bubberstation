/// Cosmetic names are persistent DNA and preference keys. Translate only their labels.
/proc/chinese_zubbers_modules_accessory_display(value, return_mapping = FALSE)
	var/static/list/names = list(
		"Body Gloss" = "身体光泽", "Synth Joints" = "合成人关节",
		"Face Disc" = "面盘", "Facemask" = "面罩纹", "Vertical Stripe" = "竖条纹", "Lips" = "嘴唇", "Fangs" = "獠牙", "Deer Snout (Marking)" = "鹿吻（纹样）",
		"Anime Eyes (Inner)" = "动漫眼睛（内侧）", "Anime Eyes (Outer)" = "动漫眼睛（外侧）", "Clown Cross" = "小丑十字纹", "Clown Lips" = "小丑唇纹", "Cyclops Sclera" = "独眼巩膜",
		"Longsock" = "长袜纹", "Sock" = "袜纹", "Sleeve" = "袖纹", "Glove" = "手套纹", "Shoulder" = "肩部", "Elbow" = "肘部", "Hip" = "髋部", "Chestplate" = "胸甲纹",
		"Monster Mouth (White)" = "怪物巨口（白色）", "Monster Mouth (White, eyes-compatible)" = "怪物巨口（白色，可搭配眼睛）", "Body Weight (Greyscale)" = "丰腴体态（灰度）",
		"Belly Button" = "肚脐", "Belly Monster" = "腹部怪物", "Belly Monster (Alt)" = "腹部怪物（另版）", "Cleavage" = "乳沟", "Third Eye" = "第三只眼",
		"Splotches" = "斑块", "Splotches Swapped" = "反色斑块", "Chitin" = "几丁质甲壳", "Dome" = "圆顶", "Top Scar Variant 1" = "胸部手术疤痕1", "Top Scar Variant 2" = "胸部手术疤痕2",
		"Tall Eyes" = "纵长眼睛", "Wide Eyes" = "横宽眼睛", "Angled Eyes" = "斜眼", "Protogen Leg - Digitigrade" = "原型兽腿部（趾行）", "Protogen Arm" = "原型兽手臂", "Protogen Chest" = "原型兽胸部", "Protogen Crotch Plate" = "原型兽裆部护甲",
		"Human Skintone" = "人类肤色", "Cryptid Ribs" = "神秘兽肋骨", "Cryptid Fur" = "神秘兽毛皮", "Chitin Forearm Armor" = "几丁质前臂护甲", "Chitin Shoulderpad" = "几丁质肩甲",
		"Chemlight" = "化学荧光", "Chembright" = "明亮化学荧光", "Belly trim" = "腹部边纹", "Eastern Dragon" = "东方龙", "Eastern Dragon 2" = "东方龙2", "Zombie" = "丧尸",
		"Hyena Mane" = "鬣狗鬃毛", "Tail Hair" = "尾发", "Hairfre" = "自由发型", "Side Hair" = "侧发", "Avian Crest" = "鸟冠", "Glamour" = "华丽发型", "Royal Curls" = "皇家卷发", "Emma" = "艾玛式", "Ozen" = "欧森式", "Damsel" = "淑女式",
		"Wavy over eye" = "遮眼波浪发", "Straight over eye" = "遮眼直发", "Side Straight" = "侧垂直发", "Straight Long" = "长直发", "Straight Long (Very)" = "超长直发", "Deathhawk" = "死亡朋克发型", "Bedhead (+hairline)" = "睡乱发（带发际线）", "Spicy (Alt)" = "火辣发型（另版）",
		"Honse" = "马儿发型", "Marge" = "玛姬式", "Pod Male" = "植物人男式", "Pod Female" = "植物人女式", "Tentacle hair" = "触手发型",
		"Warm Thigh Highs" = "保暖过膝袜", "Warm Ankle Socks" = "保暖踝袜", "Warm Short Socks" = "保暖短袜", "NonTemp Thigh Highs" = "普通过膝袜", "Cool thigh highs." = "清凉过膝袜", "Cool Ankle Socks." = "清凉踝袜", "Cool Short Socks." = "清凉短袜", "Nontemp ankle socks." = "普通踝袜", "Nontemp short socks." = "普通短袜",
		"Owl fluff" = "猫头鹰绒羽", "Cryptid Neck Fur" = "神秘兽颈毛", "Naja Hood" = "眼镜蛇颈兜", "Fringe" = "刘海", "Cutout" = "镂空",
		"Flaguardyain" = "弗拉瓜迪恩式", "Lizard Tongue Flick" = "蜥蜴吐舌", "Lizard Tongue Flick Slow" = "蜥蜴慢速吐舌", "Lizard Tongue Flick Fast" = "蜥蜴快速吐舌", "Nose Lick" = "舔鼻", "Full Stub" = "满脸短胡茬", "Twisted Long" = "长扭辫", "Twisted" = "扭辫", "Wicked" = "邪魅式", "Inari" = "稻荷式",
		"Short (Side)" = "短发（侧分）", "Ponytails (Berly)" = "马尾（伯莉式）", "Edgerunner" = "边缘行者式", "Dreadlocks Alt" = "脏辫（另版）", "Dreadtail" = "脏辫马尾", "Short (Bob)" = "短发（波波头）", "Long Smoothy" = "柔顺长发", "Slime Tendrils - Bangs" = "史莱姆触须刘海", "Fluffball" = "蓬松毛球",
		"Moth Ponytail 1" = "蛾族马尾1", "Moth Ponytail 2" = "蛾族马尾2", "Moth Hair Spiky" = "蛾族尖刺发", "Moth Hair Messy" = "蛾族乱发", "Moth Hair Tuft" = "蛾族发簇", "Moth Hair Short" = "蛾族短发", "Rogue" = "游侠式",
		"Slime Tails" = "史莱姆双尾", "Pigtails Cupid" = "丘比特双马尾", "Pigtails Antenna" = "触角双马尾", "Teto Drills" = "重音螺旋双马尾", "Pigtails 6" = "双马尾6", "Afro Over Eyes" = "遮眼爆炸头", "Wolf Cut" = "狼尾头",
		"Slime Fringe Long" = "史莱姆长刘海", "Slime Tails 2" = "史莱姆双尾2", "Slime Ponytail Low" = "史莱姆低马尾", "Slime Blobby" = "史莱姆团发", "Slime Ponytail High" = "史莱姆高马尾", "Afro Three Quarters" = "四分之三爆炸头", "Long Dreads" = "长脏辫", "Ponytail Fro" = "爆炸头马尾", "Long Side Cut" = "长侧削发", "Frizzy Side Cut" = "蓬松侧削发", "Side Cut Bang" = "侧削刘海", "Slime Jelly" = "史莱姆果冻发", "Bigger Tails" = "大双尾", "Beard (Viking)" = "胡须（维京式）",
		"Sylveon Bow" = "仙子伊布蝴蝶结", "Very Long" = "超长", "Very Short" = "超短", "Mid Bun Short" = "中发髻（短）", "Mid Bun Normal" = "中发髻（标准）", "Mid Bun Long" = "中发髻（长）", "Mid Bun Very Short" = "中发髻（超短）", "Insulated" = "隔热型", "Excited" = "兴奋型", "Reserved" = "矜持型", "Tuux" = "图克斯式", "Long Tuux" = "长图克斯式", "Loose Braid" = "松辫",
		"Synthetic Lizard - Snout" = "合成蜥蜴吻部", "Synthetic Lizard - Snout Under" = "合成蜥蜴吻部下侧", "Synthetic Lizard - Snout Tertiary" = "合成蜥蜴吻部第三色", "Synthetic Lizard - Snout Tertiary Under" = "合成蜥蜴吻部下侧第三色", "Synthetic Lizard - Snout Long" = "合成蜥蜴长吻", "Synthetic Lizard - Snout Long & Thick" = "合成蜥蜴粗长吻部",
		"Synthetic Lizard - Barless" = "合成蜥蜴无条纹", "Synthetic Lizard - Barless Under" = "合成蜥蜴无条纹下侧", "Synthetic Lizard - Barless Over" = "合成蜥蜴无条纹上侧", "Synthetic Lizard - Barless Tertiary" = "合成蜥蜴无条纹第三色", "Synthetic Lizard - Barless Tertiary Under" = "合成蜥蜴无条纹下侧第三色", "Protogen" = "原型兽", "Protogen - With Bolt" = "原型兽（带螺栓）",
		"Synthetic Lizard" = "合成蜥蜴", "Synthetic Lizard - Antennae" = "合成蜥蜴触角", "Synthetic Lizard - Curled" = "合成蜥蜴卷曲触角", "Synthetic Lizard - Thick" = "合成蜥蜴粗触角", "Synthetic Lizard - Thick Light" = "合成蜥蜴粗触角（发光）", "Synthetic Lizard - Short" = "合成蜥蜴短触角", "Synthetic Lizard - Sharp" = "合成蜥蜴尖触角", "Synthetic Lizard - Sharp Light" = "合成蜥蜴尖触角（发光）", "Synthetic Lizard - Horns" = "合成蜥蜴角状触角", "Synthetic Lizard - Horns Light" = "合成蜥蜴角状触角（发光）", "Synthetic Lizard - Cobra Hood" = "合成蜥蜴蛇颈兜", "Synthetic Lizard - Cobra Hood (Ears)" = "合成蜥蜴蛇颈兜（耳部）",
		"Cybernetic Lizard" = "机械蜥蜴", "Cybernetic Lizard (Inverted)" = "机械蜥蜴（反色）", "Cybernetic Feline" = "机械猫", "Cybernetic Feline (Inverted)" = "机械猫（反色）", "Cybernetic Horse" = "机械马", "Cybernetic Horse (Inverted)" = "机械马（反色）", "Cybernetic Bunny" = "机械兔", "Cybernetic Wolf" = "机械狼", "Cybernetic Wolf (Inverted)" = "机械狼（反色）", "Cybernetic Naga" = "机械娜迦", "Cybernetic Naga, Fat" = "机械娜迦（肥胖）",
		"Synthetic Big Legs" = "合成巨腿", "Synthetic Big Legs, Stanced" = "合成巨腿（站姿）", "Synthetic Big Legs, Bird" = "合成巨腿（鸟类）", "Synthetic Big Legs, Stanced Bird" = "合成巨腿（鸟类站姿）", "Synthetic Big Legs, Pegs" = "合成巨腿（桩足）", "Synthetic Big Legs, Stanced Pegs" = "合成巨腿（桩足站姿）", "Robotic Horse" = "机器人马",
		"Cow" = "牛", "Cow (Spotted)" = "牛（斑点）", "Bunny" = "兔", "Drake" = "龙", "Drake (Old)" = "龙（旧版）", "Tarantula" = "捕鸟蛛", "Drider" = "蛛化精灵", "Broodmother" = "育母蛛", "Insect" = "昆虫", "Winged Insect" = "有翼昆虫", "Eevee" = "伊布", "Horse" = "马", "Naga" = "娜迦", "Naga, Fat" = "娜迦（肥胖）", "Naga, Striped" = "娜迦（条纹）", "Naga, Rattle" = "娜迦（响尾）", "Otie" = "奥蒂兽", "Scolipede" = "蜈蚣王", "Tentacle, Alt" = "触手（另版）", "Canine" = "犬类", "Feline" = "猫类", "Goop" = "黏液",
		"Big Legs" = "巨腿", "Big Legs, Stanced" = "巨腿（站姿）", "Big Legs, Bird" = "巨腿（鸟类）", "Big Legs, Stanced Bird" = "巨腿（鸟类站姿）", "Big Legs, Pegs" = "巨腿（桩足）", "Big Legs, Stanced Pegs" = "巨腿（桩足站姿）",
		"Sylveon ribbons" = "仙子伊布缎带", "Aeromorph Delta" = "拟机体三角翼", "Aeromorph Variable" = "拟机体变后掠翼", "Aeromorph Straight" = "拟机体平直翼", "Aeromorph Swept" = "拟机体后掠翼", "Aeromorph Flying" = "拟机体飞翼", "Aeromorph Hyper" = "拟机体机翼（Hyper站式）",
	)
	if(return_mapping)
		return names
	return names[value] || value
