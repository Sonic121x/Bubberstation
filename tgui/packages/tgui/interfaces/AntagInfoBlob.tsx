import {
  Box,
  Collapsible,
  Divider,
  LabeledList,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Rules } from './AntagInfoRules'; // BUBBER EDIT ADDITION
import type { Objective } from './common/Objectives';

type Data = {
  color: string;
  description: string;
  effects: string;
  name: string;
  objectives: Objective[];
};

const BLOB_COLOR = '#556b2f';

export const AntagInfoBlob = (props) => {
  return (
    <Window width={400} height={550}>
      <Window.Content>
        <Section fill scrollable>
          <Overview />
          <Divider />
          <Basics />
          <Structures />
          <Minions />
          <ObjectiveDisplay />
          <Rules /* SKYRAT EDIT ADDITION */ />
        </Section>
      </Window.Content>
    </Window>
  );
};

const Overview = (props) => {
  const { data } = useBackend<Data>();
  const { color, description, effects, name } = data;

  if (!name) {
    return (
      <Stack vertical>
        <Stack.Item bold fontSize="14px" textColor={BLOB_COLOR}>
          你还没有显露真身！
        </Stack.Item>
        <Stack.Item>
          你必须屈服于感染。找个安全的地方爆发吧！
        </Stack.Item>
      </Stack>
    );
  }

  return (
    <Stack vertical>
      <Stack.Item bold fontSize="24px" textColor={BLOB_COLOR}>
        你是变形菌！
      </Stack.Item>
      <Stack.Item>作为主脑，你可以控制变形菌。</Stack.Item>
      <Stack.Item>
        你的变形菌试剂是：{' '}
        <span
          style={{
            color,
          }}
        >
          {name}
        </span>
      </Stack.Item>
      <Stack.Item>
        你的{' '}
        <span
          style={{
            color,
          }}
        >
          {name}
        </span>{' '}
        试剂{description}
      </Stack.Item>
      {effects && (
        <Stack.Item>
          你的{' '}
          <span
            style={{
              color,
            }}
          >
            {name}
          </span>{' '}
          试剂{effects}
        </Stack.Item>
      )}
    </Stack>
  );
};

const Basics = (props) => {
  return (
    <Collapsible title="基础知识">
      <LabeledList>
        <LabeledList.Item label="攻击">
          你可以扩张，攻击人员、损坏物体，
          或在空地上放置普通变形菌。
        </LabeledList.Item>
        <LabeledList.Item label="放置">
          点击屏幕右下角的“放置变形菌核心”按钮，
          即可手动放置变形菌核心。{' '}
          <br />
          <br />
          如果你是变形菌感染者，
          点击屏幕左上角的爆发按钮，
          即可在你所在的位置放置核心。
        </LabeledList.Item>
        <LabeledList.Item label="抬头显示">
          除了抬头显示上的按钮，还有一些鼠标快捷操作，
          可以加快扩张和防御。
        </LabeledList.Item>
        <LabeledList.Item label="快捷操作">
          点击 = 扩张变形菌 <br />
          鼠标中键 = 集结孢子 <br />
          Ctrl + 点击 = 创建护盾变形菌 <br />
          Alt + 点击 = 移除变形菌 <br />
        </LabeledList.Item>
        <LabeledList.Item label="通讯">
          尝试说话会向所有其他主脑发送消息，
          使你能与它们协同行动。
        </LabeledList.Item>
      </LabeledList>
    </Collapsible>
  );
};

const Minions = (props) => {
  return (
    <Collapsible title="仆从">
      <LabeledList>
        <LabeledList.Item label="变形菌巨兽">
          消耗资源即可从工厂生产此单位。它们难以杀死，
          力量强大，且具备一定智慧。用于生产巨兽的工厂
          会变得脆弱，并暂时无法生产孢子。
        </LabeledList.Item>
        <LabeledList.Item label="孢子">
          工厂会自动生产这些弱小的单位，但你可以集结它们
          攻击敌人。它们也会攻击工厂附近的敌人，
          并尝试将尸体转化为僵尸。
        </LabeledList.Item>
      </LabeledList>
    </Collapsible>
  );
};

const Structures = (props) => {
  return (
    <Collapsible title="结构">
      <Box>
        普通变形菌可以扩张你的领地，并能升级为
        具有特殊功能的变形菌。请记住，
        向太空扩张有 80% 的失败概率！
      </Box>
      <br />
      <Box>你可以将普通变形菌升级为以下类型：</Box>
      <Divider />
      <LabeledList>
        <LabeledList.Item label="坚固变形菌">
          坚固变形菌造价昂贵，但能承受更多伤害。此外，
          它们防火且能阻挡气流，可以用来
          保护自己免受空间站火灾的伤害。
        </LabeledList.Item>
        <LabeledList.Item label="反射变形菌">
          将坚固变形菌升级为反射变形菌，可反射大多数弹射物，
          但代价是降低抗爆能力。
        </LabeledList.Item>
        <LabeledList.Item label="资源变形菌">
          为你生产更多资源的变形菌。尽可能多地建造，
          以吞噬空间站。此类变形菌必须放置在
          节点变形菌或核心附近才能运作。
        </LabeledList.Item>
        <LabeledList.Item label="工厂变形菌">
          生产变形菌孢子，攻击附近的敌人。
          此类变形菌必须放置在节点变形菌或核心附近才能运作。
        </LabeledList.Item>
        <LabeledList.Item label="节点变形菌">
          像核心一样生长的变形菌。它也能像核心一样激活
          资源变形菌和工厂变形菌。
        </LabeledList.Item>
      </LabeledList>
    </Collapsible>
  );
};

const ObjectiveDisplay = (props) => {
  const { data } = useBackend<Data>();
  const { color, objectives } = data;

  return (
    <Collapsible title="目标">
      <LabeledList>
        {objectives.map(({ explanation }, index) => (
          <LabeledList.Item
            color={color ?? 'white'}
            key={index}
            label={(index + 1).toString()}
          >
            {explanation}
          </LabeledList.Item>
        ))}
      </LabeledList>
    </Collapsible>
  );
};
