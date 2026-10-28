import {
  AnimatedNumber,
  Box,
  Button,
  LabeledList,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  points: number;
  pad: string;
  sending: BooleanLike;
  status_report: string;
};

export const CargoHoldTerminal = (props) => {
  const { act, data } = useBackend<Data>();
  const { points, pad, sending, status_report } = data;

  return (
    <Window width={600} height={230}>
      <Window.Content scrollable>
        <Section>
          <LabeledList>
            <LabeledList.Item label="当前货物价值">
              <Box inline bold>
                <AnimatedNumber value={Math.round(points)} /> 信用点
              </Box>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          title="货物传送台"
          buttons={
            <>
              <Button
                icon={'sync'}
                content={'重新计算价值'}
                disabled={!pad}
                onClick={() => act('recalc')}
              />
              <Button
                icon={sending ? 'times' : 'arrow-up'}
                content={sending ? '停止传送' : '传送货物'}
                selected={sending}
                disabled={!pad}
                onClick={() => act(sending ? 'stop' : 'send')}
              />
            </>
          }
        >
          <LabeledList>
            <LabeledList.Item label="状态" color={pad ? 'good' : 'bad'}>
              {pad ? '在线' : '未找到'}
            </LabeledList.Item>
            <LabeledList.Item label="货物报告">
              {status_report}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
