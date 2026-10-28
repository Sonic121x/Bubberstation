import { Box, Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { ObjectiveElement } from './ObjectiveElement';

type PrimaryObjectiveMenuProps = {
  primary_objectives;
  can_renegotiate;
};

export const PrimaryObjectiveMenu = (props: PrimaryObjectiveMenuProps) => {
  const { act } = useBackend();
  const { primary_objectives, can_renegotiate } = props;
  return (
    <Section fill scrollable align="center">
      <Box my={4} bold fontSize={1.2} color="green">
        欢迎，特工。
      </Box>
      <Box my={4} bold fontSize={1.2}>
        你的主要目标如下。不惜一切代价完成它们。
      </Box>
      <Stack vertical>
        {primary_objectives.map((prim_obj, index) => (
          <Stack.Item key={index}>
            <ObjectiveElement
              key={prim_obj.id}
              name={prim_obj.task_name}
              description={prim_obj.task_text}
            />
          </Stack.Item>
        ))}
      </Stack>
      {!!can_renegotiate && (
        <Box mt={3} mb={5} bold fontSize={1.2} align="center" color="white">
          <Button
            content={'重新协商合同'}
            tooltip={
              '将现有主要目标替换为一个自定义目标。此操作只能执行一次。'
            }
            onClick={() => act('renegotiate_objectives')}
          />
        </Box>
      )}
      <Box my={4} fontSize={0.8}>
        <Box>辛迪操作系统 3.17 版</Box>
        <Box color="green">连接安全</Box>
      </Box>
    </Section>
  );
};
