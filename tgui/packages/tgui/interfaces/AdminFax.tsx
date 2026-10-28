import { useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  Input,
  Knob,
  NumberInput,
  Section,
  Stack,
  TextArea,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { skyratFaxDisplay } from '../localization/skyratSystemsDisplay';
type Data = {
  faxes: string[];
  stamps: string[];
};

const paperNameOptions = [
  '纳米传讯官方报告',
  '辛迪加报告',
] as const;

const fromWhoOptions = ['纳米传讯', '辛迪加'] as const;

export function AdminFax(props) {
  const { act, data } = useBackend<Data>();
  const { faxes = [], stamps = [] } = data;

  const [fax, setFax] = useState('');
  const [saved, setSaved] = useState(false);
  const [paperName, setPaperName] = useState('');
  const [fromWho, setFromWho] = useState('');
  const [rawText, setRawText] = useState('');
  const [stamp, setStamp] = useState('');
  const [stampCoordX, setStampCoordX] = useState(0);
  const [stampCoordY, setStampCoordY] = useState(0);
  const [stampAngle, setStampAngle] = useState(0);

  if (stamp && stamps[0] !== 'None') {
    stamps.unshift('None');
  }

  return (
    <Window title="管理员传真面板" width={400} height={675} theme="admin">
      <Window.Content scrollable>
        <Section
          title="传真菜单"
          buttons={
            <Button
              icon="arrow-up"
              disabled={!fax}
              onClick={() =>
                act('follow', {
                  faxName: fax,
                })
              }
            >
              跟随
            </Button>
          }
        >
          <Dropdown
            placeholder="选择传真机……"
            fluid
            selected={fax}
            options={faxes.map((value) => ({ value, displayText: skyratFaxDisplay(value) }))}
            onSelected={setFax}
          />
        </Section>
        <Section
          title="纸张"
          buttons={
            <Button
              icon="eye"
              disabled={!saved}
              onClick={() =>
                act('preview', {
                  faxName: fax,
                })
              }
            >
              预览
            </Button>
          }
        >
          <Stack fill vertical>
            <Stack.Item>
              <Input
                placeholder="纸张名称……"
                value={paperName}
                fluid
                onChange={setPaperName}
              />
            </Stack.Item>
            <Stack.Item>
              <SourceButtons
                stateSetter={setPaperName}
                options={paperNameOptions}
                tooltip="传真纸顶部的标题。"
              />
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item>
              <Input
                placeholder="发件人……"
                value={fromWho}
                fluid
                onChange={setFromWho}
              />
            </Stack.Item>
            <Stack.Item>
              <SourceButtons
                stateSetter={setFromWho}
                options={fromWhoOptions}
                tooltip="传真日志中记录的发件人。"
              />
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item>
              <TextArea
                placeholder="在此输入内容……"
                height="200px"
                fluid
                value={rawText}
                onChange={setRawText}
              />
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item>
              <Dropdown
                fluid
                options={stamps.map((value) => ({ value, displayText: value === 'None' ? '无' : value }))}
                selected="选择印章（可选）"
                onSelected={(value) => {
                  if (value === 'None') {
                    setStamp('');
                    stamps.shift();
                  } else {
                    setStamp(value);
                  }
                }}
              />
            </Stack.Item>
            <Stack.Item textAlign="center">
              {stamp && (
                <>
                  <h4>
                    X 坐标：{' '}
                    <NumberInput
                      step={1}
                      width="45px"
                      minValue={0}
                      maxValue={300}
                      value={stampCoordX}
                      onChange={(v) => setStampCoordX(v)}
                    />
                  </h4>

                  <h4>
                    Y 坐标：{' '}
                    <NumberInput
                      step={1}
                      width="45px"
                      minValue={0}
                      maxValue={400}
                      value={stampCoordY}
                      onChange={(v) => setStampCoordY(v)}
                    />
                  </h4>

                  <Box textAlign="center">
                    <h4>旋转角度</h4>
                    <Knob
                      size={1.5}
                      value={stampAngle}
                      minValue={0}
                      maxValue={360}
                      animated={false}
                      onChange={(_event, value) => setStampAngle(value)}
                    />
                  </Box>
                </>
              )}
            </Stack.Item>
          </Stack>
        </Section>
        <Section title="操作">
          <Button
            disabled={!saved || !fax}
            icon="paper-plane"
            onClick={() =>
              act('send', {
                faxName: fax,
              })
            }
          >
            发送
          </Button>
          <Button
            icon="floppy-disk"
            color="green"
            onClick={() => {
              setSaved(true);
              act('save', {
                faxName: fax,
                paperName: paperName,
                rawText: rawText,
                stamp: stamp,
                stampX: stampCoordX,
                stampY: stampCoordY,
                stampAngle: stampAngle,
                fromWho: fromWho,
              });
            }}
          >
            保存
          </Button>
          <Button
            disabled={!saved}
            icon="circle-plus"
            onClick={() =>
              act('createPaper', {
                faxName: fax,
              })
            }
          >
            生成纸张
          </Button>
        </Section>
      </Window.Content>
    </Window>
  );
}

type SourceButtonsProps = {
  stateSetter: (source: string) => void;
  options: readonly string[];
  tooltip: string;
};

function SourceButtons(props: SourceButtonsProps) {
  const { stateSetter, options, tooltip } = props;

  return (
    <Tooltip content={tooltip}>
      <Stack fill>
        <Stack.Item grow>
          <Button fluid icon="n" onClick={() => stateSetter(options[0])}>
            纳米传讯
          </Button>
        </Stack.Item>
        <Stack.Item grow>
          <Button fluid icon="s" onClick={() => stateSetter(options[1])}>
            辛迪加
          </Button>
        </Stack.Item>
      </Stack>
    </Tooltip>
  );
}
