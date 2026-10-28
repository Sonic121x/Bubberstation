import { Button, Dimmer, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const STORY_VALUE_KEY = -1;
const STORY_VALUE_SHIT = 0;
const STORY_VALUE_NONE = 1;
const STORY_VALUE_MEH = 2;
const STORY_VALUE_OKAY = 3;
const STORY_VALUE_AMAZING = 4;
const STORY_VALUE_LEGENDARY = 5;

const MemoryQuality = (props) => {
  const { act } = useBackend();
  const { quality } = props;

  if (quality === STORY_VALUE_KEY) {
    return (
      <Button
        icon="key"
        color="transparent"
        tooltipPosition="right"
        tooltip={`
          这是一段关键记忆，其中包含重要信息，
          你以后可能需要再次查阅。
        `}
      />
    );
  }
  if (quality === STORY_VALUE_SHIT) {
    return (
      <Button
        icon="poop"
        color="transparent"
        tooltipPosition="right"
        tooltip={`
          这段记忆毫无趣味！它无法成就
          好的艺术作品，也不太可能流传后世。
        `}
      />
    );
  }
  if (quality === STORY_VALUE_NONE) {
    return (
      <Button
        icon="star"
        color="transparent"
        tooltipPosition="right"
        tooltip={`
          这段记忆相当平淡。以它创作的艺术作品
          也会十分平庸，不太可能流传后世。
  `}
      />
    );
  }
  if (quality === STORY_VALUE_MEH) {
    return (
      <Button
        icon="star"
        style={{
          background:
            'linear-gradient(to right, #964B30, #D68B60, #B66B30, #D68B60, #964B30);',
        }}
        tooltipPosition="right"
        tooltip={`
          这段记忆不算特别有趣。它或许能成为
          一个还过得去的故事，但别抱太大期望。
    `}
      />
    );
  }
  if (quality === STORY_VALUE_OKAY) {
    return (
      <Button
        icon="star"
        style={{
          background:
            'linear-gradient(to right, #636363, #a3a3a3, #6e6e6e, #a3a3a3, #636363);',
        }}
        tooltipPosition="right"
        tooltip={`
          这段记忆挺不错！它可以讲成一些好故事，
          甚至可能被后人传颂。
      `}
      />
    );
  }
  if (quality === STORY_VALUE_AMAZING) {
    return (
      <Button
        icon="star"
        style={{
          background:
            'linear-gradient(to right, #AA771C, #BCB68A, #B38728, #BCB68A, #AA771C);',
        }}
        tooltipPosition="right"
        tooltip={`
          这段记忆非常精彩！你可以用它讲述动人的故事，
          而且很有可能流传后世！
      `}
      />
    );
  }
  if (quality === STORY_VALUE_LEGENDARY) {
    return (
      <Button
        icon="crown"
        style={{
          background:
            'linear-gradient(to right, #56A5B3, #75D4E2, #56A5B3, #75D4E2, #56A5B3)',
        }}
        tooltipPosition="right"
        tooltip={`
          这段记忆堪称传奇！它可以成就
          传世艺术作品，并极有可能流传后世。
        `}
      />
    );
  }
  // Default return / error
  return (
    <Button
      icon="question"
      tooltipPosition="right"
      tooltip={`
        这段记忆没有有效的品质等级，我们无法判断
        它的好坏。这是一个错误，请报告此问题！
      `}
    />
  );
};

export const MemoryPanel = (props) => {
  const { act, data } = useBackend();
  const memories = data.memories || [];
  return (
    <Window title="记忆面板" width={400} height={500}>
      <Window.Content>
        <Section
          maxHeight="32px"
          title="记忆"
          buttons={
            <Button
              color="transparent"
              tooltip={`
                这些是你的记忆。经历值得铭记的事件后，你会获得记忆，
                并能以其创作艺术作品！
              `}
              tooltipPosition="bottom-start"
              icon="info"
            />
          }
        />
        {(!memories && (
          <Dimmer fontSize="28px" align="center">
            你没有任何记忆！
          </Dimmer>
        )) || (
          <Stack vertical>
            {memories.map((memory) => (
              <Stack.Item key={memory.name}>
                <Section>
                  <MemoryQuality quality={memory.quality} /> {memory.name}
                </Section>
              </Stack.Item>
            ))}
          </Stack>
        )}
      </Window.Content>
    </Window>
  );
};
