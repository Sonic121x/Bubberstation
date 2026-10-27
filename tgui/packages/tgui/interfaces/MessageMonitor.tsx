import { type Dispatch, type SetStateAction, useState } from 'react';
import {
  Box,
  Button,
  Input,
  NoticeBox,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { areaDisplay, type BatchDisplayData } from '../localization/batchThreeDisplay';
import { useBackend } from '../backend';
import { Window } from '../layouts';
import { machineChoiceDisplay } from './common/machineChoiceDisplay';
enum Screen {
  Main,
  MessageLogs,
  RequestLogs,
  Hacked,
}

type Data = BatchDisplayData & {
  screen: Screen;
  status: BooleanLike;
  server_status: BooleanLike;
  auth: BooleanLike;
  password: string;
  is_malf: BooleanLike;
  error_message: string;
  success_message: string;
  notice_message: string;
  requests: Request[];
  messages: Message[];
  is_on_station: BooleanLike;
};

type Request = {
  ref: string;
  message: string;
  stamp: string;
  departament: string;
  id_auth: string;
};

type Message = {
  ref: string;
  message: string;
  sender: string;
  recipient: string;
};

const RequestLogsScreen = (props) => {
  const { act, data } = useBackend<Data>();
  const { requests = [] } = data;
  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Section
          fill
          scrollable
          title="请求"
          buttons={
            <Button
              content="主菜单"
              icon="home"
              onClick={() => act('return_home')}
            />
          }
        >
          <Table>
            <Table.Row header>
              <Table.Cell>删除</Table.Cell>
              <Table.Cell>消息</Table.Cell>
              <Table.Cell>印章</Table.Cell>
              <Table.Cell>部门</Table.Cell>
              <Table.Cell>身份认证</Table.Cell>
            </Table.Row>
            {requests?.map((request) => (
              <Table.Row key={request.ref} className="candystripe">
                <Table.Cell>
                  <Button
                    icon="trash"
                    color="red"
                    onClick={() => act('delete_request', { ref: request.ref })}
                  />
                </Table.Cell>
                <Table.Cell>{request.message}</Table.Cell>
                <Table.Cell>{request.stamp}</Table.Cell>
                <Table.Cell>{machineChoiceDisplay(areaDisplay(request.departament, data))}</Table.Cell>
                <Table.Cell>{request.id_auth}</Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const MessageLogsScreen = (props) => {
  const { act, data } = useBackend<Data>();
  const { messages = [] } = data;
  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Section
          fill
          scrollable
          title="已存储消息"
          buttons={
            <Button
              content="主菜单"
              icon="home"
              onClick={() => act('return_home')}
            />
          }
        >
          <Table>
            <Table.Row header>
              <Table.Cell>删除</Table.Cell>
              <Table.Cell>发件人</Table.Cell>
              <Table.Cell>收件人</Table.Cell>
              <Table.Cell>消息</Table.Cell>
            </Table.Row>
            {messages?.map((message) => (
              <Table.Row key={message.ref} className="candystripe">
                <Table.Cell>
                  <Button
                    icon="trash"
                    color="red"
                    onClick={() => act('delete_message', { ref: message.ref })}
                  />
                </Table.Cell>
                <Table.Cell>{message.sender}</Table.Cell>
                <Table.Cell>{message.recipient}</Table.Cell>
                <Table.Cell>
                  <Box
                    as="span"
                    dangerouslySetInnerHTML={{ __html: message.message }}
                  />
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const HackedScreen = (props) => {
  return (
    <Stack.Item grow>
      <Stack fill vertical>
        <Stack.Item grow />
        <Stack.Item align="center" grow>
          <Box color="red" fontSize="18px" bold mt={5}>
            错%*#误：严#%^重系&@统故++~|障……
          </Box>
          <Box color="red" fontSize="18px" bold mt={5}>
            正*b在启&*动重-00启协/.\;议……
          </Box>
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

const MainScreenAuth = (props: AuthScreenProps) => {
  const { auth_password, setPassword } = props;

  const { act, data } = useBackend<Data>();
  const { status, is_malf, is_on_station } = data;

  return (
    <>
      <Stack.Item>
        <Section>
          <Input
            value={auth_password}
            onChange={setPassword}
            placeholder="密码"
          />
          <Button
            content={'退出登录'}
            onClick={() => act('auth', { auth_password: auth_password })}
          />
          <Button
            icon={status ? 'power-off' : 'times'}
            content={status ? '开启' : '关闭'}
            color={status ? 'green' : 'red'}
            onClick={() => act('turn_server')}
          />
          {is_malf === 1 && (
            <Button
              icon="terminal"
              content="入侵"
              color="red"
              disabled
              onClick={() => act('hack')}
            />
          )}
        </Section>
      </Stack.Item>
      <Table>
        <Table.Row header>
          <Table.Cell>选项</Table.Cell>
          <Table.Cell>说明</Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell>
            <Button
              content={'查看消息日志'}
              onClick={() => act('view_message_logs')}
            />
          </Table.Cell>
          <Table.Cell>显示所有已发送的消息</Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell>
            <Button
              content={'查看请求控制台日志'}
              onClick={() => act('view_request_logs')}
            />
          </Table.Cell>
          <Table.Cell>
            显示所有通过请求控制台发送的请求
          </Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell>
            <Button.Confirm
              content={'清除消息日志'}
              onClick={() => act('clear_message_logs')}
            />
          </Table.Cell>
          <Table.Cell>清除消息日志</Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell>
            <Button.Confirm
              content={'清除请求控制台日志'}
              onClick={() => act('clear_request_logs')}
            />
          </Table.Cell>
          <Table.Cell>清除请求控制台日志</Table.Cell>
        </Table.Row>
        {!!is_on_station && (
          <Table.Row>
            <Table.Cell>
              <Button
                content={'设置自定义密钥'}
                onClick={() => act('set_key')}
              />
            </Table.Cell>
            <Table.Cell>更改解密密钥</Table.Cell>
          </Table.Row>
        )}
        <Table.Row>
          <Table.Cell>
            <Button
              content={'发送管理员消息'}
              onClick={() => act('send_fake_message')}
            />
          </Table.Cell>
          <Table.Cell>向用户的 PDA 发送自定义消息</Table.Cell>
        </Table.Row>
      </Table>
    </>
  );
};

type AuthScreenProps = {
  auth_password: string;
  setPassword: Dispatch<SetStateAction<string>>;
};

const MainScreenNotAuth = (props: AuthScreenProps) => {
  const { auth_password, setPassword } = props;
  const { act, data } = useBackend<Data>();
  const { status, is_malf } = data;

  return (
    <>
      <Stack.Item>
        <Section>
          <Input
            value={auth_password}
            onChange={setPassword}
            placeholder="密码"
          />
          <Button onClick={() => act('auth', { auth_password: auth_password })}>
            认证
          </Button>
          <Button
            icon={status ? 'power-off' : 'times'}
            color={status ? 'green' : 'red'}
            disabled
            onClick={() => act('turn_server')}
          >
            {status ? '开启' : '关闭'}
          </Button>
          {!!is_malf && (
            <Button color="red" onClick={() => act('hack')}>
              入侵
            </Button>
          )}
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <Section fill scrollable title="选择选项">
          <Table>
            <Table.Row header>
              <Table.Cell>选项</Table.Cell>
              <Table.Cell>说明</Table.Cell>
            </Table.Row>
            <Table.Row>
              <Table.Cell>
                <Button
                  content={'连接服务器'}
                  onClick={() => act('link_server')}
                />
              </Table.Cell>
              <Table.Cell>连接到服务器</Table.Cell>
            </Table.Row>
          </Table>
        </Section>
      </Stack.Item>
    </>
  );
};

const MainScreen = (props) => {
  const { data } = useBackend<Data>();
  const { auth, password } = data;

  const [auth_password, setPassword] = useState(password);

  return (
    <Stack fill vertical>
      {auth ? (
        <MainScreenAuth
          auth_password={auth_password}
          setPassword={setPassword}
        />
      ) : (
        <MainScreenNotAuth
          auth_password={auth_password}
          setPassword={setPassword}
        />
      )}
    </Stack>
  );
};

export const MessageMonitor = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    screen,
    error_message,
    success_message,
    notice_message,
    server_status,
  } = data;
  return (
    <Window width={700} height={400}>
      <Window.Content>
        <Stack vertical fill>
          {server_status ? (
            <>
              <Stack.Item>
                {!!error_message && (
                  <NoticeBox color="red">{error_message}</NoticeBox>
                )}
              </Stack.Item>
              <Stack.Item>
                {!!success_message && (
                  <NoticeBox color="green">{success_message}</NoticeBox>
                )}
              </Stack.Item>
              <Stack.Item grow>
                {(screen === Screen.Main && <MainScreen />) ||
                  (screen === Screen.MessageLogs && <MessageLogsScreen />) ||
                  (screen === Screen.RequestLogs && <RequestLogsScreen />) ||
                  (screen === Screen.Hacked && <HackedScreen />)}
              </Stack.Item>
              <Stack.Item>
                {!!notice_message && (
                  <NoticeBox color="yellow">{notice_message}</NoticeBox>
                )}
              </Stack.Item>
              <label>
                第 514 号规定禁止向部门主管发送包含
                情色描绘内容的消息。
              </label>
            </>
          ) : (
            <>
              <Stack.Item>
                <NoticeBox color="red">
                  未找到服务器，点击按钮扫描网络
                </NoticeBox>
              </Stack.Item>
              <Stack.Item>
                <Button
                  content="连接服务器"
                  onClick={() => act('connect_server')}
                />
              </Stack.Item>
            </>
          )}
        </Stack>
      </Window.Content>
    </Window>
  );
};
