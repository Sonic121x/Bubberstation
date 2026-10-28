import { Box, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { type Objective, ObjectivePrintout } from './common/Objectives';

const jauntstyle = {
  color: 'lightblue',
};

const injurestyle = {
  color: 'yellow',
};

type Info = {
  fluff: string;
  explain_attack: BooleanLike;
  objectives: Objective[];
};

export const AntagInfoDemon = (props) => {
  const { data } = useBackend<Info>();
  const { fluff, objectives, explain_attack } = data;
  return (
    <Window width={620} height={356} theme="syndicate">
      <Window.Content style={{ backgroundImage: 'none' }}>
        <Stack fill>
          <Stack.Item>
            <DemonRunes />
          </Stack.Item>
          <Stack.Item grow>
            <Stack vertical width="544px" fill>
              <Stack.Item grow>
                <Section fill scrollable={objectives.length > 2}>
                  <Stack vertical>
                    <Stack.Item
                      textAlign="center"
                      textColor="red"
                      fontSize="20px"
                    >
                      {fluff}
                    </Stack.Item>
                    <Stack.Item>
                      <ObjectivePrintout
                        titleMessage="完成这些目标是你的本性："
                        objectiveTextSize="20px"
                        objectives={objectives}
                      />
                    </Stack.Item>
                  </Stack>
                </Section>
              </Stack.Item>
              {!!explain_attack && (
                <Stack.Item>
                  <Section fill title="恶魔之力">
                    <Stack vertical>
                      <Stack.Item>
                        <span style={jauntstyle}>血遁：</span>你可以
                        潜入血泊并从另一处血泊中现身，前往所需的
                        地点。结束血遁时会获得速度加成，
                        适合发动突袭。你可以把失去反抗能力的
                        受害者拖入血泊，吞噬他们并恢复
                        生命值。
                      </Stack.Item>
                      <Stack.Divider />
                      <Stack.Item>
                        <span style={injurestyle}>怪力重击：</span>你
                        可以通过右键点击发动毁灭性的重击，
                        一击就能打碎骨头。这很适合
                        阻止受害者逃跑，因为伤势
                        会让他们减速。
                      </Stack.Item>
                    </Stack>
                  </Section>
                </Stack.Item>
              )}
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <DemonRunes />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const DemonRunes = (props) => {
  return (
    <Section height="102%" mt="-6px" fill>
      {/*
      shoutout to my boy Yuktopus from Crash Bandicoot: Crash of the Titans.
      Damn, that was such a good game.
      */}
      <Box className="HellishRunes__demonrune">
        Y<br />U<br />K<br />T<br />O<br />P<br />U<br />S<br />
        Y<br />U<br />K<br />T<br />O<br />P<br />U<br />S<br />
        Y<br />U<br />K<br />T<br />O<br />P<br />U<br />S<br />
        Y<br />U<br />K<br />T<br />O<br />P<br />U<br />S
      </Box>
    </Section>
  );
};
