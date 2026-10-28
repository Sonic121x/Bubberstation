import {
  AnimatedNumber,
  Box,
  Button,
  LabeledList,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../../backend';

type StoredTank = {
  name: string;
  pressure: number;
};

export type PortableBasicInfoData = {
  connected: boolean;
  holding: StoredTank | null;
  on: boolean;
  pressure: number;
  hasHypernobCrystal: boolean;
  reactionSuppressionEnabled: boolean;
};

export const PortableBasicInfo = (props) => {
  const { act, data } = useBackend<PortableBasicInfoData>();
  const {
    connected,
    holding,
    on,
    pressure,
    hasHypernobCrystal,
    reactionSuppressionEnabled,
  } = data;
  return (
    <>
      <Section
        title="状态"
        buttons={
          <Button
            icon={on ? 'power-off' : 'times'}
            selected={on}
            onClick={() => act('power')}
          >
            {on ? '开启' : '关闭'}
          </Button>
        }
      >
        <LabeledList>
          <LabeledList.Item label="压力">
            <AnimatedNumber value={pressure} />
            {' kPa'}
          </LabeledList.Item>
          <LabeledList.Item label="接口" color={connected ? 'good' : 'average'}>
            {connected ? '已连接' : '未连接'}
          </LabeledList.Item>
          {!!hasHypernobCrystal && (
            <LabeledList.Item label="反应抑制">
              <Button
                icon={reactionSuppressionEnabled ? 'snowflake' : 'times'}
                selected={reactionSuppressionEnabled}
                onClick={() => act('reaction_suppression')}
              >
                {reactionSuppressionEnabled ? '已启用' : '已禁用'}
              </Button>
            </LabeledList.Item>
          )}
        </LabeledList>
      </Section>
      <Section
        title="装载气罐"
        minHeight="82px"
        buttons={
          <Button icon="eject" disabled={!holding} onClick={() => act('eject')}>
            弹出
          </Button>
        }
      >
        {holding ? (
          <LabeledList>
            <LabeledList.Item label="标签">{holding.name}</LabeledList.Item>
            <LabeledList.Item label="压力">
              <AnimatedNumber value={holding.pressure} />
              {' kPa'}
            </LabeledList.Item>
          </LabeledList>
        ) : (
          <Box color="average">未装载气罐</Box>
        )}
      </Section>
    </>
  );
};
