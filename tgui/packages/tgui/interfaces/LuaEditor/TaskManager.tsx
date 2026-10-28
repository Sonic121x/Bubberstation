import type { Dispatch, SetStateAction } from 'react';
import { Button, LabeledList, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { CallInfo, LuaEditorData, LuaEditorModal } from './types';

type TaskManagerProps = {
  setToCall: Dispatch<SetStateAction<CallInfo>>;
  setModal: Dispatch<SetStateAction<LuaEditorModal>>;
};

export const TaskManager = (props: TaskManagerProps) => {
  const { act, data } = useBackend<LuaEditorData>();
  const { setToCall, setModal } = props;
  const { tasks } = data;
  const { sleeps = [], yields = [] } = tasks;
  return (
    <Stack fill width="100%" justify="space-around">
      <Stack.Item grow shrink>
        <Section title="休眠任务" fill>
          <LabeledList>
            {sleeps.map(({ index, name }, i) => (
              <LabeledList.Item key={i} label={name}>
                <Button
                  color="red"
                  icon="window-close"
                  onClick={() =>
                    act('killTask', { is_sleep: true, index: index })
                  }
                >
                  终止
                </Button>
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item grow shrink>
        <Section title="挂起任务" fill>
          <LabeledList>
            {yields.map(({ index, name }, i) => (
              <LabeledList.Item key={i} label={name}>
                <Button
                  onClick={() => {
                    setToCall({
                      type: 'resumeTask',
                      params: { index: index },
                    });
                    setModal('call');
                  }}
                >
                  调用
                </Button>
                <Button
                  color="red"
                  icon="window-close"
                  onClick={() => {
                    act('killTask', { is_sleep: false, index: index });
                  }}
                >
                  终止
                </Button>
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
