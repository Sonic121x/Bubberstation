import { useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  Section,
  Stack,
  TextArea,
} from 'tgui-core/components';
import { areaDisplay } from '../../localization/batchThreeDisplay';
import { useBackend, useLocalState } from '../../backend';
import { RequestPriority, type RequestsData, RequestType } from './types';
import { machineChoiceDisplay } from '../common/machineChoiceDisplay';
export const MessageWriteTab = (props) => {
  const { act, data } = useBackend<RequestsData>();
  const {
    authentication_data,
    hack_state,
    assistance_consoles = [],
    supply_consoles = [],
    information_consoles = [],
  } = data;

  const sorted_assistance = assistance_consoles.sort();
  const sorted_supply = supply_consoles.sort();
  const sorted_information = information_consoles.sort();

  const resetMessage = () => {
    setMessageText('');
    setRecipient('');
    setPriority(RequestPriority.NORMAL);
    setRequestType(RequestType.ASSISTANCE);
  };
  const [messageText, setMessageText] = useLocalState('messageText', '');
  const [requestType, setRequestType] = useState(RequestType.ASSISTANCE);
  const [priority, setPriority] = useState(RequestPriority.NORMAL);
  const [recipient, setRecipient] = useState('');
  return (
    <Section>
      <Stack fill mb={2}>
        <Stack.Item grow>
          <Button
            fluid
            icon="handshake-angle"
            selected={requestType === RequestType.ASSISTANCE}
            onClick={() => {
              setRecipient('');
              setRequestType(RequestType.ASSISTANCE);
            }}
          >
            请求援助
          </Button>
        </Stack.Item>
        <Stack.Item grow>
          <Button
            fluid
            icon="boxes-stacked"
            selected={requestType === RequestType.SUPPLIES}
            onClick={() => {
              setRecipient('');
              setRequestType(RequestType.SUPPLIES);
            }}
          >
            请求物资
          </Button>
        </Stack.Item>
        <Stack.Item grow>
          <Button
            fluid
            icon="upload"
            selected={requestType === RequestType.INFORMATION}
            onClick={() => {
              setRecipient('');
              setRequestType(RequestType.INFORMATION);
            }}
          >
            转达信息
          </Button>
        </Stack.Item>
      </Stack>
      <Box>
        {requestType === RequestType.ASSISTANCE && (
          <Dropdown
            width="100%"
            options={sorted_assistance.map((value) => ({ value, displayText: machineChoiceDisplay(areaDisplay(value, data)) }))}
            selected={recipient} displayText={machineChoiceDisplay(areaDisplay(recipient, data))}
            placeholder="选择收件人"
            onSelected={(value) => setRecipient(value)}
          />
        )}
        {requestType === RequestType.SUPPLIES && (
          <Dropdown
            width="100%"
            options={sorted_supply.map((value) => ({ value, displayText: machineChoiceDisplay(areaDisplay(value, data)) }))}
            selected={recipient} displayText={machineChoiceDisplay(areaDisplay(recipient, data))}
            placeholder="选择收件人"
            onSelected={(value) => setRecipient(value)}
          />
        )}
        {requestType === RequestType.INFORMATION && (
          <Dropdown
            width="100%"
            options={sorted_information.map((value) => ({ value, displayText: machineChoiceDisplay(areaDisplay(value, data)) }))}
            selected={recipient} displayText={machineChoiceDisplay(areaDisplay(recipient, data))}
            placeholder="选择收件人"
            onSelected={(value) => setRecipient(value)}
          />
        )}
      </Box>
      <Stack fill mt={2} mb={2}>
        <Stack.Item grow>
          <Button
            icon="envelope"
            content="普通优先级"
            key={RequestPriority.NORMAL}
            fluid
            selected={priority === RequestPriority.NORMAL}
            onClick={() => setPriority(RequestPriority.NORMAL)}
          />
        </Stack.Item>
        <Stack.Item grow>
          <Button
            icon="exclamation"
            content="高优先级"
            key={RequestPriority.HIGH}
            fluid
            selected={priority === RequestPriority.HIGH}
            onClick={() => setPriority(RequestPriority.HIGH)}
          />
        </Stack.Item>
        {!!hack_state && (
          <Stack.Item grow>
            <Button
              icon="burst"
              content="极高优先级"
              key={RequestPriority.EXTREME}
              fluid
              selected={priority === RequestPriority.EXTREME}
              onClick={() => setPriority(RequestPriority.EXTREME)}
            />
          </Stack.Item>
        )}
      </Stack>
      <TextArea
        fluid
        height={20}
        maxLength={1025}
        value={messageText}
        onChange={setMessageText}
        placeholder="输入消息……"
      />
      <Section>
        <Stack fill justify="space-between">
          <Stack.Item>
            <Button
              icon="paper-plane"
              disabled={!messageText || !recipient || !priority || !requestType}
              onClick={() => {
                if (!messageText || !recipient || !priority || !requestType) {
                  return;
                }

                act('send_message', {
                  message: messageText,
                  recipient: recipient,
                  request_type: requestType,
                  priority: priority,
                });
                resetMessage();
              }}
            >
              发送消息
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button icon="id-card" onClick={() => act('verify_id')}>
              {authentication_data.message_verified_by || '未认证'}
            </Button>
            <Button icon="stamp" onClick={() => act('stamp')}>
              {authentication_data.message_stamped_by || '未盖章'}
            </Button>
          </Stack.Item>
        </Stack>
        <Button
          icon="trash-can"
          onClick={() => {
            act('clear_authentication');
            resetMessage();
          }}
        >
          丢弃消息
        </Button>
      </Section>
    </Section>
  );
};
