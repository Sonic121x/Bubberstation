import { useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  Icon,
  NoticeBox,
  RestrictedInput,
  Section,
  Stack,
  Table,
  TextArea,
  Tooltip,
} from 'tgui-core/components';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { holopayDisplay } from '../localization/holopayDisplay';
type HoloPayData = {
  available_logos: string[];
  balance: number;
  description: string;
  force_fee: number;
  max_fee: number;
  name: string;
  owner: string;
  shop_logo: string;
  user: { name: string; balance: number };
};

export const HoloPay = (props) => {
  const { data } = useBackend<HoloPayData>();
  const { owner } = data;
  const [setupMode, setSetupMode] = useState(false);
  // User clicked the "Setup" or "Done" button.
  const onClick = () => {
    setSetupMode(!setupMode);
  };

  return (
    <Window height={300} width={250} title="全息支付">
      <Window.Content>
        {!owner ? (
          <NoticeBox>错误！请先刷ID卡。</NoticeBox>
        ) : (
          <Stack fill vertical>
            <Stack.Item>
              <AccountDisplay onClick={onClick} />
            </Stack.Item>
            <Stack.Item grow>
              {!setupMode ? (
                <TerminalDisplay onClick={onClick} />
              ) : (
                <SetupDisplay onClick={onClick} />
              )}
            </Stack.Item>
          </Stack>
        )}
      </Window.Content>
    </Window>
  );
};

/**
 * Displays the current user's bank information (if any)
 */
const AccountDisplay = (props) => {
  const { data } = useBackend<HoloPayData>();
  const { user } = data;
  if (!user) {
    return <NoticeBox>错误！未检测到账户。</NoticeBox>;
  }

  return (
    <Section>
      <Table>
        <Table.Row>
          <Table.Cell>
            <Box color="label">
              <Icon name="money-check" color="label" mr={1} />
              {user?.name}
            </Box>
          </Table.Cell>
          <Table.Cell collapsing>
            <Box color="good">
              {user?.balance} cr <Icon color="gold" name="coins" />
            </Box>
          </Table.Cell>
        </Table.Row>
      </Table>
    </Section>
  );
};

/**
 * Displays the payment processor. This is the main display.
 * Shows icon, name, payment button.
 */
const TerminalDisplay = (props) => {
  const { act, data } = useBackend<HoloPayData>();
  const { description, force_fee, name, owner, user, shop_logo } = data;
  const { onClick } = props;
  const is_owner = owner === user?.name;
  const cannot_pay =
    is_owner || !user || user?.balance < 1 || user?.balance < force_fee;

  return (
    <Section
      buttons={
        is_owner && (
          <Button icon="edit" onClick={onClick}>
            设置
          </Button>
        )
      }
      fill
      title="终端"
    >
      <Stack fill vertical>
        <Stack.Item align="center" mt={3}>
          <Icon color="good" name={shop_logo} size={5} />
        </Stack.Item>
        <Stack.Item grow textAlign="center">
          <Tooltip content={description} position="bottom">
            <Box color="label" fontSize="17px" overflow="hidden">
              {decodeHtmlEntities(name)}
            </Box>
          </Tooltip>
        </Stack.Item>
        <Stack.Item>
          {force_fee ? (
            <Button.Confirm
              content={
                <>
                  <Icon name="coins" />
                  支付{`${force_fee}信用点`}
                </>
              }
              disabled={cannot_pay}
              fluid
              height="2rem"
              onClick={() => act('pay')}
              pt={0.2}
              textAlign="center"
            />
          ) : (
            <Button
              content={
                <>
                  <Icon name="coins" />
                  支付
                </>
              }
              disabled={cannot_pay}
              fluid
              height="2rem"
              onClick={() => act('pay')}
              pt={0.2}
              textAlign="center"
            />
          )}
        </Stack.Item>
      </Stack>
    </Section>
  );
};

/**
 * User has clicked "setup" button. Changes vars on the holopay.
 */
const SetupDisplay = (props) => {
  const { act, data } = useBackend<HoloPayData>();
  const { available_logos = [], force_fee, max_fee, name, shop_logo } = data;
  const { onClick } = props;

  const [isValid, setIsValid] = useState(true);

  return (
    <Section
      buttons={
        <Button
          icon="check"
          onClick={() => {
            act('done');
            onClick();
          }}
        >
          完成
        </Button>
      }
      fill
      scrollable
      title="设置"
    >
      <Stack fill vertical>
        <Stack.Item>
          <Box bold color="label">
            商店标志
          </Box>
          <Dropdown
            onSelected={(value) => act('logo', { logo: value })}
            options={available_logos.map((value) => ({ value, displayText: holopayDisplay(value) }))}
            selected={shop_logo} displayText={holopayDisplay(shop_logo)}
            width="100%"
          />
        </Stack.Item>
        <Stack.Item>
          <Box bold color="label">
            名称（3至42个字符）
          </Box>
          <TextArea
            fluid
            height="3rem"
            maxLength={42}
            onBlur={(value) => {
              value?.length > 3 && act('rename', { name: value });
            }}
            placeholder={decodeHtmlEntities(name)}
          />
        </Stack.Item>
        <Stack.Item>
          <Tooltip content="设置固定费用，替代任意金额付款。">
            <Box bold color="label">
              固定费用
            </Box>
            <RestrictedInput
              fluid
              maxValue={max_fee}
              onEnter={(value) => isValid && act('fee', { amount: value })}
              onValidationChange={setIsValid}
              value={force_fee}
            />
          </Tooltip>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
