import { useState } from 'react';
import {
  BlockQuote,
  Box,
  Button,
  Dropdown,
  Flex,
  Input,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Tabs,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { createSearch } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type RulesetCount = Record<string, number>;

type DynamicConfig = Record<string, any>;

type typePath = string;

type Player = {
  key: string;
};

type RulesetReport = RulesetType & {
  index: number;
  selected_players: Player[];
  hidden: BooleanLike;
};

type RulesetType = {
  name: string;
  id: string;
  typepath: typePath;
  admin_disabled: BooleanLike;
};

type Data = {
  current_tier?: {
    number: number;
    name: string;
  };
  ruleset_count?: RulesetCount;
  full_config?: DynamicConfig;
  queued_rulesets: RulesetReport[];
  active_rulesets: RulesetReport[];
  all_rulesets: Record<string, RulesetType[]>;
  time_until_lights: number;
  time_until_heavies: number;
  time_until_latejoins: number;
  time_until_next_midround: number;
  time_until_next_latejoin: number;
  failed_latejoins: number;
  light_midround_chance: number;
  heavy_midround_chance: number;
  latejoin_chance: number;
  roundstarted: BooleanLike;
  config_even_enabled: BooleanLike;
  light_chance_maxxed: BooleanLike;
  heavy_chance_maxxed: BooleanLike;
  latejoin_chance_maxxed: BooleanLike;
  next_dynamic_tick: number;
  antag_events_enabled: BooleanLike;
};

function formatTime(seconds: number): string {
  seconds /= 10;
  if (seconds < 0) {
    return '永不';
  }
  const hours = Math.floor(seconds / 3600);
  const minutes = Math.floor((seconds % 3600) / 60);
  const secs = Math.round(seconds % 60);

  return `${hours} 小时 ${minutes} 分 ${secs} 秒`;
}

function getPlayerString(players: Player[]): string {
  if (players.length === 0) {
    return '无人';
  } else if (players.length === 1) {
    return players[0].key;
  } else if (players.length === 2) {
    return `${players[0].key} 和 ${players[1].key}`;
  }
  let playerString = '';
  for (let i = 0; i < players.length; i++) {
    playerString += players[i].key;
    if (i < players.length - 1) {
      playerString += ', ';
    }
    if (i === players.length - 2) {
      playerString += '和 ';
    }
  }
  return playerString;
}

function readableRulesesetCategory(ruleset_category: string): string {
  // Replace underlines with spaces and auto-capitalize first letter of every word
  return ({ roundstart: '开局', latejoin: '中途加入', light_midround: '轻度局中事件', heavy_midround: '重度局中事件' }[ruleset_category] || ruleset_category)
    .replace(/_/g, ' ')
    .split(' ')
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');
}

const StatusPanel = () => {
  const { data, act } = useBackend<Data>();
  const {
    current_tier,
    ruleset_count,
    time_until_lights,
    time_until_heavies,
    time_until_latejoins,
    time_until_next_midround,
    time_until_next_latejoin,
    failed_latejoins,
    light_midround_chance,
    heavy_midround_chance,
    latejoin_chance,
    roundstarted,
    light_chance_maxxed,
    heavy_chance_maxxed,
    latejoin_chance_maxxed,
    next_dynamic_tick,
  } = data;

  if (!current_tier) {
    return (
      <LabeledList>
        <LabeledList.Item label="当前等级">
          <Button onClick={() => act('set_tier')}>（点击设置）</Button>
        </LabeledList.Item>
      </LabeledList>
    );
  }

  return (
    <LabeledList>
      <LabeledList.Item label="当前等级">
        <Box>
          <b>{current_tier.number}</b> ({current_tier.name})
        </Box>
        {!roundstarted && (
          <Button ml={1} onClick={() => act('set_tier')}>
            （更改）
          </Button>
        )}
      </LabeledList.Item>
      {ruleset_count &&
        Object.entries(ruleset_count).map(([name, count]) => (
          <LabeledList.Item
            key={name}
            label={`${readableRulesesetCategory(name)}规则集数量`}
          >
            <Flex>
              <Flex.Item>{count}</Flex.Item>
              {(name !== 'roundstart' || !roundstarted) && (
                <Flex.Item ml={1}>
                  <Button
                    icon="plus"
                    tooltip="将此类型的规则集数量上限增加 1"
                    tooltipPosition="right"
                    onClick={() =>
                      act('add_ruleset_category_count', {
                        ruleset_category: name,
                      })
                    }
                  />
                </Flex.Item>
              )}
              {(name !== 'roundstart' || !roundstarted) && (
                <Flex.Item ml={0.5}>
                  <Button
                    icon="times"
                    disabled={count === 0}
                    tooltip="将此类型的规则集数量上限设为 0"
                    tooltipPosition="right"
                    onClick={() =>
                      act('set_ruleset_category_count', {
                        ruleset_category: name,
                        ruleset_count: 0,
                      })
                    }
                  />
                </Flex.Item>
              )}
            </Flex>
          </LabeledList.Item>
        ))}
      {time_until_lights > 0 ? (
        <LabeledList.Item label="轻度局中事件开始时间">
          <Flex>
            <Flex.Item>
              <Box>{formatTime(time_until_lights)}</Box>
            </Flex.Item>
            <Flex.Item>
              <Button ml={1} onClick={() => act('light_start_now')}>
                立即开始
              </Button>
            </Flex.Item>
          </Flex>
        </LabeledList.Item>
      ) : (
        <>
          <LabeledList.Item label="轻度局中事件冷却">
            <Flex>
              <Flex.Item>
                <Box>
                  {time_until_next_midround > 0
                    ? formatTime(time_until_next_midround)
                    : `下次动态更新（${formatTime(next_dynamic_tick)}）`}
                </Box>
              </Flex.Item>
              <Flex.Item>
                <Button
                  ml={1}
                  disabled={time_until_next_midround <= 0}
                  onClick={() => act('reset_midround_cooldown')}
                >
                  重置冷却
                </Button>
              </Flex.Item>
            </Flex>
          </LabeledList.Item>
          <LabeledList.Item label="轻度局中事件概率">
            <Flex>
              <Flex.Item>
                <Box
                  inline
                  style={{
                    borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
                  }}
                >
                  <Tooltip content="下次动态更新选中轻度局中规则集的概率">
                    {light_midround_chance}%
                  </Tooltip>
                </Box>
              </Flex.Item>
              <Flex.Item>
                <Button ml={1} onClick={() => act('max_light_chance')}>
                  {light_chance_maxxed ? '重置' : '设为 100%'}
                </Button>
              </Flex.Item>
            </Flex>
          </LabeledList.Item>
        </>
      )}
      {time_until_heavies > 0 ? (
        <LabeledList.Item label="重度局中事件开始时间">
          <Flex>
            <Flex.Item>
              <Box>{formatTime(time_until_heavies)}</Box>
            </Flex.Item>
            <Flex.Item>
              <Button ml={1} onClick={() => act('heavy_start_now')}>
                立即开始
              </Button>
            </Flex.Item>
          </Flex>
        </LabeledList.Item>
      ) : (
        <>
          <LabeledList.Item label="重度局中事件冷却">
            <Flex>
              <Flex.Item>
                <Box>
                  {time_until_next_midround > 0
                    ? formatTime(time_until_next_midround)
                    : `下次动态更新（${formatTime(next_dynamic_tick)}）`}
                </Box>
              </Flex.Item>
              <Flex.Item>
                <Button
                  ml={1}
                  disabled={time_until_next_midround <= 0}
                  onClick={() => act('reset_midround_cooldown')}
                >
                  重置冷却
                </Button>
              </Flex.Item>
            </Flex>
          </LabeledList.Item>
          <LabeledList.Item label="重度局中事件概率">
            <Flex>
              <Flex.Item>
                <Box
                  inline
                  style={{
                    borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
                  }}
                >
                  <Tooltip content="下次动态更新选中重度局中规则集的概率">
                    {heavy_midround_chance}%
                  </Tooltip>
                </Box>
              </Flex.Item>
              <Flex.Item>
                <Button ml={1} onClick={() => act('max_heavy_chance')}>
                  {heavy_chance_maxxed ? '重置' : '设为 100%'}
                </Button>
              </Flex.Item>
            </Flex>
          </LabeledList.Item>
        </>
      )}
      {time_until_latejoins > 0 ? (
        <LabeledList.Item label="中途加入规则开始时间">
          <Flex>
            <Flex.Item>
              <Box>{formatTime(time_until_latejoins)}</Box>
            </Flex.Item>
            <Flex.Item>
              <Button ml={1} onClick={() => act('latejoin_start_now')}>
                立即开始
              </Button>
            </Flex.Item>
          </Flex>
        </LabeledList.Item>
      ) : (
        <>
          <LabeledList.Item label="中途加入规则冷却">
            <Flex>
              <Flex.Item>
                <Box>
                  {time_until_next_latejoin
                    ? formatTime(time_until_next_latejoin)
                    : '下一名中途加入的玩家'}
                </Box>
              </Flex.Item>
              <Flex.Item>
                <Button
                  ml={1}
                  disabled={time_until_next_latejoin <= 0}
                  onClick={() => act('reset_latejoin_cooldown')}
                >
                  重置冷却
                </Button>
              </Flex.Item>
            </Flex>
          </LabeledList.Item>
          <LabeledList.Item label="中途加入规则概率">
            <Flex>
              <Flex.Item>
                <Box
                  inline
                  style={{
                    borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
                  }}
                >
                  <Tooltip
                    content="下一名加入游戏的玩家被选中参与中途加入规则集的概率。
              注意，这不保证规则集一定执行；如果执行失败，
              下一名加入的玩家被选中的概率将会增加。"
                  >
                    {latejoin_chance}%（已失败 {failed_latejoins} 次）
                  </Tooltip>
                </Box>
              </Flex.Item>
              <Flex.Item>
                <Button ml={1} onClick={() => act('max_latejoin_chance')}>
                  {latejoin_chance_maxxed ? '重置' : '设为 100%'}
                </Button>
              </Flex.Item>
            </Flex>
          </LabeledList.Item>
        </>
      )}
    </LabeledList>
  );
};

// This just reports the entire config
const ConfigPanel = () => {
  const { data } = useBackend<Data>();
  const { full_config = {} } = data;

  const configKeys = Object.keys(full_config);
  const [shownConfig, setShownConfig] = useState(configKeys[0]);
  // Config given to us is basically just a big json object
  // Future TODO make this a whole functional config editor

  if (configKeys.length === 0) {
    return (
      <NoticeBox>
        未加载配置，请参考仓库中的默认配置。
      </NoticeBox>
    );
  }

  return (
    <Stack vertical fill>
      <Stack.Item>
        <NoticeBox>
          这是动态系统运行规则集时读取的
          当前配置。若需临时修改这些值，可以
          使用查看变量功能。（注意：回合开始后，修改等级配置
          不再生效。）
        </NoticeBox>
      </Stack.Item>
      <Stack.Item>
        <Dropdown
          options={configKeys}
          selected={shownConfig}
          onSelected={(key) => setShownConfig(key)}
        />
      </Stack.Item>
      <Stack.Item height="180px">
        <Section fill scrollable>
          <LabeledList>
            {Object.entries(full_config[shownConfig]).map(
              ([config_name, config]) => (
                <LabeledList.Item key={config_name} label={config_name}>
                  <Box
                    style={{
                      wordBreak: 'break-all',
                      wordWrap: 'break-word',
                    }}
                  >
                    {JSON.stringify(config)}
                  </Box>
                </LabeledList.Item>
              ),
            )}
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

// This is where you can see queued rulesets, active rulesets, and trigger new ones
const RulesetsPanel = () => {
  const { data, act } = useBackend<Data>();
  const { all_rulesets, queued_rulesets, active_rulesets, roundstarted } = data;

  const any_admin_disabled = Object.values(all_rulesets).some((ruleset_list) =>
    ruleset_list.some((ruleset) => ruleset.admin_disabled),
  );
  const all_admin_disabled = Object.values(all_rulesets).every((ruleset_list) =>
    ruleset_list.every((ruleset) => ruleset.admin_disabled),
  );

  const [searchText, setSearchText] = useState('');
  const searchFilter = createSearch(
    searchText,
    (ruleset: RulesetType) => ruleset.name,
  );

  return (
    <Stack vertical fill>
      <Stack.Item>
        <Section title="排队中的规则集">
          <Stack vertical>
            {queued_rulesets.length === 0 ? (
              <Stack.Item grow>
                <NoticeBox align="center">没有排队中的规则集。</NoticeBox>
              </Stack.Item>
            ) : (
              queued_rulesets.map((ruleset) => (
                <Stack.Item key={ruleset.id}>
                  <Button
                    mr={0.5}
                    icon="times"
                    tooltip="从队列移除"
                    onClick={() =>
                      act('remove_queued_ruleset', {
                        ruleset_index: ruleset.index,
                      })
                    }
                  />
                  {ruleset.name} ({ruleset.id})
                </Stack.Item>
              ))
            )}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Divider />
      <Stack.Item>
        <Section title="运行中的规则集">
          <Stack vertical>
            {active_rulesets.length === 0 ? (
              <Stack.Item grow>
                <NoticeBox align="center">没有运行中的规则集。</NoticeBox>
              </Stack.Item>
            ) : (
              active_rulesets.map((ruleset) => (
                <Stack.Item key={ruleset.id}>
                  <Flex>
                    <Flex.Item
                      style={
                        ruleset.hidden
                          ? { textDecoration: 'line-through' }
                          : undefined
                      }
                    >
                      {ruleset.name} ({ruleset.id})
                    </Flex.Item>
                    <Flex.Item ml={1}>
                      <Button.Checkbox
                        checked={ruleset.hidden}
                        icon="times"
                        tooltip="勾选后，此规则集
                          将不会显示在回合结束报告中。"
                        onClick={() =>
                          act('hide_ruleset', {
                            ruleset_index: ruleset.index,
                          })
                        }
                      />
                    </Flex.Item>
                  </Flex>
                  <BlockQuote>
                    已选择：{getPlayerString(ruleset.selected_players)}
                  </BlockQuote>
                </Stack.Item>
              ))
            )}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Divider />
      <Stack.Item height="330px">
        <Section
          fill
          title="可用规则集"
          scrollable
          buttons={
            <>
              <Input
                placeholder="搜索规则集……"
                onChange={setSearchText}
                expensive
                value={searchText}
              />
              <Button
                disabled={all_admin_disabled}
                onClick={() => act('disable_all')}
              >
                全部禁用
              </Button>
              <Button
                disabled={!any_admin_disabled}
                onClick={() => act('enable_all')}
              >
                全部启用
              </Button>
            </>
          }
        >
          <Stack>
            {Object.entries(all_rulesets).map(
              ([ruleset_category, ruleset_list]) => (
                <Stack.Item key={ruleset_category} grow>
                  <Stack vertical>
                    <Stack.Item align="center">
                      <h4>{readableRulesesetCategory(ruleset_category)}</h4>
                    </Stack.Item>
                    {ruleset_list
                      .filter(searchFilter)
                      .sort((a, b) => (a.name > b.name ? 1 : -1))
                      .map((ruleset, index) => (
                        <Stack.Item key={ruleset.id}>
                          <Flex>
                            {ruleset_category === 'roundstart' ||
                            ruleset_category === 'latejoin' ? (
                              <Flex.Item>
                                <Button
                                  icon="plus"
                                  tooltip={
                                    ruleset_category === 'roundstart' &&
                                    roundstarted
                                      ? '回合已经开始！'
                                      : '加入队列'
                                  }
                                  tooltipPosition="right"
                                  disabled={
                                    ruleset_category === 'roundstart' &&
                                    roundstarted
                                  }
                                  onClick={() =>
                                    act('add_queued_ruleset', {
                                      ruleset_type: ruleset.typepath,
                                    })
                                  }
                                />
                              </Flex.Item>
                            ) : (
                              <Flex.Item>
                                <Button
                                  icon="play"
                                  tooltip="执行此规则集"
                                  tooltipPosition="right"
                                  onClick={() =>
                                    act('execute_ruleset', {
                                      ruleset_type: ruleset.typepath,
                                    })
                                  }
                                />
                              </Flex.Item>
                            )}
                            {(ruleset_category !== 'roundstart' ||
                              !roundstarted) && (
                              <Flex.Item>
                                <Button.Checkbox
                                  ml={0.5}
                                  tooltipPosition="right"
                                  tooltip="勾选后，此规则集
                                      将永远不会随机触发。"
                                  checked={ruleset.admin_disabled}
                                  color={
                                    ruleset.admin_disabled ? 'bad' : 'grey'
                                  }
                                  disabled={
                                    ruleset_category === 'roundstart' &&
                                    roundstarted
                                  }
                                  onClick={() =>
                                    act('disable_ruleset', {
                                      ruleset_type: ruleset.typepath,
                                    })
                                  }
                                />
                              </Flex.Item>
                            )}
                            <Flex.Item
                              style={{
                                borderBottom:
                                  '2px dotted rgba(255, 255, 255, 0.8)',
                              }}
                              ml={1}
                            >
                              <Tooltip content={`ID: ${ruleset.id}`}>
                                {ruleset.name}
                              </Tooltip>
                            </Flex.Item>
                          </Flex>
                        </Stack.Item>
                      ))}
                  </Stack>
                </Stack.Item>
              ),
            )}
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

enum TABS {
  Status = 'Status',
  Rulesets = 'Rulesets',
  Config = 'Config',
}

export const DynamicAdmin = () => {
  const { act, data } = useBackend<Data>();
  const { config_even_enabled, antag_events_enabled } = data;

  // disable config tab if config_even_enabled is false
  const tabs_filtered = Object.keys(TABS).filter(
    (tab) => tab !== TABS.Config || config_even_enabled,
  );

  const [currentTab, setCurrentTab] = useState(tabs_filtered[0]);

  let componentShown;

  switch (currentTab) {
    case TABS.Status:
      componentShown = <StatusPanel />;
      break;
    case TABS.Config:
      componentShown = <ConfigPanel />;
      break;
    case TABS.Rulesets:
      componentShown = <RulesetsPanel />;
      break;
    default:
      componentShown = <StatusPanel />;
  }

  return (
    <Window
      title="动态模式管理面板"
      width={currentTab === TABS.Rulesets ? 800 : 500}
      height={currentTab === TABS.Rulesets ? 600 : 400}
    >
      <Window.Content>
        <Section
          title="&nbsp;"
          height="100%"
          width="100%"
          buttons={
            <>
              <Button.Checkbox
                checked={antag_events_enabled}
                tooltip="勾选后，可触发生成反派的随机事件
                  或动态规则集。"
                onClick={() => act('toggle_antag_events')}
              >
                反派事件
              </Button.Checkbox>
              <Button
                tooltip="打开动态子系统的变量查看面板。"
                onClick={() => act('dynamic_vv')}
              >
                VV
              </Button>
            </>
          }
        >
          <Tabs>
            {tabs_filtered.map((tab) => (
              <Tabs.Tab
                key={tab}
                selected={currentTab === tab}
                onClick={() => setCurrentTab(tab)}
              >
                {{ Status: '状态', Rulesets: '规则集', Config: '配置' }[tab] || tab}
              </Tabs.Tab>
            ))}
          </Tabs>
          {componentShown}
        </Section>
      </Window.Content>
    </Window>
  );
};
