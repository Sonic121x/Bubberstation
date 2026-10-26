/proc/toggle_permit_pins()
	GLOB.permit_pin_unrestricted = !GLOB.permit_pin_unrestricted
	minor_announce("许可锁定击针的锁现已[GLOB.permit_pin_unrestricted ? "解除" : "恢复"]。", "武器系统更新：")
	SSblackbox.record_feedback("nested tally", "keycard_auths", 1, list("permit-locked pins", GLOB.permit_pin_unrestricted ? "unlocked" : "locked"))
