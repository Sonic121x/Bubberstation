import { Box, Button, Section, Table } from 'tgui-core/components';
import { toTitleCase } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Material = {
  name: string;
  amount: number;
};

type Data = {
  materials: Material[];
};

export const OreBox = (props) => {
  const { act, data } = useBackend<Data>();
  const { materials } = data;

  return (
    <Window width={335} height={415}>
      <Window.Content scrollable>
        <Section
          title="矿石与巨石"
          buttons={
            <Button
              disabled={materials.length === 0}
              onClick={() => act('removeall')}
            >
              清空
            </Button>
          }
        >
          <Table>
            <Table.Row header>
              <Table.Cell>物品</Table.Cell>
              <Table.Cell collapsing textAlign="right">
                数量
              </Table.Cell>
            </Table.Row>
            {materials.map((material, id) => (
              <Table.Row key={id}>
                <Table.Cell>{toTitleCase(material.name)}</Table.Cell>
                <Table.Cell collapsing textAlign="right">
                  <Box color="label" inline>
                    {material.amount}
                  </Box>
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
        <Section>
          <Box>
            可用矿石袋或徒手装入矿石。巨石
            也可存放在这里。
            <br />
            不接受爆裂矿。
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
