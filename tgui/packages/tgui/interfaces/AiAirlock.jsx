import { Button, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const dangerMap = {
  2: {
    color: 'good',
    localStatusText: '离线',
  },
  1: {
    color: 'average',
    localStatusText: '注意',
  },
  0: {
    color: 'bad',
    localStatusText: '最佳',
  },
};

export const AiAirlock = (props) => {
  const { act, data } = useBackend();
  const statusMain = dangerMap[data.power.main] || dangerMap[0];
  const statusBackup = dangerMap[data.power.backup] || dangerMap[0];
  const statusElectrify = dangerMap[data.shock] || dangerMap[0];
  return (
    <Window width={500} height={390}>
      <Window.Content>
        <Section title="电源状态">
          <LabeledList>
            <LabeledList.Item
              label="主电源"
              color={statusMain.color}
              buttons={
                <Button
                  icon="lightbulb-o"
                  disabled={!data.power.main}
                  content="中断"
                  onClick={() => act('disrupt-main')}
                />
              }
            >
              {data.power.main ? '在线' : '离线'}{' '}
              {((!data.wires.main_1 || !data.wires.main_2) &&
                '[电线已被剪断！]') ||
                (data.power.main_timeleft > 0 &&
                  `[${data.power.main_timeleft}秒]`)}
            </LabeledList.Item>
            <LabeledList.Item
              label="备用电源"
              color={statusBackup.color}
              buttons={
                <Button
                  icon="lightbulb-o"
                  disabled={!data.power.backup}
                  content="中断"
                  onClick={() => act('disrupt-backup')}
                />
              }
            >
              {data.power.backup ? '在线' : '离线'}{' '}
              {((!data.wires.backup_1 || !data.wires.backup_2) &&
                '[电线已被剪断！]') ||
                (data.power.backup_timeleft > 0 &&
                  `[${data.power.backup_timeleft}秒]`)}
            </LabeledList.Item>
            <LabeledList.Item
              label="通电"
              color={statusElectrify.color}
              buttons={
                <>
                  <Button
                    icon="wrench"
                    disabled={!(data.wires.shock && data.shock === 0)}
                    content="恢复"
                    onClick={() => act('shock-restore')}
                  />
                  <Button
                    icon="bolt"
                    disabled={!data.wires.shock}
                    content="临时"
                    onClick={() => act('shock-temp')}
                  />
                  <Button
                    icon="bolt"
                    disabled={!data.wires.shock}
                    content="永久"
                    onClick={() => act('shock-perm')}
                  />
                </>
              }
            >
              {data.shock === 2 ? '安全' : '已通电'}{' '}
              {(!data.wires.shock && '[电线已被剪断！]') ||
                (data.shock_timeleft > 0 && `[${data.shock_timeleft}秒]`) ||
                (data.shock_timeleft === -1 && '[永久]')}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="权限与门控">
          <LabeledList>
            <LabeledList.Item
              label="ID 扫描"
              color="bad"
              buttons={
                <Button
                  icon={data.id_scanner ? 'power-off' : 'times'}
                  content={data.id_scanner ? '已启用' : '已禁用'}
                  selected={data.id_scanner}
                  disabled={!data.wires.id_scanner}
                  onClick={() => act('idscan-toggle')}
                />
              }
            >
              {!data.wires.id_scanner && '[电线已被剪断！]'}
            </LabeledList.Item>
            <LabeledList.Item
              label="紧急通行"
              buttons={
                <Button
                  icon={data.emergency ? 'power-off' : 'times'}
                  content={data.emergency ? '已启用' : '已禁用'}
                  selected={data.emergency}
                  onClick={() => act('emergency-toggle')}
                />
              }
            />
            <LabeledList.Divider />
            <LabeledList.Item
              label="门栓"
              color="bad"
              buttons={
                <Button
                  icon={data.locked ? 'lock' : 'unlock'}
                  content={data.locked ? '已落下' : '已升起'}
                  selected={data.locked}
                  disabled={!data.wires.bolts}
                  onClick={() => act('bolt-toggle')}
                />
              }
            >
              {!data.wires.bolts && '[电线已被剪断！]'}
            </LabeledList.Item>
            <LabeledList.Item
              label="门状态指示灯"
              color="bad"
              buttons={
                <Button
                  icon={data.feedback ? 'power-off' : 'times'}
                  content={data.feedback ? '已启用' : '已禁用'}
                  selected={data.feedback}
                  disabled={!data.wires.feedback}
                  onClick={() => act('light-toggle')}
                />
              }
            >
              {!data.wires.feedback && '[电线已被剪断！]'}
            </LabeledList.Item>
            <LabeledList.Item
              label="门压力传感器"
              color="bad"
              buttons={
                <Button
                  icon={data.safe ? 'power-off' : 'times'}
                  content={data.safe ? '已启用' : '已禁用'}
                  selected={data.safe}
                  disabled={!data.wires.safe}
                  onClick={() => act('safe-toggle')}
                />
              }
            >
              {!data.wires.safe && '[电线已被剪断！]'}
            </LabeledList.Item>
            <LabeledList.Item
              label="门定时安全机制"
              color="bad"
              buttons={
                <Button
                  icon={data.speed ? 'power-off' : 'times'}
                  content={data.speed ? '已启用' : '已禁用'}
                  selected={data.speed}
                  disabled={!data.wires.timing}
                  onClick={() => act('speed-toggle')}
                />
              }
            >
              {!data.wires.timing && '[电线已被剪断！]'}
            </LabeledList.Item>
            <LabeledList.Divider />
            <LabeledList.Item
              label="门控制"
              color="bad"
              buttons={
                <Button
                  icon={data.opened ? 'sign-out-alt' : 'sign-in-alt'}
                  content={data.opened ? '开启' : '关闭'}
                  selected={data.opened}
                  disabled={data.locked || data.welded}
                  onClick={() => act('open-close')}
                />
              }
            >
              {!!(data.locked || data.welded) && (
                <span>
                  [门已{data.locked ? '栓住' : ''}
                  {data.locked && data.welded ? '并' : ''}
                  {data.welded ? '焊死' : ''}！]
                </span>
              )}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
