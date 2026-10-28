import { useState } from 'react';
import {
  BlockQuote,
  Dropdown,
  Flex,
  Input,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  policy: Record<string, string>;
};

function searchForPolicy(policy: Record<string, string>, token: string) {
  return Object.keys(policy).filter((key) =>
    key.toLowerCase().includes(token.toLowerCase()),
  );
}

export const Policypanel = () => {
  const { data } = useBackend<Data>();
  const { policy } = data;

  const [currentPolicy, setCurrentPolicy] = useState<string>('');

  return (
    <Window title="规则面板" theme="admin" width={400} height={300}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <Flex>
              <Flex.Item width="50%">
                <Dropdown
                  options={Object.keys(policy)}
                  selected={currentPolicy}
                  onSelected={setCurrentPolicy}
                />
              </Flex.Item>
              <Flex.Item width="50%">
                <Input
                  placeholder="搜索……"
                  fluid
                  onEnter={(value) => {
                    const results = searchForPolicy(policy, value);
                    if (results.length === 1) {
                      setCurrentPolicy(results[0]);
                    }
                  }}
                />
              </Flex.Item>
            </Flex>
          </Stack.Item>
          <Stack.Item height="100%">
            <Section scrollable fill>
              <BlockQuote fontSize="16px">
                {policy[currentPolicy] ||
                  `选择要查看的规则。这些规则会在玩家
                    获得对应角色时向其展示。`}
              </BlockQuote>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
