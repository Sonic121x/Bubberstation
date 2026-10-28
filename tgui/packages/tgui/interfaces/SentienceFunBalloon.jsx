import {
  Button,
  Input,
  LabeledList,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const SentienceFunBalloon = (props) => {
  const { act, data } = useBackend();
  const { group_name, range, antag } = data;
  return (
    <Window title={'启智欢乐气球'} width={400} height={200}>
      <Window.Content>
        <Stack vertical>
          <Section title="配置气球效果：">
            <LabeledList>
              <LabeledList.Item label="群体名称">
                <Input
                  fluid
                  value={group_name}
                  onBlur={(value) =>
                    act('group_name', {
                      updated_name: value,
                    })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label="作用范围">
                <NumberInput
                  tickWhileDragging
                  width="84px"
                  value={range}
                  minValue={1}
                  maxValue={100}
                  step={1}
                  stepPixelSize={15}
                  onChange={(value) =>
                    act('effect_range', {
                      updated_range: value,
                    })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label="将群体设为反派？">
                <Button.Checkbox
                  icon={data.antag ? 'user-secret' : 'times'}
                  content={data.antag ? '是' : '否'}
                  selected={data.antag}
                  onClick={() => act('select_antag')}
                />
              </LabeledList.Item>
            </LabeledList>
          </Section>
          <Section>
            <Button.Confirm
              fluid
              icon="magic"
              color="good"
              textAlign="center"
              content="戳破气球"
              onClick={() => act('pop')}
            />
          </Section>
        </Stack>
      </Window.Content>
    </Window>
  );
};
