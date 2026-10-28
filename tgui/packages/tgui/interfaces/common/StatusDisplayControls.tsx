import { Button, Flex, Input, Section } from 'tgui-core/components';

import { useBackend, useSharedState } from '../../backend';

type Data = {
  upperText: string;
  lowerText: string;
  maxStatusLineLength: number;
};

export function StatusDisplayControls(props) {
  const { act, data } = useBackend<Data>();
  const {
    upperText: initialUpper,
    lowerText: initialLower,
    maxStatusLineLength,
  } = data;

  const [upperText, setUpperText] = useSharedState(
    'statusUpperText',
    initialUpper,
  );
  const [lowerText, setLowerText] = useSharedState(
    'statusLowerText',
    initialLower,
  );

  return (
    <>
      <Section>
        <Button
          icon="toggle-off"
          color="bad"
          onClick={() => act('setStatusPicture', { picture: 'blank' })}
        >
          关闭
        </Button>
        <Button
          icon="space-shuttle"
          color=""
          onClick={() => act('setStatusPicture', { picture: 'shuttle' })}
        >
          穿梭机到达倒计时／关闭
        </Button>
      </Section>

      <Section title="图形">
        <Button
          icon="flag"
          onClick={() => act('setStatusPicture', { picture: 'default' })}
        >
          标志
        </Button>

        <Button
          icon="exclamation"
          onClick={() => act('setStatusPicture', { picture: 'currentalert' })}
        >
          安全警戒等级
        </Button>

        <Button
          icon="exclamation-triangle"
          onClick={() => act('setStatusPicture', { picture: 'lockdown' })}
        >
          封锁
        </Button>

        <Button
          icon="biohazard"
          onClick={() => act('setStatusPicture', { picture: 'biohazard' })}
        >
          生物危害
        </Button>

        <Button
          icon="radiation"
          onClick={() => act('setStatusPicture', { picture: 'radiation' })}
        >
          辐射
        </Button>
      </Section>

      <Section title="消息">
        <Flex direction="column" align="stretch">
          <Flex.Item mb={1}>
            <Input
              fluid
              maxLength={maxStatusLineLength}
              value={upperText}
              onChange={setUpperText}
            />
          </Flex.Item>

          <Flex.Item mb={1}>
            <Input
              fluid
              maxLength={maxStatusLineLength}
              value={lowerText}
              onChange={setLowerText}
            />
          </Flex.Item>

          <Flex.Item>
            <Button
              icon="comment-o"
              onClick={() => act('setStatusMessage', { upperText, lowerText })}
            >
              发送
            </Button>
          </Flex.Item>
        </Flex>
      </Section>
    </>
  );
}
