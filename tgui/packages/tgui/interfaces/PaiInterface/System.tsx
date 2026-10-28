import { useBackend } from 'tgui/backend';
import { Box, Button, LabeledList, Section, Stack } from 'tgui-core/components';

import type { PaiData } from './types';

export function SystemDisplay(props) {
  return (
    <Stack fill vertical>
      <Stack.Item grow={3}>
        <SystemWallpaper />
      </Stack.Item>
      <Stack.Item grow>
        <SystemInfo />
      </Stack.Item>
    </Stack>
  );
}

/** Renders some ASCII art. Changes to red on emag. */
function SystemWallpaper(props) {
  const { data } = useBackend<PaiData>();
  const { emagged } = data;

  const owner = !emagged ? '纳米传讯' : ' 辛迪加';
  const eyebrows = !emagged ? "/\\ ' /\\" : ' \\\\ // ';

  const paiAscii = [
    ' ________  ________  ___',
    ' |\\   __  \\|\\   __  \\|\\  \\',
    ' \\ \\  \\|\\  \\ \\  \\|\\  \\ \\  \\     操作界面',
    '  \\ \\   ____\\ \\   __  \\ \\  \\     版本 2.5',
    '   \\ \\  \\___|\\ \\  \\ \\  \\ \\  \\',
    '    \\ \\__\\    \\ \\__\\ \\__\\ \\__\\     所属机构',
    `     \\|__|     \\|__|\\|__|\\|__|      ${owner}`,
    '',
  ].join('\n');

  const floofAscii = [
    '                              .--.       .-.',
    "        ,;;``;;-;,,..___.,,.-/   `;_//,.'   )",
    "      .' ;;  `;  :; `;;  ;;  `.       '/   .'",
    `     ,;  ';   ;   '  ';  ';   ,'    ${eyebrows}';`, // lol
    "    /'     `      \\   `     ;','   ( d\\__b_),",
    "   /   /       .,;;)       ', (    .'     __\\",
    "  ;:.  \\     ,_   /         ', ' .'_      \\/;",
    " ,   ,;'      `;;/       /    ';,\\ `-..__._,'",
    " ;:.  /____  ..-'--.    /-'    ..---. ._._/ ---.",
    " |    ;' ;'|        \\--/;' ,' /      \\   ,      \\",
    " `.fL__;,__/-..__)_)/  `--'--'`-._)_)/ --\\.._)_)/",
  ].join('\n');

  return (
    <Section fill nowrap overflow="hidden">
      <pre>
        <Box color={!emagged ? 'blue' : 'crimson'}>{paiAscii}</Box>
        <Box color={!emagged ? 'gold' : 'limegreen'}>{floofAscii}</Box>
      </pre>
    </Section>
  );
}

/** Displays master info.
 * You can check their DNA and change your image here.
 */
function SystemInfo(props) {
  const { act, data } = useBackend<PaiData>();
  const { screen_image_interface_icon, master_dna, master_name } = data;

  return (
    <Section
      buttons={
        <>
          <Button
            disabled={!master_dna}
            icon="dna"
            onClick={() => act('check dna')}
            tooltip="验证主人的 DNA。必须被拿在手中。"
          >
            验证
          </Button>
          <Button
            icon={screen_image_interface_icon}
            onClick={() => act('change image')}
            tooltip="更换显示图像。"
          >
            显示图像
          </Button>
          {/** BUBBER EDIT: pAI self Wipe */}
          <Button
            icon="skull"
            color="bad"
            onClick={() => act('wipe files')}
          >
            清除人格
          </Button>
          {/** BUBBER EDIT END: pAI self wipe */}
        </>
      }
      fill
      title="系统信息"
    >
      <LabeledList>
        <LabeledList.Item label="主人">
          {master_name || '无。'}
        </LabeledList.Item>
        <LabeledList.Item color={master_dna ? 'red' : ''} label="DNA">
          {master_dna || '无。'}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
}
