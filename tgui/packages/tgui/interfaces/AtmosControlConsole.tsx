import { useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  LabeledList,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import {
  AtmosHandbookContent,
  atmosHandbookHooks,
} from './common/AtmosHandbook';
import { type Gasmix, GasmixParser } from './common/GasmixParser';

type Chamber = {
  id: string;
  name: string;
  gasmix?: Gasmix;
  input_info?: { active: boolean; amount: number };
  output_info?: { active: boolean; amount: number };
};

type Data = {
  chambers: Chamber[];
  maxInput: number;
  maxOutput: number;
  reconnecting: boolean;
  control: boolean;
  defaultGas: string | null;
};

export const AtmosControlConsole = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    chambers = [],
    maxInput,
    maxOutput,
    reconnecting,
    control,
    defaultGas,
  } = data;
  const [chamberId, setChamberId] = useState(chambers[0]?.id);
  const selectedChamber =
    chambers.length === 1
      ? chambers[0]
      : chambers.find((chamber) => chamber.id === chamberId);
  const [setActiveGasId, setActiveReactionId] = atmosHandbookHooks();

  if (defaultGas) {
    setActiveGasId(defaultGas);
  }

  return (
    <Window width={550} height={600}>
      <Window.Content scrollable>
        <Stack vertical fill>
          <Stack.Item>
            {chambers.length > 1 && (
              <Section title="气室选择">
                <Dropdown
                  width="100%"
                  options={chambers.map((chamber) => chamber.name)}
                  selected={selectedChamber?.name}
                  onSelected={(value) =>
                    setChamberId(
                      chambers.find((chamber) => chamber.name === value)?.id ||
                        chambers[0].id,
                    )
                  }
                />
              </Section>
            )}
            <Section
              title={selectedChamber ? selectedChamber.name : '气室读数'}
              buttons={
                !!reconnecting && (
                  <Button
                    icon="undo"
                    content="重新连接"
                    onClick={() => act('reconnect')}
                  />
                )
              }
            >
              {selectedChamber?.gasmix ? (
                <GasmixParser
                  gasmix={selectedChamber.gasmix}
                  gasesOnClick={setActiveGasId}
                  reactionOnClick={setActiveReactionId}
                />
              ) : (
                <Box italic> {'未检测到传感器！'}</Box>
              )}
            </Section>
            {!!selectedChamber && !!control && (
              <Section title="气室控制">
                <Stack>
                  <Stack.Item grow>
                    {selectedChamber.input_info ? (
                      <LabeledList>
                        <LabeledList.Item label="输入注气器">
                          <Button
                            icon={
                              selectedChamber.input_info.active
                                ? 'power-off'
                                : 'times'
                            }
                            content={
                              selectedChamber.input_info.active
                                ? '正在注入'
                                : '关闭'
                            }
                            selected={selectedChamber.input_info.active}
                            onClick={() =>
                              act('toggle_input', {
                                chamber: selectedChamber.id,
                              })
                            }
                          />
                        </LabeledList.Item>
                        <LabeledList.Item label="输入速率">
                          <NumberInput
                            step={1}
                            value={Number(selectedChamber.input_info.amount)}
                            unit="L/s"
                            width="63px"
                            minValue={0}
                            maxValue={maxInput}
                            onChange={(value) =>
                              act('adjust_input', {
                                chamber: selectedChamber.id,
                                rate: value,
                              })
                            }
                          />
                        </LabeledList.Item>
                      </LabeledList>
                    ) : (
                      <Box italic> {'未检测到输入设备！'}</Box>
                    )}
                  </Stack.Item>
                  <Stack.Item grow>
                    {selectedChamber.output_info ? (
                      <LabeledList>
                        <LabeledList.Item label="输出调节器">
                          <Button
                            icon={
                              selectedChamber.output_info.active
                                ? 'power-off'
                                : 'times'
                            }
                            content={
                              selectedChamber.output_info.active
                                ? '开启'
                                : '关闭'
                            }
                            selected={selectedChamber.output_info.active}
                            onClick={() =>
                              act('toggle_output', {
                                chamber: selectedChamber.id,
                              })
                            }
                          />
                        </LabeledList.Item>
                        <LabeledList.Item label="输出压力">
                          <NumberInput
                            value={Number(selectedChamber.output_info.amount)}
                            unit="kPa"
                            width="75px"
                            minValue={0}
                            maxValue={maxOutput}
                            step={10}
                            onChange={(value) =>
                              act('adjust_output', {
                                chamber: selectedChamber.id,
                                rate: value,
                              })
                            }
                          />
                        </LabeledList.Item>
                      </LabeledList>
                    ) : (
                      <Box italic> {'未检测到输出设备！'} </Box>
                    )}
                  </Stack.Item>
                </Stack>
              </Section>
            )}
          </Stack.Item>
          <Stack.Item grow>
            <AtmosHandbookContent />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
