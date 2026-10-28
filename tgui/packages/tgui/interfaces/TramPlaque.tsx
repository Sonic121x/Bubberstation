import { LabeledList, NoticeBox, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  currentTram: Tram[];
  previousTrams: Tram[];
};

type Tram = {
  serialNumber: string;
  mfgDate: string;
  distanceTravelled: number;
  tramCollisions: number;
};

export const TramPlaque = (props) => {
  const { data } = useBackend<Data>();
  const { currentTram = [], previousTrams = [] } = data;

  return (
    <Window
      title="电车信息铭牌"
      width={600}
      height={360}
      theme="dark"
    >
      <Window.Content>
        <NoticeBox info>中村工程公司出品：天际电车六型</NoticeBox>
        <Section
          title={
            currentTram.map((serialNumber) => serialNumber.serialNumber) +
            ' - 制造于 ' +
            currentTram.map((serialNumber) => serialNumber.mfgDate)
          }
        >
          <LabeledList>
            <LabeledList.Item label="行驶里程">
              {currentTram.map(
                (serialNumber) => serialNumber.distanceTravelled / 1000,
              )}{' '}
              km
            </LabeledList.Item>
            <LabeledList.Item label="碰撞次数">
              {currentTram.map((serialNumber) => serialNumber.tramCollisions)}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="电车历史记录">
          <Stack fill g={0}>
            <Stack.Item m={1} grow>
              <b>序列号</b>
            </Stack.Item>
            <Stack.Item m={1} grow>
              <b>制造日期</b>
            </Stack.Item>
            <Stack.Item m={1} grow>
              <b>里程</b>
            </Stack.Item>
            <Stack.Item m={1} grow>
              <b>碰撞次数</b>
            </Stack.Item>
          </Stack>
          <Stack vertical fill>
            {previousTrams.map((tram_entry) => (
              <Stack.Item key={tram_entry.serialNumber}>
                <Stack fill g={0}>
                  <Stack.Item m={1} grow>
                    {tram_entry.serialNumber}
                  </Stack.Item>
                  <Stack.Item m={1} grow>
                    {tram_entry.mfgDate}
                  </Stack.Item>
                  <Stack.Item m={1} grow>
                    {tram_entry.distanceTravelled / 1000} km
                  </Stack.Item>
                  <Stack.Item m={1} grow>
                    {tram_entry.tramCollisions}
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
