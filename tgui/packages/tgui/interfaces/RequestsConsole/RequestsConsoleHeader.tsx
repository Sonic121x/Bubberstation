import { Button, NoticeBox, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { RequestPriority, type RequestsData } from './types';
import { machineChoiceDisplay } from '../common/machineChoiceDisplay';
export const RequestsConsoleHeader = (props) => {
  const { act, data } = useBackend<RequestsData>();
  const { has_mail_send_error, new_message_priority } = data;
  return (
    <Stack.Item mb={1}>
      {!!has_mail_send_error && <ErrorNoticeBox />}
      {!!new_message_priority && <MessageNoticeBox />}
      <EmergencyBox />
    </Stack.Item>
  );
};

const EmergencyBox = (props) => {
  const { act, data } = useBackend<RequestsData>();
  const { emergency } = data;
  return (
    <>
      {!!emergency && (
        <NoticeBox danger>
          已呼叫{machineChoiceDisplay(emergency)}！RETA 可为响应人员开启区域内的门。
        </NoticeBox>
      )}
      {!emergency && (
        <Stack fill>
          <Stack.Item grow>
            <Button
              fluid
              color="red"
              icon="shield"
              content="呼叫安保"
              onClick={() =>
                act('set_emergency', {
                  emergency: 'Security',
                })
              }
            />
          </Stack.Item>
          <Stack.Item grow>
            <Button
              fluid
              color="red"
              icon="screwdriver-wrench"
              content="呼叫工程"
              onClick={() =>
                act('set_emergency', {
                  emergency: 'Engineering',
                })
              }
            />
          </Stack.Item>
          <Stack.Item grow>
            <Button
              fluid
              color="red"
              icon="suitcase-medical"
              content="呼叫医疗"
              onClick={() =>
                act('set_emergency', {
                  emergency: 'Medical',
                })
              }
            />
          </Stack.Item>
        </Stack>
      )}
    </>
  );
};

const ErrorNoticeBox = (props) => {
  return (
    <NoticeBox danger>{'发送消息时发生错误！'}</NoticeBox>
  );
};

const MessageNoticeBox = (props) => {
  const { data } = useBackend<RequestsData>();
  const { new_message_priority } = data;
  return (
    <NoticeBox>
      {'您有新的未读'}
      {new_message_priority === RequestPriority.HIGH && '高优先级'}
      {new_message_priority === RequestPriority.EXTREME && '极高优先级'}
      {'消息'}
    </NoticeBox>
  );
};
