import { Button, Section } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { BAYS } from './constants';
import type { PodLauncherData } from './types';

export function PodBays(props) {
  const { act, data } = useBackend<PodLauncherData>();
  const { bayNumber } = data;

  return (
    <Section
      buttons={
        <>
          <Button
            color="transparent"
            icon="trash"
            onClick={() => act('clearBay')}
            tooltip={`
              清除所选装载区
              内的所有内容`}
            tooltipPosition="top-end"
          />
          <Button
            color="transparent"
            icon="question"
            tooltip={`
              每个选项对应
              中央指挥部的一个区域。
              发射的空投舱会
              按照左上角
              “装载来源”
              的选项设置，
              装入这些区域内的物品。`}
            tooltipPosition="top-end"
          />
        </>
      }
      fill
      title="装载区"
    >
      {BAYS.map((bay, i) => (
        <Button
          key={i}
          onClick={() => act('switchBay', { bayNumber: `${i + 1}` })}
          selected={bayNumber === `${i + 1}`}
          tooltipPosition="bottom-end"
        >
          {bay.title}
        </Button>
      ))}
    </Section>
  );
}
