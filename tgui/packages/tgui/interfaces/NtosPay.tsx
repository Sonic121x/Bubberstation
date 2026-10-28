import { useState } from 'react';
import {
  Box,
  Button,
  Divider,
  Input,
  NoticeBox,
  RestrictedInput,
  Section,
  Stack,
  Table,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

type Data = {
  name: string;
  owner_token: string;
  money: number;
  transaction_list: Transactions[];
  wanted_token: string;
};

type Transactions = {
  adjusted_money: number;
  reason: string;
};

export const NtosPay = (props) => {
  return (
    <NtosWindow width={495} height={655}>
      <NtosWindow.Content>
        <NtosPayContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const NtosPayContent = (props) => {
  const { data } = useBackend<Data>();
  const { name } = data;

  if (!name) {
    return (
      <NoticeBox>
        您需要将身份卡插入卡槽，
        才能使用此应用。
      </NoticeBox>
    );
  }

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Introduction />
      </Stack.Item>
      <Stack.Item>
        <TransferSection />
      </Stack.Item>
      <Stack.Item grow>
        <TransactionHistory />
      </Stack.Item>
    </Stack>
  );
};

/** Displays the user's name and balance. */
const Introduction = (props) => {
  const { data } = useBackend<Data>();
  const { name, owner_token, money } = data;
  return (
    <Section textAlign="center">
      <Table>
        <Table.Row>您好，{name}。</Table.Row>
        <Table.Row>您的支付识别码是 {owner_token}。</Table.Row>
        <Table.Row>
          账户余额：{money} 信用点
        </Table.Row>
      </Table>
    </Section>
  );
};

/** Displays the transfer section. */
const TransferSection = (props) => {
  const { act, data } = useBackend<Data>();
  const { money, wanted_token } = data;

  const [token, setToken] = useState('');
  const [moneyToSend, setMoneyToSend] = useState(1);
  const [nameToToken, setNameToToken] = useState('');
  const [moneyToSendIsValid, setMoneyToSendIsValid] = useState(true);

  return (
    <Stack>
      <Stack.Item>
        <Section title="转账">
          <Box>
            <Tooltip
              content="输入您要转入信用点的账户的支付识别码。"
              position="top"
            >
              <Input
                placeholder="支付识别码"
                width="190px"
                onChange={setToken}
              />
            </Tooltip>
          </Box>
          <Tooltip
            content="输入要转账的信用点金额。"
            position="top"
          >
            <RestrictedInput
              width="83px"
              minValue={1}
              maxValue={money}
              onChange={setMoneyToSend}
              onValidationChange={setMoneyToSendIsValid}
              value={moneyToSend}
            />
          </Tooltip>
          <Button
            disabled={!moneyToSendIsValid}
            onClick={() =>
              act('Transaction', {
                token: token,
                amount: moneyToSend,
              })
            }
          >
            转出信用点
          </Button>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="查询支付识别码" width="270px" height="98px">
          <Box>
            <Input
              placeholder="账户持有人全名。"
              width="190px"
              onChange={setNameToToken}
            />
            <Button
              onClick={() =>
                act('GetPayToken', {
                  wanted_name: nameToToken,
                })
              }
            >
              查询
            </Button>
          </Box>
          <Divider hidden />
          <Box nowrap>{wanted_token}</Box>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

/** Displays the transaction history. */
const TransactionHistory = (props) => {
  const { data } = useBackend<Data>();
  const { transaction_list = [] } = data;

  return (
    <Section fill title="交易记录">
      <Section fill scrollable title={<TableHeaders />}>
        <Table>
          {transaction_list.map((log, index) => (
            <Table.Row
              key={index}
              className="candystripe"
              color={log.adjusted_money < 1 ? 'red' : 'green'}
            >
              <Table.Cell width="100px">
                {log.adjusted_money > 1 ? '+' : ''}
                {log.adjusted_money}
              </Table.Cell>
              <Table.Cell textAlign="center">{log.reason}</Table.Cell>
            </Table.Row>
          ))}
        </Table>
      </Section>
    </Section>
  );
};

/** Renders a set of sticky headers */
const TableHeaders = (props) => {
  return (
    <Table>
      <Table.Row>
        <Table.Cell color="label" width="100px">
          金额
        </Table.Cell>
        <Table.Cell color="label" textAlign="center">
          原因
        </Table.Cell>
      </Table.Row>
    </Table>
  );
};
