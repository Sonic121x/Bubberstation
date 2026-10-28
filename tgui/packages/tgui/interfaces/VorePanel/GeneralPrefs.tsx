import { useBackend } from 'tgui/backend';
import { Button, Flex, Section } from 'tgui-core/components';

import type * as types from './types';

export const Preferences = (props) => {
  const { data } = useBackend<types.Data>();
  const { preferences } = data;

  return (
    <Section title="吞食偏好">
      <Flex wrap>
        {Object.entries(preferences).map(([key, value]) => {
          const data = PREF_TYPE_MAP[key];
          if (data) {
            return (
              <Flex.Item basis="33%" key={key}>
                {data.component({ key, name: data.name, value })}
              </Flex.Item>
            );
          } else {
            return (
              <Flex.Item key={key} basis="33%">
                未知偏好：{key}
              </Flex.Item>
            );
          }
        })}
      </Flex>
    </Section>
  );
};

export const PrefTrinary = (props: {
  key: string;
  name: string;
  value: number;
}) => {
  const { act } = useBackend();
  const { key, name, value } = props;

  return (
    <Button
      fluid
      icon={value === 2 ? 'star' : value === 1 ? 'star-half-alt' : 'star-o'}
      textAlign="center"
      tooltipPosition="bottom"
      onClick={() => act('set_pref', { key, value: (value + 1) % 3 })}
      selected={value === 2}
      tooltip={
        value === 2
          ? '你将自动接受此类吞食互动'
          : value === 1
            ? '每次发生此类吞食互动时，都会询问你是否同意'
            : '你将自动拒绝此类吞食互动'
      }
    >
      {name} - {value === 2 ? '总是' : value === 1 ? '询问' : '从不'}
    </Button>
  );
};

export const PrefBinary = (props: {
  key: string;
  name: string;
  value: number;
}) => {
  const { act } = useBackend();
  const { key, name, value } = props;

  return (
    <Button
      fluid
      icon={value ? 'toggle-on' : 'toggle-off'}
      textAlign="center"
      tooltipPosition="bottom"
      onClick={() => act('set_pref', { key, value: !value })}
      tooltip={value ? '已启用' : '已禁用'}
      selected={value}
    >
      {name} - {value ? '已启用' : '已禁用'}
    </Button>
  );
};

export const PREF_TYPE_MAP = {
  prey_toggle: { component: PrefTrinary, name: '作为猎物' },
  pred_toggle: { component: PrefTrinary, name: '作为捕食者' },
  eating_noises: { component: PrefBinary, name: '进食音效' },
  digestion_noises: { component: PrefBinary, name: '消化音效' },
  belch_noises: { component: PrefBinary, name: '打嗝音效' },
  digestion_allowed: { component: PrefBinary, name: '承受消化伤害' },
  qdel_allowed: { component: PrefBinary, name: '消化后删除身体' },
  absorb_allowed: { component: PrefBinary, name: '允许吸收' },
  fullscreen_overlays_allowed: {
    component: PrefBinary,
    name: '全屏叠加效果',
  },
};
