/obj/structure/chess
	anchored = FALSE
	density = FALSE
	icon = 'icons/obj/toys/chess.dmi'
	icon_state = "white_pawn"
	name = "\improper 大概是枚白色兵"
	desc = "这有点奇怪。请告诉管理员你是怎么弄到这个棋类父对象的。谢谢！"
	max_integrity = 100
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/chess/wrench_act(mob/user, obj/item/tool)
	if(flags_1 & HOLOGRAM_1)
		balloon_alert(user, "它直接穿过去了！")
		return TRUE
	to_chat(user, span_notice("你开始拆解这枚棋子。"))
	if(!do_after(user, 0.5 SECONDS, target = src))
		return TRUE
	var/obj/item/stack/sheet/iron/metal_sheets = new (drop_location(), 2)
	if (!QDELETED(metal_sheets))
		metal_sheets.add_fingerprint(user)
	tool.play_tool_sound(src)
	qdel(src)
	return TRUE

/obj/structure/chess/whitepawn
	name = "\improper 白色兵"
	desc = "一枚白色兵棋子。在走出漂亮的吃过路兵时会被人指责作弊。"
	icon_state = "white_pawn"

/obj/structure/chess/whiterook
	name = "\improper 白色车"
	desc = "一枚白色车棋子，又称城堡。可沿直线移动任意格数，还有一种名为王车易位的特殊走法。"
	icon_state = "white_rook"

/obj/structure/chess/whiteknight
	name = "\improper 白色马"
	desc = "一枚白色马棋子。它可以跳过其他棋子，沿 L 形移动。一位白衣骑士——哦。哈！"
	icon_state = "white_knight"

/obj/structure/chess/whitebishop
	name = "\improper 白色象"
	desc = "一枚白色象棋子，可沿斜线移动任意格数。"
	icon_state = "white_bishop"

/obj/structure/chess/whitequeen
	name = "\improper 白色后"
	desc = "一枚白色后棋子，可沿斜线和直线移动任意格数。"
	icon_state = "white_queen"

/obj/structure/chess/whiteking
	name = "\improper 白色王"
	desc = "一枚白色王棋子，可朝任意方向移动一格。"
	icon_state = "white_king"

/obj/structure/chess/blackpawn
	name = "\improper 黑色兵"
	desc = "一枚黑色兵棋子。在走出漂亮的吃过路兵时会被人指责作弊。"
	icon_state = "black_pawn"

/obj/structure/chess/blackrook
	name = "\improper 黑色车"
	desc = "一枚黑色车棋子，又称城堡。可沿直线移动任意格数，还有一种名为王车易位的特殊走法。"
	icon_state = "black_rook"

/obj/structure/chess/blackknight
	name = "\improper 黑色马"
	desc = "一枚黑色马棋子。它可以跳过其他棋子，沿 L 形移动。"
	icon_state = "black_knight"

/obj/structure/chess/blackbishop
	name = "\improper 黑色象"
	desc = "一枚黑色象棋子，可沿斜线移动任意格数。"
	icon_state = "black_bishop"

/obj/structure/chess/blackqueen
	name = "\improper 黑色后"
	desc = "一枚黑色后棋子，可沿斜线和直线移动任意格数。"
	icon_state = "black_queen"

/obj/structure/chess/blackking
	name = "\improper 黑色王"
	desc = "一枚黑色王棋子，可朝任意方向移动一格。"
	icon_state = "black_king"

/obj/structure/chess/checker
	icon_state = "white_checker_man"
	name = "\improper 大概是枚白色跳棋"
	desc = "这有点奇怪。请告诉管理员你是怎么弄到这个跳棋父对象的。谢谢！"

/obj/structure/chess/checker/whiteman
	name = "\improper 白色跳棋棋子"
	desc = "一枚白色跳棋子。看起来可疑地像一枚被压扁的国际象棋兵。"
	icon_state = "white_checker_man"

/obj/structure/chess/checker/whiteking
	name = "\improper 白色跳棋棋子"
	desc = "一枚白色跳棋子。它被叠起来了！"
	icon_state = "white_checker_king"

/obj/structure/chess/checker/blackman
	name = "\improper 黑色跳棋棋子"
	desc = "一枚黑色跳棋子。看起来可疑地像一枚被压扁的国际象棋兵。"
	icon_state = "black_checker_man"

/obj/structure/chess/checker/blackking
	name = "\improper 黑色跳棋王"
	desc = "一枚黑色跳棋子。它被叠起来了！"
	icon_state = "black_checker_king"
