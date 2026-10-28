// THIS IS A SKYRAT UI FILE
import { Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const AntagInfoOpfor = (props) => {
  const { act } = useBackend();
  return (
    <Window width={620} height={250}>
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item fontSize="20px" color={'good'}>
              {'你是敌对势力候选人！'}
            </Stack.Item>
            {
              '鼓励你申请成为敌对势力，以某种形式开展反派行动。'
            }
            {
              '如果没有想法，可以查看 Discord 的 #player-submitted-opfors 频道寻找灵感。'
            }
            {
              '如果你不想成为敌对势力，只需点击下方按钮移除候选人身份。'
            }
            <Stack.Item align="center">
              <Button
                color="red"
                content={'移除身份'}
                tooltip={'移除你的敌对势力候选人身份。'}
                onClick={() => act('pass_on')}
              />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
