import { useState } from 'react';
import {
  Button,
  Dimmer,
  Dropdown,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Rules } from './AntagInfoRules'; // SKYRAT EDIT ADDITION
import {
  type Objective,
  ObjectivePrintout,
  ReplaceObjectivesButton,
} from './common/Objectives';

const hivestyle = {
  fontWeight: 'bold',
  color: 'yellow',
};

const absorbstyle = {
  color: 'red',
  fontWeight: 'bold',
};

const revivestyle = {
  color: 'lightblue',
  fontWeight: 'bold',
};

const transformstyle = {
  color: 'orange',
  fontWeight: 'bold',
};

const storestyle = {
  color: 'lightgreen',
  fontWeight: 'bold',
};

const hivemindstyle = {
  color: 'violet',
  fontWeight: 'bold',
};

const fallenstyle = {
  color: 'black',
  fontWeight: 'bold',
};

type Memory = {
  name: string;
  story: string;
};

type Info = {
  true_name: string;
  hive_name: string;
  stolen_antag_info: string;
  memories: Memory[];
  objectives: Objective[];
  can_change_objective: BooleanLike;
  absorbed_dna: number;
};

// SKYRAT EDIT change height from 750 to 900
export const AntagInfoChangeling = (props) => {
  return (
    <Window width={720} height={900}>
      <Window.Content
        style={{
          backgroundImage: 'none',
        }}
      >
        <Stack vertical fill>
          <Stack.Item maxHeight={16}>
            <IntroductionSection />
          </Stack.Item>
          {/* SKYRAT EDIT ADDITION START */}
          <Stack.Item>
            <Rules />
          </Stack.Item>
          {/* SKYRAT EDIT ADDITION END */}
          <Stack.Item grow={4}>
            <AbilitiesSection />
          </Stack.Item>
          <BetrayalWarning />
          <Stack.Item grow={3}>
            <Stack fill>
              <Stack.Item grow>
                <MemoriesSection />
              </Stack.Item>
              <Stack.Item grow>
                <VictimPatternsSection />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const IntroductionSection = (props) => {
  const { act, data } = useBackend<Info>();
  const {
    true_name,
    hive_name,
    objectives,
    can_change_objective,
    absorbed_dna,
  } = data;
  return (
    <Section
      fill
      title="简介"
      style={{ overflowY: 'auto' }}
      buttons={
        <Button
          icon="dna"
          tooltipPosition="left"
          tooltip={`已吸收的 DNA`}
          color="purple"
        >
          {absorbed_dna}
        </Button>
      }
    >
      <Stack vertical fill>
        <Stack.Item fontSize="25px">
          你是{true_name}，来自
          <span style={hivestyle}>{hive_name}</span>。
        </Stack.Item>
        <Stack.Item>
          <ObjectivePrintout
            objectives={objectives}
            objectiveFollowup={
              <ReplaceObjectivesButton
                can_change_objective={can_change_objective}
                button_title={'演化新指令'}
                button_colour={'green'}
              />
            }
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const AbilitiesSection = () => {
  const { act, data } = useBackend<Info>();
  const { true_name } = data;
  return (
    <Section fill title="能力">
      <Stack fill>
        <Stack.Item grow>
          <Stack fill vertical>
            <Stack.Item textColor="label" grow>
              你的
              <span style={absorbstyle}>&ensp;吸收 DNA</span>能力
              能窃取受害者的 DNA 和记忆。
              <span style={absorbstyle}>&ensp;提取 DNA 毒刺</span>能力
              也能窃取受害者的 DNA，而且不会被察觉，但无法
              获得其记忆或说话方式。
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item textColor="label" grow>
              你的
              <span style={revivestyle}>&ensp;复苏停滞</span>能力
              能让你复活。这意味着只有彻底摧毁
              你的身体才能阻止你！显然，这会发出很大动静，
              因此不要在你不打算灭口的人面前使用。
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Divider />
        <Stack.Item grow>
          <Stack fill vertical>
            <Stack.Item textColor="label" grow>
              你的
              <span style={transformstyle}>&ensp;变形</span>能力
              能让你变成已收集 DNA 的对象，无论收集方式是否致命。
              它还会在你的空装备槽位上模拟对方穿着的衣物
              （并非真正的衣物）。
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item textColor="label" grow>
              在
              <span style={storestyle}>&ensp;细胞商场</span>中，
              你可以购买初始能力之外的更多能力。你有 10 点
              基因点数可用于购买能力，吸收身体后还能重新适应，
              返还点数，以选择不同的能力组合。
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Divider />
        <Stack.Item grow>
          <Stack fill vertical>
            <Stack.Item textColor="label" grow>
              所有能力都需要消耗{' '}
              <span style={hivemindstyle}>化学物质</span>，你可以通过
              屏幕左侧的抬头显示查看当前储量。将鼠标悬停于此，
              还可以查看你能储存的化学物质
              上限。你可以通过
              <span style={absorbstyle}>&ensp;吸收</span>其他
              变形怪来提高上限。
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item textColor="label" grow>
              无论出身如何，所有变形怪都由{' '}
              <span style={hivemindstyle}>蜂巢意识</span>连接在一起。你可以
              使用自己的精神化名{' '}
              <span style={hivemindstyle}>{true_name}</span>与其他变形怪交流，
              只需在消息前加上<span style={hivemindstyle}>:g</span>。齐心协力，
              让空间站见识前所未有的恐怖吧。
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const BetrayalWarning = (props) => {
  return (
    <NoticeBox danger>
      其他变形怪是强大的盟友，但其中一些可能会背叛你。
      变形怪可以通过吸收同类大幅增强实力，而被
      另一个变形怪吸收会让你沦为{' '}
      <span style={fallenstyle}>堕落变形怪</span>。没有比这
      更大的耻辱。
    </NoticeBox>
  );
};

const MemoriesSection = (props) => {
  const { data } = useBackend<Info>();
  const { memories } = data;
  const [selectedMemory, setSelectedMemory] = useState(
    (!!memories && memories[0]) || null,
  );
  const memoryMap = {};
  for (const index in memories) {
    const memory = memories[index];
    memoryMap[memory.name] = memory;
  }

  return (
    <Section
      fill
      scrollable={!!memories && !!memories.length}
      title="窃取的记忆"
      buttons={
        <Button
          icon="info"
          tooltipPosition="left"
          tooltip={`
            吸收目标
            可以获得其记忆。这些记忆
            能帮助你冒充目标！
          `}
        />
      }
    >
      {(!!memories && !memories.length && (
        <Dimmer fontSize="20px">先吸收一个受害者！</Dimmer>
      )) || (
        <Stack vertical>
          <Stack.Item>
            <Dropdown
              width="100%"
              selected={selectedMemory?.name}
              options={memories.map((memory) => {
                return memory.name;
              })}
              onSelected={(selected) => setSelectedMemory(memoryMap[selected])}
            />
          </Stack.Item>
          <Stack.Item>{!!selectedMemory && selectedMemory.story}</Stack.Item>
        </Stack>
      )}
    </Section>
  );
};

const VictimPatternsSection = (props) => {
  const { data } = useBackend<Info>();
  const { stolen_antag_info } = data;
  return (
    <Section
      fill
      scrollable={!!stolen_antag_info}
      title="额外窃取的信息"
    >
      {(!!stolen_antag_info && stolen_antag_info) || (
        <Dimmer fontSize="20px">先吸收一个受害者！</Dimmer>
      )}
    </Section>
  );
};
