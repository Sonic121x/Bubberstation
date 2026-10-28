import { useState } from 'react';
import { useBackend, useLocalState } from 'tgui/backend';
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  RestrictedInput,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';

import { CharacterPreview } from '../common/CharacterPreview';
import { EditableText } from '../common/EditableText';
import { CRIMESTATUS2COLOR, CRIMESTATUS2DESC } from './constants';
import { CrimeWatcher } from './CrimeWatcher';
import { getSecurityRecord } from './helpers';
import { RecordPrint } from './RecordPrint';
import type { SecurityRecordsData } from './types';
import { recordDisplay } from '../../localization/batchThreeDisplay';
/** Views a selected record. */
export const SecurityRecordView = (props) => {
  const foundRecord = getSecurityRecord();
  if (!foundRecord) return <NoticeBox>尚未选择档案。</NoticeBox>;

  const { data } = useBackend<SecurityRecordsData>();
  const { assigned_view } = data;

  const [open] = useLocalState<boolean>('printOpen', false);

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Stack fill>
          <Stack.Item>
            <CharacterPreview height="100%" id={assigned_view} />
          </Stack.Item>
          <Stack.Item grow>
            <CrimeWatcher />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>{open ? <RecordPrint /> : <RecordInfo />}</Stack.Item>
    </Stack>
  );
};

const RecordInfo = (props) => {
  const foundRecord = getSecurityRecord();
  if (!foundRecord) return <NoticeBox>尚未选择档案。</NoticeBox>;

  const { act, data } = useBackend<SecurityRecordsData>();
  const { available_statuses } = data;
  const [open, setOpen] = useLocalState<boolean>('printOpen', false);

  // const { min_age, max_age } = data; // ORIGINAL
  const { min_age, max_age, max_chrono_age } = data; // SKYRAT EDIT CHANGE - Chronological age

  const {
    age,
    chrono_age, // SKYRAT EDIT ADDITION - Chronological age
    crew_ref,
    crimes,
    fingerprint,
    gender,
    name,
    note,
    rank,
    species,
    wanted_status,
    voice,
    // SKYRAT EDIT START - RP Records
    past_general_records,
    past_security_records,
    // SKYRAT EDIT END
  } = foundRecord;

  const [isValid, setIsValid] = useState(true);

  const hasValidCrimes = !!crimes.find((crime) => !!crime.valid);

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Section
          buttons={
            <Stack>
              <Stack.Item>
                <Button
                  height="1.7rem"
                  icon="print"
                  onClick={() => setOpen(true)}
                  tooltip="打印犯罪记录或海报。"
                >
                  打印
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button.Confirm
                  icon="trash"
                  onClick={() => act('delete_record', { crew_ref: crew_ref })}
                  tooltip="删除档案数据。"
                >
                  删除
                </Button.Confirm>
              </Stack.Item>
            </Stack>
          }
          fill
          title={
            <Table.Cell color={CRIMESTATUS2COLOR[wanted_status]}>
              {name}
            </Table.Cell>
          }
        >
          <LabeledList>
            <LabeledList.Item
              buttons={available_statuses.map((button, index) => {
                const isSelected = button === wanted_status;
                return (
                  <Button
                    color={isSelected ? CRIMESTATUS2COLOR[button] : 'grey'}
                    disabled={button === 'Arrest' && !hasValidCrimes}
                    icon={isSelected ? 'check' : ''}
                    key={index}
                    onClick={() =>
                      act('set_wanted', {
                        crew_ref: crew_ref,
                        status: button,
                      })
                    }
                    pl={!isSelected ? '1.8rem' : 1}
                    tooltip={CRIMESTATUS2DESC[button] || ''}
                    tooltipPosition="bottom-start"
                  >
                    {recordDisplay(button, data)}
                  </Button>
                );
              })}
              label="状态"
            >
              <Box color={CRIMESTATUS2COLOR[wanted_status]}>
                {recordDisplay(wanted_status, data)}
              </Box>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item grow={2}>
        <Section fill scrollable>
          <LabeledList>
            <LabeledList.Item label="姓名">
              <EditableText field="name" target_ref={crew_ref} text={name} />
            </LabeledList.Item>
            <LabeledList.Item label="职业">
              <EditableText field="rank" target_ref={crew_ref} text={rank} displayText={recordDisplay(rank, data)} />
            </LabeledList.Item>
            {/* <LabeledList.Item label="Age"> // ORIGINAL */}
            {/* SKYRAT EDIT CHANGE BEGIN - Chronological age */}
            <LabeledList.Item label="生理年龄">
              {/* SKYRAT EDIT CHANGE END */}
              <RestrictedInput
                minValue={min_age}
                maxValue={max_age}
                onEnter={(value) =>
                  isValid &&
                  act('edit_field', {
                    crew_ref: crew_ref,
                    field: 'age',
                    value: value,
                  })
                }
                onValidationChange={setIsValid}
                value={age}
              />
            </LabeledList.Item>
            {/* SKYRAT EDIT ADDITION BEGIN - Chronological age */}
            <LabeledList.Item label="实际年龄">
              <RestrictedInput
                minValue={min_age}
                maxValue={max_chrono_age}
                onEnter={(value) =>
                  act('edit_field', {
                    crew_ref: crew_ref,
                    field: 'chrono_age',
                    value: value,
                  })
                }
                value={chrono_age}
              />
            </LabeledList.Item>
            {/* SKYRAT EDIT ADDITION END */}
            <LabeledList.Item label="种族">
              <EditableText
                field="species"
                target_ref={crew_ref}
                text={species} displayText={recordDisplay(species, data)}
              />
            </LabeledList.Item>
            <LabeledList.Item label="性别">
              <EditableText
                field="gender"
                target_ref={crew_ref}
                text={gender} displayText={recordDisplay(gender, data)}
              />
            </LabeledList.Item>
            <LabeledList.Item color="good" label="指纹">
              <EditableText
                color="good"
                field="fingerprint"
                target_ref={crew_ref}
                text={fingerprint}
              />
            </LabeledList.Item>
            <LabeledList.Item label="声音">
              <EditableText field="voice" target_ref={crew_ref} text={voice} />
            </LabeledList.Item>
            <LabeledList.Item label="备注">
              <EditableText
                field="security_note"
                target_ref={crew_ref}
                text={note}
              />
            </LabeledList.Item>
            {/* SKYRAT EDIT START - RP Records (Not pretty but it's there) */}
            <LabeledList.Item label="一般档案">
              <Box maxWidth="100%" preserveWhitespace>
                {past_general_records || '无'}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="过往安保档案">
              <Box maxWidth="100%" preserveWhitespace>
                {past_security_records || '无'}
              </Box>
            </LabeledList.Item>
            {/* SKYRAT EDIT END */}
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
