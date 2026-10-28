import { Button, Divider, NoticeBox, Stack } from 'tgui-core/components';
import { useBackend } from '../../backend';
import { PointLocked } from './Locked';
import type { SpellbookData } from './types';

export function Randomize(props) {
  const { act, data } = useBackend<SpellbookData>();
  const { points, semi_random_bonus, full_random_bonus } = data;

  return (
    <Stack fill vertical>
      {points < 10 && <PointLocked />}
      <Stack.Item>
        半随机配装保证你至少拥有一定的机动能力和杀伤能力。
        保证获得总价值 {semi_random_bonus} 点的法术。
      </Stack.Item>
      <Stack.Item>
        <Button.Confirm
          confirmContent="决定放手一搏？"
          confirmIcon="dice-three"
          lineHeight={6}
          fluid
          icon="dice-three"
          onClick={() => act('semirandomize')}
        >
          半随机配装
        </Button.Confirm>
        <Divider />
      </Stack.Item>
      <Stack.Item>
        完全随机配装可能给你任何东西，而且无法反悔！
        保证获得总价值 {full_random_bonus} 点的法术。
      </Stack.Item>
      <Stack.Item>
        <NoticeBox danger>
          <Button.Confirm
            confirmContent="决定放手一搏？"
            confirmIcon="dice"
            lineHeight={6}
            fluid
            color="black"
            icon="dice"
            onClick={() => act('randomize')}
          >
            完全随机配装
          </Button.Confirm>
        </NoticeBox>
      </Stack.Item>
    </Stack>
  );
}
