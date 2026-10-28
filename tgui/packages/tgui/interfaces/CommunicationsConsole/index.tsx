import { Box, Button, Section } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { PageBuyingShuttle } from './BuyingShuttle';
import { PageChangingStatus } from './ChangingStatus';
import { PageMain } from './Main';
import { PageMessages } from './Messages';
import { NoConnectionModal } from './NoConnectionModal';
import { type CommsConsoleData, ShuttleState } from './types';

export function CommunicationsConsole(props) {
  const { act, data } = useBackend<CommsConsoleData>();
  const {
    authenticated,
    authorizeName,
    canLogOut,
    canRequestSafeCode,
    emagged,
    hasConnection,
    page,
    safeCodeDeliveryArea,
    safeCodeDeliveryWait,
  } = data;

  let currentPage;
  switch (page) {
    case ShuttleState.BUYING_SHUTTLE:
      currentPage = <PageBuyingShuttle />;
      break;
    case ShuttleState.CHANGING_STATUS:
      currentPage = <PageChangingStatus />;
      break;
    case ShuttleState.MAIN:
      currentPage = <PageMain />;
      break;
    case ShuttleState.MESSAGES:
      currentPage = <PageMessages />;
      break;
    default:
      currentPage = <Box>页面尚未实现：{page}</Box>;
      break;
  }

  return (
    <Window width={400} height={650} theme={emagged ? 'syndicate' : undefined}>
      <Window.Content scrollable>
        {!hasConnection && <NoConnectionModal />}

        {(canLogOut || !authenticated) && (
          <Section title="身份验证">
            <Button
              icon={authenticated ? 'sign-out-alt' : 'sign-in-alt'}
              color={authenticated ? 'bad' : 'good'}
              onClick={() => act('toggleAuthentication')}
            >
              {authenticated
                ? `登出${authorizeName ? ` (${authorizeName})` : ''}`
                : '登录'}
            </Button>
          </Section>
        )}

        {canRequestSafeCode ? (
          <Section title="应急保险柜密码">
            <Button
              icon="key"
              color="good"
              onClick={() => act('requestSafeCodes')}
            >
              请求保险柜密码
            </Button>
          </Section>
        ) : (
          !!safeCodeDeliveryWait && (
            <Section title="应急保险柜密码投送" color="label">
              {`空投舱抵达 ${safeCodeDeliveryArea} 的剩余时间：\
            ${Math.round(safeCodeDeliveryWait / 10)} 秒`}
            </Section>
          )
        )}

        {!!authenticated && currentPage}
      </Window.Content>
    </Window>
  );
}
