import { Box, Button, Divider, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { machineStatusDisplay } from '../localization/machineStatusDisplay';
type Data = {
  area_notice: string;
  area_name: string;
  area_allows_shuttle_docking: boolean;
  wire_data: WireData[];
  legend: string;
  legend_viewing_list: string;
  legend_off: string;
  fluff_notice: string;
  station_name: string;
  wires_name: string;
  wire_devices: WireDevices[];
  viewing: BooleanLike;
};

type WireDevices = {
  name: string;
  ref: string;
};

type WireData = {
  color: string;
  message: string;
};

export const Blueprints = () => {
  const { act, data } = useBackend<Data>();
  const { legend, legend_viewing_list, legend_off } = data;

  return (
    <Window width={450} height={340}>
      <Window.Content scrollable>
        {legend === legend_viewing_list ? (
          <WireList />
        ) : legend === legend_off ? (
          <MainMenu />
        ) : (
          <WireArea />
        )}
      </Window.Content>
    </Window>
  );
};

const WireList = () => {
  const { act, data } = useBackend<Data>();
  const { wire_devices = [] } = data;

  return (
    <Section>
      <Button fluid icon="chevron-left" onClick={() => act('exit_legend')}>
        返回
      </Button>
      <Stack fill wrap g={0.5} mt={1}>
        {wire_devices.map((wire) => (
          <Stack.Item key={wire.ref} grow basis={10}>
            <Button
              fluid
              ellipsis
              onClick={() =>
                act('view_wireset', {
                  view_wireset: wire.ref,
                })
              }
            >
              {wire.name}
            </Button>
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};

const WireArea = () => {
  const { act, data } = useBackend<Data>();
  const { wires_name, wire_data = [] } = data;

  return (
    <Section>
      <Button fluid icon="chevron-left" onClick={() => act('view_legend')}>
        返回
      </Button>
      <Box bold>{wires_name}的电线：</Box>
      {wire_data.map((wire) => (
        <Box ml={1} m={1} key={wire.message}>
          <span style={{ color: wire.color }}>{machineStatusDisplay(wire.color)}</span>：{' '}
          {wire.message}
        </Box>
      ))}
    </Section>
  );
};

const MainMenu = () => {
  const { act, data } = useBackend<Data>();
  const {
    area_notice,
    area_name,
    area_allows_shuttle_docking,
    fluff_notice,
    station_name,
    viewing,
  } = data;

  const buttonProps = {
    fluid: true,
    textAlign: 'center',
    py: 0.75,
  };

  return (
    <Section title={`${station_name}蓝图`}>
      <Box italic fontSize={0.9}>
        {fluff_notice}
      </Box>
      <Divider />
      <Box bold m={1.5} textAlign="center">
        {area_notice}
      </Box>
      <Stack fill vertical>
        <Stack.Item>
          <Button
            {...buttonProps}
            icon="pencil"
            onClick={() => act('create_area')}
          >
            创建或修改现有区域
          </Button>
        </Stack.Item>
        <Stack.Item>
          <Button {...buttonProps} icon="font" onClick={() => act('edit_area')}>
            更改区域名称
          </Button>
        </Stack.Item>
        <Stack.Item>
          <Button
            {...buttonProps}
            icon={area_allows_shuttle_docking ? 'toggle-on' : 'toggle-off'}
            iconPosition="right"
            onClick={() => act('toggle_allow_shuttle_docking')}
          >
            允许穿梭机停靠
          </Button>
        </Stack.Item>
        <Stack.Item>
          <Button
            {...buttonProps}
            icon="chevron-right"
            onClick={() => act('view_legend')}
          >
            查看电线颜色图例
          </Button>
        </Stack.Item>
        <Stack.Item>
          <Stack fill>
            <Stack.Item grow>
              <Button
                {...buttonProps}
                icon="wrench"
                color={!!viewing && 'red'}
                onClick={() =>
                  act(viewing ? 'hide_blueprints' : 'view_blueprints')
                }
              >
                {viewing ? '隐藏' : '查看'}结构数据
              </Button>
            </Stack.Item>
            {!!viewing && (
              <Stack.Item>
                <Button
                  {...buttonProps}
                  p={0.75}
                  icon="refresh"
                  tooltip="刷新结构数据"
                  onClick={() => act('refresh')}
                />
              </Stack.Item>
            )}
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
