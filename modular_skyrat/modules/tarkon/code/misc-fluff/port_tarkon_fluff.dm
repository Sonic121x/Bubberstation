// Engine based key doors
/obj/machinery/door/puzzle/keycard/rnd
	name = "研发安全气闸"
	desc = "塔肯工业安全储藏门锁，带有紫色标记。"
	puzzle_id = "tarkon1"

/obj/machinery/door/puzzle/keycard/engi
	name = "工程安全气闸"
	desc = "塔肯工业安全储藏门锁，带有橙色标记。"
	puzzle_id = "tarkon2"

/obj/machinery/door/puzzle/keycard/med
	name = "医疗安全气闸"
	desc = "塔肯工业安全储藏门锁，带有蓝色标记。"
	puzzle_id = "tarkon3"

/obj/machinery/door/puzzle/keycard/vault
	name = "金库安全气闸"
	desc = "塔肯工业安全储藏门锁，带有黑色标记。"
	puzzle_id = "tarkon4"

// End Engine based key doors

// Engine based Door Keys

/obj/item/keycard/tarkon_rnd
	name = "科研钥匙卡"
	desc = "塔肯工业安全储藏门锁的钥匙。"
	color = "#a03aaf"
	puzzle_id = "tarkon1"

/obj/item/keycard/tarkon_engi
	name = "工程钥匙卡"
	desc = "塔肯工业安全储藏门锁的钥匙。"
	color = "#f05812"
	puzzle_id = "tarkon2"

/obj/item/keycard/tarkon_med
	name = "医疗钥匙卡"
	desc = "塔肯工业安全储藏门锁的钥匙。"
	color = "#33d4ff"
	puzzle_id = "tarkon3"

/obj/item/keycard/tarkon_vault
	name = "金库钥匙卡"
	desc = "塔肯工业安全储藏门锁的钥匙。"
	color = "#303030"
	puzzle_id = "tarkon4"

// End Engine based door keys

/mob/living/basic/alien/drone/tarkon
	basic_mob_flags = DEL_ON_DEATH

// JOB SPECIFIC VAULT KEYS

/obj/item/keycard/tarkon_job_med
	name = "私人钥匙卡"
	desc = "塔肯工业安全储藏门锁的钥匙，标签写着“医疗安全储藏室”。"
	color = "#33d4ff"
	puzzle_id = "tarkon_vaultmed"

/obj/item/keycard/tarkon_job_sec
	name = "私人钥匙卡"
	desc = "塔肯工业安全储藏门锁的钥匙，标签写着“安保安全储藏室”。"
	color = "#C70039"
	puzzle_id = "tarkon_vaultsec"

/obj/item/keycard/tarkon_job_engi
	name = "私人钥匙卡"
	desc = "塔肯工业安全储藏门锁的钥匙，标签写着“工程安全储藏室”。"
	color =  "#FFC300"
	puzzle_id = "tarkon_vaultengi"

/obj/item/keycard/tarkon_job_rnd
	name = "私人钥匙卡"
	desc = "塔肯工业安全储藏门锁的钥匙，标签写着“科研安全储藏室”。"
	color = "#a207b9"
	puzzle_id = "tarkon_vaultrnd"

/obj/item/keycard/tarkon_job_supply
	name = "私人钥匙卡"
	desc = "塔肯工业安全储藏门锁的钥匙，标签写着“补给安全储藏室”。"
	color = "#9e5d06"
	puzzle_id = "tarkon_vaultsupply"

/obj/item/keycard/tarkon_job_command
	name = "私人钥匙卡"
	desc = "塔肯工业安全储藏门锁的钥匙，标签写着“指挥安全储藏室”。"
	color = "#1b50d5"
	puzzle_id = "tarkon_vaultcommand"

/obj/item/keycard/tarkon_job_ensign
	name = "私人钥匙卡"
	desc = "塔肯工业安全储藏门锁的钥匙，标签写着“少尉安全储藏室”。"
	color = "#1b50d5"
	puzzle_id = "tarkon_vaultensign"

/obj/item/keycard/tarkon_job_service
	name = "私人钥匙卡"
	desc = "塔肯工业安全储藏门锁的钥匙，标签写着“服务安全储藏室”。"
	color = "#1cac40"
	puzzle_id = "tarkon_vaultservice"

// End job specific vault keys

// JOB SPECIFIC VAULT DOORS
/obj/machinery/door/puzzle/keycard/personal_med
	name = "私人医疗安全气闸"
	desc = "塔肯工业安全储藏门锁，带有蓝色标记。"
	puzzle_id = "tarkon_vaultmed"

/obj/machinery/door/puzzle/keycard/personal_sec
	name = "私人安保安全气闸"
	desc = "塔肯工业安全储藏门锁，带有红色标记。"
	puzzle_id = "tarkon_vaultsec"

/obj/machinery/door/puzzle/keycard/personal_engi
	name = "私人工程安全气闸"
	desc = "塔肯工业安全储藏门锁，带有橙色标记。"
	puzzle_id = "tarkon_vaultengi"

/obj/machinery/door/puzzle/keycard/personal_rnd
	name = "私人科研安全气闸"
	desc = "塔肯工业安全储藏门锁，带有紫色标记。"
	puzzle_id = "tarkon_vaultrnd"

/obj/machinery/door/puzzle/keycard/personal_supply
	name = "私人补给安全气闸"
	desc = "塔肯工业安全储藏门锁，带有棕色标记。"
	puzzle_id = "tarkon_vaultsupply"

/obj/machinery/door/puzzle/keycard/personal_command
	name = "私人指挥安全气闸"
	desc = "塔肯工业安全储藏门锁，带有蓝色和金色标记。"
	puzzle_id = "tarkon_vaultcommand"

/obj/machinery/door/puzzle/keycard/personal_ensign
	name = "私人少尉安全气闸"
	desc = "塔肯工业安全储藏门锁，带有蓝色和红色标记。"
	puzzle_id = "tarkon_vaultensign"

/obj/machinery/door/puzzle/keycard/personal_service
	name = "私人服务安全气闸"
	desc = "塔肯工业安全储藏门锁，带有深绿色标记。"
	puzzle_id = "tarkon_vaultservice"

// End job specific vault doors

/obj/item/card/id/departmental_budget/tarkon
	department_ID = ACCOUNT_TAR
	department_name = ACCOUNT_TAR_NAME
	icon_state = "car_budget" // looks close enough
