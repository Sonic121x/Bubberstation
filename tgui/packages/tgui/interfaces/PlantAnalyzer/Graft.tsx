import {
  DmIcon,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';
import { capitalizeFirst } from 'tgui-core/string';

import { useBackend } from '../../backend';
import { TraitTooltip } from '../SeedTable';
import { Fallback } from './Fallback';
import type { PlantAnalyzerData } from './types';

export function PlantAnalyzerGraft(props) {
  const { data } = useBackend<PlantAnalyzerData>();
  const { graft_data } = data;

  if (!graft_data) {
    // This shouldn't be rendered if graft_data is null
    return null;
  }

  return (
    <Section
      title={`接穗：${capitalizeFirst(graft_data.name)}`}
      buttons={
        !!graft_data.graft_gene && (
          <TraitTooltip path={graft_data.graft_gene} trait_db={data.trait_db} />
        )
      }
    >
      <Stack>
        <Stack.Item mx={2}>
          <DmIcon
            fallback={Fallback}
            icon={graft_data.icon}
            icon_state={graft_data.icon_state}
            height="64px"
            width="64px"
          />
        </Stack.Item>
        <Stack.Item>
          <LabeledList>
            <LabeledList.Item label="耐久">
              <ProgressBar
                value={graft_data.endurance / 100}
                ranges={{
                  good: [0.5, Infinity],
                  average: [0.1, 0.5],
                  bad: [0, 0.1],
                }}
              >
                {graft_data.endurance} / 100
              </ProgressBar>
            </LabeledList.Item>

            <LabeledList.Item label="寿命">
              <ProgressBar
                value={graft_data.lifespan / 100}
                ranges={{
                  good: [0.65, Infinity],
                  average: [0.25, 0.65],
                  bad: [0, 0.25],
                }}
              >
                {graft_data.lifespan} / 100
              </ProgressBar>
            </LabeledList.Item>

            <LabeledList.Item label="产量">
              <ProgressBar
                value={graft_data.yield / 10}
                ranges={{
                  good: [0.7, Infinity],
                  average: [0.3, 0.7],
                  bad: [0, 0.3],
                }}
              >
                {graft_data.yield} / 10
              </ProgressBar>
            </LabeledList.Item>

            <LabeledList.Item label="不稳定性">
              <ProgressBar
                value={graft_data.weed_chance}
                maxValue={100}
                ranges={{
                  good: [-Infinity, 20],
                  average: [20, 40],
                  bad: [40, Infinity],
                }}
              >
                {graft_data.weed_chance} / 100
              </ProgressBar>
            </LabeledList.Item>

            <LabeledList.Item label="生产周期">
              {graft_data.production * data.cycle_seconds} 秒
            </LabeledList.Item>

            <LabeledList.Item label="杂草">
              {graft_data.weed_chance && graft_data.weed_rate
                ? graft_data.weed_chance +
                  '% 概率增长 ' +
                  graft_data.weed_rate
                : '不生长杂草'}
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
}
