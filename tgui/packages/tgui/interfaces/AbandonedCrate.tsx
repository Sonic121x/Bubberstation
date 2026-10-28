import { Box, Button, NoticeBox, Section, Table } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  previous_attempts: Attempts[];
  attempts_left: number;
};

type Attempts = {
  attempt: string;
  bulls: number;
  cows: number;
};

const check_attempts = (attempts_to_check: number) => {
  return attempts_to_check === 1
    ? '在下次解锁失败时启动。'
    : `在 ${attempts_to_check} 次解锁失败后启动。`;
};

const BULLS_COWS_INFO = `密码由一串不重复的数字组成。
每次猜错后，会显示数字和位置都正确的个数，
以及数字正确但位置错误的个数。`;

export const AbandonedCrate = (props) => {
  const { data } = useBackend<Data>();
  const { previous_attempts, attempts_left } = data;

  return (
    <Window width={335} height={180 + previous_attempts.length * 19}>
      <Window.Content scrollable>
        <Section
          title="十进制密码锁"
          buttons={
            <Button
              tooltip={BULLS_COWS_INFO}
              icon="info"
              tooltipPosition="top"
            />
          }
        >
          <NoticeBox color="bad">
            防拆炸弹将{check_attempts(attempts_left)}
          </NoticeBox>
          <Table>
            {!!previous_attempts.length && (
              <Table.Row fontSize="125%" bold>
                <Table.Cell
                  collapsing
                  color="white"
                  textAlign="center"
                  pr="5px"
                >
                  尝试
                </Table.Cell>
                <Table.Cell collapsing textAlign="center">
                  <Button
                    tooltip={`数字和位置都正确`}
                    icon="check"
                    color="green"
                  />
                </Table.Cell>
                <Table.Cell collapsing textAlign="center">
                  <Button
                    tooltip={`数字正确但位置错误`}
                    icon="asterisk"
                    color="yellow"
                  />
                </Table.Cell>
              </Table.Row>
            )}
            {previous_attempts.map((previous_attempts) => (
              <Table.Row
                key={previous_attempts.attempt}
                style={{ borderTop: '2px solid #222' }}
              >
                <Table.Cell collapsing textAlign="center" pr="5px">
                  <Box color="white" inline fontSize="125%">
                    {previous_attempts.attempt}
                  </Box>
                </Table.Cell>
                <Table.Cell collapsing textAlign="center">
                  <Box color="green" inline fontSize="125%">
                    {previous_attempts.bulls}
                  </Box>
                </Table.Cell>
                <Table.Cell collapsing textAlign="center">
                  <Box color="yellow" inline fontSize="125%">
                    {previous_attempts.cows}
                  </Box>
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
