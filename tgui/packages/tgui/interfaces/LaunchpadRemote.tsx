import { NoticeBox } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { LaunchpadControl } from './LaunchpadConsole';

type Data = {
  has_pad: BooleanLike;
  pad_closed: BooleanLike;
};

export const LaunchpadRemote = (props) => {
  const { data } = useBackend<Data>();
  const { has_pad, pad_closed } = data;

  return (
    <Window
      title="公文包传送平台遥控器"
      width={340}
      height={275}
      theme="syndicate"
    >
      <Window.Content>
        {(!has_pad && <NoticeBox>未连接传送平台</NoticeBox>) ||
          (pad_closed && <NoticeBox>传送平台已收起</NoticeBox>) || (
            <LaunchpadControl topLevel />
          )}
      </Window.Content>
    </Window>
  );
};
