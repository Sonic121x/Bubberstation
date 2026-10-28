import { useBackend } from 'tgui/backend';
import { Button, LabeledList, NumberInput } from 'tgui-core/components';
import { Window } from '../layouts';

type Data = {
  threshold: number;
  connections: number;
};

export const ChemAutomaticBuffer = () => {
  const { act, data } = useBackend<Data>();
  const { threshold, connections } = data;
  return (
    <Window width={250} height={120}>
      <Window.Content>
        <LabeledList>
          <LabeledList.Item label="阈值">
            <NumberInput
              minValue={1}
              maxValue={200}
              value={threshold}
              step={1}
              onChange={(value) =>
                act('set_threshold', {
                  threshold: value,
                })
              }
            />
          </LabeledList.Item>
          <LabeledList.Item label="连接数">
            {connections || '无'}
          </LabeledList.Item>
          <LabeledList.Item label="同步">
            <Button onClick={() => act('sync')}>同步数值</Button>
          </LabeledList.Item>
        </LabeledList>
      </Window.Content>
    </Window>
  );
};
