import { useBackend } from 'tgui/backend';
import {
  Box,
  Button,
  Icon,
  Knob,
  LabeledControls,
  LabeledList,
  NumberInput,
  Section,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import type { HypertorusFilter } from '.';
import { HelpDummy, HoverHelp } from './helpers';

type ComboProps = {
  color?: string | BooleanLike;
  defaultValue: number;
  flipIcon?: BooleanLike;
  help?: string;
  icon?: string;
  maxValue: number;
  minValue: number;
  parameter: string;
  step?: number;
  unit: string;
  value: number;
};

type ControlsData = {
  cooling_volume: number;
  current_damper: number;
  heat_output: number;
  heating_conductor: number;
  magnetic_constrictor: number;
};

type WasteData = {
  filter_types: HypertorusFilter[];
  mod_filtering_rate: number;
  waste_remove: BooleanLike;
};

/*
 * This module holds user interactable controls. Some may be good candidates
 * for generalizing and refactoring.
 */
const ComboKnob = (props: ComboProps) => {
  const {
    color = false,
    defaultValue,
    flipIcon,
    help,
    icon,
    maxValue,
    minValue,
    parameter,
    step = 5,
    value,
    ...rest
  } = props;

  const { act } = useBackend();

  const iconProps = {
    rotation: 0,
  };
  if (flipIcon) {
    iconProps.rotation = 180;
  }

  const icon_element = icon && (
    <Icon
      position="absolute"
      top="16px"
      left="-27px"
      color="label"
      fontSize="200%"
      name={icon}
      {...iconProps}
    />
  );

  return (
    <Box position="relative" left="2px">
      {help ? <Tooltip content={help}>{icon_element}</Tooltip> : icon_element}
      <Knob
        color={color}
        size={2}
        value={value}
        minValue={minValue}
        maxValue={maxValue}
        step={step}
        stepPixelSize={1}
        onChange={(_, v) => act(parameter, { [parameter]: v })}
        {...rest}
      />
      <Button
        fluid
        position="absolute"
        top="-2px"
        right="-20px"
        color="transparent"
        icon="fast-forward"
        onClick={() => act(parameter, { [parameter]: maxValue })}
      />
      <Button
        fluid
        position="absolute"
        top="16px"
        right="-20px"
        color="transparent"
        icon="undo"
        onClick={() => act(parameter, { [parameter]: defaultValue })}
      />
      <Button
        fluid
        position="absolute"
        top="34px"
        right="-20px"
        color="transparent"
        icon="fast-backward"
        onClick={() => act(parameter, { [parameter]: minValue })}
      />
    </Box>
  );
};

export const HypertorusSecondaryControls = (props) => {
  const { data } = useBackend<ControlsData>();
  const {
    cooling_volume,
    current_damper,
    heat_output,
    heating_conductor,
    magnetic_constrictor,
  } = data;

  return (
    <Section title="反应堆控制">
      <LabeledControls justify="space-around" wrap>
        <LabeledControls.Item label="加热导体">
          <ComboKnob
            color={heating_conductor > 50 && heat_output > 0 && 'yellow'}
            value={heating_conductor}
            unit="J/cm"
            minValue={50}
            defaultValue={100}
            maxValue={500}
            parameter="heating_conductor"
            icon="fire"
            help="调整聚变反应升温或降温的速率。较高的加热值能提高产量，但有引发反应失控的风险。"
          />
        </LabeledControls.Item>
        <LabeledControls.Item label="冷却容积">
          <ComboKnob
            value={cooling_volume}
            unit="L"
            minValue={50}
            defaultValue={100}
            maxValue={2000}
            parameter="cooling_volume"
            step={25}
            icon="snowflake-o"
            help="调整 HFR 核心内部的冷却空间。较小的空间会降低内部冷却能力，但能将大部分冷却剂移到核心外，在无需使用时快速冷却。"
          />
        </LabeledControls.Item>
        <LabeledControls.Item label="磁约束器">
          <ComboKnob
            value={magnetic_constrictor}
            unit="m³/T"
            minValue={50}
            defaultValue={100}
            maxValue={1000}
            parameter="magnetic_constrictor"
            icon="magnet"
            flipIcon
            help="调整聚变反应的密度。密度更高的反应会释放更多能量，但参与反应的质量过大时可能导致反应失稳。"
          />
        </LabeledControls.Item>
        <LabeledControls.Item label="电流阻尼器">
          <ComboKnob
            color={current_damper && 'yellow'}
            value={current_damper}
            unit="W"
            minValue={0}
            defaultValue={0}
            maxValue={1000}
            parameter="current_damper"
            icon="sun-o"
            help="使反应失稳。反应充分失稳后会停止生产并转为吸热，从而冷却聚变混合物。含铁量较高的反应更难失稳。"
          />
        </LabeledControls.Item>
      </LabeledControls>
    </Section>
  );
};

export const HypertorusWasteRemove = (props) => {
  const { act, data } = useBackend<WasteData>();
  const { filter_types = [], waste_remove, mod_filtering_rate } = data;

  return (
    <Section title="输出控制">
      <LabeledList>
        <LabeledList.Item
          label={
            <>
              <HoverHelp
                content={
                  '从聚变混合物中排出废气，' +
                  '并从慢化混合物中排出选定的气体。'
                }
              />
              废气排出：
            </>
          }
        >
          <Button
            icon={waste_remove ? 'power-off' : 'times'}
            content={waste_remove ? '开启' : '关闭'}
            selected={waste_remove}
            onClick={() => act('waste_remove')}
          />
        </LabeledList.Item>
        <LabeledList.Item
          label={
            <>
              <HelpDummy />
              慢化气体过滤速率：
            </>
          }
        >
          <NumberInput
            animated
            tickWhileDragging
            value={mod_filtering_rate}
            unit="mol/s"
            step={1}
            minValue={5}
            maxValue={200}
            onChange={(value) =>
              act('mod_filtering_rate', {
                mod_filtering_rate: value,
              })
            }
          />
        </LabeledList.Item>
        <LabeledList.Item
          label={
            <>
              <HelpDummy />
              从慢化混合物中过滤：
            </>
          }
        >
          {filter_types.map(({ gas_id, gas_name, enabled }) => (
            <Button.Checkbox
              key={gas_id}
              checked={enabled}
              onClick={() =>
                act('filter', {
                  mode: gas_id,
                })
              }
            >
              {gas_name}
            </Button.Checkbox>
          ))}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
