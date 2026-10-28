import { Box, Button, LabeledList, Section } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

type Data = {
  current_user: string;
  card_owner: string;
  paperamt: number;
  barcode_split: number;
  has_id_slot: BooleanLike;
};

export const NtosShipping = (props) => {
  return (
    <NtosWindow width={450} height={350}>
      <NtosWindow.Content scrollable>
        <ShippingHub />
        <ShippingOptions />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

/** Returns information about the current user, available paper, etc */
const ShippingHub = (props) => {
  const { act, data } = useBackend<Data>();
  const { current_user, card_owner, paperamt, barcode_split } = data;

  return (
    <Section
      title="纳米传讯操作系统货运中心"
      buttons={
        <Button
          icon="eject"
          content="弹出身份卡"
          onClick={() => act('ejectid')}
        />
      }
    >
      <LabeledList>
        <LabeledList.Item label="当前用户">
          {current_user || '无'}
        </LabeledList.Item>
        <LabeledList.Item label="已插入身份卡">
          {card_owner || '无'}
        </LabeledList.Item>
        <LabeledList.Item label="可用纸张">{paperamt}</LabeledList.Item>
        <LabeledList.Item label="销售分成">
          {barcode_split}%
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

/** Returns shipping options */
const ShippingOptions = (props) => {
  const { act, data } = useBackend<Data>();
  const { has_id_slot, current_user } = data;

  return (
    <Section title="发货选项">
      <Box>
        <Button
          icon="id-card"
          tooltip="将当前身份卡的持有人设为当前用户。"
          tooltipPosition="right"
          disabled={!has_id_slot}
          onClick={() => act('selectid')}
          content="使用当前身份卡"
        />
      </Box>
      <Box>
        <Button
          icon="print"
          tooltip="打印条形码，贴在包装好的包裹上。"
          tooltipPosition="right"
          disabled={!current_user}
          onClick={() => act('print')}
          content="打印条形码"
        />
      </Box>
      <Box>
        <Button
          icon="tags"
          tooltip="设置您希望从包裹销售中获得的分成比例。"
          tooltipPosition="right"
          onClick={() => act('setsplit')}
          content="设置分成比例"
        />
      </Box>
      <Box>
        <Button
          icon="sync-alt"
          content="重置身份"
          onClick={() => act('resetid')}
        />
      </Box>
    </Section>
  );
};
