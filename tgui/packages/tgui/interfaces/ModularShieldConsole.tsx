import {
  Button,
  Input,
  NoticeBox,
  ProgressBar,
  Section,
  Table,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type GeneratorStats = {
  name: string;
  id: number;
  max_strength: number;
  current_strength: number;
  active: BooleanLike;
  recovering: BooleanLike;
  current_regeneration: number;
};

type Data = {
  generators: GeneratorStats[];
};

export const ModularShieldConsole = () => {
  const { data } = useBackend<Data>();
  const { generators } = data;
  return (
    <Window title="模块化护盾控制台" width={450} height={275}>
      <Window.Content scrollable>
        {generators.length === 0 ? (
          <NoticeBox>未连接护盾发生器</NoticeBox>
        ) : (
          <Section minHeight="200px">
            <GeneratorTable />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};

const GeneratorTable = () => {
  const { data } = useBackend<Data>();
  const { generators } = data;
  return (
    <Table>
      <Table.Row>
        <Table.Cell bold>名称</Table.Cell>
        <Table.Cell bold collapsing textAlign="center">
          状态
        </Table.Cell>
        <Table.Cell bold textAlign="center">
          开关
        </Table.Cell>
      </Table.Row>
      {generators.map((stat) => (
        <GeneratorTableEntry GeneratorData={stat} key={stat.id} />
      ))}
    </Table>
  );
};

type GeneratorTableEntryProps = {
  GeneratorData: GeneratorStats;
};

const GeneratorTableEntry = (props: GeneratorTableEntryProps) => {
  const { act, data } = useBackend<Data>();
  const { GeneratorData } = props;
  const {
    name,
    id,
    max_strength,
    current_strength,
    active,
    recovering,
    current_regeneration,
  } = GeneratorData;

  return (
    <Table.Row className="candystripe">
      <Table.Cell>
        <Input
          value={name}
          width="170px"
          onBlur={(value) =>
            act('rename', {
              id,
              name: value,
            })
          }
        />
      </Table.Cell>
      <Table.Cell
        collapsing
        textAlign="center"
        color={recovering ? 'red' : 'white'}
      >
        <ProgressBar
          width="170px"
          value={current_strength}
          maxValue={max_strength}
          ranges={{
            good: [max_strength * 0.75, max_strength],
            average: [max_strength * 0.25, max_strength * 0.75],
            bad: [0, max_strength * 0.25],
          }}
        >
          {current_strength}/{max_strength} + {current_regeneration}
        </ProgressBar>
      </Table.Cell>
      <Table.Cell>
        <Button
          bold
          disabled={recovering}
          selected={active}
          content={active ? '开启' : '关闭'}
          icon="power-off"
          onClick={() => act('toggle_shields', { id })}
        />
      </Table.Cell>
    </Table.Row>
  );
};
