import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import {
  Box,
  Button,
  Dropdown,
  Flex,
  Icon,
  Input,
  LabeledList,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';

import type * as types from './types';

export const Savefile = (props: {
  setTab: React.Dispatch<React.SetStateAction<number>>;
}) => {
  const { act, data } = useBackend<types.Data>();
  const { setTab } = props;
  const [editing, setEditing] = useState(false);

  return (
    <Flex align="center" justify="center" height="100%">
      <Flex.Item width={40}>
        <LabeledList>
          <LabeledList.Item
            label="当前加载的腹腔存档槽"
            buttons={
              <Button
                selected={editing}
                onClick={() => setEditing(!editing)}
                disabled={data.not_our_owner}
              >
                <Icon name="pencil" />
              </Button>
            }
          >
            {editing && !data.not_our_owner ? (
              <Input
                width={21}
                value={data.current_slot}
                onChange={(name) => act('set_slot_name', { name })}
              />
            ) : (
              data.current_slot
            )}
          </LabeledList.Item>
        </LabeledList>
        <Stack vertical width={40} mt={4}>
          <Stack.Item>
            <Stack>
              <Stack.Item grow>
                <Stack vertical>
                  <Stack.Item>
                    <Button
                      fluid
                      icon="tasks"
                      onClick={() => {
                        act('load_slot');
                        setTab(0);
                      }}
                      disabled={data.not_our_owner}
                    >
                      加载存档槽
                    </Button>
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      fluid
                      icon="upload"
                      onClick={() => act('import_bellies')}
                    >
                      导入
                    </Button>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item grow>
                <Stack vertical>
                  <Stack.Item>
                    <Button
                      fluid
                      icon="copy"
                      onClick={() => act('copy_to_slot')}
                      disabled={data.not_our_owner}
                    >
                      复制到存档槽
                    </Button>
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      fluid
                      icon="download"
                      onClick={() => act('export_bellies')}
                      disabled={data.not_our_owner}
                    >
                      导出
                    </Button>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <Button
              fluid
              icon="cloud-download-alt"
              onClick={() => act('belly_backups')}
              disabled={data.not_our_owner}
            >
              下载备份
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button
              fluid
              icon="magnifying-glass"
              onClick={() => act('toggle_lookup_data')}
              disabled={data.not_our_owner}
            >
              将角色存档槽与腹腔配置关联
            </Button>
          </Stack.Item>
        </Stack>
      </Flex.Item>
    </Flex>
  );
};

export const SlotLookupTable = (props) => {
  const { act, data } = useBackend<types.Data>();
  const { character_slots, vore_slots, lookup_table } = data;

  if (!character_slots || !vore_slots || !lookup_table) {
    return <Box>严重错误</Box>;
  }

  const pickable_vore_slots = Object.keys(vore_slots).map(
    (displayText, value) => {
      return { displayText, value };
    },
  );

  const pickable_character_slots = character_slots
    .map((key, index) => {
      return {
        displayText: key || `新存档槽（${index + 1}）`,
        value: index + 1,
      };
    })
    .filter((value) => !(value.value in lookup_table));

  const [editingRow, setEditingRow] = useState<string | null>(null);
  const [cSlot, setCSlot] = useState<number | null>(null);
  const [vSlot, setVSlot] = useState<number | null>(null);

  return (
    <Section
      title="角色与腹腔配置关联"
      buttons={
        <>
          <Button
            color="green"
            tooltip={
              <Box italic mb={1}>
                要将腹腔存档槽与角色关联，请点击“新增”，
                然后选择角色，以及希望该角色
                自动加载的腹腔存档槽。
              </Box>
            }
          >
            <Icon name="question" />
          </Button>
          <Button color="bad" onClick={() => act('toggle_lookup_data')}>
            <Icon name="window-close-o" />
          </Button>
        </>
      }
      fill
      scrollable
    >
      <Table>
        <Table.Row header>
          <Table.Cell width={15} header collapsing>
            角色姓名
          </Table.Cell>
          <Table.Cell width={15} header collapsing>
            腹腔存档槽
          </Table.Cell>
          <Table.Cell header collapsing />
          <Table.Cell header />
        </Table.Row>
        {!!lookup_table &&
          Object.entries(lookup_table).map(([k, v]) => (
            <Table.Row key={k}>
              <Table.Cell width={15} collapsing verticalAlign="middle">
                {character_slots[parseInt(k, 10) - 1] || `新存档槽（${k}）`}
              </Table.Cell>
              <Table.Cell width={15} collapsing verticalAlign="middle">
                {editingRow === k ? (
                  <Dropdown
                    options={pickable_vore_slots}
                    selected={vSlot as any}
                    displayText={
                      <Box>
                        {pickable_vore_slots.find((x) => x.value === vSlot)
                          ?.displayText || '无'}
                      </Box>
                    }
                    onSelected={(value) => setVSlot(value)}
                  />
                ) : (
                  pickable_vore_slots.find((p) => p.value === v)?.displayText
                )}
              </Table.Cell>
              <Table.Cell collapsing verticalAlign="middle">
                <Button
                  icon="pencil"
                  onClick={() => {
                    if (k === editingRow) {
                      setEditingRow(null);
                    } else {
                      setEditingRow(k);
                    }
                    setCSlot(parseInt(k, 10));
                    setVSlot(v);
                  }}
                  color={k === editingRow ? 'bad' : ''}
                >
                  {k === editingRow ? '取消' : '编辑'}
                </Button>
              </Table.Cell>
              <Table.Cell collapsing verticalAlign="middle">
                {k === editingRow ? (
                  <Button
                    fluid
                    icon="save"
                    color="good"
                    disabled={cSlot === null || vSlot === null}
                    onClick={() => {
                      setEditingRow(null);
                      act('set_lookup_table_entry', {
                        from: cSlot,
                        to: vSlot,
                      });
                    }}
                  >
                    保存
                  </Button>
                ) : (
                  <Button.Confirm
                    fluid
                    color="bad"
                    icon="trash"
                    onClick={() =>
                      act('delete_lookup_table_entry', { slot_to_delete: k })
                    }
                  >
                    删除
                  </Button.Confirm>
                )}
              </Table.Cell>
              <Table.Cell />
            </Table.Row>
          ))}
        {editingRow === 'new' && (
          <Table.Row>
            <Table.Cell width={15} collapsing verticalAlign="middle">
              <Dropdown
                options={pickable_character_slots}
                selected={cSlot as any}
                displayText={
                  <Box>
                    {pickable_character_slots.find((x) => x.value === cSlot)
                      ?.displayText || '无'}
                  </Box>
                }
                onSelected={(value) => setCSlot(value)}
              />
            </Table.Cell>
            <Table.Cell width={15} collapsing verticalAlign="middle">
              <Dropdown
                options={pickable_vore_slots}
                selected={vSlot as any}
                displayText={
                  <Box>
                    {pickable_vore_slots.find((x) => x.value === vSlot)
                      ?.displayText || '无'}
                  </Box>
                }
                onSelected={(value) => setVSlot(value)}
              />
            </Table.Cell>
            <Table.Cell collapsing verticalAlign="middle">
              <Button
                fluid
                icon="plus"
                color="good"
                disabled={vSlot === null || cSlot === null}
                onClick={() => {
                  act('set_lookup_table_entry', { from: cSlot, to: vSlot });
                  setEditingRow(null);
                }}
              >
                添加
              </Button>
            </Table.Cell>
            <Table.Cell collapsing verticalAlign="middle">
              <Button
                fluid
                icon="times"
                color="bad"
                onClick={() => {
                  setEditingRow(null);
                }}
              >
                取消
              </Button>
            </Table.Cell>
            <Table.Cell />
          </Table.Row>
        )}
      </Table>
      <Button
        selected={editingRow === 'new'}
        onClick={() => {
          if (editingRow === 'new') {
            setEditingRow(null);
          } else {
            setEditingRow('new');
          }
          setCSlot(null);
          setVSlot(null);
        }}
        mt={1}
        icon="plus"
      >
        新增
      </Button>
    </Section>
  );
};
