// THIS IS A SKYRAT UI FILE
import { Fragment } from 'react';
import {
  Box,
  Button,
  Collapsible,
  Divider,
  Icon,
  ProgressBar,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import { chineseDisplay } from 'tgui/localization/zhDisplay';
import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';

const brassColor = '#DFC69C';
const tinkerCache = '#B5FD9D';
const replicaFab = '#DED09F';
const clockMarauder = '#FF9D9D';

const convertPower = (power_in) => {
  const units = ['W', 'kW', 'MW', 'GW'];
  let power = 0;
  let value = power_in;
  while (value >= 1000 && power < units.length) {
    power++;
    value /= 1000;
  }
  return Math.round((value + Number.EPSILON) * 100) / 100 + units[power];
};

export const ClockworkSlab = (props) => {
  const [selectedTab, setSelectedTab] = useLocalState(
    'selectedTab',
    'Servitude',
  );
  return (
    <Window theme="clockwork" width={860} height={700}>
      <Window.Content>
        <Section
          title={
            <Box inline color={'good'}>
              <Icon name={'cog'} rotation={0} spin={1} />
              {' 发条石板 '}
              <Icon name={'cog'} rotation={35} spin={1} />
            </Box>
          }
        >
          <ClockworkButtonSelection />
        </Section>
        <div className="ClockSlab__left">
          <Section height="100%" overflowY="auto">
            <ClockworkSpellList selectedTab={selectedTab} />
          </Section>
        </div>
        <div className="ClockSlab__right">
          <div className="ClockSlab__stats">
            <Section height="100%">
              <ClockworkOverview />
            </Section>
          </div>
          <div className="ClockSlab__current">
            <Section
              height="100%"
              overflowY="auto"
              title="《齿轮之仆》第一卷"
            >
              <ClockworkHelp />
            </Section>
          </div>
        </div>
      </Window.Content>
    </Window>
  );
};

const ClockworkHelp = (props) => {
  return (
    <>
      <Collapsible title="从何开始" color="average" open={1}>
        <Section>
          一场漫长而惨烈的战争过后，拉特瓦被囚禁
          于充满苦难的维度之中。
          <br />
          你是他仅存的、最忠诚的仆从之一。<br />
          你十分虚弱，力量所剩无几，大部分经文
          都无法生效。
          <br />
          <b>
            安装&nbsp;
            <font color={brassColor}>整合齿轮&nbsp;</font>
            以解锁更多经文并汲取能量！
          </b>
          <br />
        </Section>
      </Collapsible>
      <Collapsible title="解锁经文" color="average">
        <Section>
          大部分经文需要<b>齿轮</b>才能解锁。
          <br />
          念诵&nbsp;
          <font color={brassColor}>
            <b>整合齿轮&nbsp;</b>
          </font>
          召唤一个整合齿轮，将它装入任意&nbsp;
          <b>APC&nbsp;</b>
          即可，空间站各处的都适用。
          <br />
          用&nbsp;
          <b>整合齿轮&nbsp;</b>
          切开&nbsp;
          <b>APC&nbsp;</b>
          ，然后将齿轮插入以开始汲取能量。不过，整合齿轮
          必须在 APC 内持续运转 5
          分钟，你才能获得一个齿轮。
          <br />
        </Section>
      </Collapsible>
      <Collapsible title="研究" color="average">
        <Section>
          某些经文和装备无法仅靠齿轮解锁。
          <br />
          使用&nbsp;
          <font color={brassColor}>
            <b>技师讲台&nbsp;</b>
          </font>
          可以研究通常处于锁定状态的装备和能力，但
          过程并不轻松。
          <br />
          每项研究都只能在特定地点
          进行，而且需要时间才能完成。在此期间，你的存在
          会变得格外显眼。
          <br />
        </Section>
      </Collapsible>
      <Collapsible title="防御" color="average">
        <Section>
          <b>
            你拥有多种结构和能力，它们对
            保卫你的领地至关重要。
          </b>
          <br />
          <b>
            <font color={brassColor}>结构：&nbsp;</font>
          </b>
          你可以建造多种珍贵的结构，
          有效守卫你的圣所。对结构使用石板
          即可获得更多信息。
          <br />
          <b>
            <font color={brassColor}>陷阱：&nbsp;</font>
          </b>
          陷阱是很实用的装置，可以在{' '}
          <font color={tinkerCache}>修补匠的秘藏</font>中制作。用石板
          将陷阱与触发器连接起来。
          <br />
          <b>
            <font color={clockMarauder}>发条掠夺者：&nbsp;</font>
          </b>
          一具强大的躯壳，能够偏转攻击，并在近身战中
          施以重击。
          <br />
          <br />
        </Section>
      </Collapsible>
      <Collapsible title="提示" color="average">
        <Section>
          <b>
            <font color={brassColor}>活力：&nbsp;</font>
          </b>
          创造{' '}
          <font color={clockMarauder}>发条掠夺者</font>需要活力，
          可通过将生物献祭给{' '}
          <font color={brassColor}>活力矩阵</font>来获得。
          <br />
          <b>
            <font color={brassColor}>能量：&nbsp;</font>
          </b>
          注意能量消耗！你依靠装有齿轮的 APC
          维持供能，而许多结构会迅速耗尽能量。
          <br />
          <b>
            <font color={brassColor}>基地：&nbsp;</font>
          </b>
          务必建立一个易于防守的行动基地！站在
          黄铜地砖上时，你会强大得多，因此要将家园
          建造成坚不可摧的堡垒。
          <br />
          <b>
            <font color={replicaFab}>复制制造器：&nbsp;</font>
          </b>
          复制制造器是你能获得的最强工具之一，
          可通过<font color={tinkerCache}>修补匠的秘藏</font>获取。它
          能将各种材料转化为能量，用来
          建造地板、墙壁和气闸。气闸会电击所有
          非教徒。
          <br />
          <b>
            <font color={brassColor}>纳尔西：&nbsp;</font>
          </b>
          纳尔西的教徒是你的头号敌人！你的一些法术对他们
          效果较弱，反之亦然。将这类异端作为活力祭品，
          或许能得到拉特瓦残存力量的奖赏。
          <br />
          <br />
        </Section>
      </Collapsible>
    </>
  );
};

const ClockworkSpellList = (props) => {
  const { act, data } = useBackend();
  const { selectedTab } = props;
  const { scriptures = [] } = data;
  return (
    <Table>
      {scriptures.map((script) =>
        script.type === selectedTab ? (
          <Fragment key={script}>
            <Table.Row>
              <Table.Cell bold>{script.name}</Table.Cell>
              <Table.Cell collapsing textAlign="right">
                <Button
                  fluid
                  color={script.purchased ? 'default' : 'average'}
                  content={
                    script.purchased
                      ? `念诵 ${convertPower(script.cost)}`
                      : `${script.cog_cost} 齿轮`
                  }
                  tooltip={
                    script.research_required
                      ? '需要研究才能解锁。'
                      : script.tip
                  }
                  disabled={script.research_required}
                  onClick={() =>
                    act('invoke', {
                      scriptureType: script.typepath,
                    })
                  }
                />
              </Table.Cell>
            </Table.Row>
            <Table.Row>
              <Table.Cell>{script.desc}</Table.Cell>
              <Table.Cell collapsing textAlign="right">
                <Button
                  fluid
                  content={'快速绑定'}
                  disabled={!script.purchased}
                  onClick={() =>
                    act('quickbind', {
                      scriptureType: script.typepath,
                    })
                  }
                />
              </Table.Cell>
            </Table.Row>
            <Table.Cell>
              <Divider />
            </Table.Cell>
          </Fragment>
        ) : (
          <Box key={script} />
        ),
      )}
    </Table>
  );
};

const ClockworkOverview = (props) => {
  const { data } = useBackend();
  const { power, cogs, vitality, max_power, max_vitality } = data;
  return (
    <Box>
      <Box color="good" bold fontSize="16px">
        {'天界之门报告'}
      </Box>
      <Divider />
      <ClockworkOverviewStat
        title="齿轮"
        amount={cogs}
        maxAmount={10}
        iconName="cog"
        unit=""
      />
      <ClockworkOverviewStat
        title="能量"
        amount={power}
        maxAmount={max_power}
        iconName="battery-half "
        overrideText={convertPower(power)}
      />
      <ClockworkOverviewStat
        title="活力"
        amount={vitality}
        maxAmount={max_vitality}
        iconName="tint"
        unit="u"
      />
    </Box>
  );
};

const ClockworkOverviewStat = (props) => {
  const { title, iconName, amount, maxAmount, unit, overrideText } = props;
  return (
    <Box height="22px" fontSize="16px">
      <Stack>
        <Stack.Item width="8%">
          <Icon name={iconName} rotation={0} spin={0} />
        </Stack.Item>
        <Stack.Item width="20%">{title}</Stack.Item>
        <Stack.Item width="80%">
          <ProgressBar
            value={amount}
            minValue={0}
            maxValue={maxAmount}
            ranges={{
              good: [maxAmount / 2, Infinity],
              average: [maxAmount / 4, maxAmount / 2],
              bad: [-Infinity, maxAmount / 4],
            }}
          >
            {overrideText ? overrideText : `${amount} ${unit}`}
          </ProgressBar>
        </Stack.Item>
      </Stack>
    </Box>
  );
};

const ClockworkButtonSelection = (props) => {
  const [selectedTab, setSelectedTab] = useLocalState('selectedTab', {});
  const tabs = ['Servitude', 'Preservation', 'Structures'];
  return (
    <Table>
      <Table.Row>
        {tabs.map((tab) => (
          <Table.Cell key={tab} collapsing>
            <Button key={tab} fluid onClick={() => setSelectedTab(tab)}>
              {chineseDisplay(tab)}
            </Button>
          </Table.Cell>
        ))}
      </Table.Row>
    </Table>
  );
};
