import {
  Button,
  LabeledList,
  NumberInput,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import {
  PortableBasicInfo,
  type PortableBasicInfoData,
} from './common/PortableAtmos';

type PortablePumpData = {
  direction: boolean;
  targetPressure: number;
  defaultPressure: number;
  minPressure: number;
  maxPressure: number;
} & PortableBasicInfoData;

export const PortablePump = (props) => {
  const { act, data } = useBackend<PortablePumpData>();
  const {
    direction,
    connected,
    holding,
    targetPressure,
    defaultPressure,
    minPressure,
    maxPressure,
  } = data;
  const pump_or_port = connected ? '接口' : '气泵';
  const area_or_tank = holding ? '气罐' : '区域';
  return (
    <Window width={300} height={340}>
      <Window.Content>
        <PortableBasicInfo />
        <Section
          title="泵送"
          buttons={
            <Button
              color={!direction && !holding ? 'caution' : null}
              onClick={() => act('direction')}
            >
              {direction
                ? `${area_or_tank} → ${pump_or_port}`
                : `${pump_or_port} → ${area_or_tank}`}
            </Button>
          }
        >
          <LabeledList>
            <LabeledList.Item label="输出压力">
              <NumberInput
                value={targetPressure}
                unit="kPa"
                width="75px"
                minValue={minPressure}
                maxValue={maxPressure}
                step={10}
                onChange={(value) =>
                  act('pressure', {
                    pressure: value,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="预设">
              <Button
                icon="minus"
                disabled={targetPressure === minPressure}
                onClick={() =>
                  act('pressure', {
                    pressure: 'min',
                  })
                }
              />
              <Button
                icon="sync"
                disabled={targetPressure === defaultPressure}
                onClick={() =>
                  act('pressure', {
                    pressure: 'reset',
                  })
                }
              />
              <Button
                icon="plus"
                disabled={targetPressure === maxPressure}
                onClick={() =>
                  act('pressure', {
                    pressure: 'max',
                  })
                }
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
