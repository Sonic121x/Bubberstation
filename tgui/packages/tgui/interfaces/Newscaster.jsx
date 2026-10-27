/**
 * @file
 * @author Original by ArcaneMusic (https://github.com/ArcaneMusic)
 * @author Changes Shadowh4nD/jlsnow301
 * @license MIT
 */

import { useState } from 'react';
import {
  BlockQuote,
  Box,
  Button,
  Divider,
  Image,
  LabeledList,
  Modal,
  Section,
  Stack,
  Tabs,
  TextArea,
} from 'tgui-core/components';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend, useSharedState } from '../backend';
import { processedText } from '../process';
import { BountyBoardContent } from './BountyBoard';
import { LoadingScreen } from './common/LoadingScreen';
import { UserDetails } from './Vending';

const CENSOR_MESSAGE =
  '此频道被认定为威胁空间站的安全与福祉，\
  已被纳米传讯列入 D 级封锁通告。';

export const Newscaster = (props) => {
  const { act, data } = useBackend();
  const NEWSCASTER_SCREEN = 1;
  const BOUNTYBOARD_SCREEN = 2;
  const [screenmode, setScreenmode] = useSharedState(
    'tab_main',
    NEWSCASTER_SCREEN,
  );

  return (
    <>
      <NewscasterChannelCreation />
      <NewscasterCommentCreation />
      <Stack fill vertical>
        <NewscasterWantedScreen />
        <Stack.Item>
          <Tabs fluid textAlign="center">
            <Tabs.Tab
              color="Green"
              selected={screenmode === NEWSCASTER_SCREEN}
              onClick={() => setScreenmode(NEWSCASTER_SCREEN)}
            >
              新闻播报机
            </Tabs.Tab>
            <Tabs.Tab
              Color="Blue"
              selected={screenmode === BOUNTYBOARD_SCREEN}
              onClick={() => setScreenmode(BOUNTYBOARD_SCREEN)}
            >
              悬赏公告板
            </Tabs.Tab>
          </Tabs>
        </Stack.Item>
        <Stack.Item grow>
          {screenmode === NEWSCASTER_SCREEN && <NewscasterContent />}
          {screenmode === BOUNTYBOARD_SCREEN && <BountyBoardContent />}
        </Stack.Item>
      </Stack>
    </>
  );
};

/** The modal menu that contains the prompts to making new channels. */
const NewscasterChannelCreation = (props) => {
  const { act, data } = useBackend();
  const [lockedmode, setLockedmode] = useState(true);
  const [cross_sector, setcross_sector] = useState(false);
  const { creating_channel, awaiting_approval, name, desc } = data;

  if (awaiting_approval) {
    return <LoadingScreen label="等待中央指挥部批准……" />;
  }

  if (!creating_channel) {
    return null;
  }

  return (
    <Modal textAlign="center" mr={1.5}>
      <Stack vertical>
        <Stack.Item>
          <Box pb={1}>
            在此输入频道名称：
            <Button
              color="red"
              icon="times"
              position="relative"
              top="20%"
              left="15%"
              onClick={() => act('cancelCreation')}
            />
          </Box>
          <TextArea
            height="40px"
            width="240px"
            backgroundColor="black"
            textColor="white"
            maxLength={42}
            onBlur={(value) =>
              act('setChannelName', {
                channeltext: value,
              })
            }
          >
            频道名称
          </TextArea>
        </Stack.Item>
        <Stack.Item>
          <Box pb={1}>在此输入频道说明：</Box>
          <TextArea
            height="150px"
            width="240px"
            backgroundColor="black"
            textColor="white"
            maxLength={512}
            onBlur={(value) =>
              act('setChannelDesc', {
                channeldesc: value,
              })
            }
          >
            频道说明
          </TextArea>
        </Stack.Item>
        <Stack.Item>
          <Section>
            将频道设为公开或私有
            <Box pt={1}>
              <Button
                selected={!lockedmode}
                disabled={cross_sector}
                onClick={() => setLockedmode(false)}
              >
                公开
              </Button>
              <Button
                selected={!!lockedmode}
                disabled={cross_sector}
                onClick={() => setLockedmode(true)}
              >
                私有
              </Button>
            </Box>
          </Section>
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            fluid
            checked={cross_sector}
            onClick={() => {
              setcross_sector(!cross_sector);
              setLockedmode(true);
            }}
            tooltip="跨星区新闻的每篇报道都需要中央指挥部批准。跨星区频道会自动锁定。"
            tooltipPosition="bottom-start"
          >
            设为跨星区频道？
          </Button.Checkbox>
        </Stack.Item>
        <Stack.Item>
          <Box>
            <Button
              onClick={() =>
                act('createChannel', {
                  cross_sector: cross_sector,
                  lockedmode: lockedmode,
                })
              }
            >
              提交频道
            </Button>
          </Box>
        </Stack.Item>
      </Stack>
    </Modal>
  );
};

/** The modal menu that contains the prompts to making new comments. */
const NewscasterCommentCreation = (props) => {
  const { act, data } = useBackend();
  const { creating_comment, viewing_message } = data;
  if (!creating_comment) {
    return null;
  }
  return (
    <Modal textAlign="center" mr={1.5}>
      <Stack vertical>
        <Stack.Item>
          <Box pb={1}>
            输入评论：
            <Button
              color="red"
              position="relative"
              icon="times"
              top="20%"
              left="25%"
              onClick={() => act('cancelCreation')}
            />
          </Box>
          <TextArea
            height="120px"
            width="240px"
            backgroundColor="black"
            textColor="white"
            maxLength={512}
            onBlur={(value) =>
              act('setCommentBody', {
                commenttext: value,
              })
            }
          >
            评论内容
          </TextArea>
        </Stack.Item>
        <Stack.Item>
          <Box>
            <Button
              onClick={() =>
                act('createComment', {
                  messageID: viewing_message,
                })
              }
            >
              提交评论
            </Button>
          </Box>
        </Stack.Item>
      </Stack>
    </Modal>
  );
};

const NewscasterWantedScreen = (props) => {
  const { act, data } = useBackend();
  const {
    viewing_wanted,
    photo_data,
    security_mode,
    wanted = [],
    criminal_name,
    crime_description,
  } = data;
  if (!viewing_wanted) {
    return null;
  }
  return (
    <Modal textAlign="center" mr={1} width={25}>
      {wanted.map((activeWanted) => (
        <>
          <Stack vertical>
            <Stack.Item>
              <Box bold color="red">
                {activeWanted.active
                  ? '生效中的通缉令：'
                  : '已撤销的通缉令：'}
                <Button
                  color="red"
                  position="relative"
                  icon="times"
                  top="20%"
                  left="15%"
                  onClick={() => act('cancelCreation')}
                />
              </Box>
              {!!activeWanted.criminal && (
                <>
                  <Section>
                    <Box bold>{activeWanted.criminal}</Box>
                    <Box italic>{activeWanted.crime}</Box>
                  </Section>
                  <Image src={activeWanted.image ? activeWanted.image : null} />
                  <Box italic>
                    发布者：
                    {activeWanted.author ? activeWanted.author : '不适用'}
                  </Box>
                </>
              )}
            </Stack.Item>
          </Stack>
          <Divider />
        </>
      ))}
      {security_mode ? (
        <>
          <LabeledList>
            <LabeledList.Item label="罪犯姓名">
              <Button
                disabled={!security_mode}
                icon="pen"
                onClick={() => act('setCriminalName')}
              >
                {criminal_name ? criminal_name : '不适用'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="犯罪行为">
              <Button
                nowrap={false}
                disabled={!security_mode}
                icon="pen"
                onClick={() => act('setCrimeData')}
              >
                {crime_description ? crime_description : '不适用'}
              </Button>
            </LabeledList.Item>
          </LabeledList>
          <Section>
            <Button
              icon="camera"
              selected={photo_data}
              disabled={!security_mode}
              onClick={() => act('togglePhoto')}
            >
              {photo_data ? '移除照片' : '附加照片'}
            </Button>
            <Button
              disabled={!security_mode}
              icon="volume-up"
              onClick={() => act('submitWantedIssue')}
            >
              发布通缉令
            </Button>
            <Button
              disabled={!security_mode}
              icon="times"
              color="red"
              onClick={() => act('clearWantedIssue')}
            >
              撤销通缉令
            </Button>
          </Section>
        </>
      ) : (
        <Box>
          {wanted.map((activeWanted) =>
            activeWanted.active
              ? '如发现此人，请联系当地安保官。'
              : '暂无通缉令。祝您平安。',
          )}
        </Box>
      )}
    </Modal>
  );
};

const NewscasterContent = (props) => {
  const { act, data } = useBackend();
  const { current_channel = {} } = data;
  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Stack fill>
          <Stack.Item grow>
            <NewscasterChannelSelector />
          </Stack.Item>
          <Stack.Item grow={2}>
            <Stack fill vertical>
              <Stack.Item>
                <UserDetails />
              </Stack.Item>
              <Stack.Item grow>
                <NewscasterChannelBox
                  channelName={current_channel.name}
                  channelOwner={current_channel.owner}
                  channelDesc={current_channel.desc}
                />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        <NewscasterChannelMessages />
      </Stack.Item>
    </Stack>
  );
};

/** The Channel Box is the basic channel information where buttons live.*/
const NewscasterChannelBox = (props) => {
  const { act, data } = useBackend();
  const {
    channelName,
    channelDesc,
    channelLocked,
    channelAuthor,
    channelCensored,
    receivingCrossSector,
    viewing_channel,
    admin_mode,
    photo_data,
    paper,
    user,
  } = data;
  return (
    <Section fill title={channelName}>
      <Stack fill vertical>
        <Stack.Item grow>
          {channelCensored ? (
            <Section>
              <BlockQuote color="red">
                <b>注意：</b> {CENSOR_MESSAGE}
              </BlockQuote>
            </Section>
          ) : (
            <Section fill scrollable>
              <BlockQuote italic fontSize={1.2} wrap>
                {decodeHtmlEntities(channelDesc)}
              </BlockQuote>
            </Section>
          )}
        </Stack.Item>
        <Stack.Item>
          <Box>
            <Button
              icon="print"
              disabled={
                (channelLocked && channelAuthor !== user.name) ||
                channelCensored ||
                receivingCrossSector
              }
              onClick={() => act('createStory', { current: viewing_channel })}
              mt={1}
            >
              提交报道
            </Button>
            <Button
              icon="camera"
              selected={photo_data}
              disabled={
                (channelLocked && channelAuthor !== user.name) ||
                channelCensored ||
                receivingCrossSector
              }
              onClick={() => act('togglePhoto')}
            >
              选择照片
            </Button>
            {!!admin_mode && (
              <Button
                icon="ban"
                tooltip="将整个频道及其内容标记为危害空间站并加以封锁。"
                disabled={!admin_mode || !viewing_channel}
                onClick={() =>
                  act('channelDNotice', {
                    secure: admin_mode,
                    channel: viewing_channel,
                  })
                }
              >
                D 级封锁通告
              </Button>
            )}
          </Box>
          <Box>
            <Button
              icon="newspaper"
              tooltip={paper <= 0 ? '请先放入纸张！' : ''}
              disabled={paper <= 0}
              onClick={() => act('printNewspaper')}
            >
              打印报纸
            </Button>
          </Box>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

/** Channel select is the left-hand menu where all the channels are listed. */
const NewscasterChannelSelector = (props) => {
  const { act, data } = useBackend();
  const { channels = [], viewing_channel, wanted = [] } = data;
  return (
    <Section minHeight="100%" width={`${window.innerWidth - 410}px`}>
      <Tabs vertical>
        {wanted.map((activeWanted) => (
          <Tabs.Tab
            pt={0.75}
            pb={0.75}
            mr={1}
            key={activeWanted.index}
            icon={activeWanted.active ? 'skull-crossbones' : null}
            textColor={activeWanted.active ? 'red' : 'grey'}
            onClick={() => act('toggleWanted')}
          >
            通缉令
          </Tabs.Tab>
        ))}
        {channels.map((channel) => (
          <Tabs.Tab
            key={channel.index}
            pt={0.75}
            pb={0.75}
            mr={1}
            selected={viewing_channel === channel.ID}
            icon={channel.censored ? 'ban' : null}
            textColor={channel.censored ? 'red' : 'white'}
            onClick={() =>
              act('setChannel', {
                channel: channel.ID,
              })
            }
          >
            {channel.name}
          </Tabs.Tab>
        ))}
        <Tabs.Tab
          pt={0.75}
          pb={0.75}
          mr={1}
          textColor="white"
          color="Green"
          onClick={() => act('startCreateChannel')}
        >
          创建频道 [+]
        </Tabs.Tab>
      </Tabs>
    </Section>
  );
};

/** This is where the channels comments get spangled out (tm) */
const NewscasterChannelMessages = (props) => {
  const { act, data } = useBackend();
  const {
    messages = [],
    viewing_channel,
    admin_mode,
    channelCensored,
    receivingCrossSector,
    channelLocked,
    channelAuthor,
    user,
  } = data;
  if (channelCensored) {
    return (
      <Section color="red">
        <b>注意：</b> 当前无法阅读评论。
        <br />
        感谢您的理解，祝您平安。
      </Section>
    );
  }
  const visibleMessages = messages.filter(
    (message) => message.ID !== viewing_channel,
  );
  return (
    <Section>
      {visibleMessages.map((message) => {
        return (
          <Section
            key={message.index}
            textColor="white"
            title={
              <i>
                {message.censored_author ? (
                  <Box textColor="red">
                    作者：[已删改]。<b>D 级封锁通告</b>。
                  </Box>
                ) : (
                  <>
                    作者：{message.auth}，发布于 {message.time}
                  </>
                )}
              </i>
            }
            buttons={
              <>
                {!!admin_mode && (
                  <Button
                    icon="comment-slash"
                    tooltip="封锁报道"
                    disabled={!admin_mode}
                    onClick={() =>
                      act('storyCensor', {
                        messageID: message.ID,
                      })
                    }
                  />
                )}
                {!!admin_mode && (
                  <Button
                    icon="user-slash"
                    tooltip="屏蔽作者"
                    disabled={!admin_mode}
                    onClick={() =>
                      act('authorCensor', {
                        messageID: message.ID,
                      })
                    }
                  />
                )}
                <Button
                  icon="comment"
                  tooltip="发表评论。"
                  disabled={
                    message.censored_author ||
                    message.censored_message ||
                    user.name === 'Unknown' ||
                    (!!channelLocked && channelAuthor !== user.name)
                  }
                  onClick={() =>
                    act('startComment', {
                      messageID: message.ID,
                    })
                  }
                />
              </>
            }
          >
            <BlockQuote>
              {message.censored_message ? (
                <Section textColor="red">
                  此消息被认定为危害空间站的安全与福祉，
                  因此被列入<b>D 级封锁通告</b>。
                </Section>
              ) : (
                <Section pl={1}>
                  <Box dangerouslySetInnerHTML={processedText(message.body)} />
                </Section>
              )}
              {message.photo !== null && !message.censored_message && (
                <Image src={message.photo} />
              )}
              {!!message.comments && (
                <Box>
                  {message.comments.map((comment) => (
                    <BlockQuote key={comment.index}>
                      <Box italic textColor="white">
                        作者：{comment.auth}，发布于 {comment.time}
                      </Box>
                      <Section ml={2.5}>
                        <Box
                          dangerouslySetInnerHTML={processedText(comment.body)}
                        />
                      </Section>
                    </BlockQuote>
                  ))}
                </Box>
              )}
            </BlockQuote>
            <Divider />
          </Section>
        );
      })}
    </Section>
  );
};
