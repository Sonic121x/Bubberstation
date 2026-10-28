import {
  Box,
  Button,
  Icon,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { NtosWindow } from '../layouts';

export const NtosNetMonitor = (props) => {
  const { act, data } = useBackend();
  const [tab_main, setTab_main] = useSharedState('tab_main', 1);
  const {
    ntnetrelays,
    idsalarm,
    idsstatus,
    ntnetlogs = [],
    tablets = [],
  } = data;

  return (
    <NtosWindow>
      <NtosWindow.Content scrollable>
        <Stack.Item>
          <Tabs>
            <Tabs.Tab
              icon="network-wired"
              lineHeight="23px"
              selected={tab_main === 1}
              onClick={() => setTab_main(1)}
            >
              纳米传讯网络
            </Tabs.Tab>
            <Tabs.Tab
              icon="tablet"
              lineHeight="23px"
              selected={tab_main === 2}
              onClick={() => setTab_main(2)}
            >
              平板电脑（{tablets.length}）
            </Tabs.Tab>
          </Tabs>
        </Stack.Item>
        {tab_main === 1 && (
          <Stack.Item>
            <MainPage
              ntnetrelays={ntnetrelays}
              idsalarm={idsalarm}
              idsstatus={idsstatus}
              ntnetlogs={ntnetlogs}
            />
          </Stack.Item>
        )}
        {tab_main === 2 && (
          <Stack.Item>
            <TabletPage tablets={tablets} />
          </Stack.Item>
        )}
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const MainPage = (props) => {
  const { ntnetrelays, idsalarm, idsstatus, ntnetlogs = [] } = props;
  const { act, data } = useBackend();

  return (
    <Section>
      <NoticeBox>
        警告：通过无线设备关闭无线发射器后，
        您可能无法重新启用它们！
      </NoticeBox>
      <Section title="无线连接">
        {ntnetrelays.map((relay) => (
          <Section
            key={relay.ref}
            title={relay.name}
            buttons={
              <Button.Confirm
                color={relay.is_operational ? 'good' : 'bad'}
                content={relay.is_operational ? '已启用' : '已禁用'}
                onClick={() =>
                  act('toggle_relay', {
                    ref: relay.ref,
                  })
                }
              />
            }
          />
        ))}
      </Section>
      <Section title="安全系统">
        {!!idsalarm && (
          <>
            <NoticeBox>检测到网络入侵</NoticeBox>
            <Box italics>
              网络中检测到异常活动。请查看系统
              日志以了解更多信息。
            </Box>
          </>
        )}
        <LabeledList>
          <LabeledList.Item
            label="入侵检测系统状态"
            buttons={
              <>
                <Button
                  icon={idsstatus ? 'power-off' : 'times'}
                  content={idsstatus ? '已启用' : '已禁用'}
                  selected={idsstatus}
                  onClick={() => act('toggleIDS')}
                />
                <Button
                  icon="sync"
                  content="重置"
                  color="bad"
                  onClick={() => act('resetIDS')}
                />
              </>
            }
          />
        </LabeledList>
        <Section
          title="系统日志"
          buttons={
            <Button.Confirm
              icon="trash"
              content="清空日志"
              onClick={() => act('purgelogs')}
            />
          }
        >
          {ntnetlogs.map((log) => (
            <Box key={log.entry} className="candystripe">
              {log.entry}
            </Box>
          ))}
        </Section>
      </Section>
    </Section>
  );
};

const TabletPage = (props) => {
  const { tablets } = props;
  const { act, data } = useBackend();
  if (!tablets.length) {
    return <NoticeBox>未检测到平板电脑。</NoticeBox>;
  }
  return (
    <Section>
      <Stack vertical mt={1}>
        <Section fill textAlign="center">
          <Icon name="comment" mr={1} />
          在线平板电脑
        </Section>
      </Stack>
      <Stack vertical mt={1}>
        <Section fill>
          <Stack vertical>
            {tablets.map((tablet) => (
              <Section
                key={tablet.ref}
                title={tablet.name}
                buttons={
                  <Button.Confirm
                    icon={tablet.enabled_spam ? 'unlock' : 'lock'}
                    color={tablet.enabled_spam ? 'good' : 'default'}
                    content={
                      tablet.enabled_spam
                        ? '限制 PDA 群发'
                        : '允许 PDA 群发'
                    }
                    onClick={() =>
                      act('toggle_mass_pda', {
                        ref: tablet.ref,
                      })
                    }
                  />
                }
              />
            ))}
          </Stack>
        </Section>
      </Stack>
    </Section>
  );
};
