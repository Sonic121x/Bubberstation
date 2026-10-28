import { Box, Button, Divider, Image, Section } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { processedText } from '../process';

type Data = {
  current_page: number;
  scribble_message: string | null;
  channel_has_messages: BooleanLike;
  channels: ChannelNames[];
  channel_data: ChannelData[];
  wanted_criminal: string | null;
  wanted_body: string | null;
  wanted_photo: string | null;
};

type ChannelNames = {
  name: string | null;
  page_number: number;
};

type ChannelData = {
  channel_name: string | null;
  author_name: string | null;
  is_censored: BooleanLike;
  channel_messages: ChannelMessages[];
};

type ChannelMessages = {
  message: string | null;
  photo: string | null;
  author: string | null;
};

export const Newspaper = (props) => {
  const { act, data } = useBackend<Data>();
  const { channels = [], current_page, scribble_message } = data;

  return (
    <Window width={300} height={400}>
      <Window.Content backgroundColor="#858387" scrollable>
        <Section>
          <Button
            icon="arrow-left"
            width="49%"
            disabled={!current_page}
            onClick={() => act('prev_page')}
          >
            上一页
          </Button>
          <Button
            icon="arrow-right"
            width="50%"
            disabled={current_page === channels.length + 1}
            onClick={() => act('next_page')}
          >
            下一页
          </Button>
        </Section>
        {current_page === channels.length + 1 ? (
          <NewspaperEnding />
        ) : current_page ? (
          <NewspaperChannel />
        ) : (
          <NewspaperIntro />
        )}
        {!!scribble_message && (
          <Box
            style={{
              borderTop: '3px dotted rgba(255, 255, 255, 0.8)',
              borderBottom: '3px dotted rgba(255, 255, 255, 0.8)',
            }}
          >
            {scribble_message}
          </Box>
        )}
      </Window.Content>
    </Window>
  );
};

const NewspaperIntro = (props) => {
  const { act, data } = useBackend<Data>();
  const { channels = [], wanted_criminal = [] } = data;

  return (
    <Section>
      <Box bold fontSize="30px">
        《狮鹫报》
      </Box>
      <Box bold fontSize="15px">
        仅限太空设施使用！
      </Box>
      <Box fontSize="12px">目录：</Box>
      {channels.map((channel) => (
        <Box key={channel.page_number}>
          第 {channel.page_number || 0} 页：{channel.name}
        </Box>
      ))}
      {!!wanted_criminal && (
        <Box bold>末页：重要安保公告</Box>
      )}
    </Section>
  );
};

const NewspaperChannel = (props) => {
  const { act, data } = useBackend<Data>();
  const { channel_has_messages, channel_data = [] } = data;

  return (
    <Section>
      {channel_data.map((individual_channel) => (
        <Box key={individual_channel.channel_name}>
          <Box bold fontSize="15px">
            {individual_channel.channel_name}
          </Box>
          <Box fontSize="12px">
            频道创办者：{individual_channel.author_name}
          </Box>
          {channel_has_messages
            ? individual_channel.channel_messages.map((message) => (
                <>
                  <Box key={message.message}>
                    <Box
                      dangerouslySetInnerHTML={processedText(message.message)}
                    />
                    {!!message.photo && <Image src={message.photo} />}
                    <Box>作者：{message.author}</Box>
                  </Box>
                  <Divider />
                </>
              ))
            : '此频道尚未刊登任何报道……'}
        </Box>
      ))}
    </Section>
  );
};

const NewspaperEnding = (props) => {
  const { act, data } = useBackend<Data>();
  const { wanted_criminal, wanted_body, wanted_photo } = data;

  return (
    <Section>
      {wanted_criminal ? (
        <>
          <Box bold fontSize="15px">
            通缉令
          </Box>
          <Box fontSize="12px">罪犯姓名：{wanted_criminal}</Box>
          <Box>描述：{wanted_body}</Box>
          {!!wanted_photo && <Image src={wanted_photo} />}
        </>
      ) : (
        '除了几条无趣的分类广告，这一页没有其他内容……'
      )}
    </Section>
  );
};
