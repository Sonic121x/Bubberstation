import '../styles/interfaces/AntagInfoHeretic.scss';

import { useState } from 'react';
import {
  BlockQuote,
  Box,
  Button,
  DmIcon,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { logger } from '../logging';
import { Rules } from './AntagInfoRules'; // SKYRAT EDIT ADDITION
import {
  type Objective,
  ObjectivePrintout,
  ReplaceObjectivesButton,
} from './common/Objectives';
import { hereticComplexityDisplay, hereticThemeSuffix } from '../localization/hereticDisplay';
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

type IconParams = {
  icon: string;
  state: string;
  frame: number;
  dir: number;
  moving: BooleanLike;
};
// BUBBER EDIT CHANGE - exported
export type Knowledge = {
  path: string;
  icon_params: IconParams;
  name: string;
  desc: string;
  gainFlavor: string;
  cost: number;
  bgr: string;
  category?: ShopCategory;
  depth: number;
  done: BooleanLike;
  ascension: BooleanLike;
  disabled?: BooleanLike;
  notice?: string;
  info?: string;
};

enum ShopCategory {
  Tree = 'tree',
  Shop = 'shop',
  Draft = 'draft',
  Start = 'start',
}
// BUBBER EDIT CHANGE - exported
export type KnowledgeTier = {
  nodes: Knowledge[];
};

type HereticPassive = {
  name: string;
  recharge: string;
  description: string[];
};
// BUBBER EDIT CHANGE - exported
export type HereticPath = {
  route: string;
  complexity: string;
  complexity_color: string;
  description: string[];
  pros: string[];
  cons: string[];
  tips: string[];
  starting_knowledge: Knowledge;
  preview_abilities: Knowledge[];
  passive: HereticPassive;
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
};

const IntroductionSection = (props) => {
  const { data } = useBackend<Info>();
  const { objectives, ascended, can_change_objective } = data;

  return (
    <Stack justify="space-evenly" height="100%" width="100%">
      <Stack.Item grow>
        <Section title="你是异教徒！" fill fontSize="14px" scrollable>
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
                      ? '敌对势力目标是你的首要目标，但若想飞升，你还必须完成以下任务' /* SKYRAT EDIT CHANGE - opfor objectives */
                      : '敌对势力目标是你的首要目标。运用黑暗知识实现你的个人目标' /* SKYRAT EDIT CHANGE - opfor objectives  */
                  }
                  objectives={objectives}
                  objectiveFollowup={
                    <ReplaceObjectivesButton
                      can_change_objective={can_change_objective}
                      button_title={'拒绝飞升'}
                      button_colour={'red'}
                      button_tooltip={
                        '背弃漫宿，转而完成自行选择的任务。选择此项后，你将无法飞升！'
                      }
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
// BUBBER EDIT CHANGE - exported
export const FlavorSection = () => {
  return (
    <Stack.Item>
      <Stack vertical textAlign="center" fontSize="14px">
        <Stack.Item>
          <i>
            又是毫无意义的工作日。你察觉到周围的一丝&nbsp;
            <span style={hereticBlue}>微光</span>
            &nbsp;，逐渐意识到空气中存在某种&nbsp;
            <span style={hereticRed}>异样</span>
            &nbsp;。你审视内心，发现了某种
            将改变一生的东西。
          </i>
        </Stack.Item>
        <Stack.Item>
          <b>
            <span style={hereticPurple}>漫宿之门</span>
            &nbsp;向你的心灵敞开。
          </b>
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

const GuideSection = () => {
  const { data } = useBackend<Info>();
  const { points_to_aura } = data;
  return (
    <Stack.Item>
      <Stack vertical fontSize="12px">
        <Stack.Item>
          - 寻找空间站各处撕裂现实的&nbsp;
          <span style={hereticPurple}>异界影响</span>
          &nbsp;，它们无法被常人的肉眼看见。&nbsp;
          <b>右键点击</b>，汲取它们以获得&nbsp;
          <span style={hereticBlue}>知识点数</span>。汲取后不久，
          所有人都将能看见它们。梦游漫宿可能有助于
          寻找它们。
        </Stack.Item>
        <Stack.Item>
          - 使用你的&nbsp;
          <span style={hereticRed}>活心脉动能力</span>
          &nbsp;来追踪&nbsp;
          <span style={hereticRed}>献祭目标</span>，但要小心：
          脉动会发出心跳声，附近的人可能听见。
          此能力与你的<b>心脏</b>绑定；若失去心脏，你必须
          完成仪式才能重新获得此能力。
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
          - 跟随<span style={hereticRed}>活心</span>寻找
          目标。将处于濒死或更糟状态的目标带到&nbsp;
          <span style={hereticGreen}>嬗变符文</span>上，
          然后&nbsp;
          <span style={hereticRed}>献祭</span>以获得&nbsp;
          <span style={hereticBlue}>知识点数</span>。漫宿{' '}
          <b>只</b>接受&nbsp;
          <span style={hereticRed}>活心</span>指定的目标。
        </Stack.Item>
        <Stack.Item>
          - 累计获得 <b>{points_to_aura}</b> 点&nbsp;
          <span style={hereticBlue}>知识</span>
          &nbsp;后，你周围将显现出&nbsp;
          <span style={hereticPurple}>漫宿能量</span>光环。此光环
          对周围所有人可见，并将暴露你的
          异教徒身份。在积累过多知识前，请考虑风险！
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

const InformationSection = () => {
  const { data } = useBackend<Info>();
  const { charges, total_sacrifices, ascended } = data;
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
          你已完成共计&nbsp;
          <b>{total_sacrifices || 0}</b>&nbsp;
          次<span style={hereticRed}>献祭</span>。
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

const KnowledgeTree = () => {
  const { data } = useBackend<Info>();
  const { knowledge_tiers } = data;

  const nodesToShow = knowledge_tiers.filter((tier) => tier.nodes.length > 0);

  return (
    <Section title="研究树" fill scrollable>
      <Box textAlign="center" fontSize="32px">
        <span style={hereticYellow}>黎明</span>
      </Box>
      <Stack vertical>
        {nodesToShow.length === 0
          ? '无！'
          : nodesToShow.map((tier, i) => (
              <Stack.Item key={i}>
                <Stack
                  justify="center"
                  align="center"
                  backgroundColor="transparent"
                  wrap="wrap"
                >
                  {tier.nodes.map((node) => (
                    <KnowledgeNode
                      key={node.path}
                      node={node}
                      // hack, free nodes are draft nodes
                      purchaseCategory={node.category}
                    />
                  ))}
                </Stack>
                <hr />
              </Stack.Item>
            ))}
      </Stack>
    </Section>
  );
};

// take &bull; in from byond and make sure it's rendered properly
function bulletpointHelper(text: string) {
  return text.replace(/&bull;/g, '•');
}

// description or info text may have <br>s,
// we need translate it into separate children for the tooltip to render it properly
function formatTooltipText(text: string) {
  return (
    <Stack vertical>
      {text.split('<br>').map((line, index) => {
        const isBulletPoint = line.includes('&bull;');
        if (isBulletPoint) {
          line = line.replace(/&bull;/g, '•');
        }
        return (
          <Stack.Item
            key={index}
            // hacky. pretty much solely exists to make Unsealed Arts readable.
            // stretches beyond the bounds of the tooltip to avoid getting cut off.
            // call it a format screw
            fontSize={isBulletPoint ? '10px' : undefined}
            width={isBulletPoint ? '110%' : undefined}
          >
            {line}
          </Stack.Item>
        );
      })}
    </Stack>
  );
}

type KnowledgeNodeProps = {
  node: Knowledge;
  purchaseCategory?: ShopCategory;
  can_buy?: BooleanLike;
};

const KnowledgeNode = (props: KnowledgeNodeProps) => {
  const { node, can_buy = true, purchaseCategory } = props;
  const { data, act } = useBackend<Info>();
  const { charges } = data;

  const isBuyable = can_buy && !node.done && !node.disabled;

  const iconState = () => {
    if (!can_buy) {
      return node.bgr;
    }
    if (node.done) {
      return 'node_finished';
    }
    if (charges < node.cost || node.disabled) {
      return 'node_locked';
    }
    return node.bgr;
  };

  return (
    <Stack.Item key={node.name}>
      <Button
        color="transparent"
        tooltip={
          <Stack vertical>
            <Stack.Item align="center" fontSize="16px">
              <b>{node.name}</b>
            </Stack.Item>
            <Stack.Item>
              <BlockQuote>
                <span style={hereticPurple}>效果：</span>{' '}
              </BlockQuote>
              {formatTooltipText(node.desc)}
            </Stack.Item>
            {!!node.notice && (
              <Stack.Item color="red">
                {formatTooltipText(node.notice)}
              </Stack.Item>
            )}
            {!!node.info && (
              <Stack.Item>
                <BlockQuote>
                  <span style={hereticGreen}>配方：</span>{' '}
                </BlockQuote>
                {formatTooltipText(node.info)}
              </Stack.Item>
            )}
          </Stack>
        }
        onClick={
          !isBuyable
            ? () => logger.warn(`Cannot buy ${node.name}`)
            : () =>
                act('research', { path: node.path, category: purchaseCategory })
        }
        width={node.ascension ? '192px' : '64px'}
        height={node.ascension ? '192px' : '64px'}
        m="8px"
        style={{
          borderRadius: '50%',
        }}
      >
        <DmIcon
          icon="icons/ui_icons/antags/heretic/knowledge.dmi"
          icon_state={iconState()}
          height={node.ascension ? '192px' : '64px'}
          width={node.ascension ? '192px' : '64px'}
          top="0px"
          left="0px"
          position="absolute"
        />
        <DmIcon
          icon={node.icon_params?.icon}
          icon_state={node.icon_params?.state}
          frame={node.icon_params?.frame}
          direction={node.icon_params?.dir}
          movement={node.icon_params?.moving}
          height={node.ascension ? '152px' : '64px'}
          width={node.ascension ? '152px' : '64px'}
          top={node.ascension ? '20px' : '0px'}
          left={node.ascension ? '20px' : '0px'}
          position="absolute"
        />
        <Box
          position="absolute"
          top="0px"
          left="0px"
          backgroundColor="black"
          textColor="white"
          bold
          style={{ margin: '2px', borderRadius: '100%' }}
        >
          {isBuyable && (node.cost > 0 ? node.cost : '免费')}
        </Box>
      </Button>
      {!!node.ascension && (
        <Box textAlign="center" fontSize="32px">
          <span style={hereticPurple}>黄昏</span>
        </Box>
      )}
    </Stack.Item>
  );
};
// BUBBER EDIT CHANGE - exported
export const KnowledgeShop = () => {
  const { data } = useBackend<Info>();
  const { knowledge_shop } = data;

  if (!knowledge_shop || knowledge_shop.length === 0) {
    return null;
  }

  return (
    <Section title="知识商店" fill scrollable>
      <Stack vertical fill>
        <Knowledges />
      </Stack>
    </Section>
  );

  function Knowledges() {
    // filter the list into being indexed by tier
    const tiers: Knowledge[][] = knowledge_shop.reduce((acc, knowledge) => {
      const tierIndex = knowledge.depth - 1; // depth starts at 1, so
      if (!acc[tierIndex]) {
        acc[tierIndex] = [];
      }
      acc[tierIndex].push(knowledge);
      return acc;
    }, [] as Knowledge[][]);

    return tiers?.map((tier, index) => (
      <Stack.Item key={`tier-${index}`}>
        第 {index + 1} 阶
        <Stack fill scrollable wrap="wrap">
          {tier.map((knowledge) => (
            <Stack.Item key={`knowledge-${knowledge.path}`}>
              <KnowledgeNode
                node={knowledge}
                purchaseCategory={knowledge.category}
              />
            </Stack.Item>
          ))}
        </Stack>
        <hr />
      </Stack.Item>
    ));
  }
};
// BUBBER EDIT CHANGE - exported
export const ResearchInfo = () => {
  const { data } = useBackend<Info>();
  const { charges, knowledge_shop } = data;

  return (
    <Stack vertical fill>
      <Stack.Item mb={1.5} fontSize="20px" textAlign="center">
        你拥有 <b>{charges || 0}</b> 点&nbsp;
        <span style={hereticBlue}>
          知识
        </span>{' '}
        可供使用。
      </Stack.Item>
      <Stack fill>
        <Stack.Item grow>
          <KnowledgeTree />
        </Stack.Item>
        {!!knowledge_shop?.length && (
          <Stack.Item grow>
            <KnowledgeShop />
          </Stack.Item>
        )}
      </Stack>
    </Stack>
  );
};
// BUBBER EDIT CHANGE - exported
export const PathInfo = ({ currentPath }: { currentPath?: HereticPath }) => {
  const { data } = useBackend<Info>();
  const { paths } = data;

  const pathBoughtIndex = paths.findIndex(
    (path) => currentPath && path.route === currentPath.route,
  );

  const [currentTab, setCurrentTab] = useState(
    pathBoughtIndex !== -1 ? pathBoughtIndex : 0,
  );

  return (
    <Stack fill>
      {!currentPath && (
        <Stack.Item>
          <Tabs fluid vertical>
            {paths.map((path, index) => (
              <Tabs.Tab
                key={index}
                icon="info"
                selected={currentTab === index}
                onClick={() => setCurrentTab(index)}
              >
                {path.route}
              </Tabs.Tab>
            ))}
          </Tabs>
        </Stack.Item>
      )}
      <Stack.Item grow>
        <PathContent path={paths[currentTab]} isPathSelected={!!currentPath} />
      </Stack.Item>
    </Stack>
  );
};

const PathProCons = ({
  proconlist,
  title,
}: {
  proconlist: string[];
  title: string;
}) => {
  return (
    <Stack vertical>
      <Stack.Item>
        <b>{title}:</b>
      </Stack.Item>
      <Stack.Item>
        {proconlist.map((item, index) => (
          <Stack.Item key={index} textAlign="left" mb={1}>
            &bull; {item}
          </Stack.Item>
        ))}
      </Stack.Item>
    </Stack>
  );
};

const PathContentUnselected = ({ path }: { path: HereticPath }) => {
  return (
    <Stack vertical>
      <Stack.Item verticalAlign="center" textAlign="center">
        <KnowledgeNode
          node={path.starting_knowledge}
          purchaseCategory={ShopCategory.Start}
        />
        <Stack.Item>
          <h3>
            复杂度：{' '}
            <span style={{ color: path.complexity_color }}>
              {hereticComplexityDisplay(path.complexity)}
            </span>
          </h3>
        </Stack.Item>
      </Stack.Item>
      <Stack.Item>
        <Stack vertical>
          {path.description.map((line, index) => (
            <Stack.Item key={index}>{line}</Stack.Item>
          ))}
        </Stack>
      </Stack.Item>
      <Stack.Divider />
      <Stack.Item>
        <Stack>
          <Stack.Item style={{ justifyItems: 'center' }} width="50%">
            <Stack vertical>
              <Stack.Item bold>被动能力：{path.passive.name}</Stack.Item>
              <Stack.Item italic>{path.passive.recharge}</Stack.Item>
              <Stack.Item className="Passive" width="100%">
                {path.passive.description[0]}
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item width="50%">
            <Stack vertical>
              <Stack.Item bold>途径能力：</Stack.Item>
              <Stack.Item>
                <Stack wrap="wrap" justify="center">
                  {path.preview_abilities.map((ability) => (
                    <Stack.Item key={`guaranteed_${ability.name}`} m={1}>
                      <KnowledgeNode node={ability} can_buy={false} />
                    </Stack.Item>
                  ))}
                </Stack>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Divider />
      <Stack.Item>
        <Stack>
          <Stack.Item width="50%">
            <PathProCons proconlist={path.pros} title="优势" />
          </Stack.Item>
          <Stack.Item width="50%">
            <PathProCons proconlist={path.cons} title="弱点" />
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

const PathContentSelected = ({
  path,
  passive_level,
}: {
  path: HereticPath;
  passive_level: number;
}) => {
  return (
    <Stack vertical>
      <Stack.Item>
        {path.description.map((line, index) => (
          <div key={index}>{line}</div>
        ))}
      </Stack.Item>
      <Stack.Item>
        <Stack vertical>
          <Stack.Item bold>
            被动能力：{path.passive.name}，等级：{passive_level}
          </Stack.Item>
          <Stack.Item italic>{path.passive.recharge}</Stack.Item>
          {path.passive.description.map((line, index) => (
            <Stack.Item
              key={index}
              className={`Passive ${passive_level >= index + 1 ? 'Passive--Active' : ''}`}
              width="100%"
            >
              等级 {index + 1}
              <br />
              {line}
            </Stack.Item>
          ))}
        </Stack>
      </Stack.Item>
      <Stack.Item textAlign="left" mt={2} mb={1}>
        <Stack.Item bold mb={1}>
          技巧：
        </Stack.Item>
        <Stack.Item>
          <Stack vertical>
            {path.tips.map((tip, index) => (
              <Stack.Item key={index} textAlign="left">
                &bull; {tip}
              </Stack.Item>
            ))}
          </Stack>
        </Stack.Item>
      </Stack.Item>
    </Stack>
  );
};

export const PathContent = ({
  //BUBBER Edit Export
  path,
  isPathSelected,
}: {
  path: HereticPath;
  isPathSelected: boolean;
}) => {
  const { data } = useBackend<Info>();
  const { passive_level } = data;

  return (
    <Section
      title={<h1 className="PathTitle">{path.route}</h1>}
      textAlign="center"
      fill
      scrollable
    >
      <Stack vertical>
        {isPathSelected ? (
          <PathContentSelected path={path} passive_level={passive_level} />
        ) : (
          <PathContentUnselected path={path} />
        )}
      </Stack>
    </Section>
  );
};

export const AntagInfoHeretic = () => {
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
      label: '途径',
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
