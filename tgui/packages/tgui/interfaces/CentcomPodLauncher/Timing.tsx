import { Button, Divider, Section } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { DELAYS, REV_DELAYS } from './constants';
import { DelayHelper } from './DelayHelper';
import type { PodLauncherData } from './types';

export function Timing(props) {
  const { act, data } = useBackend<PodLauncherData>();
  const { custom_rev_delay, effectReverse } = data;

  return (
    <Section
      buttons={
        <>
          <Button
            color="transparent"
            icon="undo"
            onClick={() => act('resetTiming')}
            tooltip={`
            重置所有空投舱的
            计时和延迟`}
            tooltipPosition="bottom-start"
          />
          <Button
            color="transparent"
            disabled={!effectReverse}
            icon={custom_rev_delay === 1 ? 'toggle-on' : 'toggle-off'}
            onClick={() => act('toggleRevDelays')}
            selected={custom_rev_delay}
            tooltip={`
            切换回收延迟
            注意：上面一组
            为普通延迟，下面一组
            为回收舱的延迟`}
            tooltipPosition="bottom"
          />
        </>
      }
      fill
      title="时间"
    >
      <DelayHelper delay_list={DELAYS} />
      {!!custom_rev_delay && (
        <>
          <Divider />
          <DelayHelper delay_list={REV_DELAYS} reverse />
        </>
      )}
    </Section>
  );
}
