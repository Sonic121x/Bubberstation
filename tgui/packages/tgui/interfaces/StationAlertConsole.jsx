import { sortBy } from 'es-toolkit';
import { Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const StationAlertConsole = (props) => {
  const { data } = useBackend();
  const { cameraView } = data;
  return (
    <Window width={cameraView ? 390 : 345} height={587}>
      <Window.Content scrollable>
        <StationAlertConsoleContent />
      </Window.Content>
    </Window>
  );
};

export const StationAlertConsoleContent = (props) => {
  const { act, data } = useBackend();
  const { cameraView } = data;

  const sortingKey = {
    Fire: 0,
    Atmosphere: 1,
    Power: 2,
    Burglar: 3,
    Motion: 4,
    Camera: 5,
  };

  const sortedAlarms = sortBy(data.alarms || [], [
    (alarm) => sortingKey[alarm.name],
  ]);

  return (
    <>
      {sortedAlarms.map((category) => (
        <Section key={category.name} title={`${({Fire:'火灾',Atmosphere:'大气',Power:'电力',Burglar:'防盗',Motion:'移动',Camera:'摄像头'})[category.name] ?? category.name}警报`}>
          <ul>
            {category.alerts.length === 0 && (
              <li className="color-good">系统正常</li>
            )}
            {category.alerts.map((alert) => (
              <Stack key={alert.name} height="30px" align="baseline">
                <Stack.Item grow>
                  <li className="color-average">
                    {alert.name}{' '}
                    {cameraView && alert.sources > 1
                      ? `（${alert.sources} 个来源）`
                      : ''}
                  </li>
                </Stack.Item>
                {!!cameraView && (
                  <Stack.Item>
                    <Button
                      textAlign="center"
                      width="100px"
                      icon={alert.cameras ? 'video' : ''}
                      disabled={!alert.cameras}
                      content={
                        alert.cameras === 1
                          ? `${alert.cameras} 台摄像头`
                          : alert.cameras > 1
                            ? `${alert.cameras} 台摄像头`
                            : '无摄像头'
                      }
                      onClick={() =>
                        act('select_camera', {
                          alert: alert.ref,
                        })
                      }
                    />
                  </Stack.Item>
                )}
              </Stack>
            ))}
          </ul>
        </Section>
      ))}
    </>
  );
};
