import { sortBy } from 'es-toolkit';
import { useState } from 'react';
import {
  Box,
  Button,
  Icon,
  Input,
  LabeledList,
  Section,
  Table,
} from 'tgui-core/components';
import { flow } from 'tgui-core/fp';
import { clamp } from 'tgui-core/math';
import type { BooleanLike } from 'tgui-core/react';
import { createSearch } from 'tgui-core/string';
import { vecLength, vecSubtract } from 'tgui-core/vector';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  power: BooleanLike;
  tag: string;
  updating: BooleanLike;
  globalmode: BooleanLike;
  currentArea: string;
  currentCoords: string;
  signals: GpsSignal[];
};

type GpsSignal = {
  entrytag: string;
  coords: string;
  dist?: number;
  degrees?: number;
};

const coordsToVec = (coords: string) => coords.split(', ').map(parseFloat);

export const Gps = () => {
  const { act, data } = useBackend<Data>();
  const { currentArea, currentCoords, globalmode, power, tag, updating } = data;
  const [searchName, setSearchName] = useState('');
  const searchByName = createSearch<GpsSignal>(
    searchName,
    (gps) => gps.entrytag,
  );
  const signals = flow([
    (signals: GpsSignal[]) =>
      signals.map((signal, index) => {
        // Calculate distance to the target. BYOND distance is capped to 127,
        // that's why we roll our own calculations here.
        const dist =
          signal.dist &&
          Math.round(
            vecLength(
              vecSubtract(
                coordsToVec(currentCoords),
                coordsToVec(signal.coords),
              ),
            ),
          );
        return { ...signal, dist, index };
      }),
    (signals: GpsSignal[]) =>
      sortBy(signals, [
        // Signals with distance metric go first
        (signal) => signal.dist === undefined,
        // Sort alphabetically
        (signal) => signal.entrytag,
      ]),
  ])(data.signals || []);
  return (
    <Window title="全球定位系统" width={470} height={700}>
      <Window.Content scrollable>
        <Section
          title="控制"
          buttons={
            <Button
              icon="power-off"
              selected={power}
              onClick={() => act('power')}
            >
              {power ? '开启' : '关闭'}
            </Button>
          }
        >
          <LabeledList>
            <LabeledList.Item label="标签">
              <Button icon="pencil-alt" onClick={() => act('rename')}>
                {tag}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="扫描模式">
              <Button
                icon={updating ? 'unlock' : 'lock'}
                color={!updating && 'bad'}
                onClick={() => act('updating')}
              >
                {updating ? '自动' : '手动'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="范围">
              <Button
                icon="sync"
                selected={!globalmode}
                onClick={() => act('globalmode')}
              >
                {globalmode ? '最大' : '本地'}
              </Button>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {!!power && (
          <>
            <Section title="当前位置">
              <Box fontSize="18px">
                {currentArea} ({currentCoords})
              </Box>
            </Section>
            <Section
              title="检测到的信号"
              buttons={
                <Input
                  placeholder="按名称搜索……"
                  width="200px"
                  value={searchName}
                  onChange={(value) => setSearchName(value)}
                />
              }
            >
              <Table>
                <Table.Row bold>
                  <Table.Cell>名称</Table.Cell>
                  <Table.Cell collapsing>方向</Table.Cell>
                  <Table.Cell collapsing>坐标</Table.Cell>
                </Table.Row>
                {signals
                  .filter(searchByName)
                  .map((signal: GpsSignal & { index: number }) => (
                    <Table.Row
                      key={signal.entrytag + signal.coords + signal.index}
                      className="candystripe"
                    >
                      <Table.Cell bold color="label">
                        {signal.entrytag}
                      </Table.Cell>
                      <Table.Cell
                        collapsing
                        opacity={
                          signal.dist !== undefined &&
                          clamp(
                            1.2 / Math.log(Math.E + signal.dist / 20),
                            0.4,
                            1,
                          )
                        }
                      >
                        {signal.degrees !== undefined && (
                          <Icon
                            mr={1}
                            size={1.2}
                            name="arrow-up"
                            rotation={signal.degrees}
                          />
                        )}
                        {signal.dist !== undefined && `${signal.dist}m`}
                      </Table.Cell>
                      <Table.Cell collapsing>{signal.coords}</Table.Cell>
                    </Table.Row>
                  ))}
              </Table>
            </Section>
          </>
        )}
      </Window.Content>
    </Window>
  );
};
