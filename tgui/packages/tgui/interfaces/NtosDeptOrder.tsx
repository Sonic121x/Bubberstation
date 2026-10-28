import { useState } from 'react';
import {
  Blink,
  Box,
  Button,
  Dimmer,
  Icon,
  NoticeBox,
  Section,
  Stack,
  Tabs,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

// 3.5x crate value, 10 minutes
const COST_MODERATE_BOUND = 700;
// 13.5x crate value, 15 minutes
const COST_LONG_BOUND = 2700;
// 40x crate value, 20 minutes
const COST_VERY_LONG_BOUND = 8000;

type typePath = string;

type Pack = {
  name: string;
  desc: string;
  cost: number;
  id: typePath;
};

type Category = {
  name: string;
  packs: Pack[];
};

type Info = {
  can_override: BooleanLike;
  time_left: string | null;
  supplies: Category[];
  no_link: BooleanLike;
  id_inside: BooleanLike;
};

const CooldownEstimate = (props) => {
  const { cost } = props;
  const cooldownColor =
    (cost >= COST_VERY_LONG_BOUND && 'red') ||
    (cost >= COST_LONG_BOUND && 'orange') ||
    (cost >= COST_MODERATE_BOUND && 'yellow') ||
    'green';
  const cooldownText =
    (cost >= COST_VERY_LONG_BOUND && '极长') ||
    (cost >= COST_LONG_BOUND && '较长') ||
    (cost >= COST_MODERATE_BOUND && '适中') ||
    '较短';
  return (
    <Box as="span" textColor={cooldownColor}>
      冷却时间{cooldownText}。
    </Box>
  );
};

export const DepartmentOrderContent = (props) => {
  const { data } = useBackend<Info>();
  const { no_link, time_left } = data;
  if (!data) {
    return null;
  }

  if (no_link) {
    return <NoLinkDimmer />;
  }
  if (time_left) {
    return <CooldownDimmer />;
  }

  return (
    <Stack vertical fill>
      <Stack.Item grow>
        <Stack fill vertical>
          <Stack.Item>
            <NoticeBox info>
              作为纳米传讯的员工，您可以
              免费订购此处的物品，仅需等待
              服务冷却。订购价格较低的物品后，
              纳米传讯允许您再次订购前的等待时间也更短，
              以此鼓励合理消费。
            </NoticeBox>
          </Stack.Item>
          <Stack.Item grow>
            <DepartmentCatalog />
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

export const NtosDeptOrder = () => {
  return (
    <NtosWindow title="部门订购" width={620} height={580}>
      <NtosWindow.Content>
        <DepartmentOrderContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const CooldownDimmer = () => {
  const { act, data } = useBackend<Info>();
  const { can_override, time_left } = data;
  return (
    <Dimmer>
      <Stack vertical>
        <Stack.Item textAlign="center">
          <Icon color="bug" name="route" size={20} />
        </Stack.Item>
        <Stack.Item fontSize="18px" color="orange">
          {time_left} 后可再次订购……
        </Stack.Item>
        <Stack.Item textAlign="center" color="orange">
          <Button
            width="300px"
            lineHeight={2}
            tooltip={
              (!!can_override &&
                '此操作需要部门主管权限！') ||
              '货箱已发出！现在无法取消！'
            }
            fontSize="14px"
            color="red"
            disabled={!can_override}
            onClick={() => act('override_order')}
          >
            <Box fontSize="22px">强制覆盖</Box>
          </Button>
        </Stack.Item>
      </Stack>
    </Dimmer>
  );
};

const NoLinkDimmer = () => {
  const { act, data } = useBackend<Info>();
  const { id_inside } = data;
  return (
    <Dimmer>
      <Stack vertical>
        <Stack.Item textAlign="center">
          <Blink>
            <Icon color="red" name="exclamation" size={16} opacity={0.8} />
          </Blink>
        </Stack.Item>
        <Stack.Item textAlign="center" fontSize="22px" color="red">
          未关联！
        </Stack.Item>
        <Stack.Item textAlign="center" fontSize="14px" color="red">
          <Button disabled={!id_inside} onClick={() => act('link')}>
            请插入银色部门主管身份卡，然后点击以继续。
          </Button>
        </Stack.Item>
      </Stack>
    </Dimmer>
  );
};

const DepartmentCatalog = () => {
  const { act, data } = useBackend<Info>();
  const { supplies } = data;
  const [tabCategory, setTabCategory] = useState(supplies[0]);

  return (
    <Stack vertical fill>
      <Stack.Item>
        <Tabs textAlign="center" fluid>
          {supplies.map((cat) => (
            <Tabs.Tab
              key={cat.name}
              selected={tabCategory === cat}
              onClick={() => setTabCategory(cat)}
            >
              {cat.name}
            </Tabs.Tab>
          ))}
        </Tabs>
      </Stack.Item>
      <Stack.Item grow>
        <Section fill scrollable>
          <Stack vertical>
            {tabCategory.packs.map((pack) => (
              <Stack.Item className="candystripe" key={pack.name}>
                <Stack fill>
                  <Stack.Item grow>
                    <Tooltip content={pack.desc}>
                      <Box
                        as="span"
                        style={{
                          borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
                        }}
                      >
                        {pack.name}
                      </Box>
                    </Tooltip>
                  </Stack.Item>
                  <Stack.Item>
                    <CooldownEstimate cost={pack.cost} />
                    &ensp;
                    <Button
                      onClick={() =>
                        act('order', {
                          id: pack.id,
                        })
                      }
                    >
                      订购
                    </Button>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
