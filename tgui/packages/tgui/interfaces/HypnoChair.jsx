import {
  Button,
  Icon,
  Input,
  LabeledList,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const HypnoChair = (props) => {
  const { act, data } = useBackend();
  return (
    <Window width={375} height={480}>
      <Window.Content>
        <Section title="信息" backgroundColor="#450F44">
          强化审讯舱旨在为受试者植入根深蒂固的
          恍惚状态触发暗示。程序完成后，
          执法人员只需说出植入的触发语，
          即可确保受试者立即完全服从并如实回答。
        </Section>
        <Section title="舱内人员信息" textAlign="center">
          <LabeledList>
            <LabeledList.Item label="姓名">
              {data.occupant.name ? data.occupant.name : '无人'}
            </LabeledList.Item>
            {!!data.occupied && (
              <LabeledList.Item
                label="状态"
                color={
                  data.occupant.stat === 0
                    ? 'good'
                    : data.occupant.stat === 1
                      ? 'average'
                      : 'bad'
                }
              >
                {data.occupant.stat === 0
                  ? '清醒'
                  : data.occupant.stat === 1
                    ? '昏迷'
                    : '死亡'}
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
        <Section title="操作" textAlign="center">
          <LabeledList>
            <LabeledList.Item label="舱门">
              <Button
                icon={data.open ? 'unlock' : 'lock'}
                color={data.open ? 'default' : 'red'}
                content={data.open ? '开启' : '关闭'}
                onClick={() => act('door')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="触发语">
              <Input
                value={data.trigger}
                onBlur={(value) =>
                  act('set_phrase', {
                    phrase: value,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="审讯舱内人员">
              <Button
                icon="code-branch"
                content={
                  data.interrogating
                    ? '中断审讯'
                    : '开始强化审讯'
                }
                onClick={() => act('interrogate')}
              />
              {data.interrogating === 1 && (
                <Icon name="cog" color="orange" spin />
              )}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
