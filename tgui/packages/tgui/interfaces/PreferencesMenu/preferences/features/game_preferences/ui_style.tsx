import { Box, Dropdown, Stack } from 'tgui-core/components';
import { classes } from 'tgui-core/react';
import { chineseDisplay } from 'tgui/localization/zhDisplay';
import {
  type FeatureChoiced,
  type FeatureChoicedServerData,
  type FeatureValueProps,
  sortChoices,
} from '../base';

function UIStyleInput(
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) {
  const { serverData, value } = props;
  if (!serverData) {
    return null;
  }

  const { icons } = serverData;

  if (!icons) {
    return <Box color="red">ui_style 缺少图标！</Box>;
  }

  const choices = Object.fromEntries(
    Object.entries(icons).map(([name, icon]) => {
      return [
        name,
        <Stack key={name}>
          <Stack.Item>
            <Box
              className={classes(['preferences64x32', icon])}
              style={{
                transform: 'scale(0.8)',
              }}
            />
          </Stack.Item>

          <Stack.Item grow>{chineseDisplay(name)}</Stack.Item>
        </Stack>,
      ];
    }),
  );

  return (
    <Dropdown
      selected={value} displayText={chineseDisplay(value)}
      clipSelectedText={false}
      onSelected={props.handleSetValue}
      width="100%"
      options={sortChoices(Object.entries(choices)).map(
        ([dataValue, label]) => {
          return {
            displayText: label,
            value: dataValue,
          };
        },
      )}
    />
  );
}

export const UI_style: FeatureChoiced = {
  name: '界面风格',
  category: 'UI',
  component: UIStyleInput,
};
