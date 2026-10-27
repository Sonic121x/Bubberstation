import { useState } from 'react';
import { Button, NoticeBox, Section, TextArea } from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { RequestsData } from './types';

export const AnnouncementTab = (props) => {
  const { act, data } = useBackend<RequestsData>();
  const { authentication_data, is_admin_ghost_ai } = data;
  const [messageText, setMessageText] = useState('');
  return (
    <Section>
      <TextArea
        fluid
        height={20}
        maxLength={1025}
        value={messageText}
        onChange={setMessageText}
        placeholder="输入公告……"
      />
      <Section>
        <AuthenticationNoticeBox />
        <Button
          disabled={
            !(
              authentication_data.announcement_authenticated ||
              is_admin_ghost_ai
            ) || !messageText
          }
          icon="bullhorn"
          content="发布公告"
          onClick={() => {
            if (
              !(
                authentication_data.announcement_authenticated ||
                is_admin_ghost_ai
              ) ||
              !messageText
            ) {
              return;
            }
            act('send_announcement', { message: messageText });
            setMessageText('');
          }}
        />
        <Button
          icon="trash-can"
          content="丢弃公告"
          onClick={() => {
            act('clear_authentication');
            setMessageText('');
          }}
        />
      </Section>
    </Section>
  );
};

const AuthenticationNoticeBox = (props) => {
  const { act, data } = useBackend<RequestsData>();
  const { authentication_data, is_admin_ghost_ai } = data;
  return (
    (!authentication_data.announcement_authenticated && !is_admin_ghost_ai && (
      <NoticeBox>刷卡以验证身份</NoticeBox>
    )) || <NoticeBox info>身份验证成功</NoticeBox>
  );
};
