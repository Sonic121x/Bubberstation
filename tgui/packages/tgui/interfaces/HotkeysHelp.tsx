import { Box, Button, Section, Table, Tooltip } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type BindingInfo = {
  name: string;
  desc: string;
};

type HotkeyInfo = {
  key: string;
  bindings: BindingInfo[];
};

type HotkeysHelpData = {
  hotkeys: HotkeyInfo[];
};

type KeyBindingBoxProps = {
  keycode: string;
};

type ModkeyProps = {
  text: string;
  color: string;
};

const shiftRegex = /(.*)(Shift)(.*)/;
const ctrlRegex = /(.*)(Ctrl)(.*)/;
const altRegex = /(.*)(Alt)(.*)/;

const addColorModifier = (
  content: string,
  regex: RegExp,
  color: string,
): React.JSX.Element | null => {
  const match = content.match(regex);

  if (match) {
    return (
      <>
        {processColorModifiers(match[1])}
        <Box inline style={{ color }}>
          {match[2]}
        </Box>
        {processColorModifiers(match[3])}
      </>
    );
  }

  return null;
};

const processColorModifiers = (content: string): string | React.JSX.Element => {
  const shifted = addColorModifier(content, shiftRegex, '#88f');

  if (shifted) {
    return shifted;
  }

  const ctrled = addColorModifier(content, ctrlRegex, '#8f8');

  if (ctrled) {
    return ctrled;
  }

  const alted = addColorModifier(content, altRegex, '#fc4');

  if (alted) {
    return alted;
  }

  // Fix the weirdly named keys

  return ` ${content}`
    .replace('Northeast', 'Page Up')
    .replace('Southeast', 'Page Down')
    .replace('Northwest', 'Home')
    .replace('Southwest', 'End')
    .replace('North', '上箭头')
    .replace('South', '下箭头')
    .replace('East', '右箭头')
    .replace('West', '左箭头')
    .replace('Numpad', '数字小键盘 ');
};

const KeyBinding = (props: KeyBindingBoxProps) => (
  <>{processColorModifiers(props.keycode)}</>
);

export const HotkeysHelp = (props) => {
  const { act, data } = useBackend<HotkeysHelpData>();

  return (
    <Window title="快捷键" width={500} height={800}>
      <Window.Content scrollable>
        <Section
          title="按键排序"
          buttons={
            <Button icon="wrench" onClick={() => act('open_keybindings')}>
              打开快捷键设置
            </Button>
          }
        >
          <Table>
            <Table.Row header>
              <Table.Cell textAlign="center" m={1}>
                按键
              </Table.Cell>
              <Table.Cell textAlign="center" m={1}>
                绑定动作
              </Table.Cell>
            </Table.Row>
            {data.hotkeys.map((hotkey) => (
              <Table.Row key={hotkey.key} className="candystripe">
                <Table.Cell bold textAlign="right" p={1}>
                  <KeyBinding keycode={hotkey.key} />
                </Table.Cell>
                <Table.Cell style={{ position: 'relative' }}>
                  {hotkey.bindings.map((binding) =>
                    binding.desc ? (
                      <Tooltip
                        key={binding.name}
                        content={binding.desc}
                        position="bottom"
                      >
                        <Box p={1} m={1} inline className="HotkeysHelp__pill">
                          {binding.name}
                        </Box>
                      </Tooltip>
                    ) : (
                      <Box
                        key={binding.name}
                        p={1}
                        m={1}
                        inline
                        className="HotkeysHelp__pill"
                      >
                        {binding.name}
                      </Box>
                    ),
                  )}
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
