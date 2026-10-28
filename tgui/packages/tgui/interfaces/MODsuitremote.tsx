// BUBBER UI FILE

import { useState } from 'react';
import {
  Box,
  Icon,
  Input,
  LabeledList,
  Modal,
  Section,
  Stack,
} from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';
import { MODsuitContent } from './MODsuit';
import { Protean } from './ProteanUI';

type Data = {
  ui_theme: string;
  linked_suit: boolean;
  wearer: boolean;
  erp_pref_check: boolean;
  protean: boolean;
};
export const MODsuitremote = (props) => {
  const { data } = useBackend<Data>();
  const { ui_theme } = data;
  return (
    <Window
      theme={ui_theme}
      width={550}
      height={350}
      title="MOD 远程控制界面"
    >
      <Window.Content scrollable>
        <RemoteMODsuitContent />
      </Window.Content>
    </Window>
  );
};

const RemoteSection = () => {
  const { act, data } = useBackend<Data>();
  const { erp_pref_check } = data;
  const [emote, setEmote] = useState('');
  return (
    <Section title="远程控制">
      <LabeledList>
        <LabeledList.Item label="强制表情动作">
          <Input
            fluid
            selfClear
            onChange={setEmote}
            disabled={!erp_pref_check}
            onEnter={() => act('emote', { emote: emote })}
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
const RemoteMODsuitContent = () => {
  const { data } = useBackend<Data>();
  const { linked_suit, wearer, protean } = data;
  if (!linked_suit) {
    return (
      <Modal>
        <center>
          <Icon size={5} name="triangle-exclamation" />
        </center>
        <br />
        尚未安装
      </Modal>
    );
  }
  if (!wearer && !protean) {
    return (
      <Modal>
        <center>
          <Icon size={5} name="triangle-exclamation" />
        </center>
        <br />
        MOD 套装无人穿戴
      </Modal>
    );
  }
  return (
    <Box>
      {protean ? (
        <Stack vertical>
          <Protean />
          <RemoteSection />
        </Stack>
      ) : (
        <Stack vertical>
          <RemoteSection />
          <MODsuitContent />
        </Stack>
      )}
    </Box>
  );
};
