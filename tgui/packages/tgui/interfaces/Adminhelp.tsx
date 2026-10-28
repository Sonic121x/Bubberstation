import { useState } from 'react';
import {
  Box,
  Button,
  Input,
  NoticeBox,
  Stack,
  TextArea,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type AdminhelpData = {
  adminCount: number;
  urgentAhelpEnabled: BooleanLike;
  bannedFromUrgentAhelp: BooleanLike;
  urgentAhelpPromptMessage: string;
};

export const Adminhelp = (props) => {
  const { act, data } = useBackend<AdminhelpData>();
  const {
    adminCount,
    urgentAhelpEnabled,
    bannedFromUrgentAhelp,
    urgentAhelpPromptMessage,
  } = data;
  const [requestForAdmin, setRequestForAdmin] = useState(false);
  const [currentlyInputting, setCurrentlyInputting] = useState(false);
  const [ahelpMessage, setAhelpMessage] = useState('');

  const confirmationText = 'alert admins';
  return (
    <Window title="向管理员求助" theme="admin" height={300} width={500}>
      <Window.Content
        style={{
          backgroundImage: 'none',
        }}
      >
        <Stack vertical fill>
          <Stack.Item grow>
            <TextArea
              autoFocus
              height="100%"
              fluid
              placeholder="管理员求助内容"
              onChange={setAhelpMessage}
            />
          </Stack.Item>
          {urgentAhelpEnabled && adminCount <= 0 && (
            <Stack.Item>
              <NoticeBox info>
                {urgentAhelpPromptMessage}
                {currentlyInputting ? (
                  <Box
                    mt={1}
                    width="100%"
                    fontFamily="arial"
                    backgroundColor="grey"
                    style={{
                      fontStyle: 'normal',
                    }}
                  >
                    输入 &apos;{confirmationText}&apos; 以继续。
                    <Input
                      placeholder="确认提示"
                      autoFocus
                      fluid
                      onChange={(value) => {
                        if (value === confirmationText) {
                          setRequestForAdmin(true);
                          setCurrentlyInputting(false);
                        }
                      }}
                    />
                  </Box>
                ) : (
                  <Button
                    mt={1}
                    onClick={() => {
                      if (requestForAdmin) {
                        setRequestForAdmin(false);
                      } else {
                        setCurrentlyInputting(true);
                      }
                    }}
                    color={requestForAdmin ? 'orange' : 'blue'}
                    icon={requestForAdmin ? 'check-square-o' : 'square-o'}
                    disabled={bannedFromUrgentAhelp}
                    tooltip={
                      bannedFromUrgentAhelp
                        ? '你已被禁止使用紧急管理员求助功能。'
                        : undefined
                    }
                    fluid
                    textAlign="center"
                  >
                    通知管理员？
                  </Button>
                )}
              </NoticeBox>
            </Stack.Item>
          )}
          <Stack.Item>
            <Button
              color="good"
              fluid
              textAlign="center"
              onClick={() =>
                act('ahelp', {
                  urgent: requestForAdmin,
                  message: ahelpMessage,
                })
              }
            >
              提交
            </Button>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
