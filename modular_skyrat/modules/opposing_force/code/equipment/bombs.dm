/datum/opposing_force_equipment/bomb_chemical
	category = OPFOR_EQUIPMENT_CATEGORY_BOMB_CHEM

/datum/opposing_force_equipment/bomb_chemical/c4
	item_type = /obj/item/grenade/c4
	description = "一块塑性炸药，用来炸开墙壁、门，当然也可以炸人。"

/datum/opposing_force_equipment/bomb_chemical/x4
	item_type = /obj/item/grenade/c4/x4
	description = "类似C4，但爆炸威力更强，且为定向爆破而非圆形爆破。"

/datum/opposing_force_equipment/bomb_chemical/minibomb
	name = "辛迪加迷你炸弹"
	item_type = /obj/item/grenade/syndieminibomb
	description = "迷你炸弹是一种引信延时五秒的手榴弹。引爆时除了会对附近人员造成大量伤害，还会炸出一个小型船体破口。"

/datum/opposing_force_equipment/bomb_chemical/minibomb_cluster
	name = "辛迪加迷你炸弹集束手榴弹"
	admin_note = "破坏力极强，爆炸范围相当于一座普通指挥舰桥。"
	item_type = /obj/item/grenade/clusterbuster/syndieminibomb

/datum/opposing_force_equipment/bomb_chemical/fragnade
	item_type = /obj/item/grenade/frag
	description = "一种引爆后释放大量破片的破片手榴弹，可造成最大程度的创伤。"

/datum/opposing_force_equipment/bomb_chemical/fire
	name = "燃烧手榴弹"
	admin_note = "名字吓人，实际效果很一般。"
	item_type = /obj/item/grenade/chem_grenade/incendiary

/datum/opposing_force_equipment/bomb_chemical/fire_cluster
	name = "燃烧集束手榴弹"
	admin_note = "产生充满房间的等离子火焰，持续约10秒。"
	item_type = /obj/item/grenade/clusterbuster/inferno

/datum/opposing_force_equipment/bomb_chemical/clf3
	name = "三氟化氯手榴弹"
	admin_note = "大多数情况下应建议玩家改用‘燃烧手榴弹’。这种手榴弹影响范围巨大，会将没有地板覆盖的地块烧穿成太空。"
	item_type = /obj/item/grenade/chem_grenade/clf3
/*
/datum/opposing_force_equipment/bomb_chemical/clf3_cluster //this fucking thing deletes your station
	name = "Trifluoride Cluster-Grenade"
	admin_note = ""
	item_type = /obj/item/grenade/clusterbuster/clf3
*/
/datum/opposing_force_equipment/bomb_chemical/facid
	name = "酸液手榴弹"
	admin_note = "这东西会腐蚀掉玩家的大部分衣物。"
	item_type = /obj/item/grenade/chem_grenade/facid
/*
/datum/opposing_force_equipment/bomb_chemical/facid_cluster //massive collateral. only uncomment if you're OK with all of crew becoming nude
	name = "Acid Cluster-Grenade"
	item_type = /obj/item/grenade/clusterbuster/facid
*/
/datum/opposing_force_equipment/bomb_chemical/radnade
	item_type = /obj/item/grenade/gluon
	description = "一种原型手榴弹，会冻结目标区域并释放致命的辐射波。"

/datum/opposing_force_equipment/bomb_chemical/henade
	item_type = /obj/item/grenade/syndieminibomb/concussion
	description = "用于震晕并使敌人丧失行动能力的手榴弹。爆炸威力仍不容小觑。"

/datum/opposing_force_equipment/bomb_chemical/anti_grav
	name = "反重力手榴弹"
	item_type = /obj/item/grenade/antigravity

/datum/opposing_force_equipment/bomb_chemical/emp
	name = "电磁脉冲手榴弹"
	item_type = /obj/item/grenade/empgrenade

/datum/opposing_force_equipment/bomb_chemical/flashbang
	name = "闪光震撼弹"
	item_type = /obj/item/grenade/flashbang
	description = "一种通过闪光和声波致晕的手榴弹，适合以非致命方式瘫痪人群。"

/datum/opposing_force_equipment/bomb_chemical/smoke
	name = "烟雾手榴弹"
	item_type = /obj/item/grenade/smokebomb

/datum/opposing_force_equipment/bomb_chemical/soap
	name = "肥皂集束手榴弹"
	item_type = /obj/item/grenade/clusterbuster/soap

/datum/opposing_force_equipment/bomb_chemical/moustache
	name = "催胡手榴弹"
	item_type = /obj/item/grenade/chem_grenade/teargas/moustache
	admin_note = "让受害者长出持续十分钟的八字胡。"

/datum/opposing_force_equipment/bomb_chemical/carp
	name = "太空鲤鱼手榴弹"
	item_type = /obj/item/grenade/spawnergrenade/spesscarp

/datum/opposing_force_equipment/bomb_chemical/carp_cluster
	name = "太空鲤鱼集束手榴弹"
	item_type = /obj/item/grenade/clusterbuster/spawner_spesscarp

/datum/opposing_force_equipment/bomb_chemical/viscerator
	name = "剖脏机投放手榴弹"
	item_type = /obj/item/grenade/spawnergrenade/manhacks
	description = "一种启动后会部署一群剖脏机的特殊手榴弹，它们会追逐并撕碎区域内所有非特工人员。"

/datum/opposing_force_equipment/bomb_chemical/viscerator_cluster
	name = "剖脏机投放集束手榴弹"
	item_type = /obj/item/grenade/clusterbuster/spawner_manhacks

/datum/opposing_force_equipment/bomb_chemical/nukedelivery
	name = "核爆特工投放手榴弹"
	item_type = /obj/item/grenade/spawnergrenade/therealnuke
	description = "一枚令人困惑的手榴弹，里面装着两名脱水核爆特工。启动后请退远。"

/datum/opposing_force_equipment/bomb_chemical/buzzkill
	name = "蜂杀手榴弹"
	item_type = /obj/item/grenade/spawnergrenade/buzzkill
	description = "启动后释放一群愤怒蜜蜂的手榴弹。这些蜜蜂会用随机毒素无差别攻击敌友。由蜜蜂解放阵线和猛虎合作社提供。"
	admin_note = "警告：这种手榴弹释放的蜜蜂几乎可能携带任何化学物质，只需几枚就能形成庞大的蜂群（每枚10只！！）。"

/datum/opposing_force_equipment/bomb_chemical/pizza
	name = "披萨炸弹"
	item_type = /obj/item/pizzabox/bomb
	description = "一个在盒盖上巧妙安装了炸弹的披萨盒。需要先打开盒子设定计时器；之后再次开盒便会触发倒计时，时间一到就会爆炸。附赠免费披萨，供你或你的目标享用！"

/datum/opposing_force_equipment/bomb_payload
	category = OPFOR_EQUIPMENT_CATEGORY_BOMB_PAYLOAD

/datum/opposing_force_equipment/bomb_payload/syndicate
	name = "辛迪加炸弹"
	item_type = /obj/item/sbeacondrop/bomb
	description = "一枚大型高威力炸弹，可用扳手固定，并设置可调计时器后启动。"
	admin_note = "警告：这枚炸弹相当大，能炸毁整个房间。"

/datum/opposing_force_equipment/bomb_payload/syndicate_emp
	name = "辛迪加电磁脉冲炸弹"
	item_type = /obj/item/sbeacondrop/emp
	description = "经过改装的辛迪加炸弹，改为释放大范围电磁脉冲。"

/datum/opposing_force_equipment/bomb_payload/syndicate_sink
	name = "辛迪加电力吸收器"
	item_type = /obj/item/sbeacondrop/powersink

/datum/opposing_force_equipment/bomb_payload/syndicate_clown_bomb
	name = "辛迪加小丑炸弹"
	item_type = /obj/item/sbeacondrop/clownbomb
	admin_note = "不会造成伤害，只会生成二十个被动的简单生物小丑。"
