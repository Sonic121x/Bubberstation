import { useEffect, useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Box, Button, Modal, Stack } from 'tgui-core/components';

import type { PreferencesMenuData } from '../types';

type Props = {
  close: () => void;
};

export function DeleteCharacterPopup(props: Props) {
  const { data, act } = useBackend<PreferencesMenuData>();
  const [secondsLeft, setSecondsLeft] = useState(3);

  const { close } = props;

  useEffect(() => {
    const interval = setInterval(() => {
      setSecondsLeft((current) => current - 1);
    }, 1000);

    return () => clearInterval(interval);
  }, []);

  return (
    <Modal>
      <Stack vertical textAlign="center" align="center">
        <Stack.Item>
          <Box fontSize="3em">请稍等！</Box>
        </Stack.Item>

        <Stack.Item maxWidth="300px">
          <Box>{`你即将永久删除 ${data.character_preferences.names[data.name_to_use]}。确定要这样做吗？`}</Box>
        </Stack.Item>

        <Stack.Item>
          <Stack fill>
            <Stack.Item>
              {/* Explicit width so that the layout doesn't shift */}
              <Button
                color="danger"
                disabled={secondsLeft > 0}
                width="80px"
                onClick={() => {
                  act('remove_current_slot');
                  close();
                }}
              >
                {secondsLeft <= 0 ? '删除' : `删除（${secondsLeft}）`}
              </Button>
            </Stack.Item>

            <Stack.Item>
              <Button onClick={close}>{'不，取消删除'}</Button>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Modal>
  );
}
