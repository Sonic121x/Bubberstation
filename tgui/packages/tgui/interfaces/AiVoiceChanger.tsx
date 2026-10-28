import {
  Button,
  Dropdown,
  Input,
  LabeledList,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  loud: BooleanLike;
  name: string;
  on: BooleanLike;
  say_verb: string;
  selected: string;
  voices: string[];
};

export function AiVoiceChanger(props) {
  const { act, data } = useBackend<Data>();
  const { loud, name, on, say_verb, voices, selected } = data;

  return (
    <Window title="变声器设置" width={400} height={200}>
      <Section fill>
        <LabeledList>
          <LabeledList.Item label="电源">
            <Button
              icon={on ? 'power-off' : 'times'}
              selected={!!on}
              onClick={() => act('power')}
            >
              {on ? '开启' : '关闭'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="口音">
            <Dropdown
              options={voices}
              onSelected={(value) => {
                act('look', {
                  look: value,
                });
              }}
              selected={selected}
            />
          </LabeledList.Item>
          <LabeledList.Item label="说话动词">
            <Input
              value={say_verb}
              onBlur={(value) =>
                act('verb', {
                  verb: value,
                })
              }
            />
          </LabeledList.Item>
          <LabeledList.Item label="音量">
            <Button
              icon={loud ? 'power-off' : 'times'}
              selected={!!loud}
              onClick={() => act('loud')}
            >
              {loud ? '高音量模式开启' : '高音量模式关闭'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="假名">
            <Input
              value={name}
              onBlur={(value) =>
                act('name', {
                  name: value,
                })
              }
            />
          </LabeledList.Item>
        </LabeledList>
      </Section>
    </Window>
  );
}
