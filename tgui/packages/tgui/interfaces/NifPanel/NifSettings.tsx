// THIS IS A BUBBER UI FILE
import { useBackend } from 'tgui/backend';
import { Button, Dropdown, Input, LabeledList } from 'tgui-core/components';
import type { NifPanelData } from './data';
import { themeDisplay, themeOptions } from '../../localization/zhThemeDisplay';
export function NifSettings() {
  const { act, data } = useBackend<NifPanelData>();
  const {
    nutrition_drain,
    ui_themes,
    current_theme,
    nutrition_level,
    blood_drain,
    minimum_blood_level,
    blood_level,
    stored_points,
    default_examine_text,
    current_examine_text,
  } = data;

  return (
    <LabeledList>
      <LabeledList.Item
        label="纳米植入框架主题"
        tooltip="此窗口使用的界面主题。"
      >
        <Dropdown
          width="100%"
          selected={current_theme} displayText={themeDisplay(current_theme)}
          options={themeOptions(ui_themes)}
          onSelected={(value) => act('change_theme', { target_theme: value })}
        />
      </LabeledList.Item>
      <LabeledList.Item
        label="纳米植入框架外观描述"
        tooltip="他人观察你时会看到这段文字。"
      >
        <Input
          placeholder={default_examine_text}
          value={current_examine_text}
          onEnter={(value) => act('change_examine_text', { new_text: value })}
          width="100%"
        />
      </LabeledList.Item>
      <LabeledList.Item
        label="消耗营养供能"
        tooltip="允许纳米植入框架消耗你摄取的食物来供能。启用后可能加快饥饿。"
      >
        <Button
          fluid
          onClick={() => act('toggle_nutrition_drain')}
          disabled={nutrition_level < 26}
        >
          {!nutrition_drain
            ? '已禁用营养供能'
            : '已启用营养供能'}
        </Button>
      </LabeledList.Item>
      <LabeledList.Item
        label="消耗血液供能"
        tooltip="允许纳米植入框架消耗你的血液来供能。这会引起呼吸急促，并在血量过低时自动关闭。"
      >
        <Button
          fluid
          onClick={() => act('toggle_blood_drain')}
          disabled={blood_level < minimum_blood_level}
        >
          {!blood_drain ? '已禁用血液供能' : '已启用血液供能'}
        </Button>
      </LabeledList.Item>
      <LabeledList.Item
        label="奖励积分"
        tooltip="奖励积分是购买纳米植入框架软件获得的另一种货币，可以跨班次保留。"
      >
        {stored_points}
      </LabeledList.Item>
    </LabeledList>
  );
}
