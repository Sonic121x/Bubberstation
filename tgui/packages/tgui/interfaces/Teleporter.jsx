import { Box, Button, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { batchThreeDisplay } from '../localization/batchThreeDisplay';
export const Teleporter = (props) => {
  const { act, data } = useBackend();
  const {
    calibrated,
    calibrating,
    power_station,
    regime_set,
    teleporter_hub,
    target,
  } = data;
  return (
    <Window width={360} height={130}>
      <Window.Content>
        <Section>
          {(!power_station && (
            <Box color="bad" textAlign="center">
              未连接供电站。
            </Box>
          )) ||
            (!teleporter_hub && (
              <Box color="bad" textAlign="center">
                未连接传送枢纽。
              </Box>
            )) || (
              <LabeledList>
                <LabeledList.Item label="模式">
                  <Button
                    content={batchThreeDisplay(regime_set)}
                    onClick={() => act('regimeset')}
                  />
                </LabeledList.Item>
                <LabeledList.Item label="目标">
                  <Button
                    icon="edit"
                    content={target}
                    onClick={() => act('settarget')}
                  />
                </LabeledList.Item>
                <LabeledList.Item
                  label="校准"
                  buttons={
                    <Button
                      icon="tools"
                      content="校准"
                      onClick={() => act('calibrate')}
                    />
                  }
                >
                  {(calibrating && <Box color="average">进行中</Box>) ||
                    (calibrated && <Box color="good">最佳</Box>) || (
                      <Box color="bad">未达最佳</Box>
                    )}
                </LabeledList.Item>
              </LabeledList>
            )}
        </Section>
      </Window.Content>
    </Window>
  );
};
