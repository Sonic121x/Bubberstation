import {
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Slider,
  Stack,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';
import { zhPanelDisplay } from './zhPanelDisplay';
import { useSettings } from './use-settings';

const tabViews = ['default', 'classic', 'scrollable'];

function LinkedToChat() {
  return <NoticeBox color="red">请先取消状态面板与聊天面板的关联！</NoticeBox>;
}

export function SettingsStatPanel(props) {
  const { settings, updateSettings } = useSettings();
  const { statLinked, statFontSize, statTabsStyle } = settings;

  return (
    <Section fill>
      <Stack fill vertical>
        <Stack.Item>
          <LabeledList>
            <LabeledList.Item label="标签页" verticalAlign="middle">
              {tabViews.map((view) => (
                <Button
                  key={view}
                  color="transparent"
                  selected={statTabsStyle === view}
                  onClick={() => updateSettings({ statTabsStyle: view })}
                >
                  {zhPanelDisplay(view)}
                </Button>
              ))}
            </LabeledList.Item>
            <LabeledList.Item label="字号">
              <Stack.Item grow>
                {statLinked ? (
                  <LinkedToChat />
                ) : (
                  <Slider
                    width="100%"
                    step={1}
                    stepPixelSize={20}
                    minValue={8}
                    maxValue={32}
                    value={statFontSize}
                    unit="px"
                    format={(value) => toFixed(value)}
                    onChange={(e, value) =>
                      updateSettings({ statFontSize: value })
                    }
                  />
                )}
              </Stack.Item>
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
        <Stack.Divider mt={2.5} />
        <Stack.Item textAlign="center">
          <Button
            fluid
            icon={statLinked ? 'unlink' : 'link'}
            color={statLinked ? 'bad' : 'good'}
            onClick={() => updateSettings({ statLinked: !statLinked })}
          >
            {statLinked ? '取消与聊天面板关联' : '与聊天面板关联'}
          </Button>
        </Stack.Item>
      </Stack>
    </Section>
  );
}
