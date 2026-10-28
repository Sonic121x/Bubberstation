import { Box, Button, NoticeBox, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  details: string[];
  selected: string;
};

type Props = {
  category: string;
};

const UI_WARNINGS = [
  `嘿，混蛋们，这些滤镜所依据的矩阵非常古老，
  而且存在严重缺陷。`,
  `在 BYOND 中没有妥善模拟色盲的好办法，
因为我们无法在不遍历屏幕所有像素的情况下
提取像素的伽马值，而针对人眼进行正确校正
恰恰需要这些信息。`,
  `因此，这种模拟远非完美。你会发现
画面比实际情况亮得多。这直接源于
无法进行伽马校正。`,
  `这个工具只是为无障碍设计提供一个粗略的
参考基准，绝非权威结论。`,
  `要是让我发现你拿这个结果欺负别人，
我就拿撬棍揍你。`,
] as const;

export const ColorBlindTester = (props) => {
  const { data } = useBackend<Data>();
  const { details } = data;

  return (
    <Window title="色盲模拟测试" width={600} height={515}>
      <Window.Content>
        <NoticeBox>
          {UI_WARNINGS.map((warning, index) => (
            <Box key={index}>{warning}</Box>
          ))}
        </NoticeBox>
        <Section>
          {Object.keys(details).map((category) => (
            <ColorBlindCategory category={category} key={category} />
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};

const ColorBlindCategory = (props: Props) => {
  const { act, data } = useBackend<Data>();
  const { category } = props;
  const { details, selected } = data;

  if (category !== selected) {
    return (
      <Section
        key={category}
        title={{ Protanopia: '红色盲', Deuteranopia: '绿色盲', Tritanopia: '蓝黄色盲', Achromatopsia: '全色盲' }[category] || category}
        buttons={
          <Button
            icon="eye"
            content="选择"
            onClick={() =>
              act('set_matrix', {
                name: category,
              })
            }
          />
        }
      >
        {details[category]}
      </Section>
    );
  }
  return (
    <Section
      key={category}
      title={{ Protanopia: '红色盲', Deuteranopia: '绿色盲', Tritanopia: '蓝黄色盲', Achromatopsia: '全色盲' }[category] || category}
      buttons={
        <Button
          icon="times"
          content="清除"
          color="bad"
          onClick={() => act('clear_matrix')}
        />
      }
    >
      {details[category]}
    </Section>
  );
};
