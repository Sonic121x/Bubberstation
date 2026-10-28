import { Box, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Rules } from './AntagInfoRules'; // SKYRAT EDIT ADDITION
import {
  type Objective,
  ObjectivePrintout,
  ReplaceObjectivesButton,
} from './common/Objectives';

const teleportstyle = {
  color: 'yellow',
};

const robestyle = {
  color: 'lightblue',
};

const destructionstyle = {
  color: 'red',
};

const defensestyle = {
  color: 'orange',
};

const transportstyle = {
  color: 'yellow',
};

const summonstyle = {
  color: 'cyan',
};

const ritualstyle = {
  color: 'violet',
};

const grandritualstyle = {
  fontWeight: 'bold',
  color: '#bd54e0',
};

type GrandRitual = {
  remaining: number;
  next_area: string;
};

type Info = {
  objectives: Objective[];
  ritual: GrandRitual;
  can_change_objective: BooleanLike;
};

// SKYRAT EDIT CHANGE - height from 630 to 700
export const AntagInfoWizard = (props) => {
  const { data, act } = useBackend<Info>();
  const { ritual, objectives, can_change_objective } = data;

  return (
    <Window width={620} height={700} theme="wizard">
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item grow>
            <Section scrollable fill>
              <Stack vertical>
                <Stack.Item textColor="red" fontSize="20px">
                  你是太空巫师！
                </Stack.Item>
                <Stack.Item>
                  <ObjectivePrintout
                    objectives={objectives}
                    titleMessage="太空巫师联邦向你下达了以下任务："
                    objectiveFollowup={
                      <ReplaceObjectivesButton
                        can_change_objective={can_change_objective}
                        button_title={'宣布个人任务'}
                        button_colour={'violet'}
                      />
                    }
                  />
                </Stack.Item>
                <Stack.Item>
                  <RitualPrintout ritual={ritual} />
                </Stack.Item>
                {/* SKYRAT EDIT ADDITION START */}
                <Stack.Item>
                  <Rules />
                </Stack.Item>
                {/* SKYRAT EDIT ADDITION END */}
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section fill title="法术书">
              <Stack vertical fill>
                <Stack.Item>
                  你拥有一本与你绑定的法术书。你可以用它
                  选择一套法术。
                  <br />
                  <span style={destructionstyle}>
                    致命法术页提供进攻法术，用于消灭
                    敌人。
                  </span>
                  <br />
                  <span style={defensestyle}>
                    防御法术页提供防御法术，帮助你
                    生存。记住，你或许很强大，但仍然只是
                    凡人。
                  </span>
                  <br />
                  <span style={transportstyle}>
                    移动法术页提供机动法术，
                    对于保命和完成任务非常重要。
                  </span>
                  <br />
                  <span style={summonstyle}>
                    召唤法术页提供召唤及其他辅助法术，
                    让你不必孤军奋战。但要小心，并非所有召唤物
                    都站在你这一边。
                  </span>
                  <br />
                  <span style={ritualstyle}>
                    仪式页提供强大的全局效果，可以让
                    空间站陷入内斗。请注意，这些仪式要么
                    耗费巨大，要么只是为了炫耀。
                  </span>
                </Stack.Item>
                <Stack.Item textColor="lightgreen">
                  （如果你不知道该选什么，或刚加入联邦，
                  请前往“巫师认可的配置”部分。
                  在那里，你会找到一些很适合新手
                  巫师的组合。）
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="其他装备">
              <Stack>
                <Stack.Item>
                  <span style={teleportstyle}>传送卷轴：</span>可使用 4 次，
                  将你传送到想去的地方。你无法返回
                  巫师巢穴，因此请在出发前
                  做好一切准备。
                  <br />
                  <span style={robestyle}>巫师长袍：</span>施放大多数
                  法术所必需。法术书会告诉你哪些法术
                  必须穿着法袍才能施放。
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section textAlign="center" textColor="red" fontSize="20px">
              记住：别忘了准备你的法术。
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const RitualPrintout = (props: { ritual: GrandRitual }) => {
  const { ritual } = props;
  if (!ritual.next_area) {
    return null;
  }
  return (
    <Box>
      或者，在数个能量汇聚点激活仪式法阵，完成{' '}
      <span style={grandritualstyle}>宏大仪式</span>
      。
      <br />
      你还必须完成
      <span style={grandritualstyle}> {ritual.remaining}</span> 次仪式。
      <br />
      你的下一个仪式地点是
      <span style={grandritualstyle}> {ritual.next_area}</span>。
    </Box>
  );
};
