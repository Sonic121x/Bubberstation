import { BlockQuote, LabeledList, Section, Stack } from 'tgui-core/components';

import { Window } from '../layouts';
import { Rules } from './AntagInfoRules'; // SKYRAT EDIT ADDITION

const tipstyle = {
  color: 'white',
};

const noticestyle = {
  color: 'lightblue',
};

export const AntagInfoNightmare = (props) => {
  return (
    <Window width={620} height={380}>
      <Window.Content backgroundColor="#0d0d0d">
        <Stack fill>
          <Stack.Item width="46.2%">
            <Section fill>
              <Stack vertical fill>
                <Stack.Item fontSize="25px">你是梦魇。</Stack.Item>
                <Stack.Item>
                  <BlockQuote>
                    你是来自群星之外的生物，在黑暗中拥有无比
                    强大的力量，几乎不可战胜。
                    遗憾的是，你在光照下会衰弱并遭受灼伤。你
                    必须使用
                    <span style={noticestyle}>&ensp;噬光者</span>让
                    空间站陷入黑暗，以便狩猎。
                  </BlockQuote>
                </Stack.Item>
                <Stack.Divider />
                <Stack.Item textColor="label">
                  <span style={tipstyle}>技巧 1：&ensp;</span>
                  经常移动。被发现后，空间站人员会追捕你，
                  所以不要在同一区域停留太久。
                  <br />
                  <span style={tipstyle}>技巧 2：&ensp;</span>
                  挑有利的架打。单打独斗时你极其强大，
                  要善用这一点。交战越频繁，
                  维持黑暗就越困难。
                  <br />
                  <span style={tipstyle}>技巧 3：&ensp;</span>
                  尽可能彻底摧毁 APC。比起破坏容易修复的灯，
                  不如破坏更难修复的 APC。
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item width="53%">
            <Section fill title="能力">
              <LabeledList>
                <LabeledList.Item label="暗影之舞">
                  在阴影中，你免疫所有远程攻击，
                  并会迅速恢复生命值。
                </LabeledList.Item>
                <LabeledList.Item label="暗影漫步">
                  你可以在黑暗中无限制地自由移动。
                  光照会使你退出此状态。
                </LabeledList.Item>
                <LabeledList.Item label="黑暗之心">
                  你的心脏招来阴影。如果你在黑暗中死去，
                  只要不受干扰，最终便会复活。
                </LabeledList.Item>
                <LabeledList.Item label="噬光者">
                  你扭曲的肢体。它会吞噬接触之物的光芒，
                  无论是受害者还是物体。在暗影漫步状态中停留
                  7 秒后，刺击敌人会使其眩晕或造成额外伤害。
                </LabeledList.Item>
              </LabeledList>
            </Section>
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
