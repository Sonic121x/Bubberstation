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
import type { NaniteProgram } from './Nanites/types';
export const NaniteChamberControl = (props, context) => {
  return (
    <Window width={380} height={570}>
      <Window.Content scrollable>
        <NaniteChamberControlContent />
      </Window.Content>
    </Window>
  );
};

interface NaniteChamberProps {
  status_msg: string;
  locked: boolean;
  occupant_name: string;
  has_nanites: boolean;
  nanite_volume: number;
  regen_rate: number;
  safety_threshold: number;
  cloud_id: number;
  scan_level: number;
  mob_programs: NaniteProgram[];
  min_cloud_id: number;
  max_cloud_id: number;
}

export const NaniteChamberControlContent = () => {
  const { act, data } = useBackend<NaniteChamberProps>();
  const {
    status_msg,
    locked,
    occupant_name,
    has_nanites,
    nanite_volume,
    regen_rate,
    safety_threshold,
    cloud_id,
    scan_level,
    mob_programs = [],
    min_cloud_id,
    max_cloud_id,
  } = data;

  if (status_msg) {
    return <NoticeBox textAlign="center">{status_msg}</NoticeBox>;
  }

  return (
    <Section
      title={`舱室：${occupant_name}`}
      buttons={
        <Button
          icon={locked ? 'lock' : 'lock-open'}
          color={locked ? 'bad' : 'default'}
          onClick={() => act('toggle_lock')}
        >
          {locked ? '已锁定' : '已解锁'}
        </Button>
      }
    >
      {!has_nanites ? (
        <>
          <Box bold color="bad" textAlign="center" fontSize="30px" mb={1}>
            未检测到纳米机器人
          </Box>
          <Button
            fluid
            bold
            icon="syringe"
            color="green"
            textAlign="center"
            fontSize="30px"
            lineHeight="50px"
            onClick={() => act('nanite_injection')}
          >
            植入纳米机器人
          </Button>
        </>
      ) : (
        <>
          <Section
            title="状态"
            buttons={
              <Button
                icon="exclamation-triangle"
                color="bad"
                onClick={() => act('remove_nanites')}
              >
                销毁纳米机器人
              </Button>
            }
          >
            <Stack>
              <Stack.Item>
                <LabeledList>
                  <LabeledList.Item label="纳米机器人数量">
                    {nanite_volume}
                  </LabeledList.Item>
                  <LabeledList.Item label="增殖速率">
                    {regen_rate}
                  </LabeledList.Item>
                </LabeledList>
              </Stack.Item>
              <Stack.Item>
                <LabeledList>
                  <LabeledList.Item label="安全阈值">
                    <NumberInput
                      value={safety_threshold}
                      minValue={0}
                      maxValue={500}
                      step={10}
                      width="39px"
                      onChange={(value) =>
                        act('set_safety', {
                          value: value,
                        })
                      }
                    />
                  </LabeledList.Item>
                  <LabeledList.Item label="云端编号">
                    <NumberInput
                      value={cloud_id}
                      minValue={min_cloud_id}
                      maxValue={max_cloud_id}
                      step={1}
                      stepPixelSize={3}
                      width="39px"
                      onChange={(value) =>
                        act('set_cloud', {
                          value: value,
                        })
                      }
                    />
                  </LabeledList.Item>
                </LabeledList>
              </Stack.Item>
            </Stack>
          </Section>
          <Section title="程序">
            {mob_programs?.map((program) => {
              const extra_settings = program.extra_settings || [];
              const rules = program.rules || [];
              return (
                <Collapsible key={program.name} title={program.name}>
                  <Section>
                    <Stack vertical>
                      {scan_level >= 2 && (
                        <Stack.Item>
                          <LabeledList>
                            <LabeledList.Item label="激活状态">
                              <Box color={program.activated ? 'good' : 'bad'}>
                                {program.activated ? '已激活' : '未激活'}
                              </Box>
                            </LabeledList.Item>
                            <LabeledList.Item label="纳米机器人消耗">
                              {program.use_rate}/s
                            </LabeledList.Item>
                          </LabeledList>
                        </Stack.Item>
                      )}
                      <Stack.Item>{program.desc}</Stack.Item>
                    </Stack>
                    {scan_level >= 2 && (
                      <Stack>
                        {!!program.can_trigger && (
                          <Stack.Item>
                            <Section title="触发设置">
                              <LabeledList>
                                <LabeledList.Item label="触发消耗">
                                  {program.trigger_cost}
                                </LabeledList.Item>
                                <LabeledList.Item label="触发冷却">
                                  {program.trigger_cooldown}
                                </LabeledList.Item>
                                {!!program.timer_trigger_delay && (
                                  <LabeledList.Item label="触发延迟">
                                    {program.timer_trigger_delay} s
                                  </LabeledList.Item>
                                )}
                                {!!program.timer_trigger && (
                                  <LabeledList.Item label="重复触发间隔">
                                    {program.timer_trigger} s
                                  </LabeledList.Item>
                                )}
                              </LabeledList>
                            </Section>
                          </Stack.Item>
                        )}
                        {!!(
                          program.timer_restart || program.timer_shutdown
                        ) && (
                          <Stack.Item>
                            <Section>
                              <LabeledList>
                                {/* I mean, bruh, this indentation level
                                    is ABSOLUTELY INSANE!!! */}
                                {program.timer_restart && (
                                  <LabeledList.Item label="重启定时器">
                                    {program.timer_restart} s
                                  </LabeledList.Item>
                                )}
                                {program.timer_shutdown && (
                                  <LabeledList.Item label="关闭定时器">
                                    {program.timer_shutdown} s
                                  </LabeledList.Item>
                                )}
                              </LabeledList>
                            </Section>
                          </Stack.Item>
                        )}
                      </Stack>
                    )}
                    {scan_level >= 3 && !!program.has_extra_settings && (
                      <Section title="附加设置">
                        <LabeledList>
                          {extra_settings.map((extra_setting) => (
                            <LabeledList.Item
                              key={extra_setting.name}
                              label={nanite.display(extra_setting.name)}
                            >
                              {nanite.value(extra_setting)}
                            </LabeledList.Item>
                          ))}
                        </LabeledList>
                      </Section>
                    )}
                    {scan_level >= 4 && (
                      <Stack>
                        <Stack.Item>
                          <Section title="信号代码">
                            <LabeledList>
                              {!!program.activation_code && (
                                <LabeledList.Item label="激活">
                                  {program.activation_code}
                                </LabeledList.Item>
                              )}
                              {!!program.deactivation_code && (
                                <LabeledList.Item label="停用">
                                  {program.deactivation_code}
                                </LabeledList.Item>
                              )}
                              {!!program.kill_code && (
                                <LabeledList.Item label="销毁">
                                  {program.kill_code}
                                </LabeledList.Item>
                              )}
                              {!!program.can_trigger &&
                                !!program.trigger_code && (
                                  <LabeledList.Item label="触发">
                                    {program.trigger_code}
                                  </LabeledList.Item>
                                )}
                            </LabeledList>
                          </Section>
                        </Stack.Item>
                        {program.has_rules && (
                          <Stack.Item>
                            <Section title="规则">
                              {rules.map((rule) => (
                                <Box key={rule.display}>{rule.display}</Box>
                              ))}
                            </Section>
                          </Stack.Item>
                        )}
                      </Stack>
                    )}
                  </Section>
                </Collapsible>
              );
            })}
          </Section>
        </>
      )}
    </Section>
  );
};
