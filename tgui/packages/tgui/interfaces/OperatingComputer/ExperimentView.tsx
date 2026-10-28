import { Button, NoticeBox, Section, Stack } from 'tgui-core/components';
import { useBackend } from '../../backend';
import { Experiment, TechwebServer } from '../ExperimentConfigure';
import type { OperatingComputerData } from './types';

export const ExperimentView = () => {
  const { act, data } = useBackend<OperatingComputerData>();
  const { techwebs, experiments } = data;

  return (
    <Stack vertical fill>
      <Stack.Item>
        <Section
          title="服务器"
          fill
          buttons={
            <Button onClick={() => act('open_experiments')}>打开配置</Button>
          }
        >
          <TechwebServer techwebs={techwebs} can_select={false} />
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <Stack vertical fill>
          {techwebs.some((e) => e.selected) && (
            <Stack.Item grow>
              <Section title="实验" scrollable fill>
                {experiments.length > 0 ? (
                  experiments
                    .sort((a, b) => (a.name > b.name ? 1 : -1))
                    .map((exp, i) => (
                      <Experiment key={i} exp={exp} can_select={false} />
                    ))
                ) : (
                  <NoticeBox color="yellow">未找到实验！</NoticeBox>
                )}
              </Section>
            </Stack.Item>
          )}
        </Stack>
      </Stack.Item>
    </Stack>
  );
};
