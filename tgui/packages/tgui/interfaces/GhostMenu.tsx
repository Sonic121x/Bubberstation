import {
  Button,
  Dropdown,
  ImageButton,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { chineseDisplay, chineseDropdownOptions } from '../localization/zhDisplay';
type Data = {
  can_boo: BooleanLike;
  hud_info: HudInfo[];
  has_fun: BooleanLike;
  lag_switch_on: BooleanLike;
  notification_data: NotificationData[];
  max_extra_view: number;
  current_extra_view: number;
  body_name: string;
  current_darkness: string;
  darkness_levels: string[];
};

type HudInfo = {
  name: string;
  enabled: BooleanLike;
  flag: string;
  tooltip: string;
};

type NotificationData = {
  key: string;
  enabled: BooleanLike;
  desc: string;
};

export const GhostMenu = (props) => {
  const { act, data } = useBackend<Data>();
  const { has_fun, can_boo } = data;
  return (
    <Window
      title="幽灵菜单"
      width={500}
      height={630}
      buttons={
        !!has_fun && (
          <>
            <Button
              disabled={!can_boo}
              tooltip="惊吓附近的事物，有冷却时间。"
              onClick={() => act('boo')}
            >
              吓！
            </Button>
            <Button
              tooltip="允许你附身于任何没有自主意识的生物。"
              onClick={() => act('possess')}
            >
              附身
            </Button>
          </>
        )
      }
    >
      <Window.Content>
        <Stack fill>
          <Stack.Item width="40%">
            <Section title="玩家与回合信息">
              <RoundSection />
            </Section>
            <Section title="抬头显示">
              <HudSection />
            </Section>
            <Section title="幽灵设置">
              <GhostSettingsSection />
            </Section>
          </Stack.Item>
          <Stack.Item width="60%">
            <NotificationPreferences />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const RoundSection = (props) => {
  const { act, data } = useBackend<Data>();
  const { body_name } = data;
  return (
    <>
      {!!body_name && (
        <ImageButton
          fluid
          dmIcon="icons/mob/simple/mob.dmi"
          dmIconState="ghost"
          tooltip="点击以返回你的身体。"
          onClick={() => act('return_to_body')}
          fontSize="11px"
          buttons={
            <Button.Confirm
              icon="ghost"
              tooltip="永久离开你的身体，此后无法再被复苏。"
              onClick={() => act('DNR')}
            />
          }
        >
          返回{body_name}的身体
        </ImageButton>
      )}
      <ImageButton
        fluid
        dmIcon="icons/obj/machines/wallmounts.dmi"
        dmIconState="newscaster_off"
        onClick={() => act('crew_manifest')}
        fontSize="11px"
      >
        查看船员名单
      </ImageButton>
      <ImageButton
        fluid
        dmIcon="icons/obj/aicards.dmi"
        dmIconState="pai"
        onClick={() => act('signup_pai')}
        fontSize="11px"
      >
        报名成为个人AI
      </ImageButton>
    </>
  );
};

const HudSection = (props) => {
  const { act, data } = useBackend<Data>();
  const { hud_info, lag_switch_on } = data;
  return (
    <Stack vertical>
      {hud_info.map((individual_hud) => (
        <Stack.Item key={individual_hud.name}>
          <Button
            fluid
            icon={individual_hud.enabled ? 'check' : 'times'}
            color={individual_hud.enabled ? 'good' : 'bad'}
            tooltip={individual_hud.tooltip}
            onClick={() =>
              act('toggle_visibility', { toggling: individual_hud.flag })
            }
          >
            {individual_hud.name}
          </Button>
        </Stack.Item>
      ))}
      {!lag_switch_on && (
        <Button
          tooltip="对你所在的位置进行T射线扫描。"
          onClick={() => act('tray_scan')}
        >
          T射线扫描
        </Button>
      )}
    </Stack>
  );
};

const GhostSettingsSection = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    current_darkness,
    darkness_levels,
    max_extra_view,
    current_extra_view,
    lag_switch_on,
  } = data;
  return (
    <Stack vertical>
      <Stack.Item>
        <Dropdown
          options={chineseDropdownOptions(darkness_levels)}
          selected={current_darkness} displayText={chineseDisplay(current_darkness)}
          onSelected={(value) =>
            act('darkness', {
              darkness_level: value,
            })
          }
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          fluid
          tooltip="将幽灵角色的外观与名称恢复为角色偏好设置中的内容。"
          onClick={() => act('restore_appearance')}
        >
          恢复幽灵角色
        </Button>
      </Stack.Item>
      {!lag_switch_on && (
        <Stack.Item mx={1}>
          额外视距：
          <NumberInput
            width="30px"
            step={1}
            value={current_extra_view}
            minValue={0}
            maxValue={max_extra_view}
            onChange={(new_range) =>
              act('view_range', {
                new_view_range: new_range,
              })
            }
          />
        </Stack.Item>
      )}
    </Stack>
  );
};

const NotificationPreferences = (props) => {
  const { act, data } = useBackend<Data>();
  const { notification_data } = data;
  if (!notification_data) {
    return '无通知！';
  }

  const ignores = notification_data.sort((a, b) => {
    const descA = a.desc.toLowerCase();
    const descB = b.desc.toLowerCase();
    if (descA < descB) {
      return -1;
    }
    if (descA > descB) {
      return 1;
    }
    return 0;
  });

  return (
    <Section
      scrollable
      fill
      title="幽灵角色通知"
      buttons={
        <>
          <Button
            icon="check"
            color="good"
            tooltip="启用所有通知。"
            onClick={() => act('turn_all_on')}
          />
          <Button
            icon="times"
            color="bad"
            tooltip="禁用所有通知。"
            onClick={() => act('turn_all_off')}
          />
        </>
      }
    >
      {ignores.map((ignore) => (
        <Button
          fluid
          key={ignore.key}
          icon={ignore.enabled ? 'times' : 'check'}
          color={ignore.enabled ? 'bad' : 'good'}
          onClick={() => act('change_notification', { key: ignore.key })}
        >
          {ignore.desc}
        </Button>
      ))}
    </Section>
  );
};
