import { Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { displayRole } from '../localization/roleDisplay';
import type { Objective } from './common/Objectives';
type Data = {
  antag_name: string;
  objectives: Objective[];
};

const textStyles = {
  variable: {
    color: 'white',
  },
  danger: {
    color: 'red',
  },
} as const;

export const AntagInfoGlitch = (props) => {
  const { data } = useBackend<Data>();
  const { antag_name, objectives = [] } = data;

  return (
    <Window width={350} height={450} theme="ntos_terminal">
      <Window.Content>
        <Section scrollable fill>
          <Stack fill vertical>
            <Stack.Item>函数 终止入侵者（引用）</Stack.Item>
            <Stack.Divider />
            <Stack.Item bold fontSize="16px">
              <span style={textStyles.variable}>初始化（{displayRole(antag_name)}）</span>
            </Stack.Item>
            <Stack.Item mb={1}>
              <span style={textStyles.danger}>比特潜行</span>是犯罪行为。你的
              任务：<span style={textStyles.variable}>消灭</span>{' '}
              有机入侵者，维护系统完整性。
            </Stack.Item>
            <SpecificInfo />

            <Stack.Divider />
            <Stack.Item>
              <span style={{ opacity: 0.6 }}>
                &#47;&#47; {objectives[0]?.explanation}
              </span>
            </Stack.Item>
            <Stack.Item>
              常量 <span style={textStyles.variable}>目标</span> ={' '}
            </Stack.Item>
            <Stack.Item>
              <span style={textStyles.variable}>系统.</span>
              <span style={textStyles.danger}>入侵者</span>
            </Stack.Item>
            <Stack.Item>
              当 <span style={textStyles.variable}>目标</span>.生命 !={' '}
              <span style={textStyles.variable}>状态.</span>死亡
            </Stack.Item>
            <Stack.Item>
              <span style={textStyles.variable}>行动.</span>
              <span style={textStyles.danger}>击杀()</span>
            </Stack.Item>
            <Stack.Item>终止入侵者([0x70cf4020])</Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

const SpecificInfo = (props) => {
  const { data } = useBackend<Data>();
  const { antag_name } = data;

  switch (antag_name) {
    case 'Cyber Police':
      return (
        <>
          <Stack.Item mb={1}>
            为协助你执行任务，你的程序已载入尖端{' '}
            <span style={textStyles.variable}>武术</span>技能。
          </Stack.Item>
          <Stack.Item grow>
            <span style={textStyles.danger}>禁止</span>使用远程武器。
            不推荐使用防弹装备。风格至上。
          </Stack.Item>
        </>
      );
    case 'Cyber Tac':
      return (
        <>
          <Stack.Item mb={1}>
            你是先进战斗单位，已配备{' '}
            <span style={textStyles.variable}>致命武器</span>。
          </Stack.Item>
          <Stack.Item grow>
            不惜一切代价<span style={textStyles.danger}>终止</span>有机
            生命。
          </Stack.Item>
        </>
      );
    case 'NetGuardian Prime':
      return (
        <Stack.Item grow>
          <span style={{ ...textStyles.danger, fontSize: '16px' }}>
            必须终止有机生命。
          </span>
        </Stack.Item>
      );
    default:
      return null;
  }
};
