import { Button, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const LaborClaimConsole = (props) => {
  const { act, data } = useBackend();
  const {
    can_go_home,
    id_points,
    ores,
    status_info,
    unclaimed_points,
    shuttle_exists,
  } = data;
  return (
    <Window width={315} height={440}>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="状态">{status_info}</LabeledList.Item>
            {!!shuttle_exists && (
              <LabeledList.Item label="穿梭机控制">
                <Button
                  content="移动穿梭机"
                  disabled={!can_go_home}
                  onClick={() => act('move_shuttle')}
                />
              </LabeledList.Item>
            )}
            <LabeledList.Item label="积分">{id_points}</LabeledList.Item>
            <LabeledList.Item
              label="未领取积分"
              buttons={
                <Button
                  content="领取积分"
                  disabled={!unclaimed_points}
                  onClick={() => act('claim_points')}
                />
              }
            >
              {unclaimed_points}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="操作说明">
          从采矿区收集巨石和矿石，并将其运至
          卸料机。然后拉动拉杆，将矿石熔炼成板材。使用
          生产控制台取出板材，再将其送至
          兑换控制台以获取积分。
          <br />
          <br />
          巨石不能直接熔炼，需要额外的
          人工处理：用镐敲击巨石，
          将其进一步破碎。
          <br />
          <br />
          劳改营熔炉产出的板材都会印有
          官方质量认证标记。只有带有标记的板材才能兑换
          积分，所以别费心拆解桌椅，
          试图用额外的金属换取积分。
        </Section>
      </Window.Content>
    </Window>
  );
};
