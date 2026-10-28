import { useState } from 'react';
import {
  Button,
  Flex,
  LabeledControls,
  NoticeBox,
  RoundGauge,
  Section,
  Stack,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const TAB2NAME = [
  {
    title: '调试',
    blurb: '无用垃圾的埋骨之地',
    gauge: 5,
    component: () => DebuggingTab,
  },
  {
    title: '实用',
    blurb: '蠢货们放日志的地方',
    gauge: 25,
    component: () => HelpfulTab,
  },
  {
    title: '娱乐',
    blurb: '我是如何举办一场“活动”的',
    gauge: 75,
    component: () => FunTab,
  },
  {
    title: '只有你觉得好玩',
    blurb: '我当管理员的最后一天是怎么过的',
    gauge: 95,
    component: () => FunForYouTab,
  },
];

const lineHeightNormal = 2.79;
const buttonWidthNormal = 12.9;
const lineHeightDebug = 6.09;

const DebuggingTab = (props) => {
  const { act } = useBackend();
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Button
          color="average"
          lineHeight={lineHeightDebug}
          icon="question"
          fluid
          content="所有维修门仅允许工程／监狱权限通行"
          onClick={() => act('maint_access_engiebrig')}
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          color="average"
          lineHeight={lineHeightDebug}
          icon="question"
          fluid
          content="所有维修门仅允许监狱权限通行"
          onClick={() => act('maint_access_brig')}
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          color="average"
          lineHeight={lineHeightDebug}
          icon="question"
          fluid
          content="移除安保人员数量上限"
          onClick={() => act('infinite_sec')}
        />
      </Stack.Item>
    </Stack>
  );
};

const HelpfulTab = (props) => {
  const { act } = useBackend();
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <NoticeBox
              mb={-0.5}
              width={buttonWidthNormal}
              height={lineHeightNormal}
            >
              开发者，把你的管理员按钮放这里！
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="plus"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="治愈所有疾病"
              onClick={() => act('clear_virus')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="biohazard"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="触发疫情"
              onClick={() => act('virus')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="plane-slash"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="修复空间站重力"
              onClick={() => act('fix_gravity')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="grin-beam-sweat"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="破坏所有灯具"
              onClick={() => act('blackout')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="magic"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="修复所有灯具"
              onClick={() => act('whiteout')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="bomb"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="查看炸弹制造记录"
              onClick={() => act('list_bombers')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="signal"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="查看信号器记录"
              onClick={() => act('list_signalers')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="robot"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="查看法则记录"
              onClick={() => act('list_lawchanges')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="address-book"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="查看船员名单"
              onClick={() => act('manifest')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="dna"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="查看DNA"
              onClick={() => act('dna')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="fingerprint"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="查看指纹"
              onClick={() => act('fingerprints')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="flag"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="切换夺旗模式"
              onClick={() => act('ctfbutton')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="sync-alt"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="重置雷霆竞技场"
              onClick={() => act('tdomereset')}
            />
          </Stack.Item>
          <Stack.Item>
            <NoticeBox
              mb={-0.5}
              width={buttonWidthNormal}
              height={lineHeightNormal}
            >
              开发者，把你的管理员按钮放这里！
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="pencil-alt"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="重命名空间站"
              onClick={() => act('set_name')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="eraser"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="恢复默认站名"
              onClick={() => act('reset_name')}
            />
          </Stack.Item>
          <Stack.Item>
            <NoticeBox
              mb={-0.5}
              width={buttonWidthNormal}
              height={lineHeightNormal}
            >
              开发者，把你的管理员按钮放这里！
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

const FunTab = (props) => {
  const { act } = useBackend();
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="robot"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="创建N.E.R.D."
              onClick={() => act('makeNerd')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="flag"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="夺旗一击必杀模式"
              onClick={() => act('ctf_instagib')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="plus"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="治疗所有人"
              onClick={() => act('mass_heal')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="bolt"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="所有区域通电"
              onClick={() => act('power')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="moon"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="所有区域断电"
              onClick={() => act('unpower')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="plug"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="为SMES充能"
              onClick={() => act('quickpower')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="user-ninja"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="匿名姓名"
              onClick={() => act('anon_name')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="robot"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="三AI模式"
              onClick={() => act('tripleAI')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="bullhorn"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="只能有一个——"
              onClick={() => act('onlyone')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="grin-beam-sweat"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="召唤枪械"
              onClick={() => act('guns')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="magic"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="召唤魔法"
              onClick={() => act('magic')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="meteor"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="召唤事件"
              onClick={() => act('events')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="hammer"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="人人平等空间站"
              onClick={() => act('eagles')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="house"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="让穿梭机返回"
              onClick={() => act('send_shuttle_back')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="oil-well"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="开采矿脉喷口"
              onClick={() => act('ore_vents')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="bullseye"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="自定义传送门风暴"
              onClick={() => act('customportal')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="bomb"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="修改爆炸上限"
              onClick={() => act('changebombcap')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="dollar-sign"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="部门订购冷却"
              onClick={() => act('department_cooldown_override')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

const FunForYouTab = (props) => {
  const { act } = useBackend();
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Stack>
          <Stack.Item>
            <NoticeBox danger mb={0} width={19.6}>
              <Button
                color="red"
                icon="user-secret"
                fluid
                content="所有人都是反派"
                onClick={() => act('antag_all')}
              />
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <NoticeBox danger width={19.6} mb={0}>
              <Button
                color="red"
                icon="brain"
                fluid
                content="所有人脑损伤"
                onClick={() => act('massbraindamage')}
              />
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack>
          <Stack.Item>
            <NoticeBox danger mb={0} width={19.6}>
              <Button
                color="red"
                icon="hand-lizard"
                fluid
                content="更改所有人的种族"
                onClick={() => act('allspecies')}
              />
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <NoticeBox danger width={19.6} mb={0}>
              <Button
                color="red"
                icon="paw"
                fluid
                content="将所有人变成猴子"
                onClick={() => act('monkey')}
              />
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <NoticeBox danger mb={0}>
          <Button
            color="black"
            icon="fire"
            fluid
            content="地板是熔岩！（危险：极其无聊）"
            onClick={() => act('floorlava')}
          />
        </NoticeBox>
      </Stack.Item>
      <Stack.Item>
        <NoticeBox danger mb={0}>
          <Button
            color="black"
            icon="fire"
            fluid
            content="中国动画！（危险：无法撤销，顺便去你的）"
            onClick={() => act('anime')}
          />
        </NoticeBox>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <NoticeBox danger width={19.6} mb={0}>
              <Button
                color="red"
                icon="cat"
                fluid
                content="全员猫化"
                onClick={() => act('masspurrbation')}
              />
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <NoticeBox info width={19.6} mb={0}>
              <Button
                color="blue"
                icon="user"
                fluid
                content="解除猫化"
                onClick={() => act('massremovepurrbation')}
              />
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <NoticeBox danger width={19.6} mb={0}>
              <Button
                color="red"
                icon="explosion"
                fluid
                content="共振级联啊啊啊"
                onClick={() => act('cascade')}
              />
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <Stack fill>
              <Stack.Item>
                <NoticeBox danger width={19.6} mb={0}>
                  <Button
                    color="red"
                    icon="burst"
                    fluid
                    content="切换流星模式"
                    onClick={() => act('meteormode')}
                  />
                </NoticeBox>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack>
          <Stack.Item>
            <NoticeBox danger width={19.6} mb={0}>
              <Button
                color="red"
                icon="flushed"
                fluid
                content="让所有人完全沉浸"
                onClick={() => act('massimmerse')}
              />
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <NoticeBox info width={19.6} mb={0}>
              <Button
                color="blue"
                icon="sync-alt"
                fluid
                content="打破沉浸感"
                onClick={() => act('unmassimmerse')}
              />
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <NoticeBox danger width={19.6} mb={0}>
              <Button
                color="red"
                icon="comment-slash"
                fluid
                content="巴别塔"
                onClick={() => act('towerOfBabel')}
              />
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <NoticeBox info width={19.6} mb={0}>
              <Button
                color="blue"
                icon="comment"
                fluid
                content="撤销巴别塔"
                onClick={() => act('cureTowerOfBabel')}
              />
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

export const Secrets = (props) => {
  const { act, data } = useBackend();
  const { is_debugger, is_funmin } = data;
  const [tabIndex, setTabIndex] = useState(2);
  const TabComponent = TAB2NAME[tabIndex - 1].component();

  return (
    <Window title="秘密面板" width={500} height={520} theme="admin">
      <Window.Content>
        <Flex direction="column" height="100%">
          <Flex.Item mb={1}>
            <Section
              title="秘密"
              buttons={
                <>
                  <Button
                    color="blue"
                    icon="address-card"
                    content="管理员日志"
                    onClick={() => act('admin_log')}
                  />
                  <Button
                    color="blue"
                    icon="eye"
                    content="查看管理员"
                    onClick={() => act('show_admins')}
                  />
                </>
              }
            >
              <Flex mx={-0.5} align="stretch" justify="center">
                <Flex.Item bold>
                  <NoticeBox color="black">
                    &quot;管理员滥权的第一条规则就是：
                    不准谈论管理员滥权。&quot;
                  </NoticeBox>
                </Flex.Item>
              </Flex>
              <Flex
                textAlign="center"
                mx={-0.5}
                align="stretch"
                justify="center"
              >
                <Flex.Item ml={-10} mr={1}>
                  <Button
                    selected={tabIndex === 2}
                    icon="check-circle"
                    content="实用"
                    onClick={() => setTabIndex(2)}
                  />
                </Flex.Item>
                <Flex.Item ml={1}>
                  <Button
                    disabled={is_funmin === 0}
                    selected={tabIndex === 3}
                    icon="smile"
                    content="娱乐"
                    onClick={() => setTabIndex(3)}
                  />
                </Flex.Item>
              </Flex>
              <Flex mx={-0.5} align="stretch" justify="center">
                <Flex.Item mt={1}>
                  <Button
                    disabled={is_debugger === 0}
                    selected={tabIndex === 1}
                    icon="glasses"
                    content="调试"
                    onClick={() => setTabIndex(1)}
                  />
                </Flex.Item>
                <Flex.Item>
                  <LabeledControls>
                    <LabeledControls.Item
                      minWidth="66px"
                      label="被投诉的概率"
                    >
                      <RoundGauge
                        size={2}
                        value={TAB2NAME[tabIndex - 1].gauge}
                        minValue={0}
                        maxValue={100}
                        alertAfter={100 * 0.7}
                        ranges={{
                          good: [-2, 100 * 0.25],
                          average: [100 * 0.25, 100 * 0.75],
                          bad: [100 * 0.75, 100],
                        }}
                        format={(value) => `${toFixed(value)}%`}
                      />
                    </LabeledControls.Item>
                  </LabeledControls>
                </Flex.Item>
                <Flex.Item mt={1}>
                  <Button
                    disabled={is_funmin === 0}
                    selected={tabIndex === 4}
                    icon="smile-wink"
                    content="只有你觉得好玩"
                    onClick={() => setTabIndex(4)}
                  />
                </Flex.Item>
              </Flex>
            </Section>
          </Flex.Item>
          <Flex.Item grow={1}>
            <Section
              fill={false}
              title={
                TAB2NAME[tabIndex - 1].title +
                '，又名：' +
                TAB2NAME[tabIndex - 1].blurb
              }
            >
              <TabComponent />
            </Section>
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};
