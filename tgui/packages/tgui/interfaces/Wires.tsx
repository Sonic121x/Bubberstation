import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts'; import { wireDisplay } from '../localization/wireDisplay';

type Data = {
  proper_name: string;
  wires: Wire[];
  status: string[];
};

type Wire = {
  color: string;
  shownColor: string;
  cut: BooleanLike;
  attached: BooleanLike;
  wire: string;
};

export const Wires = (props) => {
  const { data } = useBackend<Data>();
  const { proper_name, status = [], wires = [] } = data;
  const dynamicHeight = 150 + wires.length * 30 + (proper_name ? 30 : 0);

  return (
    <Window width={350} height={dynamicHeight}>
      <Window.Content>
        <Stack fill vertical>
          {!!proper_name && (
            <Stack.Item>
              <NoticeBox textAlign="center">
                {proper_name} 接线配置
              </NoticeBox>
            </Stack.Item>
          )}
          <Stack.Item grow>
            <Section fill>
              <WireMap />
            </Section>
          </Stack.Item>
          {!!status.length && (
            <Stack.Item>
              <Section>
                {status.map((status) => (
                  <Box key={status}>{status}</Box>
                ))}
              </Section>
            </Stack.Item>
          )}
        </Stack>
      </Window.Content>
    </Window>
  );
};

/** Returns a labeled list of wires */
const WireMap = (props) => {
  const { act, data } = useBackend<Data>();
  const { wires } = data;

  return (
    <LabeledList>
      {wires.map((wire) => (
        <LabeledList.Item
          key={wire.color}
          className="candystripe"
          label={wireDisplay(wire.shownColor)}
          labelColor={wire.shownColor.replace(' ', '')}
          color={wire.shownColor.replace(' ', '')}
          buttons={
            <>
              <Button
                content={wire.cut ? '接合' : '剪断'}
                onClick={() =>
                  act('cut', {
                    wire: wire.color,
                  })
                }
              />
              <Button
                content="脉冲"
                onClick={() =>
                  act('pulse', {
                    wire: wire.color,
                  })
                }
              />
              <Button
                content={wire.attached ? '拆下' : '连接'}
                onClick={() =>
                  act('attach', {
                    wire: wire.color,
                  })
                }
              />
            </>
          }
        >
          {!!wire.wire && <i>({wire.wire})</i>}
        </LabeledList.Item>
      ))}
    </LabeledList>
  );
};
