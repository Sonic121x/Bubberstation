import { useState } from 'react';
import {
  Box,
  Button,
  Collapsible,
  Dropdown,
  Flex,
  Input,
  LabeledList,
  NoticeBox,
  NumberInput,
  Section,
  Slider,
  Stack,
  Tabs,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { factionDisplay, factionOptions, narrateColourDisplay, narrateColourOptions } from './PlayerPanelDisplay';
type Data = {
  mob_name: string;
  mob_type: string;
  admin_mob_type: string;
  client_ckey: string;
  client_rank: string;
  ranks: string;
  last_ckey: string;
  discord_id: string;
  playtimes_enabled: boolean;
  playtime: string;
  godmode: boolean;
  is_frozen: boolean;
  is_slept: boolean;
  client_muted: number;
  current_time: string;
  data_related_ip: string;
  data_related_cid: string;
  data_player_join_date: string;
  data_account_join_date: string;
  data_byond_version: string;
  data_old_names: string;
  mob_speed: number;
  mob_scale: number;
  mob_status_flags: number;
  current_faction: string[];

  glob_mute_bits: {
    name: string;
    bitflag: number;
  }[];

  glob_limbs: {
    [key: string]: string;
  };

  glob_status_flags: {
    [key: string]: number;
  };

  glob_factions: string[];

  transformables: {
    name: string;
    color: string;
    types: {
      name: string;
      key: string;
    }[];
  }[];
};

const PAGES = [
  {
    title: '常规',
    component: () => GeneralActions,
    color: 'green',
    icon: 'tools',
  },
  {
    title: '生物',
    component: () => PhysicalActions,
    color: 'yellow',
    icon: 'bolt',
    canAccess: (data) => {
      return !!data.mob_type.includes('/mob/living');
    },
  },
  {
    title: '变形',
    component: () => TransformActions,
    color: 'orange',
    icon: 'exchange-alt',
  },
  {
    title: '惩罚',
    component: () => PunishmentActions,
    color: 'red',
    icon: 'gavel',
  },
  {
    title: '趣味',
    component: () => FunActions,
    color: 'blue',
    icon: 'laugh',
  },
  {
    title: '其他',
    component: () => OtherActions,
    color: 'blue',
    icon: 'crosshairs',
  },
];

export const PlayerPanel = () => {
  const { act, data } = useBackend<Data>();
  const [pageIndex, setPageIndex] = useState(0);
  const PageComponent = PAGES[pageIndex].component();

  const {
    mob_name,
    mob_type,
    client_ckey,
    client_rank,
    ranks,
    last_ckey,
    playtimes_enabled,
    playtime,
  } = data;

  return (
    <Window title={`${mob_name} 玩家面板`} width={600} height={480}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <Section>
              <Stack>
                <Stack.Item width="80px" color="label">
                  名称：
                </Stack.Item>
                <Stack.Item grow={1}>
                  <Input
                    width="100%"
                    value={mob_name}
                    onBlur={(value) => act('set_name', { name: value })}
                  />
                </Stack.Item>
                {!!client_ckey && (
                  <Stack.Item>
                    <Box inline ml=".75rem" mr=".5rem" color="label">
                      等级：
                    </Box>
                    <Stack.Item inline>
                      <Button
                        minWidth="11rem"
                        textAlign="center"
                        onClick={() => act('edit_rank')}
                      >
                        {client_rank}
                      </Button>
                    </Stack.Item>
                  </Stack.Item>
                )}
              </Stack>

              <Stack mt={1}>
                <Stack.Item width="80px" color="label">
                  生物类型：
                </Stack.Item>
                <Stack.Item grow={1}>{mob_type}</Stack.Item>
                <Stack.Item>
                  <Button
                    minWidth="11rem"
                    textAlign="center"
                    ml=".5rem"
                    icon="window-restore"
                    onClick={() => act('access_variables')}
                  >
                    查看变量
                  </Button>
                  {!!client_ckey && (
                    <Button
                      minWidth="11rem"
                      textAlign="center"
                      ml=".5rem"
                      icon="window-restore"
                      disabled={!playtimes_enabled}
                      onClick={() => act('access_playtimes')}
                    >
                      {playtimes_enabled ? playtime : '游玩时长'}
                    </Button>
                  )}
                </Stack.Item>
              </Stack>

              {(!!client_ckey || !!last_ckey) && (
                <Stack mt={1}>
                  <Stack.Item width="80px" color="label">
                    {client_ckey ? '客户端：' : '上个客户端：'}
                  </Stack.Item>
                  <Stack.Item grow={1}>
                    <Tooltip
                      position="bottom"
                      content={ranks || '无其他等级'}
                    >
                      <Box
                        inline
                        style={{
                          borderBottom: ranks
                            ? '2px dotted rgba(255, 255, 255, 0.8)'
                            : 'none',
                        }}
                      >
                        {client_ckey || last_ckey}
                      </Box>
                    </Tooltip>

                    {!client_ckey && !!last_ckey && (
                      <Button
                        ml={1}
                        icon="magnifying-glass"
                        tooltip="打开玩家的当前面板"
                        onClick={() => act('open_latest_panel')}
                      />
                    )}
                  </Stack.Item>

                  {!!client_ckey && (
                    <Stack.Item>
                      <Button
                        minWidth="11rem"
                        textAlign="center"
                        ml=".5rem"
                        icon="comment-dots"
                        onClick={() => act('private_message')}
                      >
                        私人消息
                      </Button>
                      <Button
                        minWidth="11rem"
                        textAlign="center"
                        ml=".5rem"
                        icon="phone-alt"
                        onClick={() => act('subtle_message')}
                      >
                        隐秘消息
                      </Button>
                    </Stack.Item>
                  )}
                </Stack>
              )}
            </Section>
          </Stack.Item>

          <Stack.Item grow>
            <Stack fill>
              <Stack.Item>
                <Section fitted>
                  <Tabs vertical>
                    {PAGES.map((page, i) => {
                      if (page.canAccess && !page.canAccess(data)) {
                        return <Tabs.Tab />;
                      }

                      return (
                        <Tabs.Tab
                          key={i}
                          color={page.color}
                          selected={i === pageIndex}
                          icon={page.icon}
                          onClick={() => setPageIndex(i)}
                        >
                          {page.title}
                        </Tabs.Tab>
                      );
                    })}
                  </Tabs>
                </Section>
              </Stack.Item>
              <Stack.Item grow basis={0} ml={1}>
                <Section fill scrollable>
                  <PageComponent />
                </Section>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const GeneralActions = () => {
  const { act, data } = useBackend<Data>();
  const { client_ckey, mob_type, admin_mob_type } = data;
  return (
    <Section>
      <Section title="伤害">
        <Flex>
          <Button
            width="100%"
            icon="heart"
            color="green"
            disabled={!mob_type.includes('/mob/living')}
            onClick={() => act('heal')}
          >
            完全恢复
          </Button>
          <Button
            width="100%"
            height="100%"
            icon="bolt"
            color="orange"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('smite')}
          >
            神罚
          </Button>
        </Flex>
      </Section>

      <Section title="传送">
        <Flex>
          <Button.Confirm
            width="100%"
            icon="reply"
            onClick={() => act('bring')}
          >
            拉到身边
          </Button.Confirm>
          <Button width="100%" onClick={() => act('orbit')}>
            跟随
          </Button>
          <Button.Confirm
            width="100%"
            height="100%"
            icon="share"
            onClick={() => act('jump_to')}
          >
            传送至目标
          </Button.Confirm>
        </Flex>
      </Section>

      <Section title="杂项">
        <Flex>
          <Button
            width="100%"
            height="100%"
            icon="user-tie"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('select_equipment')}
          >
            选择装备
          </Button>
          <Button.Confirm
            icon="trash-alt"
            width="100%"
            height="100%"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('strip')}
          >
            丢弃全部物品
          </Button.Confirm>
          <Button
            width="100%"
            textAlign="center"
            disabled={!client_ckey}
            onClick={() => act('traitor_panel')}
          >
            叛徒面板
          </Button>
          <Button
            width="100%"
            height="100%"
            textAlign="center"
            disabled={
              !client_ckey || !mob_type.includes('/mob/living/carbon/human')
            }
            onClick={() => act('apply_client_quirks')}
          >
            应用客户端特质
          </Button>
        </Flex>
        <Flex>
          <Button.Confirm
            icon="snowflake"
            width="100%"
            height="100%"
            color="orange"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('cryo')}
          >
            送入冷冻舱
          </Button.Confirm>
          <Button
            width="100%"
            height="100%"
            icon="clipboard-list"
            color="orange"
            textAlign="center"
            onClick={() => act('logs')}
          >
            日志
          </Button>
          <Button.Confirm
            width="100%"
            height="100%"
            color="orange"
            icon="undo"
            disabled={!mob_type.includes('/mob/dead/observer')}
            tooltip={
              mob_type !== '/mob/dead/observer'
                ? '仅可对幽灵使用'
                : ''
            }
            onClick={() => act('lobby')}
          >
            送回大厅
          </Button.Confirm>
        </Flex>
        <Flex>
          <Button
            width="100%"
            icon="user-cog"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('load_preferences')}
          >
            加载偏好设置
          </Button>
        </Flex>
      </Section>

      <Section title="控制">
        <Flex>
          <Button.Confirm
            width="100%"
            icon="ghost"
            confirmColor="bad"
            disabled={!client_ckey || !mob_type.includes('/mob/living')}
            onClick={() => act('ghost')}
          >
            弹出灵魂
          </Button.Confirm>
          <Button.Confirm
            width="100%"
            confirmColor="bad"
            disabled={
              mob_type.includes('/mob/dead/observer') ||
              !admin_mob_type.includes('/mob/dead/observer')
            }
            onClick={() => act('take_control')}
          >
            接管控制
          </Button.Confirm>
          <Button.Confirm
            width="100%"
            height="100%" // weird ass bug here, so height set to 100%
            icon="ghost"
            tooltip="向幽灵提供控制权"
            disabled={!mob_type.includes('/mob/living')}
            onClick={() => act('offer_control')}
          >
            提供控制权
          </Button.Confirm>
        </Flex>
      </Section>
    </Section>
  );
};

const PhysicalActions = () => {
  const { act, data } = useBackend<Data>();
  const {
    glob_limbs,
    glob_status_flags,
    mob_scale,
    mob_speed,
    mob_status_flags,
    mob_type,
    current_faction,
    glob_factions,
  } = data;
  const limbs = Object.keys(glob_limbs);
  const limb_flags = limbs.map((_, i) => 1 << i);
  const [delimbOption, setDelimbOption] = useState(0);

  return (
    <Section fill>
      <Section title="特性">
        <Flex>
          <Button
            width="100%"
            height="100%"
            icon="paw"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('species')}
          >
            种族
          </Button>
          <Button
            width="100%"
            height="100%"
            icon="bolt"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('quirk')}
          >
            特质
          </Button>
          <Button
            width="100%"
            height="100%"
            icon="magic"
            onClick={() => act('spell')}
          >
            法术
          </Button>
        </Flex>
        <Flex mt={1}>
          <Button
            width="100%"
            height="100%"
            icon="fist-raised"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('martial_art')}
          >
            武术
          </Button>
          <Button
            width="100%"
            height="100%"
            icon="lightbulb"
            onClick={() => act('skill_panel')}
          >
            技能
          </Button>
          <Button
            width="100%"
            height="100%"
            icon="comment-dots"
            onClick={() => act('languages')}
          >
            语言
          </Button>
        </Flex>
      </Section>

      <Section title="状态标志">
        <Stack wrap>
          {Object.keys(glob_status_flags).map((flag) => {
            let isActive;
            if (flag === 'Godmode') {
              isActive = data.godmode;
            } else {
              isActive = mob_status_flags & glob_status_flags[flag];
            }
            return (
              <Button.Checkbox
                key={flag}
                checked={isActive}
                color={isActive ? 'green' : 'red'}
                onClick={() =>
                  act('toggle_status_flag', {
                    flag: glob_status_flags[flag],
                    enabled: !isActive,
                  })
                }
              >
                {flag === 'Godmode' ? '无敌模式' : flag}
              </Button.Checkbox>
            );
          })}
        </Stack>
      </Section>

      <Section
        title="肢体"
        buttons={
          <Stack>
            {limbs.map((val, index) => (
              <Button.Checkbox
                key={index}
                checked={delimbOption & limb_flags[index]}
                disabled={!mob_type.includes('/mob/living/carbon/human')}
                onClick={() =>
                  setDelimbOption(
                    delimbOption & limb_flags[index]
                      ? delimbOption & ~limb_flags[index]
                      : delimbOption | limb_flags[index],
                  )
                }
              >
                {val}
              </Button.Checkbox>
            ))}
          </Stack>
        }
      >
        <Stack>
          <Button.Confirm
            width="100%"
            icon="unlink"
            color="red"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() =>
              act('limb', {
                limbs: limb_flags.map(
                  (val, index) =>
                    !!(delimbOption & val) && glob_limbs[limbs[index]],
                ),
                delimb_mode: true,
              })
            }
          >
            移除肢体
          </Button.Confirm>
          <Button.Confirm
            width="100%"
            icon="link"
            color="green"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() =>
              act('limb', {
                limbs: limb_flags.map(
                  (val, index) =>
                    !!(delimbOption & val) && glob_limbs[limbs[index]],
                ),
              })
            }
          >
            恢复肢体
          </Button.Confirm>
        </Stack>
      </Section>

      <Section
        title="缩放"
        buttons={
          <Button
            icon="sync"
            onClick={() => {
              act('scale', { new_scale: 1 });
            }}
          >
            重置
          </Button>
        }
      >
        <Slider
          minValue={0.25}
          maxValue={8}
          value={mob_scale}
          stepPixelSize={12}
          step={0.25}
          onChange={(_event, value: number) => {
            act('scale', { new_scale: value });
          }}
          unit="x"
        />
      </Section>

      <Section
        title="速度"
        buttons={
          <Button
            icon="sync"
            onClick={() => {
              act('reset_speed');
            }}
          >
            重置
          </Button>
        }
      >
        <Tooltip
          content="负值加快，正值减慢"
          position="bottom"
        >
          <Box
            mb={1}
            color="label"
            style={{
              borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
              display: 'inline-block',
              cursor: 'help',
            }}
          >
            当前速度：{mob_speed}
          </Box>
        </Tooltip>
        <Slider
          minValue={-10}
          maxValue={10}
          value={mob_speed}
          stepPixelSize={6}
          step={0.25}
          onChange={(_event, value: number) => {
            act('set_speed', { speed: value });
          }}
          unit="速度"
        />
      </Section>

      <Section title="发言">
        <Stack mt={1}>
          <Stack.Item width="100px" color="label">
            强制说话：
          </Stack.Item>
          <Stack.Item grow={1}>
            <Input
              width="100%"
              onEnter={(value) => act('force_say', { to_say: value })}
            />
          </Stack.Item>
        </Stack>
        <Stack mt={2}>
          <Stack.Item width="100px" color="label">
            强制表情动作：
          </Stack.Item>
          <Stack.Item grow={1}>
            <Input
              width="100%"
              onEnter={(value) => act('force_emote', { to_emote: value })}
            />
          </Stack.Item>
        </Stack>
      </Section>

      <Section title="阵营">
        <Stack vertical>
          <Stack.Item>
            <Stack>
              <Stack.Item width="100px" color="label">
                当前：
              </Stack.Item>
              <Stack.Item grow={1}>
                {current_faction && current_faction.length > 0 ? (
                  <Stack wrap>
                    {current_faction.map((faction, index) => (
                      <Button
                        key={index}
                        color="orange"
                        icon="times"
                        tooltip="点击移除阵营"
                        onClick={() => act('remove_faction', { faction })}
                      >
                        {factionDisplay(faction)}
                      </Button>
                    ))}
                  </Stack>
                ) : (
                  <Box color="label">无阵营</Box>
                )}
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <Stack>
              <Stack.Item width="100px" color="label">
                添加：
              </Stack.Item>
              <Stack.Item grow={1}>
                <Dropdown
                  width="100%"
                  placeholder="选择要添加的阵营"
                  options={factionOptions(glob_factions)}
                  selected={null}
                  onSelected={(value) => act('add_faction', { faction: value })}
                />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Section>
    </Section>
  );
};

const TransformActions = () => {
  const { act, data } = useBackend<Data>();
  const { transformables, mob_type } = data;
  return (
    <Section>
      <Button
        width="100%"
        py=".5rem"
        textAlign="center"
        onClick={() => act('transform', { newType: '/mob/living' })}
      >
        自定义
      </Button>

      {transformables.map((transformables_category) => {
        return (
          <Section title={transformables_category.name} key={0}>
            <Flex wrap="wrap" justify="space-between">
              {transformables_category.types.map((transformables_type) => {
                return (
                  <Flex.Item key={0} width="calc(33.3% - .125rem)" mb=".25rem">
                    <Button.Confirm
                      width="100%"
                      height="100%"
                      color={transformables_category.color}
                      disabled={mob_type === transformables_type.key}
                      onClick={() =>
                        act('transform', {
                          newType: transformables_type.key,
                          newTypeName: transformables_type.name,
                        })
                      }
                    >
                      {transformables_type.name}
                    </Button.Confirm>
                  </Flex.Item>
                );
              })}
            </Flex>
          </Section>
        );
      })}
    </Section>
  );
};

const PunishmentActions = () => {
  const { act, data } = useBackend<Data>();
  const {
    client_ckey,
    last_ckey,
    mob_type,
    is_frozen,
    is_slept,
    glob_mute_bits,
    client_muted,
    data_related_cid,
    data_related_ip,
    data_byond_version,
    data_player_join_date,
    data_account_join_date,
    data_old_names,
    discord_id,
    current_time,
  } = data;

  // Check if we have any key (current client or last known)
  const hasAnyKey = !!(client_ckey || last_ckey);

  return (
    <Section>
      <Flex>
        <Button
          width="100%"
          py=".5rem"
          icon="clipboard-list"
          color="orange"
          textAlign="center"
          disabled={!hasAnyKey}
          onClick={() => act('notes')}
        >
          备注
        </Button>
      </Flex>
      <Section title="限制行动">
        <Flex>
          <Button
            width="100%"
            color={is_frozen ? 'orange' : ''}
            icon={is_frozen ? 'check-square-o' : 'square-o'}
            disabled={!mob_type.includes('/mob/living')}
            onClick={() => act('freeze')}
          >
            冻结
          </Button>
          <Button
            width="100%"
            color={is_slept ? 'orange' : ''}
            icon={is_slept ? 'check-square-o' : 'square-o'}
            disabled={!mob_type.includes('/mob/living')}
            onClick={() => act('sleep')}
          >
            睡眠
          </Button>
          <Button.Confirm
            width="100%"
            height="100%"
            icon="share"
            color="bad"
            disabled={!mob_type.includes('/mob/living')}
            onClick={() => act('prison')}
          >
            管理员监狱
          </Button.Confirm>
        </Flex>
      </Section>

      <Section title="封禁处理">
        <Flex>
          <Button.Confirm
            width="100%"
            icon="ban"
            color="red"
            disabled={!client_ckey}
            onClick={() => act('kick')}
          >
            踢出
          </Button.Confirm>
          <Button
            width="100%"
            icon="gavel"
            color="red"
            disabled={!hasAnyKey}
            onClick={() => act('ban')}
          >
            封禁
          </Button>
          <Button.Confirm
            width="100%"
            height="100%"
            icon="gavel"
            color="red"
            disabled={!hasAnyKey}
            onClick={() => act('sticky_ban')}
          >
            关联封禁
          </Button.Confirm>
        </Flex>
      </Section>

      <Section
        title="禁言"
        buttons={
          <>
            <Button
              icon="lock-open"
              color="green"
              disabled={!client_ckey}
              onClick={() => act('unmute_all')}
            >
              全部解除禁言
            </Button>
            <Button
              icon="lock"
              color="red"
              disabled={!client_ckey}
              onClick={() => act('mute_all')}
            >
              全部禁言
            </Button>
          </>
        }
      >
        <Flex>
          {glob_mute_bits.map((bit, i) => {
            const isMuted = client_muted && client_muted & bit.bitflag;
            return (
              <Button
                key={i}
                width="100%"
                height="100%"
                icon={isMuted ? 'check-square-o' : 'square-o'}
                color={isMuted ? 'bad' : ''}
                disabled={!client_ckey}
                onClick={() =>
                  act('mute', {
                    mute_flag: !isMuted
                      ? client_muted | bit.bitflag
                      : client_muted & ~bit.bitflag,
                  })
                }
              >
                {bit.name}
              </Button>
            );
          })}
        </Flex>
      </Section>
      <Section
        title="调查"
        buttons={
          <Flex>
            <Flex.Item align="center" mr=".5rem" color="label">
              按以下信息查找关联账户：
            </Flex.Item>
            <Button
              minWidth="5rem"
              color="orange"
              textAlign="center"
              mr=".5rem"
              disabled={!data_related_cid}
              onClick={() => act('related_accounts', { related_thing: 'CID' })}
            >
              CID
            </Button>
            <Button
              minWidth="5rem"
              color="orange"
              textAlign="center"
              height="100%"
              disabled={!data_related_ip}
              onClick={() => act('related_accounts', { related_thing: 'IP' })}
            >
              IP
            </Button>
          </Flex>
        }
      >
        <Collapsible width="100%" color="orange" title="详情">
          <LabeledList>
            <LabeledList.Item label="当前时间" color="label">
              {current_time}
            </LabeledList.Item>
            <LabeledList.Item label="账户创建时间">
              {data_account_join_date}
            </LabeledList.Item>
            <LabeledList.Item label="首次加入服务器">
              {data_player_join_date}
            </LabeledList.Item>
            <LabeledList.Item label="BYOND 版本">
              {data_byond_version}
            </LabeledList.Item>
            <LabeledList.Item label="曾用名">
              {data_old_names}
            </LabeledList.Item>
            <LabeledList.Item label="Discord">
              {discord_id &&
              discord_id !== 'Not found' &&
              discord_id !== 'Database error' &&
              discord_id !== 'No ckey found' ? (
                <Box color="good">{`<@${discord_id}>`}</Box>
              ) : discord_id === 'Not found' ? (
                <Box color="bad">未找到 Discord ID</Box>
              ) : discord_id === 'Database error' ? (
                <Box color="bad">数据库错误</Box>
              ) : discord_id === 'No ckey found' ? (
                <Box color="bad">未找到 ckey</Box>
              ) : (
                <Button
                  icon="discord"
                  color="purple"
                  compact
                  disabled={!hasAnyKey}
                  onClick={() => act('show_discord_id')}
                >
                  获取 ID
                </Button>
              )}
            </LabeledList.Item>
          </LabeledList>
        </Collapsible>
      </Section>
    </Section>
  );
};

const FunActions = () => {
  const { act } = useBackend<Data>();

  const colours = {
    White: '#a4bad6',
    Dark: '#42474D',
    Red: '#c51e1e',
    'Red Bright': '#FF0000',
    Velvet: '#660015',
    Green: '#059223',
    Blue: '#6685f5',
    Purple: '#800080',
    'Purple Dark': '#5000A0',
    Narsie: '#973e3b',
    Ratvar: '#BE8700',
  };

  const [lockExplode, setLockExplode] = useState(true);
  const [empMode, setEmpMode] = useState(false);
  const [expPower, setExpPower] = useState(8);
  const [narrateSize, setNarrateSize] = useState(1);
  const [narrateMessage, setNarrateMessage] = useState('');
  const [narrateColour, setNarrateColour] = useState(Object.keys(colours)[0]);
  const [narrateFont, setNarrateFont] = useState('Verdana');
  const [narrateBold, setNarrateBold] = useState(false);
  const [narrateItalic, setNarrateItalic] = useState(false);
  const [narrateGlobal, setNarrateGlobal] = useState(false);
  const [narrateRange, setNarrateRange] = useState(7);

  const narrateStyles = {
    color: colours[narrateColour],
    'font-size': `${narrateSize}rem`,
    'font-weight': narrateBold ? 'bold' : '',
    'font-family': narrateFont,
    'font-style': narrateItalic ? 'italic' : '',
  };

  return (
    <Section fill>
      <NoticeBox info textAlign="center">
        这些功能以你的视图中心为作用中心
      </NoticeBox>

      <Section
        title="爆炸"
        buttons={
          <>
            <Button.Checkbox
              checked={empMode}
              color="transparent"
              onClick={() => setEmpMode(!empMode)}
            >
              电磁脉冲模式
            </Button.Checkbox>
            <Button
              icon={lockExplode ? 'lock' : 'lock-open'}
              onClick={() => setLockExplode(!lockExplode)}
              color={lockExplode ? 'green' : 'bad'}
            >
              {lockExplode ? '已锁定' : '已解锁'}
            </Button>
          </>
        }
      >
        <Flex align="right" grow={1} mt={1}>
          <Flex.Item>
            <Button
              width="100%"
              height="100%"
              color="red"
              disabled={lockExplode}
              onClick={() =>
                act('explode', { power: expPower, emp_mode: empMode })
              }
            >
              <Box height="100%" pt={2} pb={2} textAlign="center">
                引爆
              </Box>
            </Button>
          </Flex.Item>
          <Flex.Item ml={1} grow={1}>
            <Slider
              unit="范围"
              value={expPower}
              stepPixelSize={15}
              onChange={(e, value) => setExpPower(value)}
              ranges={{
                green: [0, 8],
                orange: [8, 15],
                red: [15, 30],
              }}
              minValue={1}
              maxValue={30}
              height="100%"
            />
          </Flex.Item>
        </Flex>
      </Section>
      <Section
        title="旁白"
        buttons={
          <Button
            icon={narrateGlobal ? 'check-square-o' : 'square-o'}
            color={narrateGlobal ? 'red' : 'transparent'}
            onClick={() => setNarrateGlobal(!narrateGlobal)}
          >
            全局旁白
          </Button>
        }
      >
        <Flex width="100%">
          <Flex width="100%" wrap>
            <Flex.Item width="52%">
              <LabeledList>
                <LabeledList.Item label="颜色">
                  <Dropdown
                    width="calc(100% - 1rem)"
                    options={narrateColourOptions(Object.keys(colours))}
                    selected={narrateColour} displayText={narrateColourDisplay(narrateColour)}
                    onSelected={(value) => setNarrateColour(value)}
                  />
                </LabeledList.Item>
                <LabeledList.Item label="字体">
                  <Dropdown
                    width="calc(100% - 1rem)"
                    selected={narrateFont}
                    options={[
                      'Verdana',
                      'Consolas',
                      'Trebuchet MS',
                      'Comic Sans MS',
                      'Times New Roman',
                    ]}
                    onSelected={(value) => setNarrateFont(value)}
                  />
                </LabeledList.Item>
              </LabeledList>
            </Flex.Item>
            <Flex.Item width="20%">
              <LabeledList>
                <LabeledList.Item label="粗体">
                  <Button.Checkbox
                    checked={narrateBold}
                    height="100%"
                    color="transparent"
                    onClick={() => setNarrateBold(!narrateBold)}
                  />
                </LabeledList.Item>
                <LabeledList.Item label="斜体">
                  <Button.Checkbox
                    checked={narrateItalic}
                    height="100%"
                    color="transparent"
                    onClick={() => setNarrateItalic(!narrateItalic)}
                  />
                </LabeledList.Item>
              </LabeledList>
            </Flex.Item>
            <Flex.Item width="28%">
              <LabeledList>
                <LabeledList.Item label="大小">
                  <NumberInput
                    width="100%"
                    value={narrateSize}
                    minValue={1}
                    maxValue={6}
                    unit="rem"
                    // align="center"
                    step={1}
                    stepPixelSize={25}
                    onChange={(value) => setNarrateSize(value)}
                  />
                </LabeledList.Item>
                {!narrateGlobal && (
                  <LabeledList.Item label="范围">
                    <NumberInput
                      width="100%"
                      value={narrateRange}
                      minValue={1}
                      maxValue={14}
                      unit="格"
                      step={1}
                      // align="center"
                      stepPixelSize={25}
                      onChange={(value) => setNarrateRange(value)}
                    />
                  </LabeledList.Item>
                )}
              </LabeledList>
            </Flex.Item>
          </Flex>
        </Flex>

        <Flex mt="1rem">
          <Flex.Item width="100%" mr="1rem">
            <Input
              width="100%"
              my=".5rem"
              onChange={(value) => setNarrateMessage(value)}
            />
          </Flex.Item>

          <Button
            color="green"
            p=".5rem"
            textAlign="center"
            disabled={!narrateMessage}
            onClick={() =>
              act('narrate', {
                message: narrateMessage,
                classes: narrateStyles,
                range: narrateRange,
                mode_global: narrateGlobal,
              })
            }
          >
            广播
          </Button>
        </Flex>

        <Box
          style={narrateStyles}
          mt="1rem"
          pl=".5rem"
          width="37rem"
          maxWidth="37rem"
        >
          {narrateMessage}
        </Box>
      </Section>
    </Section>
  );
};

const OtherActions = () => {
  const { act, data } = useBackend<Data>();
  const { mob_type, client_ckey } = data;

  return (
    <Section fill>
      <Section title="其他功能">
        <Button
          width="100%"
          p=".5rem"
          mb=".5rem"
          textAlign="center"
          disabled={!client_ckey}
          onClick={() => act('job_exemption_panel')}
        >
          职位限制豁免面板
        </Button>
        <Button
          width="100%"
          p=".5rem"
          mb=".5rem"
          textAlign="center"
          disabled={!client_ckey}
          onClick={() => act('commend')}
        >
          表彰行为
        </Button>
        <Button
          width="100%"
          p=".5rem"
          mb=".5rem"
          textAlign="center"
          disabled={!client_ckey}
          onClick={() => act('play_sound_to')}
        >
          向玩家播放声音
        </Button>
        <Button
          width="100%"
          p=".5rem"
          mb=".5rem"
          textAlign="center"
          disabled={!mob_type.includes('/mob/living/silicon/robot')}
          onClick={() => act('borg_panel')}
        >
          机器人面板
        </Button>
      </Section>
    </Section>
  );
};
