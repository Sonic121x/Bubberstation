import { useBackend } from 'tgui/backend';
import {
  Box,
  Input,
  LabeledList,
  Section,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import { capitalizeFirst, decodeHtmlEntities } from 'tgui-core/string';

import { getColor } from './helpers';
import type { Data } from './types';

/**
 * Displays info about the virus. Child elements display
 * the virus's traits and descriptions.
 */
export const VirusDisplay = (props) => {
  const { virus } = props;

  return (
    <Stack fill>
      <Stack.Item grow={3}>
        <Info virus={virus} />
      </Stack.Item>
      {virus.is_adv && (
        <>
          <Stack.Divider />
          <Stack.Item grow={1}>
            <Traits virus={virus} />
          </Stack.Item>
        </>
      )}
    </Stack>
  );
};

/** Displays the description, name and other info for the virus. */
const Info = (props) => {
  const { act } = useBackend<Data>();
  const {
    virus: { agent, can_rename, description, index, name, spread },
  } = props;

  return (
    <LabeledList>
      <LabeledList.Item label="名称">
        {can_rename ? (
          <Input
            placeholder="输入名称"
            value={name === 'Unknown' || name === '未知' ? '' : name}
            onBlur={(value) =>
              act('rename_disease', {
                index: index,
                name: value,
              })
            }
          />
        ) : (
          <Box color="bad">{decodeHtmlEntities(name)}</Box>
        )}
      </LabeledList.Item>
      <LabeledList.Item label="描述">{description}</LabeledList.Item>
      <LabeledList.Item label="病原体">
        {capitalizeFirst(agent)}
      </LabeledList.Item>
      <LabeledList.Item label="传播方式">{spread}</LabeledList.Item>
    </LabeledList>
  );
};

/**
 * Displays the traits of the virus. This could be iterated over
 * with object.keys but you would need a helper function for the tooltips.
 * I would rather hard code it here.
 */
const Traits = (props) => {
  const {
    virus: { resistance, stage_speed, stealth, transmission, severity },
  } = props;

  return (
    <Section title="属性">
      <LabeledList>
        <Tooltip content="抵抗治疗和自然康复的能力。">
          <LabeledList.Item color={getColor(resistance)} label="抗性">
            {resistance}
          </LabeledList.Item>
        </Tooltip>
        <Tooltip content="症状发展的速度。">
          <LabeledList.Item color={getColor(stage_speed)} label="阶段速度">
            {stage_speed}
          </LabeledList.Item>
        </Tooltip>
        <Tooltip content="医疗设备检测到疾病的难度。">
          <LabeledList.Item color={getColor(stealth)} label="隐蔽性">
            {stealth}
          </LabeledList.Item>
        </Tooltip>
        <Tooltip content="决定传播方式。">
          <LabeledList.Item
            color={getColor(transmission)}
            label="传播性"
          >
            {transmission}
          </LabeledList.Item>
        </Tooltip>
        <Tooltip content="疾病的总体危险程度。">
          <LabeledList.Item
            color={getColor(severity)}
            label="严重程度"
          >
            {severity}
          </LabeledList.Item>
        </Tooltip>
      </LabeledList>
    </Section>
  );
};
