import {
  Button,
  Input,
  LabeledList,
  NoticeBox,
  NumberInput,
  Section,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { naniteControlsDisplay as zh } from '../localization/zhNaniteControlsDisplay';
export const NaniteRemote = (props, context) => {
  return (
    <Window width={420} height={500}>
      <Window.Content scrollable>
        <NaniteRemoteContent />
      </Window.Content>
    </Window>
  );
};

interface NaniteProgramProps {
  code: number;
  locked: boolean;
  mode: string;
  program_name: string;
  relay_code: number;
  comms: boolean;
  message: string;
  saved_settings: Array<SavedSetting>;
}

interface SavedSetting {
  id: string;
  name: string;
  mode: string;
  code: number;
  relay_code: number;
}

export const NaniteRemoteContent = () => {
  const { act, data } = useBackend<NaniteProgramProps>();
  const {
    code,
    locked,
    mode,
    program_name,
    relay_code,
    comms,
    message,
    saved_settings = [],
  } = data;

  const modes = ['Off', 'Local', 'Targeted', 'Area', 'Relay'];

  if (locked) {
    return <NoticeBox>此界面已锁定。</NoticeBox>;
  }

  return (
    <>
      <Section
        title="纳米机器人控制"
        buttons={
          <Button icon="lock" onClick={() => act('lock')}>
            锁定界面
          </Button>
        }
      >
        <LabeledList>
          <LabeledList.Item label="名称">
            <Input
              value={program_name}
              maxLength={14}
              width="130px"
              onChange={(value) =>
                act('update_name', {
                  name: value,
                })
              }
            />
            <Button icon="save" onClick={() => act('save')}>
              保存
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label={comms ? '通信代码' : '信号代码'}>
            <NumberInput
              value={code}
              minValue={0}
              maxValue={9999}
              width="47px"
              step={1}
              stepPixelSize={2}
              onChange={(value) =>
                act('set_code', {
                  code: value,
                })
              }
            />
          </LabeledList.Item>
          {!!comms && (
            <LabeledList.Item label="消息">
              <Input
                value={message}
                width="270px"
                onChange={(value) =>
                  act('set_message', {
                    value: value,
                  })
                }
              />
            </LabeledList.Item>
          )}
          {mode === 'Relay' && (
            <LabeledList.Item label="中继代码">
              <NumberInput
                value={relay_code}
                minValue={0}
                maxValue={9999}
                width="47px"
                step={1}
                stepPixelSize={2}
                onChange={(value) =>
                  act('set_relay_code', {
                    code: value,
                  })
                }
              />
            </LabeledList.Item>
          )}
          <LabeledList.Item label="信号模式">
            {modes.map((key) => (
              <Button
                key={key}
                selected={mode === key}
                onClick={() =>
                  act('select_mode', {
                    mode: key,
                  })
                }
              >
                {zh(key)}
              </Button>
            ))}
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="已保存的设置">
        {saved_settings.length > 0 ? (
          <Table>
            <Table.Row header>
              <Table.Cell width="35%">名称</Table.Cell>
              <Table.Cell width="20%">模式</Table.Cell>
              <Table.Cell collapsing>代码</Table.Cell>
              <Table.Cell collapsing>中继</Table.Cell>
            </Table.Row>
            {saved_settings.map((setting) => (
              <Table.Row key={setting.id} className="candystripe">
                <Table.Cell bold color="label">
                  {setting.name}:
                </Table.Cell>
                <Table.Cell>{zh(setting.mode)}</Table.Cell>
                <Table.Cell>{setting.code}</Table.Cell>
                <Table.Cell>
                  {setting.mode === 'Relay' && setting.relay_code}
                </Table.Cell>
                <Table.Cell textAlign="right">
                  <Button
                    icon="upload"
                    color="good"
                    onClick={() =>
                      act('load', {
                        save_id: setting.id,
                      })
                    }
                  />
                  <Button
                    icon="minus"
                    color="bad"
                    onClick={() =>
                      act('remove_save', {
                        save_id: setting.id,
                      })
                    }
                  />
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        ) : (
          <NoticeBox>目前没有已保存的设置</NoticeBox>
        )}
      </Section>
    </>
  );
};
