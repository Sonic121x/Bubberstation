import { BlockQuote, Button, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Rules } from './AntagInfoRules'; // BUBBER EDIT ADDITION
import { type Objective, ObjectivePrintout } from './common/Objectives';

const allystyle = {
  fontWeight: 'bold',
  color: 'yellow',
};

const badstyle = {
  color: 'red',
  fontWeight: 'bold',
};

const goalstyle = {
  color: 'lightblue',
  fontWeight: 'bold',
};

type Info = {
  has_codewords: BooleanLike;
  phrases: string;
  responses: string;
  theme: string;
  allies: string;
  goal: string;
  intro: string;
  code: string;
  failsafe_code: string;
  has_uplink: BooleanLike;
  uplink_intro: string;
  uplink_unlock_info: string;
  given_uplink: BooleanLike;
  objectives: Objective[];
};

const IntroductionSection = (props) => {
  const { act, data } = useBackend<Info>();
  const { intro, objectives } = data;
  return (
    <Section fill title="简介" scrollable>
      <Stack vertical fill>
        <Stack.Item fontSize="25px">{intro}</Stack.Item>
        <Stack.Item grow>
          <ObjectivePrintout objectives={objectives} />
        </Stack.Item>
        {/* SKYRAT EDIT ADDITION START */}
        <Stack.Item grow>
          {/* SKYRAT EDIT ADDITION START */}
          <Stack.Item>
            <Rules />
          </Stack.Item>
        </Stack.Item>
        {/* SKYRAT EDIT ADDITION END */}
      </Stack>
    </Section>
  );
};

const EmployerSection = (props) => {
  const { data } = useBackend<Info>();
  const { allies, goal } = data;
  return (
    <Section
      fill
      title="雇主"
      scrollable
      buttons={
        <Button
          icon="hammer"
          tooltip={`
            这是给感到无聊的叛徒的玩法建议。
            你不必遵循它，除非你需要一些
            度过本回合的灵感。`}
          tooltipPosition="bottom-start"
        >
          方针
        </Button>
      }
    >
      <Stack vertical fill>
        <Stack.Item grow>
          <Stack vertical>
            <Stack.Item>
              <span style={allystyle}>
                你的效忠对象：
                <br />
              </span>
              <BlockQuote>{allies}</BlockQuote>
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item mb={1}>
              <span style={goalstyle}>
                雇主的想法：
                <br />
              </span>
              <BlockQuote>{goal}</BlockQuote>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const UplinkSection = (props) => {
  const { data } = useBackend<Info>();
  const { has_uplink, uplink_intro, uplink_unlock_info, code, failsafe_code } =
    data;
  return (
    <Section title="上行链路" mb={!has_uplink && -1}>
      <Stack fill>
        {
          <>
            <Stack.Item bold>
              {uplink_intro}
              <br />
              {code && <span style={goalstyle}>密码：{code}</span>}
              <br />
              {failsafe_code && (
                <span style={badstyle}>应急销毁密码：{failsafe_code}</span>
              )}
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item align="center">
              <BlockQuote>{uplink_unlock_info}</BlockQuote>
            </Stack.Item>
          </>
        }
      </Stack>
      <br />
      {
        <Section>
          {' '}
          <br />
          <br />
        </Section>
      }
    </Section>
  );
};

const CodewordsSection = (props) => {
  const { data } = useBackend<Info>();
  const { has_codewords, phrases, responses } = data;
  return (
    <Section title="暗号" mb={!has_codewords && -1}>
      <Stack fill>
        {(!has_codewords && (
          <BlockQuote>
            你没有获得暗号。你必须
            通过其他方式寻找潜在盟友。但请谨慎行动，
            因为任何人都可能是敌人。
          </BlockQuote>
        )) || (
          <>
            <Stack.Item grow basis={0}>
              <BlockQuote>
                雇主为你提供了以下暗号，用于
                识别其他特工。在日常交谈中使用
                暗号，即可辨认同伴。但请谨慎行动，
                因为任何人都可能是敌人。
                <span style={badstyle}>
                  &ensp;你已记住这些暗号，
                  听到时便能辨认出来。
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
};

export const AntagInfoTraitor = (props) => {
  const { data } = useBackend<Info>();
  const { theme, given_uplink } = data;
  return (
    <Window width={620} height={580} theme={theme}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item grow>
            <Stack fill>
              <Stack.Item width="70%">
                <IntroductionSection />
              </Stack.Item>
              <Stack.Item width="30%">
                <EmployerSection />
              </Stack.Item>
            </Stack>
          </Stack.Item>
          {!!given_uplink && (
            <Stack.Item>
              <UplinkSection />
            </Stack.Item>
          )}
          <Stack.Item>
            <CodewordsSection />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
