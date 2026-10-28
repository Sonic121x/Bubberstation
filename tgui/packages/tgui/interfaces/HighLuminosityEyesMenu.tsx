import {
  Button,
  ColorBox,
  Input,
  LabeledList,
  NumberInput,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type EyeColorData = {
  mode: BooleanLike;
  hasOwner: BooleanLike;
  left: string;
  right: string;
};

type Data = {
  eyeColor: EyeColorData;
  lightColor: string;
  range: number;
};

enum ToUpdate {
  LightColor,
  LeftEye,
  RightEye,
}

const LightColorDisplay = (props) => {
  const { act, data } = useBackend<Data>();
  const { lightColor } = data;
  return (
    <LabeledList.Item label="颜色">
      <ColorBox color={lightColor} />{' '}
      <Button
        icon="palette"
        onClick={() => act('pick_color', { to_update: ToUpdate.LightColor })}
        tooltip="打开颜色选择窗口以更改光照颜色。"
      />
      <Button
        icon="dice"
        onClick={() => act('random_color', { to_update: ToUpdate.LightColor })}
        tooltip="随机设置光照颜色。"
      />
      <Input
        value={lightColor}
        width={6}
        maxLength={7}
        onBlur={(value) =>
          act('enter_color', {
            new_color: value,
            to_update: ToUpdate.LightColor,
          })
        }
      />
    </LabeledList.Item>
  );
};

const RangeDisplay = (props) => {
  const { act, data } = useBackend<Data>();
  const { range } = data;
  return (
    <LabeledList.Item label="范围">
      <Button
        icon="minus-square-o"
        onClick={() => act('set_range', { new_range: range - 1 })}
        tooltip="缩小光照范围。"
      />
      <Button
        icon="plus-square-o"
        onClick={() => act('set_range', { new_range: range + 1 })}
        tooltip="扩大光照范围。"
      />
      <NumberInput
        animated
        tickWhileDragging
        width="35px"
        step={1}
        stepPixelSize={5}
        value={range}
        minValue={0}
        maxValue={5}
        onChange={(value) =>
          act('set_range', {
            new_range: value,
          })
        }
      />
    </LabeledList.Item>
  );
};

const EyeColorDisplay = (props) => {
  const { act, data } = useBackend<Data>();
  const { eyeColor } = data;
  return (
    <>
      <LabeledList.Item label="颜色同步">
        <Button.Checkbox
          checked={eyeColor.mode}
          onClick={() => act('toggle_eye_color')}
          tooltip="切换是否让眼睛颜色与光照颜色保持一致。"
        />
      </LabeledList.Item>
      {!eyeColor.mode && (
        <>
          <LabeledList.Item label="左眼">
            <ColorBox color={eyeColor.left} />{' '}
            <Button
              icon="palette"
              onClick={() => act('pick_color', { to_update: ToUpdate.LeftEye })}
              tooltip="打开颜色选择窗口以更改眼睛颜色。"
            />
            <Button
              icon="dice"
              onClick={() =>
                act('random_color', { to_update: ToUpdate.LeftEye })
              }
              tooltip="随机设置眼睛颜色。"
            />
            <Input
              value={eyeColor.left}
              width={6}
              maxLength={7}
              onBlur={(value) =>
                act('enter_color', {
                  new_color: value,
                  to_update: ToUpdate.LeftEye,
                })
              }
            />
          </LabeledList.Item>
          <LabeledList.Item label="右眼">
            <ColorBox color={eyeColor.right} />{' '}
            <Button
              icon="palette"
              onClick={() =>
                act('pick_color', { to_update: ToUpdate.RightEye })
              }
              tooltip="打开颜色选择窗口以更改眼睛颜色。"
            />
            <Button
              icon="dice"
              onClick={() =>
                act('random_color', { to_update: ToUpdate.RightEye })
              }
              tooltip="随机设置眼睛颜色。"
            />
            <Input
              value={eyeColor.right}
              width={6}
              maxLength={7}
              onBlur={(value) =>
                act('enter_color', {
                  new_color: value,
                  to_update: ToUpdate.RightEye,
                })
              }
            />
          </LabeledList.Item>
        </>
      )}
    </>
  );
};

export const HighLuminosityEyesMenu = (props) => {
  const { act, data } = useBackend<Data>();
  const { eyeColor } = data;
  return (
    <Window
      title="高亮度眼睛"
      width={eyeColor.hasOwner ? 262 : 225}
      height={eyeColor.hasOwner ? (eyeColor.mode ? 170 : 220) : 135}
    >
      <Window.Content>
        <Section fill title="设置">
          <LabeledList>
            <LightColorDisplay />
            <RangeDisplay />
            {!!eyeColor.hasOwner && <EyeColorDisplay />}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
