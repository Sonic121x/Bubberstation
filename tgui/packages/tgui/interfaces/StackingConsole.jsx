import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts'; import { chineseDisplay } from '../localization/zhDisplay';

export const StackingConsole = (props) => {
  const { act, data } = useBackend();
  const { machine } = data;
  return (
    <Window width={320} height={340}>
      <Window.Content scrollable>
        {!machine ? (
          <NoticeBox>未连接堆叠机</NoticeBox>
        ) : (
          <StackingConsoleContent />
        )}
      </Window.Content>
    </Window>
  );
};

export const StackingConsoleContent = (props) => {
  const { act, data } = useBackend();
  const {
    input_direction,
    output_direction,
    stacking_amount,
    contents = [],
  } = data;
  return (
    <>
      <Section>
        <LabeledList>
          <LabeledList.Item label="堆叠数量">
            {stacking_amount || '未知'}
          </LabeledList.Item>
          <LabeledList.Item
            label="输入"
            buttons={
              <Button
                icon="rotate"
                content="旋转"
                onClick={() =>
                  act('rotate', {
                    input: 1,
                  })
                }
              />
            }
          >
            <Box style={{ textTransform: 'capitalize' }}>{chineseDisplay(input_direction)}</Box>
          </LabeledList.Item>
          <LabeledList.Item
            label="输出"
            buttons={
              <Button
                icon="rotate"
                content="旋转"
                onClick={() =>
                  act('rotate', {
                    input: 0,
                  })
                }
              />
            }
          >
            <Box style={{ textTransform: 'capitalize' }}>
              {chineseDisplay(output_direction)}
            </Box>
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="已存材料">
        {!contents.length ? (
          <NoticeBox>没有已存材料</NoticeBox>
        ) : (
          <LabeledList>
            {contents.map((sheet) => (
              <LabeledList.Item
                key={sheet.type}
                label={sheet.name}
                buttons={
                  <Button
                    icon="eject"
                    content="释放"
                    onClick={() =>
                      act('release', {
                        type: sheet.type,
                      })
                    }
                  />
                }
              >
                {sheet.amount || '未知'}
              </LabeledList.Item>
            ))}
          </LabeledList>
        )}
      </Section>
    </>
  );
};
