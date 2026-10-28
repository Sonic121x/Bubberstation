import { Box, Button } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { useCompact } from './hooks';
import type { PodLauncherData } from './types';

export function PodLaunch(props) {
  const { act, data } = useBackend<PodLauncherData>();
  const { giveLauncher } = data;

  const [compact] = useCompact();

  return (
    <Button
      fluid
      onClick={() => act('giveLauncher')}
      selected={giveLauncher}
      textAlign="center"
      tooltip={`
        你应该知道《阿斯塔特圣典》
        对此有何教诲`}
      tooltipPosition="top"
    >
      <Box bold fontSize="1.4em" lineHeight={compact ? 1.5 : 3}>
        发射
      </Box>
    </Button>
  );
}
