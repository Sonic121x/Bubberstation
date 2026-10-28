import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Slider,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type IVDripData = {
  hasInternalStorage: BooleanLike;
  hasContainer: BooleanLike;
  canRemoveContainer: BooleanLike;
  mode: BooleanLike;
  canDraw: BooleanLike;
  injectFromPlumbing: BooleanLike;
  canAdjustTransfer: BooleanLike;
  transferRate: number;
  transferStep: number;
  minTransferRate: number;
  maxTransferRate: number;
  hasObjectAttached: BooleanLike;
  objectName: string;
  containerReagentColor: string;
  containerCurrentVolume: number;
  containerMaxVolume: number;
};

enum MODE {
  drawing,
  injecting,
}

export const IVDrip = (props) => {
  const { act, data } = useBackend<IVDripData>();
  const {
    hasContainer,
    canRemoveContainer,
    mode,
    canDraw,
    hasInternalStorage,
    transferRate,
    transferStep,
    maxTransferRate,
    minTransferRate,
    hasObjectAttached,
    objectName,
    containerCurrentVolume,
    containerMaxVolume,
    containerReagentColor,
  } = data;
  return (
    <Window width={400} height={220}>
      <Window.Content>
        <Section fill>
          <LabeledList>
            <LabeledList.Item
              label="流速"
              buttons={
                <Box>
                  <Button
                    width={4}
                    lineHeight={2}
                    align="center"
                    icon="angles-left"
                    onClick={() =>
                      act('changeRate', {
                        rate: minTransferRate,
                      })
                    }
                  />
                  <Button
                    width={4}
                    lineHeight={2}
                    align="center"
                    icon="angles-right"
                    onClick={() =>
                      act('changeRate', {
                        rate: maxTransferRate,
                      })
                    }
                  />
                </Box>
              }
            >
              <Slider
                step={transferStep}
                my={1}
                value={transferRate}
                minValue={minTransferRate}
                maxValue={maxTransferRate}
                unit="单位/秒"
                onChange={(e, value) =>
                  act('changeRate', {
                    rate: value,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item
              label="流向"
              color={!mode ? 'bad' : ''}
              buttons={
                <Button
                  my={1}
                  width={8}
                  lineHeight={2}
                  align="center"
                  disabled={!canDraw}
                  color={!mode && 'bad'}
                  content={mode ? '输液中' : '抽取中'}
                  icon={mode ? 'syringe' : 'droplet'}
                  onClick={() => act('changeMode')}
                />
              }
            >
              {mode
                ? hasInternalStorage
                  ? '从管网输入试剂'
                  : '从容器输入试剂'
                : '将血液抽入容器'}
            </LabeledList.Item>
            {hasContainer || hasInternalStorage ? (
              <LabeledList.Item
                label="容器"
                buttons={
                  !hasInternalStorage &&
                  !!canRemoveContainer && (
                    <Button
                      my={1}
                      width={8}
                      lineHeight={2}
                      align="center"
                      icon="eject"
                      content="弹出"
                      onClick={() => act('eject')}
                    />
                  )
                }
              >
                <ProgressBar
                  value={containerCurrentVolume}
                  minValue={0}
                  maxValue={containerMaxVolume}
                  color={containerReagentColor}
                >
                  <span
                    style={{
                      textShadow: '1px 1px 0 black',
                    }}
                  >
                    {`${containerCurrentVolume} / ${containerMaxVolume} 单位`}
                  </span>
                </ProgressBar>
              </LabeledList.Item>
            ) : (
              <LabeledList.Item label="容器">
                <Tooltip content="手持容器点击输液架即可连接。">
                  <NoticeBox my={0.7}>未连接容器。</NoticeBox>
                </Tooltip>
              </LabeledList.Item>
            )}
            {hasObjectAttached ? (
              <LabeledList.Item
                label="连接对象"
                buttons={
                  <Button
                    disabled={!hasObjectAttached}
                    my={1}
                    width={8}
                    lineHeight={2}
                    align="center"
                    icon="ban"
                    content="断开"
                    onClick={() => act('detach')}
                  />
                }
              >
                <Box maxHeight={'45px'} overflow={'hidden'}>
                  {objectName}
                </Box>
              </LabeledList.Item>
            ) : (
              <LabeledList.Item label="连接对象">
                <Tooltip content="从输液架拖拽到目标对象上即可连接。">
                  <NoticeBox my={0.7}>未连接任何对象。</NoticeBox>
                </Tooltip>
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
