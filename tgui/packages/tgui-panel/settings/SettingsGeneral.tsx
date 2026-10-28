import { useState } from 'react';
import {
  Button,
  Collapsible,
  Divider,
  Input,
  LabeledList,
  Section,
  Slider,
  Stack,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';
import { zhPanelDisplay } from './zhPanelDisplay';
import { chatRenderer } from '../chat/renderer';
import { FONTS, THEMES } from './constants';
import { resetPaneSplitters, setEditPaneSplitters } from './scaling';
import { exportChatSettings, importChatSettings } from './settingsImExport';
import { useSettings } from './use-settings';

export function SettingsGeneral(props) {
  const { settings, updateSettings } = useSettings();
  const [freeFont, setFreeFont] = useState(false);

  const [editingPanes, setEditingPanes] = useState(false);

  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label="主题">
          {THEMES.map((THEME) => (
            <Button
              key={THEME}
              selected={settings.theme === THEME}
              color="transparent"
              onClick={() =>
                updateSettings({
                  theme: THEME,
                })
              }
            >
              {zhPanelDisplay(THEME)}
            </Button>
          ))}
        </LabeledList.Item>
        <LabeledList.Item label="界面大小">
          <Stack>
            <Stack.Item>
              <Button
                onClick={() =>
                  setEditingPanes((val) => {
                    setEditPaneSplitters(!val);
                    return !val;
                  })
                }
                color={editingPanes ? 'red' : undefined}
                icon={editingPanes ? 'save' : undefined}
              >
                {editingPanes ? '保存' : '调整界面大小'}
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button onClick={resetPaneSplitters} icon="refresh" color="red">
                重置
              </Button>
            </Stack.Item>
          </Stack>
        </LabeledList.Item>
        <LabeledList.Item label="字体">
          <Stack.Item>
            {!freeFont ? (
              <Collapsible
                title={zhPanelDisplay(settings.fontFamily)}
                width="100%"
                buttons={
                  <Button
                    icon={freeFont ? 'lock-open' : 'lock'}
                    color={freeFont ? 'good' : 'bad'}
                    onClick={() => {
                      setFreeFont(!freeFont);
                    }}
                  >
                    自定义字体
                  </Button>
                }
              >
                {FONTS.map((FONT) => (
                  <Button
                    key={FONT}
                    fontFamily={FONT}
                    selected={settings.fontFamily === FONT}
                    color="transparent"
                    onClick={() =>
                      updateSettings({
                        fontFamily: FONT,
                      })
                    }
                  >
                    {zhPanelDisplay(FONT)}
                  </Button>
                ))}
              </Collapsible>
            ) : (
              <Stack>
                <Input
                  fluid
                  value={settings.fontFamily}
                  onBlur={(value) =>
                    updateSettings({
                      fontFamily: value,
                    })
                  }
                />
                <Button
                  ml={0.5}
                  icon={freeFont ? 'lock-open' : 'lock'}
                  color={freeFont ? 'good' : 'bad'}
                  onClick={() => {
                    setFreeFont(!freeFont);
                  }}
                >
                  自定义字体
                </Button>
              </Stack>
            )}
          </Stack.Item>
        </LabeledList.Item>
        <LabeledList.Item label="字号" verticalAlign="middle">
          <Stack textAlign="center">
            <Stack.Item grow>
              <Slider
                width="100%"
                step={1}
                stepPixelSize={20}
                minValue={8}
                maxValue={32}
                value={settings.fontSize}
                unit="px"
                format={(value) => toFixed(value)}
                onChange={(e, value) => updateSettings({ fontSize: value })}
              />
            </Stack.Item>
          </Stack>
        </LabeledList.Item>
        <LabeledList.Item label="行高">
          <Slider
            width="100%"
            step={0.01}
            minValue={0.8}
            maxValue={5}
            value={settings.lineHeight}
            format={(value) => toFixed(value, 2)}
            onChange={(e, value) =>
              updateSettings({
                lineHeight: value,
              })
            }
          />
        </LabeledList.Item>
      </LabeledList>
      <Divider />
      <Stack fill>
        <Stack.Item mt={0.15}>
          <Button
            icon="compact-disc"
            tooltip="导出聊天设置"
            onClick={exportChatSettings}
          >
            导出设置
          </Button>
        </Stack.Item>
        <Stack.Item mt={0.15}>
          <Button.File
            accept=".json"
            tooltip="导入聊天设置"
            icon="arrow-up-from-bracket"
            onSelectFiles={importChatSettings}
          >
            导入设置
          </Button.File>
        </Stack.Item>
        <Stack.Item grow mt={0.15}>
          <Button
            icon="save"
            tooltip="将当前标签页的历史消息导出为 HTML 文件"
            onClick={() => chatRenderer.saveToDisk()}
          >
            保存聊天日志
          </Button>
        </Stack.Item>
        <Stack.Item mt={0.15}>
          <Button.Confirm
            icon="trash"
            tooltip="删除当前标签页的历史消息"
            onClick={() => chatRenderer.clearChat()}
          >
            清空聊天
          </Button.Confirm>
        </Stack.Item>
      </Stack>
    </Section>
  );
}
