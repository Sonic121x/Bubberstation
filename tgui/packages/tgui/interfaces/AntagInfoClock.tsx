// THIS IS A SKYRAT UI FILE
import { Icon, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Rules } from './AntagInfoRules';

type Info = {
  antag_name: string;
};

export const AntagInfoClock = (props) => {
  const { data } = useBackend<Info>();
  const { antag_name } = data;
  return (
    <Window width={620} height={350} theme="clockwork">
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item fontSize="20px" color={'good'}>
              <Icon name={'cog'} rotation={0} spin />
              {` 你是${antag_name}！ `}
              <Icon name={'cog'} rotation={35} spin />
            </Stack.Item>
            <Stack.Item>
              <Rules />
            </Stack.Item>
            <Stack.Item>
              <ObjectivePrintout />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

const ObjectivePrintout = (props) => {
  const { data } = useBackend<Info>();
  return (
    <Stack vertical>
      <Stack.Item bold>你的目标：</Stack.Item>
      <Stack.Item>
        {
          '- 利用赐予你的力量，推进你所属其他组织的目标。'
        }
      </Stack.Item>
      <Stack.Item>
        {
          '- 传播我们伟大的引擎之主拉特瓦的恩典、知识与荣耀。'
        }
      </Stack.Item>
    </Stack>
  );
};
