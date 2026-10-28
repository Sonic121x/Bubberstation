import { useState } from 'react';
import { Box, Button, Flex, Modal, Section } from 'tgui-core/components';
import { communicationsAlertDisplay } from '../../localization/communicationsDisplay';

import { useBackend } from '../../backend';
import { AlertButton } from './AlertButton';
import { MessageModal } from './MessageModal';
import { type CommsConsoleData, ShuttleState } from './types';

export function PageMain(props) {
  const { act, data } = useBackend<CommsConsoleData>();
  const {
    alertLevel,
    callShuttleReasonMinLength,
    canBuyShuttles,
    canMakeAnnouncement,
    canMessageAssociates,
    canRecallShuttles,
    canRequestNuke,
    canSendToSectors,
    canSetAlertLevel,
    canToggleEmergencyAccess,
    canToggleEngineeringOverride, // BUBBER EDIT - Engineering override
    emagged,
    syndicate,
    emergencyAccess,
    engineeringOverride, // BUBBER EDIT - Engineering override
    importantActionReady,
    sectors,
    shuttleCalled,
    shuttleCalledPreviously,
    shuttleCanEvacOrFailReason,
    shuttleLastCalled,
    shuttleRecallable,
  } = data;

  const [callingShuttle, setCallingShuttle] = useState(false);
  const [messagingAssociates, setMessagingAssociates] = useState(false);
  const [messagingSector, setMessagingSector] = useState('');
  const [requestingNukeCodes, setRequestingNukeCodes] = useState(false);

  const [newAlertLevel, setNewAlertLevel] = useState('');
  const showAlertLevelConfirm = newAlertLevel && newAlertLevel !== alertLevel;

  return (
    <Box>
      {!syndicate && (
        <Section title="紧急穿梭机">
          {shuttleCalled ? (
            <Button.Confirm
              icon="space-shuttle"
              color="bad"
              disabled={!canRecallShuttles || !shuttleRecallable}
              tooltip={
                (canRecallShuttles &&
                  !shuttleRecallable &&
                  '现在已无法召回紧急穿梭机。') ||
                '你无权召回紧急穿梭机。'
              }
              tooltipPosition="top"
              onClick={() => act('recallShuttle')}
            >
              召回紧急穿梭机
            </Button.Confirm>
          ) : (
            <Button
              icon="space-shuttle"
              disabled={shuttleCanEvacOrFailReason !== 1}
              tooltip={
                shuttleCanEvacOrFailReason !== 1
                  ? shuttleCanEvacOrFailReason
                  : undefined
              }
              tooltipPosition="top"
              onClick={() => setCallingShuttle(true)}
            >
              呼叫紧急穿梭机
            </Button>
          )}
          {!!shuttleCalledPreviously &&
            (shuttleLastCalled ? (
              <Box>
                最近一次穿梭机呼叫／召回信号来自：{' '}
                <b>{shuttleLastCalled}</b>
              </Box>
            ) : (
              <Box>无法追踪最近一次穿梭机呼叫／召回信号。</Box>
            ))}
        </Section>
      )}

      {!!canSetAlertLevel && (
        <Section title="警戒等级">
          <Flex justify="space-between">
            <Flex.Item>
              <Box>
                当前处于<b>{communicationsAlertDisplay(alertLevel)}</b>警戒
              </Box>
            </Flex.Item>

            <Flex.Item>
              <AlertButton
                alertLevel="green"
                onClick={() => setNewAlertLevel('green')}
              />

              <AlertButton
                alertLevel="blue"
                onClick={() => setNewAlertLevel('blue')}
              />

              {/* BUBBER EDIT ADDITION BEGIN - ALERTS */}
              <AlertButton
                alertLevel="violet"
                onClick={() => setNewAlertLevel('violet')}
              />

              <AlertButton
                alertLevel="orange"
                onClick={() => setNewAlertLevel('orange')}
              />

              <AlertButton
                alertLevel="amber"
                onClick={() => setNewAlertLevel('amber')}
              />
              {/* BUBBER EDIT ADDITION END - ALERTS */}
            </Flex.Item>
          </Flex>
        </Section>
      )}

      <Section title="功能">
        <Flex direction="column">
          {!!canMakeAnnouncement && (
            <Button
              icon="bullhorn"
              onClick={() => act('makePriorityAnnouncement')}
            >
              发布优先公告
            </Button>
          )}

          {!!canToggleEmergencyAccess && (
            <Button.Confirm
              icon="id-card-o"
              confirmIcon="id-card-o"
              color={emergencyAccess ? 'bad' : undefined}
              onClick={() => act('toggleEmergencyAccess')}
            >
              {emergencyAccess ? '禁用' : '启用'}维护区紧急
              通行权限
            </Button.Confirm>
          )}

          {/* BUBBER EDIT ADDITION START - Engineering Override */}
          {!!canToggleEngineeringOverride && (
            <Button.Confirm
              icon="wrench"
              color={engineeringOverride ? 'bad' : undefined}
              onClick={() => act('toggleEngOverride')}
            >
              {engineeringOverride ? '禁用' : '启用'}工程越权
              通行权限
            </Button.Confirm>
          )}
          {/* BUBBER EDIT ADDITION END - Engineering Override */}

          {!syndicate && (
            <Button
              icon="desktop"
              onClick={() =>
                act('setState', { state: ShuttleState.CHANGING_STATUS })
              }
            >
              设置状态显示屏
            </Button>
          )}

          <Button
            icon="envelope-o"
            onClick={() => act('setState', { state: ShuttleState.MESSAGES })}
          >
            消息列表
          </Button>

          {canBuyShuttles !== 0 && (
            <Button
              icon="shopping-cart"
              disabled={canBuyShuttles !== 1}
              // canBuyShuttles is a string detailing the fail reason
              // if one can be given
              tooltip={canBuyShuttles !== 1 ? canBuyShuttles : undefined}
              tooltipPosition="top"
              onClick={() =>
                act('setState', { state: ShuttleState.BUYING_SHUTTLE })
              }
            >
              购买穿梭机
            </Button>
          )}

          {!!canMessageAssociates && (
            <Button
              icon="comment-o"
              disabled={!importantActionReady}
              onClick={() => setMessagingAssociates(true)}
            >
              发送消息给{emagged ? '［未知］' : '中央指挥部'}
            </Button>
          )}

          {!!canRequestNuke && (
            <Button
              icon="radiation"
              disabled={!importantActionReady}
              onClick={() => setRequestingNukeCodes(true)}
            >
              请求核武器授权码
            </Button>
          )}

          {!!emagged && !syndicate && (
            <Button icon="undo" onClick={() => act('restoreBackupRoutingData')}>
              恢复备份路由数据
            </Button>
          )}

          {/* BUBBER EDIT ADDITION BEGIN - Additional Calls */}
          {!!canMakeAnnouncement && (
            <Button icon="bullhorn" onClick={() => act('callThePolice')}>
              呼叫地球政府 911：法警支援
            </Button>
          )}
          {!!canMakeAnnouncement && (
            <Button icon="bullhorn" onClick={() => act('callTheCatmos')}>
              呼叫地球政府 811：大气支援
            </Button>
          )}
          {!!canMakeAnnouncement && (
            <Button icon="bullhorn" onClick={() => act('callTheParameds')}>
              呼叫地球政府 911：医疗支援
            </Button>
          )}
          {!!emagged && (
            <Button icon="bullhorn" onClick={() => act('callThePizza')}>
              向多吉诺披萨店下单
            </Button>
          )}
          {/* BUBBER EDIT ADDITION END - Additional Calls */}
        </Flex>
      </Section>

      {!!canMessageAssociates && messagingAssociates && (
        <MessageModal
          label={`通过量子纠缠发送给${
            emagged ? '［异常路由坐标］' : '中央指挥部'
          }的消息`}
          notice="请注意，此过程成本高昂，滥用将导致……终结。发送消息不保证得到回应。"
          icon="bullhorn"
          buttonText="发送"
          onBack={() => setMessagingAssociates(false)}
          onSubmit={(message) => {
            setMessagingAssociates(false);
            act('messageAssociates', {
              message,
            });
          }}
        />
      )}

      {!!canRequestNuke && requestingNukeCodes && (
        <MessageModal
          label="申请核自毁密码的理由"
          notice="任何情况下都不允许滥用核武器申请系统。发送消息不保证得到回应。"
          icon="bomb"
          buttonText="申请密码"
          onBack={() => setRequestingNukeCodes(false)}
          onSubmit={(reason) => {
            setRequestingNukeCodes(false);
            act('requestNukeCodes', {
              reason,
            });
          }}
        />
      )}

      {!!callingShuttle && (
        <MessageModal
          label="紧急情况说明"
          icon="space-shuttle"
          buttonText="呼叫穿梭机"
          minLength={callShuttleReasonMinLength}
          onBack={() => setCallingShuttle(false)}
          onSubmit={(reason) => {
            setCallingShuttle(false);
            act('callShuttle', {
              reason,
            });
          }}
        />
      )}

      {!!canSetAlertLevel && showAlertLevelConfirm && (
        <Modal>
          <Flex direction="column" textAlign="center" width="300px">
            <Flex.Item fontSize="16px" mb={2}>
              刷 ID 卡确认更改
            </Flex.Item>

            <Flex.Item mr={2} mb={1}>
              <Button
                icon="id-card-o"
                color="good"
                fontSize="16px"
                onClick={() => {
                  act('changeSecurityLevel', {
                    newSecurityLevel: newAlertLevel,
                  });
                  setNewAlertLevel('');
                }}
              >
                刷 ID 卡
              </Button>

              <Button
                icon="times"
                color="bad"
                fontSize="16px"
                onClick={() => setNewAlertLevel('')}
              >
                取消
              </Button>
            </Flex.Item>
          </Flex>
        </Modal>
      )}

      {!!canSendToSectors && sectors.length > 0 && (
        <Section title="友方星区">
          <Flex direction="column">
            {sectors.map((sectorName) => (
              <Flex.Item key={sectorName}>
                <Button
                  disabled={!importantActionReady}
                  onClick={() => setMessagingSector(sectorName)}
                >
                  向 {sectorName} 星区的空间站发送消息
                </Button>
              </Flex.Item>
            ))}

            {sectors.length > 2 && (
              <Flex.Item>
                <Button
                  disabled={!importantActionReady}
                  onClick={() => setMessagingSector('all')}
                >
                  向所有友方空间站发送消息
                </Button>
              </Flex.Item>
            )}
          </Flex>
        </Section>
      )}

      {!!canSendToSectors && sectors.length > 0 && messagingSector && (
        <MessageModal
          label="发送给友方空间站的消息"
          notice="请注意，此过程成本高昂，滥用将导致……终结。"
          icon="bullhorn"
          buttonText="发送"
          onBack={() => setMessagingSector('')}
          onSubmit={(message) => {
            act('sendToOtherSector', {
              destination: messagingSector,
              message,
            });

            setMessagingSector('');
          }}
        />
      )}
    </Box>
  );
}
