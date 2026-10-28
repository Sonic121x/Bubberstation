import {
  Box,
  Button,
  Dimmer,
  NoticeBox,
  Section,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import { displayRole } from '../localization/roleDisplay';
export const NtosJobManager = (props) => {
  return (
    <NtosWindow width={400} height={620}>
      <NtosWindow.Content scrollable>
        <NtosJobManagerContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const NtosJobManagerContent = (props) => {
  const { act, data } = useBackend();
  const { authed, cooldown, slots = [], prioritized = [] } = data;
  if (!authed) {
    return (
      <NoticeBox>
        当前身份卡没有调整职位名额的权限。
      </NoticeBox>
    );
  }
  return (
    <Section>
      {cooldown > 0 && (
        <Dimmer>
          <Box bold textAlign="center" fontSize="20px">
            冷却中：{cooldown} 秒
          </Box>
        </Dimmer>
      )}
      <Table>
        <Table.Row header>
          <Table.Cell>优先招聘</Table.Cell>
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
                  act('PRG_priority', {
                    target: slot.title,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell collapsing>
              {slot.current} / {slot.total}
            </Table.Cell>
            <Table.Cell collapsing>
              <Button
                content="开放"
                disabled={!slot.status_open}
                onClick={() =>
                  act('PRG_open_job', {
                    target: slot.title,
                  })
                }
              />
              <Button
                content="关闭"
                disabled={!slot.status_close}
                onClick={() =>
                  act('PRG_close_job', {
                    target: slot.title,
                  })
                }
              />
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};
