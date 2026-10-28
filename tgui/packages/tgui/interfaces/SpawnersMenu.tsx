import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import { Button, LabeledList, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { capitalizeAll } from 'tgui-core/string';

type Data = {
  spawners: Spawner[];
};

type Spawner = {
  name: string;
  amount_left: number;
  infinite: BooleanLike;
} & Partial<{
  desc: string;
  you_are_text: string;
  flavor_text: string;
  important_text: string;
}>;

export const SpawnersMenu = (props) => {
  const { act, data } = useBackend<Data>();
  const { spawners = [] } = data;

  return (
    <Window title="可加入角色" width={700} height={525}>
      <Window.Content scrollable>
        <Stack vertical>
          {spawners.map((spawner) => (
            <Stack.Item key={spawner.name}>
              <Section
                fill
                // Capitalizes the spawner name
                title={capitalizeAll(spawner.name)}
                buttons={
                  <Stack>
                    {spawner.infinite ? (
                      <Stack.Item fontSize="14px" color="green">
                        不限数量
                      </Stack.Item>
                    ) : (
                      <Stack.Item fontSize="14px" color="green">
                        剩余{spawner.amount_left}个
                      </Stack.Item>
                    )}
                    <Stack.Item>
                      <Button
                        content="跳转"
                        onClick={() =>
                          act('jump', {
                            name: spawner.name,
                          })
                        }
                      />
                      <Button
                        content="加入"
                        onClick={() =>
                          act('spawn', {
                            name: spawner.name,
                          })
                        }
                      />
                    </Stack.Item>
                  </Stack>
                }
              >
                <LabeledList>
                  {spawner.desc ? (
                    <LabeledList.Item label="描述">
                      {spawner.desc}
                    </LabeledList.Item>
                  ) : (
                    <div>
                      <LabeledList.Item label="身份背景">
                        {spawner.you_are_text || '未知'}
                      </LabeledList.Item>
                      <LabeledList.Item label="指引">
                        {spawner.flavor_text || '无'}
                      </LabeledList.Item>
                      <LabeledList.Item color="bad" label="条件">
                        {spawner.important_text || '无'}
                      </LabeledList.Item>
                    </div>
                  )}
                </LabeledList>
              </Section>
            </Stack.Item>
          ))}
        </Stack>
      </Window.Content>
    </Window>
  );
};
