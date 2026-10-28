import { useState } from 'react';
import {
  Button,
  DmIcon,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

type Data = {
  dmi: {
    icon: string;
    icon_state: string;
  };
};

export const NtosCursor = () => {
  const { data } = useBackend<Data>();

  const { dmi } = data;

  const [numClicked, incrementClicked] = useState(0);

  const NoticeBoxText = () => {
    if (numClicked <= 2) {
      return `只有一个选项……就是这把剑。`;
    } else if (numClicked === 3) {
      return `你点了一下这把剑。它还是这把剑。`;
    } else if (numClicked === 4) {
      return `你又点了一下这把剑。它还是这把剑。`;
    } else if (numClicked === 5) {
      return `还想再点这把剑？它还是这把剑。`;
    }
    return `你点了这把剑 ${numClicked} 次……它还是这把剑。`;
  };

  return (
    <NtosWindow width={350} height={300}>
      <NtosWindow.Content scrollable>
        <Section title="选择光标">
          <Stack vertical>
            <Stack.Item align={'center'}>
              <Button
                height="100px"
                width="100px"
                color={numClicked >= 1 ? 'green' : null}
                onClick={() => incrementClicked(numClicked + 1)}
              >
                <DmIcon
                  icon={dmi.icon}
                  icon_state={dmi.icon_state}
                  style={{
                    transform: `scale(3) translateX(4px) translateY(8px)`,
                  }}
                />
              </Button>
            </Stack.Item>
            <Stack.Item>
              <NoticeBox>{NoticeBoxText()}</NoticeBox>
            </Stack.Item>
          </Stack>
        </Section>
      </NtosWindow.Content>
    </NtosWindow>
  );
};
