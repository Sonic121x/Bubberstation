import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Tabs,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';
import { batchThreeDisplay } from '../localization/batchThreeDisplay';
export const RoboticsControlConsole = (props) => {
  const { act, data } = useBackend();
  const [tab, setTab] = useSharedState('tab', 1);
  const { can_hack, can_detonate, cyborgs = [], drones = [] } = data;

  return (
    <Window width={500} height={460}>
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 1}
            onClick={() => setTab(1)}
          >
            赛博格（{cyborgs.length}）
          </Tabs.Tab>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 2}
            onClick={() => setTab(2)}
          >
            无人机（{drones.length}）
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && (
          <Cyborgs
            cyborgs={cyborgs}
            can_hack={can_hack}
            can_detonate={can_detonate}
          />
        )}
        {tab === 2 && <Drones drones={drones} />}
      </Window.Content>
    </Window>
  );
};

const Cyborgs = (props) => {
  const { cyborgs, can_hack, can_detonate } = props;
  const { act, data } = useBackend();
  if (!cyborgs.length) {
    return (
      <NoticeBox>未检测到权限范围内的赛博格单元</NoticeBox>
    );
  }
  return cyborgs.map((cyborg) => {
    return (
      <Section
        key={cyborg.ref}
        title={cyborg.name}
        buttons={
          <>
            {!!can_hack && !cyborg.emagged && (
              <Button
                icon="terminal"
                content="入侵"
                color="bad"
                onClick={() =>
                  act('magbot', {
                    ref: cyborg.ref,
                  })
                }
              />
            )}
            <Button.Confirm
              icon={cyborg.locked_down ? 'unlock' : 'lock'}
              color={cyborg.locked_down ? 'good' : 'default'}
              content={cyborg.locked_down ? '解除锁定' : '锁定'}
              onClick={() =>
                act('stopbot', {
                  ref: cyborg.ref,
                })
              }
            />
            {!!can_detonate && (
              <Button.Confirm
                icon="bomb"
                content="引爆"
                color="bad"
                onClick={() =>
                  act('killbot', {
                    ref: cyborg.ref,
                  })
                }
              />
            )}
          </>
        }
      >
        <LabeledList>
          <LabeledList.Item label="状态">
            <Box
              color={
                cyborg.status ? 'bad' : cyborg.locked_down ? 'average' : 'good'
              }
            >
              {cyborg.status
                ? '无响应'
                : cyborg.locked_down
                  ? '已锁定'
                  : '正常'}
            </Box>
          </LabeledList.Item>
          <LabeledList.Item label="电量">
            <Box
              color={
                cyborg.charge <= 30
                  ? 'bad'
                  : cyborg.charge <= 70
                    ? 'average'
                    : 'good'
              }
            >
              {typeof cyborg.charge === 'number'
                ? `${cyborg.charge}%`
                : '未找到'}
            </Box>
          </LabeledList.Item>
          <LabeledList.Item label="型号">{batchThreeDisplay(cyborg.module)}</LabeledList.Item>
          <LabeledList.Item label="主控AI">
            <Box color={cyborg.synchronization ? 'default' : 'average'}>
              {cyborg.synchronization || '无'}
            </Box>
          </LabeledList.Item>
        </LabeledList>
      </Section>
    );
  });
};

const Drones = (props) => {
  const { drones } = props;
  const { act } = useBackend();

  if (!drones.length) {
    return (
      <NoticeBox>未检测到权限范围内的无人机单元</NoticeBox>
    );
  }

  return drones.map((drone) => {
    return (
      <Section
        key={drone.ref}
        title={drone.name}
        buttons={
          <Button.Confirm
            icon="bomb"
            content="引爆"
            color="bad"
            onClick={() =>
              act('killdrone', {
                ref: drone.ref,
              })
            }
          />
        }
      >
        <LabeledList>
          <LabeledList.Item label="状态">
            <Box color={drone.status ? 'bad' : 'good'}>
              {drone.status ? '无响应' : '正常'}
            </Box>
          </LabeledList.Item>
        </LabeledList>
      </Section>
    );
  });
};
