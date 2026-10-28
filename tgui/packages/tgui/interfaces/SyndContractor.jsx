import { useState } from 'react';
import {
  Box,
  Button,
  Flex,
  Icon,
  LabeledList,
  Modal,
  NoticeBox,
  Section,
  Stack,
  Table,
  Tabs,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import { FakeTerminal } from './common/FakeTerminal';

const CONTRACT_STATUS_INACTIVE = 1;
const CONTRACT_STATUS_ACTIVE = 2;
const CONTRACT_STATUS_BOUNTY_CONSOLE_ACTIVE = 3;
const CONTRACT_STATUS_EXTRACTING = 4;
const CONTRACT_STATUS_COMPLETE = 5;
const CONTRACT_STATUS_ABORTED = 6;

export const SyndContractor = (props) => {
  return (
    <NtosWindow width={500} height={600} theme="syndicate">
      <NtosWindow.Content scrollable>
        <SyndContractorContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const SyndContractorContent = (props) => {
  const { data, act } = useBackend();

  const terminalMessages = [
    '正在记录生物识别数据……',
    '正在分析内嵌辛迪加信息……',
    '身份已确认',
    '正在联系辛迪加数据库……',
    '正在等待响应……',
    '正在等待响应……',
    '正在等待响应……',
    '正在等待响应……',
    '正在等待响应……',
    '正在等待响应……',
    '已收到响应，确认码 4851234……',
    `确认账户 ${Math.round(Math.random() * 20000)}`,
    '正在建立私人账户……',
    '承包商账户已创建',
    '正在搜索可用合同……',
    '正在搜索可用合同……',
    '正在搜索可用合同……',
    '正在搜索可用合同……',
    '已找到合同',
    '欢迎，特工',
  ];

  const infoEntries = [
    '辛迪合同 v2.0',
    '',
    '我们已在你的任务区域内确认了一些',
    '潜在的高价值目标。据推测，他们掌握着',
    '有价值的情报，这些情报可能对我们组织',
    '当前的行动至关重要。',
    '',
    '下方列出了你可以接取的全部合同。你需要',
    '将指定目标带到指定的交接地点，',
    '并通过此上行链路联系我们。我们会派出',
    '专用撤离舱，请将目标装入其中。',
    '',
    '我们需要活着的目标，不过有时也会为尸体',
    '支付少量报酬，只是不会发放所列的',
    '额外奖金。你可以通过此上行链路提取',
    '实物蓝晶作为报酬，并将其装入你的',
    '常规辛迪加上行链路以购买所需物品。',
    '目标送达我们手中时，这些蓝晶就会',
    '立即到账，你可以随时通过此系统',
    '领取。',
    '',
    '被撤离的目标完成其用途后，我们会要求',
    '空间站支付赎金以换回目标，并分给你',
    '少量提成。请小心，他们返回后',
    '可能会认出你。我们提供了',
    '标准承包商装备，可以帮助你隐藏',
    '身份。',
  ];

  const errorPane = !!data.error && (
    <Modal backgroundColor="red">
      <Flex align="center">
        <Flex.Item mr={2}>
          <Icon size={4} name="exclamation-triangle" />
        </Flex.Item>
        <Flex.Item mr={2} grow={1} textAlign="center">
          <Box width="260px" textAlign="left" minHeight="80px">
            {data.error}
          </Box>
          <Button content="关闭" onClick={() => act('PRG_clear_error')} />
        </Flex.Item>
      </Flex>
    </Modal>
  );

  if (!data.logged_in) {
    return (
      <Section minHeight="525px">
        <Box width="100%" textAlign="center">
          <Button
            content="注册用户"
            color="transparent"
            onClick={() => act('PRG_login')}
          />
        </Box>
        {!!data.error && <NoticeBox>{data.error}</NoticeBox>}
      </Section>
    );
  }

  if (data.logged_in && data.first_load) {
    return (
      <Box backgroundColor="rgba(0, 0, 0, 0.8)" minHeight="525px">
        <FakeTerminal
          allMessages={terminalMessages}
          finishedTimeout={3000}
          onFinished={() => act('PRG_set_first_load_finished')}
        />
      </Box>
    );
  }

  if (data.info_screen) {
    return (
      <>
        <Box backgroundColor="rgba(0, 0, 0, 0.8)" minHeight="500px">
          <FakeTerminal allMessages={infoEntries} linesPerSecond={10} />
        </Box>
        <Button
          fluid
          content="继续"
          color="transparent"
          textAlign="center"
          onClick={() => act('PRG_toggle_info')}
        />
      </>
    );
  }

  return (
    <>
      {errorPane}
      <SyndPane />
    </>
  );
};

export const StatusPane = (props) => {
  const { act, data } = useBackend();

  return (
    <Section
      title={
        <>
          承包商状态
          <Button
            content="再次查看说明"
            color="transparent"
            mb={0}
            ml={1}
            onClick={() => act('PRG_toggle_info')}
          />
        </>
      }
      buttons={
        <Box bold mr={1}>
          {data.contract_rep} 声望
        </Box>
      }
    >
      <Stack>
        <Stack.Item grow>
          <LabeledList>
            <LabeledList.Item
              label="可领取蓝晶"
              buttons={
                <Button
                  content="领取"
                  disabled={data.redeemable_tc <= 0}
                  onClick={() => act('PRG_redeem_TC')}
                />
              }
            >
              {String(data.redeemable_tc)}
            </LabeledList.Item>
            <LabeledList.Item label="已赚取蓝晶">
              {String(data.earned_tc)}
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
        <Stack.Item grow>
          <LabeledList>
            <LabeledList.Item label="已完成合同">
              {String(data.contracts_completed)}
            </LabeledList.Item>
            <LabeledList.Item label="当前状态">活跃</LabeledList.Item>
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

export const SyndPane = (props) => {
  const [tab, setTab] = useState(1);
  return (
    <>
      <StatusPane state={props.state} />
      <Tabs>
        <Tabs.Tab selected={tab === 1} onClick={() => setTab(1)}>
          合同
        </Tabs.Tab>
        <Tabs.Tab selected={tab === 2} onClick={() => setTab(2)}>
          中心
        </Tabs.Tab>
      </Tabs>
      {tab === 1 && <ContractsTab />}
      {tab === 2 && <HubTab />}
    </>
  );
};

const ContractsTab = (props) => {
  const { act, data } = useBackend();
  const contracts = data.contracts || [];
  return (
    <>
      <Section
        title="可用合同"
        buttons={
          <Button
            content="呼叫撤离"
            disabled={!data.ongoing_contract || data.extraction_enroute}
            onClick={() => act('PRG_call_extraction')}
          />
        }
      >
        {contracts.map((contract) => {
          if (
            data.ongoing_contract &&
            contract.status !== CONTRACT_STATUS_ACTIVE
          ) {
            return CONTRACT_STATUS_INACTIVE;
          }
          const active = contract.status > CONTRACT_STATUS_INACTIVE;
          if (contract.status >= CONTRACT_STATUS_COMPLETE) {
            return CONTRACT_STATUS_COMPLETE;
          }
          return (
            <Section
              key={contract.target}
              title={
                contract.target
                  ? `${contract.target} (${contract.target_rank})`
                  : '无效目标'
              }
              level={active ? 1 : 2}
              buttons={
                <>
                  <Box inline bold mr={1}>
                    {`${contract.payout}（+${contract.payout_bonus}）蓝晶`}
                  </Box>
                  <Button
                    content={active ? '中止' : '接受'}
                    disabled={contract.extraction_enroute}
                    color={active && 'bad'}
                    onClick={() =>
                      act(`PRG_contract${active ? '_abort' : '-accept'}`, {
                        contract_id: contract.id,
                      })
                    }
                  />
                </>
              }
            >
              <NoticeBox>
                <box>{contract.message}</box>
                <Box bold mb={1}>
                  交接地点：
                </Box>
                <Box>{contract.dropoff}</Box>
              </NoticeBox>
            </Section>
          );
        })}
      </Section>
      <Section
        title="交接地点定位器"
        textAlign="center"
        opacity={data.ongoing_contract ? 100 : 0}
      >
        <Box bold>{data.dropoff_direction}</Box>
      </Section>
    </>
  );
};

const HubTab = (props) => {
  const { act, data } = useBackend();
  const contractor_hub_items = data.contractor_hub_items || [];
  return (
    <Section>
      {contractor_hub_items.map((item) => {
        const repInfo = item.cost ? `${item.cost} 声望` : '免费';
        const limited = item.limited !== -1;
        return (
          <Section
            key={item.name}
            title={`${item.name} - ${repInfo}`}
            level={2}
            buttons={
              <>
                {limited && (
                  <Box inline bold mr={1}>
                    剩余 {item.limited}
                  </Box>
                )}
                <Button
                  content="购买"
                  disabled={
                    data.contract_rep < item.cost ||
                    (limited && item.limited <= 0)
                  }
                  onClick={() =>
                    act('buy_hub', {
                      item: item.name,
                      cost: item.cost,
                    })
                  }
                />
              </>
            }
          >
            <Table>
              <Table.Row>
                <Table.Cell>
                  <Icon fontSize="60px" name={item.item_icon} />
                </Table.Cell>
                <Table.Cell verticalAlign="top">{item.desc}</Table.Cell>
              </Table.Row>
            </Table>
          </Section>
        );
      })}
    </Section>
  );
};
