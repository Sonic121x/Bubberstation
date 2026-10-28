import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
} from 'tgui-core/components';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const RemoteRobotControl = (props) => {
  return (
    <Window title="远程机器人控制" width={500} height={500}>
      <Window.Content scrollable>
        <RemoteRobotControlContent />
      </Window.Content>
    </Window>
  );
};

export const RemoteRobotControlContent = (props) => {
  const { act, data } = useBackend();
  const { robots = [] } = data;
  if (!robots.length) {
    return (
      <Section>
        <NoticeBox textAlign="center">未检测到机器人</NoticeBox>
      </Section>
    );
  }
  return robots.map((robot) => {
    return (
      <Section
        key={robot.ref}
        title={`${robot.name} (${robot.model})`}
        buttons={
          <>
            <Button
              icon="tools"
              content="控制界面"
              onClick={() =>
                act('interface', {
                  ref: robot.ref,
                })
              }
            />
            <Button
              icon="phone-alt"
              content="呼叫"
              onClick={() =>
                act('callbot', {
                  ref: robot.ref,
                })
              }
            />
          </>
        }
      >
        <LabeledList>
          <LabeledList.Item label="状态">
            <Box
              inline
              color={
                ['Inactive', '未激活'].includes(decodeHtmlEntities(robot.mode))
                  ? 'bad'
                  : ['Idle', '待机'].includes(decodeHtmlEntities(robot.mode))
                    ? 'average'
                    : 'good'
              }
            >
              {decodeHtmlEntities(robot.mode)}
            </Box>{' '}
            {(robot.hacked && (
              <Box inline color="bad">
                （已入侵）
              </Box>
            )) ||
              ''}
          </LabeledList.Item>
          <LabeledList.Item label="位置">{robot.location}</LabeledList.Item>
        </LabeledList>
      </Section>
    );
  });
};
