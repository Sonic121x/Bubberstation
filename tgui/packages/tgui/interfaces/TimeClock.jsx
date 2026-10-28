// THIS IS A SKYRAT UI FILE
import { Box, Button, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts'; import { displayRole } from '../localization/roleDisplay'; import { chineseDisplay } from '../localization/zhDisplay';

export const TimeClock = (props) => {
  const { act, data } = useBackend();
  const {
    inserted_id,
    insert_id_cooldown,
    id_holder_name,
    id_job_title,
    station_alert_level,
    current_time,
    clock_status,
  } = data;

  return (
    <Window title={'考勤钟'} width={500} height={250} resizable>
      <Window.Content>
        <Section>
          <Box textAlign="center" fontSize="15px">
            空间站时间：<b>{current_time}</b>
          </Box>
          <Box textAlign="center" fontSize="15px">
            当前警戒等级：<b>{chineseDisplay(station_alert_level)}</b>
          </Box>
        </Section>
        {inserted_id ? (
          <>
            <Section title={false}>
              <LabeledList>
                <LabeledList.Item label="身份卡持有人">
                  {id_holder_name}
                </LabeledList.Item>
                <LabeledList.Item label="当前职业">
                  {displayRole(id_job_title)}
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Box>
              <Button
                width="95%"
                disabled={insert_id_cooldown}
                onClick={() => act('clock_in_or_out')}
              >
                <center>{clock_status ? '上班打卡' : '下班打卡'} </center>
              </Button>
              <Button icon="eject" onClick={() => act('eject_id')} />
            </Box>
          </>
        ) : (
          <Section title={false}>
            {' '}
            <Box fontSize="18px">
              <center>
                <b>请插入身份卡以开始！</b>
              </center>
            </Box>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
