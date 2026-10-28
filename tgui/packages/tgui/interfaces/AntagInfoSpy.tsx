import { Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import {
  type Objective,
  ObjectivePrintout,
  ReplaceObjectivesButton,
} from './common/Objectives';

const greenText = {
  fontWeight: 'italics',
  color: '#20b142',
};

const redText = {
  fontWeight: 'italics',
  color: '#e03c3c',
};

type Data = {
  antag_name: string;
  uplink_location: string | null;
  objectives: Objective[];
  can_change_objective: BooleanLike;
};

export const AntagInfoSpy = () => {
  const { data } = useBackend<Data>();
  const { antag_name, uplink_location, objectives, can_change_objective } =
    data;
  return (
    <Window width={380} height={450} theme="ntos_darkmode">
      <Window.Content
        style={{
          backgroundImage: 'none',
        }}
      >
        <Section title={`你是${antag_name || '间谍'}。`}>
          <Stack vertical fill ml={1} mr={1}>
            <Stack.Item fontSize={1.2}>
              你配备了一台伪装成{' '}
              {uplink_location || '某件物品'}的特殊上行链路，能让你从
              空间站窃取物品。
            </Stack.Item>
            <Stack.Item>
              <span style={greenText}>
                <b>手持时激活</b>即可打开上行链路，并可{' '}
                <b>右键点击</b>悬赏目标将其窃取。
              </span>
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item>
              你可能并非孤身一人：空间站上也许还有其他间谍。
            </Stack.Item>
            <Stack.Item>
              与他们合作还是对抗，由你决定。但{' '}
              <span style={redText}>
                同一项悬赏无法领取两次。
              </span>
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item>
              <ObjectivePrintout
                titleMessage={'如果你选择接受，这是你的任务'}
                objectives={objectives}
              />
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item textAlign="center">
              {
                <ReplaceObjectivesButton
                  can_change_objective={can_change_objective}
                  button_title={'制定自己的计划'}
                  button_colour={'green'}
                />
              }
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
