import {
  Box,
  Button,
  Flex,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';

export const DopplerArray = (props) => {
  return (
    <Window width={650} height={320} resizable>
      <Window.Content>
        <DopplerArrayContent />
      </Window.Content>
    </Window>
  );
};

const DopplerArrayContent = (props) => {
  const { act, data } = useBackend();
  const { records = [], disk, storage } = data;
  const [activeRecordName, setActiveRecordName] = useSharedState(
    'activeRecordrecord',
    records[0]?.name,
  );
  const activeRecord = records.find((record) => {
    return record.name === activeRecordName;
  });
  const DopplerArrayFooter = (
    <Section title={disk ? `${disk} (${storage})` : '未插入磁盘'}>
      <Button
        textAlign="center"
        fluid
        icon="eject"
        content="弹出磁盘"
        disabled={!disk}
        onClick={() => act('eject_disk')}
      />
    </Section>
  );
  const DopplerArrayRecords = (
    <Section>
      <Stack>
        <Stack.Item mr={2}>
          <Tabs vertical>
            {records.map((record) => (
              <Tabs.Tab
                icon="file"
                key={record.name}
                selected={record.name === activeRecordName}
                onClick={() => setActiveRecordName(record.name)}
              >
                {record.name}
              </Tabs.Tab>
            ))}
          </Tabs>
        </Stack.Item>
        {activeRecord ? (
          <Stack.Item>
            <Section
              title={activeRecord.name}
              buttons={
                <>
                  <Button.Confirm
                    icon="trash"
                    content="删除"
                    color="bad"
                    onClick={() =>
                      act('delete_record', {
                        ref: activeRecord.ref,
                      })
                    }
                  />
                  <Button
                    icon="floppy-disk"
                    content="保存"
                    disabled={!disk}
                    tooltip="将所选记录保存到已插入的数据磁盘。"
                    tooltipPosition="bottom"
                    onClick={() =>
                      act('save_record', {
                        ref: activeRecord.ref,
                      })
                    }
                  />
                </>
              }
            >
              <LabeledList>
                <LabeledList.Item label="时间戳">
                  {activeRecord.timestamp}
                </LabeledList.Item>
                <LabeledList.Item label="坐标">
                  {activeRecord.coordinates}
                </LabeledList.Item>
                <LabeledList.Item label="传播延迟">
                  {activeRecord.displacement} 秒
                </LabeledList.Item>
                <LabeledList.Item label="爆心半径">
                  {activeRecord.factual_epicenter_radius}
                  {activeRecord.theory_epicenter_radius &&
                    '（理论值：' +
                      activeRecord.theory_epicenter_radius +
                      '）'}
                </LabeledList.Item>
                <LabeledList.Item label="外围半径">
                  {activeRecord.factual_outer_radius}
                  {activeRecord.theory_outer_radius &&
                    `（理论值：${activeRecord.theory_outer_radius}）`}
                </LabeledList.Item>
                <LabeledList.Item label="冲击波半径">
                  {activeRecord.factual_shockwave_radius}
                  {activeRecord.theory_shockwave_radius &&
                    '（理论值：' +
                      activeRecord.theory_shockwave_radius +
                      '）'}
                </LabeledList.Item>
                <LabeledList.Item label="可能原因">
                  {activeRecord.reaction_results.length
                    ? activeRecord.reaction_results.map((reaction_name) => (
                        <Box key={reaction_name}>{reaction_name}</Box>
                      ))
                    : '无可用信息'}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
        ) : (
          <Stack.Item grow={1} basis={0}>
            <NoticeBox>未选择记录</NoticeBox>
          </Stack.Item>
        )}
      </Stack>
    </Section>
  );
  return (
    <Flex direction="column" height="100%">
      <Flex.Item grow>
        {!records.length ? (
          <NoticeBox>没有记录</NoticeBox>
        ) : (
          DopplerArrayRecords
        )}
      </Flex.Item>
      <Flex.Item>{DopplerArrayFooter}</Flex.Item>
    </Flex>
  );
};
