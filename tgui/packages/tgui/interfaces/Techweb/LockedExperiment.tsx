import { Box, Button, Flex, Icon } from 'tgui-core/components';

export function LockedExperiment(props) {
  return (
    <Box m={1} className="ExperimentConfigure__ExperimentPanel">
      <Button
        fluid
        backgroundColor="#40628a"
        className="ExperimentConfigure__ExperimentName"
        disabled
      >
        <Flex align="center" justify="space-between">
          <Flex.Item color="rgba(0, 0, 0, 0.6)">
            <Icon name="lock" />
            尚未发现的实验
          </Flex.Item>
          <Flex.Item color="rgba(0, 0, 0, 0.5)">???</Flex.Item>
        </Flex>
      </Button>
      <Box className="ExperimentConfigure__ExperimentContent">
        此实验尚未被发现，请继续研究科技树上的节点，
        以揭示该实验的内容。
      </Box>
    </Box>
  );
}
