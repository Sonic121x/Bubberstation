/obj/item/paper/fluff/merge_my_fucking_pr
	default_raw_text = "糟了"

/obj/item/paper/fluff/merge_my_fucking_pr/Initialize(mapload)

	//I love madlibs.
	//The fallbacks should never roll but you never know.
	var/pr_number = 40000 + (text2num(copytext("\ref[src]",2),16) % 100000) //While scientific notation is funny, it wasn't precise enough
	var/thing_to_remove = LOWER_TEXT(pick_list_replacements(ION_FILE, "ionobjects")) || "Kebab" //2006 called, they want their meme back
	var/obj/machinery/nuclearbomb/selfdestruct/self_destruct = locate() in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/nuclearbomb/selfdestruct) //Wait, why the fuck are we trying to get the nuke??? Coder backdoor???
	if(self_destruct)
		if(self_destruct.r_code == NUKE_CODE_UNSET)
			self_destruct.r_code = random_nukecode()
			message_admins("由于一堆火药味十足的 PR，自毁密码被设置成了“[self_destruct.r_code]”。")
		if(self_destruct.r_code == pr_number)
			thing_to_remove = "空间站核自毁装置" //Just made every senior admin shit themselves with this line. 1 in 140,000 chance, by the way.

	var/title = "移除[capitalize(thing_to_remove)]"
	var/author = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]" || "Joe Momma"
	var/author_dash = replacetextEx(author," ","-")
	var/conversation = pick_list_replacements(HALLUCINATION_FILE, "conversation") || "滚开好吗？"
	var/redpill = pick_list_replacements(REDPILL_FILE, "redpill_questions") || "为什么不呢？"
	var/job = replacetextEx(pick_list_replacements(HALLUCINATION_FILE, "people") ,"\\%TARGETNAME","Security") || "Security"
	var/traitor = replacetextEx(pick_list_replacements(HALLUCINATION_FILE, "accusations") ,"\\%TARGETNAME","a griefer") || "a griefer"
	var/location = replacetextEx(pick_list_replacements(HALLUCINATION_FILE, "location") ,"\\%TARGETNAME","dorms") || "dorms"
	var/branch = replacetextEx("[traitor]-[thing_to_remove]-removal"," ","-")
	var/dirty_commits = rand(4,75)

	default_raw_text = {"
	<h1>[title] #[pr_number]</h1>
	[author] 想把 [dirty_commits] 个提交合并进 \[Space-Station-13:master\]，来源为 \[[author_dash]:[branch]\]
	<br>
	<br>
	<br>
	<br>
	<br>
	<hr>
	<h2>关于此拉取请求</h2>
	<hr>
	<p>移除[thing_to_remove]。</p>
	<br>
	<h2>为什么这对空间站有好处</h2>
	<hr>
	<p>[redpill]</p>
	<p>
	[pick("研究主管需要","安保需要","我们需要","中央指挥部需要","纳米传讯需要")]从
	[pick("空间站","船员",job,location)]中移除[thing_to_remove]。[pick("你也许在想","你大概想知道","你也许会说","有人会想","有人可能会说")]
	“[conversation]”，[pick("所以让我解释一下","通常你是对的","但让我解释一下","所以请给我一点时间","给我一秒钟解释")]。
	<br><br>
	[pick("有一次","之前","上个班次","不久前")]，那个该死的捣乱者乔治·梅隆在当[job]时[traitor]，而[pick("他","他们")]
	[pick("杀死","袭击","扇了屁股","拍打","私聊警告")]了[pick("我","我本人","我的身心健康","我的屁股")]，地点在[location]，
	[pick("用的就是","使用的是","而我当时连")] [thing_to_remove]。这[pick("不该发生","他妈的太蠢了","让我哭了","浪费了我的时间","惹恼了我")]，所以我
	[pick("请愿","乞求","请求","要求")]将其移除。
	</p>
	<br>
	<h1>更新日志</h1>
	<hr>
	CL [author]<br>
	[pick("del","remove","balance","fix","bugfix")]: 移除[thing_to_remove]<br>
	/CL
	"}

	name = "[initial(name)] - 拉取请求 #[pr_number]，[title]"

	return ..()
