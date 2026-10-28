import { type ReactNode, useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  Input,
  ProgressBar,
  Section,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Direction } from '../constants';
import { Window } from '../layouts';

type AreaData = { name: string; ref: string };

type VisualizationToggleProps = { visualizing: BooleanLike };

type ShuttleConstructionUnieuqData = {
  linkedShuttle: 0;
  tooManyShuttles: BooleanLike;
  onCustomShuttle: BooleanLike;
};

type ShuttleConfigurationUniqueData = {
  linkedShuttle: string;
  onShuttle: BooleanLike;
  inDefaultArea: BooleanLike;
  currentArea: AreaData;
  defaultApc: BooleanLike;
  apcInMergeRegion: BooleanLike;
  apcs: Record<string, BooleanLike>;
  neighboringAreas: Record<string, string>;
  idle: BooleanLike;
};

type ShuttleBlueprintsData = {
  shuttles?: Record<string, string>;
  visualizing: BooleanLike;
  masterExists: BooleanLike;
  isMaster: BooleanLike;
  maxShuttleSize: number;
} & (OnShuttleFrameData | OffShuttleFrameData) &
  (ShuttleConstructionUnieuqData | ShuttleConfigurationUniqueData);

type OnShuttleFrameData = {
  onShuttleFrame: 1;
  size: number;
  problems: number;
};

type OffShuttleFrameData = {
  onShuttleFrame: 0;
  size: undefined;
  problems: undefined;
};

type DirectionPadProps = {
  title: string;
  tooltip?: ReactNode;
  enabledDirections: Direction;
  selectedDirection: Direction;
  onSelect: (direction: Direction) => void;
};

const directionData: [Direction, string][] = [
  [Direction.NORTH, 'up'],
  [Direction.SOUTH, 'down'],
  [Direction.EAST, 'right'],
  [Direction.WEST, 'left'],
];

type ProblemsTooltipProps = {
  description: string;
  problemHeader: string;
  problems: number;
  problemStrings: string[];
};

const DirectionPad = (props: DirectionPadProps) => {
  const { title, tooltip, enabledDirections, selectedDirection, onSelect } =
    props;
  const [north, south, east, west] = directionData.map(
    ([direction, icon_suffix], i) => (
      <Stack.Item key={i}>
        <Button
          fluid
          m={0}
          icon={`arrow-${icon_suffix}`}
          selected={selectedDirection & direction}
          disabled={!(enabledDirections & direction)}
          onClick={() => onSelect(direction)}
        />
      </Stack.Item>
    ),
  );
  const titleNode = (
    <Box width="100%" textAlign="center">
      {title}
    </Box>
  );
  return (
    <Section
      fill
      title={
        tooltip ? <Tooltip content={tooltip}>{titleNode}</Tooltip> : titleNode
      }
    >
      <Stack fill vertical align="center" justify="center">
        {north}
        <Stack.Item>
          <Stack>
            {west}
            <Stack.Item width="1rem" mx={1} />
            {east}
          </Stack>
        </Stack.Item>
        {south}
      </Stack>
    </Section>
  );
};

const VisualizationToggle = (props: VisualizationToggleProps) => {
  const { visualizing } = props;
  const { act } = useBackend<ShuttleBlueprintsData>();
  return (
    <Tooltip
      content="切换显示可用于建造穿梭机的框架预览。
                红色格子表示建在无效区域中的框架，
                或合适区域中尚需铺设框架的部分。"
    >
      <Box inline>
        可视化：
        <Button
          color="transparent"
          icon={visualizing ? 'toggle-on' : 'toggle-off'}
          onClick={() => act('toggleVisualization')}
        />
      </Box>
    </Tooltip>
  );
};

const ProblemsTooltip = (props: ProblemsTooltipProps) => {
  const { description, problemHeader, problems, problemStrings } = props;

  const problemElements: React.ReactElement[] = [];
  for (let i = 0; i < problemStrings.length; i++) {
    if (problems & (1 << i)) {
      problemElements.push(<Box key={i}>{`● ${problemStrings[i]}`}</Box>);
    }
  }

  return (
    <Box>
      {description}
      {problems ? (
        <>
          <Box>{problemHeader}</Box>
          {problemElements}
        </>
      ) : undefined}
    </Box>
  );
};

const ShuttleConstruction = () => {
  const [shuttleDirection, setShuttleDirection] = useState<Direction>(
    Direction.NORTH,
  );
  const { act, data } = useBackend<ShuttleBlueprintsData>();
  if (data.linkedShuttle !== 0) {
    throw new Error('type guard failure - linkedShuttle must be 0');
  }
  const {
    onShuttleFrame,
    visualizing,
    tooManyShuttles,
    onCustomShuttle,
    masterExists,
    size,
    maxShuttleSize,
    problems,
  } = data;
  return (
    <Stack justify="space-around">
      <Stack.Item grow>
        <DirectionPad
          title="穿梭机朝向"
          tooltip="设置即将建造的穿梭机的朝向。"
          enabledDirections={Direction.ALL}
          selectedDirection={shuttleDirection}
          onSelect={(dir) => setShuttleDirection(dir)}
        />
      </Stack.Item>
      <Stack.Item>
        <Stack fill vertical align="end" justify="space-between">
          <Stack.Item>
            <VisualizationToggle visualizing={visualizing} />
          </Stack.Item>
          <Stack.Item>
            <Stack vertical>
              <Stack.Item>
                <Button.Confirm
                  disabled={!onShuttleFrame || tooManyShuttles || problems}
                  tooltip={
                    <ProblemsTooltip
                      description="使用穿梭机框架建造新穿梭机。"
                      problemHeader="以下问题导致此框架无法用于建造穿梭机。"
                      problems={problems ?? 0}
                      problemStrings={[
                        '你不在穿梭机框架上。',
                        '当前自定义穿梭机数量过多。',
                        '此框架过大。',
                        '此框架包含自定义区域的APC，但未包含整个区域。\
                         请移除APC，或将区域剩余部分纳入框架。',
                        '此框架侵入了不允许自定义穿梭机停靠的区域。',
                        '此框架包含属于非自定义区域的APC。',
                      ]}
                    />
                  }
                  onClick={() =>
                    act('tryBuildShuttle', { dir: shuttleDirection })
                  }
                >
                  建造新穿梭机
                </Button.Confirm>
              </Stack.Item>
              {onShuttleFrame ? (
                <Stack.Item>
                  <ProgressBar
                    value={size}
                    maxValue={maxShuttleSize}
                    ranges={{
                      green: [0, maxShuttleSize * 0.5],
                      yellow: [maxShuttleSize * 0.5, maxShuttleSize * 0.75],
                      orange: [maxShuttleSize * 0.75, maxShuttleSize],
                      red: [maxShuttleSize, Infinity],
                    }}
                  >
                    {`${size}/${maxShuttleSize}`}
                  </ProgressBar>
                </Stack.Item>
              ) : undefined}
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              disabled={!onCustomShuttle || masterExists}
              tooltip={
                onCustomShuttle
                  ? masterExists
                    ? '此穿梭机的主蓝图仍然存在。\
                          持有人可以将其复制到这份蓝图中。'
                    : null
                  : '你必须位于自定义穿梭机上才能执行此操作。'
              }
              onClick={() => act('tryLinkShuttle')}
            >
              连接现有穿梭机
            </Button.Confirm>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

const ShuttleConfiguration = () => {
  const [name, setName] = useState('');
  const [mergeArea = { name: '', ref: '' }, setMergeArea] =
    useState<AreaData>();
  const { act, data } = useBackend<ShuttleBlueprintsData>();
  if (data.linkedShuttle === 0) {
    throw new Error('type guard failure - linkedShuttle must be non-zero');
  }
  const {
    visualizing,
    onShuttleFrame,
    onShuttle,
    inDefaultArea,
    currentArea = { name: '', ref: '' },
    neighboringAreas = {},
    apcs = {},
    defaultApc,
    apcInMergeRegion,
    idle,
    isMaster,
    size,
    maxShuttleSize,
    problems,
  } = data;
  const { name: currentAreaName, ref: currentAreaRef } = currentArea;
  const { name: mergeAreaName, ref: mergeAreaRef } = mergeArea;
  const removalApcConflict = defaultApc && apcs[currentAreaRef];
  const mergeApcConflict = apcInMergeRegion && apcs[mergeAreaRef];
  const tooLarge = (size ?? 0) > maxShuttleSize;
  return (
    <Stack fill vertical align="center" justify="space-around">
      <Stack.Item textAlign="center">
        <h2>当前区域：</h2>
        <h3>
          {onShuttle
            ? inDefaultArea
              ? '默认区域'
              : currentAreaName
            : '不在穿梭机上'}
        </h3>
      </Stack.Item>
      <Stack.Item>
        <Input fluid placeholder="新区域名称" onChange={setName} />
        <Stack>
          <Stack.Item>
            <Button.Confirm
              disabled={!(onShuttle && inDefaultArea)}
              tooltip={
                onShuttle
                  ? inDefaultArea
                    ? '将穿梭机内的房间划为独立区域。'
                    : '只能从默认区域中划出新区域。'
                  : '你必须位于已连接的穿梭机上才能执行此操作。'
              }
              onClick={() => act('createNewArea', { name: name })}
            >
              划定新区域
            </Button.Confirm>
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              disabled={!onShuttle || inDefaultArea}
              tooltip={
                onShuttle
                  ? inDefaultArea
                    ? '无法重命名默认区域。'
                    : null
                  : '你必须位于已连接的穿梭机上才能执行此操作。'
              }
              onClick={() => act('renameArea', { name: name })}
            >
              重命名当前区域
            </Button.Confirm>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item width="100%">
        <Stack fill justify="center">
          <Stack.Item>
            <Dropdown
              placeholder="选择区域"
              options={Object.entries(neighboringAreas).map(([ref, name]) => {
                return {
                  displayText: name,
                  value: ref,
                };
              })}
              selected={mergeAreaName}
              onSelected={(value) =>
                setMergeArea({ name: neighboringAreas[value], ref: value })
              }
            />
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              disabled={
                !(onShuttle && inDefaultArea && mergeArea) || mergeApcConflict
              }
              tooltip={
                '将默认区域中相连的部分并入所选区域。' +
                (onShuttle
                  ? mergeArea
                    ? inDefaultArea
                      ? mergeApcConflict
                        ? '\n所选区域和待并入区域均有APC。必须先移除其中一个。'
                        : ''
                      : '\n只能将所选区域扩展至默认区域。'
                    : ''
                  : '\n你必须位于已连接的穿梭机上才能执行此操作。')
              }
              onClick={() => act('mergeIntoArea', { area: mergeAreaRef })}
            >
              扩展区域
            </Button.Confirm>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack vertical>
          <Stack.Item>
            <Stack>
              <Stack.Item>
                <Button.Confirm
                  disabled={!(idle && onShuttleFrame) || problems || tooLarge}
                  tooltip={
                    <ProblemsTooltip
                      description="使用相邻穿梭机框架扩建已连接的穿梭机。"
                      problemHeader="以下问题导致穿梭机无法扩建。"
                      problems={problems ?? 0}
                      problemStrings={[
                        '你必须站在要用于扩建穿梭机的框架上。',
                        '此框架未与已连接的穿梭机相邻。',
                        '此框架过大。',
                        '此框架包含自定义区域的APC，但未包含整个区域。\
                         请移除APC，或将区域剩余部分纳入框架。',
                        '此框架侵入了不允许自定义穿梭机停靠的区域。',
                        '此框架包含属于非自定义区域的APC。',
                      ]}
                    />
                  }
                  onClick={() => act('expandWithFrame')}
                >
                  用相连框架扩建穿梭机
                </Button.Confirm>
              </Stack.Item>
              <Stack.Item>
                <VisualizationToggle visualizing={visualizing} />
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            {onShuttleFrame ? (
              <Stack.Item>
                <ProgressBar
                  value={size}
                  maxValue={maxShuttleSize}
                  ranges={{
                    green: [0, maxShuttleSize * 0.5],
                    yellow: [maxShuttleSize * 0.5, maxShuttleSize * 0.75],
                    orange: [maxShuttleSize * 0.75, maxShuttleSize],
                    red: [maxShuttleSize, Infinity],
                  }}
                >
                  {`${size}/${maxShuttleSize}`}
                </ProgressBar>
              </Stack.Item>
            ) : undefined}
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Button.Confirm
          disabled={!onShuttle || inDefaultArea || removalApcConflict}
          tooltip={
            '将当前区域并入默认区域。' +
            (onShuttle
              ? inDefaultArea
                ? '\n你已位于默认区域内。'
                : removalApcConflict
                  ? '\n当前区域和默认区域均有APC。必须先移除其中一个。'
                  : ''
              : '\n你必须位于已连接的穿梭机上才能执行此操作。')
          }
          onClick={() => act('releaseArea')}
        >
          撤销区域划分
        </Button.Confirm>
      </Stack.Item>
      <Stack.Item>
        <Button.Confirm
          disabled={!idle || !isMaster}
          tooltip={`移除穿梭机的所有空白空间。${
            isMaster
              ? idle
                ? '\n这会删除所有已无空间的区域，\
              若穿梭机已无任何部分残留，则会将其彻底注销。'
                : '\n穿梭机必须处于空闲状态才能执行此操作。'
              : '\n只有主蓝图能执行此操作。'
          }`}
          onClick={() => act('cleanupEmptyTurfs')}
        >
          清理空白空间
        </Button.Confirm>
      </Stack.Item>
    </Stack>
  );
};

export const ShuttleBlueprints = (props) => {
  const { act, data } = useBackend<ShuttleBlueprintsData>();
  const { linkedShuttle, shuttles, masterExists, isMaster } = data;
  return (
    <Window width={450} height={340}>
      <Window.Content>
        <Section
          fill
          buttons={
            <>
              {shuttles && (
                <Dropdown
                  options={[
                    { displayText: '无', value: 0 },
                    ...Object.entries(shuttles).map(
                      ([ref, name]: [string, string]) => {
                        return { displayText: name, value: ref };
                      },
                    ),
                  ]}
                  selected={linkedShuttle ? shuttles[linkedShuttle] : '无'}
                  onSelected={(value) => {
                    if (value === 0) {
                      act('unsetShuttle');
                    } else {
                      act('switchShuttle', { ref: value });
                    }
                  }}
                />
              )}
              {!!linkedShuttle && !masterExists && !isMaster && (
                <Button.Confirm onClick={() => act('promoteToMaster')}>
                  升级为主蓝图
                </Button.Confirm>
              )}
            </>
          }
        >
          {linkedShuttle ? <ShuttleConfiguration /> : <ShuttleConstruction />}
        </Section>
      </Window.Content>
    </Window>
  );
};
