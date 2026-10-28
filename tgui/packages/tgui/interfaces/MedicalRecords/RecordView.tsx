import { useState } from 'react';
import {
  Box,
  Button,
  Input,
  LabeledList,
  NoticeBox,
  RestrictedInput,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { CharacterPreview } from '../common/CharacterPreview';
import { EditableText } from '../common/EditableText';
import {
  MENTALSTATUS2COLOR,
  MENTALSTATUS2DESC,
  MENTALSTATUS2ICON,
  PHYSICALSTATUS2COLOR,
  PHYSICALSTATUS2DESC,
  PHYSICALSTATUS2ICON,
} from './constants';
import { getMedicalRecord, getQuirkStrings } from './helpers';
import { NoteKeeper } from './NoteKeeper';
import type { MedicalRecordData } from './types';
import { recordDisplay } from '../../localization/batchThreeDisplay';
/** Views a selected record. */
export const MedicalRecordView = (props) => {
  const foundRecord = getMedicalRecord();
  if (!foundRecord) return <NoticeBox>未选择记录。</NoticeBox>;

  const { act, data } = useBackend<MedicalRecordData>();
  const { assigned_view, physical_statuses, mental_statuses, station_z } = data;

  // const { min_age, max_age } = data; // ORIGINAL
  const { min_age, max_age, max_chrono_age } = data; // SKYRAT EDIT CHANGE - Chronological age

  const {
    age,
    chrono_age, // SKYRAT EDIT ADDITION - Chronological age
    blood_type,
    crew_ref,
    dna,
    gender,
    major_disabilities,
    minor_disabilities,
    physical_status,
    cause_of_death,
    mental_status,
    name,
    quirk_notes,
    rank,
    // SKYRAT EDIT START - RP Records
    past_general_records,
    past_medical_records,
    // SKYRAT EDIT END
    species,
  } = foundRecord;

  const minor_disabilities_array = getQuirkStrings(minor_disabilities);
  const major_disabilities_array = getQuirkStrings(major_disabilities);
  const quirk_notes_array = getQuirkStrings(quirk_notes);

  const [isValid, setIsValid] = useState(true);

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Stack fill>
          <Stack.Item>
            <CharacterPreview height="100%" id={assigned_view} />
          </Stack.Item>
          <Stack.Item grow>
            <NoteKeeper />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        <Section
          buttons={
            <Button.Confirm
              icon="trash"
              disabled={!station_z}
              onClick={() => act('expunge_record', { crew_ref: crew_ref })}
              tooltip="删除记录数据。"
            >
              删除
            </Button.Confirm>
          }
          fill
          scrollable
          title={name}
        >
          <LabeledList>
            <LabeledList.Item label="姓名">
              <EditableText field="name" target_ref={crew_ref} text={name} />
            </LabeledList.Item>
            <LabeledList.Item label="职业">
              <EditableText field="job" target_ref={crew_ref} text={rank} displayText={recordDisplay(rank, data)} />
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
                    field: 'age',
                    ref: crew_ref,
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
                    field: 'chrono_age',
                    ref: crew_ref,
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
            <LabeledList.Item label="DNA">
              <EditableText
                color="good"
                field="dna"
                target_ref={crew_ref}
                text={dna}
              />
            </LabeledList.Item>
            <LabeledList.Item color="bad" label="血型">
              <EditableText
                field="blood_type"
                target_ref={crew_ref}
                text={blood_type}
              />
            </LabeledList.Item>
            <LabeledList.Item
              buttons={physical_statuses.map((button, index) => {
                const isSelected = button === physical_status;
                return (
                  <Button
                    color={isSelected ? PHYSICALSTATUS2COLOR[button] : 'grey'}
                    height={'1.75rem'}
                    icon={PHYSICALSTATUS2ICON[button]}
                    key={index}
                    onClick={() =>
                      act('set_physical_status', {
                        crew_ref: crew_ref,
                        physical_status: button,
                      })
                    }
                    textAlign="center"
                    tooltip={PHYSICALSTATUS2DESC[button] || ''}
                    tooltipPosition="bottom-start"
                    width={!isSelected ? '3.0rem' : 3.0}
                  >
                    {recordDisplay(button, data)[0]}
                  </Button>
                );
              })}
              label="身体状态"
            >
              <Box color={PHYSICALSTATUS2COLOR[physical_status]}>
                {recordDisplay(physical_status, data)}
              </Box>
            </LabeledList.Item>
            {physical_status === 'Deceased' && (
              <LabeledList.Item label="死因">
                <Box>
                  <Input
                    fluid
                    placeholder="输入死因……"
                    value={cause_of_death}
                    onChange={(value) =>
                      act('set_cause_of_death', {
                        crew_ref: crew_ref,
                        cause: value,
                      })
                    }
                  />
                </Box>
              </LabeledList.Item>
            )}
            <LabeledList.Item
              buttons={mental_statuses.map((button, index) => {
                const isSelected = button === mental_status;
                return (
                  <Button
                    color={isSelected ? MENTALSTATUS2COLOR[button] : 'grey'}
                    height={'1.75rem'}
                    icon={MENTALSTATUS2ICON[button]}
                    key={index}
                    onClick={() =>
                      act('set_mental_status', {
                        crew_ref: crew_ref,
                        mental_status: button,
                      })
                    }
                    textAlign="center"
                    tooltip={MENTALSTATUS2DESC[button] || ''}
                    tooltipPosition="bottom-start"
                    width={!isSelected ? '3.0rem' : 3.0}
                  >
                    {recordDisplay(button, data)[0]}
                  </Button>
                );
              })}
              label="精神状态"
            >
              <Box color={MENTALSTATUS2COLOR[mental_status]}>
                {recordDisplay(mental_status, data)}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="轻度障碍">
              {minor_disabilities_array.map((disability, index) => (
                <Box key={index}>&#8226; {disability}</Box>
              ))}
            </LabeledList.Item>
            <LabeledList.Item label="重度障碍">
              {major_disabilities_array.map((disability, index) => (
                <Box key={index}>&#8226; {disability}</Box>
              ))}
            </LabeledList.Item>
            <LabeledList.Item label="特质">
              {quirk_notes_array.map((quirk, index) => (
                <Box key={index}>&#8226; {quirk}</Box>
              ))}
            </LabeledList.Item>
            {/* SKYRAT EDIT START - RP Records (Not pretty but it's there) */}
            <LabeledList.Item label="一般记录">
              <Box maxWidth="100%" preserveWhitespace>
                {past_general_records || '无'}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="既往病历">
              <Box maxWidth="100%" preserveWhitespace>
                {past_medical_records || '无'}
              </Box>
            </LabeledList.Item>
            {/* SKYRAT EDIT END */}
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
