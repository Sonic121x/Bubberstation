// THIS IS A BUBBER UI FILE

import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts/Window';
import { Button, Section, Tabs } from 'tgui-core/components';

import { BelliesList } from './BellyUI';
import { Preferences } from './GeneralPrefs';
import { Inside } from './Inside';
import { Savefile, SlotLookupTable } from './SavefileManagement';
import type * as types from './types';

export const VorePanel = (props) => {
  return (
    <Window width={750} height={540}>
      <Window.Content>
        <VoreMain />
      </Window.Content>
    </Window>
  );
};

const VoreMain = (props) => {
  const { data, act } = useBackend<types.Data>();
  const [tab, setTab] = useState(0);

  if (data.character_slots) {
    return <SlotLookupTable />;
  }

  let tabs_to_use: React.ReactElement | null = (
    <Tabs fluid>
      <Tabs.Tab selected={tab === 0} onClick={() => setTab(0)}>
        腹腔
      </Tabs.Tab>
      <Tabs.Tab selected={tab === 1} onClick={() => setTab(1)}>
        所在腹腔
      </Tabs.Tab>
      <Tabs.Tab selected={tab === 2} onClick={() => setTab(2)}>
        偏好
      </Tabs.Tab>
    </Tabs>
  );

  if (tab > 2) {
    tabs_to_use = null;
  }

  return (
    <Section
      title={
        data.not_our_owner
          ? '吞食面板 - 警告：保存功能已禁用'
          : `吞食面板 - ${data.current_slot}`
      }
      fill
      buttons={
        <Button
          icon={tab === 3 ? 'arrow-left' : 'cloud-download-alt'}
          onClick={() => setTab(tab === 3 ? 0 : 3)}
        >
          {tab === 3 ? '返回' : '腹腔存档管理'}
        </Button>
      }
    >
      {tabs_to_use}
      {tab === 0 && <BelliesList />}
      {tab === 1 && <Inside />}
      {tab === 2 && <Preferences />}
      {tab === 3 && <Savefile setTab={setTab} />}
    </Section>
  );
};
