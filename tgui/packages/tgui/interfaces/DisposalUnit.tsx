import {
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type DisposalUnitData = {
  flush: boolean;
  full_pressure: boolean;
  pressure_charging: boolean;
  panel_open: boolean;
  per: number;
  isai: boolean;
};

export const DisposalUnit = (props) => {
  const { act, data } = useBackend<DisposalUnitData>();
  const { flush, full_pressure, pressure_charging, panel_open, per, isai } =
    data;
  let stateColor: string;
  let stateText: string;
  if (full_pressure) {
    stateColor = 'good';
    stateText = '就绪';
  } else if (panel_open) {
    stateColor = 'bad';
    stateText = '电源已禁用';
  } else if (pressure_charging) {
    stateColor = 'average';
    stateText = '加压中';
  } else {
    stateColor = 'bad';
    stateText = '关闭';
  }
  return (
    <Window width={300} height={180}>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="状态" color={stateColor}>
              {stateText}
            </LabeledList.Item>
            <LabeledList.Item label="压力">
              <ProgressBar value={per} color="good" />
            </LabeledList.Item>
            <LabeledList.Item label="手柄">
              <Button
                icon={flush ? 'toggle-on' : 'toggle-off'}
                disabled={isai || panel_open}
                onClick={() => act(flush ? 'handle-0' : 'handle-1')}
              >
                {flush ? '松开' : '拉下'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="弹出">
              <Button
                icon="sign-out-alt"
                disabled={isai}
                onClick={() => act('eject')}
              >
                弹出内容物
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="电源">
              <Button
                icon="power-off"
                disabled={panel_open}
                selected={pressure_charging}
                onClick={() => act(pressure_charging ? 'pump-0' : 'pump-1')}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
