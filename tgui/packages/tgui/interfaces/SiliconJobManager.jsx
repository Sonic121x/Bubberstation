import { Button, NoticeBox, Section, Table } from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts'; import { displayRole } from '../localization/roleDisplay';

export const SiliconJobManager = (props) => {
  return (
    <NtosWindow width={400} height={300}>
      <NtosWindow.Content scrollable>
        <SiliconManagerContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const SiliconManagerContent = (props) => {
  const { act, data } = useBackend();
  const { authed, slots = [], prioritized = [] } = data;
  if (!authed) {
    return (
      <NoticeBox>
        当前身份卡没有修改职业名额的权限。
      </NoticeBox>
    );
  }
  return (
    <Section>
      <Table>
        <Table.Row header>
          <Table.Cell>优先职位</Table.Cell>
          <Table.Cell>名额</Table.Cell>
        </Table.Row>
        {slots.map((slot) => (
          <Table.Row key={slot.title} className="candystripe">
            <Table.Cell bold>
              <Button.Checkbox
                fluid
                content={displayRole(slot.title)}
                disabled={slot.total <= 0}
                checked={slot.total > 0 && prioritized.includes(slot.title)}
                onClick={() =>
                  act('Silicon_priority', {
                    target: slot.title,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell collapsing>
              {slot.current} / {slot.total}
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};
