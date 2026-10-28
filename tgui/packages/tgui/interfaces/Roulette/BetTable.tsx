import { useState } from 'react';
import { Box, Button, NumberInput, Stack, Table } from 'tgui-core/components';
import { type BooleanLike, classes } from 'tgui-core/react';

import { useBackend } from '../../backend';
import { getNumberColor } from './helpers';

type Data = {
  IsAnchored: BooleanLike;
  BetAmount: number;
  BetType: string;
  HouseBalance: number;
  LastSpin: number;
  Spinning: BooleanLike;
  AccountBalance: number;
  CanUnbolt: BooleanLike;
};

export function RouletteBetTable(props) {
  const { act, data } = useBackend<Data>();
  const { LastSpin, HouseBalance, BetAmount, IsAnchored } = data;

  const [customBet, setCustomBet] = useState(500);

  let BetType = data.BetType;

  if (BetType.startsWith('s')) {
    BetType = BetType.substring(1, BetType.length);
  }

  return (
    <Table className="Roulette__lowertable" collapsing>
      <Table.Row>
        <Table.Cell
          className={classes([
            'Roulette',
            'Roulette__lowertable--cell',
            'Roulette__lowertable--header',
          ])}
        >
          上次结果：
        </Table.Cell>
        <Table.Cell
          className={classes([
            'Roulette',
            'Roulette__lowertable--cell',
            'Roulette__lowertable--header',
          ])}
        >
          当前下注：
        </Table.Cell>
      </Table.Row>
      <Table.Row>
        <Table.Cell
          className={classes([
            'Roulette',
            'Roulette__lowertable--cell',
            'Roulette__lowertable--spinresult',
            `Roulette__lowertable--spinresult-${getNumberColor(LastSpin)}`,
          ])}
        >
          {LastSpin}
        </Table.Cell>
        <Table.Cell
          className={classes([
            'Roulette',
            'Roulette__lowertable--cell',
            'Roulette__lowertable--betscell',
          ])}
        >
          <Box bold mt={1} mb={1} fontSize="20px" textAlign="center">
            下注{BetAmount}信用点于{({ even: '偶数', odd: '奇数', black: '黑色', red: '红色', '1st col': '第一列', '2nd col': '第二列', '3rd col': '第三列' })[BetType] ?? BetType}
          </Box>
          <Box ml={1} mr={1}>
            <Button
              fluid
              onClick={() =>
                act('ChangeBetAmount', {
                  amount: 10,
                })
              }
            >
              下注10信用点
            </Button>
            <Button
              fluid
              onClick={() =>
                act('ChangeBetAmount', {
                  amount: 50,
                })
              }
            >
              下注50信用点
            </Button>
            <Button
              fluid
              onClick={() =>
                act('ChangeBetAmount', {
                  amount: 100,
                })
              }
            >
              下注100信用点
            </Button>
            <Button
              fluid
              onClick={() =>
                act('ChangeBetAmount', {
                  amount: 500,
                })
              }
            >
              下注500信用点
            </Button>
            <Stack>
              <Stack.Item grow>
                <Button
                  fluid
                  onClick={() =>
                    act('ChangeBetAmount', {
                      amount: customBet,
                    })
                  }
                >
                  下注自定义金额……
                </Button>
              </Stack.Item>
              <Stack.Item>
                <NumberInput
                  value={customBet}
                  minValue={0}
                  maxValue={1000}
                  step={10}
                  stepPixelSize={4}
                  width="40px"
                  onChange={(value) => setCustomBet(value)}
                />
              </Stack.Item>
            </Stack>
          </Box>
        </Table.Cell>
      </Table.Row>
      <Table.Row>
        <Table.Cell colSpan={2}>
          <Box bold m={1} fontSize="14px" textAlign="center">
            刷一张关联账户的身份卡即可转动轮盘！
          </Box>
        </Table.Cell>
      </Table.Row>
      <Table.Row>
        <Table.Cell className="Roulette__lowertable--cell">
          <Box inline bold mr={1}>
            庄家余额：
          </Box>
          <Box inline>{HouseBalance ? `${HouseBalance} 信用点` : '无'}</Box>
        </Table.Cell>
        <Table.Cell className="Roulette__lowertable--cell">
          <Button
            fluid
            m={1}
            color="transparent"
            textAlign="center"
            onClick={() => act('anchor')}
          >
            {IsAnchored ? '已固定' : '未固定'}
          </Button>
        </Table.Cell>
      </Table.Row>
    </Table>
  );
}
