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
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import { FakeTerminal } from './common/FakeTerminal';

enum CONTRACT {
  Inactive = 1,
  Active = 2,
  Complete = 5,
}

type Data = {
  contracts_completed: number;
  contracts: ContractData[];
  dropoff_direction: string;
  earned_tc: number;
  error: string;
  extraction_enroute: BooleanLike;
  first_load: BooleanLike;
  info_screen: BooleanLike;
  logged_in: BooleanLike;
  ongoing_contract: BooleanLike;
  redeemable_tc: number;
};

type ContractData = {
  contract: string;
  dropoff: string;
  extraction_enroute: BooleanLike;
  id: number;
  message: string;
  payout_bonus: number;
  payout: number;
  status: number;
  target_rank: string;
  target: string;
};

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
] as const;

export function SyndicateContractor(props) {
  return (
    <NtosWindow width={500} height={600}>
      <NtosWindow.Content scrollable>
        <SyndicateContractorContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
}

function SyndicateContractorContent(props) {
  const { data, act } = useBackend<Data>();
  const { error, logged_in, first_load, info_screen } = data;

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
  ] as const;

  const errorPane = !!error && (
    <Modal backgroundColor="red">
      <Flex align="center">
        <Flex.Item mr={2}>
          <Icon size={4} name="exclamation-triangle" />
        </Flex.Item>
        <Flex.Item mr={2} grow={1} textAlign="center">
          <Box width="260px" textAlign="left" minHeight="80px">
            {error}
          </Box>
          <Button onClick={() => act('PRG_clear_error')}>关闭</Button>
        </Flex.Item>
      </Flex>
    </Modal>
  );

  if (!logged_in) {
    return (
      <Section minHeight="525px">
        <Box width="100%" textAlign="center">
          <Button color="transparent" onClick={() => act('PRG_login')}>
            注册用户
          </Button>
        </Box>
        {!!error && <NoticeBox>{error}</NoticeBox>}
      </Section>
    );
  }

  if (logged_in && first_load) {
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

  if (info_screen) {
    return (
      <>
        <Box backgroundColor="rgba(0, 0, 0, 0.8)" minHeight="500px">
          <FakeTerminal allMessages={infoEntries} linesPerSecond={10} />
        </Box>
        <Button
          fluid
          color="transparent"
          textAlign="center"
          onClick={() => act('PRG_toggle_info')}
        >
          继续
        </Button>
      </>
    );
  }

  return (
    <>
      {errorPane}
      <StatusPane state={props.state} />
      <ContractsTab />
    </>
  );
}

function StatusPane(props) {
  const { act, data } = useBackend<Data>();
  const { redeemable_tc, earned_tc, contracts_completed } = data;

  return (
    <Section
      buttons={
        <Button
          color="transparent"
          mb={0}
          ml={1}
          onClick={() => act('PRG_toggle_info')}
        >
          再次查看说明
        </Button>
      }
      title="承包商状态"
    >
      <Stack>
        <Stack.Item grow>
          <LabeledList>
            <LabeledList.Item
              label="可领取蓝晶"
              buttons={
                <Button
                  disabled={redeemable_tc <= 0}
                  onClick={() => act('PRG_redeem_TC')}
                >
                  领取
                </Button>
              }
            >
              {String(redeemable_tc)}
            </LabeledList.Item>
            <LabeledList.Item label="已赚取蓝晶">
              {String(earned_tc)}
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
        <Stack.Item grow>
          <LabeledList>
            <LabeledList.Item label="已完成合同">
              {String(contracts_completed)}
            </LabeledList.Item>
            <LabeledList.Item label="当前状态">活跃</LabeledList.Item>
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
}

function ContractsTab(props) {
  const { act, data } = useBackend<Data>();
  const {
    contracts = [],
    ongoing_contract,
    extraction_enroute,
    dropoff_direction,
  } = data;

  return (
    <>
      <Section
        title="可用合同"
        buttons={
          <Button
            disabled={!ongoing_contract || !!extraction_enroute}
            onClick={() => act('PRG_call_extraction')}
          >
            呼叫撤离
          </Button>
        }
      >
        {contracts.map((contract) => {
          if (ongoing_contract && contract.status !== CONTRACT.Active) {
            return null;
          }
          const active = contract.status > CONTRACT.Inactive;
          if (contract.status >= CONTRACT.Complete) {
            return null;
          }
          return (
            <Section
              key={contract.target}
              title={
                contract.target
                  ? `${contract.target} (${contract.target_rank})`
                  : '无效目标'
              }
              buttons={
                <>
                  <Box inline bold mr={1}>
                    {`${contract.payout}（+${contract.payout_bonus}）蓝晶`}
                  </Box>
                  <Button
                    disabled={!!contract.extraction_enroute}
                    color={active && 'bad'}
                    onClick={() =>
                      act(`PRG_contract${active ? '_abort' : '-accept'}`, {
                        contract_id: contract.id,
                      })
                    }
                  >
                    {active ? '中止' : '接受'}
                  </Button>
                </>
              }
            >
              <Stack>
                <Stack.Item grow>{contract.message}</Stack.Item>
                <Stack.Item>
                  <Box bold mb={1}>
                    交接地点：
                  </Box>
                  <Box>{contract.dropoff}</Box>
                </Stack.Item>
              </Stack>
            </Section>
          );
        })}
      </Section>
      <Section
        title="交接地点定位器"
        textAlign="center"
        opacity={ongoing_contract ? 100 : 0}
      >
        <Box bold>{dropoff_direction}</Box>
      </Section>
    </>
  );
}
