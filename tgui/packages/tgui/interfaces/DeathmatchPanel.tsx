import {
  Button,
  Dropdown,
  Icon,
  NoticeBox,
  Section,
  Stack,
  Table,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Lobby = {
  name: string;
  players: number;
  max_players: number;
  map: string;
  playing: BooleanLike;
};

type Data = {
  hosting: BooleanLike;
  admin: BooleanLike;
  playing: string;
  lobbies: Lobby[];
};

export function DeathmatchPanel(props) {
  const { act, data } = useBackend<Data>();
  const { hosting } = data;

  return (
    <Window title="死斗大厅列表" width={360} height={400}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <NoticeBox danger>
              参与游戏后，你仍可能回到自己的身体中（但
              不作保证）！
            </NoticeBox>
          </Stack.Item>
          <Stack.Item grow>
            <LobbyPane />
          </Stack.Item>
          <Stack.Item>
            <Button
              disabled={!!hosting}
              fluid
              textAlign="center"
              color="good"
              onClick={() => act('host')}
            >
              创建大厅
            </Button>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
}

function LobbyPane(props) {
  const { data } = useBackend<Data>();
  const { lobbies = [] } = data;

  return (
    <Section fill scrollable>
      <Table>
        <Table.Row header>
          <Table.Cell>房主</Table.Cell>
          <Table.Cell>地图</Table.Cell>
          <Table.Cell>
            <Tooltip content="玩家">
              <Icon name="users" />
            </Tooltip>
          </Table.Cell>
          <Table.Cell align="center">
            <Icon name="hammer" />
          </Table.Cell>
        </Table.Row>

        {lobbies.length === 0 && (
          <Table.Row>
            <Table.Cell colSpan={4}>
              <NoticeBox textAlign="center">
                未找到大厅。创建一个吧！
              </NoticeBox>
            </Table.Cell>
          </Table.Row>
        )}

        {lobbies.map((lobby, index) => (
          <LobbyDisplay key={index} lobby={lobby} />
        ))}
      </Table>
    </Section>
  );
}

function LobbyDisplay(props) {
  const { act, data } = useBackend<Data>();
  const { admin, playing, hosting } = data;
  const { lobby } = props;

  const isActive = (!!hosting || !!playing) && playing !== lobby.name;

  return (
    <Table.Row className="candystripe" key={lobby.name}>
      <Table.Cell>
        {!admin ? (
          lobby.name
        ) : (
          <Dropdown
            width={10}
            noChevron
            selected={lobby.name}
            options={[{ value: 'Close', displayText: '关闭' }, { value: 'View', displayText: '查看' }]}
            onSelected={(value) =>
              act('admin', {
                id: lobby.name,
                func: value,
              })
            }
          />
        )}
      </Table.Cell>
      <Table.Cell>{lobby.map}</Table.Cell>
      <Table.Cell collapsing>
        {lobby.players}/{lobby.max_players}
      </Table.Cell>
      <Table.Cell collapsing>
        {!lobby.playing ? (
          <Button
            disabled={isActive}
            color="good"
            onClick={() => act('join', { id: lobby.name })}
            width="100%"
            textAlign="center"
          >
            {playing === lobby.name ? '查看' : '加入'}
          </Button>
        ) : (
          <Button
            disabled={isActive}
            color="good"
            onClick={() => act('spectate', { id: lobby.name })}
          >
            观战
          </Button>
        )}
      </Table.Cell>
    </Table.Row>
  );
}
