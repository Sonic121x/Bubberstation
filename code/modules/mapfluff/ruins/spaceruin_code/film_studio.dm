//film studio paper fluff
/obj/item/paper/fluff/ruins/film_studio
	name = "将就着用你手头的东西"
	default_raw_text = "你的老板在此。公司那边说这间制片厂不赚钱。 \
	你到现在也该明白那些抠门鬼是什么意思了。将就着用手头的东西把收视率拉上去！ \
	除了我刚派给你的新导演，我没法给你别的支援了，毕竟你离核心星区那么远。 \
	不过我听说有一家纳米传讯的空间站要在这一星区落脚。 \
	去娱乐他们！这样公司应该就不会再从我们这儿抽钱了！——老板"

/obj/item/paper/fluff/ruins/film_studio/director_note
	name = "操 操 操"
	default_raw_text = "就这点破烂预算，我他妈怎么写我的毕生杰作！？ \
	这锈桶跟那个高管跟我说的完全不一样， \
	‘革命性的顶尖制片厂’，放屁！去他的，我不干了！新人，你想拍烂重制版或者重播热门节目随你便。 \
	那些东西对我这种档次的人来说太没品位了。——雷扎·纳基姆先生"

/obj/item/paper/fluff/ruins/film_studio/layoff
	name = "致第 13 太空星区地方电视台的人事通知"
	default_raw_text = "索弗罗尼娅广播公司遗憾地通知你们，我们最亲爱的员工们。由于一份令人担忧的季度末报告，我们决定 \
	进行一些‘重组’。如果你正在读这封信，说明你幸运地被认定为最低限度员工；而那些没被认定的，已经 \
	从低温休眠中唤醒并被送往最近的宜居行星。我们希望这一决定能带来更好的结果。"

//Camera
/obj/item/broadcast_camera/film_studio
	name = "广播摄像机"
	desc = "一台大型摄像机，可将其现场画面与音频实时传输到本星区各地的娱乐显示器上，让所有人都能观看直播。"
	broadcast_name = "SS13.tv"
	camera_networks = list(CAMERANET_NETWORK_FILMSTUDIO)
