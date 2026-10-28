import { useBackend } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';
import {
  type FeatureChoiced,
  type FeatureChoicedServerData,
  type FeatureNumeric,
  FeatureSliderInput,
  type FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

const FeatureBlooperDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) => {
  const { act } = useBackend();

  return (
    <Stack>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_blooper');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const blooper_choice: FeatureChoiced = {
  name: '角色声音',
  component: FeatureBlooperDropdownInput,
};

export const blooper_speed: FeatureNumeric = {
  name: '角色语速（%）',
  description: '数值越低，语速越慢；数值越高，语速越快。',
  component: FeatureSliderInput,
};

export const blooper_pitch: FeatureNumeric = {
  name: '角色音高（%）',
  description: '数值越低，声音越低沉；数值越高，音调越高。',
  component: FeatureSliderInput,
};

export const blooper_pitch_range: FeatureNumeric = {
  name: '角色音域（%）',
  description:
    '数值越低，音调变化范围越窄；数值越高，变化范围越宽。',
  component: FeatureSliderInput,
};
