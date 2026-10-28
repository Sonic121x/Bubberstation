// THIS IS A SKYRAT UI FILE
import {
  Button,
  Collapsible,
  LabeledList,
  Section,
  TextArea,
} from 'tgui-core/components';

import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';

type StoryManagerData = {
  current_stories: Story[];
  archived_stories: Story[];
  current_date: string;
};

type Story = {
  title: string;
  text: string;
  id: string;
  year: string;
  month: string;
  day: string;
};

export const StoryManager = (props) => {
  const { data, act } = useBackend<StoryManagerData>();
  const { current_stories, archived_stories, current_date } = data;

  const [title, setTitle] = useLocalState('title', '');
  const [text, setText] = useLocalState('text', '');
  const [id, setID] = useLocalState('id', '');

  return (
    <Window width={600} height={800} title="背景故事播报管理器">
      <Window.Content scrollable>
        <Section textAlign="center">
          背景故事播报管理器
          <br />
          <i>在此发布的内容要到下一回合才会显示！</i>
          <br />
          <span style={{ color: 'red' }}>
            除非清楚自己在做什么，否则请勿随意修改。
          </span>
        </Section>
        <Section>
          <LabeledList>
            <LabeledList.Item label="标题">
              <TextArea
                height="20px"
                placeholder="文章的简短标题／作者。"
                onChange={setTitle}
              />
            </LabeledList.Item>
            <LabeledList.Item label="正文">
              <TextArea
                height="100px"
                placeholder="文章的正文内容。"
                onChange={setText}
              />
            </LabeledList.Item>
            <LabeledList.Item label="标识符">
              <TextArea
                height="20px"
                placeholder="文章的唯一标识符。若此标识符已被使用，文章将无法发布。"
                onChange={setID}
              />
            </LabeledList.Item>
            <LabeledList.Item label="日期">
              <i>发布日期：{current_date}</i>
            </LabeledList.Item>
          </LabeledList>
          <Button
            icon="arrow-up"
            mr="9px"
            color="blue"
            onClick={() => {
              act('publish_article', {
                title: title,
                text: text,
                id: id,
              });
            }}
          >
            发布
          </Button>
        </Section>
        <Collapsible title="当前故事">
          {current_stories.map((story) => (
            <Collapsible
              bold
              key={story.id}
              title={
                story.title +
                ' | 发布于 ' +
                story.month +
                '/' +
                story.day +
                '/' +
                story.year
              }
            >
              <Section>
                {story.text}
                <br />
                <Button
                  icon="book"
                  mr="9px"
                  color="red"
                  onClick={() => {
                    act('archive_article', {
                      id: story.id,
                    });
                  }}
                >
                  归档
                </Button>
              </Section>
            </Collapsible>
          ))}
        </Collapsible>
        <Collapsible title="已归档故事">
          {archived_stories.map((story) => (
            <Collapsible
              bold
              key={story.id}
              title={
                story.title +
                ' | 发布于 ' +
                story.month +
                '/' +
                story.day +
                '/' +
                story.year
              }
            >
              <Section>
                {story.text}
                <br />
                <Button
                  icon="floppy-disk"
                  mr="9px"
                  color="green"
                  onClick={() => {
                    act('circulate_article', {
                      id: story.id,
                    });
                  }}
                >
                  重新发布
                </Button>
              </Section>
            </Collapsible>
          ))}
        </Collapsible>
      </Window.Content>
    </Window>
  );
};
