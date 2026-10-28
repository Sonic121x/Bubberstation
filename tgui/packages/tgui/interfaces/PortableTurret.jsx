import { Button, LabeledList, NoticeBox, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const PortableTurret = (props) => {
  const { act, data } = useBackend();
  const {
    silicon_user,
    locked,
    on,
    check_weapons,
    neutralize_criminals,
    neutralize_all,
    neutralize_unidentified,
    neutralize_nonmindshielded,
    neutralize_cyborgs,
    neutralize_heads,
    manual_control,
    allow_manual_control,
    lasertag_turret,
  } = data;
  return (
    <Window width={310} height={lasertag_turret ? 110 : 292}>
      <Window.Content>
        <NoticeBox>
          刷 ID 卡以{locked ? '解锁' : '锁定'}此界面。
        </NoticeBox>

        <Section>
          <LabeledList>
            <LabeledList.Item
              label="状态"
              buttons={
                !lasertag_turret &&
                (!!allow_manual_control ||
                  (!!manual_control && !!silicon_user)) && (
                  <Button
                    icon={manual_control ? 'wifi' : 'terminal'}
                    content={
                      manual_control ? '正被远程控制' : '手动控制'
                    }
                    disabled={manual_control}
                    color="bad"
                    onClick={() => act('manual')}
                  />
                )
              }
            >
              <Button
                icon={on ? 'power-off' : 'times'}
                content={on ? '开启' : '关闭'}
                selected={on}
                disabled={locked}
                onClick={() => act('power')}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {!lasertag_turret && (
          <Section
            title="目标设置"
            buttons={
              <Button.Checkbox
                checked={!neutralize_heads}
                content="忽略指挥人员"
                disabled={locked}
                onClick={() => act('shootheads')}
              />
            }
          >
            <Button.Checkbox
              fluid
              checked={neutralize_all}
              content="非安保且非指挥人员"
              disabled={locked}
              onClick={() => act('shootall')}
            />
            <Button.Checkbox
              fluid
              checked={check_weapons}
              content="未经授权的武器"
              disabled={locked}
              onClick={() => act('authweapon')}
            />
            <Button.Checkbox
              fluid
              checked={neutralize_unidentified}
              content="不明生命信号"
              disabled={locked}
              onClick={() => act('checkxenos')}
            />
            <Button.Checkbox
              fluid
              checked={neutralize_nonmindshielded}
              content="无心智护盾者"
              disabled={locked}
              onClick={() => act('checkloyal')}
            />
            <Button.Checkbox
              fluid
              checked={neutralize_criminals}
              content="通缉犯"
              disabled={locked}
              onClick={() => act('shootcriminals')}
            />
            <Button.Checkbox
              fluid
              checked={neutralize_cyborgs}
              content="机器人"
              disabled={locked}
              onClick={() => act('shootborgs')}
            />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
