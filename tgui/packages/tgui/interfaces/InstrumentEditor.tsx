import {
  Box,
  Button,
  Collapsible,
  Divider,
  Dropdown,
  NumberInput,
  Section,
  Stack,
  Input,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  id: string;
  using_instrument: string;
  note_shift_min: number;
  note_shift_max: number;
  note_shift: number;
  octaves: number;
  sustain_modes: string[];
  sustain_mode: string;
  sustain_mode_button: string;
  sustain_mode_duration: number;
  instrument_ready: BooleanLike;
  volume: number;
  volume_dropoff_threshold: number;
  min_volume: number;
  max_volume: number;
  sustain_indefinitely: BooleanLike;
  sustain_mode_min: number;
  sustain_mode_max: number;
  playing: BooleanLike;
  max_repeats: number;
  repeat: number;
  bpm: number;
  lines: LineData[];
  can_switch_instrument: BooleanLike;
  possible_instruments: InstrumentData[];
  max_line_chars: number;
  max_lines: number;
};

type InstrumentData = {
  name: string;
  id: string;
};

type LineData = {
  line_count: number;
  line_text: string;
};

export const InstrumentEditor = (props) => {
  const { data } = useBackend<Data>();

  return (
    <Window width={750} height={500}>
      <Window.Content scrollable>
        <InstrumentSettings />
        <Collapsible open title="音乐编辑器" icon="pencil">
          <EditingSettings />
        </Collapsible>
        <Collapsible title="帮助" icon="question">
          <HelpSection />
        </Collapsible>
      </Window.Content>
    </Window>
  );
};

const InstrumentSettings = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    id,
    playing,
    repeat,
    max_repeats,
    can_switch_instrument,
    possible_instruments = [],
    instrument_ready,
    using_instrument,
    note_shift_min,
    note_shift_max,
    note_shift,
    octaves,
    sustain_modes,
    sustain_mode,
    sustain_mode_button,
    sustain_mode_duration,
    sustain_indefinitely,
    sustain_mode_min,
    sustain_mode_max,
    volume,
    min_volume,
    max_volume,
    volume_dropoff_threshold,
    lines,
  } = data;

  const instrument_id_by_name = (name) => {
    return possible_instruments.find((instrument) => instrument.name === name)
      ?.id;
  };

  return (
    <Section title="设置">
      {lines.length > 0 && (
        <Box fontSize="16px" mb={1}>
          <Button onClick={() => act('play_music')}>
            {playing ? '停止音乐' : '开始演奏'}
          </Button>
        </Box>
      )}
      <Box>
        <Box
          inline
          style={{
            borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
          }}
          mr={1}
        >
          <Tooltip
            content="附近所有使用相同标识的乐器，
               会在其中一件开始演奏时一同演奏同一首曲子。"
          >
            标识：
          </Tooltip>
        </Box>
        <Input
          value={id}
          maxLength={20}
          onChange={(value) => act('set_instrument_id', { id: value })}
        />
      </Box>
      <Box>
        剩余重复次数：
        <NumberInput
          ml={1}
          step={1}
          minValue={0}
          disabled={!!playing}
          maxValue={max_repeats}
          value={repeat}
          onChange={(value) =>
            act('set_repeat_amount', {
              amount: value,
            })
          }
        />
      </Box>
      <Box>
        {!!can_switch_instrument && (
          <Stack fill>
            <Stack.Item mt={0.5}>当前乐器</Stack.Item>
            <Stack.Item grow>
              <Dropdown
                width="40%"
                selected={using_instrument}
                disabled={!can_switch_instrument}
                options={possible_instruments.map(
                  (instrument) => instrument.name,
                )}
                onSelected={(value) =>
                  act('change_instrument', {
                    new_instrument: instrument_id_by_name(value),
                  })
                }
              />
            </Stack.Item>
          </Stack>
        )}
      </Box>
      <Stack mt={1}>
        <Stack.Item>
          演奏设置：
          <Box>
            <NumberInput
              minValue={note_shift_min}
              maxValue={note_shift_max}
              step={1}
              value={note_shift}
              onChange={(value) =>
                act('set_note_shift', {
                  amount: value,
                })
              }
            />
            个半音 / {octaves} 个八度
          </Box>
          <Stack>
            <Stack.Item mt={0.5}>模式：</Stack.Item>
            <Stack.Item grow>
              <Dropdown
                width="100%"
                selected={sustain_mode} displayText={sustain_mode === 'Linear' ? '线性' : sustain_mode === 'Exponential' ? '指数' : sustain_mode}
                options={sustain_modes.map((value) => ({ value, displayText: value === 'Linear' ? '线性' : value === 'Exponential' ? '指数' : value }))}
                onSelected={(value) =>
                  act('set_sustain_mode', {
                    new_mode: value,
                  })
                }
              />
            </Stack.Item>
          </Stack>
          <Box>
            {sustain_mode_button}:
            <NumberInput
              ml={1}
              step={1}
              minValue={sustain_mode_min}
              maxValue={sustain_mode_max}
              value={sustain_mode_duration}
              onChange={(value) =>
                act('edit_sustain_mode', {
                  amount: value,
                })
              }
            />
          </Box>
        </Stack.Item>
        <Divider vertical />
        <Stack.Item>
          <Box>
            状态：
            {instrument_ready ? (
              <span style={{ color: '#5EFB6E' }}> 就绪</span>
            ) : (
              <span style={{ color: '#FF0000' }}>
                {' '}
                乐器定义错误！
              </span>
            )}
          </Box>
          <Box>
            音量：
            <NumberInput
              step={1}
              minValue={min_volume}
              maxValue={max_volume}
              value={volume}
              onChange={(value) =>
                act('set_volume', {
                  amount: value,
                })
              }
            />
          </Box>
          <Box>
            音量衰减阈值：
            <NumberInput
              step={1}
              minValue={1}
              maxValue={100}
              value={volume_dropoff_threshold}
              onChange={(value) =>
                act('set_dropoff_volume', {
                  amount: value,
                })
              }
            />
          </Box>
          <Box>
            <Button onClick={() => act('toggle_sustain_hold_indefinitely')}>
              {sustain_indefinitely
                ? '无限延长最后保持的音符'
                : '不无限延长最后保持的音符'}
            </Button>
          </Box>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const EditingSettings = (props) => {
  const { act, data } = useBackend<Data>();
  const { bpm, lines } = data;

  return (
    <Section>
      <Box>
        <Button onClick={() => act('start_new_song')}>新建曲目</Button>
        <Button onClick={() => act('import_song')}>导入曲目</Button>
      </Box>
      <Box>
        节拍速度：{' '}
        <Button
          onClick={() => act('tempo', { tempo_change: 'increase_speed' })}
        >
          -
        </Button>{' '}
        {bpm} BPM{' '}
        <Button
          onClick={() => act('tempo', { tempo_change: 'decrease_speed' })}
        >
          +
        </Button>
      </Box>
      <Box>
        {lines.map((line, index) => (
          <Box key={index} fontSize="11px">
            第 {index} 行：
            <Button
              onClick={() =>
                act('modify_line', { line_editing: line.line_count })
              }
            >
              编辑
            </Button>
            <Button
              onClick={() =>
                act('delete_line', { line_deleted: line.line_count })
              }
            >
              X
            </Button>
            {line.line_text}
          </Box>
        ))}
      </Box>
      <Box>
        <Button onClick={() => act('add_new_line')}>添加一行</Button>
      </Box>
    </Section>
  );
};

const HelpSection = (props) => {
  const { data } = useBackend<Data>();
  const { max_line_chars, max_lines } = data;

  return (
    <Section>
      <Box>
        每行由一系列以英文逗号（,）分隔的和弦组成，
        每个和弦的音符用连字符（-）分隔。
        <br />
        和弦中的所有音符同时演奏，持续时间由节拍速度决定。
        <br />
        音符使用音名表示，也可以附加
        升降记号和八度编号。
        <br />
        默认情况下，各音符均为第 3 八度的本位音。对音符另作设置后，
        系统会记住该音符的设置。
        <br />
        例如：<i>C,D,E,F,G,A,B</i> 会演奏 C 大调音阶。
        <br />
        音符的升降与八度设置会沿用到后续同名音符：{' '}
        <i>C,C4,C,C3</i> 等同于 <i>C3,C4,C4,C3</i>
        <br />
        用连字符分隔音符即可演奏和弦：{' '}
        <i>A-C#,Cn-E,E-G#,Gn-B</i>
        <br />空和弦表示休止：<i>C,E,,C,G</i>
        <br />
        如需改变和弦时长，在末尾添加 /x，和弦
        的持续时间将等于
        <br />
        节拍速度规定的时长除以 x：<i>C,G/2,E/4</i>
        <br />
        综合示例：<i>E-E4/4,F#/2,G#/8,B/8,E3-E4/4</i>
        <br />
        每行最多可包含 {max_line_chars} 个字符。
        <br />每首曲目最多可包含 {max_lines} 行。
        <br />
      </Box>
    </Section>
  );
};
