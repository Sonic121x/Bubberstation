import {
  Box,
  Button,
  Flex,
  LabeledList,
  NoticeBox,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

export const NtosCivCargoHoldTerminal = (props) => {
  const { act, data } = useBackend();
  const { status_report, id_inserted, id_bounty_info, picking } = data;
  const in_text = '欢迎您，尊敬的员工。';
  const out_text = '请将身份卡插入控制台以开始。';
  return (
    <NtosWindow width={580} height={375}>
      <NtosWindow.Content scrollable>
        <Flex>
          <Flex.Item grow>
            <NoticeBox color={!id_inserted ? 'default' : 'blue'}>
              {id_inserted ? in_text : out_text}
            </NoticeBox>
            <Section
              title="悬赏选择"
              buttons={
                <Button
                  icon={id_bounty_info ? 'recycle' : 'pen'}
                  color={id_bounty_info ? 'green' : 'default'}
                  tooltip={id_bounty_info ? '更换悬赏' : '新悬赏'}
                  disabled={!id_inserted}
                  onClick={() => act('bounty')}
                />
              }
            >
              <LabeledList>
                <LabeledList.Item label="货运报告">
                  {status_report}
                </LabeledList.Item>
              </LabeledList>
            </Section>
            {picking ? <BountyPickBox /> : <BountyTextBox />}
          </Flex.Item>
        </Flex>
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const BountyTextBox = (props) => {
  const { data } = useBackend();
  const { id_bounty_info, id_bounty_value, id_bounty_num } = data;
  const na_text = '无，请添加新悬赏。';
  return (
    <Section title="悬赏信息">
      <LabeledList>
        <LabeledList.Item label="描述">
          {id_bounty_info ? id_bounty_info : na_text}
        </LabeledList.Item>
        <LabeledList.Item label="数量">
          {id_bounty_info ? id_bounty_num : '不适用'}
        </LabeledList.Item>
        <LabeledList.Item label="价值">
          {id_bounty_info ? id_bounty_value : '不适用'}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const BountyPickBox = (props) => {
  const { act, data } = useBackend();
  const { id_bounty_names, id_bounty_infos, id_bounty_values } = data;
  return (
    <Section title="请选择悬赏：" textAlign="center">
      <Flex width="100%" wrap>
        <Flex.Item shrink={0} grow={0.5}>
          <BountyPickButton
            bounty_name={id_bounty_names[0]}
            bounty_info={id_bounty_infos[0]}
            bounty_value={id_bounty_values[0]}
            pick_value={1}
            act={act}
          />
        </Flex.Item>
        <Flex.Item shrink={0} grow={0.5} px={1}>
          <BountyPickButton
            bounty_name={id_bounty_names[1]}
            bounty_info={id_bounty_infos[1]}
            bounty_value={id_bounty_values[1]}
            pick_value={2}
            act={act}
          />
        </Flex.Item>
        <Flex.Item shrink={0} grow={0.5}>
          <BountyPickButton
            bounty_name={id_bounty_names[2]}
            bounty_info={id_bounty_infos[2]}
            bounty_value={id_bounty_values[2]}
            pick_value={3}
            act={act}
          />
        </Flex.Item>
      </Flex>
    </Section>
  );
};

const BountyPickButton = (props) => {
  return (
    <Button
      fluid
      color="green"
      onClick={() => props.act('pick', { value: props.pick_value })}
      style={{
        display: 'flex',
        textWrap: 'wrap',
        whiteSpace: 'normal',
        paddingLeft: '0',
        paddingRight: '0',
      }}
    >
      <Box>{props.bounty_name}</Box>
      <Box
        textAlign="left"
        color="black"
        backgroundColor="linen"
        lineHeight="1.2em"
        p={1}
      >
        {props.bounty_info}
      </Box>
      <Box>报酬：{props.bounty_value} 信用点</Box>
    </Button>
  );
};
