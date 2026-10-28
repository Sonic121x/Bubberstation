import { Box, Divider, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  error_message: string | null;
  last_power_output: string | null;
  cold_data: CirculatorData[];
  hot_data: CirculatorData[];
};

type CirculatorData = {
  temperature_inlet: number | null;
  temperature_outlet: number | null;
  pressure_inlet: number | null;
  pressure_outlet: number | null;
};

export const ThermoElectricGenerator = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    error_message,
    last_power_output,
    cold_data = [],
    hot_data = [],
  } = data;
  if (error_message) {
    return (
      <Window width={320} height={100}>
        <Window.Content>
          <Section>错误：{error_message}</Section>
        </Window.Content>
      </Window>
    );
  }
  return (
    <Window width={350} height={195}>
      <Window.Content>
        <Section>
          <Box>
            <Box>上次输出：{last_power_output}</Box>
            <Divider />
            <Box m={1} textColor="cyan" bold>
              冷端循环
            </Box>
            {cold_data.map((data, index) => (
              <Box key={index}>
                <Box>
                  入口温度：{data.temperature_inlet} K / 出口温度：{' '}
                  {data.temperature_outlet} K
                </Box>
                <Box>
                  入口压力：{data.pressure_inlet} kPa / 出口压力：{' '}
                  {data.pressure_outlet} kPa
                </Box>
              </Box>
            ))}
          </Box>
          <Box>
            <Box m={1} textColor="red" bold>
              热端循环{' '}
            </Box>
            {hot_data.map((data, index) => (
              <Box key={index}>
                <Box>
                  入口温度：{data.temperature_inlet} K / 出口温度：{' '}
                  {data.temperature_outlet} K
                </Box>
                <Box>
                  入口压力：{data.pressure_inlet} kPa / 出口压力：{' '}
                  {data.pressure_outlet} kPa
                </Box>
              </Box>
            ))}
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
