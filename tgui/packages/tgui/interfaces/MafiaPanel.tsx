import { useState } from 'react';
import {
  Box,
  Button,
  Collapsible,
  Flex,
  NoticeBox,
  Section,
  Stack,
  Tabs,
  TextArea,
} from 'tgui-core/components';
import { formatTime } from 'tgui-core/format';
import { type BooleanLike, classes } from 'tgui-core/react';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type RoleInfo = {
  role_theme: string;
  role: string;
  desc: string;
  hud_icon: string;
  revealed_icon: string;
  role_dead: string;
};

type PlayerInfo = {
  name: string;
  role_revealed: string;
  is_you: BooleanLike;
  ref: string;
  alive: string;
  possible_actions: ActionInfo[];
  votes: number;
};

type ActionInfo = {
  name: string;
  ref: string;
};

type LobbyData = {
  name: string;
  status: string;
};

type MessageData = {
  msg: string;
};

type MafiaData = {
  players: PlayerInfo[];
  lobbydata: LobbyData[];
  messages: MessageData[];
  user_notes: string;
  roleinfo: RoleInfo;
  phase: string;
  turn: number;
  timeleft: number;
  is_observer: boolean;
  all_roles: string[];
  admin_controls: boolean;
  person_voted_up_ref: string;
  player_voted_up: BooleanLike;
};

export const MafiaPanelData = (props) => {
  const { act, data } = useBackend<MafiaData>();
  const { phase, roleinfo, admin_controls, messages, player_voted_up } = data;
  const [mafia_tab, setMafiaMode] = useState('Role list');

  if (phase === 'No Game') {
    return (
      <Stack fill vertical>
        <MafiaLobby />
        {!!admin_controls && <MafiaAdmin />}
      </Stack>
    );
  }

  return (
    <Stack fill>
      {!!roleinfo && (
        <Stack.Item grow>
          <MafiaChat />
        </Stack.Item>
      )}
      <Stack.Item grow>
        <Stack fill vertical>
          {!!roleinfo && (
            <>
              <Stack.Item>
                <MafiaRole />
              </Stack.Item>
              {phase === 'Judgment' && !player_voted_up && (
                <Stack.Item>
                  <MafiaJudgement />
                </Stack.Item>
              )}
            </>
          )}

          <Stack.Item>{!!admin_controls && <MafiaAdmin />}</Stack.Item>

          {phase !== 'No Game' && (
            <Stack.Item>
              <Stack fill>
                <Stack.Item grow>
                  <MafiaPlayers />
                </Stack.Item>
                <Stack.Item grow>
                  <Stack.Item>
                    <Tabs fluid>
                      <Tabs.Tab
                        align="center"
                        selected={mafia_tab === 'Role list'}
                        onClick={() => setMafiaMode('Role list')}
                      >
                        角色列表
                        <Button
                          color="transparent"
                          icon="address-book"
                          tooltipPosition="bottom-start"
                          tooltip={`
                            这里列出了本局游戏中的角色。你可以
                            点击问号，查看关于该角色的
                            简短介绍。`}
                        />
                      </Tabs.Tab>
                      <Tabs.Tab
                        align="center"
                        selected={mafia_tab === 'Notes'}
                        onClick={() => setMafiaMode('Notes')}
                      >
                        笔记
                        <Button
                          color="transparent"
                          icon="pencil"
                          tooltipPosition="bottom-start"
                          tooltip={`
                            这是你的笔记本，可以保存任何想记录的
                            内容，供之后查阅。你也可以
                            点击按钮，将笔记发送至聊天。`}
                        />
                      </Tabs.Tab>
                    </Tabs>
                  </Stack.Item>
                  {mafia_tab === 'Role list' && <MafiaListOfRoles />}
                  {mafia_tab === 'Notes' && <MafiaNotesTab />}
                </Stack.Item>
              </Stack>
            </Stack.Item>
          )}
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

export const MafiaPanel = (props) => {
  const { act, data } = useBackend<MafiaData>();
  const { roleinfo } = data;
  return (
    <Window title="黑手党" theme={roleinfo?.role_theme} width={900} height={600}>
      <Window.Content>
        <MafiaPanelData />
      </Window.Content>
    </Window>
  );
};

const MafiaChat = (props) => {
  const { act, data } = useBackend<MafiaData>();
  const { messages } = data;
  const [message_to_send, setMessagingBox] = useState('');
  return (
    <Stack vertical fill>
      {!!messages && (
        <>
          <Section fill scrollable title="聊天记录">
            {messages.map((message) => (
              <Box key={message.msg}>{decodeHtmlEntities(message.msg)}</Box>
            ))}
          </Section>
          <TextArea
            fluid
            height="10%"
            maxLength={300}
            className="Section__title candystripe"
            onChange={setMessagingBox}
            placeholder="输入聊天内容"
            value={message_to_send}
          />
          <Button
            color="bad"
            fluid
            textAlign="center"
            tooltip="将消息发送至聊天。"
            onClick={() => {
              setMessagingBox('');
              act('send_message_to_chat', { message: message_to_send });
            }}
          >
            发送至聊天
          </Button>
        </>
      )}
    </Stack>
  );
};

const MafiaLobby = (props) => {
  const { act, data } = useBackend<MafiaData>();
  const { lobbydata = [], is_observer } = data;
  const readyGhosts = lobbydata
    ? lobbydata.filter((player) => player.status === 'Ready')
    : null;
  return (
    <Section
      fill
      scrollable
      title="大厅"
      buttons={
        <>
          <Button
            icon="clipboard-check"
            tooltipPosition="bottom-start"
            tooltip={`
              报名参加下一局游戏。如果
              当前已有正在进行的游戏，你将
              被登记参加下一局。
            `}
            content="报名"
            onClick={() => act('mf_signup')}
          />
          <Button
            icon="arrow-right"
            tooltipPosition="bottom-start"
            tooltip={`
              投票要求提前开始游戏。
              当前已报名玩家中半数同意后，即可开始。
              至少需要六名玩家。
            `}
            content="立即开始！"
            onClick={() => act('vote_to_start')}
          />
        </>
      }
    >
      <NoticeBox info textAlign="center">
        当前大厅有 {readyGhosts ? readyGhosts.length : '0'}/12 名
        有效报名玩家。
      </NoticeBox>
      {!!is_observer && (
        <NoticeBox color="green" textAlign="center">
          以幽灵身份报名黑手党的玩家，会在游戏结束后
          返回原先的身体，因此你可以暂时离开身体，
          来玩上一局。
        </NoticeBox>
      )}
      {lobbydata.map((lobbyist) => (
        <Stack
          key={lobbyist.name}
          className="candystripe"
          p={1}
          align="baseline"
        >
          <Stack.Item grow>
            {!is_observer ? '未知玩家' : lobbyist.name}
          </Stack.Item>
          <Stack.Item>状态：</Stack.Item>
          <Stack.Item color={lobbyist.status === 'Ready' ? 'green' : 'red'}>
            {lobbyist.status === 'Ready' ? '已准备' : lobbyist.status === 'Disconnected' ? '已断线' : lobbyist.status}
          </Stack.Item>
        </Stack>
      ))}
    </Section>
  );
};

const MafiaRole = (props) => {
  const { act, data } = useBackend<MafiaData>();
  const { phase, turn, roleinfo, timeleft } = data;
  return (
    <Section
      fill
      title={(phase === 'Judgment' ? '审判阶段' : phase) + turn}
      minHeight="110px"
      maxHeight="50px"
      buttons={
        <Box
          lineHeight={1.5}
          fontFamily="Consolas, monospace"
          fontSize="14px"
          fontWeight="bold"
        >
          {formatTime(timeleft)}
        </Box>
      }
    >
      <Stack>
        <Stack.Item grow>
          <Box fontSize="16px">你的身份是{roleinfo.role}</Box>
          {!!roleinfo.role_dead && (
            <Box bold>
              你已经死亡。如果本局存在牧师，
              你可以在夜间与其交谈。
            </Box>
          )}
          {!roleinfo.role_dead && <Box italic>{roleinfo.desc}</Box>}
        </Stack.Item>
        <Stack.Item>
          <Box
            className={classes(['mafia32x32', roleinfo.revealed_icon])}
            style={{
              transform: 'scale(2) translate(0px, 10%)',
              verticalAlign: 'middle',
            }}
          />
          <Box
            className={classes(['mafia32x32', roleinfo.hud_icon])}
            style={{
              transform: 'scale(2) translate(-5px, -5px)',
              verticalAlign: 'middle',
            }}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const MafiaListOfRoles = (props) => {
  const { act, data } = useBackend<MafiaData>();
  const { all_roles } = data;
  return (
    <Section fill>
      <Flex direction="column">
        {all_roles?.map((r) => (
          <Flex.Item key={r} className="Section__title candystripe">
            <Flex align="center" justify="space-between">
              <Flex.Item>{r}</Flex.Item>
              <Flex.Item textAlign="right">
                <Button
                  color="transparent"
                  icon="question"
                  onClick={() =>
                    act('mf_lookup', {
                      role_name: r.slice(0, -3),
                    })
                  }
                />
              </Flex.Item>
            </Flex>
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};

const MafiaNotesTab = (props) => {
  const { act, data } = useBackend<MafiaData>();
  const { user_notes } = data;
  const [note_message, setNotesMessage] = useState(user_notes);
  return (
    <Section fill>
      <TextArea
        height="80%"
        maxLength={600}
        className="Section__title candystripe"
        onChange={setNotesMessage}
        placeholder="输入笔记……"
        value={note_message}
      />

      <Button
        color="good"
        fluid
        textAlign="center"
        onClick={() => act('change_notes', { new_notes: note_message })}
        tooltip="将输入的内容保存为笔记。死亡后无法执行此操作。"
      >
        保存
      </Button>
      <Button.Confirm
        color="bad"
        fluid
        content="发送至聊天"
        textAlign="center"
        onClick={() => act('send_notes_to_chat')}
      />
    </Section>
  );
};

const MafiaJudgement = (props) => {
  const { act, data } = useBackend();
  return (
    <Section title="审判">
      <Flex>
        <Button
          icon="smile-beam"
          color="good"
          onClick={() => act('vote_innocent')}
        >
          无罪
        </Button>
        <Box>现在开始投票，请判定被告无罪或有罪！</Box>
        <Button icon="angry" color="bad" onClick={() => act('vote_guilty')}>
          有罪
        </Button>
      </Flex>
      <Flex justify="center">
        <Button icon="meh" color="white" onClick={() => act('vote_abstain')}>
          弃权
        </Button>
      </Flex>
    </Section>
  );
};

const MafiaPlayers = (props) => {
  const { act, data } = useBackend<MafiaData>();
  const { players = [], person_voted_up_ref } = data;
  return (
    <Section fill scrollable title="玩家">
      <Flex direction="column" fill justify="space-around">
        {players?.map((player) => (
          <Flex.Item className="Section__title candystripe" key={player.ref}>
            <Stack align="center">
              <Stack.Item
                grow
                color={!player.alive && 'red'}
                backgroundColor={
                  player.ref === person_voted_up_ref ? 'yellow' : null
                }
              >
                {player.name}
                {(!!player.is_you && '（你）') ||
                  (!!player.role_revealed && ` - ${player.role_revealed}`)}
              </Stack.Item>
              <Stack.Item>
                {player.votes !== undefined &&
                  !!player.alive &&
                  `票数：${player.votes}`}
              </Stack.Item>
              <Stack.Item minWidth="42px" textAlign="center">
                {player.possible_actions?.map((action) => (
                  <Button
                    key={action.name}
                    onClick={() =>
                      act('perform_action', {
                        action_ref: action.ref,
                        target: player.ref,
                      })
                    }
                  >
                    {action.name}
                  </Button>
                ))}
              </Stack.Item>
            </Stack>
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};

const MafiaAdmin = (props) => {
  const { act, data } = useBackend();
  return (
    <Collapsible title="管理员控制" color="red">
      <Section>
        <Collapsible title="程序员的善意提醒" color="transparent">
          这些功能几乎都是为了调试游戏而编写的（唉，
          调试一款十二人游戏！），因此十分简陋，
          很容易出错。按下按钮前，务必清楚
          自己在做什么。另外，因为确实有管理员这么干过：
          请勿碎尸、删除或尘化任何玩家！这会让游戏陷入无尽的运行时错误。
        </Collapsible>
        <Button icon="arrow-right" onClick={() => act('next_phase')}>
          下一阶段
        </Button>
        <Button icon="home" onClick={() => act('players_home')}>
          送所有玩家回去
        </Button>
        <Button icon="sync-alt" onClick={() => act('new_game')}>
          新游戏
        </Button>
        <Button icon="skull" onClick={() => act('nuke')}>
          清空游戏
        </Button>
        <br />
        <Button icon="paint-brush" onClick={() => act('debug_setup')}>
          创建自定义配置
        </Button>
        <Button icon="paint-roller" onClick={() => act('cancel_setup')}>
          重置自定义配置
        </Button>
        <Button icon="magic" onClick={() => act('start_now')}>
          立即开始！
        </Button>
      </Section>
    </Collapsible>
  );
};
