import { Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { REVERSE_OPTIONS } from './constants';
import { useTab } from './hooks';
import type { PodLauncherData } from './types';

export function ReverseMenu(props) {
  const { act, data } = useBackend<PodLauncherData>();
  const {
    customDropoff,
    effectReverse,
    picking_dropoff_turf,
    reverse_option_list,
  } = data;

  const [tab, setTab] = useTab();

  return (
    <Section
      buttons={
        <Button
          icon={effectReverse ? 'toggle-on' : 'toggle-off'}
          onClick={() => {
            act('effectReverse');
            if (tab === 2) {
              setTab(1);
              act('tabSwitch', { tabIndex: 1 });
            }
          }}
          selected={effectReverse}
          tooltip={`
            不发送物品。
            着陆后返回
            卸货地格（未指定时
            返回装载区）。`}
          tooltipPosition="bottom"
        />
      }
      fill
      title="回收模式"
    >
      {!!effectReverse && (
        <Stack fill vertical>
          <Stack.Item maxHeight="20px">
            <Button
              disabled={!effectReverse}
              onClick={() => act('pickDropoffTurf')}
              selected={picking_dropoff_turf}
              tooltip={`
                回收舱着陆后
                前往的地点`}
              tooltipPosition="bottom-end"
            >
              卸货地格
            </Button>
            <Button
              disabled={!customDropoff}
              icon="trash"
              inline
              onClick={() => {
                act('clearDropoffTurf');
                if (tab === 2) {
                  setTab(1);
                  act('tabSwitch', { tabIndex: 1 });
                }
              }}
              tooltip={`
                清除自定义
                卸货地点。回收舱
                将改为在
                所选装载区卸货。`}
              tooltipPosition="bottom"
            />
          </Stack.Item>
          <Stack.Divider />
          <Stack.Item maxHeight="20px">
            {REVERSE_OPTIONS.map((option, i) => (
              <Button
                disabled={!effectReverse}
                key={i}
                icon={option.icon}
                inline
                onClick={() =>
                  act('reverseOption', {
                    reverseOption: option.key || option.title,
                  })
                }
                selected={
                  option.key
                    ? reverse_option_list[option.key]
                    : reverse_option_list[option.title]
                }
                tooltip={option.title}
              />
            ))}
          </Stack.Item>
        </Stack>
      )}
    </Section>
  );
}
