import { Button, LabeledList, NoticeBox, Section } from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  orphaned_keys: string[];
  archived_keys: string[];
};

export const AchievementsAdminPanel = (props) => {
  const { act, data } = useBackend<Data>();
  const { orphaned_keys, archived_keys } = data;
  return (
    <Window title="成就管理面板" width={540} height={680}>
      <Window.Content scrollable>
        <Section title="孤立成就">
          <NoticeBox>
            这些成就存在于数据库中，但在代码中缺少定义。
            它们很可能已被移除，可以安全清理。
            如果多个服务器共用同一数据库，
            这些成就也可能来自代码版本比本服务器更新的
            其他服务器。
          </NoticeBox>
          <LabeledList>
            {orphaned_keys.map((key) => (
              <LabeledList.Item
                key={key}
                label=""
                buttons={
                  <>
                    <Button.Confirm
                      onClick={() => act('archive', { key: key })}
                    >
                      归档
                    </Button.Confirm>
                    <Button.Confirm
                      onClick={() => act('cleanup_orphan', { key: key })}
                    >
                      清理
                    </Button.Confirm>
                  </>
                }
              >
                {key}
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
        <Section title="已归档成就">
          <NoticeBox>数据库中已归档的成就。</NoticeBox>
          <LabeledList>
            {archived_keys.map((key) => (
              <LabeledList.Item
                key={key}
                label=""
                buttons={
                  <Button.Confirm
                    onClick={() => act('cleanup_orphan', { key: key })}
                  >
                    清理
                  </Button.Confirm>
                }
              >
                {key}
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
