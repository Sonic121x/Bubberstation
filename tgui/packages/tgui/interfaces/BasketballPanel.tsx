import { Button, NoticeBox, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type BasketballPanelData = {
  total_votes: number;
  players_min: number;
  players_max: number;
  lobbydata: {
    ckey: string;
    status: string;
  }[];
};

export const BasketballPanel = (props) => {
  const { act, data } = useBackend<BasketballPanelData>();

  return (
    <Window title="篮球" width={650} height={580}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item grow>
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
                    报名参加下一场比赛。如果
                    已有比赛正在进行，你将报名
                    参加之后的一场。
                  `}
                    content="报名"
                    onClick={() => act('basketball_signup')}
                  />
                  <Button
                    icon="basketball"
                    disabled={data.total_votes < data.players_min}
                    onClick={() => act('basketball_start')}
                  >
                    开始
                  </Button>
                </>
              }
            >
              <NoticeBox info>
                大厅已有 {data.total_votes} 名玩家报名。此小游戏
                需要 {data.players_min} 至 {data.players_max} 名玩家。
              </NoticeBox>

              {data.lobbydata.map((lobbyist) => (
                <Stack
                  key={lobbyist.ckey}
                  className="candystripe"
                  p={1}
                  align="baseline"
                >
                  <Stack.Item grow>{lobbyist.ckey}</Stack.Item>
                  <Stack.Item>状态：</Stack.Item>
                  <Stack.Item
                    color={lobbyist.status === 'Ready' ? 'green' : 'red'}
                  >
                    {lobbyist.status === 'Ready' ? '已就绪' : lobbyist.status === 'Disconnected' ? '已断开连接' : lobbyist.status}
                  </Stack.Item>
                </Stack>
              ))}
            </Section>
          </Stack.Item>
          <Stack.Item />
        </Stack>
      </Window.Content>
    </Window>
  );
};
