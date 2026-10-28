import { sortBy } from 'es-toolkit';
import {
  Box,
  Button,
  Flex,
  ProgressBar,
  Section,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts'; import { displayRole } from '../localization/roleDisplay';

const JOB_REPORT_MENU_FAIL_REASON_TRACKING_DISABLED = 1;
const JOB_REPORT_MENU_FAIL_REASON_NO_RECORDS = 2;

const sortByPlaytime = (array) => sortBy(array, [([_, playtime]) => -playtime]);

const PlaytimeSection = (props) => {
  const { playtimes } = props;

  const sortedPlaytimes = sortByPlaytime(Object.entries(playtimes)).filter(
    (entry) => entry[1],
  );

  if (!sortedPlaytimes.length) {
    return '此分类没有游戏时长记录。';
  }

  const mostPlayed = sortedPlaytimes[0][1];
  return (
    <Table>
      {sortedPlaytimes.map(([jobName, playtime]) => {
        const ratio = playtime / mostPlayed;
        return (
          <Table.Row key={jobName}>
            <Table.Cell
              collapsing
              p={0.5}
              style={{
                verticalAlign: 'middle',
              }}
            >
              <Box align="right">{displayRole(jobName)}</Box>
            </Table.Cell>
            <Table.Cell>
              <ProgressBar maxValue={mostPlayed} value={playtime}>
                <Flex>
                  <Flex.Item width={`${ratio * 100}%`} />
                  <Flex.Item>
                    {(playtime / 60).toLocaleString(undefined, {
                      minimumFractionDigits: 1,
                      maximumFractionDigits: 1,
                    })}
                    小时
                  </Flex.Item>
                </Flex>
              </ProgressBar>
            </Table.Cell>
          </Table.Row>
        );
      })}
    </Table>
  );
};

export const TrackedPlaytime = (props) => {
  const { act, data } = useBackend();
  const {
    failReason,
    jobPlaytimes,
    specialPlaytimes,
    exemptStatus,
    isAdmin,
    livingTime,
    ghostTime,
    adminTime,
  } = data;
  return (
    <Window title="游戏时长记录" width={550} height={650}>
      <Window.Content scrollable>
        {(failReason &&
          ((failReason === JOB_REPORT_MENU_FAIL_REASON_TRACKING_DISABLED && (
            <Box>此服务器已禁用时长记录。</Box>
          )) ||
            (failReason === JOB_REPORT_MENU_FAIL_REASON_NO_RECORDS && (
              <Box>你没有记录。</Box>
            )))) || (
          <Box>
            <Section title="总计">
              <PlaytimeSection
                playtimes={{
                  幽灵: ghostTime,
                  存活: livingTime,
                  管理员: adminTime,
                }}
              />
            </Section>
            <Section
              title="职业"
              buttons={
                !!isAdmin && (
                  <Button.Checkbox
                    checked={!!exemptStatus}
                    onClick={() => act('toggle_exempt')}
                  >
                    豁免职业时长要求
                  </Button.Checkbox>
                )
              }
            >
              <PlaytimeSection playtimes={jobPlaytimes} />
            </Section>
            <Section title="特殊">
              <PlaytimeSection playtimes={specialPlaytimes} />
            </Section>
          </Box>
        )}
      </Window.Content>
    </Window>
  );
};
