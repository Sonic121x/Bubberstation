/**
 * Fluff notes
 */
/obj/item/paper/fluff/awaymissions/astrum
	icon_state = "alienpaper_words"
	show_written_words = FALSE

/obj/item/paper/fluff/awaymissions/astrum/click_alt(mob/user)
	return NONE //no folding these

/obj/item/paper/fluff/awaymissions/astrum/combat
	name = "报告：战斗全息甲板"
	default_raw_text = {"尽管我们在将原始人整合进其他甲板时遇到过问题，但战斗甲板上的实验对象已经开始进行实验，且没有出现往常那些问题。<br>
	假设：这些对象对其他任何事物的倾向都不如对暴力的倾向明显？也许这与他们那身彩色制服有关。<br>"}

/obj/item/paper/fluff/awaymissions/astrum/reproductive_studies
	name = "报告：生殖研究"
	default_raw_text = {"无论我们做什么，原始人都不肯展示他们的求偶仪式，也许是我们在搭建模拟环境时出了什么差错？<br>
	想法：多放一些乙醇类液体，原始人似乎很喜欢靠饮用它来降低自己的矜持。<br>"}

/obj/item/paper/fluff/awaymissions/astrum/frozen
	name = "报告：冰冻全息甲板"
	default_raw_text = {"这里没什么可学的，原始人一旦接触到极低温和敌对动物就会死亡。<br>
	结论：用更有利于我们研究的内容替换冰冻全息甲板，那道裂隙一直在弄死负责清洁的杂役。<br>"}

/obj/item/paper/fluff/awaymissions/astrum/xeno_studies
	name = "报告：异形研究全息甲板"
	default_raw_text = {"不不不不不不不，我现在就要关闭这个实验。<br>
	结论：这跟研究原始人到底有什么关系？！<br>"}

/obj/item/paper/fluff/awaymissions/astrum/beach
	name = "报告：海滩全息甲板"
	default_raw_text = {"好吧，我们在这里几乎一无所获，原始人一旦被放进放松的海滩环境，仍会不停地尖叫并武装自己。<br>
	结论：这一批学不到任何东西，记得找个时间把他们处理掉，再带一批新的来。<br>"}
