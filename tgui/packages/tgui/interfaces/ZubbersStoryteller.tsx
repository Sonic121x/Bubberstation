import { useState } from 'react';
import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
  Table,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts'; import { storytellerTagDisplay } from '../localization/storytellerTagDisplay';

export type Storyteller_Data = {
  storyteller_name: string;
  storyteller_halt: boolean;
  antag_count: number;
  antag_cap: number;

  pop_data: Record<string, number>;
  tracks_data: Record<string, Storyteller_Track>;
  scheduled_data: Record<string, Record<string, string>>;
  events: Record<string, Storyteller_Event_Category>;
};

export type Storyteller_Track = {
  name: string;
  current: number;
  max: number;
  next: number;
  forced: Storyteller_Event;
};

export type Storyteller_Event = {
  name: string;
  desc: string;
  tags: string[];
  occurences: number;
  occurences_shared: boolean;
  min_pop: number;
  start: number;
  can_run: boolean;
  weight: number;
  weight_raw: number;
  track: string;
  roundstart: boolean;
};

export type Storyteller_Event_Category = {
  name: string;
  events: Record<string, Storyteller_Event>;
};

export const ZubbersStoryteller = (props) => {
  return (
    <Window width={1200} height={680}>
      <Window.Content height="100%">
        <Stack fill vertical>
          <Stack.Item grow>
            <ZubbersStorytellerRoundData />
            <Stack.Divider />
            <ZubbersStorytellerTrackData />
          </Stack.Item>

          <Stack.Item grow>
            <Stack fill vertical>
              <Stack.Item>
                <ZubbersStorytellerScheduledData />
              </Stack.Item>
              <Stack.Item grow>
                <ZubbersStorytellerEventPanel />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

export const ZubbersStorytellerRoundData = (props) => {
  const { act, data } = useBackend<Storyteller_Data>();
  const {
    storyteller_name,
    storyteller_halt,
    pop_data,
    antag_cap,
    antag_count,
  } = data;
  return (
    <Section
      title="叙事者"
      buttons={
        <>
          <Box inline bold mr={1}>
            {storyteller_name}
          </Box>
          <Button onClick={() => act('set_storyteller')}>
            设置叙事者
          </Button>
        </>
      }
    >
      <LabeledList>
        <LabeledList.Item label="叙事者状态">
          <Button
            color={storyteller_halt ? 'red' : 'green'}
            tooltip={`${storyteller_halt ? '恢复' : '暂停'}叙事者`}
            onClick={() => act('halt_storyteller')}
            textAlign="center"
          >
            {storyteller_halt ? '已暂停' : '运行中'}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="活跃玩家">
          {pop_data.active} {'('}主管：{pop_data.head}，安保：{pop_data.sec}，
          工程：{pop_data.eng}，医疗：{pop_data.med}
          {')'}
        </LabeledList.Item>
        <LabeledList.Item
          label="反派上限"
          tooltip="反派人数／反派人数上限"
        >
          <ProgressBar
            value={antag_count}
            maxValue={antag_cap}
            ranges={{
              good: [-Infinity, antag_cap],
              bad: [antag_cap, Infinity],
            }}
          >
            {`${antag_count}/${antag_cap}`}
          </ProgressBar>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const TRACK_DATA_TRACK_WIDTH = '5%';
const TRACK_DATA_POINT_WIDTH = '22%';
const TRACK_DATA_NEXT_WIDTH = '5%';
const TRACK_DATA_FORCED_WIDTH = '20%';
const TRACK_DATA_ACTIONS_WIDTH = '20%';

export const ZubbersStorytellerTrackData = (props) => {
  const { act, data } = useBackend<Storyteller_Data>();
  const { tracks_data, storyteller_halt } = data;
  return (
    <Section title="事件轨道">
      <Table>
        <Table.Row bold>
          <Table.Cell width={TRACK_DATA_TRACK_WIDTH}>轨道</Table.Cell>
          <Table.Cell width={TRACK_DATA_POINT_WIDTH}>点数</Table.Cell>
          <Table.Cell width={TRACK_DATA_NEXT_WIDTH} textAlign="center">
            下次事件
          </Table.Cell>
          <Table.Cell width={TRACK_DATA_FORCED_WIDTH}>
            下次强制事件
          </Table.Cell>
          <Table.Cell width={TRACK_DATA_ACTIONS_WIDTH}>操作</Table.Cell>
        </Table.Row>
        <Stack.Divider />
        {Object.entries(tracks_data).map(([track, track_data]) => {
          const max_points = track_data.max;
          const current_points = track_data.current;
          const forced = track_data.forced ? track_data.forced : 0;
          return (
            <Table.Row key={track}>
              <Table.Cell>
                <Button
                  tooltip="编辑点数"
                  width="100%"
                  textAlign="center"
                  onClick={() =>
                    act('track_action', { action: 'set_pnts', track: track })
                  }
                >
                  {track}
                </Button>
              </Table.Cell>
              <Table.Cell>
                <ProgressBar
                  value={current_points}
                  maxValue={max_points}
                  ranges={{
                    good: [-Infinity, max_points],
                    average: [max_points, Infinity],
                  }}
                >
                  {`${current_points} / ${max_points}`}
                  {' (' +
                    Math.floor((current_points * 100) / max_points) +
                    '%) '}
                </ProgressBar>
              </Table.Cell>
              <Table.Cell textAlign="center">
                {storyteller_halt ? '不适用' : `约 ${track_data.next} 分钟`}
              </Table.Cell>
              <Table.Cell>{forced ? forced.name : ''}</Table.Cell>
              <Table.Cell>
                <Button
                  onClick={() =>
                    act('track_action', { action: 'force_next', track: track })
                  }
                >
                  下一事件
                </Button>
              </Table.Cell>
            </Table.Row>
          );
        })}
      </Table>
    </Section>
  );
};

export const ZubbersStorytellerScheduledData = (props) => {
  const { act, data } = useBackend<Storyteller_Data>();
  const { scheduled_data } = data;
  return (
    <Section title="已安排事件">
      <Table>
        <Table.Row bold>
          <Table.Cell>名称</Table.Cell>
          <Table.Cell>轨道</Table.Cell>
          <Table.Cell>时间</Table.Cell>
          <Table.Cell>操作</Table.Cell>
        </Table.Row>
        {Object.entries(scheduled_data).map(([event_name, event_data]) => {
          const timeNum = Number(event_data.time)?.toFixed(1);
          return (
            <Table.Row key={event_name}>
              <Table.Cell>{event_name}</Table.Cell>
              <Table.Cell>{event_data.track}</Table.Cell>
              <Table.Cell>{timeNum ? `${timeNum} 秒` : '回合开始'}</Table.Cell>
              <Table.Cell>
                <Button
                  color="red"
                  onClick={() =>
                    act('event_action', {
                      action: 'cancel',
                      type: event_data.event_type,
                    })
                  }
                >
                  取消
                </Button>
                <Button
                  onClick={() =>
                    act('event_action', {
                      action: 'refund',
                      type: event_data.event_type,
                    })
                  }
                >
                  退还点数
                </Button>
                <Button
                  onClick={() =>
                    act('event_action', {
                      action: 'reschedule',
                      type: event_data.event_type,
                    })
                  }
                >
                  重新安排
                </Button>
                <Button
                  color="green"
                  onClick={() =>
                    act('event_action', {
                      action: 'fire',
                      type: event_data.event_type,
                    })
                  }
                >
                  触发
                </Button>
              </Table.Cell>
            </Table.Row>
          );
        })}
      </Table>
    </Section>
  );
};

const EVENT_PANEL_NAME_WIDTH = '20%';
const EVENT_PANEL_TAGS_WIDTH = '10%';
const EVENT_PANEL_OCCURENCES_WIDTH = '6%';
const EVENT_PANEL_POP_WIDTH = '6%';
const EVENT_PANEL_MINTIME_WIDTH = '6%';
const EVENT_PANEL_CANRUN_WIDTH = '6%';
const EVENT_PANEL_WEIGHT_WIDTH = '10%';
const EVENT_PANEL_ACTIONS_WIDTH = '20%';

export const ZubbersStorytellerEventPanel = (props) => {
  const { act, data } = useBackend<Storyteller_Data>();
  const { events } = data;

  const eventCategoryTabs = Object.values(events);
  const [currentEventCategory, setCurrentEventCategory] = useState(
    eventCategoryTabs[0],
  );
  const [showRoundstart, setRounstart] = useState(false);

  const eventButtons = () => {
    const event_categories = Object.values(events).map((event_category) => {
      return (
        <Button
          key={event_category.name}
          selected={event_category === currentEventCategory}
          onClick={() => setCurrentEventCategory(event_category)}
        >
          {event_category.name}
        </Button>
      );
    });
    return (
      <Stack>
        <Button.Checkbox
          checked={showRoundstart}
          onClick={() => setRounstart((prevValue) => !prevValue)}
        >
          回合开始
        </Button.Checkbox>
        {event_categories}
      </Stack>
    );
  };

  return (
    <Section
      title="事件面板"
      maxHeight="100%"
      fill
      scrollable
      buttons={eventButtons()}
    >
      <Table>
        <Table.Row bold>
          <Table.Cell width={EVENT_PANEL_NAME_WIDTH}>名称</Table.Cell>
          <Table.Cell width={EVENT_PANEL_TAGS_WIDTH}>标签</Table.Cell>
          <Table.Cell width={EVENT_PANEL_OCCURENCES_WIDTH} textAlign="center">
            次数
          </Table.Cell>
          <Table.Cell width={EVENT_PANEL_POP_WIDTH} textAlign="center">
            最低人数
          </Table.Cell>
          <Table.Cell width={EVENT_PANEL_MINTIME_WIDTH} textAlign="center">
            最早时间
          </Table.Cell>
          <Table.Cell width={EVENT_PANEL_CANRUN_WIDTH} textAlign="center">
            可运行
          </Table.Cell>
          <Table.Cell width={EVENT_PANEL_WEIGHT_WIDTH} textAlign="center">
            权重（原值）
          </Table.Cell>
          <Table.Cell width={EVENT_PANEL_ACTIONS_WIDTH}>操作</Table.Cell>
        </Table.Row>
        <ZubbersStorytellerEventPanelCategory
          current={currentEventCategory}
          roundstart={showRoundstart}
        />
      </Table>
    </Section>
  );
};

type EventPanel_Category_Props = {
  current: Storyteller_Event_Category;
  roundstart: boolean;
};

export const ZubbersStorytellerEventPanelCategory = (
  props: EventPanel_Category_Props,
) => {
  const { current, roundstart } = props;
  return (
    <>
      {Object.entries(current.events)
        .sort((a, b) => b[1].weight - a[1].weight)
        .map(([event_type, event]) => {
          return (
            <ZubbersStorytellerEvent
              key={event_type}
              type={event_type}
              event={event}
            />
          );
        })}
    </>
  );
};

type Event_Props = {
  type: string;
  event: Storyteller_Event;
};

export const ZubbersStorytellerEvent = (props: Event_Props) => {
  const { type, event } = props;
  const { act } = useBackend<Storyteller_Data>();
  return (
    <Table.Row>
      <Table.Cell>
        <Tooltip content={event.desc}>{event.name}</Tooltip>
      </Table.Cell>
      <Table.Cell>
        {Object.values(event.tags).map((tag) => {
          return `${storytellerTagDisplay(tag)} `;
        })}
      </Table.Cell>
      <Table.Cell textAlign="center">
        {event.occurences}
        {event.occurences_shared ? '（共享）' : ''}
      </Table.Cell>
      <Table.Cell textAlign="center">{event.min_pop}</Table.Cell>
      <Table.Cell textAlign="center">
        {event.start}
        {'分钟'}
      </Table.Cell>
      <Table.Cell textAlign="center">{event.can_run ? '是' : '否'}</Table.Cell>
      <Table.Cell textAlign="center">
        {event.weight}
        {` (${event.weight_raw})`}
      </Table.Cell>
      <Table.Cell>
        <Button
          onClick={() =>
            act('panel_action', {
              action: 'fire',
              type: type,
              track: event.track,
            })
          }
        >
          触发
        </Button>
        <Button
          onClick={() =>
            act('panel_action', {
              action: 'schedule',
              type: type,
              track: event.track,
            })
          }
        >
          安排
        </Button>
        <Button
          onClick={() =>
            act('panel_action', {
              action: 'force_next',
              type: type,
              track: event.track,
            })
          }
        >
          下次强制触发
        </Button>
      </Table.Cell>
    </Table.Row>
  );
};
