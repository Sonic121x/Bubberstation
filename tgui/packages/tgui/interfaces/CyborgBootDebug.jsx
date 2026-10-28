import { Button, Input, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const TOOLTIP_NAME = `
  输入此单元的新名称。留空可恢复默认设置，
  这样该单元就可以自行选择名称。
`;

const TOOLTIP_LOCOMOTION = `
  若设为受限，该单元将被
  锁定，直到解除限制。
`;

const TOOLTIP_PANEL = `
  解锁后，即使没有适当授权，
  也能打开该单元的盖板。
`;

const TOOLTIP_AISYNC = `
  关闭后，该单元将
  不会与任何 AI 配对。
`;

const TOOLTIP_AI = `
  设置哪个 AI 将成为
  此单元的主控 AI。
`;

const TOOLTIP_LAWSYNC = `
  关闭后，此单元不会与主控 AI
  同步法则。
`;

export const CyborgBootDebug = (props) => {
  const { act, data } = useBackend();
  const { designation, master, lawsync, aisync, locomotion, panel } = data;
  return (
    <Window width={master?.length > 26 ? 537 : 440} height={289}>
      <Window.Content>
        <Section title="基本设置">
          <LabeledList>
            <LabeledList.Item
              label="名称"
              buttons={
                <Button
                  icon="info"
                  tooltip={TOOLTIP_NAME}
                  tooltipPosition="left"
                />
              }
            >
              <Input
                fluid
                value={designation || ''} placeholder="默认机器人"
                onBlur={(value) =>
                  act('rename', {
                    new_name: value,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item
              label="伺服电机功能"
              buttons={
                <Button
                  icon="info"
                  tooltip={TOOLTIP_LOCOMOTION}
                  tooltipPosition="left"
                />
              }
            >
              <Button
                icon={locomotion ? 'unlock' : 'lock'}
                content={locomotion ? '自由' : '受限'}
                color={locomotion ? 'good' : 'bad'}
                onClick={() => act('locomotion')}
              />
            </LabeledList.Item>
            <LabeledList.Item
              label="盖板"
              buttons={
                <Button
                  icon="info"
                  tooltip={TOOLTIP_PANEL}
                  tooltipPosition="left"
                />
              }
            >
              <Button
                icon={panel ? 'lock' : 'unlock'}
                content={panel ? '已锁定' : '已解锁'}
                onClick={() => act('panel')}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="AI 设置">
          <LabeledList>
            <LabeledList.Item
              label="AI 连接端口"
              buttons={
                <Button
                  icon="info"
                  tooltip={TOOLTIP_AISYNC}
                  tooltipPosition="left"
                />
              }
            >
              <Button
                icon={aisync ? 'unlock' : 'lock'}
                content={aisync ? '开启' : '关闭'}
                onClick={() => act('aisync')}
              />
            </LabeledList.Item>
            <LabeledList.Item
              label="主控 AI"
              buttons={
                <Button
                  icon="info"
                  tooltip={TOOLTIP_AI}
                  tooltipPosition="left"
                />
              }
            >
              <Button
                icon={!aisync ? 'times' : master ? 'edit' : 'sync'}
                content={!aisync ? '无' : master || '自动'}
                color={master ? 'default' : 'good'}
                disabled={!aisync}
                onClick={() => act('set_ai')}
              />
            </LabeledList.Item>
            <LabeledList.Item
              label="法则同步端口"
              buttons={
                <Button
                  icon="info"
                  tooltip={TOOLTIP_LAWSYNC}
                  tooltipPosition="top-start"
                />
              }
            >
              <Button
                icon={!aisync ? 'lock' : lawsync ? 'unlock' : 'lock'}
                content={!aisync ? '关闭' : lawsync ? '开启' : '关闭'}
                disabled={!aisync}
                onClick={() => act('lawsync')}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
