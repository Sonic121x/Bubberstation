import { sortBy } from 'es-toolkit';
import { filter } from 'es-toolkit/compat';
import { useState } from 'react';
import { useBackend, useLocalState } from 'tgui/backend';
import {
  Box,
  Button,
  Icon,
  Input,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

import { CRIMESTATUS2COLOR } from './constants';
import { isRecordMatch } from './helpers';
import type { SecurityRecord, SecurityRecordsData } from './types';
import { recordDisplay } from '../../localization/batchThreeDisplay';
/** Tabs on left, with search bar */
export const SecurityRecordTabs = (props) => {
  const { act, data } = useBackend<SecurityRecordsData>();
  const { higher_access, records = [], station_z } = data;

  const errorMessage = !records.length
    ? '未找到档案。'
    : '没有匹配结果，请调整搜索条件。';

  const [search, setSearch] = useState('');

  const sorted = sortBy(
    filter(records, (record) => isRecordMatch(record, search) || recordDisplay(record.rank, data).includes(search)),
    [(record) => record.name],
  );

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Input
          fluid
          placeholder="姓名／职业／指纹"
          onChange={setSearch}
          expensive
        />
      </Stack.Item>
      <Stack.Item grow>
        <Section fill scrollable>
          <Tabs vertical>
            {!sorted.length ? (
              <NoticeBox>{errorMessage}</NoticeBox>
            ) : (
              sorted.map((record, index) => (
                <CrewTab record={record} key={index} />
              ))
            )}
          </Tabs>
        </Section>
      </Stack.Item>
      <Stack.Item align="center">
        <Stack fill>
          <Stack.Item>
            <Button
              disabled
              icon="plus"
              tooltip="将一张1米见方的照片插入终端即可添加新档案。无需打开此界面。"
            >
              创建
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              content="清空"
              disabled={!higher_access || !station_z}
              icon="trash"
              onClick={() => act('purge_records')}
              tooltip="清除犯罪记录数据。"
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

/** Individual record */
const CrewTab = (props: { record: SecurityRecord }) => {
  const [selectedRecord, setSelectedRecord] = useLocalState<
    SecurityRecord | undefined
  >('securityRecord', undefined);

  const { act, data } = useBackend<SecurityRecordsData>();
  const { assigned_view } = data;
  const { record } = props;
  const { crew_ref, name, trim, wanted_status } = record;

  /** Chooses a record */
  const selectRecord = (record: SecurityRecord) => {
    if (selectedRecord?.crew_ref === crew_ref) {
      setSelectedRecord(undefined);
    } else {
      // See MedicalRecords/RecordTabs.tsx for explanation
      if (selectedRecord === undefined) {
        setTimeout(() => {
          act('view_record', {
            assigned_view: assigned_view,
            crew_ref: crew_ref,
          });
        });
      }
      setSelectedRecord(record);
      act('view_record', { assigned_view: assigned_view, crew_ref: crew_ref });
    }
  };

  const isSelected = selectedRecord?.crew_ref === crew_ref;

  return (
    <Tabs.Tab
      className="candystripe"
      onClick={() => selectRecord(record)}
      selected={isSelected}
    >
      <Box bold={isSelected} color={CRIMESTATUS2COLOR[wanted_status]}>
        <Icon name={trim || 'question'} /> {name}
      </Box>
    </Tabs.Tab>
  );
};
