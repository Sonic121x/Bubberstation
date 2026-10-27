import { Button, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { areaDisplay, type BatchDisplayData } from '../localization/batchThreeDisplay';
type Data = BatchDisplayData & {
  priority: string[];
  minor: string[];
};

export const AtmosAlertConsole = (props) => {
  const { act, data } = useBackend<Data>();
  const { priority = [], minor = [] } = data;

  return (
    <Window width={350} height={300}>
      <Window.Content scrollable>
        <Section title="Alarms">
          <ul>
            {priority.length === 0 && (
              <li className="color-good">No priority alerts</li>
            )}
            {priority.map((alert) => (
              <li key={alert}>
                <Button
                  icon="times"
                  content={areaDisplay(alert, data)}
                  color="bad"
                  onClick={() => act('clear', { zone: alert })}
                />
              </li>
            ))}
            {minor.length === 0 && (
              <li className="color-good">No minor alerts</li>
            )}
            {minor.map((alert) => (
              <li key={alert}>
                <Button
                  icon="times"
                  content={areaDisplay(alert, data)}
                  color="average"
                  onClick={() => act('clear', { zone: alert })}
                />
              </li>
            ))}
          </ul>
        </Section>
      </Window.Content>
    </Window>
  );
};
