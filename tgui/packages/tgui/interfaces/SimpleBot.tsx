import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import {
  Button,
  Icon,
  LabeledControls,
  NoticeBox,
  Section,
  Slider,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { capitalizeAll } from 'tgui-core/string'; import { botControlDisplay } from '../localization/botControlDisplay';

type Data = {
  can_hack: BooleanLike;
  custom_controls: Record<string, number>;
  emagged: BooleanLike;
  has_access: BooleanLike;
  locked: BooleanLike;
  settings: Settings;
};

type Settings = {
  airplane_mode: BooleanLike;
  allow_possession: BooleanLike;
  has_personality: BooleanLike;
  maintenance_lock: BooleanLike;
  pai_inserted: boolean;
  patrol_station: BooleanLike;
  possession_enabled: BooleanLike;
  power: BooleanLike;
};

export function SimpleBot(props) {
  const { data } = useBackend<Data>();
  const { can_hack, locked } = data;
  const access = !locked || !!can_hack;

  return (
    <Window width={450} height={300}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <BotSettings />
          </Stack.Item>
          {!!access && (
            <Stack.Item grow>
              <BotControl />
            </Stack.Item>
          )}
        </Stack>
      </Window.Content>
    </Window>
  );
}

export function BotSettings(props) {
  const { act, data } = useBackend<Data>();
  const { can_hack, locked } = data;
  const access = !locked || !!can_hack;
  return (
    <Section title="设置" buttons={<TabDisplay />}>
      {!access ? <NoticeBox>已锁定！</NoticeBox> : <SettingsDisplay />}
    </Section>
  );
}

export function BotControl(props) {
  const { act, data } = useBackend<Data>();
  const { custom_controls } = data;
  return (
    <Section fill scrollable title="控制">
      <LabeledControls wrap>
        {Object.entries(custom_controls).map((control) => (
          <LabeledControls.Item
            pb={2}
            key={control[0]}
            label={botControlDisplay(control[0]) ?? capitalizeAll(control[0].replace('_', ' '))}
          >
            <ControlHelper control={control} />
          </LabeledControls.Item>
        ))}
      </LabeledControls>
    </Section>
  );
}
/** Creates a lock button at the top of the controls */
function TabDisplay(props) {
  const { act, data } = useBackend<Data>();
  const {
    can_hack,
    emagged,
    has_access,
    locked,
    settings: { allow_possession },
  } = data;

  return (
    <>
      {!!can_hack && (
        <Button
          color="danger"
          disabled={!can_hack}
          icon={emagged ? 'bug' : 'lock'}
          onClick={() => act('hack')}
          selected={!emagged}
          tooltip={
            !emagged
              ? '解除安全协议。'
              : '重置机器人操作系统。'
          }
        >
          {emagged ? '故障状态' : '安全锁'}
        </Button>
      )}
      {!!allow_possession && <PaiButton />}
      <Button
        color="transparent"
        icon="fa-poll-h"
        onClick={() => act('rename')}
        tooltip="更新机器人的注册名称。"
      >
        重命名
      </Button>
      <Button
        color="transparent"
        disabled={!has_access && !can_hack}
        icon={locked ? 'lock' : 'lock-open'}
        onClick={() => act('lock')}
        selected={locked}
        tooltip={`${locked ? '解锁' : '锁定'}控制面板。`}
      >
        控制面板锁
      </Button>
    </>
  );
}

/** Creates a button indicating PAI status and offers the eject action */
function PaiButton(props) {
  const { act, data } = useBackend<Data>();
  const {
    settings: { pai_inserted },
  } = data;

  if (!pai_inserted) {
    return (
      <Button
        color="transparent"
        icon="robot"
        tooltip={`插入已激活的个人AI卡以控制此设备。`}
      >
        未插入个人AI
      </Button>
    );
  }

  return (
    <Button
      disabled={!pai_inserted}
      icon="eject"
      onClick={() => act('eject_pai')}
      tooltip={`弹出当前个人AI。`}
    >
      弹出个人AI
    </Button>
  );
}

/** Displays the bot's standard settings: Power, patrol, etc. */
function SettingsDisplay(props) {
  const { act, data } = useBackend<Data>();
  const {
    settings: {
      airplane_mode,
      patrol_station,
      power,
      maintenance_lock,
      allow_possession,
      possession_enabled,
    },
  } = data;

  return (
    <LabeledControls>
      <LabeledControls.Item label="电源">
        <Tooltip content={`${power ? '关闭' : '开启'}机器人电源。`}>
          <Icon
            size={2}
            name="power-off"
            color={power ? 'good' : 'gray'}
            onClick={() => act('power')}
          />
        </Tooltip>
      </LabeledControls.Item>
      <LabeledControls.Item label="飞行模式">
        <Tooltip
          content={`${
            !airplane_mode ? '禁止' : '允许'
          }通过控制台远程访问。`}
        >
          <Icon
            size={2}
            name="plane"
            color={airplane_mode ? 'yellow' : 'gray'}
            onClick={() => act('airplane')}
          />
        </Tooltip>
      </LabeledControls.Item>
      <LabeledControls.Item label="空间站巡逻">
        <Tooltip
          content={`${
            patrol_station ? '关闭' : '开启'
          }空间站自动巡逻。`}
        >
          <Icon
            size={2}
            name="map-signs"
            color={patrol_station ? 'good' : 'gray'}
            onClick={() => act('patrol')}
          />
        </Tooltip>
      </LabeledControls.Item>
      <LabeledControls.Item label="检修锁">
        <Tooltip
          content={
            maintenance_lock
              ? '打开检修舱盖以进行维修。'
              : '关闭检修舱盖。'
          }
        >
          <Icon
            size={2}
            name="toolbox"
            color={maintenance_lock ? 'yellow' : 'gray'}
            onClick={() => act('maintenance')}
          />
        </Tooltip>
      </LabeledControls.Item>
      {!!allow_possession && (
        <LabeledControls.Item label="人格">
          <Tooltip
            content={
              possession_enabled
                ? '将人格重置为出厂默认状态。'
                : '允许下载独特人格。'
            }
          >
            <Icon
              size={2}
              name="robot"
              color={possession_enabled ? 'good' : 'gray'}
              onClick={() => act('toggle_personality')}
            />
          </Tooltip>
        </LabeledControls.Item>
      )}
    </LabeledControls>
  );
}

enum ControlType {
  MedbotThreshold = 'heal_threshold',
  FloorbotTiles = 'tile_stack',
  FloorbotLine = 'line_mode',
}

type ControlProps = {
  control: [string, number];
};

/** Helper function which identifies which button to create.
 * Might need some fine tuning if you are using more advanced controls.
 */
function ControlHelper(props: ControlProps) {
  const { act } = useBackend<Data>();
  const { control } = props;

  switch (control[0]) {
    case ControlType.MedbotThreshold:
      return <MedbotThreshold control={control} />;
    case ControlType.FloorbotTiles:
      return <FloorbotTiles control={control} />;
    case ControlType.FloorbotLine:
      return <FloorbotLine control={control} />;
    default:
      return (
        <Icon
          color={control[1] ? 'good' : 'gray'}
          name={control[1] ? 'toggle-on' : 'toggle-off'}
          size={2}
          onClick={() => act(control[0])}
        />
      );
  }
}

/** Slider button for medbot healing thresholds */
function MedbotThreshold(props: ControlProps) {
  const { act } = useBackend<Data>();
  const { control } = props;

  return (
    <Tooltip content="调整触发伤害治疗的灵敏度。">
      <Slider
        minValue={5}
        maxValue={75}
        ranges={{
          good: [-Infinity, 15],
          average: [15, 55],
          bad: [55, Infinity],
        }}
        step={5}
        unit="%"
        value={control[1]}
        onChange={(_, value) => act(control[0], { threshold: value })}
      />
    </Tooltip>
  );
}

/** Tile stacks for floorbots - shows number and eject button */
function FloorbotTiles(props: ControlProps) {
  const { act } = useBackend<Data>();
  const { control } = props;

  return (
    <Button
      disabled={!control[1]}
      icon={control[1] ? 'eject' : ''}
      onClick={() => act('eject_tiles')}
      tooltip="机器人内储存的地砖数量。"
    >
      {control[1] ? `${control[1]}` : '空'}
    </Button>
  );
}

/** Direction indicator for floorbot when line mode is chosen. */
function FloorbotLine(props: ControlProps) {
  const { act } = useBackend<Data>();
  const { control } = props;

  return (
    <Tooltip content="启用直线铺砖模式。">
      <Icon
        color={control[1] ? 'good' : 'gray'}
        name={control[1] ? 'compass' : 'toggle-off'}
        onClick={() => act('line_mode')}
        size={!control[1] ? 2 : 1.5}
      />
      {control[1] ? control[1].toString().charAt(0).toUpperCase() : ''}
    </Tooltip>
  );
}
