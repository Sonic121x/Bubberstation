import { Button, Section, Stack } from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';
import { chineseDisplay } from '../localization/zhDisplay';
type EchoData = {
  selected_options: string[];
  all_options: string[];
};

export const EcholocationFocus = () => {
  const { data, act } = useBackend<EchoData>();
  const { selected_options, all_options } = data;

  return (
    <Window width={250} height={300}>
      <Window.Content>
        <Section
          title="回声定位设置"
          buttons={
            <Button
              icon="info"
              disabled
              tooltip="设置回声定位所感知或忽略的物体。"
            />
          }
        >
          <Stack vertical>
            {all_options.map((option) => (
              <Stack.Item key={option}>
                <Button.Checkbox
                  checked={selected_options.includes(option)}
                  onClick={() => act('toggle', { option: option })}
                >
                  {chineseDisplay(option)}
                </Button.Checkbox>
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
