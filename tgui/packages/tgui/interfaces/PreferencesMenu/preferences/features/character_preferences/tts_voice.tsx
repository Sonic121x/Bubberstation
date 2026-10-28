import { useBackend } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';

import {
  type FeatureChoiced,
  type FeatureChoicedServerData,
  type FeatureNumeric,
  FeatureSliderInput,
  type FeatureValueProps,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

function FeatureTTSDropdownInput(
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) {
  const { act } = useBackend();

  return (
    <Stack>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_voice');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_voice_robot');
          }}
          icon="robot"
          width="100%"
          height="100%"
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_blips');
          }}
          icon="leaf"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
}

export const tts_voice: FeatureChoiced = {
  name: '语音',
  component: FeatureTTSDropdownInput,
};

export const tts_voice_pitch: FeatureNumeric = {
  name: '音调调整',
  component: FeatureSliderInput,
};

export const tts_blip_base: FeatureChoiced = {
  name: '语音短音基础音色',
  component: FeatureDropdownInput,
};

export const tts_blip_number: FeatureNumeric = {
  name: '语音短音变体',
  component: FeatureSliderInput,
};
