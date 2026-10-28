import { LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { AirAlarmData } from './types';

const dangerMap = {
  0: {
    color: 'good',
    localStatusText: '良好',
  },
  1: {
    color: 'average',
    localStatusText: '注意',
  },
  2: {
    color: 'bad',
    localStatusText: '危险（需要内供气）',
  },
} as const;

const faultMap = {
  0: {
    color: 'good',
    areaFaultText: '无',
  },
  1: {
    color: 'purple',
    areaFaultText: '手动触发',
  },
  2: {
    color: 'average',
    areaFaultText: '自动检测',
  },
} as const;

export function AirAlarmStatus(props) {
  const { data } = useBackend<AirAlarmData>();
  const { envData } = data;

  const localStatus = dangerMap[data.dangerLevel] || dangerMap[0];
  const areaFault = faultMap[data.faultStatus] || faultMap[0];

  return (
    <Section title="空气状态">
      <LabeledList>
        {envData.length <= 0 ? (
          <LabeledList.Item label="警告" color="bad">
            无法获取空气样本进行分析。
          </LabeledList.Item>
        ) : (
          <>
            {envData.map((entry) => {
              const status = dangerMap[entry.danger] || dangerMap[0];
              return (
                <LabeledList.Item
                  key={entry.name}
                  label={entry.name}
                  color={status.color}
                >
                  {entry.value}
                </LabeledList.Item>
              );
            })}
            <LabeledList.Item label="本地状态" color={localStatus.color}>
              {localStatus.localStatusText}
            </LabeledList.Item>
            <LabeledList.Item
              label="区域状态"
              color={data.atmosAlarm || data.fireAlarm ? 'bad' : 'good'}
            >
              {(data.atmosAlarm && '大气警报') ||
                (data.fireAlarm && '火灾警报') ||
                '正常'}
            </LabeledList.Item>
            <LabeledList.Item label="故障状态" color={areaFault.color}>
              {areaFault.areaFaultText}
            </LabeledList.Item>
            <LabeledList.Item
              label="故障位置"
              color={data.faultLocation ? 'blue' : 'good'}
            >
              {data.faultLocation || '无'}
            </LabeledList.Item>
          </>
        )}
        {!!data.emagged && (
          <LabeledList.Item label="警告" color="bad">
            安全措施已停用。设备可能出现异常行为。
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
}
