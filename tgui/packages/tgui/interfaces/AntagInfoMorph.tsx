import { BlockQuote, Stack } from 'tgui-core/components';

import { Window } from '../layouts';
import { Rules } from './AntagInfoRules'; // SKYRAT EDIT ADDITION

const goodstyle = {
  color: 'lightgreen',
};

const badstyle = {
  color: 'red',
};

const noticestyle = {
  color: 'lightblue',
};

export const AntagInfoMorph = (props) => {
  return (
    <Window width={620} height={170} theme="abductor">
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item fontSize="25px">你是拟态怪……</Stack.Item>
          <Stack.Item>
            <BlockQuote>
              ……一个能变形、几乎什么都能吃的怪物。你
              可以模仿任何看得到的东西，只需{' '}
              <span style={noticestyle}>
                对其使用“变化形态”能力。按住 Shift 点击
                目标物体也可以。
              </span>{' '}
              <span style={badstyle}>
                &ensp;这个过程会惊动附近的所有目击者。
              </span>{' '}
              变形后，你的移动速度更快，但无法攻击生物
              或进食。此外，
              <span style={badstyle}>
                &ensp;三格以内的人检查你时，
                会察觉到诡异的不对劲之处。
              </span>{' '}
              你可以攻击任意物品或死亡生物来吞食它；
              <span style={goodstyle}>
                &ensp;尸体能恢复你的生命值。
              </span>{' '}
              最后，变形状态下想恢复原形，
              可以{' '}
              <span style={noticestyle}>
                对自己使用“变化形态”能力。你也可以
                按住 Shift 点击自己。
              </span>{' '}
            </BlockQuote>
          </Stack.Item>
          {/* SKYRAT EDIT ADDITION START */}
          <Stack.Item>
            <Rules />
          </Stack.Item>
          {/* SKYRAT EDIT ADDITION END */}
        </Stack>
      </Window.Content>
    </Window>
  );
};
