import { useBackend } from 'tgui/backend';
import { Box, Collapsible, Section } from 'tgui-core/components';

import { BellyContents } from './BellyUI';
import * as types from './types';

export const Inside = (props) => {
  const { data } = useBackend<types.Data>();
  const { inside } = data;

  if (!inside) {
    return <Section title="体内！">你不在任何人的体内！</Section>;
  }

  const preyMode = types.digestModeToPreyMode[inside.digest_mode];

  return (
    <Section title="体内！">
      <Box>
        <Box color="yellow" inline>
          你目前位于
        </Box>{' '}
        <Box inline color="blue">
          {inside.owner_name || '某人'}
          的
        </Box>{' '}
        <Box inline color="red">
          {inside.name}
        </Box>{' '}
        <Box inline color="yellow">
          内，正
        </Box>{' '}
        <Box inline color={preyMode.color}>
          {preyMode.text}
        </Box>
      </Box>
      <Box mb={1} color="label" preserveWhitespace>
        {inside.desc}
      </Box>
      {inside.contents.length ? (
        <Collapsible title="腹腔内容物">
          <BellyContents contents={inside.contents} />
        </Collapsible>
      ) : (
        '你周围没有其他东西。'
      )}
    </Section>
  );
};
