// THIS IS A SKYRAT UI FILE
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Slider,
} from 'tgui-core/components';
import { formatPower } from 'tgui-core/format';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { machineStatusDisplay } from '../localization/machineStatusDisplay';
type Data = {
  connected: BooleanLike;
  notice: string;
  unlocked: BooleanLike;
  target: string;
  powernet_power: number;
  capacitor_charge: number;
  target_capacitor_charge: number;
  max_capacitor_charge: number;
  status: string;
};

export const BluespaceArtillerySkyrat = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    notice,
    connected,
    unlocked,
    target,
    powernet_power,
    capacitor_charge,
    target_capacitor_charge,
    max_capacitor_charge,
    status,
  } = data;

  return (
    <Window width={600} height={600}>
      <Window.Content>
        {!!notice && <NoticeBox>{notice}</NoticeBox>}
        {connected ? (
          <>
            <Section title="系统状态">
              <Box
                color={status !== 'SYSTEM READY' ? 'bad' : 'green'}
                fontSize="25px"
              >
                {machineStatusDisplay(status)}
              </Box>
            </Section>
            <Section
              title="电容器"
              buttons={
                <Button
                  content="为电容器充电"
                  color="orange"
                  onClick={() => act('charge')}
                />
              }
            >
              <LabeledList>
                <LabeledList.Item label="电容器电量">
                  {formatPower(capacitor_charge, 1)}
                </LabeledList.Item>
                <LabeledList.Item label="可用功率">
                  {formatPower(powernet_power, 1)}
                </LabeledList.Item>
                <LabeledList.Item label="目标电量">
                  <Slider
                    value={target_capacitor_charge}
                    fillValue={target_capacitor_charge}
                    minValue={0}
                    maxValue={max_capacitor_charge}
                    step={100000}
                    stepPixelSize={1}
                    format={(value) => formatPower(value, 1)}
                    onChange={(e, value) =>
                      act('capacitor_target_change', {
                        capacitor_target: value,
                      })
                    }
                  />
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Section
              title="目标"
              buttons={
                <Button
                  icon="crosshairs"
                  disabled={!unlocked}
                  onClick={() => act('recalibrate')}
                />
              }
            >
              <Box color={target ? 'average' : 'bad'} fontSize="25px">
                {target || '未设置目标'}
              </Box>
            </Section>
            <Section>
              {unlocked ? (
                <Box style={{ margin: 'auto' }}>
                  <Button
                    fluid
                    content="开火"
                    color="bad"
                    disabled={!target || status !== 'SYSTEM READY'}
                    fontSize="30px"
                    textAlign="center"
                    lineHeight="46px"
                    onClick={() => act('fire')}
                  />
                </Box>
              ) : (
                <>
                  <Box color="bad" fontSize="18px">
                    蓝空间火炮目前已锁定。
                  </Box>
                  <Box mt={1}>
                    正在等待至少两名空间站主管
                    通过钥匙卡读取器授权。
                  </Box>
                </>
              )}
            </Section>
          </>
        ) : (
          <Section>
            <LabeledList>
              <LabeledList.Item label="维护">
                <Button
                  icon="wrench"
                  content="完成部署"
                  onClick={() => act('build')}
                />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
