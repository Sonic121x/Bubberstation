import {
  Box,
  Button,
  DmIcon,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import { capitalizeFirst } from 'tgui-core/string';

import { useBackend } from '../../backend';
import { Fallback } from './Fallback';
import type { PlantAnalyzerData } from './types';

export function PlantAnalyzerTrayStats(props) {
  const { data } = useBackend<PlantAnalyzerData>();
  const { tray_data } = data;

  if (!tray_data) {
    // This shouldn't be rendered if tray_data is null
    return null;
  }

  return (
    <Section title={capitalizeFirst(tray_data.name)}>
      <Stack>
        <Stack.Item mx={2}>
          <Stack vertical align="center" width="100px">
            <Stack.Item>
              <DmIcon
                fallback={Fallback}
                icon={tray_data.icon}
                icon_state={tray_data.icon_state}
                height="64px"
                width="64px"
              />
            </Stack.Item>
            <Stack.Item>
              <Stack>
                <Stack.Item>
                  <Button
                    icon="hand-holding-droplet"
                    color={tray_data.self_sustaining ? 'yellow' : 'transparent'}
                    tooltip={
                      tray_data.self_sustaining
                        ? '自动培育已启用：提供光照、回收水分，并减少杂草和害虫。'
                        : '自动培育未启用'
                    }
                    disabled={1}
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="wind"
                    color={tray_data.being_pollinated ? 'teal' : 'transparent'}
                    tooltip={
                      tray_data.being_pollinated
                        ? '正在与附近植物异花授粉，可能共享植物试剂。'
                        : '未进行异花授粉'
                    }
                    disabled={1}
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="sun"
                    color={tray_data.yield_mod > 1 ? 'olive' : 'transparent'}
                    tooltip={
                      tray_data.yield_mod > 1
                        ? '已由蜜蜂授粉，产量翻倍。'
                        : '无产量修正'
                    }
                    disabled={1}
                  />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item width="100%">
          <LabeledList>
            <LabeledList.Item
              label="水分"
              tooltip="缺水会使植物开始枯萎，蘑菇除外。"
            >
              <ProgressBar
                value={tray_data.water / tray_data.water_max}
                ranges={{
                  good: [0.7, Infinity],
                  average: [0.3, 0.7],
                  bad: [0, 0.3],
                }}
              >
                {tray_data.water} / {tray_data.water_max}
              </ProgressBar>
            </LabeledList.Item>

            <LabeledList.Item
              label="养分"
              tooltip="缺少养分会使植物开始枯萎，杂草除外。养分可能影响植物和种植槽的属性。"
            >
              {tray_data.reagents.length > 0 ? (
                <Box>
                  <ProgressBar
                    width="234px" // why won't you scale??
                    position="absolute"
                    value={0}
                    color="transparent"
                    style={{
                      zIndex: 3,
                      border: `1px solid ${nutriToColor(tray_data.nutri, tray_data.nutri_max)}`,
                    }}
                  >
                    {tray_data.nutri} / {tray_data.nutri_max}
                  </ProgressBar>
                  {tray_data.reagents.map((reagent, i) => (
                    <ProgressBar
                      key={`${i}-${reagent.name}`}
                      mb={-0.5}
                      width={`${(reagent.volume / tray_data.nutri_max) * 234}px`}
                      value={1}
                      color={reagent.color}
                      empty
                    />
                  ))}
                </Box>
              ) : (
                <ProgressBar
                  value={tray_data.nutri / tray_data.nutri_max}
                  ranges={{
                    good: [0.7, Infinity],
                    average: [0.3, 0.7],
                    bad: [0, 0.3],
                  }}
                >
                  {tray_data.nutri} / {tray_data.nutri_max}
                </ProgressBar>
              )}
            </LabeledList.Item>

            <LabeledList.Item
              label="光照"
              tooltip="光照低于 40% 时植物会枯萎。蘑菇只需 20%。"
            >
              <ProgressBar
                value={tray_data.light_level}
                maxValue={1}
                ranges={{
                  bad: [0, 0.2],
                  average: [0.2, 0.4],
                  good: [0.4, Infinity],
                }}
              >
                {Math.round(tray_data.light_level * 100)}%
              </ProgressBar>
            </LabeledList.Item>

            <LabeledList.Item
              label="杂草"
              tooltip="降低植物产量。数量过多时可能侵占种植槽。通过耕作清除。"
            >
              <ProgressBar
                value={tray_data.weeds}
                maxValue={tray_data.weeds_max}
                ranges={{
                  good: [-Infinity, 5],
                  average: [5, 10],
                  bad: [10, tray_data.weeds_max],
                }}
              >
                {tray_data.weeds} / {tray_data.weeds_max}
              </ProgressBar>
            </LabeledList.Item>

            <LabeledList.Item
              label="害虫"
              tooltip="伤害植物并降低效力。使用杀虫营养液清除。"
            >
              <ProgressBar
                value={tray_data.pests}
                maxValue={tray_data.pests_max}
                ranges={{
                  good: [-Infinity, 4],
                  average: [4, 8],
                  bad: [8, tray_data.pests_max],
                }}
              >
                {tray_data.pests} / {tray_data.pests_max}
              </ProgressBar>
            </LabeledList.Item>

            <LabeledList.Item
              label="毒素"
              tooltip="伤害植物。使用解毒营养液清除。"
            >
              <ProgressBar
                value={tray_data.toxins}
                maxValue={tray_data.toxins_max}
                ranges={{
                  good: [-Infinity, 0],
                  average: [1, Math.round(tray_data.toxins_max * 0.5)],
                  bad: [Math.round(tray_data.toxins_max * 0.5), Infinity],
                }}
              >
                {tray_data.toxins} / {tray_data.toxins_max}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
}

export function PlantAnalyzerTrayChems(props) {
  const { data } = useBackend<PlantAnalyzerData>();
  const { tray_data } = data;

  if (!tray_data) {
    // This shouldn't be rendered if tray_data is null
    return null;
  }

  return (
    <Section title={capitalizeFirst(`${tray_data.name}养分`)}>
      {tray_data.reagents.length === 0 ? (
        <NoticeBox color="red" align="center">
          未检测到试剂
        </NoticeBox>
      ) : (
        <Table>
          <Table.Row header>
            <Table.Cell>试剂</Table.Cell>
            <Table.Cell>容量</Table.Cell>
          </Table.Row>
          {tray_data.reagents.map((reagent, i) => (
            <Table.Row key={i} className="candystripe">
              <Table.Cell py={0.5} pl={1}>
                {reagent.name}
              </Table.Cell>
              <Table.Cell>{reagent.volume}u</Table.Cell>
            </Table.Row>
          ))}
        </Table>
      )}
    </Section>
  );
}

function nutriToColor(nutri: number, maxNutri: number) {
  if (nutri < maxNutri * 0.3) return 'red';
  if (nutri < maxNutri * 0.7) return 'yellow';
  return 'green';
}
