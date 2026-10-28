// THIS IS A SKYRAT UI FILE
import { useState } from 'react';
import {
  Box,
  Button,
  Collapsible,
  Input,
  LabeledList,
  NoticeBox,
  NumberInput,
  Section,
  Slider,
  Stack,
  Tabs,
  TextArea,
} from 'tgui-core/components';
import { round } from 'tgui-core/math';
import { chineseDisplay } from 'tgui/localization/zhDisplay';
import { useBackend } from '../backend';
import { Window } from '../layouts'; import { displayRole } from '../localization/roleDisplay';

export const OpposingForcePanel = (props) => {
  const [tab, setTab] = useState(1);
  const { act, data } = useBackend();
  const { admin_mode, creator_ckey, owner_antag } = data;
  return (
    <Window
      title={`敌对势力：${creator_ckey}`}
      width={585}
      height={860}
      theme={owner_antag ? 'syndicate' : 'admin'}
    >
      <Window.Content scrollable>
        <Stack vertical grow mb={1}>
          <Stack.Item>
            <Tabs fill>
              {admin_mode ? (
                <>
                  <Tabs.Tab
                    width="100%"
                    selected={tab === 1}
                    onClick={() => setTab(1)}
                  >
                    管理员控制
                  </Tabs.Tab>
                  <Tabs.Tab
                    width="100%"
                    selected={tab === 2}
                    onClick={() => setTab(2)}
                  >
                    管理员聊天
                  </Tabs.Tab>
                </>
              ) : (
                <>
                  <Tabs.Tab
                    width="100%"
                    selected={tab === 1}
                    onClick={() => setTab(1)}
                  >
                    概览
                  </Tabs.Tab>
                  <Tabs.Tab
                    width="100%"
                    selected={tab === 2}
                    onClick={() => setTab(2)}
                  >
                    装备
                  </Tabs.Tab>
                  <Tabs.Tab
                    width="100%"
                    selected={tab === 3}
                    onClick={() => setTab(3)}
                  >
                    管理员聊天
                  </Tabs.Tab>
                </>
              )}
            </Tabs>
          </Stack.Item>
        </Stack>
        {admin_mode ? (
          <>
            {tab === 1 && <AdminTab />}
            {tab === 2 && <AdminChatTab />}
          </>
        ) : (
          <>
            {tab === 1 && <OpposingForceTab />}
            {tab === 2 && <EquipmentTab />}
            {tab === 3 && <AdminChatTab />}
          </>
        )}
      </Window.Content>
    </Window>
  );
};

export const OpposingForceTab = (props) => {
  const { act, data } = useBackend();
  const {
    creator_ckey,
    objectives = [],
    can_submit,
    status,
    can_request_update,
    request_updates_muted,
    can_edit,
    backstory,
    handling_admin,
    blocked,
    approved,
    denied,
  } = data;
  return (
    <Stack vertical grow>
      <Stack.Item>
        <Section
          title={
            handling_admin
              ? `控制 - 负责管理员：${handling_admin}`
              : '控制'
          }
        >
          <Stack>
            <Stack.Item>
              <Button
                icon="check"
                color="good"
                tooltip={
                  '提交申请以供审核。' +
                  (blocked ? '（已被禁止申请）' : '')
                }
                disabled={!can_submit || blocked}
                content="提交申请"
                onClick={() => act('submit')}
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="question"
                color="orange"
                tooltip={
                  '向管理员询问处理进度。' +
                  (request_updates_muted ? '（已禁言）' : '')
                }
                disabled={!can_request_update || request_updates_muted}
                content="询问进度"
                onClick={() => act('request_update')}
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="wrench"
                color="blue"
                tooltip="修改申请，这会重置所有批准状态。"
                disabled={can_edit}
                content="修改申请"
                onClick={() => act('modify_request')}
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="trash"
                color="bad"
                tooltip="将申请从队列中移除。"
                disabled={status === 'Not submitted'}
                content="撤回申请"
                onClick={() => act('close_application')}
              />
            </Stack.Item>
          </Stack>
          <Stack>
            <Stack.Item>
              <Button
                icon="file-import"
                color="blue"
                tooltip="从 .json 文件导入申请。"
                disabled={status === 'Awaiting approval'}
                content="导入 JSON"
                onClick={() => act('import_json')}
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="file-export"
                color="purple"
                tooltip="将申请导出为 .json 文件。"
                disabled={status === 'Awaiting approval'}
                content="导出 JSON"
                onClick={() => act('export_json')}
              />
            </Stack.Item>
          </Stack>
          <NoticeBox
            color={approved ? 'good' : denied ? 'bad' : 'orange'}
            mt={2}
          >
            {chineseDisplay(status)}
          </NoticeBox>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="背景故事">
          <TextArea
            fluid
            disabled={!can_edit}
            height="100px"
            value={backstory}
            placeholder="说明你为何想要作恶。请写明导致角色产生这种想法的具体经历，站在角色的立场思考并作出合理反应。（限 2000 字符）"
            onBlur={(value) =>
              act('set_backstory', {
                backstory: value,
              })
            }
          />
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section
          title="目标"
          buttons={
            <Button
              icon="plus"
              content="添加目标"
              onClick={() => act('add_objective')}
            />
          }
        >
          {!!objectives.length && <OpposingForceObjectives />}
        </Section>
      </Stack.Item>
    </Stack>
  );
};

export const OpposingForceObjectives = (props) => {
  const { act, data } = useBackend();
  const { objectives = [], can_edit } = data;

  const [selectedObjectiveID, setSelectedObjective] = useState(
    objectives[0]?.id,
  );

  const selectedObjective = objectives.find((objective) => {
    return objective.id === selectedObjectiveID;
  });

  return (
    <Stack vertical grow>
      {objectives.length > 0 && (
        <Stack.Item>
          <Tabs fill>
            {objectives.map((objective) => (
              <Tabs.Tab
                color={
                  objective.status_text === 'Not Reviewed'
                    ? 'yellow'
                    : objective.approved
                      ? 'good'
                      : 'bad'
                }
                textColor={
                  objective.status_text === 'Not Reviewed'
                    ? 'yellow'
                    : objective.approved
                      ? 'good'
                      : 'bad'
                }
                width="25%"
                key={objective.id}
                selected={objective.id === selectedObjectiveID}
                onClick={() => setSelectedObjective(objective.id)}
              >
                <Stack align="center">
                  <Stack.Item width="80%">
                    {objective.title ? objective.title : '空白目标'}
                  </Stack.Item>
                  <Stack.Item width="20%">
                    <Button
                      disabled={!can_edit}
                      height="90%"
                      icon="minus"
                      color="bad"
                      textAlign="center"
                      tooltip="移除目标"
                      onClick={() =>
                        act('remove_objective', {
                          objective_ref: objective.ref,
                        })
                      }
                    />
                  </Stack.Item>
                </Stack>
              </Tabs.Tab>
            ))}
          </Tabs>
        </Stack.Item>
      )}
      {selectedObjective ? (
        <Stack.Item>
          <Stack vertical>
            <Stack.Item>
              <Stack.Item>
                <Stack vertical>
                  <Stack.Item>标题</Stack.Item>
                  <Stack.Item>
                    <Input
                      disabled={!can_edit}
                      width="100%"
                      placeholder="空白目标"
                      value={selectedObjective.title}
                      onBlur={(value) =>
                        act('set_objective_title', {
                          objective_ref: selectedObjective.ref,
                          title: value,
                        })
                      }
                    />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item>
                <Stack vertical mt={2}>
                  <Stack.Item>
                    强度：{chineseDisplay(selectedObjective.text_intensity)}
                  </Stack.Item>
                  <Stack.Item>
                    <Slider
                      disabled={!can_edit}
                      step={1}
                      value={selectedObjective.intensity}
                      format={(value) => round(value, 1)}
                      minValue={0}
                      maxValue={500}
                      ranges={{
                        good: [0, 149],
                        teal: [150, 249],
                        olive: [250, 349],
                        orange: [350, 449],
                        red: [450, 500],
                      }}
                      onDrag={(_e, value) =>
                        act('set_objective_intensity', {
                          objective_ref: selectedObjective.ref,
                          new_intensity_level: value,
                        })
                      }
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Stack>
                      <Stack.Item>
                        <Button
                          ml={7.6}
                          mr={15}
                          disabled={!can_edit}
                          icon="laugh"
                          color="good"
                          onClick={() =>
                            act('set_objective_intensity', {
                              objective_ref: selectedObjective.ref,
                              new_intensity_level: 50,
                            })
                          }
                        />
                        <Button
                          mr={15}
                          disabled={!can_edit}
                          icon="smile"
                          color="teal"
                          onClick={() =>
                            act('set_objective_intensity', {
                              objective_ref: selectedObjective.ref,
                              new_intensity_level: 150,
                            })
                          }
                        />
                        <Button
                          mr={15}
                          disabled={!can_edit}
                          icon="meh-blank"
                          color="olive"
                          onClick={() =>
                            act('set_objective_intensity', {
                              objective_ref: selectedObjective.ref,
                              new_intensity_level: 250,
                            })
                          }
                        />
                        <Button
                          mr={15}
                          disabled={!can_edit}
                          icon="frown"
                          color="orange"
                          onClick={() =>
                            act('set_objective_intensity', {
                              objective_ref: selectedObjective.ref,
                              new_intensity_level: 350,
                            })
                          }
                        />
                        <Button
                          disabled={!can_edit}
                          icon="grimace"
                          color="red"
                          onClick={() =>
                            act('set_objective_intensity', {
                              objective_ref: selectedObjective.ref,
                              new_intensity_level: 450,
                            })
                          }
                        />
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item>
                <Stack vertical mt={2}>
                  <Stack.Item>描述</Stack.Item>
                  <Stack.Item>
                    <TextArea
                      fluid
                      disabled={!can_edit}
                      height="85px"
                      value={selectedObjective.description}
                      placeholder="在此详细说明你想达成的目标，例如“摧毁死星”或“摧毁死星及其基地”。（限 1000 字符）"
                      onBlur={(value) =>
                        act('set_objective_description', {
                          objective_ref: selectedObjective.ref,
                          new_desciprtion: value,
                        })
                      }
                    />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item>
                <Stack vertical mt={2}>
                  <Stack.Item>理由</Stack.Item>
                  <Stack.Item>
                    <TextArea
                      fluid
                      disabled={!can_edit}
                      height="85px"
                      value={selectedObjective.justification}
                      placeholder="在此填写执行该目标的理由，确保你的目标有充分依据。（限 1000 字符）"
                      onBlur={(value) =>
                        act('set_objective_justification', {
                          objective_ref: selectedObjective.ref,
                          new_justification: value,
                        })
                      }
                    />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item mt={2}>
                <NoticeBox color={selectedObjective.approved ? 'good' : 'bad'}>
                  {selectedObjective.status_text === 'Not Reviewed'
                    ? '目标未审核'
                    : selectedObjective.approved
                      ? '目标已批准'
                      : selectedObjective.denied_text
                        ? '目标已拒绝，原因：' +
                          selectedObjective.denied_text
                        : '目标已拒绝'}
                </NoticeBox>
              </Stack.Item>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      ) : (
        <Stack.Item>未选择目标。</Stack.Item>
      )}
    </Stack>
  );
};

export const EquipmentTab = (props) => {
  const { act, data } = useBackend();
  const { equipment_list = [], selected_equipment = [], can_edit } = data;
  return (
    <Stack vertical grow>
      <Stack.Item>
        <Section title="已选装备">
          {selected_equipment.length === 0 ? (
            <Box color="bad">未选择装备。</Box>
          ) : (
            selected_equipment.map((equipment) => (
              <>
                <LabeledList key={equipment.ref}>
                  <LabeledList.Item
                    buttons={
                      <>
                        <NumberInput
                          animated
                          value={equipment.count}
                          minValue={1}
                          maxValue={5}
                          onChange={(value) =>
                            act('set_equipment_count', {
                              selected_equipment_ref: equipment.ref,
                              new_equipment_count: value,
                            })
                          }
                        />
                        <Button
                          icon="times"
                          color="bad"
                          content="移除"
                          onClick={() =>
                            act('remove_equipment', {
                              selected_equipment_ref: equipment.ref,
                            })
                          }
                        />
                      </>
                    }
                    label={equipment.name}
                  />
                  <LabeledList.Item label="状态">
                    {equipment.denied_reason
                      ? chineseDisplay(equipment.status) +
                        '，原因：' +
                        equipment.denied_reason
                      : chineseDisplay(equipment.status)}
                  </LabeledList.Item>
                </LabeledList>
                <Input
                  mt={1}
                  mb={1}
                  disabled={!can_edit}
                  width="100%"
                  placeholder="申请此物品的理由"
                  value={equipment.reason}
                  onBlur={(value) =>
                    act('set_equipment_reason', {
                      selected_equipment_ref: equipment.ref,
                      new_equipment_reason: value,
                    })
                  }
                />
              </>
            ))
          )}
        </Section>
        <Section title="可用装备">
          <Stack vertical fill>
            {equipment_list.map((equipment_category) => (
              <Stack.Item key={equipment_category.category}>
                <Collapsible
                  title={chineseDisplay(equipment_category.category)}
                  key={equipment_category.category}
                >
                  <Section>
                    {equipment_category.items.map((item) => (
                      <Section
                        title={item.name}
                        key={item.ref}
                        buttons={
                          <Button
                            icon="check"
                            color="good"
                            content="选择"
                            disabled={!can_edit}
                            onClick={() =>
                              act('select_equipment', {
                                equipment_ref: item.ref,
                              })
                            }
                          />
                        }
                      >
                        <LabeledList>
                          <LabeledList.Item label="描述">
                            {item.description}
                          </LabeledList.Item>
                        </LabeledList>
                      </Section>
                    ))}
                  </Section>
                </Collapsible>
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

export const AdminChatTab = (props) => {
  const { act, data } = useBackend();
  const { messages = [] } = data;
  return (
    <Stack vertical fill>
      <Stack.Item grow={10}>
        <Section scrollable fill>
          {messages.map((message) => (
            <Box key={message.msg}>{message.msg}</Box>
          ))}
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <Input
          height="22px"
          fluid
          selfClear
          placeholder="发送消息，或使用“/”输入命令"
          mt={1}
          onEnter={(value) =>
            act('send_message', {
              message: value,
            })
          }
        />
      </Stack.Item>
    </Stack>
  );
};

export const AdminTab = (props) => {
  const { act, data } = useBackend();
  const {
    request_updates_muted,
    approved,
    denied,
    objectives = [],
    selected_equipment = [],
    backstory,
    blocked,
    equipment_issued,
    owner_mob,
    owner_role,
    raw_status,
  } = data;
  return (
    <Stack vertical grow>
      <Stack.Item>
        <Section title="用户信息">
          <LabeledList>
            <LabeledList.Item label="名称">{owner_mob}</LabeledList.Item>
            <LabeledList.Item label="角色">{displayRole(owner_role)}</LabeledList.Item>
            <LabeledList.Item label="申请状态">
              {chineseDisplay(raw_status)}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="管理员控制">
          <Stack mb={1}>
            <Stack.Item>
              <Button
                icon="check"
                color="good"
                tooltip="批准申请及其中已通过审核的目标。"
                disabled={approved}
                content="批准"
                onClick={() => act('approve')}
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="check-double"
                color="orange"
                tooltip="批准申请及全部目标和装备。请务必先审核申请与目标！"
                disabled={approved}
                content="全部批准"
                onClick={() => act('approve_all')}
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="universal-access"
                color="purple"
                disabled={!approved || equipment_issued}
                tooltip="向玩家发放全部已批准装备。"
                content="发放装备"
                onClick={() => act('issue_gear')}
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="times"
                color="red"
                disabled={denied}
                content="拒绝"
                onClick={() => act('deny')}
              />
            </Stack.Item>
            <Stack.Item>
              {blocked ? (
                <Button
                  icon="check-circle"
                  color="green"
                  tooltip="恢复该用户提交申请的权限。"
                  content="解除申请限制"
                  onClick={() => act('toggle_block')}
                />
              ) : (
                <Button
                  icon="ban"
                  color="red"
                  tooltip="禁止该用户提交申请。"
                  content="禁止申请"
                  onClick={() => act('toggle_block')}
                />
              )}
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="suitcase"
                color="blue"
                tooltip="将自己设为负责此申请的管理员。"
                content="接手处理"
                onClick={() => act('handle')}
              />
            </Stack.Item>
          </Stack>
          <Stack>
            <Stack.Item>
              {request_updates_muted ? (
                <Button
                  icon="volume-up"
                  color="green"
                  content="解除求助禁言"
                  onClick={() => act('mute_request_updates')}
                />
              ) : (
                <Button
                  icon="volume-mute"
                  color="red"
                  content="禁止求助请求"
                  onClick={() => act('mute_request_updates')}
                />
              )}
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="compress-arrows-alt"
                color="teal"
                tooltip="跟随用户的生物"
                content="跟随"
                onClick={() => act('flw_user')}
              />
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="背景故事">
          {backstory.length === 0 ? (
            <Box color="bad">未设置背景故事。</Box>
          ) : (
            <Box preserveWhitespace>{backstory}</Box>
          )}
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="目标">
          {objectives.length === 0 ? (
            <Box color="bad">未选择目标。</Box>
          ) : (
            objectives.map((objective, index) => (
              <Section
                title={`${index + 1}. ${objective.title}`}
                key={objective.id}
                buttons={
                  <>
                    <Button
                      icon="check"
                      color="good"
                      disabled={
                        objective.approved &&
                        objective.status_text !== 'Not Reviewed'
                      }
                      content="批准目标"
                      onClick={() =>
                        act('approve_objective', {
                          objective_ref: objective.ref,
                        })
                      }
                    />
                    <Button
                      icon="times"
                      color="bad"
                      disabled={
                        !objective.approved &&
                        objective.status_text !== 'Not Reviewed'
                      }
                      content="拒绝目标"
                      onClick={() =>
                        act('deny_objective', {
                          objective_ref: objective.ref,
                        })
                      }
                    />
                  </>
                }
              >
                <LabeledList key={objective.id}>
                  <LabeledList.Item label="描述">
                    {objective.description}
                  </LabeledList.Item>
                  <LabeledList.Item label="理由">
                    {objective.justification}
                  </LabeledList.Item>
                  <LabeledList.Item label="强度">
                    {'(' +
                      objective.intensity +
                      ') ' +
                      chineseDisplay(objective.text_intensity)}
                  </LabeledList.Item>
                  <LabeledList.Item label="状态">
                    {objective.status_text === 'Not Reviewed'
                      ? '目标未审核'
                      : objective.approved
                        ? '目标已批准'
                        : objective.denied_text
                          ? '目标已拒绝，原因：' +
                            objective.denied_text
                          : '目标已拒绝'}
                  </LabeledList.Item>
                </LabeledList>
              </Section>
            ))
          )}
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="装备">
          {selected_equipment.length === 0 ? (
            <Box color="bad">未选择装备。</Box>
          ) : (
            selected_equipment.map((equipment, index) => (
              <Section
                title={equipment.name}
                key={equipment.ref}
                buttons={
                  <>
                    <Button
                      icon="check"
                      color="good"
                      disabled={
                        equipment.approved &&
                        equipment.status !== 'Not Reviewed'
                      }
                      content="批准装备"
                      onClick={() =>
                        act('approve_equipment', {
                          selected_equipment_ref: equipment.ref,
                        })
                      }
                    />
                    <Button
                      icon="times"
                      color="bad"
                      disabled={
                        !equipment.approved &&
                        equipment.status !== 'Not Reviewed'
                      }
                      content="拒绝装备"
                      onClick={() =>
                        act('deny_equipment', {
                          selected_equipment_ref: equipment.ref,
                        })
                      }
                    />
                  </>
                }
              >
                <LabeledList key={equipment.ref}>
                  <LabeledList.Item label="描述">
                    {equipment.description}
                  </LabeledList.Item>
                  <LabeledList.Item label="理由">
                    {equipment.reason}
                  </LabeledList.Item>
                  <LabeledList.Item label="状态">
                    {equipment.denied_reason
                      ? chineseDisplay(equipment.status) +
                        '，原因：' +
                        equipment.denied_reason
                      : chineseDisplay(equipment.status)}
                  </LabeledList.Item>
                  <LabeledList.Item label="数量">
                    {equipment.count}
                  </LabeledList.Item>
                  <LabeledList.Item label="装备备注">
                    {equipment.admin_note}
                  </LabeledList.Item>
                </LabeledList>
              </Section>
            ))
          )}
        </Section>
      </Stack.Item>
    </Stack>
  );
};
