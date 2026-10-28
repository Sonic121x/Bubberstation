import { NoticeBox } from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import { MODsuitContent } from './MODsuit';

export const NtosMODsuit = (props) => {
  const { data } = useBackend();
  const { ui_theme } = data;
  return (
    <NtosWindow theme={ui_theme}>
      <NtosWindow.Content scrollable>
        <NtosMODsuitContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const NtosMODsuitContent = (props) => {
  const { data } = useBackend();
  const { has_suit } = data;
  if (!has_suit) {
    return (
      <NoticeBox mt={1} mb={0} danger fontSize="12px">
        未连接 MOD 套装。请用运行此应用的设备轻点套装，
        以完成同步。
      </NoticeBox>
    );
  } else {
    return <MODsuitContent />;
  }
};
