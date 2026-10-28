import { sortBy } from 'es-toolkit';
import { useState } from 'react';
import {
  Box,
  Button,
  Dimmer,
  Divider,
  Icon,
  Input,
  NoticeBox,
  Section,
  Stack,
  TextArea,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { createSearch } from 'tgui-core/string';

import { useBackend } from '../../backend';
import { NtosWindow } from '../../layouts';
import { ChatScreen } from './ChatScreen';
import type { NtChat, NtMessenger, NtPicture } from './types';
import { displayRole as zh } from '../../localization/roleDisplay';
type NtosMessengerData = {
  can_spam: BooleanLike;
  is_silicon: BooleanLike;
  remote_silicon: BooleanLike;
  owner?: NtMessenger;
  saved_chats: Record<string, NtChat>;
  messengers: Record<string, NtMessenger>;
  sort_by_job: BooleanLike;
  alert_silenced: BooleanLike;
  alert_able: BooleanLike;
  sending_and_receiving: BooleanLike;
  open_chat: string;
  stored_photos?: NtPicture[];
  selected_photo_path?: string;
  on_spam_cooldown: BooleanLike;
  virus_attach: BooleanLike;
  sending_virus: BooleanLike;
};

export const NtosMessenger = (props) => {
  const { data } = useBackend<NtosMessengerData>();
  const {
    is_silicon,
    remote_silicon,
    saved_chats,
    stored_photos,
    selected_photo_path,
    open_chat,
    messengers,
    sending_virus,
  } = data;

  let content: React.JSX.Element;
  if (remote_silicon) {
    content = <AccessDeniedScreen />;
  } else if (open_chat !== null) {
    const openChat = saved_chats[open_chat];
    const temporaryRecipient = messengers[open_chat];

    if (!openChat && !temporaryRecipient) {
      content = <ContactsScreen />;
    } else {
      content = (
        <ChatScreen
          storedPhotos={stored_photos}
          selectedPhoto={selected_photo_path}
          isSilicon={is_silicon}
          sendingVirus={sending_virus}
          canReply={openChat ? openChat.can_reply : !!temporaryRecipient}
          messages={openChat ? openChat.messages : []}
          recipient={openChat ? openChat.recipient : temporaryRecipient}
          unreads={openChat ? openChat.unread_messages : 0}
          chatRef={openChat?.ref}
        />
      );
    }
  } else {
    content = <ContactsScreen />;
  }

  return (
    <NtosWindow width={600} height={850}>
      <NtosWindow.Content>{content}</NtosWindow.Content>
    </NtosWindow>
  );
};

const AccessDeniedScreen = (props: any) => {
  const { act, data } = useBackend<NtosMessengerData>();

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section>
          <Stack vertical textAlign="center">
            <Box bold>
              <Icon name="address-card" />
              太空信使 V6.5.3
            </Box>
          </Stack>
        </Section>
      </Stack.Item>
      <NoticeBox
        color="white"
        position="relative"
        top="30%"
        fontSize="30px"
        textAlign="center"
      >
        错误：连接被拒绝
      </NoticeBox>
      <Stack vertical position="relative" top="35%" textAlign="left">
        <Section>
          <Box>主机消息：</Box>
          <Box>－此应用的远程访问已受限制。</Box>
          <Box>－请联系管理员获取进一步帮助。</Box>
        </Section>
      </Stack>
    </Stack>
  );
};

const ContactsScreen = (props: any) => {
  const { act, data } = useBackend<NtosMessengerData>();
  const {
    owner,
    alert_silenced,
    alert_able,
    sending_and_receiving,
    saved_chats,
    messengers,
    sort_by_job,
    can_spam,
    is_silicon,
    virus_attach,
    sending_virus,
  } = data;

  const [searchUser, setSearchUser] = useState('');

  const sortByUnreads = (array: NtChat[]) =>
    sortBy(array, [(chat) => chat.unread_messages]);

  const searchChatByName = createSearch(
    searchUser,
    (chat: NtChat) => chat.recipient.name + chat.recipient.job + zh(chat.recipient.job),
  );
  const searchMessengerByName = createSearch(
    searchUser,
    (messenger: NtMessenger) => messenger.name + messenger.job + zh(messenger.job),
  );

  const chatToButton = (chat: NtChat) => {
    return (
      <ChatButton
        key={chat.ref}
        name={`${chat.recipient.name}（${zh(chat.recipient.job)}）`}
        chatRef={chat.ref}
        unreads={chat.unread_messages}
      />
    );
  };

  const messengerToButton = (messenger: NtMessenger) => {
    return (
      <ChatButton
        key={messenger.ref}
        name={`${messenger.name}（${zh(messenger.job)}）`}
        chatRef={messenger.ref!}
        unreads={0}
      />
    );
  };

  const openChatsArray = sortByUnreads(Object.values(saved_chats)).filter(
    searchChatByName,
  );

  const filteredChatButtons = openChatsArray
    .filter((c) => c.visible)
    .map(chatToButton);

  const messengerButtons = Object.entries(messengers)
    .filter(
      ([ref, messenger]) =>
        openChatsArray.every((chat) => chat.recipient.ref !== ref) &&
        searchMessengerByName(messenger),
    )
    .map(([_, messenger]) => messenger)
    .map(messengerToButton)
    .concat(openChatsArray.filter((chat) => !chat.visible).map(chatToButton));

  const noId = !owner && !is_silicon;

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section>
          <Stack vertical textAlign="center">
            <Box bold>
              <Icon name="address-card" mr={1} />
              太空信使 V6.5.4
            </Box>
            <Box italic opacity={0.3} mt={1}>
              自 2467 年起为您提供防窃听通信。
            </Box>
            <Divider hidden />
            <Box>
              <Button
                icon="bell"
                disabled={!alert_able}
                content={
                  alert_able && !alert_silenced ? '铃声：开启' : '铃声：关闭'
                }
                onClick={() => act('PDA_toggleAlerts')}
              />
              <Button
                icon="address-card"
                content={
                  sending_and_receiving
                    ? '发送／接收：开启'
                    : '发送／接收：关闭'
                }
                onClick={() => act('PDA_toggleSendingAndReceiving')}
              />
              <Button
                icon="bell"
                content="设置铃声"
                onClick={() => act('PDA_ringSet')}
              />
              <Button
                icon="sort"
                content={`排序依据：${sort_by_job ? '职务' : '姓名'}`}
                onClick={() => act('PDA_changeSortStyle')}
              />
              {!!virus_attach && (
                <Button
                  icon="bug"
                  color="bad"
                  content={`附加病毒：${sending_virus ? '是' : '否'}`}
                  onClick={() => act('PDA_toggleVirus')}
                />
              )}
            </Box>
          </Stack>
          <Divider hidden />
          <Stack justify="space-between">
            <Box m={0.5}>
              <Icon name="magnifying-glass" mr={1} />
              搜索用户
            </Box>
            <Input
              width="220px"
              placeholder="按姓名或职务搜索……"
              value={searchUser}
              onChange={setSearchUser}
            />
          </Stack>
        </Section>
      </Stack.Item>
      {filteredChatButtons.length > 0 && (
        <Stack.Item grow={1}>
          <Stack vertical fill>
            <Section>
              <Icon name="comments" mr={1} />
              历史消息
            </Section>
            <Section fill scrollable>
              <Stack vertical>{filteredChatButtons}</Stack>
            </Section>
          </Stack>
        </Stack.Item>
      )}
      <Stack.Item grow={2}>
        <Stack vertical fill>
          <Section>
            <Stack>
              <Box m={0.5}>
                <Icon name="address-card" mr={1} />
                检测到的通信终端
              </Box>
            </Stack>
          </Section>
          <Section fill scrollable>
            <Stack vertical pb={1} fill>
              {messengerButtons.length === 0 && (
                <Stack align="center" justify="center" fill pl={4}>
                  <Icon color="gray" name="user-slash" size={2} />
                  <Stack.Item fontSize={1.5} ml={3}>
                    未找到用户。
                  </Stack.Item>
                </Stack>
              )}
              {messengerButtons}
            </Stack>
          </Section>
        </Stack>
      </Stack.Item>
      {!!can_spam && (
        <Stack.Item>
          <SendToAllSection />
        </Stack.Item>
      )}
      {noId && <NoIDDimmer />}
    </Stack>
  );
};

type ChatButtonProps = {
  name: string;
  unreads: number;
  chatRef: string;
};

const ChatButton = (props: ChatButtonProps) => {
  const { act } = useBackend();
  const unreadMessages = props.unreads;
  const hasUnreads = unreadMessages > 0;
  return (
    <Button
      icon={hasUnreads && 'envelope'}
      key={props.chatRef}
      fluid
      onClick={() => {
        act('PDA_viewMessages', { ref: props.chatRef });
      }}
    >
      {hasUnreads &&
        `[${unreadMessages <= 9 ? unreadMessages : '9+'} 条未读消息${
          ''
        }]`}{' '}
      {props.name}
    </Button>
  );
};

const SendToAllSection = (props) => {
  const { data, act } = useBackend<NtosMessengerData>();
  const { on_spam_cooldown } = data;

  const [message, setMessage] = useState('');

  return (
    <>
      <Section>
        <Stack justify="space-between">
          <Stack.Item align="center">
            <Icon name="satellite-dish" mr={1} ml={0.5} />
            发送给所有人
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="arrow-right"
              disabled={on_spam_cooldown || message === ''}
              tooltip={on_spam_cooldown && '请稍候再发送消息！'}
              onClick={() => {
                act('PDA_sendEveryone', { message: message });
                setMessage('');
              }}
            >
              发送
            </Button>
          </Stack.Item>
        </Stack>
      </Section>
      <Section>
        <TextArea
          height={6}
          width="100%"
          value={message}
          placeholder="向所有人发送消息……"
          onChange={setMessage}
          selfClear
          onEnter={() => {
            act('PDA_sendEveryone', { message: message });
          }}
        />
      </Section>
    </>
  );
};

const NoIDDimmer = () => {
  return (
    <Dimmer>
      <Stack align="baseline" vertical>
        <Stack ml={-2}>
          <Icon color="red" name="address-card" size={10} />
        </Stack>
        <Stack.Item fontSize="18px">
          请录入身份卡信息以继续。
        </Stack.Item>
      </Stack>
    </Dimmer>
  );
};
