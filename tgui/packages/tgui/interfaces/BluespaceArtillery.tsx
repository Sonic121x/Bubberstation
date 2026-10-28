import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  connected: BooleanLike;
  notice: string;
  unlocked: BooleanLike;
  visualizing: BooleanLike;
  target: string;
};

export const BluespaceArtillery = (props) => {
  const { act, data } = useBackend<Data>();
  const { connected, notice, unlocked, visualizing, target } = data;

  return (
    <Window width={400} height={220}>
      <Window.Content>
        {!!notice && <NoticeBox>{notice}</NoticeBox>}
        {connected ? (
          <>
            <Section
              title="目标"
              buttons={
                <Button
                  icon="crosshairs"
                  disabled={!unlocked}
                  onClick={() => act('recalibrate')}
                />
              }
            >
              <Box color={target ? 'average' : 'bad'} fontSize="25px">
                {target || '未设置目标'}
              </Box>
            </Section>
            <Section>
              {unlocked ? (
                <Box style={{ margin: 'auto' }}>
                  <Button
                    fluid
                    content="开火"
                    color="bad"
                    disabled={!target}
                    fontSize="30px"
                    textAlign="center"
                    lineHeight="46px"
                    onClick={() => act('fire')}
                  />
                </Box>
              ) : (
                <>
                  <Box color="bad" fontSize="18px">
                    蓝空间火炮目前已锁定。
                  </Box>
                  <Box mt={1}>
                    正在等待至少两名空间站主管
                    通过钥匙卡读取器授权。
                  </Box>
                </>
              )}
            </Section>
          </>
        ) : (
          <Section>
            <LabeledList>
              <LabeledList.Item label="维护">
                {(visualizing) ? (
                  <>
                    <Button color="good" onClick={() => act('build')}>
                      确认位置
                    </Button>
                    <Button color="bad" onClick={() => act('unvisualize')}>
                      取消
                    </Button>
                  </>
                ) : (
                  <Button icon="wrench" onClick={() => act('visualize')}>
                    开始部署
                  </Button>
                )}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
