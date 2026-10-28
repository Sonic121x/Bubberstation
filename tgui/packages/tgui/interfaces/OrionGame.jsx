import { Box, Button, Divider, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { batchThreeDisplay } from '../localization/batchThreeDisplay';
const buttonWidth = 2;

const goodstyle = {
  color: 'lightgreen',
  fontWeight: 'bold',
};

const badstyle = {
  color: 'red',
  fontWeight: 'bold',
};

const partstyle = {
  color: 'yellow',
  fontWeight: 'bold',
};

const fuelstyle = {
  color: 'olive',
  fontWeight: 'bold',
};

const variousButtonIcons = {
  'Restore Hull': 'wrench',
  'Fix Engine': 'rocket',
  'Repair Electronics': 'server',
  Wait: 'clock',
  Continue: 'arrow-right',
  'Explore Ship': 'door-open',
  'Leave the Derelict': 'arrow-right',
  'Welcome aboard.': 'user-plus',
  'Where did you go?!': 'user-minus',
  'A good find.': 'box-open',
  'Continue travels.': 'arrow-right',
  'Keep Speed': 'tachometer-alt',
  'Slow Down': 'arrow-left',
  'Speed Past': 'tachometer-alt',
  'Go Around': 'redo',
  'Oh...': 'circle',
  Dock: 'dollar-sign',
};

const STATUS2COMPONENT = [
  { component: () => ORION_STATUS_START },
  { component: () => ORION_STATUS_INSTRUCTIONS },
  { component: () => ORION_STATUS_NORMAL },
  { component: () => ORION_STATUS_GAMEOVER },
  { component: () => ORION_STATUS_MARKET },
];

const locationInfo = [
  {
    title: '冥王星',
    blurb:
      '冥王星早已部署远程传感器与扫描仪，时刻准备着，并持续探测银河深处。',
  },
  {
    title: '小行星带',
    blurb:
      '太阳系边缘有一片危机四伏的小行星带。许多人因判断失误，被游荡的小行星撞得粉身碎骨。',
  },
  {
    title: '比邻星',
    blurb:
      '这里是距太阳最近的恒星系，曾象征亚光速航行的极限，如今已成为人烟稀少的冒险者与商人避风港。',
  },
  {
    title: '死寂星域',
    blurb:
      '这片星域中的物质极其稀少。虽然这种低密度区域并不罕见，但它的广阔程度仍令人震惊。',
  },
  {
    title: '参宿七主星',
    blurb:
      '参宿七星系中央的主星炽热燃烧，让周围行星沐浴在热量与辐射之中。',
  },
  {
    title: '天仓五贝塔',
    blurb:
      '天仓五贝塔最近成为前往猎户座的殖民者的中转站，附近聚集着许多飞船和临时空间站。',
  },
  {
    title: '太空虫',
    blurb:
      '你看见窗外有些太空虫。它们以扭曲现实的方式蠕动，让你感到恶心。银河法规要求报告所有太空虫目击事件。',
  },
  {
    title: '贝塔-9 太空前哨',
    blurb:
      '你接近了这片星域中的第一座人造建筑。建造它的不是太阳系旅人，而是来自猎户座的殖民者。它是殖民者成功的丰碑。',
  },
  {
    title: '猎户座主星',
    blurb:
      '你抵达了猎户座！恭喜！你的船员成为了少数为人类开辟新立足点的先驱！',
  },
];

const AdventureStatus = (props) => {
  const { data, act } = useBackend();
  const {
    lings_suspected,
    eventname,
    settlers,
    settlermoods,
    hull,
    electronics,
    engine,
    food,
    fuel,
  } = data;
  return (
    <Section
      title="冒险状态"
      fill
      buttons={
        !!lings_suspected && (
          <Button
            fluid
            color="black"
            textAlign="center"
            icon="skull"
            content="随机处决"
            disabled={eventname}
            onClick={() => act('random_kill')}
          />
        )
      }
    >
      <Stack fill g={0}>
        <Stack.Item grow>
          {settlers?.map((settler) => (
            <Stack key={settler} align="center">
              <Stack.Item grow>{settler}</Stack.Item>
              <Stack.Item>
                <Button
                  fluid
                  color="red"
                  textAlign="center"
                  icon="skull"
                  content="处决"
                  disabled={lings_suspected || eventname}
                  onClick={() =>
                    act('target_kill', {
                      who: settler,
                    })
                  }
                />
              </Stack.Item>
              <Stack.Item
                className={`moods32x32 mood${settlermoods[settler] + 1}`}
              />
            </Stack>
          ))}
        </Stack.Item>
        <Divider vertical />
        <Stack.Item>
          <Stack vertical fill justify="center">
            <Stack.Item>
              <Button
                fluid
                icon="hamburger"
                content={`剩余食物：${food}`}
                color="green"
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                fluid
                icon="gas-pump"
                content={`剩余燃料：${fuel}`}
                color="olive"
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                fluid
                icon="wrench"
                content={`船体零件：${hull}`}
                color="average"
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                fluid
                icon="server"
                content={`电子零件：${electronics}`}
                color="blue"
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                fluid
                icon="rocket"
                content={`引擎零件：${engine}`}
                color="violet"
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const ORION_STATUS_START = (props) => {
  const { data, act } = useBackend();
  const { gamename } = data;
  return (
    <Section fill>
      <Stack vertical textAlign="center" fill>
        <Stack.Item grow={1} />
        <Stack.Item fontSize="32px">{gamename}</Stack.Item>
        <Stack.Item grow fontSize="15px" color="label">
          {'“重温先祖的旅程！”'}
        </Stack.Item>
        <Stack.Item fontSize="15px">
          <Button
            lineHeight={2}
            fluid
            icon="play"
            content="开始游戏"
            onClick={() => act('start_game')}
          />
        </Stack.Item>
        <Stack.Item fontSize="15px">
          <Button
            lineHeight={2}
            fluid
            icon="info"
            content="玩法说明"
            onClick={() => act('instructions')}
          />
        </Stack.Item>
        <Stack.Item grow={3} />
      </Stack>
    </Section>
  );
};

const ORION_STATUS_INSTRUCTIONS = (props) => {
  const { act } = useBackend();
  const fake_settlers = ['约翰', '威廉', '爱丽丝', '汤姆'];
  return (
    <>
      <Section
        color="label"
        title="目标"
        buttons={
          <Button
            content="返回主菜单"
            onClick={() => act('back_to_menu')}
          />
        }
      >
        <Box fontSize="11px">
          23 世纪，猎户座航路开辟，
          为勇于冒险的人提供了一条危险却充满机遇的太空航线。
          许多在银河边疆追寻新生活的先驱，最终找到了
          梦寐以求的一切……或者在途中丧命。
        </Box>
      </Section>
      <Section title="状态示例">
        <Stack>
          <Stack.Item basis={70} grow align="center">
            {fake_settlers?.map((settler) => (
              <Stack key={settler} align="center">
                <Stack.Item grow>{settler}</Stack.Item>
                <Stack.Item>
                  <Button
                    fluid
                    color="red"
                    textAlign="center"
                    icon="skull"
                    content="处决"
                  />
                </Stack.Item>
                <Stack.Item className={'moods32x32 mood5'} />
              </Stack>
            ))}
          </Stack.Item>
          <Divider vertical />
          <Stack.Item>
            这里显示先驱们的状态。每次继续向前航行，
            每人都要消耗 1 单位食物才能前往<span style={goodstyle}>猎户座</span>
            。途中可以招募更多船员，但失去他们
            可能和找到他们一样快。
            <br />
            <br />
            如果食物耗尽或船员全部死亡，{' '}
            就会<span style={badstyle}>游戏结束</span>！
          </Stack.Item>
        </Stack>
      </Section>
      <Section title="资源">
        <Stack>
          <Stack.Item grow>
            如果想要抵达<span style={goodstyle}>猎户座</span>，
            就必须合理管理资源：
            <br />
            <span style={goodstyle}>食物</span>：船员需要吃饭。
            船员越多，食物消耗越快！
            <br />
            <span style={fuelstyle}>燃料</span>：每次航行消耗 5 单位
            燃料。别让它耗尽。
            <br />
            <span style={partstyle}>零件</span>：用于修复故障。
            没人喜欢把时间浪费在维修上！
          </Stack.Item>
          <Divider vertical />
          <Stack.Item>
            <Stack vertical fill justify="center">
              <Stack.Item>
                <Button
                  fluid
                  icon="hamburger"
                  content={'剩余食物：80'}
                  color="green"
                />
              </Stack.Item>
              <Stack.Item>
                <Button
                  fluid
                  icon="gas-pump"
                  content={'剩余燃料：60'}
                  color="olive"
                />
              </Stack.Item>
              <Stack.Item>
                <Button
                  fluid
                  icon="wrench"
                  content={'船体零件：1'}
                  color="average"
                />
              </Stack.Item>
              <Stack.Item>
                <Button
                  fluid
                  icon="server"
                  content={'电子零件：1'}
                  color="blue"
                />
              </Stack.Item>
              <Stack.Item mb={-0.3}>
                <Button
                  fluid
                  icon="rocket"
                  content={'引擎零件：1'}
                  color="violet"
                />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Section>
    </>
  );
};

const ORION_STATUS_NORMAL = (props) => {
  const { data, act } = useBackend();
  const {
    settlers,
    settlermoods,
    hull,
    electronics,
    engine,
    food,
    fuel,
    turns,
    eventname,
    eventtext,
    buttons,
  } = data;
  return (
    <Stack vertical fill>
      <Stack.Item grow>
        <Section title={(!!eventname && '事件') || '地点'} fill>
          <Stack fill textAlign="center" vertical>
            <Stack.Item grow>
              <Box bold fontSize="15px">
                {(!!eventname && batchThreeDisplay(eventname)) || locationInfo[turns - 1].title}
              </Box>
              <br />
              <Box fontSize="15px">
                {(!!eventtext && eventtext) || locationInfo[turns - 1].blurb}
              </Box>
            </Stack.Item>
            <Stack.Item>
              {(!!buttons &&
                buttons.map((button) => (
                  <Stack.Item key={button}>
                    <Button
                      mb={1}
                      lineHeight={3}
                      width={16}
                      icon={variousButtonIcons[button]}
                      content={batchThreeDisplay(button)}
                      onClick={() => act(button)}
                    />
                  </Stack.Item>
                ))) || (
                <Button
                  mb={1}
                  lineHeight={3}
                  width={16}
                  icon="arrow-right"
                  content="继续"
                  onClick={() => act('continue')}
                />
              )}
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <AdventureStatus />
      </Stack.Item>
    </Stack>
  );
};

const ORION_STATUS_GAMEOVER = (props) => {
  const { data, act } = useBackend();
  const { reason } = data;
  return (
    <Section fill>
      <Stack vertical textAlign="center" fill>
        <Stack.Item grow={1} />
        <Stack.Item color="red" fontSize="32px">
          {'游戏结束'}
        </Stack.Item>
        <Stack.Item grow fontSize="15px" color="label">
          {reason}
        </Stack.Item>
        <Stack.Item fontSize="15px">
          <Button
            lineHeight={2}
            fluid
            icon="arrow-left"
            content="主菜单"
            onClick={() => act('back_to_menu')}
          />
        </Stack.Item>
        <Stack.Item grow={3} />
      </Stack>
    </Section>
  );
};

const marketButtonSpacing = 0.8;

const ORION_STATUS_MARKET = (props) => {
  const { data, act } = useBackend();
  const { turns, spaceport_raided } = data;
  return (
    <Stack vertical fill>
      <Stack.Item grow>
        <Section
          title="市场"
          fill
          buttons={
            <>
              <Button
                content="劫掠"
                icon="skull"
                color="black"
                disabled={spaceport_raided}
                onClick={() => act('raid_spaceport')}
              />
              <Button
                content="离开"
                icon="arrow-right"
                onClick={() => act('leave_spaceport')}
              />
            </>
          }
        >
          <Stack fill textAlign="center" vertical>
            <Stack.Item grow>
              <Box mb={-2} bold fontSize="15px">
                {(turns === 4 && '天仓五贝塔') || '小型太空港'}
              </Box>
              <br />
              <Box fontSize="14px">
                {(spaceport_raided && (
                  <Box color="red">
                    你能活着逃出来已经很幸运了。
                    再次尝试停靠只会送命。
                  </Box>
                )) ||
                  '你好，先驱！我们有物资可以帮助你 \
                  抵达猎户座。不过可不是免费的！'}
              </Box>
            </Stack.Item>
            {(spaceport_raided && (
              <>
                <Stack.Item>
                  港口已进入高度戒备状态。
                  购买物资的机会早已溜走。
                </Stack.Item>
                <Stack.Item grow />
              </>
            )) || (
              <>
                <Stack.Item>综合市场：</Stack.Item>
                <Stack.Item>
                  <Stack mb={-1} fill>
                    <Stack.Item grow basis={0}>
                      <Stack vertical>
                        <Stack.Item>
                          <Button
                            fluid
                            icon="gas-pump"
                            content={'5 食物 → 5 燃料'}
                            color="green"
                            onClick={() =>
                              act('trade', {
                                what: 2,
                              })
                            }
                          />
                        </Stack.Item>
                        <Divider />
                        <Stack.Item mt={0}>港口机库：</Stack.Item>
                        <Stack.Item mb={marketButtonSpacing}>
                          <Button
                            fluid
                            icon="wrench"
                            content={'5 燃料换船体板'}
                            color="average"
                            onClick={() =>
                              act('buyparts', {
                                part: 2,
                              })
                            }
                          />
                        </Stack.Item>
                        <Stack.Item mb={marketButtonSpacing}>
                          <Button
                            fluid
                            icon="server"
                            content={'5 燃料换电子零件'}
                            color="blue"
                            onClick={() =>
                              act('buyparts', {
                                part: 3,
                              })
                            }
                          />
                        </Stack.Item>
                        <Stack.Item mb={marketButtonSpacing}>
                          <Button
                            fluid
                            icon="rocket"
                            content={'5 燃料换引擎零件'}
                            color="violet"
                            onClick={() =>
                              act('buyparts', {
                                part: 1,
                              })
                            }
                          />
                        </Stack.Item>
                      </Stack>
                    </Stack.Item>
                    <Stack.Item grow basis={0}>
                      <Stack vertical>
                        <Stack.Item>
                          <Button
                            fluid
                            icon="hamburger"
                            content={'5 燃料 → 5 食物'}
                            color="olive"
                            onClick={() =>
                              act('trade', {
                                what: 1,
                              })
                            }
                          />
                        </Stack.Item>
                        <Divider />
                        <Stack.Item mt={0}>港口酒吧：</Stack.Item>
                        <Stack.Item mb={marketButtonSpacing}>
                          <Button
                            fluid
                            icon="user-plus"
                            content={'10 食物和 10 燃料换船员'}
                            color="white"
                            onClick={() => act('buycrew')}
                          />
                        </Stack.Item>
                        <Stack.Item mb={marketButtonSpacing}>
                          <Button
                            fluid
                            icon="user-minus"
                            content={'船员换 7 食物和 7 燃料'}
                            color="black"
                            onClick={() => act('sellcrew')}
                          />
                        </Stack.Item>
                        <Stack.Item mb={marketButtonSpacing}>
                          <Button
                            fluid
                            icon="meteor"
                            content={'古怪船员（同价）'}
                            color="purple"
                            onClick={() =>
                              act('buycrew', {
                                odd: 1,
                              })
                            }
                          />
                        </Stack.Item>
                      </Stack>
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
              </>
            )}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <AdventureStatus />
      </Stack.Item>
    </Stack>
  );
};

export const OrionGame = (props) => {
  const { act, data } = useBackend();
  const { gamestatus, gamename, eventname } = data;
  const GameStatusComponent = STATUS2COMPONENT[gamestatus].component();
  const MarketRaid = STATUS2COMPONENT[2].component();
  return (
    <Window title={gamename} width={420} height={535}>
      <Window.Content scrollable>
        {(eventname === 'Space Port Raid' && <MarketRaid />) || (
          <GameStatusComponent />
        )}
      </Window.Content>
    </Window>
  );
};
