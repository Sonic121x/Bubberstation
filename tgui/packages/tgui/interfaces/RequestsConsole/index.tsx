import { Button, Stack } from 'tgui-core/components';
import { areaDisplay } from '../../localization/batchThreeDisplay';
import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { RequestsConsoleHeader } from './RequestsConsoleHeader';
import { RequestMainScreen } from './RequestsConsoleMainScreen';
import type { RequestsData } from './types';
import { machineChoiceDisplay } from '../common/machineChoiceDisplay';
export const RequestsConsole = (props) => {
  const { act, data } = useBackend<RequestsData>();
  const { department } = data;
  return (
    <Window title={`${machineChoiceDisplay(areaDisplay(department, data))}请求控制台`} width={500} height={600}>
      <Window.Content>
        <RequestsConsoleContent />
      </Window.Content>
    </Window>
  );
};

const RequestsConsoleContent = (props) => {
  const { act, data } = useBackend<RequestsData>();
  return (
    <Stack vertical fill>
      <RequestsConsoleHeader />
      <RequestMainScreen />
      <RequestsConsoleFooter />
    </Stack>
  );
};

const RequestsConsoleFooter = (props) => {
  const { act, data } = useBackend<RequestsData>();
  const { silent } = data;
  return (
    <Stack.Item>
      <Button.Checkbox
        fluid
        checked={!silent}
        content={'扬声器'}
        onClick={() => {
          act('toggle_silent');
        }}
      />
    </Stack.Item>
  );
};
