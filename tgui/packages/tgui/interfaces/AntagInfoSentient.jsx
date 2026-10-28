import { BlockQuote, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const AntagInfoSentient = (props) => {
  const { act, data } = useBackend();
  const { enslaved_to, holographic } = data;
  return (
    <Window width={400} height={400} theme="neutral">
      <Window.Content>
        <Section fill>
          <Stack vertical fill textAlign="center">
            <Stack.Item fontSize="20px">
              你是有知觉的生物！
            </Stack.Item>
            <Stack.Item>
              <BlockQuote>
                一切突然变得清晰：你知道自己是什么，也知道自己是谁！
                你拥有了自我意识！
                {!!enslaved_to &&
                  ' 你很庆幸自己拥有了自我意识，并深深感激 ' +
                    enslaved_to +
                    '。请服侍 ' +
                    enslaved_to +
                    '，并帮助' +
                    '对方' +
                    '不惜一切代价完成' +
                    '其' +
                    '目标。'}
                {!!holographic &&
                  ' 你也沮丧地意识到，自己并非真正的生物，而是全息形体。你的存在受限于全息甲板的设定。'}
              </BlockQuote>
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
