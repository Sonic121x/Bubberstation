import { useState } from 'react';
import {
  Button,
  NoticeBox,
  Stack,
  Table,
  TextArea,
} from 'tgui-core/components';
import { libraryActionDisplay as zh } from '../../localization/zhLibraryDisplay';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { useModifyState } from './hooks';
import { type LibraryAdminData, ModifyTypes } from './types';

function getActionColor(reason: string) {
  switch (reason) {
    case 'deleted':
      return 'rgba(255, 0, 0, 0.4)';
    case 'undeleted':
      return 'rgba(0, 120, 70, 0.4)';
    default:
      return 'rgba(0, 0, 0, 0.4)';
  }
}

export function ModifyPage(props) {
  const { act, data } = useBackend<LibraryAdminData>();

  const { can_db_request, view_raw, history } = data;
  const { modifyMethodState, modifyTargetState } = useModifyState();

  const [modifyMethod, setModifyMethod] = modifyMethodState;
  const [modifyTarget, setModifyTarget] = modifyTargetState;
  const [reason, setReason] = useState('null');

  const entries = history[modifyTarget.toString()]
    ? history[modifyTarget.toString()].sort((a, b) => b.id - a.id)
    : [];

  return (
    <Window.Content scrollable>
      <NoticeBox>
        注意！游戏内无法彻底删除书籍。
        <br />
        此操作相当于点击“对所有人
        隐藏此书”的按钮。
        <br />
        如果确实需要彻底删除某本书，
        请联系数据库管理员。
      </NoticeBox>
      <Stack>
        <Stack.Item fontSize="25px" pb={2}>
          你为什么要{zh(modifyMethod)}这本书？
        </Stack.Item>
        <Stack.Item fontSize="17px">
          <Button
            onClick={() =>
              act('view_book', {
                book_id: modifyTarget,
              })
            }
            icon="book-reader"
          >
            查看
          </Button>
        </Stack.Item>
        <Stack.Item fontSize="17px">
          <Button
            textAlign="right"
            onClick={() => act('toggle_raw')}
            color={view_raw ? 'purple' : 'blue'}
            icon={view_raw ? 'theater-masks' : 'glasses'}
          >
            {view_raw ? '源文本' : '正常显示'}
          </Button>
        </Stack.Item>
      </Stack>
      <TextArea
        fluid
        height="20vh"
        width="100%"
        backgroundColor="black"
        textColor="white"
        onChange={setReason}
      />
      <Stack justify="center" align="center" pt={1} pb={1}>
        <Stack.Item>
          <Button
            disabled={!can_db_request}
            icon="upload"
            fontSize="18px"
            color="good"
            onClick={() => {
              switch (modifyMethod) {
                case ModifyTypes.Delete:
                  act('hide_book', {
                    book_id: modifyTarget,
                    delete_reason: reason,
                  });
                  break;
                case ModifyTypes.Restore:
                  act('unhide_book', {
                    book_id: modifyTarget,
                    free_reason: reason,
                  });
                  break;
              }
              setModifyMethod('');
              setModifyTarget(0);
            }}
            lineHeight={2}
          >
            {zh(modifyMethod)}
          </Button>
        </Stack.Item>
        <Stack.Item>
          <Button
            icon="times"
            fontSize="18px"
            color="bad"
            onClick={() => {
              setModifyMethod('');
              setModifyTarget(0);
            }}
            lineHeight={2}
          >
            返回
          </Button>
        </Stack.Item>
      </Stack>
      <Table>
        <Table.Row backgroundColor="rgba(0,0,0, 0.4)" header>
          <Table.Cell className="LibraryAdmin_RecordHeader">编号</Table.Cell>
          <Table.Cell className="LibraryAdmin_RecordHeader">操作</Table.Cell>
          <Table.Cell className="LibraryAdmin_RecordHeader">原因</Table.Cell>
          <Table.Cell className="LibraryAdmin_RecordHeader">
            管理员账号
          </Table.Cell>
          <Table.Cell className="LibraryAdmin_RecordHeader">
            日期时间
          </Table.Cell>
        </Table.Row>
        {entries.map((entry) => (
          <Table.Row
            key={entry.id}
            backgroundColor={getActionColor(entry.action)}
          >
            <Table.Cell className="LibraryAdmin_RecordCell">
              {entry.id}
            </Table.Cell>
            <Table.Cell className="LibraryAdmin_RecordCell">
              {zh(entry.action)}
            </Table.Cell>
            <Table.Cell
              className="LibraryAdmin_RecordCell"
              style={{
                whiteSpace: 'pre-wrap',
              }}
            >
              {entry.reason}
            </Table.Cell>
            <Table.Cell className="LibraryAdmin_RecordCell">
              {entry.ckey}
            </Table.Cell>
            <Table.Cell className="LibraryAdmin_RecordCell">
              {entry.datetime}
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Window.Content>
  );
}
