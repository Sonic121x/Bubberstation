import { Button, LabeledList, Section } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { ColorItem } from './RapidPipeDispenser';

type Data = {
  has_cap: BooleanLike;
  can_change_colour: BooleanLike;
  drawables: Drawable[];
  is_capped: BooleanLike;
  selected_stencil: string;
  is_literate_user: BooleanLike;
  text_buffer: string;
};

type Drawable = {
  items: { item: string; label?: string }[];
  name: string;
};

export const Crayon = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    has_cap,
    can_change_colour,
    drawables = [],
    is_capped,
    selected_stencil,
    is_literate_user,
    text_buffer,
    washable_coloring_mode,
    remove_coloring,
  } = data;
  const capOrChanges = has_cap || can_change_colour;

  return (
    <Window width={600} height={600}>
      <Window.Content scrollable>
        {!!capOrChanges && (
          <Section title="基本设置">
            <LabeledList>
              <LabeledList.Item label="盖子">
                <Button
                  icon={is_capped ? 'power-off' : 'times'}
                  content={is_capped ? '已盖上' : '已取下'}
                  selected={is_capped}
                  onClick={() => act('toggle_cap')}
                />
              </LabeledList.Item>
              <ColorItem />
              <LabeledList.Item>
                <Button
                  content="自定义颜色"
                  onClick={() => act('custom_color')}
                />
              </LabeledList.Item>
              <LabeledList.Item>
                <Button
                  content={washable_coloring_mode ? '可清洗油漆' : '永久油漆'}
                  onClick={() => act('change_color_mode')}
                />
                <Button
                  content={remove_coloring ? '除漆模式' : '喷漆模式'}
                  selected={remove_coloring}
                  onClick={() => act('toggle_remove_coloring')}
                />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
        <Section title="模板">
          <LabeledList>
            {drawables.map((drawable) => {
              const items = drawable.items || [];
              return (
                <LabeledList.Item key={drawable.name} label={drawable.name}>
                  {items.map((item) => (
                    <Button
                      key={item.item}
                      content={item.label || item.item}
                      selected={item.item === selected_stencil}
                      onClick={() =>
                        act('select_stencil', {
                          item: item.item,
                        })
                      }
                    />
                  ))}
                </LabeledList.Item>
              );
            })}
          </LabeledList>
        </Section>
        {!!is_literate_user && (
          <Section title="文字">
            <LabeledList>
              <LabeledList.Item label="待写内容">
                {text_buffer}
              </LabeledList.Item>
            </LabeledList>
            <Button content="新文字" onClick={() => act('enter_text')} />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
