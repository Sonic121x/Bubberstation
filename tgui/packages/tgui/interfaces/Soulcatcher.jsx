// THIS IS A SKYRAT UI FILE
import {
  BlockQuote,
  Box,
  Button,
  Collapsible,
  Divider,
  Flex,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Soulcatcher = (props) => {
  const { act, data } = useBackend();
  const {
    require_approval,
    current_rooms = [],
    ghost_joinable,
    current_mob_count,
    max_mobs,
    removable,
    communicate_as_parent,
    theme,
    carrier_targeted,
  } = data;

  return (
    <Window width={520} height={400} theme={theme} resizable>
      <Window.Content scrollable>
        {current_rooms.map((room) => (
          <Section
            key={room.key}
            title={<span style={{ color: room.color }}>{room.name}</span>}
            buttons={
              <>
                <Button
                  icon="palette"
                  tooltip="更改房间颜色"
                  onClick={() =>
                    act('change_room_color', { room_ref: room.reference })
                  }
                >
                  改色
                </Button>
                <Button
                  icon="pen"
                  tooltip="更改房间名称"
                  onClick={() =>
                    act('rename_room', { room_ref: room.reference })
                  }
                >
                  重命名
                </Button>
                <Button
                  icon="trash"
                  tooltip="删除房间"
                  color="red"
                  onClick={() =>
                    act('delete_room', { room_ref: room.reference })
                  }
                >
                  删除
                </Button>
              </>
            }
          >
            <BlockQuote preserveWhitespace> {room.description}</BlockQuote>
            <Box>
              <Button
                icon="scroll"
                tooltip="发送不带姓名的动作描述。"
                onClick={() =>
                  act('send_message', {
                    room_ref: room.reference,
                    emote: true,
                    narration: true,
                  })
                }
              >
                旁白
              </Button>

              <Button
                icon="comment"
                tooltip="在房间内说话。"
                onClick={() =>
                  act('send_message', {
                    room_ref: room.reference,
                    emote: false,
                  })
                }
              >
                说话
              </Button>

              <Button
                icon="face-smile"
                tooltip="在房间内发送动作描述。"
                onClick={() =>
                  act('send_message', {
                    room_ref: room.reference,
                    emote: true,
                  })
                }
              >
                动作
              </Button>

              <Button
                icon="user-gear"
                tooltip="编辑说话和发送动作描述时使用的姓名。"
                onClick={() =>
                  act('modify_name', {
                    room_ref: room.reference,
                  })
                }
              >
                编辑姓名
              </Button>
              <Button
                icon="book"
                tooltip="更改房间描述"
                onClick={() =>
                  act('redescribe_room', { room_ref: room.reference })
                }
              >
                重新布置
              </Button>
              <Button
                icon="image"
                tooltip="更改房间当前叠层"
                onClick={() =>
                  act('change_overlay', { room_ref: room.reference })
                }
              >
                {room.overlay_name ? room.overlay_name : '更改叠层'}
              </Button>
              {room.overlay_name && (
                <>
                  <Button
                    icon="eye"
                    tooltip="预览当前房间叠层"
                    onClick={() =>
                      act('preview_overlay', { room_ref: room.reference })
                    }
                  >
                    预览房间
                  </Button>
                  {room.overlay_recolorable && (
                    <Button
                      icon="eye-dropper"
                      tooltip="更改当前房间叠层的颜色"
                      onClick={() =>
                        act('change_overlay_color', {
                          room_ref: room.reference,
                        })
                      }
                    >
                      修改颜色
                    </Button>
                  )}
                </>
              )}

              <Button
                color={room.joinable ? 'green' : 'red'}
                icon={room.joinable ? 'door-open' : 'door-closed'}
                onClick={() =>
                  act('toggle_joinable_room', { room_ref: room.reference })
                }
              >
                {room.joinable ? '允许进入房间' : '禁止进入房间'}
              </Button>
              <Button
                icon={room.currently_targeted ? 'check' : 'xmark'}
                tooltip="选择灵魂捕手指令发送消息的目标房间。"
                color={room.currently_targeted ? 'green' : 'red'}
                onClick={() =>
                  act('change_targeted_room', { room_ref: room.reference })
                }
              >
                {room.currently_targeted ? '已设为目标' : '未设为目标'}
              </Button>
            </Box>
            {room.souls && (
              <>
                <br />
                <Box textAlign="center" fontSize="15px" opacity={0.8}>
                  <b>当前灵魂</b>
                </Box>
                <Divider />
                <Flex direction="column">
                  {room.souls.map((mob) => (
                    <Flex.Item key={mob.key}>
                      <Collapsible
                        title={mob.name}
                        buttons={
                          <>
                            {!mob.scan_needed && (
                              <>
                                <Button
                                  color="green"
                                  icon="pen"
                                  tooltip="更改该角色的姓名。"
                                  onClick={() =>
                                    act('change_name', {
                                      target_mob: mob.reference,
                                      room_ref: room.reference,
                                    })
                                  }
                                />
                                <Button
                                  color="red"
                                  icon="arrow-rotate-left"
                                  tooltip="重置该角色的姓名。"
                                  onClick={() =>
                                    act('reset_name', {
                                      target_mob: mob.reference,
                                      room_ref: room.reference,
                                    })
                                  }
                                />
                              </>
                            )}
                            <Button
                              icon="paper-plane"
                              tooltip="将角色转移到另一个房间"
                              onClick={() =>
                                act('transfer_mob', {
                                  room_ref: room.reference,
                                  target_mob: mob.reference,
                                })
                              }
                            />
                          </>
                        }
                      >
                        <Box textAlign="center" fontSize="13px" opacity={0.8}>
                          <b>外观描述</b>
                        </Box>
                        <Divider />
                        <BlockQuote preserveWhitespace>
                          {mob.description}
                        </BlockQuote>
                        <br />
                        <Box textAlign="center" fontSize="13px" opacity={0.8}>
                          <b>戏外备注</b>
                        </Box>
                        <Divider />
                        <BlockQuote preserveWhitespace>
                          {mob.ooc_notes}
                        </BlockQuote>
                        <br />
                        <LabeledList>
                          <LabeledList.Item label="外界听觉">
                            <Button
                              color={mob.outside_hearing ? 'green' : 'red'}
                              fluid
                              tooltip="该角色能否听到外界的声音？"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'external_hearing',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.outside_hearing ? '已启用' : '已禁用'}
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="外界视觉">
                            <Button
                              color={mob.outside_sight ? 'green' : 'red'}
                              fluid
                              tooltip="该角色能否看见外界？"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'external_sight',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.outside_sight ? '已启用' : '已禁用'}
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="内部听觉">
                            <Button
                              color={mob.internal_hearing ? 'green' : 'red'}
                              fluid
                              tooltip="该角色能否听到房间内的声音？"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'hearing',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.internal_hearing ? '已启用' : '已禁用'}
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="内部视觉">
                            <Button
                              color={mob.internal_sight ? 'green' : 'red'}
                              fluid
                              tooltip="该角色能否看见房间内部？"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'sight',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.internal_sight ? '已启用' : '已禁用'}
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="说话">
                            <Button
                              color={mob.able_to_speak ? 'green' : 'red'}
                              fluid
                              tooltip="该角色能否说话？"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'able_to_speak',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.able_to_speak ? '已启用' : '已禁用'}
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="动作">
                            <Button
                              color={mob.able_to_emote ? 'green' : 'red'}
                              fluid
                              tooltip="该角色能否发送动作描述？"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'able_to_emote',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.able_to_emote ? '已启用' : '已禁用'}
                            </Button>
                          </LabeledList.Item>
                          {communicate_as_parent && (
                            <>
                              <LabeledList.Item label="对外说话">
                                <Button
                                  color={
                                    mob.able_to_speak_as_container
                                      ? 'green'
                                      : 'red'
                                  }
                                  fluid
                                  tooltip="该角色能否以容器的身份说话？"
                                  onClick={() =>
                                    act('toggle_soul_sense', {
                                      target_mob: mob.reference,
                                      sense_to_change:
                                        'able_to_speak_as_container',
                                      room_ref: room.reference,
                                    })
                                  }
                                >
                                  {mob.able_to_speak_as_container
                                    ? '已启用'
                                    : '已禁用'}
                                </Button>
                              </LabeledList.Item>
                              <LabeledList.Item label="对外动作">
                                <Button
                                  color={
                                    mob.able_to_emote_as_container
                                      ? 'green'
                                      : 'red'
                                  }
                                  fluid
                                  tooltip="该角色能否以容器的身份发送动作描述？"
                                  onClick={() =>
                                    act('toggle_soul_sense', {
                                      target_mob: mob.reference,
                                      sense_to_change:
                                        'able_to_emote_as_container',
                                      room_ref: room.reference,
                                    })
                                  }
                                >
                                  {mob.able_to_emote_as_container
                                    ? '已启用'
                                    : '已禁用'}
                                </Button>
                              </LabeledList.Item>
                            </>
                          )}
                          <LabeledList.Item label="重命名">
                            <Button
                              color={mob.able_to_rename ? 'green' : 'red'}
                              fluid
                              tooltip="该角色能否更改自己的姓名？"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'able_to_rename',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.able_to_rename ? '已启用' : '已禁用'}
                            </Button>
                          </LabeledList.Item>
                        </LabeledList>
                        <br />
                        <Button
                          fluid
                          icon="eject"
                          color="red"
                          onClick={() =>
                            act('remove_mob', {
                              target_mob: mob.reference,
                              room_ref: room.reference,
                            })
                          }
                        >
                          移除灵魂
                        </Button>
                      </Collapsible>
                    </Flex.Item>
                  ))}
                </Flex>
              </>
            )}
          </Section>
        ))}
        {max_mobs && (
          <Section>
            <ProgressBar
              textAlign="left"
              minValue={0}
              color="blue"
              maxValue={max_mobs}
              value={max_mobs - current_mob_count}
            >
              剩余角色容量：{max_mobs - current_mob_count}
            </ProgressBar>
          </Section>
        )}
        <Button
          fluid
          color="green"
          icon="plus"
          onClick={() => act('create_room', {})}
        >
          创建新房间
        </Button>
        <Button
          fluid
          color={ghost_joinable ? 'green' : 'red'}
          icon={ghost_joinable ? 'door-open' : 'door-closed'}
          onClick={() => act('toggle_joinable', {})}
        >
          {ghost_joinable ? '允许' : '禁止'}幽灵进入
        </Button>
        <Button
          fluid
          color={require_approval ? 'green' : 'red'}
          icon={require_approval ? 'lock' : 'lock-open'}
          onClick={() => act('toggle_approval', {})}
        >
          进入{require_approval ? '需要' : '无需'}批准
        </Button>
        <Button
          fluid
          color={carrier_targeted ? 'green' : 'red'}
          icon={carrier_targeted ? 'check' : 'xmark'}
          onClick={() => act('change_targeted_carrier', {})}
        >
          指令消息{require_approval ? '会' : '不会'}发送至此载体
        </Button>
        {removable && (
          <Button
            require_approval
            fluid
            color="red"
            icon="eject"
            onClick={() => act('delete_self', {})}
          >
            从所属物体上移除灵魂捕手
          </Button>
        )}
      </Window.Content>
    </Window>
  );
};
