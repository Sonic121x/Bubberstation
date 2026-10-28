import { useState } from 'react';

import { Window } from '../../layouts';
import { BookListing } from './BookListing';
import { ModifyState } from './hooks';
import { ModifyPage } from './Modify';

export function LibraryAdmin(props) {
  const modifyMethodState = useState('');
  const modifyTargetState = useState(0);

  return (
    <Window
      title="管理员图书馆控制台"
      theme="admin"
      width={800}
      height={600}
    >
      <ModifyState.Provider value={{ modifyMethodState, modifyTargetState }}>
        {modifyMethodState[0] ? <ModifyPage /> : <BookListing />}
      </ModifyState.Provider>
    </Window>
  );
}
