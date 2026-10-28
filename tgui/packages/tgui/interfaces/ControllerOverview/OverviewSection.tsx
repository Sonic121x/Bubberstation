import { Button, LabeledList, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { ControllerData } from './types';

export function OverviewSection(props) {
  const { act, data } = useBackend<ControllerData>();
  const {
    fast_update,
    rolling_length,
    map_cpu,
    subsystems = [],
    world_time,
  } = data;

  let avgUsage = 0;
  let overallOverrun = 0;
  for (let i = 0; i < subsystems.length; i++) {
    avgUsage += subsystems[i].usage_per_tick;
    overallOverrun += subsystems[i].overtime;
  }

  return (
    <Section
      fill
      title="主控制器概览"
      buttons={
        <>
          <Button
            tooltip="快速刷新"
            icon={fast_update ? 'check-square-o' : 'square-o'}
            color={fast_update && 'average'}
            onClick={() => {
              act('toggle_fast_update');
            }}
          >
            快速
          </Button>
          <Button.Input
            buttonText={`平均周期：${(rolling_length / 10).toFixed(2)} 秒`}
            value={(rolling_length / 10).toString()}
            onCommit={(value) => {
              act('set_rolling_length', {
                rolling_length: value,
              });
            }}
          />
        </>
      }
    >
      <Stack fill>
        <Stack.Item grow>
          <LabeledList>
            <LabeledList.Item label="世界时间">
              {world_time.toFixed(1)}
            </LabeledList.Item>
            <LabeledList.Item label="地图 CPU 占用">
              {map_cpu.toFixed(2)}%
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
        <Stack.Item grow>
          <LabeledList>
            <LabeledList.Item label="总平均占用率">
              {avgUsage.toFixed(2)}%
            </LabeledList.Item>
            <LabeledList.Item label="总超时比例">
              {overallOverrun.toFixed(2)}%
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
}
