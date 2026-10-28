import { BlockQuote, Button, Flex, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

enum LawType {
  HACKED = 'hacked',
  CORE = 'core',
  SUPPLIED = 'supplied',
}

const lawTypeColors = {
  [LawType.HACKED]: 'red',
  [LawType.CORE]: 'blue',
  [LawType.SUPPLIED]: 'green',
};

type Law = {
  text: string;
  number: number | string;
  type: LawType;
};

type Data = {
  locked: BooleanLike;
  stated_laws: string[];
  all_laws: Law[];
};

export const StateLawUi = () => {
  const { data, act } = useBackend<Data>();
  const { locked, stated_laws, all_laws } = data;

  return (
    <Window
      title="宣读法则"
      width={400}
      height={Math.max(1, all_laws.length) * 55 + 150}
    >
      <Window.Content
        style={{
          backgroundImage: 'none',
        }}
      >
        <Section
          title="向船员宣读时，要包含哪些法则？"
          scrollable
        >
          <Stack vertical>
            {all_laws.length === 0 ? (
              <Stack.Item>
                <BlockQuote>没有可用的法则！</BlockQuote>
              </Stack.Item>
            ) : (
              all_laws.map((law, index) => (
                <Stack.Item key={index} className="candystripe">
                  <Flex align="center" p={0.5}>
                    <Flex.Item mr={0.5}>
                      <Button.Checkbox
                        iconSize={2}
                        checked={stated_laws.includes(law.text)}
                        onClick={() => act('toggle_stated', { law: law.text })}
                      />
                    </Flex.Item>
                    <Flex.Item grow={1}>
                      <BlockQuote
                        textColor={lawTypeColors[law.type] || 'green'}
                      >
                        {law.number}. {law.text}
                      </BlockQuote>
                    </Flex.Item>
                  </Flex>
                </Stack.Item>
              ))
            )}
          </Stack>
        </Section>
        <Section>
          <Button.Confirm
            width="100%"
            textAlign="center"
            fontSize="20px"
            color="blue"
            confirmColor="green"
            disabled={locked}
            onClick={() => act('state_laws')}
            italic={!!locked}
          >
            {locked ? '冷却中' : '宣读法则'}
          </Button.Confirm>
        </Section>
      </Window.Content>
    </Window>
  );
};
