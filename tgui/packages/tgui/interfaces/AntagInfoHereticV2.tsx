// BUBBER FILE - COPIED FROM [AntagInfoHeretic.tsx] DUE TO THE SCALE OF CHANGES
import '../styles/interfaces/AntagInfoHeretic.scss';

import { useState } from 'react';
import { Box, Section, Stack, Tabs } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import {
  FlavorSection,
  type HereticPath,
  type Knowledge,
  type KnowledgeTier,
  PathInfo,
  ResearchInfo,
} from './AntagInfoHeretic';
import { Rules } from './AntagInfoRules'; // SKYRAT EDIT ADDITION
import {
  type Objective,
  ObjectivePrintout,
  ReplaceObjectivesButton,
} from './common/Objectives';
import { hereticThemeSuffix } from '../localization/hereticDisplay';
const hereticRed = {
  color: '#e03c3c',
};

const hereticBlue = {
  fontWeight: 'bold',
  color: '#2185d0',
};

const hereticPurple = {
  fontWeight: 'bold',
  color: '#bd54e0',
};

const hereticGreen = {
  fontWeight: 'bold',
  color: '#20b142',
};

const hereticYellow = {
  fontWeight: 'bold',
  color: 'yellow',
};

type Info = {
  charges: number;
  total_sacrifices: number;
  ascended: BooleanLike;
  objectives: Objective[];
  can_change_objective: BooleanLike;
  paths: HereticPath[];
  knowledge_shop: Knowledge[];
  knowledge_tiers: KnowledgeTier[];
  passive_level: number;
  points_to_aura: number;
  influences_drained: number;
  ways_opened: number;
  win_amount: number;
};

const IntroductionSection = (props) => {
  const { data } = useBackend<Info>();
  const { objectives, ascended, can_change_objective, win_amount } = data;

  return (
    <Stack justify="space-evenly" height="100%" width="100%">
      <Stack.Item grow>
        <Section title="你是侍徒！" fill fontSize="14px">
          <Stack vertical>
            <FlavorSection />
            <Stack.Divider />
            {/* SKYRAT EDIT ADDITION START */}
            <Stack.Item>
              <Rules />
            </Stack.Item>
            {/* SKYRAT EDIT ADDITION END */}
            <Stack.Divider />
            <GuideSection />
            <Stack.Divider />
            <InformationSection />
            <Stack.Divider />
            {!ascended && (
              <Stack.Item>
                <ObjectivePrintout
                  fill
                  titleMessage={
                    can_change_objective
                      ? `你必须完成以下目标中的 ${win_amount} 项` /* SKYRAT EDIT CHANGE - opfor objectives */
                      : '敌对势力目标是你的首要目标。运用黑暗知识实现你的个人目标' /* SKYRAT EDIT CHANGE - opfor objectives  */
                  }
                  objectives={objectives}
                  objectiveFollowup={
                    <ReplaceObjectivesButton
                      can_change_objective={can_change_objective}
                      button_title={'自定目标'}
                      button_colour={'red'}
                      button_tooltip={'寻找自己的道路。'}
                    />
                  }
                />
              </Stack.Item>
            )}
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const GuideSection = () => {
  return (
    <Stack.Item>
      <Stack vertical fontSize="12px">
        <Stack.Item>
          - 寻找空间站各处撕裂现实的&nbsp;
          <span style={hereticPurple}>异界影响</span>
          &nbsp;，它们无法被常人的肉眼看见。&nbsp;
          <b>右键点击</b>，汲取它们以获得&nbsp;
          <span style={hereticBlue}>知识点数</span>，最多可达到
          目标要求的上限。汲取后不久，所有人都将能看见它们，
          而它们会侵蚀理智、引发幻觉，
          并生成怪物。开始汲取异界影响后，船员可能会敌视你。
          请注意：汲取异界影响时，
          你的行为十分显眼。
        </Stack.Item>
        <Stack.Item>
          - 使用&nbsp;
          <span style={hereticYellow}>双指叩门仪式</span>
          &nbsp;来追踪&nbsp;
          <span style={hereticYellow}>通路</span>，最多可达到目标要求的
          上限。通路是通往漫宿的强大门户，打开它们
          可以获得一些<span style={hereticBlue}>知识点数</span>。打开通路
          需要完整的仪式和一组物品；在远离通路处
          使用仪式，可以显示所有通路及其所需物品。
          打开通路一分钟后，其附近会发生危险事件！
          注意：仪式也接受所需物品的子类型。
        </Stack.Item>
        <Stack.Item>
          - 绘制&nbsp;
          <span style={hereticGreen}>嬗变符文</span>的方法是：
          使用绘图工具（钢笔或蜡笔）点击地板，同时在另一只手激活&nbsp;
          <span style={hereticGreen}>漫宿之握</span>
          &nbsp;。此符文可以用于完成
          仪式和献祭。
        </Stack.Item>
        <Stack.Item>
          - 为自己制作一件<span style={hereticYellow}>法器</span>，
          以施放各种高级法术，帮助你获取
          越来越困难的通路。
        </Stack.Item>
        <Stack.Item>
          <span style={hereticRed}>警告！</span>
          <br />
          汲取&nbsp;
          <span style={hereticYellow}>异界影响</span>时，你的行为十分显眼，
          但法典可以大幅提高汲取速度。
          <br />
          <span style={hereticPurple}>异界影响</span>{' '}
          和<span style={hereticYellow}>通路</span>生成的生物对你并不友善。
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

const InformationSection = () => {
  const { data } = useBackend<Info>();
  const { charges, influences_drained, ways_opened, ascended } = data;
  return (
    <Stack.Item>
      <Stack vertical fill>
        {!!ascended && (
          <Stack.Item>
            <Stack align="center">
              <Stack.Item>你已</Stack.Item>
              <Stack.Item fontSize="24px">
                <Box inline color="yellow">
                  飞升
                </Box>
                ！
              </Stack.Item>
            </Stack>
          </Stack.Item>
        )}
        <Stack.Item>
          你拥有 <b>{charges || 0}</b> 点&nbsp;
          <span style={hereticBlue}>
            知识
          </span>
          。
        </Stack.Item>
        <Stack.Item>
          你已开启共计&nbsp;
          <b>{influences_drained || 0}</b>&nbsp;
          处<span style={hereticPurple}>异界影响</span>。
        </Stack.Item>
        <Stack.Item>
          你已开启共计&nbsp;
          <b>{ways_opened || 0}</b>&nbsp;
          条<span style={hereticYellow}>通路</span>。
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

export const AntagInfoHereticV2 = () => {
  const { data } = useBackend<Info>();
  const { ascended, knowledge_tiers, paths } = data;

  const [currentTab, setTab] = useState(1);
  // only tiers has done variables set
  const currentPath = paths.find((path) =>
    knowledge_tiers.some((tier) =>
      tier.nodes.some(
        (node) => node.done && node.path === path.starting_knowledge.path,
      ),
    ),
  );

  const tabs = [
    { label: '信息', icon: 'info', content: <IntroductionSection /> },
    {
      label: '途径信息',
      icon: 'info',
      content: <PathInfo currentPath={currentPath} />,
    },
    { label: '研究', icon: 'book', content: <ResearchInfo /> },
  ];

  const currentTheme = () => {
    if (currentPath?.route) {
      return `Heretic theme-Heretic--${hereticThemeSuffix(currentPath.route)}`;
    }
    return 'Heretic';
  };

  return (
    <Window
      width={750}
      height={635}
      theme={`${currentTheme()}${ascended ? ' heretic-theme-ascended' : ''}`}
    >
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Tabs fluid>
              {tabs.map((tab, index) => (
                <Tabs.Tab
                  key={index}
                  icon={tab.icon}
                  selected={currentTab === index}
                  onClick={() => setTab(index)}
                >
                  {tab.label}
                </Tabs.Tab>
              ))}
            </Tabs>
          </Stack.Item>
          <Stack.Item grow>{tabs[currentTab].content}</Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
