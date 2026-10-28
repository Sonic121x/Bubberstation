import { Button, Flex, NoticeBox, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const GhostPoolProtection = (props) => {
  const { act, data } = useBackend();
  const {
    events_or_midrounds,
    spawners,
    station_sentience,
    silicons,
    minigames,
  } = data;
  return (
    <Window
      title="幽灵候选池保护"
      width={400}
      height={270}
      theme="admin"
    >
      <Window.Content>
        <Flex grow={1} height="100%">
          <Section
            title="选项"
            buttons={
              <>
                <Button
                  color="good"
                  icon="plus-circle"
                  content="全部启用"
                  onClick={() => act('all_roles')}
                />
                <Button
                  color="bad"
                  icon="minus-circle"
                  content="全部禁用"
                  onClick={() => act('no_roles')}
                />
              </>
            }
          >
            <NoticeBox danger>
              筹备秘密事件时请注意：如果切换空间站创造的
              智慧生命选项，玩家可能会发现管理员为了
              此事件禁用了角色……
            </NoticeBox>
            <Flex.Item>
              <Button
                fluid
                textAlign="center"
                color={events_or_midrounds ? 'good' : 'bad'}
                icon="meteor"
                content="事件与回合中途规则集"
                onClick={() => act('toggle_events_or_midrounds')}
              />
            </Flex.Item>
            <Flex.Item>
              <Button
                fluid
                textAlign="center"
                color={spawners ? 'good' : 'bad'}
                icon="pastafarianism"
                content="幽灵角色生成点"
                onClick={() => act('toggle_spawners')}
              />
            </Flex.Item>
            <Flex.Item>
              <Button
                fluid
                textAlign="center"
                color={station_sentience ? 'good' : 'bad'}
                icon="user-astronaut"
                content="空间站创造的智慧生命"
                onClick={() => act('toggle_station_sentience')}
              />
            </Flex.Item>
            <Flex.Item>
              <Button
                fluid
                textAlign="center"
                color={silicons ? 'good' : 'bad'}
                icon="robot"
                content="硅基生命"
                onClick={() => act('toggle_silicons')}
              />
            </Flex.Item>
            <Flex.Item>
              <Button
                fluid
                textAlign="center"
                color={minigames ? 'good' : 'bad'}
                icon="gamepad"
                content="小游戏"
                onClick={() => act('toggle_minigames')}
              />
            </Flex.Item>
            <Flex.Item>
              <Button
                fluid
                textAlign="center"
                color="orange"
                icon="check"
                content="应用更改"
                onClick={() => act('apply_settings')}
              />
            </Flex.Item>
          </Section>
        </Flex>
      </Window.Content>
    </Window>
  );
};
