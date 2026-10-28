import { useState } from 'react';
import { Button, Modal } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { TechwebContent } from './Content';
import { TechWebRoute } from './hooks';
import type { TechWebData } from './types';

export function TechwebStart(props) {
  const { act, data } = useBackend<TechWebData>();
  const { locked, stored_research } = data;
  const techwebState = useState({
    route: '',
  });

  if (locked) {
    return (
      <Modal width="15em" align="center" className="Techweb__LockedModal">
        <div>
          <b>控制台已锁定</b>
        </div>
        <Button icon="unlock" onClick={() => act('toggleLock')}>
          解锁
        </Button>
      </Modal>
    );
  }

  if (!stored_research) {
    return (
      <Modal width="25em" align="center" className="Techweb__LockedModal">
        <div>
          <b>未找到科研科技网络，请同步控制台。</b>
        </div>
      </Modal>
    );
  }

  return (
    <TechWebRoute.Provider value={techwebState}>
      <TechwebContent />
    </TechWebRoute.Provider>
  );
}
