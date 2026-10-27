/datum/wound/blunt/robotic/secures_internals/severe
	name = "紧固件脱落"
	desc = "多种紧固装置极度松动，焊点在多处断开，导致内部组件剧烈晃动，\
	肢体出现明显功能障碍。"
	treat_text = "由合格技师固定螺栓和螺丝（若没有技师，骨胶也能凑合），然后重新焊接。"
	examine_desc = "每次动作都会晃动，焊点明显断裂"
	occur_text = "明显裂开，焊锡四处飞溅"
	severity = WOUND_SEVERITY_SEVERE

	simple_treat_text = "<b>若位于<b>胸部</b>，<b>行走</b>、<b>抓住它</b>、<b>打夹板</b>、<b>休息</b>或将<b>自己系</b>在物体上以减少移动影响。\
	之后找<b>别人</b>——最好是<b>机修/工程</b>人员——用<b>螺丝刀/扳手</b>固定，然后<b>重新焊接</b>！"
	homemade_treat_text = "若<b>无法用螺丝刀/扳手</b>固定，<b>骨胶</b>可以随着时间固定内部组件，但有<b>腐蚀</b>风险。\
	或者，用<b>撬棍</b>撬开肢体以露出内部——这会让重新固定<b>更容易</b>，但有<b>很高风险</b>会让你被<b>电击</b>，\
	所以请戴上绝缘手套。这会<b>使肢体残废</b>，因此只能作为最后手段！"
	treat_text_short = "使用螺丝刀或扳手，然后使用焊接工具或烧灼器。"

	wound_flags = (ACCEPTS_GAUZE|MANGLES_EXTERIOR|SPLINT_OVERLAY|CAN_BE_GRASPED)
	treatable_by = list(/obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/robotic/severe
	treatable_tools = list(TOOL_WELDER, TOOL_CROWBAR)

	interaction_efficiency_penalty = 2
	limp_slowdown = 6
	limp_chance = 60

	brain_trauma_group = BRAIN_TRAUMA_MILD
	trauma_cycle_cooldown = 1.5 MINUTES

	threshold_penalty = 40

	base_movement_stagger_score = 40

	chest_attacked_stagger_chance_ratio = 5
	chest_attacked_stagger_mult = 3

	chest_movement_stagger_chance = 2

	stagger_aftershock_knockdown_ratio = 0.3
	stagger_aftershock_knockdown_movement_ratio = 0.2

	a_or_from = "from"

	ready_to_secure_internals = TRUE
	ready_to_resolder = FALSE

	scar_keyword = "bluntsevere"

/datum/wound_pregen_data/blunt_metal/fastenings
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/robotic/secures_internals/severe

	threshold_minimum = 65
