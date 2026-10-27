//Title Capitalization for names please!!!

/*
*	GLASSES
*/

/datum/loadout_item/glasses/prescription_glasses/thin
	name = "细框眼镜"
	item_path = /obj/item/clothing/glasses/thin

/datum/loadout_item/glasses/prescription_glasses/better
	name = "现代眼镜"
	item_path = /obj/item/clothing/glasses/regular/betterunshit

/datum/loadout_item/glasses/orange_glasses
	name = "橙色眼镜"
	item_path = /obj/item/clothing/glasses/orange

/datum/loadout_item/glasses/psych_glasses
	name = "心理医生眼镜"
	item_path = /obj/item/clothing/glasses/psych

/datum/loadout_item/glasses/red_glasses
	name = "红色眼镜"
	item_path = /obj/item/clothing/glasses/red

/datum/loadout_item/glasses/roseglasses
	name = "玫瑰色眼镜"
	item_path = /obj/item/clothing/glasses/rosecolored
	//ckeywhitelist = list("1ceres", "irrigoimport", "zeskorion", "wizardlywoz", "duckymomo", "samarai1000", "funkyfetusstrikesback", "m97screwsyourparents", "lynxqueen", "kaynite", "mahalia", "sapphoqueer", "emmakisst", "ceasethebridge", "valorthix" )

/*
*	GOGGLES
*/

/datum/loadout_item/glasses/goggles
	abstract_type = /datum/loadout_item/glasses/goggles
	group = "护目镜"

/datum/loadout_item/glasses/goggles/geist
	name = "幽魂目镜"
	item_path = /obj/item/clothing/glasses/geist_gazers

/datum/loadout_item/glasses/goggles/biker
	name = "机车护目镜"
	item_path = /obj/item/clothing/glasses/biker

/datum/loadout_item/glasses/goggles/surgery
	name = "恢复护目镜"
	item_path = /obj/item/clothing/glasses/surgerygoggles

/datum/loadout_item/glasses/goggles/surgery/med
	name = "手术护目镜"
	item_path = /obj/item/clothing/glasses/hud/health/surgerygoggles
	restricted_roles = list(ALL_JOBS_MEDICAL, JOB_GENETICIST)

/*
*	MISC
*/

/datum/loadout_item/glasses/eyepatch
	abstract_type = /datum/loadout_item/glasses/eyepatch
	group = "眼罩"

/datum/loadout_item/glasses/eyepatch/black
	name = "眼罩"
	item_path = /obj/item/clothing/glasses/eyepatch

/datum/loadout_item/glasses/eyepatch/white
	name = "白色眼罩"
	item_path = /obj/item/clothing/glasses/eyepatch/white

/datum/loadout_item/glasses/eyepatch/wrap
	name = "包裹式眼罩"
	item_path = /obj/item/clothing/glasses/eyepatch/wrap

/datum/loadout_item/glasses/eyepatch/rose
	name = "玫瑰色眼罩"
	item_path = /obj/item/clothing/glasses/eyepatch/rosecolored
	//ckeywhitelist = list("kaynite")

/datum/loadout_item/glasses/eyepatch/medical
	name = "医疗眼罩（Skyrat）"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/med
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/eyepatch/robotics
	name = "诊断眼罩"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/diagnostic
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/eyepatch/science
	name = "科研眼罩"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/sci
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/eyepatch/meson
	name = "介子眼罩"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/meson
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/glasses/eyepatch/security
	name = "安保眼罩 HUD"
	item_path = /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

//COSTUMES

/datum/loadout_item/glasses/costume
	abstract_type = /datum/loadout_item/glasses/costume
	group = "戏服与搞怪眼镜"

/datum/loadout_item/glasses/costume/fakeblindfold
	name = "假眼罩布"
	item_path = /obj/item/clothing/glasses/trickblindfold

/datum/loadout_item/glasses/costume/obsoleteblindfold
	name = "过时的假眼罩布"
	item_path = /obj/item/clothing/glasses/trickblindfold/obsolete

/*
*	JOB-LOCKED
*/

/datum/loadout_item/glasses/hud
	abstract_type = /datum/loadout_item/glasses/hud
	group = "HUD"

/datum/loadout_item/glasses/hud/civ
	name = "民用 HUD"
	item_path = /obj/item/clothing/glasses/hud/civilian

/datum/loadout_item/glasses/hud/retinal_projector
	name = "视网膜投影器"
	item_path = /obj/item/clothing/glasses/hud/ar/projector

/datum/loadout_item/glasses/hud/sec
	name = "安保 HUD"
	item_path = /obj/item/clothing/glasses/hud/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/hud/sec/glasses
	name = "处方款安保 HUD"
	item_path = /obj/item/clothing/glasses/hud/security/prescription
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/hud/med/glasses
	name = "处方款医疗 HUD"
	item_path = /obj/item/clothing/glasses/hud/health/prescription
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/hud/diag/glasses
	name = "处方款诊断 HUD"
	item_path = /obj/item/clothing/glasses/hud/diagnostic/prescription
	restricted_roles = list(JOB_RESEARCH_DIRECTOR,JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/glasses/hud/science/glasses
	name = "处方款科研眼镜"
	item_path = /obj/item/clothing/glasses/science/prescription
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/hud/retinalprojector/security
	name = "视网膜投影安保 HUD"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/hud/retinalprojector/health
	name = "视网膜投影医疗 HUD"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/health
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/hud/retinalprojector/meson
	name = "视网膜投影介子 HUD"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/meson
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/glasses/hud/retinalprojector/diagnostic
	name = "视网膜投影诊断 HUD"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/diagnostic
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/glasses/hud/retinalprojector/science
	name = "科学视网膜投影器"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/science
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/hud/redgigagar
	name = "红色千兆 HUD GAR 墨镜"
	item_path = /obj/item/clothing/glasses/hud/security/sunglasses/gars/giga/roselia
	//ckeywhitelist = list("ultimarifox")
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER)

/*
*	SHADES
*/

/datum/loadout_item/glasses/shades
	abstract_type = /datum/loadout_item/glasses/shades
	group = "墨镜与飞行员眼镜"

/datum/loadout_item/glasses/shades/aviator/gold
	name = "紫金飞行员眼镜"
	item_path = /obj/item/clothing/glasses/gold_aviators
	//ckeywhitelist = list("nikohyena")

/datum/loadout_item/glasses/shades/osi
	name = "OSI 眼镜"
	item_path = /obj/item/clothing/glasses/osi

/datum/loadout_item/glasses/shades/phantom
	name = "幻影眼镜"
	item_path = /obj/item/clothing/glasses/phantom

/datum/loadout_item/glasses/shades/fake_sunglasses
	name = "假墨镜"
	item_path = /obj/item/clothing/glasses/fake_sunglasses

/datum/loadout_item/glasses/shades/salesman
	name = "有色眼镜"
	item_path = /obj/item/clothing/glasses/salesman

/datum/loadout_item/glasses/shades/aviator/security
	name = "安保 HUD 飞行员眼镜"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/shades/aviator/health
	name = "医疗 HUD 飞行员眼镜"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/health
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/shades/aviator/meson
	name = "介子 HUD 飞行员眼镜"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/meson
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/glasses/shades/aviator/diagnostic
	name = "诊断 HUD 飞行员眼镜"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/diagnostic
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/glasses/shades/aviator/science
	name = "科学飞行员眼镜"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/science
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/shades/prescription/aviator/security
	name = "处方款安保 HUD 飞行员眼镜"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/security/prescription
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/shades/prescription/aviator/health
	name = "处方款医疗 HUD 飞行员眼镜"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/health/prescription
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/shades/prescription/aviator/meson
	name = "处方款介子 HUD 飞行员眼镜"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/meson/prescription
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/glasses/shades/prescription/aviator/diagnostic
	name = "处方款诊断 HUD 飞行员眼镜"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/diagnostic/prescription
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/glasses/shades/prescription/aviator/science
	name = "处方款科学飞行员眼镜"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/science/prescription
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/shades/aviator_fake
	name = "假飞行员眼镜"
	item_path = /obj/item/clothing/glasses/fake_sunglasses/aviator
