import { useBackend } from 'tgui/backend';
import {
  BlockQuote,
  Box,
  LabeledList,
  Section,
  Stack,
} from 'tgui-core/components';
import { decodeHtmlEntities } from 'tgui-core/string';

import { DIRECTIVE_COMPREHENSION, DIRECTIVE_ORDER } from './constants';
import type { PaiData } from './types';

/** Shows the hardcoded PAI info along with any supplied orders. */
export function DirectiveDisplay(props) {
  const { data } = useBackend<PaiData>();
  const { directives = [], master_name } = data;
  const displayedLaw = directives?.length
    ? decodeHtmlEntities(directives[0])
    : '无。';

  return (
    <Stack fill vertical>
      <Stack.Item grow={2}>
        <Section fill scrollable title="逻辑核心">
          <Box color="label">
            {DIRECTIVE_COMPREHENSION}
            <br />
            <br />
            {DIRECTIVE_ORDER}
          </Box>
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <Section fill scrollable title="指令">
          {!master_name ? (
            '无。'
          ) : (
            <LabeledList>
              <LabeledList.Item label="首要指令">
                为你的主人服务。
              </LabeledList.Item>
              <LabeledList.Item label="补充指令">
                <BlockQuote>{displayedLaw}</BlockQuote>
              </LabeledList.Item>
            </LabeledList>
          )}
        </Section>
      </Stack.Item>
    </Stack>
  );
}
