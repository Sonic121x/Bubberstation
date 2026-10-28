import { useEffect, useState } from 'react';
import {
  BlockQuote,
  Box,
  Button,
  Dropdown,
  Icon,
  Modal,
  Section,
  Slider,
  Stack,
  Table,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import type { ManipulatorData, ManipulatorTask } from './types';
import { batchThreeDisplay } from '../../localization/batchThreeDisplay';
const TASK_TYPE_LABELS: Record<string, string> = {
  pickup: '拾取……',
  drop: '放下……',
  throw: '投掷……',
  use: '使用手持物……',
  interact: '交互……',
  move: '移动……',
  wait: '等待……',
  stop: '停止……',
};

const TASK_TYPE_ICONS: Record<string, string> = {
  pickup: 'hand',
  drop: 'box-open',
  throw: 'paper-plane',
  use: 'mouse-pointer',
  interact: 'bolt',
  move: 'arrows-alt',
  wait: 'hourglass-half',
  stop: 'stop-circle',
};

const TASKING_STRATEGY_ICONS: Record<string, string> = {
  Sequential: 'list-ol',
  'Strict order': 'lock',
};

const buttonNumberToIcon: Record<number, string> = {
  1: '',
  2: 'arrow-up',
  3: '',
  4: 'arrow-left',
  5: 'arrows-to-dot',
  6: 'arrow-right',
  7: '',
  8: 'arrow-down',
  9: '',
};

function MasterControls() {
  const { act, data } = useBackend<ManipulatorData>();
  const { speed_multiplier, min_speed_multiplier, max_speed_multiplier } = data;

  return (
    <Stack>
      <Stack.Item>
        <Button
          icon="backward-step"
          onClick={() =>
            act('adjust_interaction_speed', { new_speed: min_speed_multiplier })
          }
        />
      </Stack.Item>
      <Stack.Item grow>
        <Slider
          style={{ marginTop: '-0px', marginBottom: '-7px' }}
          lineHeight={1}
          step={0.1}
          my={1}
          value={speed_multiplier}
          minValue={min_speed_multiplier}
          maxValue={max_speed_multiplier}
          unit="x"
          stepPixelSize={20}
          onChange={(_e, value) =>
            act('adjust_interaction_speed', { new_speed: value })
          }
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          icon="forward-step"
          onClick={() =>
            act('adjust_interaction_speed', { new_speed: max_speed_multiplier })
          }
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          icon="eject"
          tooltip="松开夹爪，放下持有的物品"
          onClick={() => act('drop_held_atom')}
        >
          放下
        </Button>
      </Stack.Item>
      <Stack.Item>
        <Button
          icon="person-walking-arrow-right"
          tooltip="解开作业者的束缚"
          onClick={() => act('unbuckle')}
        >
          解开
        </Button>
      </Stack.Item>
    </Stack>
  );
};

type ConfigRowProps = {
  label: string;
  content: string;
  onClick: () => void;
  tooltip?: string;
  selected?: BooleanLike;
};

const ConfigRow = (props: ConfigRowProps) => {
  const { label, content, onClick, tooltip = '', selected = false } = props;

  return (
    <Table.Row
      className="candystripe"
      style={{ height: '2em', lineHeight: '2em' }}
    >
      <Table.Cell>
        <Box style={{ marginLeft: '5px' }}>{label}</Box>
      </Table.Cell>
      <Table.Cell
        style={{ width: 'min-content', whiteSpace: 'nowrap', textAlign: 'right' }}
      >
        <Button tooltip={tooltip} onClick={onClick} selected={!!selected}>
          {content}
        </Button>
      </Table.Cell>
    </Table.Row>
  );
};

const getPointButtonNumber = (offset: string): number | null => {
  const [dx, dy] = offset.split(',').map(Number);
  if (!Number.isFinite(dx) || !Number.isFinite(dy)) return null;
  if (dx < -1 || dx > 1 || dy < -1 || dy > 1) return null;
  if (dx === 0 && dy === 0) return null;
  const xIndex = dx + 1;
  const yIndex = 1 - dy;
  return yIndex * 3 + xIndex + 1;
};

type TaskEditModalProps = {
  task: ManipulatorTask;
  onClose: () => void;
};

function TaskEditModal(props: TaskEditModalProps) {
  const { act, data } = useBackend<ManipulatorData>();
  const { task, onClose } = props;

  const adjust = (param: string, value?: any) =>
    act('adjust_task_param', { taskId: task.id, param, value });

  const isCargo = !!task.turf;
  const isPickup = task.task_type.includes('pickup');
  const isDropoff = task.task_type === 'drop' || task.task_type === 'throw' || task.task_type === 'use';
  const isInteract = task.task_type.includes('interact');
  const isMove = task.task_type === 'move';

  const currentButton = task.turf
    ? getPointButtonNumber(task.turf)
    : null;

  return (
    <Modal style={{ padding: '6px', width: '340px', boxSizing: 'initial' }}>
      <Section
        title={`编辑：${task.name}`}
        buttons={
          <Button icon="xmark" color="bad" onClick={onClose} />
        }
      >
        {task.task_type.includes('wait') && (
          <Table>
            <Table.Row className="candystripe" style={{ height: '2em', lineHeight: '2em' }}>
              <Table.Cell>
                <Box style={{ marginLeft: '5px' }}>等待时间</Box>
              </Table.Cell>
              <Table.Cell style={{ paddingRight: '5px' }}>
                <Slider
                  value={task.time ?? 1}
                  minValue={1}
                  maxValue={60}
                  step={1}
                  stepPixelSize={4}
                  unit="s"
                  onChange={(_e, value) => adjust('set_wait_time', value)}
                />
              </Table.Cell>
            </Table.Row>
          </Table>
        )}
      {isCargo && (
          <Stack>
            <Stack.Item>
              <Box
                style={{
                  display: 'grid',
                  gridTemplateColumns: '1fr 1fr 1fr',
                  gridTemplateRows: '1fr 1fr 1fr',
                  height: '60px',
                  width: '60px',
                  gap: '2px',
                  marginRight: '10px',
                }}
              >
                {[1, 2, 3, 4, 5, 6, 7, 8, 9].map((n) => (
                  <Button
                    key={n}
                    disabled={n === 5}
                    color={currentButton === n ? 'good' : 'default'}
                    onClick={() => n !== 5 && adjust('move_to', { buttonNumber: n })}
                    style={{ margin: '0', padding: '0', textAlign: 'center' }}
                    icon={buttonNumberToIcon[n]}
                  />
                ))}
              </Box>
            </Stack.Item>
            <Stack.Item grow>
              <Table>
                {!isMove && (
                  <ConfigRow
                    label="使用筛选器"
                    content={task.filters_status ? '是' : '否'}
                    onClick={() => adjust('toggle_filter_skip')}
                    tooltip="切换是否使用筛选器"
                  />
                )}
                {isPickup && (
                  <ConfigRow
                    label="拾取时机"
                    content={batchThreeDisplay(task.pickup_eagerness ?? '—')}
                    onClick={() => adjust('cycle_pickup_eagerness')}
                    tooltip="等待放置位置可用，或立即拾取"
                  />
                )}
                {isDropoff && (
                  <>
                    {task.task_type === 'drop' && (
                      <ConfigRow
                        label="溢出处理"
                        content={batchThreeDisplay(task.overflow_status ?? '—')}
                        onClick={() => adjust('cycle_overflow_status')}
                        tooltip="切换溢出处理方式"
                      />
                    )}
                    {task.task_type === 'throw' && (
                      <ConfigRow
                        label="投掷距离"
                        content={`${task.throw_range} 格`}
                        onClick={() => adjust('cycle_throw_range')}
                        tooltip="切换投掷距离"
                      />
                    )}
                  </>
                )}
                {(task.task_type === 'use' || isInteract) && (
                  <>
                    <ConfigRow
                      label="右键点击"
                      content={task.worker_use_rmb ? '是' : '否'}
                      onClick={() => adjust('toggle_worker_rmb')}
                      tooltip="模拟鼠标右键点击"
                    />
                    <ConfigRow
                      label="战斗模式"
                      content={task.worker_combat_mode ? '是' : '否'}
                      onClick={() => adjust('toggle_worker_combat')}
                      tooltip="交互时使用战斗模式"
                    />
                    <ConfigRow
                      label="跳过固定物体"
                      content={task.skip_anchored ? '是' : '否'}
                      onClick={() => adjust('toggle_skip_anchored')}
                      tooltip="寻找交互目标时跳过已固定的物体"
                    />
                  </>
                )}
              </Table>
            </Stack.Item>
          </Stack>
        )}
      </Section>

      {isCargo && !isMove && (
        <>
          <Section
            title="物品筛选器"
            buttons={
              <>
                <Button
                  icon="plus"
                  onClick={() => adjust('add_atom_filter_from_held')}
                >
                  添加手持物
                </Button>
                <Button.Confirm
                  onClick={() => adjust('reset_atom_filters')}
                  confirmContent="确定重置？"
                  icon="trash"
                />
              </>
            }
          >
            <Stack vertical>
              {(task.item_filters ?? []).map((name, index) => (
                <Stack key={index}>
                  <Stack.Item grow>
                    <BlockQuote>{name}</BlockQuote>
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      color="transparent"
                      icon="xmark"
                      onClick={() => adjust('delete_filter', index)}
                    />
                  </Stack.Item>
                </Stack>
              ))}
            </Stack>
          </Section>

          {(task.settings_list ?? []).length > 0 && (
            <Section title="交互优先级">
              <Table>
                {task.settings_list!.map((setting, index) => (
                  <Table.Row className="candystripe" key={setting.name}>
                    <Table.Cell style={{ padding: '4px' }}>
                      <Icon name="hashtag" /> {index + 1}
                    </Table.Cell>
                    <Table.Cell>
                      <Button.Checkbox
                        onClick={() => adjust('toggle_priority', index)}
                        checked={!!setting.active}
                        fluid
                      >
                        {setting.name}
                      </Button.Checkbox>
                    </Table.Cell>
                    <Table.Cell width="1em">
                      <Button
                        icon="arrow-up"
                        disabled={index === 0}
                        onClick={() =>
                          index > 0 && adjust('priority_move_up', index)
                        }
                      />
                    </Table.Cell>
                  </Table.Row>
                ))}
              </Table>
            </Section>
          )}
        </>
      )}
    </Modal>
  );
};

const TaskList = () => {
  const { act, data } = useBackend<ManipulatorData>();
  const { tasks_data, current_task, tasking_strategy } = data;

  const [editingTask, setEditingTask] = useState<ManipulatorTask | null>(null);
  const [editingNameId, setEditingNameId] = useState<string | null>(null);
  const [newName, setNewName] = useState('');
  const [selectedType, setSelectedType] = useState<string>('pickup');

  const adjust = (taskId: string, param: string, value?: any) =>
    act('adjust_task_param', { taskId, param, value });

  const handleSaveName = (taskId: string) => {
    adjust(taskId, 'set_name', newName);
    setEditingNameId(null);
    setNewName('');
  };

  // keep modal in sync with live data
  useEffect(() => {
    if (!editingTask) return;
    const updated = tasks_data.find((t) => t.id === editingTask.id);
    if (updated) setEditingTask(updated);
  }, [tasks_data]);

  const strategyIcon =
    TASKING_STRATEGY_ICONS[tasking_strategy] ?? 'list-ol';

  return (
    <>
      <Section
        title="任务"
        buttons={
          <>
            <Button
              icon={strategyIcon}
              color="transparent"
              tooltip="切换任务执行策略"
              onClick={() => act('cycle_tasking_strategy', {
                new_strategy: tasking_strategy === 'Sequential' ? 'Strict order' : 'Sequential',
              })}
            >
              {batchThreeDisplay(tasking_strategy)}
            </Button>
            <Button
              icon="arrows-spin"
              color="transparent"
              tooltip="重置当前任务位置"
              onClick={() => act('reset_tasking_index')}
            >
              重置
            </Button>
          </>
        }
      >
        <Stack vertical>
          {tasks_data.map((task, index) => {
            const isActive = current_task === task.id;
            const taskTypeKey = Object.keys(TASK_TYPE_LABELS).find((k) =>
              task.task_type.includes(k),
            ) ?? 'wait';

            return (
              <Stack.Item
                key={task.id}
                style={{
                  padding: '5px',
                  border: isActive ? '1px solid #bdad5e' : '1px solid transparent',
                  borderRadius: '2px',
                  boxShadow: isActive ? '0 0 6px 2px rgba(200, 168, 0, 0.55)' : undefined,
                  backgroundColor: isActive ? 'rgba(151, 142, 95, 0.55)' : undefined
                }}
                className="candystripe"
              >
                <Stack align="center">
                  <Stack.Item>
                    <Box
                      style={{
                        width: '1.4em',
                        textAlign: 'center',
                        color: '#888',
                        fontWeight: 'bold',
                      }}
                    >
                      {index + 1}
                    </Box>
                  </Stack.Item>
                  <Stack.Item>
                    <Icon
                      name={TASK_TYPE_ICONS[taskTypeKey] ?? 'circle'}
                      style={{ width: '1.2em', textAlign: 'center', marginRight: '5px' }}
                    />
                  </Stack.Item>
                  <Stack.Item grow>
                      <Box>
                        <Box bold style={{ display: 'inline' }}>
                          {TASK_TYPE_LABELS[taskTypeKey] ?? task.task_type}
                        </Box>
                        <Box color="label" fontSize="11px">

                          {task.item_filters && task.item_filters.length > 0 && (
                            <Box>
                              {'……以下任意一种：' +
                                task.item_filters.slice(0, 3).join(', ') +
                                (task.item_filters.length > 3 ? `及其他 ${task.item_filters.length - 3} 种` : '') +
                                '……'}
                            </Box>
                          )}
                          {task.turf && <Box>……{task.task_type === 'move' ? '前往' : '位于'} [{task.turf}]……</Box>}
                          {task.time && <Box>……持续 {task.time} 秒……</Box>}
                          {task.sub_name && <Box>...{task.sub_name}</Box>}
                        </Box>
                      </Box>
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      icon="gear"
                      color="transparent"
                      onClick={() => setEditingTask(task)}
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      icon="trash"
                      color="transparent"
                      onClick={() => adjust(task.id, 'remove_task')}
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Stack style={{ gap: '4px' }}>
                      <Stack.Item>
                        <Button
                          icon="arrow-down"
                          disabled={index === tasks_data.length - 1}
                          onClick={() => adjust(task.id, 'move_down')}
                        />
                      </Stack.Item>
                      <Stack.Item>
                        <Button
                          icon="arrow-up"
                          disabled={index === 0}
                          onClick={() => adjust(task.id, 'move_up')}
                        />
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            );
          })}
        </Stack>
      </Section>

      <Section>
        <Stack>
          <Stack.Item grow>
            <Dropdown
              width="100%"
              options={Object.keys(TASK_TYPE_LABELS).map((k) => ({
                value: k,
                displayText: TASK_TYPE_LABELS[k],
              }))}
              selected={selectedType} displayText={TASK_TYPE_LABELS[selectedType]}
              onSelected={(val) => setSelectedType(val)}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="plus"
              onClick={() => act('create_task', { task_type: selectedType })}
              style={{lineHeight: '22px'}}
            >
              新建
            </Button>
          </Stack.Item>
        </Stack>
      </Section>

      {editingTask && (
        <TaskEditModal
          task={editingTask}
          onClose={() => setEditingTask(null)}
        />
      )}
    </>
  );
};

export const BigManipulator = () => {
  const { data, act } = useBackend<ManipulatorData>();
  const { active, stopping } = data;

  return (
    <Window title="机械臂界面" width={420} height={560}>
      <Window.Content overflowY="auto">
        <Section
          title="操作面板"
          buttons={
            <Button
              icon={!active ? 'play' : stopping ? 'hourglass-start' : 'stop'}
              color={!active ? 'good' : stopping ? 'blue' : 'bad'}
              onClick={() => act('run_cycle')}
            >
              {!active ? '运行' : stopping ? '正在停止' : '停止'}
            </Button>
          }
        >
          <MasterControls />
        </Section>
        <Section

        >
          <Stack>
            <Stack.Item grow>
            <Button style={{
              width: '100%',
              lineHeight: '24px'
            }}
              icon={ data.disk_inserted ? "eject" : 'info' }
              disabled={!data.disk_inserted || !!active || !!stopping}
              color={!data.disk_inserted && "none"}
              onClick={() => act('disk_eject')}
            >
              { data.disk_inserted ? `软盘（任务数：${data.disk_task_count}）` : "未插入磁盘" }
            </Button>
            </Stack.Item>
            <Stack.Item>
              <Button style={{
              lineHeight: '24px'
            }}
                icon="download"
                disabled={!data.disk_inserted || !!active || !!stopping}
                onClick={() => act('disk_read')}
              >
                读取
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button style={{
              lineHeight: '24px'
            }}
                icon="upload"
                disabled={!data.disk_inserted || !!data.disk_read_only || !!active || !!stopping}
                onClick={() => act('disk_write')}
              >
                写入
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button.Confirm style={{
              lineHeight: '24px'
            }}
                icon="trash"
                disabled={!data.disk_inserted || !!data.disk_read_only || !!active || !!stopping}
                confirmContent="确定清空？"
                onClick={() => act('disk_clear')}
              >清空
              </Button.Confirm>
            </Stack.Item>
          </Stack>
        </Section>
        <TaskList />
      </Window.Content>
    </Window>
  );
};
