import {
  Box,
  Button,
  Knob,
  LabeledControls,
  LabeledList,
  NoticeBox,
  RoundGauge,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import { formatSiUnit } from 'tgui-core/format';
import { toFixed } from 'tgui-core/math';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';

type Data = {
  // Dynamic
  tankPresent: BooleanLike;
  tankPressure: number;
  leaking: BooleanLike;
  active: BooleanLike;
  transferRate: number;
  lastPressure: number;
  disk: string;
  storage: string;
  records: GasRecord[];
  // Static
  maxTransfer: number;
  leakPressure: number;
  fragmentPressure: number;
  ejectPressure: number;
};

type GasRecord = {
  ref: string;
  name: string;
  timestamp: string;
  source: string;
  gases: Record<string, number>[];
};

const formatPressure = (value) => {
  if (value < 10000) {
    return `${toFixed(value)} kPa`;
  }
  return formatSiUnit(value * 1000, 1, 'Pa');
};

export const TankCompressor = (props) => {
  return (
    <Window title="气罐压缩机" width={440} height={440}>
      <Window.Content>
        <TankCompressorContent />
      </Window.Content>
    </Window>
  );
};

const TankCompressorContent = (props) => {
  const { act, data } = useBackend<Data>();
  const { disk, storage } = data;

  return (
    <Stack vertical fill>
      <TankCompressorControls />
      <Stack.Item grow>
        <Section
          scrollable
          fill
          style={{
            textTransform: 'capitalize',
          }}
          title={disk ? `${disk} (${storage})` : '未插入磁盘'}
          buttons={
            <Button
              icon="eject"
              disabled={!disk}
              onClick={() => act('eject_disk')}
            >
              弹出磁盘
            </Button>
          }
        >
          <TankCompressorRecords />
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const TankCompressorControls = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    tankPresent,
    leaking,
    lastPressure,
    leakPressure,
    fragmentPressure,
    tankPressure,
    maxTransfer,
    active,
    transferRate,
    ejectPressure,
  } = data;
  const pressure = tankPresent ? tankPressure : lastPressure;
  const usingLastData = !!(lastPressure && !tankPresent);
  const notice_color =
    usingLastData || leaking || pressure > fragmentPressure
      ? 'bad'
      : !tankPresent
        ? 'blue'
        : pressure > leakPressure
          ? 'average'
          : 'good';
  const notice_text = usingLastData
    ? '气罐已毁。正在显示最后记录的数据。'
    : !tankPresent
      ? '未检测到气罐'
      : leaking
        ? '气罐泄漏中'
        : !pressure
          ? '未检测到压力'
          : pressure < leakPressure
            ? '气罐压力正常'
            : pressure < fragmentPressure
              ? '泄漏危险'
              : '爆炸危险';

  return (
    <Stack.Item>
      <Section
        title="气罐"
        buttons={
          <Button
            icon="eject"
            disabled={!tankPresent || tankPressure > ejectPressure}
            onClick={() => act('eject_tank')}
          >
            {'弹出气罐'}
          </Button>
        }
      >
        <NoticeBox color={notice_color}>{notice_text}</NoticeBox>
        <LabeledControls p={2}>
          <LabeledControls.Item label="压力">
            <RoundGauge
              size={2.5}
              value={pressure}
              minValue={0}
              maxValue={fragmentPressure * 1.15}
              alertAfter={leakPressure}
              ranges={{
                good: [0, leakPressure],
                average: [leakPressure, fragmentPressure],
                bad: [fragmentPressure, fragmentPressure * 1.15],
              }}
              format={formatPressure}
            />
          </LabeledControls.Item>
          <LabeledControls.Item label="流量">
            <Box position="relative">
              <Knob
                size={2}
                value={transferRate}
                unit="升／秒"
                minValue={0}
                maxValue={maxTransfer}
                step={1}
                stepPixelSize={8}
                onChange={(e, value) =>
                  act('change_rate', {
                    target: value,
                  })
                }
              />
              <Button
                fluid
                position="absolute"
                top="-2px"
                right="-24px"
                color="transparent"
                icon="fast-forward"
                onClick={() =>
                  act('change_rate', {
                    target: maxTransfer,
                  })
                }
              />
              <Button
                fluid
                position="absolute"
                top="16px"
                right="-24px"
                color="transparent"
                icon="undo"
                onClick={() =>
                  act('change_rate', {
                    target: 0,
                  })
                }
              />
            </Box>
          </LabeledControls.Item>
          <LabeledControls.Item label="压缩机">
            <Button
              my={0.5}
              lineHeight={2}
              fontSize="18px"
              icon="power-off"
              disabled={!tankPresent || (!!leaking && pressure < leakPressure)}
              selected={active}
              onClick={() => act('toggle_injection')}
            >
              {active ? '开启' : '关闭'}
            </Button>
          </LabeledControls.Item>
        </LabeledControls>
      </Section>
    </Stack.Item>
  );
};

const TankCompressorRecords = (props) => {
  const { act, data } = useBackend<Data>();
  const { records = [], disk } = data;
  const [activeRecordRef, setActiveRecordRef] = useSharedState(
    'recordRef',
    records[0]?.ref,
  );
  const activeRecord =
    !!activeRecordRef &&
    records.find((record) => activeRecordRef === record.ref);
  if (records.length === 0) {
    return (
      <Stack.Item grow>
        <NoticeBox>无记录</NoticeBox>
      </Stack.Item>
    );
  }

  return (
    <Stack.Item grow>
      <Stack fill>
        <Stack.Item mr={2}>
          <Tabs vertical>
            {records.map((record) => (
              <Tabs.Tab
                icon="file"
                key={record.name}
                selected={record.ref === activeRecordRef}
                onClick={() => setActiveRecordRef(record.ref)}
              >
                {record.name}
              </Tabs.Tab>
            ))}
          </Tabs>
        </Stack.Item>
        {activeRecord ? (
          <Stack.Item grow>
            <LabeledList>
              <LabeledList.Item label="标题">
                {activeRecord.name}
              </LabeledList.Item>
              <LabeledList.Item label="时间">
                {activeRecord.timestamp}
              </LabeledList.Item>
              <LabeledList.Item label="来源">
                {activeRecord.source}
              </LabeledList.Item>
              <LabeledList.Item label="气体">
                <LabeledList>
                  {Object.keys(activeRecord.gases).map((gas_name) => (
                    <LabeledList.Item label={gas_name} key={gas_name}>
                      {`${
                        activeRecord.gases[gas_name]
                          ? activeRecord.gases[gas_name].toFixed(2)
                          : '-'
                      } 摩尔`}
                    </LabeledList.Item>
                  ))}
                </LabeledList>
              </LabeledList.Item>
              <LabeledList.Item label="操作">
                <Button
                  icon="floppy-disk"
                  content="保存到磁盘"
                  disabled={!disk}
                  tooltip="将选中的记录保存到插入的数据磁盘。"
                  tooltipPosition="bottom"
                  onClick={() => {
                    act('save_record', {
                      ref: activeRecord.ref,
                    });
                  }}
                />
                <Button.Confirm
                  icon="trash"
                  color="bad"
                  onClick={() => {
                    act('delete_record', {
                      ref: activeRecord.ref,
                    });
                  }}
                />
              </LabeledList.Item>
            </LabeledList>
          </Stack.Item>
        ) : (
          <Stack.Item grow={1} basis={0}>
            <NoticeBox>未选择记录</NoticeBox>
          </Stack.Item>
        )}
      </Stack>
    </Stack.Item>
  );
};
