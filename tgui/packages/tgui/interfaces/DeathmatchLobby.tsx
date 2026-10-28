import {
  Box,
  Button,
  Divider,
  Dropdown,
  Icon,
  LabeledList,
  Modal,
  NoticeBox,
  Section,
  Stack,
  Table,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Player = {
  host: number;
  key: string;
  loadout: string;
  ready: BooleanLike;
  mob: string;
};

type Modifier = {
  desc: string;
  modpath: string;
  name: string;
  player_selectable: BooleanLike;
  player_selected: BooleanLike;
  selectable: BooleanLike;
  selected: BooleanLike;
};

type Map = {
  desc: string;
  max_players: number;
  min_players: number;
  name: string;
  time: number;
};

type Data = {
  active_mods: string;
  admin: BooleanLike;
  host: BooleanLike;
  loadoutdesc: string;
  loadouts: string[];
  map: Map;
  maps: string[];
  mod_menu_open: BooleanLike;
  modifiers: Modifier[];
  observers: Player[];
  players: Player[];
  playing: BooleanLike;
  self: string;
};

export function DeathmatchLobby(props) {
  const { act, data } = useBackend<Data>();
  const {
    admin,
    host,
    mod_menu_open,
    observers = [],
    players = [],
    self,
  } = data;

  const allReady = players.every((player) => player.ready);

  const fullAccess = !!host || !!admin;
  const showMenu = fullAccess && !!mod_menu_open;

  const isObserver = observers.find((observer) => observer.key === self);

  return (
    <Window title="死斗大厅" width={560} height={480}>
      {showMenu && <ModSelector />}
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item grow>
            <Stack fill>
              <Stack.Item grow={4}>
                <PlayerColumn />
              </Stack.Item>
              <Stack.Item grow={3}>
                <HostControls />
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <Section>
              <Stack fill>
                <Stack.Item grow>
                  {!!admin && (
                    <Button
                      icon="exclamation"
                      color="caution"
                      onClick={() => act('admin', { func: 'Force start' })}
                    >
                      强制开始
                    </Button>
                  )}
                </Stack.Item>
                <Stack.Item>
                  <Button color="caution" onClick={() => act('observe')}>
                    {isObserver ? '加入' : '观察'}
                  </Button>
                  <Button color="bad" onClick={() => act('leave_game')}>
                    离开游戏
                  </Button>
                  <Button
                    color="good"
                    disabled={!allReady}
                    onClick={() => act('start_game')}
                  >
                    开始游戏
                  </Button>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
}

function PlayerColumn(props) {
  const { act, data } = useBackend<Data>();
  const {
    admin,
    host,
    loadouts = [],
    observers = [],
    players = [],
    self,
  } = data;

  const allReady = players.every((player) => player.ready);

  const fullAccess = !!host || !!admin;

  return (
    <Section fill scrollable={players.length > 30}>
      <Table>
        <Table.Row header>
          <Table.Cell collapsing />
          <Table.Cell>名称</Table.Cell>
          <Table.Cell>装备配置</Table.Cell>
          <Table.Cell collapsing align="center">
            <Tooltip
              content={!allReady ? '玩家正在准备' : '请按开始！'}
            >
              <Icon
                name={!allReady ? 'check' : 'check-circle'}
                color={allReady && 'green'}
              />
            </Tooltip>
          </Table.Cell>
        </Table.Row>
        {players.map((player) => {
          const isHost = !!player.host;
          const isSelf = player.key === self;
          const canBoot = fullAccess && !isSelf;

          return (
            <Table.Row className="candystripe" key={player.key}>
              <Table.Cell align="center" collapsing verticalAlign="top">
                {isHost && (
                  <Tooltip content="房主">
                    <Icon color="gold" name="star" pt={isSelf && 0.5} />
                  </Tooltip>
                )}
                {!host && isSelf && (
                  <Tooltip content="你">
                    <Icon color="green" name="arrow-right" pt={0.9} />
                  </Tooltip>
                )}
              </Table.Cell>

              <Table.Cell verticalAlign="top" pt={!isHost && '2px'}>
                {!canBoot ? (
                  <Box color="label">{player.key}</Box>
                ) : (
                  <Dropdown
                    width={9}
                    selected={player.key}
                    options={[{ value: 'Kick', displayText: '踢出' }, { value: 'Transfer host', displayText: '移交房主' }, { value: 'Toggle observe', displayText: '切换观察模式' }]}
                    onSelected={(value) =>
                      act('host', {
                        id: player.key,
                        func: value,
                      })
                    }
                  />
                )}
              </Table.Cell>

              <Table.Cell>
                {!isSelf ? (
                  <Box color="label">{player.loadout}</Box>
                ) : (
                  <Dropdown
                    width={10}
                    selected={player.loadout}
                    disabled={!host && !isSelf}
                    options={loadouts}
                    onSelected={(value) =>
                      act('change_loadout', {
                        player: player.key,
                        loadout: value,
                      })
                    }
                  />
                )}
              </Table.Cell>

              <Table.Cell align="center" verticalAlign="middle">
                {isSelf ? (
                  <Button.Checkbox
                    disabled={!isSelf}
                    checked={player.ready}
                    onClick={() => act('ready')}
                  />
                ) : (
                  !!player.ready && <Icon name="check" />
                )}
              </Table.Cell>
            </Table.Row>
          );
        })}
        {observers.map((observer) => {
          const isHost = !!observer.host;
          const isSelf = observer.key === self;
          const canBoot = fullAccess && !isSelf;

          return (
            <Table.Row key={observer.key}>
              <Table.Cell
                collapsing
                verticalAlign="top"
                pt={fullAccess && '2px'}
              >
                {isHost ? (
                  <Tooltip content="房主">
                    <Icon name="star" />
                  </Tooltip>
                ) : (
                  <Icon name="eye" />
                )}
              </Table.Cell>
              <Table.Cell>
                {!canBoot ? (
                  <b>{observer.key}</b>
                ) : (
                  <Dropdown
                    width={9}
                    selected={observer.key}
                    options={[{ value: 'Kick', displayText: '踢出' }, { value: 'Transfer host', displayText: '移交房主' }, { value: 'Toggle observe', displayText: '切换观察模式' }]}
                    onSelected={(value) =>
                      act('host', {
                        id: observer.key,
                        func: value,
                      })
                    }
                  />
                )}
              </Table.Cell>
              <Table.Cell color="label">观察中</Table.Cell>
            </Table.Row>
          );
        })}
      </Table>
    </Section>
  );
}

function HostControls(props) {
  const { act, data } = useBackend<Data>();
  const { active_mods = [], admin, host, loadoutdesc, playing } = data;

  const fullAccess = !!host || !!admin;

  return (
    <Section fill scrollable>
      <MapInfo />
      <Divider />
      <Box textAlign="center" color="average">
        {active_mods}
      </Box>
      {fullAccess && (
        <>
          <Divider />
          <Button textAlign="center" fluid onClick={() => act('open_mod_menu')}>
            切换规则修正
          </Button>
        </>
      )}
      <Divider />
      <NoticeBox info align="center">
        装备配置说明
      </NoticeBox>

      <Box textAlign="center">{loadoutdesc}</Box>
      {!!playing && (
        <>
          <Divider />
          <Box textAlign="center">
            游戏正在进行或加载中。
          </Box>
        </>
      )}
    </Section>
  );
}

const ModSelector = (props) => {
  const { act, data } = useBackend<Data>();
  const { modifiers = [] } = data;

  return (
    <Modal>
      <Button fluid color="bad" onClick={() => act('exit_mod_menu')}>
        返回
      </Button>
      {modifiers.map((mod, index) => (
        <Button.Checkbox
          key={index}
          mb={2}
          checked={mod.selected}
          tooltip={mod.desc}
          color={mod.selected ? 'green' : 'blue'}
          disabled={!mod.selected && !mod.selectable}
          onClick={() =>
            act('toggle_modifier', {
              modpath: mod.modpath,
            })
          }
        >
          {mod.name}
        </Button.Checkbox>
      ))}
    </Modal>
  );
};

function MapInfo(props) {
  const { act, data } = useBackend<Data>();
  const { host, maps = [], map, players } = data;

  if (!host && !map?.name) {
    return <NoticeBox align="center">未选择地图</NoticeBox>;
  }

  return (
    <>
      {!host ? (
        <NoticeBox danger>{map.name}</NoticeBox>
      ) : (
        <>
          <Dropdown
            color="average"
            width="100%"
            selected={map.name}
            options={maps}
            onSelected={(value) =>
              act('host', {
                func: 'change_map',
                map: value,
              })
            }
          />
          <Divider />
        </>
      )}
      {map.desc}
      <Divider />
      <LabeledList>
        <LabeledList.Item label="最长游戏时间">
          {`${map.time / 600} 分钟`}
        </LabeledList.Item>
        <LabeledList.Item label="最少玩家人数">
          {map.min_players}
        </LabeledList.Item>
        <LabeledList.Item label="最多玩家人数">
          {map.max_players}
        </LabeledList.Item>
        <LabeledList.Item label="当前玩家人数">
          {players.length}
        </LabeledList.Item>
      </LabeledList>
    </>
  );
}
