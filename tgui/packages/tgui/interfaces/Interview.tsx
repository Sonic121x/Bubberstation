import { type ReactNode, useState } from 'react';
import {
  BlockQuote,
  Box,
  Button,
  NoticeBox,
  Section,
  TextArea,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  connected: BooleanLike;
  is_admin: BooleanLike;
  questions: Question[];
  queue_pos: number;
  read_only: BooleanLike;
  status: string;
  welcome_message: string;
  centcom_connected: BooleanLike;
  has_permabans: BooleanLike;
};

type Question = {
  qidx: number;
  question: string;
  response: string | null;
};

enum STATUS {
  Approved = 'interview_approved',
  Denied = 'interview_denied',
}

// Matches a complete markdown-style link, capturing the whole [...](...)
const linkRegex = /(\[[^[]+\]\([^)]+\))/;
// Decomposes a markdown-style link into the link and display text
const linkDecomposeRegex = /\[([^[]+)\]\(([^)]+)\)/;

// Renders any markdown-style links within a provided body of text
const linkifyText = (text: string) => {
  const parts: ReactNode[] = text.split(linkRegex);
  for (let i = 1; i < parts.length; i += 2) {
    const match = linkDecomposeRegex.exec(parts[i] as string);
    if (!match) continue;

    parts[i] = (
      <a key={`link${i}`} href={match[2]}>
        {match[1]}
      </a>
    );
  }
  return parts;
};

export const Interview = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    connected,
    is_admin,
    questions = [],
    queue_pos,
    read_only,
    status,
    welcome_message = '',
    centcom_connected,
    has_permabans,
  } = data;

  const allAnswered = questions.every((q) => q.response);
  const numAnswered = questions.filter((q) => q.response)?.length;

  return (
    <Window
      width={550}
      height={600}
      canClose={is_admin || status === 'interview_approved'}
    >
      <Window.Content scrollable>
        {(!read_only && (
          <Section title="欢迎！">
            <p>{linkifyText(welcome_message)}</p>
          </Section>
        )) || <RenderedStatus status={status} queue_pos={queue_pos} />}
        <Section
          title="问卷"
          buttons={
            <span>
              <Button
                onClick={() => act('submit')}
                disabled={read_only || !allAnswered || !questions.length}
                icon="envelope"
                tooltip={
                  !allAnswered &&
                  `请回答所有问题。
                     ${numAnswered} / ${questions.length}`
                }
              >
                {read_only ? '已提交' : '提交'}
              </Button>
              {!!is_admin && status === 'interview_pending' && (
                <span>
                  <Button disabled={!connected} onClick={() => act('adminpm')}>
                    管理员私信
                  </Button>
                  <Button color="good" onClick={() => act('approve')}>
                    批准
                  </Button>
                  <Button color="bad" onClick={() => act('deny')}>
                    拒绝
                  </Button>
                  {!!centcom_connected && (
                    <Button
                      color={has_permabans ? 'bad' : 'average'}
                      tooltip={
                        has_permabans
                          ? '该用户有永久封禁记录！'
                          : ''
                      }
                      onClick={() => act('check_centcom')}
                    >
                      查询中央封禁数据库
                    </Button>
                  )}
                </span>
              )}
            </span>
          }
        >
          {!read_only && (
            <>
              <Box as="p" color="label">
                请回答以下问题。
                <ul>
                  <li>
                    你可以按回车键或点击保存按钮来保存
                    回答。
                  </li>
                  <li>
                    在点击提交按钮之前，你可以修改回答。
                  </li>
                  <li>完成后请点击“提交”。</li>
                </ul>
              </Box>
              <NoticeBox info align="center">
                提交后将无法修改回答。
              </NoticeBox>
            </>
          )}
          {questions.map((question) => (
            <QuestionArea key={question.qidx} {...question} />
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};

const RenderedStatus = (props: { status: string; queue_pos: number }) => {
  const { status, queue_pos } = props;

  switch (status) {
    case STATUS.Approved:
      return <NoticeBox success>此次面试已获批准。</NoticeBox>;
    case STATUS.Denied:
      return <NoticeBox danger>此次面试已被拒绝。</NoticeBox>;
    default:
      return (
        <NoticeBox info>
          你的回答已提交。你目前在队列中排第 {queue_pos}
          位。
        </NoticeBox>
      );
  }
};

const QuestionArea = (props: Question) => {
  const { qidx, question, response } = props;
  const { act, data } = useBackend<Data>();
  const { is_admin, read_only } = data;

  const [userInput, setUserInput] = useState(response);

  const saveResponse = () => {
    act('update_answer', {
      qidx,
      answer: userInput,
    });
  };

  const changedResponse = userInput !== response;

  const saveAvailable = !read_only && !!userInput && changedResponse;

  const isSaved = !!response && !changedResponse;

  return (
    <Section
      title={`问题 ${qidx}`}
      buttons={
        <Button
          disabled={!saveAvailable}
          onClick={saveResponse}
          icon={isSaved ? 'check' : 'save'}
        >
          {isSaved ? '已保存' : '保存'}
        </Button>
      }
    >
      <p>{linkifyText(question)}</p>
      {read_only || is_admin ? (
        <BlockQuote>{response || '未回答。'}</BlockQuote>
      ) : (
        <TextArea
          fluid
          height={10}
          maxLength={500}
          onChange={setUserInput}
          onEnter={saveResponse}
          placeholder="在此填写回答，最多 500 个字符。按回车键保存。"
          value={response || undefined}
        />
      )}
    </Section>
  );
};
