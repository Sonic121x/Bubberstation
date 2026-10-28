// THIS IS A SKYRAT UI FILE
import { useBackend } from '../backend';
import { Collapsible, Section } from 'tgui-core/components';
import { NtosWindow } from '../layouts';

export const NtosNewsArchive = (props) => {
  const { data } = useBackend();
  const { stories } = data;

  return (
    <NtosWindow width={600} height={800}>
      <NtosWindow.Content scrollable>
        <Section textAlign="center">
          纳米传讯新闻网络档案！
        </Section>
        {stories.map((story) => (
          <Collapsible
            bold
            key={story.title}
            title={
              story.title +
              ' | 发布日期 ' +
              story.month +
              '/' +
              story.day +
              '/' +
              story.year
            }
          >
            <Section>{story.text}</Section>
          </Collapsible>
        ))}
      </NtosWindow.Content>
    </NtosWindow>
  );
};
