import { Box, Icon, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { type Objective, ObjectivePrintout } from './common/Objectives';

type Data = {
  objectives: Objective[];
};

export const AntagInfoBrainwashed = (porps) => {
  const { data } = useBackend<Data>();

  return (
    <Window width={400} height={400} theme="abductor">
      <Window.Content backgroundColor="#722e7d">
        <Icon
          size={16}
          name="flushed"
          color="#3f1945"
          position="absolute"
          top="42%"
          left="26%"
        />
        <Section fill>
          <Stack fill vertical g={0} textAlign="center">
            <Stack.Item fontFamily="Wingdings">
              Hey, no! Stop translating this!
            </Stack.Item>
            <Stack.Item fontSize="20px">你的思绪一片混乱……</Stack.Item>
            <Stack.Item fontSize="20px">
              它正集中于唯一的目标……
            </Stack.Item>
            <Stack.Item mt={3.5} grow>
              <ObjectivePrintout
                fill
                objectives={data.objectives}
                objectiveFollowup={
                  <Box bold textColor="red">
                    必须遵从这项指令。
                  </Box>
                }
              />
            </Stack.Item>
            <Stack.Item mb={0.5} fontSize="20px" textColor="#61e4b9">
              不惜一切代价遵从指令！
            </Stack.Item>
            <Stack.Item fontFamily="Wingdings">
              You ruined my cool font effect.
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
