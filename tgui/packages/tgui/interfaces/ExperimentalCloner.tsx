import {
  Button,
  Divider,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { recordDisplay, type BatchDisplayData } from '../localization/batchThreeDisplay';
type Data = BatchDisplayData & {
  linked_scanner: BooleanLike;
  linked_pod: BooleanLike;
  is_scanning: BooleanLike;
  is_cloning: BooleanLike;
  record_name?: string;
  record_species?: string;
  scanner_occupant?: string;
  scanner_species?: string;
  cloning_name?: string;
  cloning_species?: string;
  cloning_progress?: number;
};

export const ExperimentalCloner = (props: any) => {
  const { act, data } = useBackend<Data>();
  const {
    linked_scanner,
    linked_pod,
    record_name,
    record_species,
    scanner_occupant,
    scanner_species,
    is_scanning,
    is_cloning,
    cloning_name,
    cloning_species,
    cloning_progress,
  } = data;

  return (
    <Window title="实验型克隆机" width={500} height={300} theme="ntOS95">
      <Window.Content>
        <Section
          title="已储存的受试者"
          buttons={
            <Button
              icon="x"
              color="bad"
              tooltip={`
            清除当前储存的克隆记录。`}
              onClick={() => act('clear_record')}
              disabled={!record_name}
              tooltipPosition="bottom-start"
            >
              清除
            </Button>
          }
        >
          {record_name ? (
            <Stack.Item>
              {record_name} ({recordDisplay(record_species ?? 'Unknown', data)})
            </Stack.Item>
          ) : (
            '记录中未储存DNA。'
          )}
        </Section>
        <Stack fill>
          <Stack.Item width="50%" mb={13}>
            <Section fill title="扫描仪">
              {linked_scanner ? (
                <Stack.Item textAlign="center">
                  <Stack vertical>
                    <Stack.Item bold>当前乘员：</Stack.Item>
                    <Stack.Item>{scanner_occupant ?? '无'}</Stack.Item>
                    {scanner_occupant && (
                      <Stack vertical>
                        <Stack.Item bold>乘员种族：</Stack.Item>
                        <Stack.Item>{recordDisplay(scanner_species ?? 'Unknown', data)}</Stack.Item>
                        <Divider />
                        <Button
                          color="good"
                          onClick={() => act('start_scan')}
                          content={is_scanning ? '扫描中……' : '立即扫描'}
                          disabled={is_scanning}
                        />
                      </Stack>
                    )}
                  </Stack>
                </Stack.Item>
              ) : (
                <Stack.Item textAlign="center">
                  未连接扫描仪。
                </Stack.Item>
              )}
            </Section>
          </Stack.Item>
          <Stack.Item width="50%" mb={13}>
            <Section fill title="克隆舱">
              {linked_pod ? (
                <Stack.Item textAlign="center">
                  {is_cloning ? (
                    <Stack vertical>
                      <Stack.Item bold>正在克隆：</Stack.Item>
                      <Stack.Item>
                        {cloning_name} ({recordDisplay(cloning_species ?? 'Unknown', data)})
                      </Stack.Item>
                      <Stack.Item>
                        <ProgressBar
                          value={cloning_progress ?? 0}
                          minValue={0}
                          maxValue={100}
                          color="good"
                        />
                      </Stack.Item>
                      {cloning_progress === 100 && (
                        <Stack.Item>正在启动神经系统……</Stack.Item>
                      )}
                    </Stack>
                  ) : (
                    <Stack vertical>
                      <Button
                        color="good"
                        onClick={() => act('start_clone')}
                        content={is_cloning ? '克隆中……' : '开始克隆'}
                        disabled={is_cloning || !record_name}
                        tooltip={!record_name && '记录中无DNA。'}
                      />
                    </Stack>
                  )}
                </Stack.Item>
              ) : (
                <Stack.Item textAlign="center">未连接克隆舱。</Stack.Item>
              )}
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
