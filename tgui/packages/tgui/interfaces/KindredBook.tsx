import { Collapsible, Section, Table } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  clans: ClanInfo[];
};

type ClanInfo = {
  clan_name: string;
  clan_desc: string;
};

export const KindredBook = (props) => {
  const { data } = useBackend<Data>();
  const { clans } = data;
  return (
    <Window width={410} height={460} theme="spookyconsole">
      <Window.Content scrollable>
        <Section title="吸血鬼氏族">
          <Table mb={2}>
            <Table.Row>
              本书由历代馆长共同编纂，收录了
              我们所知的所有关于潜伏于空间站的
              不死威胁的情报……
            </Table.Row>
            <Table.Row>那么，你对哪个氏族感兴趣？</Table.Row>
          </Table>
          <Table>
            <Table.Row>
              {clans.map((clan) => (
                <Collapsible key={clan.clan_name} title={clan.clan_name}>
                  <Table.Cell color="label">{clan.clan_desc}</Table.Cell>
                </Collapsible>
              ))}
            </Table.Row>
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
