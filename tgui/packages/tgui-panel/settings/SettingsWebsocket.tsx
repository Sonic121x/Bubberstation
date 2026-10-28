import {
  Button,
  Input,
  LabeledList,
  Section,
  Stack,
} from 'tgui-core/components';
import { chatRenderer } from 'tgui-panel/chat/renderer';
import {
  wsDisconnect,
  wsReconnect,
  wsUpdate,
} from 'tgui-panel/websocket/helpers';
import { useSettings } from './use-settings';

export function SettingsWebsocket(props) {
  const { settings, updateSettings } = useSettings();
  const { statLinked, statFontSize, statTabsStyle } = settings;

  return (
    <Section fill>
      <Stack fill vertical>
        <Stack.Item>
          <LabeledList>
            <LabeledList.Item label="WebSocket 客户端">
              <Button.Checkbox
                checked={settings.websocketEnabled}
                color="transparent"
                onClick={() => {
                  const websocketEnabled = !settings.websocketEnabled;
                  updateSettings({ websocketEnabled });
                  wsUpdate(websocketEnabled);
                }}
              >
                已启用
              </Button.Checkbox>
              <Button
                icon={'question'}
                onClick={() => {
                  chatRenderer.processBatch([
                    {
                      html:
                        '<div class="boxed_message"><b>WebSocket 说明</b><br><span class="notice">' +
                        '此功能会连接指定的 WebSocket 服务器，' +
                        '将游戏服务器发送的所有数据转发给它。' +
                        '这样就能让游戏内的动作联动其他服务或现实设备，' +
                        '例如响应式 RGB 灯光、触觉反馈，或在虚拟主播软件中' +
                        '播放特效和动画等。更多信息请参阅' +
                        '<a href="https://github.com/tgstation/tgstation/pull/96241">此拉取请求。</a></span></div>',
                    },
                  ]);
                }}
              />
            </LabeledList.Item>
            <LabeledList.Item label="WebSocket 服务器">
              <Stack.Item>
                <Stack>
                  <Input
                    width={'100%'}
                    value={settings.websocketServer}
                    placeholder="localhost:4242"
                    onChange={(value) =>
                      updateSettings({
                        websocketServer: value,
                      })
                    }
                  />
                </Stack>
              </Stack.Item>
            </LabeledList.Item>
            <LabeledList.Item label="WebSocket 控制">
              <Button
                ml={0.5}
                icon={'globe'}
                color={'good'}
                onClick={wsReconnect}
              >
                强制重新连接
              </Button>
              <Button
                ml={0.5}
                icon={'globe'}
                color={'bad'}
                onClick={wsDisconnect}
              >
                强制断开连接
              </Button>
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
}
