// THIS IS A NOVA SECTOR UI FILE
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type ReactorInfo = {
  venting: BooleanLike;
  vent_dir: BooleanLike;
  active: BooleanLike;
  safety: BooleanLike;
  overclocked: BooleanLike;
  criticality: number;
  health_percent: number;
  max_power_generation: number;
  safeties_max_power_generation: number;
  raw_last_power_output: number;
  raw_last_power_output_bonus: number;
  last_power_output: string;
  last_power_output_bonus: string;
  last_tritium_consumption: number;
  fuel_time_left: number;
  fuel_time_left_text: string;
  rod: BooleanLike;
  rod_mix_pressure: number;
  rod_pressure_limit: number;
  rod_mix_temperature: number;
  rod_trit_moles: number;
  temperature_limit: number;
  magic_number: number;
  auto_vent_upgrade: BooleanLike;
  auto_vent: BooleanLike;
  jammed: BooleanLike;
  meltdown: BooleanLike;
  overclocked_upgrade: BooleanLike;
};

export const RBMK2 = (props) => {
  const { act, data } = useBackend<ReactorInfo>();
  return (
    <Window width={360} height={710}>
      <Window.Content>
        <Section textAlign="center" title="状态">
          <LabeledList>
            <LabeledList.Item
              label="运行状态"
              tooltip="反应堆是否正在运行。"
            >
              <NoticeBox
                danger
                textAlign="center"
                backgroundColor={data.active ? 'good' : 'bad'}
              >
                {data.active ? '在线' : '离线'}
              </NoticeBox>
            </LabeledList.Item>
            <LabeledList.Item
              label="稳定性"
              tooltip="反应堆是否处于稳定状态。"
            >
              <NoticeBox
                danger
                textAlign="center"
                backgroundColor={data.meltdown ? 'danger' : 'good'}
              >
                {data.meltdown ? '堆芯熔毁' : '稳定'}
              </NoticeBox>
            </LabeledList.Item>
            <LabeledList.Item
              label="连接"
              tooltip="反应堆的物理连接状态。连接卡死可能导致问题。"
            >
              <NoticeBox
                danger
                textAlign="center"
                backgroundColor={data.jammed ? 'danger' : 'good'}
              >
                {data.jammed ? '卡死' : '安全'}
              </NoticeBox>
            </LabeledList.Item>
            <LabeledList.Item
              label="发电功率"
              tooltip="发电功率取决于燃料棒温度和零件质量。超过安全限制可产生额外电力，但不建议这样做。"
            >
              <ProgressBar
                value={data.raw_last_power_output}
                minValue={0}
                maxValue={data.safeties_max_power_generation}
                ranges={{
                  danger: [
                    data.max_power_generation,
                    Infinity
                    ],
                  bad: [
                    data.safeties_max_power_generation*0.9,
                    data.max_power_generation
                  ],
                  average: [
                    data.safeties_max_power_generation*0.75,
                    data.safeties_max_power_generation*0.9
                  ],
                  good: [
                    data.safeties_max_power_generation*0.5,
                    data.safeties_max_power_generation*0.75
                  ],
                  cyan: [
                    -Infinity,
                    data.safeties_max_power_generation*0.5               
                  ],
                }}
              >
                {data.raw_last_power_output_bonus > 0 ? `${data.last_power_output} + ${data.last_power_output_bonus}` : data.last_power_output}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label="燃料棒压力"
              tooltip="压力超过4500 kPa后反应会逐渐减慢，在18000 kPa时降至最慢。压力超过9000 kPa时将触发安全系统。"
            >
              <ProgressBar
                value={data.rod_mix_pressure}
                minValue={0}
                maxValue={data.rod_pressure_limit}
                ranges={{
                  bad: [
                    data.rod_pressure_limit,
                    Infinity,
                  ],
                  orange: [
                    data.rod_pressure_limit * 0.9,
                    data.rod_pressure_limit
                  ],
                  average: [
                    data.rod_pressure_limit * 0.6,
                    data.rod_pressure_limit * 0.9
                  ],
                  good: [
                    -Infinity,
                    data.rod_pressure_limit * 0.6
                  ],
                }}
              >
                {data.rod_mix_pressure} kPa
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label="堆芯温度"
              tooltip="根据堆芯反应活性估算的温度。一般来说，绝不应让它超过9000开尔文。"
            >
              <ProgressBar
                value={data.magic_number}
                minValue={0}
                maxValue={9000}
                ranges={{
                  bad: [
                    9000,
                    Infinity
                  ],
                  orange: [
                    8000,
                    9000
                  ],
                  average: [
                    7500,
                    8000
                  ],
                  good: [
                    2500,
                    7500
                  ],
                  cyan: [
                   -Infinity,
                   2500
                  ],
                }}
              >
                {data.magic_number} 开尔文
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label="燃料棒温度"
              tooltip="混合气体温度越高，燃料消耗越快，发电功率也越高。"
            >
              <ProgressBar
                value={data.rod_mix_temperature}
                minValue={0}
                maxValue={data.temperature_limit}
                ranges={{
                  bad: [
                    data.temperature_limit*0.9,
                    Infinity
                  ],
                  orange: [
                    data.temperature_limit*0.75,
                    data.temperature_limit*0.9
                  ],
                  average: [
                    data.temperature_limit*0.5,
                    data.temperature_limit*0.75
                  ],
                  good: [
                    -Infinity,
                    data.temperature_limit*0.5
                  ],
                }}
              >
                {data.rod_mix_temperature} 开尔文
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label="剩余燃料"
              tooltip="当前燃料棒中的剩余氚量。"
            >
              <ProgressBar // Changes color based on rate of consumption while giving you a total reading.
                value={data.fuel_time_left}
                minValue={0}
                maxValue={60*60*3} //3 hours.
                ranges={{
                  bad: [-Infinity, 60*5], //5 minutes
                  orange: [60*5, 60*30], //30 minutes
                  average: [60*30, 60*60], //1 hour
                  good: [60*60, Infinity],
                }}
              >
                {data.rod_trit_moles} 摩尔（{data.fuel_time_left_text}）
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="氚消耗速率">
              {data.last_tritium_consumption}μmol/s
            </LabeledList.Item>
            <LabeledList.Item
              label="临界程度"
              tooltip="堆芯熔毁时临界程度会大幅上升。临界程度越高，结构爆炸失效的风险和爆炸半径也越大。超过100%时，反应堆极有可能自行爆炸。请不要让这种事发生在行星表面；我们不想再出事故了。"
            >
              <ProgressBar
                value={data.criticality}
                minValue={0}
                maxValue={100}
                ranges={{
                  bad: [100, Infinity],
                  orange: [50, 100],
                  average: [5, 50],
                  good: [-Infinity, 5],
                }}
              >
                {data.criticality}%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label="完整性"
              tooltip="反应堆结构完整性的估算值。不要让它降到0%以下。"
            >
              <ProgressBar
                value={data.health_percent}
                minValue={0}
                maxValue={100}
                ranges={{
                  good: [90, Infinity],
                  average: [50, 90],
                  orange: [25, 50],
                  bad: [-Infinity, 25],
                }}
              >
                {data.health_percent}%
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="控制" textAlign="center">
          <LabeledList>
            <Button.Confirm
              tooltip="反应堆启动／关闭按钮"
              textAlign="center"
              width="100%"
              icon="fa-power-off"
              confirmContent="确定吗？"
              color={data.active ? 'average' : 'good'}
              onClick={() => act('activate')}
            >
              {data.active ? '关闭' : '启动'}
            </Button.Confirm>
            {data.rod ? (
              <Button.Confirm
                tooltip="弹出当前插入的燃料棒。注意：虽然测试中无法稳定复现，但此按钮极少数情况下能解除燃料棒卡死。最好还是使用撬棍。"
                textAlign="center"
                width="100%"
                icon="fa-eject"
                color="orange"
                onClick={() => act('eject')}
              >
                弹出燃料棒
              </Button.Confirm>
            ) : (
              <NoticeBox danger textAlign="center">
                没有可弹出的控制棒
              </NoticeBox>
            )}
          </LabeledList>
          <Section title="通风控制" textAlign="center">
            注意：必须关闭通风口才能改变方向。
            <br />
            <i>（这是为了节约成本——请勿打印本段。）</i>
          </Section>
          <LabeledList>
            <LabeledList.Item
              label="通风开关"
              buttons={
                <>
                  <Box inline mx={2} color={data.venting ? 'good' : 'orange'}>
                    {data.venting ? '在线' : '离线'}
                  </Box>
                  <Button.Confirm
                    tooltip="开启或关闭通风口。"
                    textAlign="center"
                    icon="fa-fan"
                    color={data.venting ? 'orange' : 'good'}
                    onClick={() => act('venttoggle')}
                  >
                    切换
                  </Button.Confirm>
                </>
              }
            />
            <LabeledList.Item
              label="通风方向"
              buttons={
                <>
                  <Box inline mx={5.68} color={data.vent_dir ? 'orange' : 'good'}>
                    {data.vent_dir ? '吸入' : '排出'}
                  </Box>
                  <Button
                    tooltip="将通风口设为从周围环境吸入空气到RBMK2内部腔室。"
                    icon="fa-clock-rotate-left"
                    disabled={data.venting}
                    color={data.vent_dir ? 'caution' : 'blue'}
                    onClick={() => act('ventpull')}
                  />
                  <Button
                    tooltip="将通风口设为把RBMK2内部腔室的气体排入周围环境。"
                    icon="fa-clock-rotate-left fa-flip-horizontal"
                    disabled={data.venting}
                    color={data.vent_dir ? 'blue' : 'good'}
                    onClick={() => act('ventpush')}
                  />
                  <Button
                    tooltip="将通风口设为过热时自动开启、过冷时自动关闭。需要自动通风升级磁盘。"
                    icon="fa-balance-scale"
					disabled={!data.auto_vent_upgrade}
                    color={data.auto_vent ? 'good' : 'blue'}
                    onClick={() => act('autovent')}
                  />
                </>
              }
            />
          </LabeledList>
          <Section title="高级控制" textAlign="center">
            警告：此处的设置可能以爆炸的方式
            使您的保修失效。
          </Section>
          <LabeledList>
            <LabeledList.Item
              label="超频"
              buttons={
                <>
                  <Box inline mx={2} color={data.overclocked ? 'good' : 'orange'}>
                    {data.overclocked ? '在线' : '离线'}
                  </Box>
                  <Button.Confirm
                    tooltip="增加发电功率，但会消耗更多氚并产生更多热量。需要超频升级磁盘。"
                    icon="exclamation-triangle"
                    color={data.overclocked ? 'average' : 'good'}
					disabled={!data.overclocked_upgrade}
                    onClick={() => act('overclocktoggle')}
                  >
                    切换
                  </Button.Confirm>
                </>
              }
            />
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
