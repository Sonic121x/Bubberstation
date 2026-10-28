import { sortBy } from 'es-toolkit';
import { Box, Button, LabeledList, Section, Table } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { skyratFaxDisplay } from '../localization/skyratSystemsDisplay';
type FaxData = {
  faxes: FaxInfo[];
  fax_id: string;
  fax_name: string;
  visible: boolean;
  has_paper: string;
  syndicate_network: boolean;
  fax_history: FaxHistory[];
  special_faxes: FaxSpecial[];
};

type FaxInfo = {
  fax_name: string;
  fax_id: string;
  visible: boolean;
  has_paper: boolean;
  syndicate_network: boolean;
};

type FaxHistory = {
  history_type: string;
  history_fax_name: string;
  history_time: string;
};

type FaxSpecial = {
  fax_name: string;
  fax_id: string;
  color: string;
  emag_needed: boolean;
};

export const Fax = (props) => {
  const { act } = useBackend();
  const { data } = useBackend<FaxData>();
  const faxes = data.faxes
    ? sortBy(
        data.syndicate_network
          ? data.faxes.filter((filterFax: FaxInfo) => filterFax.visible)
          : data.faxes.filter(
              (filterFax: FaxInfo) =>
                filterFax.visible && !filterFax.syndicate_network,
            ),
        [(sortFax: FaxInfo) => sortFax.fax_name],
      )
    : [];
  const special_networks = data.syndicate_network
    ? data.special_faxes
    : data.special_faxes.filter((fax: FaxSpecial) => !fax.emag_needed);
  return (
    <Window width={340} height={540}>
      <Window.Content scrollable>
        <Section title="传真机信息">
          <LabeledList.Item label="网络名称">
            {skyratFaxDisplay(data.fax_name)}
          </LabeledList.Item>
          <LabeledList.Item label="网络编号">{data.fax_id}</LabeledList.Item>
          <LabeledList.Item label="网络可见">
            {data.visible ? '是' : '否'}
          </LabeledList.Item>
        </Section>
        <Section
          title="纸张"
          buttons={
            <Button onClick={() => act('remove')} disabled={!data.has_paper}>
              取出
            </Button>
          }
        >
          <LabeledList.Item label="纸张">
            {data.has_paper ? (
              <Box color="green">托盘中有纸</Box>
            ) : (
              <Box color="red">无纸</Box>
            )}
          </LabeledList.Item>
        </Section>
        <Section title="发送">
          {faxes.length === 0 && special_networks.length === 0 ? (
            '传真机未能在网络中检测到其他传真机。'
          ) : (
            <Box mt={0.4}>
              {special_networks.map((special: FaxSpecial) => (
                <Button
                  key={special.fax_id}
                  tooltip={skyratFaxDisplay(special.fax_name)}
                  disabled={!data.has_paper}
                  color={special.color}
                  onClick={() =>
                    act('send_special', {
                      id: special.fax_id,
                      name: special.fax_name,
                    })
                  }
                >
                  {skyratFaxDisplay(special.fax_name)}
                </Button>
              ))}
              {faxes.length !== 0
                ? faxes.map((fax: FaxInfo) => (
                    <Button
                      key={fax.fax_id}
                      tooltip={skyratFaxDisplay(fax.fax_name)}
                      disabled={!data.has_paper}
                      color={fax.syndicate_network ? 'red' : 'blue'}
                      onClick={() =>
                        act('send', {
                          id: fax.fax_id,
                          name: fax.fax_name,
                        })
                      }
                    >
                      {skyratFaxDisplay(fax.fax_name)}
                    </Button>
                  ))
                : null}
            </Box>
          )}
        </Section>
        <Section
          title="历史记录"
          buttons={
            <Button
              onClick={() => act('history_clear')}
              disabled={!data.fax_history}
            >
              清除
            </Button>
          }
        >
          <Table>
            <Table.Cell>
              {data.fax_history !== null
                ? data.fax_history.map((history: FaxHistory) => (
                    <Table.Row key={history.history_type}>
                      {
                        <Box
                          color={
                            ['Send', '发送'].includes(history.history_type) ? 'Green' : 'Red'
                          }
                        >
                          {({ Send: '发送', Receive: '接收' }[history.history_type]) ?? history.history_type}
                        </Box>
                      }
                      {skyratFaxDisplay(history.history_fax_name)} - {history.history_time}
                    </Table.Row>
                  ))
                : null}
            </Table.Cell>
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
