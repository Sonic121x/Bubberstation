import { useBackend, useSharedState } from 'tgui/backend';
import {
  Button,
  Dropdown,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { Window } from '../layouts';

type Weather = {
  id: string;
  name: string;
  desc: string;
};

type Data = {
  core_charges: number;
  max_core_charge: number;
  weather_charge_cost: number;
  can_summon_weather: BooleanLike;
  can_clear_weather: BooleanLike;
  summonable_weather_types: Weather[];
  active_weather_on_z: Weather[];
};

function formatCharges(charges: number, max_charges: number) {
  return `${(charges / max_charges) * 100}%`;
}

export const AnomalousWeatherTower = () => {
  const { act, data } = useBackend<Data>();
  const {
    core_charges,
    max_core_charge,
    weather_charge_cost,
    can_summon_weather,
    can_clear_weather,
    summonable_weather_types,
    active_weather_on_z,
  } = data;

  const [selectedWeather, setSelectedWeather] = useSharedState(
    'selectedWeather',
    summonable_weather_types[0],
  );

  const winHeight = 420 + active_weather_on_z.length * 30;

  let chargeColor = 'green';
  if (core_charges / max_core_charge <= 0.25) {
    chargeColor = 'red';
  } else if (core_charges / max_core_charge <= 0.5) {
    chargeColor = 'yellow';
  }

  return (
    <Window width={250} height={winHeight} theme="ntos_darkmode">
      <Window.Content>
        <Stack vertical>
          <Stack.Item>
            <Section fontFamily="Consolas, monospace">
              <Stack vertical align="center">
                <Stack.Item fontSize="18px">核心电量</Stack.Item>
                <Stack.Item
                  fontSize="24px"
                  color={chargeColor}
                  backgroundColor="black"
                  pt={1}
                  pb={1}
                  width="50%"
                  textAlign="center"
                  className="AnomalyTower__Charge"
                >
                  {formatCharges(core_charges, max_core_charge)}
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="当前天气" fontFamily="Consolas, monospace">
              {active_weather_on_z.length > 0 ? (
                active_weather_on_z.map((weather) => (
                  <Stack.Item key={weather.id}>
                    <Stack align="center">
                      <Stack.Item grow>{weather.name}</Stack.Item>
                      <Stack.Item>
                        <Button
                          onClick={() =>
                            act('clear_weather', { weather_ref: weather.id })
                          }
                          icon="times"
                          color="red"
                          disabled={!can_clear_weather}
                          tooltip={
                            can_clear_weather
                              ? undefined
                              : '天气抑制器正在充能。'
                          }
                        />
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                ))
              ) : (
                <Stack.Item>
                  <NoticeBox>无</NoticeBox>
                </Stack.Item>
              )}
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <Section
              title="召唤天气"
              fill
              fontFamily="Consolas, monospace"
            >
              <Stack vertical fill>
                <Stack.Item>
                  <Dropdown
                    buttons
                    options={summonable_weather_types.map(
                      (weather) => weather.name,
                    )}
                    selected={selectedWeather.name}
                    onSelected={(weatherName) => {
                      const weather = summonable_weather_types.find(
                        (w) => w.name === weatherName,
                      );
                      if (weather) setSelectedWeather(weather);
                    }}
                  />
                </Stack.Item>
                <Stack.Item className="AnomalyTower__HazardBg" align="center">
                  <Button
                    color="red"
                    m={1}
                    className="AnomalyTower__HazardButton"
                    align="center"
                    onClick={() =>
                      act('summon_weather', {
                        weather_type: selectedWeather.id,
                      })
                    }
                    disabled={
                      !can_summon_weather || core_charges < weather_charge_cost
                    }
                    tooltip={
                      core_charges < weather_charge_cost
                        ? '电量不足，无法召唤天气。'
                        : can_summon_weather
                          ? undefined
                          : '天气线圈正在充能。'
                    }
                  />
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
