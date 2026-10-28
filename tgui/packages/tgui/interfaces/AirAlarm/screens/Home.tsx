import type { Dispatch, SetStateAction } from 'react';
import { useBackend } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';

import type { AirAlarmData, AlarmScreen } from '../types';

type Props = {
  setScreen?: Dispatch<SetStateAction<AlarmScreen>>;
};

export function AirAlarmControlHome(props: Props) {
  const { act, data } = useBackend<AirAlarmData>();
  const { setScreen } = props;
  if (!setScreen) {
    throw new Error('setScreen is required');
  }

  const {
    allowLinkChange,
    atmosAlarm,
    filteringPath,
    panicSiphonPath,
    selectedModePath,
    sensor,
  } = data;

  const isPanicSiphoning = selectedModePath === panicSiphonPath;
  return (
    <Stack vertical>
      <Stack.Item>
        <Button
          icon={atmosAlarm ? 'exclamation-triangle' : 'exclamation'}
          color={atmosAlarm && 'caution'}
          onClick={() => act(atmosAlarm ? 'reset' : 'alarm')}
        >
          区域大气警报
        </Button>
      </Stack.Item>
      <Stack.Item mb={1}>
        <Button
          icon={isPanicSiphoning ? 'exclamation-triangle' : 'exclamation'}
          color={isPanicSiphoning && 'danger'}
          onClick={() =>
            act('mode', {
              mode: isPanicSiphoning ? filteringPath : panicSiphonPath,
            })
          }
        >
          紧急抽气
        </Button>
      </Stack.Item>
      <Stack.Item>
        <Button icon="sign-out-alt" onClick={() => setScreen('vents')}>
          通风口控制
        </Button>
      </Stack.Item>
      <Stack.Item>
        <Button icon="filter" onClick={() => setScreen('scrubbers')}>
          洗气器控制
        </Button>
      </Stack.Item>
      <Stack.Item>
        <Button icon="cog" onClick={() => setScreen('modes')}>
          运行模式
        </Button>
      </Stack.Item>
      <Stack.Item>
        <Button icon="chart-bar" onClick={() => setScreen('thresholds')}>
          报警阈值
        </Button>
      </Stack.Item>
      {!!sensor && !!allowLinkChange && (
        <Stack.Item>
          <Button.Confirm
            icon="link-slash"
            color="danger"
            onClick={() => act('disconnect_sensor')}
          >
            断开传感器
          </Button.Confirm>
        </Stack.Item>
      )}
    </Stack>
  );
}
