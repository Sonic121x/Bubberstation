import { Button, LabeledList, NoticeBox, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const ProbingConsole = (props) => {
  const { act, data } = useBackend();
  const { open, feedback, occupant, occupant_name, occupant_status } = data;
  return (
    <Window width={330} height={207} theme="abductor">
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="机器报告">
              {feedback}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          title="扫描仪"
          buttons={
            <Button
              icon={open ? 'sign-out-alt' : 'sign-in-alt'}
              content={open ? '关闭' : '打开'}
              onClick={() => act('door')}
            />
          }
        >
          {(occupant && (
            <LabeledList>
              <LabeledList.Item label="姓名">{occupant_name}</LabeledList.Item>
              <LabeledList.Item
                label="状态"
                color={
                  occupant_status === 3
                    ? 'bad'
                    : occupant_status === 2
                      ? 'average'
                      : 'good'
                }
              >
                {occupant_status === 3
                  ? '死亡'
                  : occupant_status === 2
                    ? '昏迷'
                    : '清醒'}
              </LabeledList.Item>
              <LabeledList.Item label="实验">
                <Button
                  icon="thermometer"
                  content="探查"
                  onClick={() =>
                    act('experiment', {
                      experiment_type: 1,
                    })
                  }
                />
                <Button
                  icon="brain"
                  content="解剖"
                  onClick={() =>
                    act('experiment', {
                      experiment_type: 2,
                    })
                  }
                />
                <Button
                  icon="search"
                  content="分析"
                  onClick={() =>
                    act('experiment', {
                      experiment_type: 3,
                    })
                  }
                />
              </LabeledList.Item>
            </LabeledList>
          )) || <NoticeBox>无实验对象</NoticeBox>}
        </Section>
      </Window.Content>
    </Window>
  );
};
