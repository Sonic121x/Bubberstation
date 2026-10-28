import { Icon, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { type Objective, ObjectivePrintout } from './common/Objectives';

type Info = {
  objectives: Objective[];
  nation: string;
  nationColor: string;
};

export const AntagInfoSeparatist = (props) => {
  const { data } = useBackend<Info>();
  const { nationColor } = data;
  return (
    <Window width={620} height={450}>
      <Window.Content backgroundColor={nationColor}>
        <Stack vertical fill>
          <Stack.Item grow>
            <IntroductionObjectives />
          </Stack.Item>
          <Stack.Item>
            <FrequentlyAskedQuestions />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const IntroductionObjectives = (props) => {
  const { data } = useBackend<Info>();
  const { nation, objectives } = data;
  return (
    <Section fill>
      <Stack vertical>
        <Stack.Item textColor="red" fontSize="20px">
          你是为{nation}争取自由的分离主义者！
        </Stack.Item>
        <Stack.Item grow>
          <ObjectivePrintout
            objectives={objectives}
            titleMessage={`${nation}的目标：`}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const FrequentlyAskedQuestions = (props) => {
  const { data } = useBackend<Info>();
  const { nation } = data;
  return (
    <Section fill>
      <Stack vertical>
        <Stack.Item fontSize="18px" bold>
          <Icon name="info" color="label" /> 常见问题：
        </Stack.Item>
        <Stack.Item fontSize="16px">
          “分离主义者到底是什么？”
        </Stack.Item>
        <Stack.Item>
          分离主义者是一种半反派角色，回合开始时
          各个部门都充满了他们。他们不能随意
          杀戮，而应捍卫自己部门的主权。
          你或许听说过他们曾经所属的游戏模式：
          国家模式！
        </Stack.Item>
        <Stack.Item fontSize="16px">
          “我该做什么？”
        </Stack.Item>
        <Stack.Item>
          每个部门（国家）都有一个目标。这是一个自由形式的
          目标，因此你应像对待绑架者的自由目标一样，
          尽力完成它。根据经验，各国最终会产生冲突，
          并演变成战争。只要双方部门都清楚冲突的
          起因和经过，就可以进攻
          敌对国家。
        </Stack.Item>
        <Stack.Item fontSize="16px">
          “{nation}是最棒的国家吗？”
        </Stack.Item>
        <Stack.Item>是的。</Stack.Item>
      </Stack>
    </Section>
  );
};
