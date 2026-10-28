import { Box, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import { sanitizeText } from '../sanitize';

export const NtosPhysScanner = (props) => {
  const { act, data } = useBackend();
  const { last_record } = data;
  const textHtml = {
    __html: sanitizeText(last_record),
  };
  return (
    <NtosWindow width={600} height={350}>
      <NtosWindow.Content scrollable>
        <Section>
          手持平板电脑轻点目标（右键），即可使用
          物理扫描仪。
        </Section>
        <Section>
          <Box bold>
            最近保存的结果
            <br />
            <br />
          </Box>
          <Box
            style={{ whiteSpace: 'pre-line' }}
            dangerouslySetInnerHTML={textHtml}
          />
        </Section>
      </NtosWindow.Content>
    </NtosWindow>
  );
};
