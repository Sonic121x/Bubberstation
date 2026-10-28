import { sortBy } from 'es-toolkit';
import {
  Box,
  Button,
  Collapsible,
  Modal,
  NoticeBox,
  Section,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import { formatMoney } from 'tgui-core/format';
import type { BooleanLike } from 'tgui-core/react';
import { batchThreeDisplay as zh } from '../localization/batchThreeDisplay';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Material = {
  name: string;
  quantity: number;
  rarity: number;
  trend: string;
  price: number;
  min_threshold: number;
  max_threshold: number;
  color: string;
  requested: number;
  elastic: number;
};

type Data = {
  orderingPrive: BooleanLike;
  canOrderCargo: BooleanLike;
  creditBalance: number;
  orderBalance: number;
  materials: Material[];
  catastrophe: BooleanLike;
  CARGO_CRATE_VALUE: number;
  updateTime: number;
};

export const MatMarket = (props) => {
  const { act, data } = useBackend<Data>();

  const {
    orderingPrive,
    canOrderCargo,
    creditBalance,
    orderBalance,
    materials = [],
    catastrophe,
    CARGO_CRATE_VALUE,
  } = data;

  // offset cost with crate value if there is currently nothing in the order
  const total_order_cost = orderBalance || CARGO_CRATE_VALUE;
  // multiplier of 1.1 for private orders
  const multiplier = orderingPrive ? 1.1 : 1;

  return (
    <Window width={990} height={615}>
      <Window.Content scrollable>
        {!!catastrophe && <MarketCrashModal />}
        <Section
          title="在售材料"
          buttons={
            !!canOrderCargo && (
              <Button.Checkbox
                icon={orderingPrive ? "fa-regular fa-square" : "square-check"}
                tooltip="使用货运预算下单。"
                color={orderingPrive ? 'transparent' : 'green'}
                checked={orderingPrive}
                content={
                  orderingPrive
                    ? '使用货运预算下单？'
                    : '正在使用货运预算下单'
                }
                onClick={() => act('toggle_budget')}
              />
            )
          }
        >
          <Section>
            <Stack>
              <Stack.Item width="15%">
                余额：<b>{formatMoney(creditBalance)}</b> 信用点
              </Stack.Item>
              <Stack.Item width="15%">
                订单：<b>{formatMoney(orderBalance)}</b> 信用点
              </Stack.Item>
              <Stack.Item
                width="20%"
                color={data.updateTime > 150 ? 'green' : '#ad7526'}
              >
                距下次更新还有 <b>{Math.round(data.updateTime / 10)} 秒</b>
                。
              </Stack.Item>
              <Stack.Item>
                <Button
                  icon="times"
                  color="transparent"
                  ml={66}
                  onClick={() => act('clear')}
                >
                  清空
                </Button>
              </Stack.Item>
            </Stack>
          </Section>
        </Section>
        {sortBy(materials, [(tempmat: Material) => tempmat.rarity]).map(
          (material, i) => (
            <Section key={i}>
              <Stack fill>
                <Stack.Item width="82%">
                  <Stack>
                    <Stack.Item
                      textColor={material.color ? material.color : 'white'}
                      fontSize="125%"
                      width="15%"
                      pr="3%"
                    >
                      {zh(material.name)}
                    </Stack.Item>
                    <Stack.Item
                      width="10%"
                      pr="2%"
                      textColor={
                        material.elastic < 33
                          ? 'red'
                          : material.elastic < 66
                            ? 'orange'
                            : 'green'
                      }
                    >
                      弹性：<b>{Math.round(material.elastic)}</b>%
                    </Stack.Item>

                    <Stack.Item
                      width="15%"
                      pr="2%"
                      >
                      <Tooltip
                        content={rangeText({ minPrice: material.min_threshold, maxPrice: material.max_threshold })}
                      >
                        <u>交易价格<br /><b>{formatMoney(material.price)}</b> 信用点</u>
                      </Tooltip>

                    </Stack.Item>
                    {material.price < material.min_threshold ? (
                      <Stack.Item width="33%" ml={2} textColor="grey">
                        材料价格跌至临界值！
                        <br /> <b>交易暂时停止。</b>
                      </Stack.Item>
                    ) : (
                      <Stack.Item width="33%" ml={2}>
                        <Box textColor={material.quantity === 0 ? 'grey' : 'white'}>
                          在售 <b>{material.quantity || '零'}</b> 张{' '}
                          <b>{zh(material.name)}</b>板材。{' '}
                        </Box>
                        <Box
                          bold={!!material.requested}
                          textColor={material.requested > 0 ? 'lightblue' : 'white'}
                        >
                          已订购 {material.requested || '零'} 张板材。
                        </Box>
                      </Stack.Item>
                    )}

                    <Stack.Item
                      width="20%"
                      color={
                        material.trend === 'up'
                          ? 'green'
                          : material.trend === 'down'
                            ? 'red'
                            : 'white'
                      }
                    >
                      <b>{zh(material.name)}</b>的走势：{' '}
                      <b>{material.trend === 'up' ? '上涨' : material.trend === 'down' ? '下跌' : material.trend === 'neutral' ? '持平' : material.trend}</b>。
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    height="35px"
                    verticalAlignContent="middle"
                    disabled={
                      catastrophe === 1 ||
                      material.price < material.min_threshold ||
                      creditBalance - total_order_cost <
                        material.price * multiplier ||
                      material.requested + 1 > material.quantity
                    }
                    tooltip={material.price * 1}
                    onClick={() =>
                      act('buy', {
                        quantity: 1,
                        material: material.name,
                      })
                    }
                  >
                    购买 1 张
                  </Button>
                  <Button
                    height="35px"
                    verticalAlignContent="middle"
                    disabled={
                      catastrophe === 1 ||
                      material.price < material.min_threshold ||
                      creditBalance - total_order_cost <
                        material.price * 5 * multiplier ||
                      material.requested + 5 > material.quantity
                    }
                    tooltip={material.price * 5}
                    onClick={() =>
                      act('buy', {
                        quantity: 5,
                        material: material.name,
                      })
                    }
                  >
                    5
                  </Button>
                  <Button
                    height="35px"
                    verticalAlignContent="middle"
                    disabled={
                      catastrophe === 1 ||
                      material.price < material.min_threshold ||
                      creditBalance - total_order_cost <
                        material.price * 10 * multiplier ||
                      material.requested + 10 > material.quantity
                    }
                    tooltip={material.price * 10}
                    onClick={() =>
                      act('buy', {
                        quantity: 10,
                        material: material.name,
                      })
                    }
                  >
                    10
                  </Button>
                  <Button
                    height="35px"
                    verticalAlignContent="middle"
                    disabled={
                      catastrophe === 1 ||
                      material.price < material.min_threshold ||
                      creditBalance - total_order_cost <
                        material.price * 25 * multiplier ||
                      material.requested + 25 > material.quantity
                    }
                    tooltip={material.price * 25}
                    onClick={() =>
                      act('buy', {
                        quantity: 25,
                        material: material.name,
                      })
                    }
                  >
                    25
                  </Button>
                  <Button
                    height="35px"
                    verticalAlignContent="middle"
                    disabled={
                      catastrophe === 1 ||
                      material.price < material.min_threshold ||
                      creditBalance - total_order_cost <
                        material.price * 50 * multiplier ||
                      material.requested + 50 > material.quantity
                    }
                    tooltip={material.price * 50}
                    onClick={() =>
                      act('buy', {
                        quantity: 50,
                        material: material.name,
                      })
                    }
                  >
                    50
                  </Button>
                </Stack.Item>
              </Stack>
            </Section>
          ),
        )}
        <NoticeBox info>
            <Collapsible title="操作说明" color="blue">
              在此下单购买的材料板材，将随
              下一批货运物资送达。
              <br /> <br />
              如需出售材料，请放入板材或类似的成叠
              材料。在市场中直接出售矿物时，每种材料的
              价格都会按比例降低，但会随时间逐渐
              恢复。为防止操纵市场，所有注册交易者
              每次最多可购买共计 10 整叠材料。
              <br /> <br />
              出售材料时，价格会根据该材料的
              弹性系数降低，之后会随时间恢复。
              <br /> <br />
              所有新订单均包含运输箱费用，
              运输箱之后可以回收。
            </Collapsible>
          </NoticeBox>
      </Window.Content>
    </Window>
  );
};

const MarketCrashModal = (props) => {
  return (
    <Modal textAlign="center" mr={1.5}>
      注意！市场已经崩盘
      <br /> <br />
      所有材料现已一文不值
      <br /> <br />
      已对所有交易者启动交易熔断机制
      <br /> <br />
      <b>请勿惊慌，我们正在处理</b>
    </Modal>
  );
};

type rangeTextProps = {
  minPrice: number;
  maxPrice: number;
}

function rangeText(props: rangeTextProps) {
  const {minPrice, maxPrice} = props;
  return (
    '此材料的交易价格范围为 ' + formatMoney(minPrice) +
    ' - ' + formatMoney(maxPrice) + ' 信用点。'
  )
}
