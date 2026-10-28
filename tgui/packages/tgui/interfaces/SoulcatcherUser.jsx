// THIS IS A SKYRAT UI FILE
import {
  BlockQuote,
  Box,
  Button,
  Collapsible,
  Divider,
  Flex,
  LabeledList,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const SoulcatcherUser = (props) => {
  const { act, data } = useBackend();
  const {
    current_room,
    user_data,
    communicate_as_parent,
    targeted,
    souls = [],
  } = data;

  return (
    <Window width={520} height={400} resizable>
      <Window.Content scrollable>
        <Section
          key={current_room.key}
          title={
            <span style={{ color: current_room.color }}>
              {current_room.name}
            </span>
          }
        >
          <BlockQuote preserveWhitespace>
            {' '}
            {current_room.description}
          </BlockQuote>
          <br />
          <Box textAlign="center" fontSize="15px" opacity={0.8}>
            <b>{user_data.name} </b>
            <Button
              color={targeted ? 'green' : 'red'}
              icon={targeted ? 'check' : 'xmark'}
              tooltip="切换载体说话和载体动作指令是否发送到此灵魂捕手。"
              onClick={() => act('toggle_target', {})}
            />
            {!user_data.scan_needed && user_data.able_to_rename && (
              <>
                <Button
                  color="green"
                  icon="pen"
                  tooltip="更改你的姓名。"
                  onClick={() => act('change_name', {})}
                />
                <Button
                  color="red"
                  icon="arrow-rotate-left"
                  tooltip="重置你的姓名。"
                  onClick={() => act('reset_name', {})}
                />
              </>
            )}
            {communicate_as_parent && (
              <Button
                color={user_data.communicating_externally ? 'green' : 'red'}
                icon={
                  user_data.communicating_externally ? 'bullhorn' : 'microphone'
                }
                tooltip="切换是否作为灵魂捕手的一部分对外发送消息。"
                onClick={() => act('toggle_external_communication', {})}
              />
            )}
          </Box>
          <Divider />
          <Collapsible title="外观描述">
            <BlockQuote preserveWhitespace>{user_data.description}</BlockQuote>
          </Collapsible>
          <Collapsible title="戏外备注">
            <BlockQuote preserveWhitespace>{user_data.ooc_notes}</BlockQuote>
          </Collapsible>
          <Collapsible title="灵魂信息">
            <LabeledList textAlign>
              <LabeledList.Item label="看见外界">
                {user_data.outside_sight ? '已启用' : '已禁用'}
              </LabeledList.Item>
              <LabeledList.Item label="听到外界">
                {user_data.outside_hearing ? '已启用' : '已禁用'}
              </LabeledList.Item>
              <LabeledList.Item label="看见内部">
                {user_data.internal_sight ? '已启用' : '已禁用'}
              </LabeledList.Item>
              <LabeledList.Item label="听到内部">
                {user_data.internal_hearing ? '已启用' : '已禁用'}
              </LabeledList.Item>
              <LabeledList.Item label="说话能力">
                {user_data.able_to_speak ? '已启用' : '已禁用'}
              </LabeledList.Item>
              <LabeledList.Item label="动作描述能力">
                {user_data.able_to_emote ? '已启用' : '已禁用'}
              </LabeledList.Item>
              {communicate_as_parent && (
                <>
                  <LabeledList.Item label="以容器身份说话">
                    {user_data.able_to_speak_as_container
                      ? '已启用'
                      : '已禁用'}
                  </LabeledList.Item>
                  <LabeledList.Item label="以容器身份描述动作">
                    {user_data.able_to_emote_as_container
                      ? '已启用'
                      : '已禁用'}
                  </LabeledList.Item>
                </>
              )}
              <LabeledList.Item label="更改姓名">
                {user_data.able_to_rename && !user_data.scan_needed
                  ? '已启用'
                  : '已禁用'}
              </LabeledList.Item>
              <LabeledList.Item label="需要身体扫描">
                {user_data.scan_needed ? '是' : '否'}
              </LabeledList.Item>
            </LabeledList>
          </Collapsible>

          {souls && user_data.internal_sight && (
            <>
              <br />
              <Box textAlign="center" fontSize="15px" opacity={0.8}>
                <b>灵魂</b>
              </Box>
              <Divider />
              <Flex direction="column">
                {souls.map((soul) => (
                  <Flex.Item key={soul.key}>
                    <Collapsible title={soul.name}>
                      <Box textAlign="center" fontSize="13px" opacity={0.8}>
                        <b>外观描述</b>
                      </Box>
                      <Divider />
                      <BlockQuote preserveWhitespace>
                        {soul.description}
                      </BlockQuote>
                      <br />
                      <Box textAlign="center" fontSize="13px" opacity={0.8}>
                        <b>戏外备注</b>
                      </Box>
                      <Divider />
                      <BlockQuote preserveWhitespace>
                        {soul.ooc_notes}
                      </BlockQuote>
                    </Collapsible>
                  </Flex.Item>
                ))}
              </Flex>
            </>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
