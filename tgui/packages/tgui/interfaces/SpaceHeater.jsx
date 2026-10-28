import {
  Box,
  Button,
  LabeledList,
  NumberInput,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import { capitalize } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const SpaceHeater = (props) => {
  const { act, data } = useBackend();
  return (
    <Window width={400} height={305}>
      <Window.Content>
        <Section
          title="电源"
          buttons={
            <>
              {!!data.chemHacked && (
                <Button
                  icon="eject"
                  content="弹出烧杯"
                  disabled={!data.beaker}
                  onClick={() => act('ejectBeaker')}
                />
              )}
              <Button
                icon="eject"
                content="弹出电池"
                disabled={!data.hasPowercell || !data.open}
                onClick={() => act('eject')}
              />
              <Button
                icon={data.on ? 'power-off' : 'times'}
                content={data.on ? '开启' : '关闭'}
                selected={data.on}
                disabled={!data.hasPowercell}
                onClick={() => act('power')}
              />
            </>
          }
        >
          <LabeledList>
            <LabeledList.Item label="电池" color={!data.hasPowercell && 'bad'}>
              {(data.hasPowercell && (
                <ProgressBar
                  value={data.powerLevel / 100}
                  ranges={{
                    good: [0.6, Infinity],
                    average: [0.3, 0.6],
                    bad: [-Infinity, 0.3],
                  }}
                >
                  {`${data.powerLevel}%`}
                </ProgressBar>
              )) ||
                '无'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="恒温控制">
          <LabeledList>
            <LabeledList.Item label="当前温度">
              <Box
                fontSize="18px"
                color={
                  Math.abs(data.targetTemp - data.currentTemp) > 50
                    ? 'bad'
                    : Math.abs(data.targetTemp - data.currentTemp) > 20
                      ? 'average'
                      : 'good'
                }
              >
                {data.currentTemp}°C
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="目标温度">
              {(data.open && (
                <NumberInput
                  animated
                  value={parseFloat(data.targetTemp)}
                  width="65px"
                  unit="°C"
                  step={1}
                  minValue={data.minTemp}
                  maxValue={data.maxTemp}
                  onChange={(value) =>
                    act('target', {
                      target: value,
                    })
                  }
                />
              )) ||
                `${data.targetTemp}°C`}
            </LabeledList.Item>
            <LabeledList.Item label="模式">
              {(!data.open && (({ auto: '自动', heat: '加热', cool: '制冷' })[data.mode] ?? capitalize(data.mode))) || (
                <>
                  <Button
                    icon="thermometer-half"
                    content="自动"
                    selected={data.mode === 'auto'}
                    onClick={() =>
                      act('mode', {
                        mode: 'auto',
                      })
                    }
                  />
                  <Button
                    icon="fire-alt"
                    content="加热"
                    selected={data.mode === 'heat'}
                    onClick={() =>
                      act('mode', {
                        mode: 'heat',
                      })
                    }
                  />
                  <Button
                    icon="fan"
                    content="制冷"
                    selected={data.mode === 'cool'}
                    onClick={() =>
                      act('mode', {
                        mode: 'cool',
                      })
                    }
                  />
                </>
              )}
            </LabeledList.Item>
            <LabeledList.Divider />
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
