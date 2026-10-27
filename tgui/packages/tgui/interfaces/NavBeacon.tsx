import {
  Box,
  Button,
  Dropdown,
  LabeledList,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';
import { chineseDisplay, chineseDropdownOptions } from '../localization/zhDisplay';
export type Data = {
  locked: BooleanLike;
  siliconUser: BooleanLike;
  controls: NavBeaconControl;
  static_controls: NavBeaconStaticControl;
};

export type NavBeaconControl = {
  location: string;
  patrol_enabled: BooleanLike;
  patrol_next: string;
  delivery_enabled: BooleanLike;
  delivery_direction: string;
  cover_locked: BooleanLike;
};

export type DisabledProps = {
  disabled: BooleanLike;
};

export type NavBeaconStaticControl = {
  direction_options: string[];
  has_codes: BooleanLike;
};

export const NavBeacon = (props) => {
  const { act, data } = useBackend();
  return (
    <Window title="导航信标" width={400} height={350}>
      <Window.Content>
        <NavBeaconContent />
      </Window.Content>
    </Window>
  );
};

export const NavBeaconContent = (props) => {
  const { act, data } = useBackend<Data>();
  const { controls, static_controls } = data;
  const disabled = data.locked && !data.siliconUser;
  return (
    <Stack vertical fill>
      <InterfaceLockNoticeBox />
      <NavBeaconControlSection disabled={disabled} />
      <NavBeaconMaintenanceSection disabled={disabled} />
    </Stack>
  );
};

export const NavBeaconControlSection = (props: DisabledProps) => {
  const { act, data } = useBackend<Data>();
  const { controls, static_controls } = data;
  return (
    <Section title="控制">
      <LabeledList>
        <LabeledList.Item label="位置">
          <Button
            fluid
            content={controls.location ?? '未设置'}
            icon="pencil-alt"
            disabled={props.disabled}
            onClick={() => act('set_location')}
          />
        </LabeledList.Item>
        <LabeledList.Item label="启用巡逻信标">
          <Button.Checkbox
            fluid
            checked={controls.patrol_enabled}
            content={controls.patrol_enabled ? '已启用' : '已禁用'}
            disabled={props.disabled}
            onClick={() => act('toggle_patrol')}
          />
        </LabeledList.Item>
        <LabeledList.Item label="下一巡逻点">
          <Button
            fluid
            content={controls.patrol_next ?? '无下一巡逻点'}
            icon="pencil-alt"
            disabled={props.disabled}
            onClick={() => act('set_patrol_next')}
          />
        </LabeledList.Item>
        <LabeledList.Item label="启用配送信标">
          <Button.Checkbox
            fluid
            checked={controls.delivery_enabled}
            content={controls.delivery_enabled ? '已启用' : '已禁用'}
            disabled={props.disabled}
            onClick={() => act('toggle_delivery')}
          />
        </LabeledList.Item>
        <LabeledList.Item label="配送方向">
          <Dropdown
            disabled={!!props.disabled}
            options={chineseDropdownOptions(static_controls.direction_options)}
            selected={controls.delivery_direction} displayText={chineseDisplay(controls.delivery_direction)}
            onSelected={(value) =>
              act('set_delivery_direction', {
                direction: value,
              })
            }
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

export const NavBeaconMaintenanceSection = (props: DisabledProps) => {
  const { act, data } = useBackend<Data>();
  const { controls, static_controls } = data;
  return (
    <Section title="维护">
      <LabeledList>
        <LabeledList.Item label="重置代码">
          {!!static_controls.has_codes && (
            <Button
              fluid
              content={'重置'}
              icon="power-off"
              disabled={props.disabled}
              onClick={() => act('reset_codes')}
            />
          )}
          {!static_controls.has_codes && <Box>未找到备份代码</Box>}
        </LabeledList.Item>
        <LabeledList.Item label="维护舱盖">
          <Button.Checkbox
            fluid
            checked={controls.cover_locked}
            content={controls.cover_locked ? '已锁定' : '已解锁'}
            disabled={props.disabled}
            onClick={() => act('toggle_cover')}
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
