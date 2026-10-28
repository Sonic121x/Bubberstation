import {
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import { formatEnergy } from 'tgui-core/format';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const MechBayPowerConsole = (props) => {
  const { act, data } = useBackend();
  const { recharge_port } = data;
  const mech = recharge_port?.mech;
  const cell = mech?.cell;
  return (
    <Window width={400} height={200}>
      <Window.Content>
        <Section
          title="机甲状态"
          textAlign="center"
          buttons={
            <Button
              icon="sync"
              content="同步"
              onClick={() => act('reconnect')}
            />
          }
        >
          <LabeledList>
            <LabeledList.Item label="完整度">
              {(!recharge_port && (
                <NoticeBox>未检测到供电接口，请重新同步。</NoticeBox>
              )) ||
                (!mech && <NoticeBox>未检测到机甲。</NoticeBox>) || (
                  <ProgressBar
                    value={mech.health / mech.maxhealth}
                    ranges={{
                      good: [0.7, Infinity],
                      average: [0.3, 0.7],
                      bad: [-Infinity, 0.3],
                    }}
                  />
                )}
            </LabeledList.Item>
            <LabeledList.Item label="电量">
              {(!recharge_port && (
                <NoticeBox>未检测到供电接口，请重新同步。</NoticeBox>
              )) ||
                (!mech && <NoticeBox>未检测到机甲。</NoticeBox>) ||
                (!cell && <NoticeBox>未安装电池。</NoticeBox>) || (
                  <ProgressBar
                    value={cell.charge / cell.maxcharge}
                    ranges={{
                      good: [0.7, Infinity],
                      average: [0.3, 0.7],
                      bad: [-Infinity, 0.3],
                    }}
                  >
                    {formatEnergy(cell.charge) +
                      '/' +
                      formatEnergy(cell.maxcharge)}
                  </ProgressBar>
                )}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
