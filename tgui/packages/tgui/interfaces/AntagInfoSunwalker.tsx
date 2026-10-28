import { BlockQuote, LabeledList, Section, Stack } from 'tgui-core/components';

import { Window } from '../layouts';

const tipstyle = {
  color: 'white',
};

const noticestyle = {
  color: 'lightblue',
};

export const AntagInfoSunwalker = (props) => {
  return (
    <Window width={660} height={300}>
      <Window.Content backgroundColor="#0d0d0d">
        <Stack fill>
          <Stack.Item width="40%">
            <Section fill>
              <Stack vertical fill>
                <Stack.Item fontSize="25px">你是逐日者</Stack.Item>
                <Stack.Item>
                  <BlockQuote>
                    你是曾被卷入超新星爆发的古老
                    虚空行者。你已发生异变，满怀憎恨。
                  </BlockQuote>
                  <BlockQuote>
                    不会有教导，也不会有启迪；他们无法活着
                    领悟这一切。
                  </BlockQuote>
                </Stack.Item>
                <Stack.Divider />
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item width="60%">
            <Section fill title="能力">
              <LabeledList>
                <LabeledList.Item label="太空潜行">
                  你可以从太空潜入空间站下方移动，用它来狩猎，
                  或抵达隔绝的太空区域。
                </LabeledList.Item>
                <LabeledList.Item label="灼烧斩击">
                  你的攻击会造成大量烧伤，并点燃命中的目标。
                </LabeledList.Item>
                <LabeledList.Item label="灼热体质">
                  你的皮肤会加热周围的空气，而太空中的真空
                  会治愈你身体所受的伤。你可以
                  自由穿过玻璃，但在重力下会减速。
                </LabeledList.Item>
                <LabeledList.Item label="恒星冲锋">
                  以爆裂的炽热速度向前冲锋，造成
                  伤害并灼烧周围环境。
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
