/////////// derelictsulaco items

/obj/item/paper/crumpled/ruins/derelict_sulaco/captain
	name = "血染的纸片"
	icon_state = "scrap_bloodied"
	default_raw_text = "我们拼尽了全力，却还是输了。现在我们只能等着自毁程序启动。但这一路我走得无憾。我们都是。我曾带领并与之并肩作战的，是我有幸见过的最勇敢、最真诚的一群人。<BR><BR>永远忠诚。<BR><BR>*罗梅罗·埃尔南舰长*"

/obj/item/paper/ruins/derelict_sulaco/birthday
	name = "致我们的舰长"
	desc = "虽然字迹模糊，但你能辨认出这张照片背面的字句：“永远忠诚！”"
	icon = 'icons/obj/art/camera.dmi'
	icon_state = "photo"
	show_written_words = FALSE

	default_raw_text = "*这看起来是舰长生日聚会的照片，拍摄于布置得很有节日气氛的食堂。船员们的笑容与笑声透过变色的胶片透出来，其中一名参谋军官正热情地拥抱着他的上级。大家看起来都很快乐。有人正把一份礼物塞进舰长手里：一个傻乎乎、一脸淘气的“跑者”毛绒玩偶。*"

/obj/item/clothing/suit/armor/vest/marine/sulaco
	name = "受损的战术护甲背心"
	desc = "一套老旧、磨损严重的量产冲压塑钢护甲，做工精良。随着时间流逝，这件装备已失去了大部分防护性能，但用来向异形竖中指还是绰绰有余。"
	armor_type = /datum/armor/derelict_marine

/obj/item/clothing/head/helmet/marine/sulaco
	name = "受损的战术战斗头盔"
	desc = "一顶战术黑色头盔，仅靠一块玻璃和不多的东西勉强与外界危险隔绝。防护性不如从前，但功能仍然完好。"
	armor_type = /datum/armor/derelict_marine

/datum/armor/derelict_marine
	melee = 20
	bullet = 20
	bio = 100
	fire = 40
	acid = 50
	wound = 20

/obj/machinery/computer/terminal/sulaco
	tguitheme = "abductor"

/obj/machinery/computer/terminal/sulaco/overwatch
	name = "监看终端"
	desc = "用于常规监看用途的最先进设备。"
	upperinfo = "布拉沃小队监看终端"
	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/terminal/sulaco/overwatch")
	icon_screen = "explosive"
	content = list("<B>操作员：</B> 卡斯·阿什波尔 <BR> <BR> <B><center>小队监看：</B> 卡斯·阿什波尔 <BR> <BR> <b>已部署小队队长</b> <BR> <b>小队智能机枪手：</b> 已部署 1 人 <BR> <b>小队卫生员：</b> 已部署 1 人 <BR> <b>小队工程师：</b> 已部署 2 人 <BR> <b>小队陆战队员：</b> 已部署 4 人 <BR> <b>总计：</b> 已部署 9 人 <BR> <b>存活陆战队员：</b> 0 <BR> <BR> <table>   <tr>     <th>姓名</th>     <th>角色</th>     <th>状态</th>     <th>位置</th>     <th>与队长距离</th>   </tr>   <tr>     <td>奇普·梅洛</td>     <td>小队队长</td>     <td>死亡</td>     <td>自毁核心室</td>     <td> 不适用 </td>   </tr>   <tr>     <td>索菲·奈特</td>     <td>小队智能机枪手</td>     <td>死亡</td>     <td>自毁核心室</td>     <td>4</td>   </tr>   <tr>     <td>玛丽·纽曼</td>     <td>小队卫生员</td>     <td>死亡</td>     <td>未知</td>     <td> 不适用 </td>   </tr>   <tr>     <td>安杰洛·巴顿</td>     <td>小队工程师</td>     <td>死亡</td>     <td>苏拉科号维护区</td>     <td>19</td>   </tr>   <tr>     <td>马龙·福斯特</td>     <td>小队工程师</td>     <td>死亡</td>     <td>苏拉科号运输机机库</td>     <td>28</td>   </tr>   <tr>     <td>道格·戴维森</td>     <td>小队陆战队员</td>     <td>死亡</td>     <td>苏拉科号机库工坊</td>     <td>33</td>   </tr>   <tr>     <td>考特尼·米勒</td>     <td>小队陆战队员</td>     <td>死亡</td>     <td>苏拉科号机库工坊</td>     <td>42</td>   </tr>   <tr>     <td>塞萨尔·杰斐逊</td>     <td>小队陆战队员</td>     <td>死亡</td>     <td>自毁核心室</td>     <td>14</td>   </tr> </table> <BR> <b>主要目标：</b> 守卫自毁核心。 <BR> <b>次要目标：</b> 让他们吃点苦头！</center>")

/obj/machinery/computer/terminal/sulaco/overwatch/main
	name = "主监看终端"
	upperinfo = "主监看终端"
	icon_screen = "commsyndie"
	icon_keyboard = "syndie_key"
	content = list("<B>主操作员：</B> 罗梅罗·埃尔南 <BR> <BR> <center><B>查利小队</B> <BR> <b>队长：</b> 科林·诺里斯 <BR> <b>小队监看：</b> 谢丽尔·韦德 <BR> <BR> <B>阿尔法小队</B> <BR> <b>队长</b>：无 <BR> <b>小队监看：</b> 无 <BR> <BR> <B>布拉沃小队</B> <BR> <b>队长</b>：奇普·梅洛 <BR> <b>小队监看：</b> 卡斯·阿什波尔 <BR> <BR> <B>德尔塔小队</B> <BR> <b>队长</b>：斯科特·伯德 <BR> <b>小队监看：</b> 凯西·阿尔 <BR> <BR> <BR> <b> 轨道轰炸炮<BR> <BR>当前火炮状态： </B> 无法连接轨道轰炸炮！ <BR> <b>激光目标：</b> 无 <BR> <b>已选目标：</b> 无</center>")

/obj/machinery/computer/terminal/sulaco/helm
	name = "操舵计算机"
	desc = "苏拉科号的导航终端。"
	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate")
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	upperinfo = "导航"
	content = list("<center><b>苏拉科号<BR><BR><BR>位置未知</b><BR><BR>能量水平：0<BR>引擎状态：不适用<BR><BR><b>无法改变轨道。</b></center>")

/obj/machinery/computer/terminal/sulaco/map
	name = "地图台"
	desc = "一张显示当前目标地点地图的桌子。"
	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/terminal/sulaco/map")
	icon_screen = "mining"
	upperinfo = "LV-624"
	content = list("由于损伤，显示器几乎无法输出地图图像，但你能辨认出一些零碎的轮廓。这似乎是一张丛林行星上某处殖民地的卫星图像。南部覆盖着茂密葱郁的植被，北部则被山地岩石所环绕。<BR><BR>一条河流穿过殖民地，将其一分为二。此外，地图上还散布着几个图标，可惜你无法理解它们代表什么。")
