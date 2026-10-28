/datum/job/blacksmith
	title = JOB_BLACKSMITH
	description = "锻造货品，再把它们卖掉。"
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_QM
	config_tag = "BLACKSMITH"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/blacksmith
	plasmaman_outfit = /datum/outfit/plasmaman/blacksmith

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR
	display_order = JOB_DISPLAY_ORDER_BLACKSMITH
	bounty_types = CIV_JOB_SMITH

	departments_list = list(
		/datum/job_department/cargo,
		)

	mail_goodies = list(
		/obj/item/stack/sheet/mineral/coal/ten = 20,
		/obj/item/stack/sheet/mineral/silver = 5,
		/obj/item/stack/sheet/mineral/gold = 5,
	)

	family_heirlooms = list(/obj/item/pen/fountain, /obj/item/forging/hammer, /obj/item/forging/tongs)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

	job_spawn_title = JOB_ASSISTANT

	voice_of_god_silence_power = 3
	rpg_title = "铁匠"
	required_languages = null
	alt_titles = list(
		"Blacksmith",
		"Ithastrist",
		"Metalurgist",
		"Metal Worker",
		"Metalsmith",
		"Forge Artisan",
		"Forgemaster",
		"Weaponsmith",
		"Armorsmith",
	)
	tgui_icon = FA_ICON_HAMMER

/datum/outfit/job/blacksmith
	name = "Blacksmith"
	jobtype = /datum/job/blacksmith

	id_trim = /datum/id_trim/job/blacksmith
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/long
	suit = /obj/item/clothing/suit/leatherapron
	backpack_contents = list(
		/obj/item/forging/hammer = 1,
		/obj/item/forging/tongs = 1,
		/obj/item/forging/billow = 1,
		/obj/item/stack/sheet/mineral/wood = 25,
		/obj/item/paper/pamphlet/blacksmith_tutorial = 1,
	)
	glasses = /obj/item/clothing/glasses/hud/permit
	belt = /obj/item/modular_computer/pda/crew/cargo
	ears = /obj/item/radio/headset/headset_cargo
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/color/brown
	skillchips = list(/obj/item/skillchip/job/blacksmith)

/obj/item/paper/pamphlet/blacksmith_tutorial
	name = "锻造手册"
	default_raw_text = "铁匠负责各类装备的精工细作：刀剑、护甲、工具腰带等等。<br>\n\
	如果有人想要专门定制的装备——尤其是老式货色——那就该来找你。<br>\n\
	如果你有一间专属的部门房间，里面应当配有以下设施：<br> \n\
	用<b>锻炉</b>加热金属板，好把它锻打成想要的形状。<br> \n\
	<b>壁挂空调</b>会带走锻炉逸散的多余热量，免得你把自己活活煮熟。<b>记得把它打开！</b><br> \n\
	<b>铁砧</b>可以放置烧热但尚未成形的物品。<br>\n\
	<b>淬火槽</b>可用来冷却烧热的物品。<br>\n\
	<b>工作台</b>是你最终完成装备制作的地方。<br>\n\
	<b>风箱</b>朝锻炉内鼓风，加快升温。<br>\n\
	<b>夹钳</b>能让你安全地把材料送进锻炉，也能安全地夹取灼热的物品。<br>\n\
	<b>锻造锤</b>配合铁砧使用，可将物品敲打成形。<br>\n\
	如果没有专属的部门房间，你可以在货运订购控制台购买“锻造工作站套装”来获取固定设备，购买“铁匠工具套装”来获取手持工具。实在不行，上述设施几乎都能用普通木材和铁打造（铁砧除外，它需要钛）。手持一叠木材、铁或钛时点击它，即可查看可制作的物品。<br>\n\
	<br> \
	如何加热你的锻炉：<br>\n\
	-1：准备燃料。煤或木材都可以。<br>\n\
	-2：把燃料放进锻炉。<br>\n\
	-3：用风箱向锻炉鼓风，加快升温。<br>\n\
	-3a：如果不往锻炉里鼓风，燃烧的燃料也会自行加热。<br>\n\
	<br>\n\
	如何打造武器：<br>\n\
	-1：用夹钳夹起一块铁板或玻璃板（或其他可锻造材料），送进已加热的锻炉。<br>\n\
	-2：想好要打造什么。然后用夹钳把加热好的物品从锻炉中取出，放到铁砧上。 <br>\n\
	-3：抡起锤子一顿猛敲！注意节奏；<b>以正确的节奏挥锤，就能锻造得完美无缺</b>。<br>\n\
	-3a：动作太慢的话，加热的金属可能在成形前就冷却了。若真如此，用夹钳把它夹起来，放回锻炉重新加热。 <br>\n\
	-4：觉得差不多了，就用淬火槽为金属淬火。<br>\n\
	-5：拿起淬火后的武器部件，固定到制作台上。提前备好木材作底座，然后在台边用锤子把武器完成！<br>\n\
	<br>\n\
	如何制作其他装备：<br>\n\
	-1：空手点击制作台，查看你能制作哪些东西。<br>\n\
	-2：选定要制作的物品后，制作台就会选中对应配方。检查制作台（Shift + 点击）即可查看所需材料。<br>\n\
	-3：备齐材料，放在制作台旁边。<br>\n\
	-3a：最常见的材料是木板（由植物学产出，或经货运订购）、皮革（来自植物学或货运）和锻造板（用锻炉从金属锻打而成）。<br>\n\
	-4：材料都放到制作台旁后，拿起锤子，在台边开工，做出你的装备！<br>\n\
	<br>\n\
	重锻/修复已锻造装备：<br>\n\
	-1：用夹钳或直接用空手把装备放进锻炉。<br>\n\
	-2：加热后放到锻造工作台上，像处理未完成的锻造物品那样加工它。<br>\n\
	-3：听声音判断已经好了，就拿到淬火槽里冷却。<br>\n\
	<br>\n\
	试剂注入：<br>\n\
	这是一种古老技艺，可将所选液体试剂的特性注入大多数锻造装备。使用锻造油以外的试剂会降低装备效能，但视注入的化学品而定，这点代价或许是值得的。<br>\n\
	注意：试剂注入会给材料带来额外压力，每当注入效果触发时都会造成磨损！<br>\n\
	通常，任何可注入的物品都会在液体中淬火时完成注入。不过，试剂注入效果可以通过重锻装备或手动注入来改变：<br>\n\
	-1：准备至少 60 单位的化学溶液用于注入。<br>\n\
	-2：把这些化学品转移到你的锻造装备中。<br>\n\
	-3：把装备放进加热的锻炉，让化学品渗入材料。<br>\n\
	<br>\n\
	其他提示：<br>\n\
	-擦亮眼睛！<b>检查</b>你的装备——无论是制作设备还是手持工具——通常都能看出些有用的信息。<br>\n\
	-多做些花样！每次都制作新产品，你的技能会学得/重新拾得最快。<br>\n\
	-试剂注入很强大，但若不知道注入什么化学品，锻造油是不错的保底选择；它能强化装备的预期性能。<br>\n\
	-随着你不断打造武器和装备，肌肉记忆会逐渐积累——从而让你能制作新的装备。留意锻炉和制作台上新出现的物品。<br>\n\
	-留意你使用的材料；材料特性会改变成品的实用性。尽管去试验，但别指望披萨武士刀除了逗人一笑还能有什么价值。<br>\n\
	-你可以在锻炉打造一把双手锤。做得好的话，它比纳米传讯配发的锤子用起来更快！"

/obj/item/choice_beacon/blacksmith
	name = "锻造补给信标"
	desc = "呼叫一个补给舱，内含锻造所需的全部装备。"
	icon_state = "sb_delivery"
	inhand_icon_state = "sb_delivery"

/obj/item/choice_beacon/blacksmith/generate_display_names()
	return list("锻造设备箱" = /obj/structure/closet/crate/large/smithing)

