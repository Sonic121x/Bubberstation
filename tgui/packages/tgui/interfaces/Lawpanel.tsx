import { countBy } from 'es-toolkit';
import { useMemo } from 'react';
import {
  Button,
  Collapsible,
  Dimmer,
  Flex,
  Icon,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const lawtype_to_color = {
  inherent: 'white',
  supplied: 'purple',
  hacked: 'orange',
  zeroth: 'red',
} as const;

type Law = {
  lawtype: string;
  // The actual law text
  law: string;
  // Law index in the list
  // Zeroth laws will always be "zero"
  // and hacked/ion laws will have an index of -1
  num: number;
};

type Silicon = {
  // Name of the silicon. Includes PAI and AI
  borg_name: string;
  borg_type: string;
  // List of our laws, this is almost never null. If it is null, that's an error.
  laws: null | Law[];
  // String, name of our master AI. Null means no master or we're not a borg
  master_ai?: null | string;
  // TRUE, we're law-synced to our master AI. FALSE, we're not, null, we're not a borg
  borg_synced?: null | BooleanLike;
  // REF() to our silicon
  ref: string;
};

type Data = {
  all_silicons: Silicon[];
};

const SyncedBorgDimmer = (props: { master: string }) => {
  return (
    <Dimmer>
      <Stack textAlign="center" vertical>
        <Stack.Item>
          <Icon color="green" name="wifi" size={10} />
        </Stack.Item>
        <Stack.Item fontSize="18px">
          此半机械人已连接至“{props.master}”。
        </Stack.Item>
        <Stack.Item fontSize="14px">请修改其主控 AI 的法则。</Stack.Item>
      </Stack>
    </Dimmer>
  );
};

export const LawPrintout = (props: { cyborg_ref: string; lawset: Law[] }) => {
  const { act } = useBackend<Law>();
  const { cyborg_ref, lawset } = props;

  const num_of_each_lawtype = useMemo(() => {
    return countBy(lawset, (law) => law.lawtype);
  }, [lawset]);

  return (
    <LabeledList>
      {lawset.map((law, index) => (
        <>
          <LabeledList.Item
            key={index}
            label={law.num >= 0 ? `${law.num}` : '?!$'}
            color={lawtype_to_color[law.lawtype] || 'pink'}
            buttons={
              <Stack>
                <Stack.Item>
                  <Button.Confirm
                    icon="trash"
                    confirmContent=""
                    confirmIcon="check"
                    color={'red'}
                    onClick={() =>
                      act('remove_law', {
                        ref: cyborg_ref,
                        law: law.law,
                        lawtype: law.lawtype,
                      })
                    }
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    color={'green'}
                    onClick={() =>
                      act('edit_law_text', {
                        ref: cyborg_ref,
                        law: law.law,
                        lawtype: law.lawtype,
                      })
                    }
                  >
                    编辑
                  </Button>
                </Stack.Item>
                {law.lawtype === 'inherent' && (
                  <>
                    <Stack.Item>
                      <Button
                        icon="arrow-up"
                        color={'green'}
                        disabled={law.num === 1}
                        onClick={() =>
                          act('move_law', {
                            ref: cyborg_ref,
                            law: law.law,
                            // may seem confusing at a glance,
                            // but pressing up = actually moving it down.
                            direction: 'down',
                          })
                        }
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="arrow-down"
                        color={'green'}
                        disabled={law.num === num_of_each_lawtype.inherent}
                        onClick={() =>
                          act('move_law', {
                            ref: cyborg_ref,
                            law: law.law,
                            // may seem confusing at a glance,
                            // but pressing down = actually moving it up.
                            direction: 'up',
                          })
                        }
                      />
                    </Stack.Item>
                  </>
                )}
              </Stack>
            }
          >
            {law.law}
          </LabeledList.Item>
          <LabeledList.Divider />
        </>
      ))}
      <LabeledList.Item label="???">
        <Button
          icon="plus"
          color={'green'}
          content={'添加法则'}
          onClick={() => act('add_law', { ref: cyborg_ref })}
        />
      </LabeledList.Item>
      <LabeledList.Divider />
    </LabeledList>
  );
};

export const SiliconReadout = (props: { cyborg: Silicon }) => {
  const { data, act } = useBackend<Silicon>();
  const { cyborg } = props;

  return (
    <Flex>
      <Flex.Item grow>
        <Collapsible title={`${cyborg.borg_type}: ${cyborg.borg_name}`}>
          <Section backgroundColor={'black'}>
            {cyborg.master_ai && !!cyborg.borg_synced && (
              <SyncedBorgDimmer master={cyborg.master_ai} />
            )}
            <Stack vertical>
              <Stack.Item>
                {cyborg.laws === null ? (
                  <Button
                    fluid
                    textAlign="center"
                    color="danger"
                    content={`此硅基生物的法则数据为空。这是
                      不应发生的错误！请提交问题报告，
                      然后点击此处为其创建法则数据。`}
                    onClick={() => act('give_law_datum', { ref: cyborg.ref })}
                  />
                ) : (
                  <LawPrintout lawset={cyborg.laws} cyborg_ref={cyborg.ref} />
                )}
              </Stack.Item>
              <Stack.Item>
                <Stack>
                  <Stack.Item>
                    <Button
                      icon="bullhorn"
                      content={'强制宣读法则'}
                      tooltip={`强制该硅基生物宣读法则。
                        只宣读固有／核心法则。`}
                      onClick={() =>
                        act('force_state_laws', { ref: cyborg.ref })
                      }
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      icon="message"
                      content={'私下告知法则'}
                      tooltip={`在该硅基生物的聊天框中显示
                        其全部法则。若对象为 AI，
                        也会向所有连接的半机械人显示。`}
                      onClick={() =>
                        act('announce_law_changes', { ref: cyborg.ref })
                      }
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      icon="bell"
                      content={'“法则已更新”提示'}
                      tooltip={`向该硅基生物发出屏幕提示，告知其
                        法则已更新。也会在聊天框中显示法则，
                        并通知亡者频道。`}
                      onClick={() =>
                        act('laws_updated_alert', { ref: cyborg.ref })
                      }
                    />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            </Stack>
          </Section>
        </Collapsible>
      </Flex.Item>
    </Flex>
  );
};

export const Lawpanel = (props) => {
  const { data, act } = useBackend<Data>();
  const { all_silicons } = data;

  return (
    <Window title="法则面板" theme="admin" width={800} height={600}>
      <Window.Content>
        <Section
          fill
          title="所有硅基生物法则"
          scrollable
          buttons={
            <Button
              icon="robot"
              content="日志"
              onClick={() => act('lawchange_logs')}
            />
          }
        >
          <Stack vertical>
            {all_silicons.length ? (
              all_silicons.map((silicon, index) => (
                <Stack.Item key={index}>
                  <SiliconReadout cyborg={silicon} />
                </Stack.Item>
              ))
            ) : (
              <Stack.Item>
                <NoticeBox>当前不存在硅基生物。</NoticeBox>
              </Stack.Item>
            )}
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
