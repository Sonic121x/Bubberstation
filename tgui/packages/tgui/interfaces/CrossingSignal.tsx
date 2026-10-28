import { LabeledList, Section } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  sensorStatus: BooleanLike;
  operatingStatus: number;
  inboundPlatform: number;
  outboundPlatform: number;
};

export const CrossingSignal = (props) => {
  const { data } = useBackend<Data>();

  const { sensorStatus, operatingStatus, inboundPlatform, outboundPlatform } =
    data;

  return (
    <Window title="道口信号" width={400} height={175} theme="dark">
      <Window.Content>
        <Section title="系统状态">
          <LabeledList>
            <LabeledList.Item
              label="运行状态"
              color={operatingStatus ? 'bad' : 'good'}
            >
              {operatingStatus ? '性能下降' : '正常'}
            </LabeledList.Item>
            <LabeledList.Item
              label="传感器状态"
              color={sensorStatus ? 'good' : 'bad'}
            >
              {sensorStatus ? '已连接' : '错误'}
            </LabeledList.Item>
            <LabeledList.Item label="驶入站台">
              {inboundPlatform}
            </LabeledList.Item>
            <LabeledList.Item label="驶出站台">
              {outboundPlatform}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
