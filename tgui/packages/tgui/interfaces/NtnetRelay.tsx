import {
  AnimatedNumber,
  Box,
  Button,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  enabled: BooleanLike;
  dos_capacity: number;
  dos_overload: number;
  dos_crashed: BooleanLike;
};

const OUTAGE_WARNING = `由于网络缓冲区溢出，
此系统暂时中断服务。在积压的数据处理完毕前，
所有新请求都将被丢弃。如果此错误
频繁出现，可能说明您的网络硬件容量不足。
请联系网络规划部门，
了解如何解决此问题。`;

export const NtnetRelay = (props) => {
  const { act, data } = useBackend<Data>();
  const { enabled, dos_capacity, dos_overload, dos_crashed } = data;

  return (
    <Window title="纳米传讯网络量子中继器" width={400} height={300}>
      <Window.Content>
        <Section
          title="网络缓冲区"
          buttons={
            <Button
              icon="power-off"
              selected={enabled}
              content={enabled ? '已启用' : '已禁用'}
              onClick={() => act('toggle')}
            />
          }
        >
          {!dos_crashed ? (
            <ProgressBar
              value={dos_overload}
              minValue={0}
              maxValue={dos_capacity}
            >
              <AnimatedNumber value={dos_overload} /> GQ
              {' / '}
              {dos_capacity} GQ
            </ProgressBar>
          ) : (
            <Box fontFamily="monospace">
              <Box fontSize="20px">网络缓冲区溢出</Box>
              <Box fontSize="16px">过载恢复模式</Box>
              <Box>{OUTAGE_WARNING}</Box>
              <Box fontSize="20px" color="bad">
                管理员强制操作
              </Box>
              <Box fontSize="16px" color="bad">
                注意——可能导致数据丢失
              </Box>
              <Button
                icon="signal"
                content="清空缓冲区"
                mt={1}
                color="bad"
                onClick={() => act('restart')}
              />
            </Box>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
