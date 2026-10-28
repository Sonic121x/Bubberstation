import {
  BlockQuote,
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  candidates: ReadonlyArray<Candidate>;
  pai: Pai;
  range_max: number;
  range_min: number;
};

type Candidate = Readonly<{
  comments: string;
  ckey: string;
  description: string;
  name: string;
}>;

type Pai = {
  can_holo: BooleanLike;
  dna: string;
  emagged: BooleanLike;
  laws: string;
  master: string;
  name: string;
  transmit: BooleanLike;
  receive: BooleanLike;
  leashed: BooleanLike;
  range: number;
};

export const PaiCard = (props) => {
  const { data } = useBackend<Data>();
  const { pai } = data;

  return (
    <Window width={400} height={400} title="pAI 选项菜单">
      <Window.Content scrollable>
        {!pai ? <PaiDownload /> : <PaiOptions />}
      </Window.Content>
    </Window>
  );
};

/** Gives a list of candidates as cards */
const PaiDownload = (props) => {
  const { act, data } = useBackend<Data>();
  const { candidates = [] } = data;

  return (
    <Stack fill vertical>
      <Stack.Item>
        <NoticeBox info>
          <Stack fill>
            <Stack.Item grow fontSize="16px">
              pAI 候选人格
            </Stack.Item>
            <Stack.Item>
              <Button
                color="good"
                icon="bell"
                onClick={() => act('request')}
                tooltip="向彼岸请求更多候选人格。"
              >
                请求
              </Button>
            </Stack.Item>
          </Stack>
        </NoticeBox>
      </Stack.Item>
      {candidates.map((candidate, index) => {
        return (
          <Stack.Item key={index}>
            <CandidateDisplay candidate={candidate} index={index + 1} />
          </Stack.Item>
        );
      })}
    </Stack>
  );
};

/**
 * Renders a custom section that displays a candidate.
 */
const CandidateDisplay = (props: { candidate: Candidate; index: number }) => {
  const { act } = useBackend<Data>();
  const {
    candidate: { comments, ckey, description, name },
    index,
  } = props;

  return (
    <Section
      buttons={
        <Button icon="save" onClick={() => act('download', { ckey })}>
          下载
        </Button>
      }
      overflow="hidden"
      title={`候选人格 ${index}`}
    >
      <Stack vertical>
        <Stack.Item>
          <Box color="label" mb={1}>
            名称：
          </Box>
          {name ? (
            <Box color="green">{name}</Box>
          ) : (
            '未提供名称，将随机生成。'
          )}
        </Stack.Item>
        {!!description && (
          <>
            <Stack.Divider />
            <Stack.Item>
              <Box color="label" mb={1}>
                角色内描述：
              </Box>
              {description}
            </Stack.Item>
          </>
        )}
        {!!comments && (
          <>
            <Stack.Divider />
            <Stack.Item>
              <Box color="label" mb={1}>
                角色外备注：
              </Box>
              {comments}
            </Stack.Item>
          </>
        )}
      </Stack>
    </Section>
  );
};

/** Once a pAI has been loaded, you can alter its settings here */
const PaiOptions = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    range_max,
    range_min,
    pai: {
      can_holo,
      dna,
      emagged,
      laws,
      master,
      name,
      transmit,
      receive,
      leashed,
      range,
    },
  } = data;
  const suppliedLaws = laws[0] ? decodeHtmlEntities(laws[0]) : '无';

  return (
    <Section fill scrollable title={`设置：${name.toUpperCase()}`}>
      <LabeledList>
        <LabeledList.Item label="主人">
          {master || (
            <Button icon="dna" onClick={() => act('set_dna')}>
              铭刻
            </Button>
          )}
        </LabeledList.Item>
        {!!master && (
          <LabeledList.Item color="red" label="DNA">
            {dna}
          </LabeledList.Item>
        )}
        <LabeledList.Item label="法则">
          <BlockQuote>{suppliedLaws}</BlockQuote>
        </LabeledList.Item>
        <LabeledList.Item label="全息形态">
          <Button
            icon={can_holo ? 'toggle-on' : 'toggle-off'}
            onClick={() => act('toggle_holo')}
            selected={can_holo}
          >
            切换
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="活动限制">
          <Button
            icon={leashed ? 'toggle-on' : 'toggle-off'}
            onClick={() => act('toggle_leash')}
            selected={leashed}
          >
            {leashed ? '解除限制' : '限制活动'}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="全息形态范围">
          <Stack>
            <Stack.Item>
              <Button
                icon="fa-circle-minus"
                onClick={() => act('decrease_range')}
                disabled={range === range_min}
              />
            </Stack.Item>
            <Stack.Item mt={0.5}>{range}</Stack.Item>
            <Stack.Item>
              <Button
                icon="fa-circle-plus"
                onClick={() => act('increase_range')}
                disabled={range === range_max}
              />
            </Stack.Item>
          </Stack>
        </LabeledList.Item>
        <LabeledList.Item label="发送">
          <Button
            icon={transmit ? 'toggle-on' : 'toggle-off'}
            onClick={() => act('toggle_radio', { option: 'transmit' })}
            selected={transmit}
          >
            切换
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="接收">
          <Button
            icon={receive ? 'toggle-on' : 'toggle-off'}
            onClick={() => act('toggle_radio', { option: 'receive' })}
            selected={receive}
          >
            切换
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="故障排除">
          <Button icon="comment" onClick={() => act('fix_speech')}>
            修复语音
          </Button>
          <Button icon="edit" onClick={() => act('set_laws')}>
            设置法则
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="人格">
          <Button icon="trash" onClick={() => act('wipe_pai')}>
            清除
          </Button>
        </LabeledList.Item>
      </LabeledList>
      {!!emagged && (
        <Button
          color="bad"
          icon="bug"
          mt={1}
          onClick={() => act('reset_software')}
        >
          重置软件
        </Button>
      )}
    </Section>
  );
};
