#include "chinese_batch_four_display.dm"
#include "chinese_batch_five_atmos_action_storage.dm"
#include "chinese_batch_five_clothing_action_storage.dm"
#include "chinese_batch_five_atmos_protocol.dm"
#include "chinese_batch_five_holiday_display.dm"
#include "chinese_batch_five_atmos_port_display.dm"
#include "chinese_batch_five_food_port_display.dm"

/proc/chinese_batch_five_action_storage_name(value, action_type)
	return chinese_batch_five_clothing_action_storage(chinese_batch_five_atmos_action_storage(value, action_type), action_type)

/// Translate UI labels only; port.name remains the blueprint's persistent key.
/proc/chinese_batch_five_circuit_port_display(value)
	return chinese_batch_five_atmos_port_display(chinese_batch_five_food_port_display(value))
