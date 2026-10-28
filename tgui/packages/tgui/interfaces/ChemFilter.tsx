import { Fragment } from 'react';
import { Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import type { CssColor } from '../constants';
import { Window } from '../layouts';

type Data = {
  left: string[];
  right: string[];
};

type Props = {
  title: string;
  list: string[];
  buttonColor: CssColor;
};

export const ChemFilterPane = (props: Props) => {
  const { act } = useBackend();
  const { title, list, buttonColor } = props;
  const titleKey = title.toLowerCase();

  return (
    <Section
      title={{ Right: '右侧', Left: '左侧' }[title] || title}
      minHeight="240px"
      buttons={
        <Button
          icon="plus"
          color={buttonColor}
          onClick={() =>
            act('add', {
              which: titleKey,
            })
          }
        >
          添加试剂
        </Button>
      }
    >
      {list.map((filter) => (
        <Fragment key={filter}>
          <Button
            fluid
            icon="minus"
            onClick={() =>
              act('remove', {
                which: titleKey,
                reagent: filter,
              })
            }
          >
            {filter}
          </Button>
        </Fragment>
      ))}
    </Section>
  );
};

export const ChemFilter = (props) => {
  const { data } = useBackend<Data>();
  const { left = [], right = [] } = data;

  return (
    <Window width={500} height={300}>
      <Window.Content scrollable>
        <Stack>
          <Stack.Item grow>
            <ChemFilterPane title="Right" list={right} buttonColor="red" />
          </Stack.Item>
          <Stack.Item grow>
            <ChemFilterPane title="Left" list={left} buttonColor="yellow" />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
