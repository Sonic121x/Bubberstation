/**
 * Player-written medical note.
 */
/datum/medical_note
	/// Player that wrote the note
	var/author
	/// Details of the note
	var/content
	/// Station timestamp
	var/time

/datum/medical_note/New(author = "匿名", content = "未提供详情。", time = "--:--:--")
	src.author = author
	src.content = content
	src.time = time
