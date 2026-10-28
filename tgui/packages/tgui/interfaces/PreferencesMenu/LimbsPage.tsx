// THIS IS A SKYRAT UI FILE
import {
  Box,
  Button,
  ColorBox,
  Dropdown,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { CharacterPreview } from '../common/CharacterPreview';
import type { PreferencesMenuData } from './types';
import { characterOptions, characterDisplay } from '../../localization/zhCharacterDisplay';
export const RotateCharacterButtons = (props) => {
  const { act } = useBackend<PreferencesMenuData>();
  return (
    <Box mt={1}>
      <Button
        onClick={() => act('rotate', { backwards: false })}
        fontSize="22px"
        icon="redo"
        tooltip="顺时针旋转"
        tooltipPosition="bottom"
      />
      <Button
        onClick={() => act('rotate', { backwards: true })}
        fontSize="22px"
        icon="undo"
        tooltip="逆时针旋转"
        tooltipPosition="bottom"
      />
    </Box>
  );
};

export const Markings = (props) => {
  const { act } = useBackend<PreferencesMenuData>();
  return (
    <Stack fill vertical>
      <Stack.Item>斑纹：</Stack.Item>
      {props.limb.markings.markings_list.map((marking, index) => (
        <Stack.Item key={marking.marking_id}>
          <Stack fill>
            <Stack.Item grow>
              <Dropdown
                width="100%"
                options={characterOptions(props.limb.markings.marking_choices)}
                selected={marking.name} displayText={characterDisplay(marking.name)}
                buttons
                onSelected={(shit) =>
                  act('change_marking', {
                    limb_slot: props.limb.slot,
                    marking_id: marking.marking_id,
                    marking_name: shit,
                  })
                }
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                onClick={() =>
                  act('color_marking', {
                    limb_slot: props.limb.slot,
                    marking_id: marking.marking_id,
                  })
                }
              >
                <ColorBox color={marking.color} />
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button
                color={marking.emissive ? 'good' : 'bad'}
                tooltip="切换斑纹是否发光。绿色表示发光，红色表示不发光。"
                onClick={() =>
                  act('change_emissive', {
                    limb_slot: props.limb.slot,
                    marking_id: marking.marking_id,
                    emissive: marking.emissive,
                  })
                }
              >
                光
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button
                color="bad"
                onClick={() =>
                  act('remove_marking', {
                    limb_slot: props.limb.slot,
                    marking_id: marking.marking_id,
                  })
                }
              >
                -
              </Button>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      ))}
      <Stack.Item>
        <Button
          color="good"
          onClick={() => act('add_marking', { limb_slot: props.limb.slot })}
        >
          +
        </Button>
      </Stack.Item>
    </Stack>
  );
};

export const LimbPage = (props) => {
  const { act } = useBackend<PreferencesMenuData>();
  return (
    <div>
      <Section fill title={characterDisplay(props.limb.name)}>
        <Stack vertical fill>
          <Stack.Item>
            <Markings limb={props.limb} />
          </Stack.Item>
        </Stack>
      </Section>
    </div>
  );
};

export const AugmentationPage = (props) => {
  const { act } = useBackend<PreferencesMenuData>();
  const { data } = useBackend<PreferencesMenuData>();
  const balance = -data.quirks_balance;
  if (props.limb.can_augment) {
    return (
      <div style={{ marginBottom: '1.5em' }}>
        <Section fill title={characterDisplay(props.limb.name)}>
          <Stack fill vertical>
            <Stack.Item>
              <Stack fill>
                <Stack.Item>植入体：</Stack.Item>
                <Stack.Item grow>
                  <Dropdown
                    width="100%"
                    options={characterOptions(Object.values(props.limb.aug_choices) as string[])}
                    selected={props.limb.chosen_aug} displayText={characterDisplay(props.limb.chosen_aug)}
                    onSelected={(value) => {
                      // Since the costs are positive,
                      // it's added and not substracted
                      if (balance + props.limb.costs[value] > 0) {
                        return;
                      }
                      act('set_limb_aug', {
                        limb_slot: props.limb.slot,
                        augment_name: value,
                      });
                    }}
                  />
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <Stack fill vertical>
                <Stack.Item>样式：</Stack.Item>
                <Stack.Item grow>
                  <Dropdown
                    width="100%"
                    options={props.data.robotic_styles.map((value) => ({ value, displayText: props.data.robotic_style_labels?.[value] ?? value }))}
                    selected={props.limb.chosen_style} displayText={props.data.robotic_style_labels?.[props.limb.chosen_style] ?? props.limb.chosen_style}
                    onSelected={(value) =>
                      act('set_limb_aug_style', {
                        limb_slot: props.limb.slot,
                        style_name: value,
                      })
                    }
                  />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Section>
      </div>
    );
  }
  return null;
};

export const OrganPage = (props) => {
  const { act } = useBackend<PreferencesMenuData>();
  const { data } = useBackend<PreferencesMenuData>();
  const balance = -data.quirks_balance;
  return (
    <Stack.Item>
      <Stack fill>
        <Stack.Item>{`${characterDisplay(props.organ.name)}：`}</Stack.Item>
        <Stack.Item grow>
          <Dropdown
            width="100%"
            options={characterOptions(Object.values(props.organ.organ_choices) as string[])}
            selected={props.organ.chosen_organ} displayText={characterDisplay(props.organ.chosen_organ)}
            onSelected={(value) => {
              // Since the costs are positive, it's added and not substracted
              if (balance + props.organ.costs[value] > 0) {
                return;
              }
              act('set_organ_aug', {
                organ_slot: props.organ.slot,
                augment_name: value,
              });
            }}
          />
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

export const LimbsPage = (props) => {
  const { data } = useBackend<PreferencesMenuData>();
  const { act } = useBackend<PreferencesMenuData>();
  const markings = data.marking_presets ? data.marking_presets : [];
  const balance = -data.quirks_balance;
  return (
    <Stack minHeight="100%">
      <Stack.Item minWidth="33%" minHeight="100%">
        <Section fill scrollable title="斑纹" height="197%">
          <div>
            <Dropdown
              width="100%"
              options={characterOptions(Object.values(markings) as string[])}
              selected={Object.values(markings)[1]} displayText={characterDisplay(Object.values(markings)[1] as string)}
              placeholder="选择预设："
              onSelected={(value) => act('set_preset', { preset: value })}
            />
          </div>
          <div>
            {data.limbs_data.map((val) => (
              <LimbPage key={val.slot} limb={val} data={data} />
            ))}
          </div>
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section title="角色预览" fill align="center" height="197%">
          <CharacterPreview
            id={data.character_preview_view}
            height="25%"
            width="100%"
          />
          <RotateCharacterButtons />
          <Box
            style={{
              marginTop: '3em',
            }}
          >
            <Section title="特质点数余额" />
          </Box>

          <Box
            backgroundColor="#eee"
            bold
            color="black"
            fontSize="1.2em"
            py={0.5}
            style={{
              width: '20%',
              alignItems: 'center',
            }}
          >
            {balance}
          </Box>
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section fill title="器官" height="87%">
          <Stack fill vertical>
            {data.organs_data.map((val) => (
              <OrganPage key={val.slot} organ={val} data={data} />
            ))}
          </Stack>
        </Section>
        <Section fill scrollable title="植入体" height="107%">
          {data.limbs_data.map((val) => (
            <AugmentationPage key={val.slot} limb={val} data={data} />
          ))}
        </Section>
      </Stack.Item>
    </Stack>
  );
};
