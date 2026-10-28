import { Box, Button } from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { PodLauncherData } from './types';

export function TabPod(props) {
  return (
    <Box color="label">
      注意：你可以右键点击这个
      <br />
      空投舱模板，直接编辑变量
    </Box>
  );
}

export function TabBay(props) {
  const { act, data } = useBackend<PodLauncherData>();
  const { oldArea } = data;

  return (
    <>
      <Button icon="street-view" onClick={() => act('teleportCentcom')}>
        传送
      </Button>
      <Button
        disabled={!oldArea}
        icon="undo-alt"
        onClick={() => act('teleportBack')}
      >
        {oldArea ? oldArea.substring(0, 17) : '返回'}
      </Button>
    </>
  );
}

export function TabDrop(props) {
  const { act, data } = useBackend<PodLauncherData>();
  const { oldArea } = data;

  return (
    <>
      <Button icon="street-view" onClick={() => act('teleportDropoff')}>
        传送
      </Button>
      <Button
        disabled={!oldArea}
        icon="undo-alt"
        onClick={() => act('teleportBack')}
      >
        {oldArea ? oldArea.substring(0, 17) : '返回'}
      </Button>
    </>
  );
}
