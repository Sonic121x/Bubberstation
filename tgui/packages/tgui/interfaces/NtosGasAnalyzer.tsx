import { Button } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import { GasAnalyzerContent, type GasAnalyzerData } from './GasAnalyzer';

type NtosGasAnalyzerData = GasAnalyzerData & {
  atmozphereMode: 'click' | 'env';
  clickAtmozphereCompatible: BooleanLike;
};

export const NtosGasAnalyzer = (props) => {
  const { act, data } = useBackend<NtosGasAnalyzerData>();
  const { atmozphereMode, clickAtmozphereCompatible } = data;
  return (
    <NtosWindow width={500} height={450}>
      <NtosWindow.Content scrollable>
        {!!clickAtmozphereCompatible && (
          <Button
            icon={'sync'}
            onClick={() => act('scantoggle')}
            fluid
            textAlign="center"
            tooltip={
              atmozphereMode === 'click'
                ? '手持平板电脑右键点击物体以扫描。右键点击平板电脑可扫描当前位置。'
                : '应用会自动更新混合气体读数。'
            }
            tooltipPosition="bottom"
          >
            {atmozphereMode === 'click'
              ? '扫描点击的物体。点击切换。'
              : '扫描当前位置。点击切换。'}
          </Button>
        )}
        <GasAnalyzerContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};
