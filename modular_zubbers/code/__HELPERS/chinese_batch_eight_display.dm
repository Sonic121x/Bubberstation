#include "chinese_batch_six_display.dm"
#include "chinese_batch_eight_core_display.dm"
#include "chinese_batch_eight_skyrat_display.dm"
#include "chinese_batch_nine_display.dm"

/// Resolve this batch's type-specific labels before older general reverse maps.
/proc/chinese_batch_eight_action_storage_name(value, action_type)
	return chinese_batch_nine_action_storage(chinese_batch_eight_skyrat_action_storage(chinese_batch_eight_core_action_storage(value, action_type), action_type), action_type)
