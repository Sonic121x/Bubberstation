import { useState } from 'react';
import {
  AnimatedNumber,
  Box,
  Button,
  LabeledList,
  NumberInput,
  RoundGauge,
  Section,
  Stack,
} from 'tgui-core/components';
import { round, toFixed } from 'tgui-core/math';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import type { MixingData, Reagent } from './ChemMixingChamber';

type ReactingData = MixingData & {
  ph: number;
  reagentAcidic: number;
  reagentAlkaline: number;
  catalysts: Reagent[];
};

export const ChemReactionChamber = (props) => {
  const { act, data } = useBackend<ReactingData>();

  const [reagentQuantity, setReagentQuantity] = useState(1);

  const {
    emptying,
    temperature,
    ph,
    targetTemp,
    isReacting,
    reagentAcidic,
    reagentAlkaline,
  } = data;
  const reagents = data.reagents || [];
  const catalysts = data.catalysts || [];
  return (
    <Window width={290} height={570}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Section
              title="反应条件"
              buttons={
                <Stack>
                  <Stack.Item mt={0.3}>{'目标：'}</Stack.Item>
                  <Stack.Item>
                    <NumberInput
                      tickWhileDragging
                      width="65px"
                      unit="K"
                      step={10}
                      stepPixelSize={3}
                      value={round(targetTemp, 0.1)}
                      minValue={0}
                      maxValue={1000}
                      onChange={(value) =>
                        act('temperature', {
                          target: value,
                        })
                      }
                    />
                  </Stack.Item>
                </Stack>
              }
            >
              <Stack vertical>
                <Stack.Item>
                  <Stack fill>
                    <Stack.Item textColor="label">
                      当前温度：
                    </Stack.Item>
                    <Stack.Item grow>
                      <AnimatedNumber
                        value={temperature}
                        format={(value) => `${toFixed(value)} K`}
                      />
                    </Stack.Item>
                    <Stack.Item grow>
                      <RoundGauge
                        value={ph}
                        minValue={0}
                        maxValue={14}
                        format={() => ''}
                        position="absolute"
                        size={1.5}
                        top={0.5}
                        right={0.5}
                        ranges={{
                          red: [-0.22, 1.5],
                          orange: [1.5, 3],
                          yellow: [3, 4.5],
                          olive: [4.5, 5],
                          good: [5, 6],
                          green: [6, 8.5],
                          teal: [8.5, 9.5],
                          blue: [9.5, 11],
                          purple: [11, 12.5],
                          violet: [12.5, 14],
                        }}
                      />
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
                <Stack.Item>
                  <Stack fill>
                    <Stack.Item textColor="label">{'ph:'}</Stack.Item>
                    <Stack.Item grow={15}>{ph}</Stack.Item>
                    <Stack.Item grow mt={1} mb={-0.5}>
                      <Button
                        color="transparent"
                        icon="question"
                        tooltip={`
                        在化学中，pH 是用于表示
                        水溶液酸碱程度的标度。
                        酸性溶液的 pH 值
                        低于碱性溶液。
                        pH 采用对数标度，
                        其值越低，溶液中的
                        氢离子浓度越高。`}
                        tooltipPosition="bottom-start"
                      />
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <Section
              title="设置"
              fill
              scrollable
              buttons={
                (isReacting && (
                  <Box inline bold color={'purple'}>
                    {'反应中'}
                  </Box>
                )) || (
                  <Box
                    fontSize="16px"
                    inline
                    bold
                    color={emptying ? 'bad' : 'good'}
                  >
                    {emptying ? '排出中' : '注入中'}
                  </Box>
                )
              }
            >
              <Stack vertical fill>
                <Stack.Item>
                  <LabeledList>
                    <LabeledList.Item label="pH 下限">
                      <NumberInput
                        tickWhileDragging
                        value={reagentAcidic}
                        minValue={0}
                        maxValue={14}
                        step={1}
                        stepPixelSize={3}
                        width="39px"
                        onChange={(value) =>
                          act('acidic', {
                            target: value,
                          })
                        }
                      />
                    </LabeledList.Item>
                    <LabeledList.Item label="pH 上限">
                      <NumberInput
                        tickWhileDragging
                        value={reagentAlkaline}
                        minValue={0}
                        maxValue={14}
                        step={1}
                        stepPixelSize={3}
                        width="39px"
                        onChange={(value) =>
                          act('alkaline', {
                            target: value,
                          })
                        }
                      />
                      <Box inline mr={1} />
                    </LabeledList.Item>
                  </LabeledList>
                </Stack.Item>
                <Stack.Item>
                  <Stack fill>
                    <Stack.Item grow>
                      <Button
                        color="good"
                        icon="plus"
                        onClick={() =>
                          act('add', {
                            amount: reagentQuantity,
                          })
                        }
                      >
                        添加试剂
                      </Button>
                    </Stack.Item>
                    <Stack.Item>
                      <NumberInput
                        tickWhileDragging
                        value={reagentQuantity}
                        minValue={1}
                        maxValue={100}
                        step={1}
                        stepPixelSize={3}
                        width="39px"
                        onChange={(value) => setReagentQuantity(value)}
                      />
                      <Box inline mr={1} />
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
                <Stack.Item>
                  <Stack vertical>
                    {reagents.map((reagent) => (
                      <Stack.Item key={reagent.name}>
                        <Stack fill>
                          <Stack.Item mt={0.25} textColor="label">
                            {`${reagent.name}:`}
                          </Stack.Item>
                          <Stack.Item mt={0.25} grow>
                            {reagent.volume}
                          </Stack.Item>

                          <Stack.Item>
                            <Button
                              color="transparent"
                              tooltip={`
                                此按钮将该试剂设为催化剂。
                                催化剂不会在反应结束时排出反应室，
                                对某些反应很有用。`}
                              tooltipPosition="bottom-start"
                              onClick={() =>
                                act('catalyst', {
                                  chem: reagent.name,
                                })
                              }
                            >
                              催
                            </Button>
                          </Stack.Item>
                          <Stack.Item>
                            <Button
                              icon="minus"
                              color="bad"
                              onClick={() =>
                                act('remove', {
                                  chem: reagent.name,
                                })
                              }
                            />
                          </Stack.Item>
                        </Stack>
                      </Stack.Item>
                    ))}
                  </Stack>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item grow={0.7}>
            <Section title="催化剂" fill scrollable>
              <Stack.Item>
                <Stack vertical fill>
                  {catalysts.map((reagent) => (
                    <Stack.Item key={reagent.name}>
                      <Stack fill>
                        <Stack.Item mt={0.25} textColor="label">
                          {`${reagent.name}:`}
                        </Stack.Item>
                        <Stack.Item mt={0.25} grow>
                          {reagent.volume}
                        </Stack.Item>
                        <Stack.Item>
                          <Button
                            color="bad"
                            onClick={() =>
                              act('catremove', {
                                chem: reagent.name,
                              })
                            }
                          >
                            催
                          </Button>
                        </Stack.Item>
                      </Stack>
                    </Stack.Item>
                  ))}
                </Stack>
              </Stack.Item>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
