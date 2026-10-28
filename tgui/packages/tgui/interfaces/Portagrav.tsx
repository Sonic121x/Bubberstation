import { Box, Button, Icon, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  percentage: number;
  on: BooleanLike;
  range: number;
  maxrange: number;
  gravity: number;
  wiremode: BooleanLike;
  draw: number;
};

export const Portagrav = (props) => {
  const { act, data } = useBackend<Data>();
  const { percentage, on, range, gravity, wiremode, maxrange, draw } = data;

  return (
    <Window width={320} height={320} theme="retro">
      <Window.Content>
        <Box
          width="100%"
          className="NuclearBomb__displayBox"
          textAlign="center"
        >
          {!wiremode && percentage !== undefined
            ? `${percentage}%`
            : wiremode
              ? '电缆供电'
              : '无电池'}
          {` - ${gravity}G`}
        </Box>
        <Box
          width="100%"
          className="NuclearBomb__displayBox"
          textAlign="center"
        >
          {on ? draw : '关闭'}／范围：{range}/{maxrange}
        </Box>
        <Section height="65%">
          <Stack>
            <Stack.Item width="30%">
              <Stack vertical ml="1rem">
                <Stack.Item>
                  <Box>电源</Box>
                </Stack.Item>
                <Stack.Divider />
                <Stack.Item>
                  <Button
                    width="64px"
                    height="64px"
                    className="NuclearBomb__Button NuclearBomb__Button--keypad"
                    tooltip="切换是否从电缆取电。"
                    onClick={() => act('toggle_wire')}
                  >
                    <Icon name="plug" size={3} mt="0.5rem" ml="0.1rem" />
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    width="64px"
                    height="64px"
                    className="NuclearBomb__Button NuclearBomb__Button--keypad"
                    onClick={() => act('toggle_power')}
                  >
                    <Icon name="power-off" size={3} mt="0.5rem" ml="0.1rem" />
                  </Button>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <Stack vertical>
                <Box textAlign="center">重力控制</Box>
                <Stack.Divider />
                <Stack.Item>
                  <Button
                    width="100%"
                    height="100%"
                    className="NuclearBomb__Button NuclearBomb__Button--keypad"
                    onClick={() => act('adjust_grav', { adjustment: 1 })}
                  >
                    <Icon name="arrow-up" size={3} mt="0.5rem" ml="1.2rem" />
                  </Button>
                </Stack.Item>
                <Stack.Divider />
                <Stack.Item>
                  <Button
                    width="100%"
                    height="100%"
                    className="NuclearBomb__Button NuclearBomb__Button--keypad"
                    onClick={() => act('adjust_grav', { adjustment: -1 })}
                  >
                    <Icon name="arrow-down" size={3} mt="0.5rem" ml="1.2rem" />
                  </Button>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item>
              <Stack vertical>
                <Box textAlign="center">范围控制</Box>
                <Stack.Divider />
                <Stack.Item>
                  <Button
                    width="100%"
                    height="100%"
                    className="NuclearBomb__Button NuclearBomb__Button--keypad"
                    onClick={() => act('adjust_range', { adjustment: 1 })}
                  >
                    <Icon name="arrow-up" size={3} mt="0.5rem" ml="1rem" />
                  </Button>
                </Stack.Item>
                <Stack.Divider />
                <Stack.Item>
                  <Button
                    width="100%"
                    height="100%"
                    className="NuclearBomb__Button NuclearBomb__Button--keypad"
                    onClick={() => act('adjust_range', { adjustment: -1 })}
                  >
                    <Icon name="arrow-down" size={3} mt="0.5rem" ml="1rem" />
                  </Button>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
