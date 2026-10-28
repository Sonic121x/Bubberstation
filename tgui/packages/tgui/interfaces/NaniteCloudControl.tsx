import {
  Box,
  Button,
  Collapsible,
  LabeledList,
  NoticeBox,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import * as nanite from '../localization/zhNaniteDisplay';
import { TechwebWarning } from './Nanites/NoTechwebWarning';
import type { NaniteProgram, Techweb } from './Nanites/types';
interface NaniteInfoBoxProps {
  has_disk: boolean;
  has_program: boolean;
  disk: NaniteProgram;
  current_view: number;
  backup_id: number;
  new_backup_id: number;
  techweb: Techweb;
  min_cloud_id: number;
  max_cloud_id: number;
}

export const NaniteDiskBox = () => {
  const { data } = useBackend<NaniteInfoBoxProps>();
  const { has_disk, has_program, disk } = data;
  if (!has_disk) {
    return <NoticeBox>未插入磁盘</NoticeBox>;
  }
  if (!has_program) {
    return <NoticeBox>插入的磁盘中没有程序</NoticeBox>;
  }
  return <NaniteInfoBox program={disk} />;
};

export const NaniteInfoBox = (props) => {
  const { program } = props;
  const {
    name,
    desc,
    activated,
    use_rate,
    can_trigger,
    trigger_cost,
    trigger_cooldown,
    activation_code,
    deactivation_code,
    kill_code,
    trigger_code,
    timer_restart,
    timer_shutdown,
    timer_trigger,
    timer_trigger_delay,
    extra_settings,
  }: NaniteProgram = program;
  return (
    <Section
      title={name}
      buttons={
        <Box inline bold color={activated ? 'good' : 'bad'}>
          {activated ? '已激活' : '已停用'}
        </Box>
      }
    >
      <Stack>
        <Stack.Item mr={1}>{desc}</Stack.Item>
        <Stack.Item>
          <table>
            <LabeledList>
              <LabeledList.Item label="消耗速率">{use_rate}</LabeledList.Item>
              {!!can_trigger && (
                <>
                  <LabeledList.Item label="触发消耗">
                    {trigger_cost}
                  </LabeledList.Item>
                  <LabeledList.Item label="触发冷却">
                    {trigger_cooldown}
                  </LabeledList.Item>
                </>
              )}
            </LabeledList>
          </table>
        </Stack.Item>
      </Stack>
      <Stack>
        <Stack.Item>
          <Section title="信号代码" mr={1}>
            <LabeledList>
              <LabeledList.Item label="激活">
                {activation_code}
              </LabeledList.Item>
              <LabeledList.Item label="停用">
                {deactivation_code}
              </LabeledList.Item>
              <LabeledList.Item label="销毁">{kill_code}</LabeledList.Item>
              {!!can_trigger && (
                <LabeledList.Item label="触发">
                  {trigger_code}
                </LabeledList.Item>
              )}
            </LabeledList>
          </Section>
        </Stack.Item>
        <Stack.Item>
          <Section title="延迟" mr={1}>
            <LabeledList>
              <LabeledList.Item label="重启">
                {timer_restart} s
              </LabeledList.Item>
              <LabeledList.Item label="关闭">
                {timer_shutdown} s
              </LabeledList.Item>
              {!!can_trigger && (
                <>
                  <LabeledList.Item label="重复触发间隔">
                    {timer_trigger} s
                  </LabeledList.Item>
                  <LabeledList.Item label="触发延迟">
                    {timer_trigger_delay} s
                  </LabeledList.Item>
                </>
              )}
            </LabeledList>
          </Section>
        </Stack.Item>
      </Stack>
      <Section title="附加设置">
        <LabeledList>
          {extra_settings?.map((setting) => {
            const naniteTypesDisplayMap = {
              number: (
                <>
                  {setting.value}
                  {setting.unit}
                </>
              ),
              text: setting.value,
              type: nanite.value(setting),
              boolean: nanite.value(setting),
            };
            return (
              <LabeledList.Item key={setting.name} label={nanite.display(setting.name)}>
                {naniteTypesDisplayMap[setting.type]}
              </LabeledList.Item>
            );
          })}
        </LabeledList>
      </Section>
    </Section>
  );
};

interface NaniteCloudBackupProps {
  cloud_id: number;
  cloud_programs: NaniteProgram[];
  cloud_backups: CloudBackups[];
}

interface CloudBackups {
  cloud_id: number;
  cloud_programs: NaniteProgram[];
}

export const NaniteCloudBackupList = () => {
  const { act, data } = useBackend<NaniteCloudBackupProps>();
  const { cloud_backups = [] } = data;

  return cloud_backups.map((backup) => (
    <Button
      fluid
      key={backup.cloud_id}
      textAlign="center"
      onClick={() =>
        act('set_view', {
          view: backup.cloud_id,
        })
      }
    >
      {`备份 #${backup.cloud_id}`}
    </Button>
  ));
};

interface NaniteCloudBackupDetailsProps {
  cloud_programs: NaniteProgram[];
  cloud_backup: CloudBackups;
  current_view: number;
  disk: NaniteProgram;
  has_program: boolean;
}

export const NaniteCloudBackupDetails = () => {
  const { act, data } = useBackend<NaniteCloudBackupDetailsProps>();
  const { current_view, disk, has_program, cloud_backup } = data;
  const can_rule = disk?.can_rule || false;
  if (!cloud_backup) {
    return <NoticeBox>错误：未找到备份</NoticeBox>;
  }
  const cloud_programs = data.cloud_programs || [];
  return (
    <Section
      title={`备份 #${current_view}`}
      buttons={
        !!has_program && (
          <Button
            icon="upload"
            color="good"
            onClick={() => act('upload_program')}
          >
            从磁盘上传程序
          </Button>
        )
      }
    >
      {cloud_programs.map((program) => {
        const rules = program.rules || [];
        return (
          <Collapsible
            key={program.name}
            title={program.name}
            buttons={
              <Button
                icon="minus-circle"
                color="bad"
                onClick={() =>
                  act('remove_program', {
                    program_id: program.id,
                  })
                }
              />
            }
          >
            <Section>
              <NaniteInfoBox program={program} />
              {(!!can_rule || !!program.has_rules) && (
                <Section
                  mt={-2}
                  title="规则"
                  buttons={
                    <>
                      {!!can_rule && (
                        <Button
                          icon="plus"
                          color="good"
                          onClick={() =>
                            act('add_rule', {
                              program_id: program.id,
                            })
                          }
                        >
                          从磁盘添加规则
                        </Button>
                      )}
                      <Button
                        icon={
                          program.all_rules_required ? 'check-double' : 'check'
                        }
                        onClick={() =>
                          act('toggle_rule_logic', {
                            program_id: program.id,
                          })
                        }
                      >
                        {program.all_rules_required ? '满足全部' : '满足任意'}
                      </Button>
                    </>
                  }
                >
                  {program.has_rules ? (
                    rules.map((rule) => (
                      <Box key={rule.display}>
                        <Button
                          icon="minus-circle"
                          color="bad"
                          onClick={() =>
                            act('remove_rule', {
                              program_id: program.id,
                              rule_id: rule.id,
                            })
                          }
                        />
                        {` ${rule.display}`}
                      </Box>
                    ))
                  ) : (
                    <Box color="bad">没有生效的规则</Box>
                  )}
                </Section>
              )}
            </Section>
          </Collapsible>
        );
      })}
    </Section>
  );
};

export const NaniteCloudControl = () => {
  const { act, data } = useBackend<NaniteInfoBoxProps>();
  const {
    has_disk,
    current_view,
    new_backup_id,
    techweb,
    min_cloud_id,
    max_cloud_id,
  } = data;
  return (
    <Window width={375} height={700}>
      <Window.Content scrollable>
        <TechwebWarning display={!techweb} />
        <Section
          title="程序磁盘"
          buttons={
            <Button
              icon="eject"
              disabled={!has_disk}
              onClick={() => act('eject')}
            >
              弹出
            </Button>
          }
        >
          <NaniteDiskBox />
        </Section>
        <Section
          title="云端存储"
          buttons={
            current_view ? (
              <Button
                icon="arrow-left"
                onClick={() =>
                  act('set_view', {
                    view: 0,
                  })
                }
              >
                返回
              </Button>
            ) : (
              <>
                {'新建备份：'}
                <NumberInput
                  value={new_backup_id}
                  minValue={min_cloud_id + 1}
                  maxValue={max_cloud_id}
                  stepPixelSize={4}
                  step={1}
                  width="39px"
                  onChange={(value) =>
                    act('update_new_backup_value', {
                      value: value,
                    })
                  }
                />
                <Button icon="plus" onClick={() => act('create_backup')} />
              </>
            )
          }
        >
          {!data.current_view ? (
            <NaniteCloudBackupList />
          ) : (
            <NaniteCloudBackupDetails />
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
