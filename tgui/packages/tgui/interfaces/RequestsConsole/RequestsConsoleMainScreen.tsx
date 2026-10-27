import { Icon, Stack, Tabs } from 'tgui-core/components';

import { useBackend, useSharedState } from '../../backend';
import { AnnouncementTab } from './AnnouncementTab';
import { MessageViewTab } from './MessageViewTab';
import { MessageWriteTab } from './MessageWriteTab';
import { type RequestsData, RequestTabs } from './types';

export const RequestMainScreen = (props) => {
  const { act, data } = useBackend<RequestsData>();
  const { can_send_announcements } = data;
  const [tab, setTab] = useSharedState('tab', RequestTabs.MESSAGE_VIEW);

  return (
    <Stack.Item grow>
      <Stack vertical fill>
        <Stack.Item>
          <Tabs textAlign="center" fluid>
            <Tabs.Tab
              selected={tab === RequestTabs.MESSAGE_VIEW}
              onClick={() => {
                setTab(RequestTabs.MESSAGE_VIEW);
                act('clear_message_status');
                act('clear_authentication');
              }}
            >
              查看消息 <Icon name={'envelope-open'} />
            </Tabs.Tab>
            <Tabs.Tab
              selected={tab === RequestTabs.MESSAGE_WRITE}
              onClick={() => {
                if (tab === RequestTabs.MESSAGE_VIEW) {
                  act('clear_message_status');
                } else if (tab !== RequestTabs.MESSAGE_WRITE) {
                  act('clear_authentication');
                }
                setTab(RequestTabs.MESSAGE_WRITE);
              }}
            >
              撰写消息 <Icon name="pencil" />
            </Tabs.Tab>
            {!!can_send_announcements && (
              <Tabs.Tab
                selected={tab === RequestTabs.ANNOUNCE}
                onClick={() => {
                  if (tab === RequestTabs.MESSAGE_VIEW) {
                    act('clear_message_status');
                  } else if (tab !== RequestTabs.ANNOUNCE) {
                    act('clear_authentication');
                  }
                  setTab(RequestTabs.ANNOUNCE);
                }}
              >
                发布公告 <Icon name="bullhorn" />
              </Tabs.Tab>
            )}
          </Tabs>
        </Stack.Item>
        <Stack.Item grow={1}>
          {tab === RequestTabs.MESSAGE_VIEW && <MessageViewTab />}
          {tab === RequestTabs.MESSAGE_WRITE && <MessageWriteTab />}
          {!!can_send_announcements && tab === RequestTabs.ANNOUNCE && (
            <AnnouncementTab />
          )}
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};
