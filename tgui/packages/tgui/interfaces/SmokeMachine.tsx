import {
  AnimatedNumber,
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import type { Beaker } from './common/BeakerDisplay';

type Data = {
  active: BooleanLike;
  maxSetting: number;
  setting: number;
  tank: Beaker;
};

export const SmokeMachine = (props) => {
  const { act, data } = useBackend<Data>();
  const { tank, active, setting, maxSetting } = data;

  return (
    <Window width={350} height={350}>
      <Window.Content>
        <Section
          title="喷雾储罐"
          buttons={
            <Button
              icon={active ? 'power-off' : 'times'}
              selected={active}
              onClick={() => act('power')}
            >
              {active ? '开启' : '关闭'}
            </Button>
          }
        >
          <ProgressBar
            value={tank.currentVolume / tank.maxVolume}
            ranges={{
              bad: [-Infinity, 0.3],
            }}
          >
            <AnimatedNumber initial={0} value={tank.currentVolume || 0} />
            {` / ${tank.maxVolume}`}
          </ProgressBar>
          <Box mt={1}>
            <LabeledList>
              <LabeledList.Item label="范围">
                {[1, 2, 3, 4, 5].map((amount) => (
                  <Button
                    disabled={maxSetting < amount}
                    icon="plus"
                    key={amount}
                    onClick={() => act('setting', { amount })}
                    selected={setting === amount}
                  >
                    {amount * 3}
                  </Button>
                ))}
              </LabeledList.Item>
            </LabeledList>
          </Box>
        </Section>
        <Section
          title="内容物"
          buttons={
            <Button icon="trash" onClick={() => act('purge')}>
              清空
            </Button>
          }
        >
          {tank.contents.map((chemical) => (
            <Box key={chemical.name} color="label">
              <AnimatedNumber initial={0} value={chemical.volume} /> 单位{' '}
              {chemical.name}
            </Box>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
