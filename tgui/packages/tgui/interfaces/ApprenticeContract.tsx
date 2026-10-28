import {
  BlockQuote,
  Box,
  Button,
  Icon,
  Section,
  Stack,
} from 'tgui-core/components';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';

export const ApprenticeContract = (props) => {
  return (
    <Window width={620} height={600} theme="wizard">
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Section textColor="lightgreen" fontSize="15px">
              如果今天联系不到任何学徒，你可以把
              契约放回法术书中退款。
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <ApprenticeSelection
              iconName="fire"
              fluffName="毁灭学徒"
              schoolTitle="destruction"
              assetName="destruction.png"
              blurb={`
                你的学徒擅长攻击魔法。
                其掌握魔法飞弹与火球术。
              `}
            />
            <ApprenticeSelection
              iconName="route"
              fluffName="移形学生"
              schoolTitle="bluespace"
              assetName="bluespace.png"
              blurb={`
              你的学徒能够违背物理法则，穿过
              实体障碍，并在眨眼间跨越
              遥远距离。其掌握传送术与以太漫步。
              `}
            />
            <ApprenticeSelection
              iconName="medkit"
              fluffName="复原新徒"
              schoolTitle="healing"
              assetName="healing.png"
              blurb={`
              你的学徒正在学习施展能够
              帮你生存的法术。其掌握力场墙与充能术，
              并配有一根治疗法杖。
              `}
            />
            <ApprenticeSelection
              iconName="user-secret"
              fluffName="无袍弟子"
              schoolTitle="robeless"
              assetName="robeless.png"
              blurb={`
              你的学徒正在学习不穿法袍
              施法。其掌握敲击术与心灵交换。
              `}
            />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const ApprenticeSelection = (props) => {
  const { act } = useBackend();
  const { iconName, fluffName, schoolTitle, assetName, blurb } = props;
  return (
    <Section>
      <Stack align="middle" fill>
        <Stack.Item>
          <Stack vertical>
            <Stack.Item>
              <img
                src={resolveAsset(assetName)}
                style={{
                  borderStyle: 'solid',
                  borderColor: '#7e90a7',
                }}
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                textAlign="center"
                fluid
                onClick={() =>
                  act('buy', {
                    school: schoolTitle,
                  })
                }
              >
                选择
              </Button>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item grow>
          <Box fontSize="20px" height="30%">
            <Icon name={iconName} /> {fluffName}
          </Box>
          <BlockQuote height="70%" fontSize="16px">
            {blurb}
          </BlockQuote>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
