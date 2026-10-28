import { sortBy } from 'es-toolkit';
import { filter } from 'es-toolkit/compat';
import { useBackend } from 'tgui/backend';
import { getGasColor, getGasLabel } from 'tgui/constants';
import {
  Box,
  Button,
  LabeledList,
  NumberInput,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';

import type { HypertorusFuel, HypertorusGas } from '.';
import { HelpDummy, HoverHelp } from './helpers';

type GasListProps = {
  input_max: number;
  input_min: number;
  input_rate: string;
  input_switch: string;
  raw_gases: HypertorusGas[];
  minimumScale: number;
  prepend?: (gas: HypertorusGas) => void;
  rateHelp?: string;
  stickyGases?: readonly string[];
};

type GasListData = {
  start_power: number;
  start_cooling: number;
};

type HypertorusData = {
  fusion_gases: HypertorusGas[];
  moderator_gases: HypertorusGas[];
  selectable_fuel: HypertorusFuel[];
  selected: string;
};

/*
 * Displays contents of gas mixtures, along with help text for gases with
 * special text when present. Some gas bars are always visible, even when
 * absent, to hint at what can be added and their effects.
 */

const moderator_gases_help = {
  plasma:
    '产生基础气体。提供适度热量加成，帮助启动早期聚变。大量添加时，其较高的热容可将温度变化减缓至可控的速度。',
  bz: '在聚变等级达到 3 或更高时产生中级气体。大幅增加辐射，并使周围人员产生幻觉。',
  proto_nitrate:
    '产生高级气体。大幅增加辐射，加快温度变化。请确保有足够的冷却能力。',
  o2: '大量添加时会快速清除铁。在较高聚变等级下，清除速度不足以抵消损伤带来的铁积累。',
  healium:
    '在高聚变等级下直接修复严重受损的 HFR 核心，但过程中会快速消耗。',
  antinoblium:
    '提供大量能量与辐射。只要含量超过微量，即使完好的 HFR 核心也可能产生危险电暴。操作时请穿戴适当的绝缘防护装备。',
  freon:
    '削弱大多数形式的能量释放，减缓温度变化。',
} as const;

const moderator_gases_sticky_order = ['plasma', 'bz', 'proto_nitrate'] as const;

const ensure_gases = (gas_array: HypertorusGas[] = [], gasids) => {
  const gases_by_id = {};
  gas_array.forEach((gas) => {
    gases_by_id[gas.id] = true;
  });

  for (const gasid of gasids) {
    if (!gases_by_id[gasid]) {
      gas_array.push({ id: gasid, amount: 0 });
    }
  }
};

const GasList = (props: GasListProps) => {
  const { act, data } = useBackend<GasListData>();
  const {
    input_max,
    input_min,
    input_rate,
    input_switch,
    raw_gases = [],
    minimumScale,
    prepend,
    rateHelp = '',
    stickyGases,
  } = props;
  const { start_power, start_cooling } = data;

  const gases: HypertorusGas[] = sortBy(
    filter(raw_gases, (gas) => gas.amount >= 0.01),
    [(gas) => -gas.amount],
  );

  if (stickyGases) {
    ensure_gases(gases, stickyGases);
  }

  return (
    <LabeledList>
      <LabeledList.Item
        label={
          <>
            <HoverHelp content={rateHelp} />
            注入控制：
          </>
        }
      >
        <Button
          disabled={start_power === 0 || start_cooling === 0}
          icon={data[input_switch] ? 'power-off' : 'times'}
          content={data[input_switch] ? '开启' : '关闭'}
          selected={data[input_switch]}
          onClick={() => act(input_switch)}
        />
        <NumberInput
          animated
          tickWhileDragging
          step={1}
          value={parseFloat(data[input_rate])}
          unit="mol/s"
          minValue={input_min}
          maxValue={input_max}
          onChange={(v) => act(input_rate, { [input_rate]: v })}
        />
      </LabeledList.Item>
      {gases.map((gas) => {
        let labelPrefix;
        if (prepend) {
          labelPrefix = prepend(gas);
        }
        return (
          <LabeledList.Item
            key={gas.id}
            label={
              <>
                {labelPrefix}
                {getGasLabel(gas.id)}:
              </>
            }
          >
            <ProgressBar
              color={getGasColor(gas.id)}
              value={gas.amount}
              minValue={0}
              maxValue={minimumScale}
            >
              {`${toFixed(gas.amount, 2)} 摩尔`}
            </ProgressBar>
          </LabeledList.Item>
        );
      })}
    </LabeledList>
  );
};

export const HypertorusGases = (props) => {
  const { data } = useBackend<HypertorusData>();
  const {
    fusion_gases = [],
    moderator_gases = [],
    selectable_fuel = [],
    selected,
  } = data;

  const selected_fuel = selectable_fuel.filter((d) => d.id === selected)[0];

  return (
    <>
      <Section title="内部聚变气体">
        {selected_fuel ? (
          <GasList
            input_rate="fuel_injection_rate"
            input_switch="start_fuel"
            input_max={150}
            input_min={0.5}
            raw_gases={fusion_gases}
            minimumScale={500}
            prepend={() => <HelpDummy />}
            rateHelp={
              '从燃料输入口添加新燃料的速率。' +
              '此速率会影响生产速度，' +
              '即使未启用输入也是如此。'
            }
            stickyGases={selected_fuel.requirements}
          />
        ) : (
          <Box align="center" color="red">
            {'尚未选择配方'}
          </Box>
        )}
      </Section>
      <Section title="慢化气体">
        <GasList
          input_rate="moderator_injection_rate"
          input_switch="start_moderator"
          input_max={150}
          input_min={0.5}
          raw_gases={moderator_gases}
          minimumScale={500}
          rateHelp={
            '从慢化气体入口添加新慢化气体的速率。'
          }
          stickyGases={moderator_gases_sticky_order}
          prepend={(gas) =>
            moderator_gases_help[gas.id] ? (
              <HoverHelp content={moderator_gases_help[gas.id]} />
            ) : (
              <HelpDummy />
            )
          }
        />
      </Section>
    </>
  );
};
