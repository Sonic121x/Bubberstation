import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import { Box, Button, Icon, NoticeBox, Stack } from 'tgui-core/components';

import { SecurityRecordTabs } from './RecordTabs';
import { SecurityRecordView } from './RecordView';
import type { SecurityRecordsData } from './types';

export const SecurityRecords = (props) => {
  const { data } = useBackend<SecurityRecordsData>();
  const { authenticated } = data;

  return (
    <Window title="安保档案" width={750} height={550}>
      <Window.Content>
        <Stack fill>{!authenticated ? <RestrictedView /> : <AuthView />}</Stack>
      </Window.Content>
    </Window>
  );
};

/** Unauthorized view. User can only log in with ID */
const RestrictedView = (props) => {
  const { act } = useBackend<SecurityRecordsData>();

  return (
    <Stack.Item grow>
      <Stack fill vertical>
        <Stack.Item grow />
        <Stack.Item align="center" grow={2}>
          <Icon color="average" name="exclamation-triangle" size={15} />
        </Stack.Item>
        <Stack.Item align="center" grow>
          <Box color="red" fontSize="18px" bold mt={5}>
            纳米传讯安保中心
          </Box>
        </Stack.Item>
        <Stack.Item>
          <NoticeBox align="right">
            您尚未登录。
            <Button ml={2} icon="lock-open" onClick={() => act('login')}>
              登录
            </Button>
          </NoticeBox>
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

/** Logged in view */
const AuthView = (props) => {
  const { act } = useBackend<SecurityRecordsData>();

  return (
    <>
      <Stack.Item grow>
        <SecurityRecordTabs />
      </Stack.Item>
      <Stack.Item grow={2}>
        <Stack fill vertical>
          <Stack.Item grow>
            <SecurityRecordView />
          </Stack.Item>
          <Stack.Item>
            <NoticeBox align="right" info>
              保护您的工作区。
              <Button
                align="right"
                icon="lock"
                color="good"
                ml={2}
                onClick={() => act('logout')}
              >
                登出
              </Button>
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </>
  );
};
