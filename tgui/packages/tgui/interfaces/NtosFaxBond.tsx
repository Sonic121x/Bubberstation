import { Button, NoticeBox, Section, Stack, Table } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

type FaxInfoList = {
  id: string;
  name: string;
  location: string;
  muted: BooleanLike;
};

type Data = {
  faxes_info: FaxInfoList[];
};

export const NtosFaxBond = (props) => {
  return (
    <NtosWindow width={400} height={500}>
      <NtosWindow.Content scrollable>
        <NtosFaxBondContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const NtosFaxBondContent = (props) => {
  const { act, data } = useBackend<Data>();
  const { faxes_info = [] } = data;
  return (
    <>
      <NoticeBox>
        扫描传真机，即可在它收到消息时获得通知。
      </NoticeBox>
      {!!faxes_info.length && (
        <Section>
          <Table>
            <Table.Row header>
              <Table.Cell>编号</Table.Cell>
              <Table.Cell>名称</Table.Cell>
              <Table.Cell>位置</Table.Cell>
              <Table.Cell />
            </Table.Row>
            {faxes_info.map((fax) => (
              <Table.Row className="candystripe" key={fax.id}>
                <Table.Cell py={1} verticalAlign="middle">
                  {fax.id}
                </Table.Cell>
                <Table.Cell py={1} verticalAlign="middle">
                  {fax.name}
                </Table.Cell>
                <Table.Cell py={1} verticalAlign="middle">
                  {fax.location}
                </Table.Cell>
                <Table.Cell py={1} verticalAlign="middle" collapsing>
                  <Stack>
                    <Button
                      fluid
                      icon={fax.muted ? 'bell-slash' : 'bell'}
                      color={fax.muted ? 'red' : 'default'}
                      tooltip={
                        fax.muted
                          ? '取消通知静音'
                          : '将通知静音'
                      }
                      onClick={() => act('mute', { id: fax.id })}
                    />
                    <Button.Confirm
                      fluid
                      icon="link-slash"
                      tooltip="取消订阅"
                      confirmContent=""
                      confirmIcon="link-slash"
                      onClick={() => act('unsubscribe', { id: fax.id })}
                    />
                  </Stack>
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      )}
    </>
  );
};
