import { useState } from 'react';
import { Box, Button, DmIcon, Section, Stack, Tabs } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import type { Objective } from './common/Objectives';
import { PowerDetails } from './PowerInfo';

export type ClanProps = {
  clan: ClanInfo[];
  in_clan: BooleanLike;
};

export type ClanInfo = {
  clan_name: string;
  clan_description: string;
  clan_icon: string;
  clan_icon_state: string;
};

export type PowerInfo = {
  power_name: string;
  power_explanation: string[];
  power_icon: string;
  power_icon_state: string;
};

export type BloodsuckerProps = {
  powers: PowerInfo[];
  objectives: Objective[];
};
export type GhoulProps = BloodsuckerProps & {
  title: string;
  description: string;
};

const ObjectivePrintout = (props: any) => {
  const { data } = useBackend<BloodsuckerProps>();
  const { objectives } = data;
  return (
    <Stack vertical>
      <Stack.Item bold>你当前的目标：</Stack.Item>
      <Stack.Item>
        {(!objectives && '无！') ||
          objectives.map((objective) => (
            <Stack.Item key={objective.count}>
              #{objective.count}: {objective.explanation}
            </Stack.Item>
          ))}
      </Stack.Item>
    </Stack>
  );
};

export const AntagInfoBloodsucker = (props: any) => {
  const [tab, setTab] = useState(1);
  return (
    <Window width={620} height={700} theme="spookyconsole">
      <Window.Content>
        <Tabs>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 1}
            onClick={() => setTab(1)}
          >
            简介
          </Tabs.Tab>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 2}
            onClick={() => setTab(2)}
          >
            氏族与能力
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && <BloodsuckerIntro />}
        {tab === 2 && <BloodsuckerClan />}
      </Window.Content>
    </Window>
  );
};

const BloodsuckerIntro = () => {
  return (
    <Stack vertical fill>
      <Stack.Item minHeight="16rem">
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item textColor="red" fontSize="20px">
              你是吸血鬼，一个潜伏在 13 号空间站上、
              渴求鲜血的不死怪物。
            </Stack.Item>
            <Stack.Item>
              <ObjectivePrintout />
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section fill title="优势与弱点">
          <Stack vertical height="7rem">
            <Stack.Item>
              <span>
                你的生命值会缓慢恢复，你惧怕火焰，
                并依赖血液生存。不要让血量
                降得太低，否则你会陷入
              </span>
              <span className={'color-red'}>狂暴</span>！<br />
              <span>
                留意你的人性水平！失去的人性越多，
                就越容易陷入{' '}
                <span className={'color-red'}>狂暴</span>！
              </span>
              <br />
              <span>
                避免在其他人附近使用吸血能力，否则你
                可能会<i>违反避世戒律</i>！
              </span>
              <span>
                失去心脏会让你的能力失效，但进入
                放有心脏的棺材，
                就能再生心脏。
              </span>
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section fill title="物品">
          <Stack vertical>
            <Stack.Item>
              在<b>棺材</b>中休息，即可将其连同所在区域占为你的庇护所。
              <br />
              检查你的新建筑，了解它们的功能！
              <br />
              医疗分析仪和诺德之书可能暴露你的身份，
              使用避世伪装能力可以隐藏身份，防止这种情况发生。
              <br />
              当等级足以拥有血仆时，
              你会在白天蛰眠期间学会
              制作劝化刑架。检查劝化刑架，
              即可得知你能拥有多少血仆！
              <br />
              选择氏族之前，你无法升级。要选择氏族，
              请点击此窗口右上方的氏族标签。
              <br />
              务必阅读“氏族与能力”标签中各项能力的说明，
              你或许会学到新知识！
              <br />
              达到一定等级后，太阳将不再让你升级，
              此时你需要吸食他人的血液
              来提升等级。
            </Stack.Item>
            <Stack.Item>
              <Section textAlign="center" textColor="red" fontSize="20px">
                其他吸血鬼不一定是你的朋友，但你可能
                需要合作才能生存。是否背叛它们由你决定，
                风险也由你承担。
              </Section>
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const BloodsuckerClan = (props: any) => {
  const { act, data } = useBackend<BloodsuckerProps & ClanProps>();
  const { clan, in_clan, powers } = data;

  if (!in_clan) {
    return (
      <Section minHeight="220px">
        <Box mt={5} bold textAlign="center" fontSize="40px">
          你尚未加入氏族。
        </Box>
        <Box mt={3}>
          <Button
            fluid
            icon="users"
            textAlign="center"
            fontSize="30px"
            lineHeight={2}
            onClick={() => act('join_clan')}
          >
            加入氏族
          </Button>
        </Box>
      </Section>
    );
  }

  return (
    <Stack vertical fill>
      <Stack.Item minHeight="20rem">
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item>
              {clan.map((ClanInfo) => (
                <>
                  <DmIcon
                    height="20rem"
                    opacity={0.25}
                    icon={ClanInfo.clan_icon}
                    icon_state={ClanInfo.clan_icon_state}
                    className="img absolute"
                    style={{ position: 'absolute' }}
                  />
                  <Stack.Item fontSize="20px" textAlign="center">
                    你属于{ClanInfo.clan_name}
                  </Stack.Item>
                  <Stack.Item
                    fontSize="16px"
                    style={{ flexBasis: '60% !important' }}
                  >
                    {ClanInfo.clan_description}
                  </Stack.Item>
                </>
              ))}
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      <PowerDetails powers={powers} />
    </Stack>
  );
};
