import { useState } from 'react';
import { Box, Icon, Input, Section } from 'tgui-core/components';
import { createSearch } from 'tgui-core/string';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import { recordDisplay } from '../localization/batchThreeDisplay'; import { displayRole } from '../localization/roleDisplay';
export const NtosRecords = (props) => {
  const { act, data } = useBackend();
  const [searchTerm, setSearchTerm] = useState('');
  const { mode, records } = data; const zh = (value) => displayRole(recordDisplay(value, data));

  const isMatchingSearchTerms = createSearch(searchTerm);

  return (
    <NtosWindow width={600} height={800}>
      <NtosWindow.Content scrollable>
        <Section textAlign="center">
          纳米传讯人事档案（机密）
        </Section>
        <Section>
          <Input
            placeholder="筛选结果……"
            value={searchTerm}
            fluid
            textAlign="center"
            onChange={setSearchTerm}
            expensive
          />
        </Section>
        {mode === 'security' &&
          records.map((record) => (
            <Section
              key={record.id}
              hidden={
                !(
                  searchTerm === '' ||
                  isMatchingSearchTerms(
                    record.name +
                      ' ' +
                      record.rank + zh(record.rank) +
                      ' ' +
                      record.species + zh(record.species) +
                      ' ' +
                      record.gender + zh(record.gender) +
                      ' ' +
                      record.age +
                      ' ' +
                      /* SKYRAT EDIT ADDITION BEGIN - Chronological age */
                      record.chrono_age +
                      ' ' +
                      /* SKYRAT EDIT ADDITION END */
                      record.fingerprint,
                  )
                )
              }
            >
              <Box bold>
                <Icon name="user" mr={1} />
                {record.name}
              </Box>
              <br />
              职务：{zh(record.rank)}
              <br />
              种族：{zh(record.species)}
              <br />
              性别：{zh(record.gender)}
              <br />
              {/* SKYRAT EDIT CHANGE - Chronological age, ORIGINAL: Age: {record.age} */}
              生理年龄：{record.age}
              {/* SKYRAT EDIT CHANGE END */}
              <br />
              {/* SKYRAT EDIT ADDITION BEGIN - Chronological age */}
              实际年龄：{record.chrono_age}
              <br />
              {/* SKYRAT EDIT ADDITION END */}
              指纹哈希：{record.fingerprint}
              <br />
              <br />
              犯罪状态：{record.wanted ? zh(record.wanted) : '已删除'}
            </Section>
          ))}
        {mode === 'medical' &&
          records.map((record) => (
            <Section
              key={record.id}
              hidden={
                !(
                  searchTerm === '' ||
                  isMatchingSearchTerms(
                    record.name +
                      ' ' +
                      record.bloodtype +
                      ' ' +
                      record.mental_status + zh(record.mental_status) +
                      ' ' +
                      record.physical_status + zh(record.physical_status),
                  )
                )
              }
            >
              <Box bold>
                <Icon name="user" mr={1} />
                {record.name}
              </Box>
              <br />
              {/* SKYRAT EDIT ADDITION BEGIN - Chronological age */}
              生理年龄：{record.age}
              <br />
              实际年龄：{record.chrono_age}
              <br />
              {/* SKYRAT EDIT ADDITION END */}
              血型：{record.bloodtype}
              <br />
              轻度残疾：
              {record.mi_dis?.split('<br>').map((entry, index) => (
                <Box key={index}>&#8226; {entry}</Box>
              ))}
              重度残疾：
              {record.ma_dis?.split('<br>').map((entry, index) => (
                <Box key={index}>&#8226; {entry}</Box>
              ))}
              <br />
              备注：{record.notes}
            </Section>
          ))}
      </NtosWindow.Content>
    </NtosWindow>
  );
};
