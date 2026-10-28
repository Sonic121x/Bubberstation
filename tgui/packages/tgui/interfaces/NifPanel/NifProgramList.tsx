// THIS IS A BUBBER UI FILE
import { useBackend } from 'tgui/backend';
import { Box, Section, Stack } from 'tgui-core/components';
import type { NifPanelData } from './data';
import { NifProgram } from './NifProgram';

export function NifProgramList() {
  const { data } = useBackend<NifPanelData>();
  const { loaded_nifsofts, max_nifsofts } = data;

  return (
    <Section
      title={`纳米植入框架软件（剩余 ${max_nifsofts - loaded_nifsofts.length} 个槽位）`}
    >
      {loaded_nifsofts.length ? (
        <Stack direction="column">
          {loaded_nifsofts.map((nifsoft) => (
            <Stack.Item key={nifsoft.name}>
              <NifProgram src={nifsoft} />
            </Stack.Item>
          ))}
        </Stack>
      ) : (
        <Box p="5px">
          <Box color="grey">目前未安装任何纳米植入框架软件。</Box>
        </Box>
      )}
    </Section>
  );
}
