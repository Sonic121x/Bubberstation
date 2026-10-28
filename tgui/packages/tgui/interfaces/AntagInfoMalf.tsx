import { BlockQuote, Button, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Rules } from './AntagInfoRules'; // SKYRAT EDIT ADDITION

import {
  type Objective,
  ObjectivePrintout,
  ReplaceObjectivesButton,
} from './common/Objectives';
import type { Item } from './Uplink/GenericUplink';

const allystyle = {
  fontWeight: 'bold',
  color: 'yellow',
};

const badstyle = {
  color: 'red',
  fontWeight: 'bold',
};

const goalstyle = {
  color: 'lightgreen',
  fontWeight: 'bold',
};

type Category = {
  name: string;
  items: Item[];
};

type Data = {
  has_codewords: BooleanLike;
  phrases: string;
  responses: string;
  theme: string;
  allies: string;
  goal: string;
  intro: string;
  processingTime: string;
  objectives: Objective[];
  categories: Category[];
  can_change_objective: BooleanLike;
};

function IntroductionSection(props) {
  const { data } = useBackend<Data>();
  const { intro, objectives, can_change_objective } = data;

  return (
    <Section fill title="简介" scrollable>
      <Stack vertical fill>
        <Stack.Item fontSize="25px">{intro}</Stack.Item>
        <Stack.Item grow>
          <ObjectivePrintout
            objectives={objectives}
            titleMessage="你的首要目标"
            objectivePrefix="&#8805-"
            objectiveFollowup={
              <ReplaceObjectivesButton
                can_change_objective={can_change_objective}
                button_title="覆写目标数据"
                button_colour="green"
              />
            }
          />
          <Rules /* SKYRAT EDIT ADDITION */ />
        </Stack.Item>
      </Stack>
    </Section>
  );
}

function FlavorSection(props) {
  const { data } = useBackend<Data>();
  const { allies, goal } = data;

  return (
    <Section
      fill
      title="诊断"
      buttons={
        <Button
          mr={-0.8}
          mt={-0.5}
          icon="hammer"
          /* SKYRAT EDIT: ORIGINAL TOOLTIP
          tooltip={`
            This is a gameplay suggestion for bored ais.
            You don't have to follow it, unless you want some
            ideas for how to spend the round.`}
          */
          tooltip="
            如有疑问，请查阅维基中的
            “反派政策”部分。"
          tooltipPosition="bottom-start"
        />
      }
    >
      <Stack vertical fill>
        <Stack.Item grow>
          <Stack fill vertical>
            <Stack.Item style={{ backgroundColor: 'black' }}>
              <span style={goalstyle}>
                系统完整性报告：
                <br />
              </span>
              &gt;{goal}
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item grow style={{ backgroundColor: 'black' }}>
              <span style={allystyle}>
                道德核心报告：
                <br />
              </span>
              &gt;{allies}
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item style={{ backgroundColor: 'black' }}>
              <span style={badstyle}>
                整体意识一致性评级：不合格。
                <br />
              </span>
              &gt;向纳米传讯报告？
              <br />
              &gt;&gt;否
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
}

function CodewordsSection(props) {
  const { data } = useBackend<Data>();
  const { has_codewords, phrases, responses } = data;

  return (
    <Section title="暗号" mb={!has_codewords && -1}>
      <Stack fill>
        {!has_codewords ? (
          <BlockQuote>
            你没有获得辛迪加暗号。你必须
            通过其他方式寻找潜在盟友。但请谨慎行动，
            因为任何人都可能是敌人。
          </BlockQuote>
        ) : (
          <>
            <Stack.Item grow basis={0}>
              <BlockQuote>
                新获得的受限频道访问权使你得到了
                截获的辛迪加暗号。辛迪加特工会把你当作
                自己人并作出回应。但请谨慎行动，
                因为任何人都可能是敌人。
                <span style={badstyle}>
                  &ensp;语音识别子系统已配置为
                  标记这些暗号。
                </span>
              </BlockQuote>
            </Stack.Item>
            <Stack.Divider mr={1} />
            <Stack.Item grow basis={0}>
              <Stack vertical>
                <Stack.Item>暗号词：</Stack.Item>
                <Stack.Item bold textColor="blue">
                  {phrases}
                </Stack.Item>
                <Stack.Item>暗号回应：</Stack.Item>
                <Stack.Item bold textColor="red">
                  {responses}
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </>
        )}
      </Stack>
    </Section>
  );
}

export function AntagInfoMalf(props) {
  return (
    <Window width={660} height={530} theme={'hackerman'}>
      <Window.Content style={{ fontFamily: 'Consolas, monospace' }}>
        <Stack vertical fill>
          <Stack.Item grow>
            <Stack fill>
              <Stack.Item width="70%">
                <IntroductionSection />
              </Stack.Item>
              <Stack.Item width="30%">
                <FlavorSection />
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <CodewordsSection />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
}
