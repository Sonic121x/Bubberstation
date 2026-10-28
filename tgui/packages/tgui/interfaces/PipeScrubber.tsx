import {
  Box,
  Button,
  Icon,
  LabeledControls,
  RoundGauge,
  Section,
  Tooltip,
} from 'tgui-core/components';
import { formatSiUnit } from 'tgui-core/format';
import { toFixed } from 'tgui-core/math';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { getGasLabel } from '../constants';
import { Window } from '../layouts';

type Data = {
  on: BooleanLike;
  direction: BooleanLike;
  connected: BooleanLike;
  pressureTank: number;
  pressureLimitTank: number;
  pressurePump: number;
  pressureLimitPump: number;
  pumpMaxPressure: number;
  hasHypernobCrystal: BooleanLike;
  reactionSuppressionEnabled: BooleanLike;
  filterTypes: Filter[];
};

type Filter = {
  id: string;
  enabled: BooleanLike;
  gasId: string;
  gasName: string;
};

const formatPressure = (value) => {
  if (value < 10000) {
    return `${toFixed(value)} kPa`;
  }
  return formatSiUnit(value * 1000, 1, 'Pa');
};

export const PipeScrubber = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    on,
    connected,
    direction,
    pressureTank,
    pressureLimitTank,
    pressurePump,
    pressureLimitPump,
    hasHypernobCrystal,
    reactionSuppressionEnabled,
    filterTypes = [],
  } = data;

  return (
    <Window width={400} height={350}>
      <Window.Content>
        <Section
          title="状态"
          buttons={
            !!hasHypernobCrystal && (
              <Button
                icon={reactionSuppressionEnabled ? 'snowflake' : 'times'}
                selected={reactionSuppressionEnabled}
                onClick={() => act('reaction_suppression')}
              >
                {reactionSuppressionEnabled
                  ? '反应抑制已启用'
                  : '反应抑制已禁用'}
              </Button>
            )
          }
        >
          <LabeledControls p={1}>
            <LabeledControls.Item label="缓冲接口">
              <Box position="relative">
                <Tooltip
                  position="top"
                  content={connected ? '已连接' : '未连接'}
                >
                  <Icon
                    size={2}
                    name={connected ? 'plug-circle-check' : 'plug-circle-xmark'}
                    color={connected ? 'good' : 'bad'}
                  />
                </Tooltip>
              </Box>
            </LabeledControls.Item>
            <LabeledControls.Item label="缓冲区">
              <RoundGauge
                size={1.75}
                value={pressurePump}
                minValue={0}
                maxValue={pressureLimitPump}
                alertAfter={pressureLimitPump * 0.7}
                ranges={{
                  good: [0, pressureLimitPump * 0.7],
                  average: [pressureLimitPump * 0.7, pressureLimitPump * 0.85],
                  bad: [pressureLimitPump * 0.85, pressureLimitPump],
                }}
                format={formatPressure}
              />
            </LabeledControls.Item>
            <LabeledControls.Item label="气罐">
              <RoundGauge
                size={1.75}
                value={pressureTank}
                minValue={0}
                maxValue={pressureLimitTank}
                alertAfter={pressureLimitTank * 0.7}
                ranges={{
                  good: [0, pressureLimitTank * 0.7],
                  average: [pressureLimitTank * 0.7, pressureLimitTank * 0.85],
                  bad: [pressureLimitTank * 0.85, pressureLimitTank],
                }}
                format={formatPressure}
              />
            </LabeledControls.Item>
            <LabeledControls.Item label="气泵">
              <Button
                my={0.5}
                width={6}
                lineHeight={2}
                fontSize="18px"
                icon="power-off"
                selected={on}
                onClick={() => act('power')}
              >
                {on ? '开启' : '关闭'}
              </Button>
            </LabeledControls.Item>
          </LabeledControls>
        </Section>
        <Section
          title="方向"
          buttons={
            <Button onClick={() => act('direction')}>
              {direction ? '缓冲区 → 气罐' : '气罐 → 缓冲区'}
            </Button>
          }
        >
          {!!direction && (
            <>
              <Box>将缓冲区内的气体过滤到内部气罐。</Box>
              <Section>
                {filterTypes.map((filter) => (
                  <Button
                    key={filter.id}
                    icon={filter.enabled ? 'check-square-o' : 'square-o'}
                    content={getGasLabel(filter.gasId, filter.gasName)}
                    selected={filter.enabled}
                    onClick={() =>
                      act('toggle_filter', {
                        val: filter.gasId,
                      })
                    }
                  />
                ))}
              </Section>
            </>
          )}
          {!direction && (
            <Box>将内部气罐中的气体排入缓冲区。</Box>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
