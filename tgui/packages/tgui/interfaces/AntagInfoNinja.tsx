import { Icon, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Rules } from './AntagInfoRules'; // SKYRAT EDIT ADDITION
import {
  type Objective,
  ObjectivePrintout,
  ReplaceObjectivesButton,
} from './common/Objectives';

const ninja_emphasis = {
  color: 'red',
};

type NinjaInfo = {
  objectives: Objective[];
  can_change_objective: BooleanLike;
};

export const AntagInfoNinja = (props) => {
  const { data } = useBackend<NinjaInfo>();
  const { objectives, can_change_objective } = data;
  return (
    <Window width={550} height={450} theme="hackerman">
      <Window.Content>
        <Icon
          size={30}
          name="spider"
          color="#003300"
          position="absolute"
          top="10%"
          left="10%"
        />
        <Section scrollable fill>
          <Stack vertical textColor="green">
            <Stack.Item textAlign="center" fontSize="20px">
              我是蜘蛛氏族的精英雇佣兵。
              <br />一名<span style={ninja_emphasis}>太空忍者</span>！
            </Stack.Item>
            <Stack.Item textAlign="center" italic>
              出其不意是我的武器，阴影是我的盔甲。没有它们，我
              一无所有。
            </Stack.Item>
            <Stack.Item>
              <Section fill>
                你的先进忍者服装有许多强大的模块。
                <br />右键点击空间站的 APC 或
                其他电源，即可吸取其电量为忍者服充电。
                <br />
                穿着忍者服时，右键点击某些机器或物品
                可以将其入侵，产生不同效果。亲自试试，看看
                你能做到什么！
              </Section>
            </Stack.Item>
            {/* SKYRAT EDIT ADDITION START */}
            <Stack.Item>
              <Rules />
            </Stack.Item>
            {/* SKYRAT EDIT ADDITION END */}
            <Stack.Item>
              <ObjectivePrintout
                objectives={objectives}
                objectiveFollowup={
                  <ReplaceObjectivesButton
                    can_change_objective={can_change_objective}
                    button_title={'调整任务参数'}
                    button_colour={'green'}
                  />
                }
              />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
