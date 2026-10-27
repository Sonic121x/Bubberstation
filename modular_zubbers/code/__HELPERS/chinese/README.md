# 中文显示辅助模块

项目通过 `tgstation.dme` 引用 `../chinese_display.dm`，再由 `_includes.dm` 统一加载本目录的文件。原入口保留通用显示函数；本目录按用途整理其余模块。

| 目录 | 职责 | 典型文件 |
| --- | --- | --- |
| `labels/` | 将内部标识转换为界面标签，以及将中文选择项还原为原始值 | `identity.dm`、`area.dm`、`accessory.dm`、`antagonist.dm` |
| `actions/` | 将中文动作名称还原为旧动作按钮存档键，兼容动态名称和同名动作 | `common.dm`、`vehicles_circuits.dm`、`mod_modules.dm` |
| `circuits/` | 电路端口的中文标签，以及大气设备协议值的还原 | `atmos_ports.dm`、`computer_ports.dm`、`atmos_protocol.dm` |
| `routing/` | 动作映射和电路显示的调用顺序、类型特例及兼容入口 | `actions.dm`、`typed_actions.dm`、`atmos_clothing.dm` |

## 常用入口

| 函数 | 用途 |
| --- | --- |
| `chinese_action_storage_name(value, action_type)` | 在保存、读取或删除动作按钮位置时还原旧名称 |
| `chinese_batch_five_circuit_port_display(value)` | 显示电路端口名称，保留 `port.name` 原始值 |
| `chinese_atmos_protocol_name(value)` | 将显示标签转换回设备协议使用的英文值 |
| `chinese_job_display(value)`、`chinese_area_display(value)` | 职业及区域的中文标签 |
| `chinese_body_zone_display(value)` | 身体部位的中文显示 |
| `chinese_roundend_category_display(value)` | 回合结算分组的中文标签 |
| `chinese_antag_storage_name(value)` | 敌对身份信息动作中嵌入名称的存档兼容 |

部分函数仍带 `batch_*` 前缀，以兼容现有调用。文件名按职责命名；新增文件直接使用职责名称，无需继续增加批次入口。

## 修改约定

1. 先查找对应领域的文件和已有函数。新模块只在 `_includes.dm` 添加一次引用，叶子模块不再相互 `#include`。
2. 显示映射用于玩家或管理员界面；资源路径、`icon_state`、协议值、端口键和持久化标识保留原值。
3. 动作逆映射需要考虑 `action_type`。相同中文可能对应不同旧名称，须保留现有类型优先级、回退顺序和动态名称处理。
4. 未命中的值和玩家自定义名称按原有规则保留。大型映射表沿用延迟初始化，避免增加全局初始化负担。
5. 调整顺序前检查同名项的类型和用途。跨模块重复字符串可能用于不同系统，不应仅因文字相同就合并。
6. 翻译遵循工作区父目录的 `专用名词对照表.md`。修改后核对引用、编译并运行 DreamChecker；只移动文件时，还应比较展开后的代码以确认行为一致。

## 本次整理

46 个辅助文件从 `__HELPERS/` 根目录移入本目录，原 `chinese_display.dm` 入口保留。原有嵌套引用集中到 `_includes.dm`，展开后的声明顺序保持一致。函数名、译文、映射内容及其执行顺序均保留。

## 第 9001–10000 项翻译扩展

- `skyrat_items_more`、`skyrat_items_roles`：物品模式、径向菜单、角色及事件标签，保留原始选择值。
- `skyrat_systems`、`skyrat_systems_roles`：子系统、特性、职业、区域、义肢与科研分类的显示。
- `zubbers_datums`、`zubbers_objects`：下游特性、称谓、全息工具、宠物等选项，以及对应动作存档名。
- `bloodsucker`、`zubbers_heretic`：氏族、能力、敌对身份和模块的显示及存档兼容。

职业、种族和区域扩展同时合并到返回完整映射的入口，供界面显示和中文输入反查原始标识使用。特性下拉选项通过指定偏好类型接入 `display_names`，不会修改保存的选择值。
