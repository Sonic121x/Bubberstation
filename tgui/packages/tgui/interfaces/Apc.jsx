import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';

export const Apc = (props) => {
  return (
    <Window width={450} height={445}>
      <Window.Content scrollable>
        <ApcContent />
      </Window.Content>
    </Window>
  );
};

const powerStatusMap = {
  2: {
    color: 'good',
    externalPowerText: '外部供电正常',
    chargingText: '已充满',
  },
  1: {
    color: 'average',
    externalPowerText: '外部供电不足',
    chargingText: '正在充电：',
  },
  0: {
    color: 'bad',
    externalPowerText: '无外部供电',
    chargingText: '未充电',
  },
};

const malfMap = {
  1: {
    icon: 'terminal',
    content: '覆写程序',
    action: 'hack',
  },
  2: {
    icon: 'caret-square-down',
    content: '转移核心进程',
    action: 'occupy',
  },
  3: {
    icon: 'caret-square-left',
    content: '返回主核心',
    action: 'deoccupy',
  },
  4: {
    icon: 'caret-square-down',
    content: '转移核心进程',
    action: 'occupy',
  },
};

const ApcContent = (props) => {
  const { act, data } = useBackend();
  const locked = data.locked && !data.siliconUser;
  const externalPowerStatus =
    powerStatusMap[data.externalPower] || powerStatusMap[0];
  const chargingStatus =
    powerStatusMap[data.chargingStatus] || powerStatusMap[0];
  const channelArray = data.powerChannels || [];
  const malfStatus = malfMap[data.malfStatus] || malfMap[0];
  const adjustedCellChange = data.powerCellStatus / 100;
  if (data.failTime > 0) {
    return (
      <NoticeBox info textAlign="center" mb={0}>
        <b>
          <h3>系统故障</h3>
        </b>
        输入/输出调节器故障！<br />
        正在等待系统重启。
        <br />
        将在 {data.failTime} 秒后执行软件重启……
        <br />
        <br />
        <Button
          icon="sync"
          content="立即重启"
          tooltip="强制重置界面。"
          tooltipPosition="bottom"
          onClick={() => act('reboot')}
        />
      </NoticeBox>
    );
  }
  return (
    <>
      <InterfaceLockNoticeBox
        siliconUser={data.remoteAccess || data.siliconUser}
        preventLocking={data.remoteAccess}
      />
      <Section title="电源状态">
        <LabeledList>
          <LabeledList.Item
            label="主断路器"
            color={externalPowerStatus.color}
            buttons={
              <Button
                icon={data.isOperating ? 'power-off' : 'times'}
                content={data.isOperating ? '开启' : '关闭'}
                selected={data.isOperating && !locked}
                disabled={locked}
                onClick={() => act('breaker')}
              />
            }
          >
            [ {externalPowerStatus.externalPowerText} ]
          </LabeledList.Item>
          <LabeledList.Item label="电池">
            <ProgressBar color="good" value={adjustedCellChange} />
          </LabeledList.Item>
          <LabeledList.Item
            label="充电模式"
            color={chargingStatus.color}
            buttons={
              <Button
                icon={data.chargeMode ? 'sync' : 'times'}
                content={data.chargeMode ? '自动' : '关闭'}
                disabled={locked}
                onClick={() => act('charge')}
              />
            }
          >
            [{' '}
            {chargingStatus.chargingText +
              (data.chargingStatus === 1 ? data.chargingPowerDisplay : '')}{' '}
            ]
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="供电通道">
        <LabeledList>
          {channelArray.map((channel) => {
            const { topicParams } = channel;
            return (
              <LabeledList.Item
                key={channel.title}
                label={channel.title}
                buttons={
                  <>
                    <Box
                      inline
                      mx={2}
                      color={channel.status >= 2 ? 'good' : 'bad'}
                    >
                      {channel.status >= 2 ? '开启' : '关闭'}
                    </Box>
                    <Button
                      icon="sync"
                      content="自动"
                      selected={
                        !locked &&
                        (channel.status === 1 || channel.status === 3)
                      }
                      disabled={locked}
                      onClick={() => act('channel', topicParams.auto)}
                    />
                    <Button
                      icon="power-off"
                      content="开启"
                      selected={!locked && channel.status === 2}
                      disabled={locked}
                      onClick={() => act('channel', topicParams.on)}
                    />
                    <Button
                      icon="times"
                      content="关闭"
                      selected={!locked && channel.status === 0}
                      disabled={locked}
                      onClick={() => act('channel', topicParams.off)}
                    />
                  </>
                }
              >
                {channel.powerLoad}
              </LabeledList.Item>
            );
          })}
          <LabeledList.Item label="总负载">
            <b>{data.totalLoad}</b>
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section
        title="其他"
        buttons={
          !!data.siliconUser && (
            <>
              {!!data.malfStatus && (
                <Button
                  icon={malfStatus.icon}
                  content={malfStatus.content}
                  color="bad"
                  onClick={() => act(malfStatus.action)}
                />
              )}
              <Button
                icon="lightbulb-o"
                content="过载"
                onClick={() => act('overload')}
              />
            </>
          )
        }
      >
        <LabeledList>
          <LabeledList.Item
            label="面板锁"
            buttons={
              <Button
                tooltip="APC 面板可以用撬棍撬开。"
                icon={data.coverLocked ? 'lock' : 'unlock'}
                content={data.coverLocked ? '已锁定' : '已解锁'}
                disabled={locked}
                onClick={() => act('cover')}
              />
            }
          />
          <LabeledList.Item
            label="应急照明"
            buttons={
              <Button
                tooltip="没有可用电源时，灯具使用内置电池供电。"
                icon="lightbulb-o"
                content={data.emergencyLights ? '已启用' : '已禁用'}
                disabled={locked}
                onClick={() => act('emergency_lighting')}
              />
            }
          />
          <LabeledList.Item
            label="夜班照明"
            buttons={
              <Button
                tooltip="调暗灯光以降低功耗。"
                icon="lightbulb-o"
                content={data.nightshiftLights ? '已启用' : '已禁用'}
                disabled={data.disable_nightshift_toggle}
                onClick={() => act('toggle_nightshift')}
              />
            }
          />
        </LabeledList>
      </Section>
    </>
  );
};
