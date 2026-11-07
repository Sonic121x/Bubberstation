// 自定义修改：集中限定中文姓名允许的汉字范围，供校验和补姓判断共用。
/proc/is_chinese_name_character(codepoint)
	return (codepoint >= 0x3400 && codepoint <= 0x4DBF) || (codepoint >= 0x4E00 && codepoint <= 0x9FFF) || (codepoint >= 0xF900 && codepoint <= 0xFAFF)

// 自定义修改：按完整字符扫描姓名，避免将多字节汉字拆开。
/proc/contains_chinese_name_character(value)
	for(var/index = 1, index <= length_char(value), index++)
		if(is_chinese_name_character(text2ascii_char(value, index)))
			return TRUE
	return FALSE
