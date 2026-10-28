import { Box, Button, Stack } from 'tgui-core/components';

export type ControlBarProps = {
  running: boolean;
  zoom: number;
  awaitingPick: boolean;
  autoScroll: boolean;
  onAutoScrollChange: (val: boolean) => void;
  act: (action: string, params?: object) => void;
};

export function ControlBar(props: ControlBarProps) {
  const { running, zoom, awaitingPick, autoScroll, onAutoScrollChange, act } =
    props;
  return (
    <Stack align="center" p={0.5}>
      <Stack.Item>
        <Button
          icon={running ? 'stop' : 'play'}
          color={running ? 'bad' : 'good'}
          onClick={() => act('toggle_running')}
        >
          {running ? '停止' : '开始'}
        </Button>
      </Stack.Item>
      <Stack.Item>
        <Button
          icon="trash"
          color="average"
          onClick={() => act('clear')}
          disabled={running}
        >
          清除
        </Button>
      </Stack.Item>
      <Stack.Item>
        <Button
          icon="crosshairs"
          color={awaitingPick ? 'caution' : 'transparent'}
          selected={awaitingPick}
          onClick={() => act('start_pick_target')}
        >
          {awaitingPick ? '点击一个目标……' : '选择目标'}
        </Button>
      </Stack.Item>
      <Stack.Item>
        <Button
          icon="angles-right"
          selected={autoScroll}
          tooltip="自动将时间线滚动到最新事件"
          onClick={() => onAutoScrollChange(!autoScroll)}
        >
          自动滚动
        </Button>
      </Stack.Item>
      <Stack.Item>
        <Box inline color="label">
          缩放：{zoom < 1 ? zoom.toFixed(1) : zoom} 倍
        </Box>
      </Stack.Item>
    </Stack>
  );
}
