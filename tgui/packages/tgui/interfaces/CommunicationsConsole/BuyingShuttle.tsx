import { sortBy } from 'es-toolkit';
import { Box, Button, Icon, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { EMAG_SHUTTLE_NOTICE } from './constants';
import { type CommsConsoleData, type Shuttle, ShuttleState } from './types';

function sortShuttles(shuttles: CommsConsoleData['shuttles']) {
  return sortBy(shuttles, [
    (shuttle) => !shuttle.emagOnly,
    (shuttle) => shuttle.initial_cost,
  ]);
}

export function PageBuyingShuttle(props) {
  const { act, data } = useBackend<CommsConsoleData>();
  const { budget, shuttles } = data;

  return (
    <Box>
      <Section>
        <Stack fill align="center" justify="space-between">
          <Button
            icon="chevron-left"
            onClick={() => act('setState', { state: ShuttleState.MAIN })}
          >
            返回
          </Button>

          <div>
            <Box as="span" bold color="good">
              {budget.toString()} cr
            </Box>{' '}
            <Icon name="coins" color="gold" />
          </div>
        </Stack>
      </Section>

      {sortShuttles(shuttles).map((shuttle) => (
        <ShuttleCard key={shuttle.ref} shuttle={shuttle} />
      ))}
    </Box>
  );
}

type ShuttleCardProps = {
  shuttle: Shuttle;
};

function ShuttleCard(props: ShuttleCardProps) {
  const { shuttle } = props;

  const { act, data } = useBackend<CommsConsoleData>();
  const {
    budget,
    displayed_currency_name,
    displayed_currency_full_name,
    emagged,
  } = data;

  return (
    <Section
      title={
        <span
          style={{
            display: 'inline-block',
            width: '70%',
          }}
        >
          {shuttle.name}
        </span>
      }
      buttons={
        <Button
          color={shuttle.emagOnly ? 'red' : 'default'}
          disabled={budget < shuttle.creditCost}
          onClick={() =>
            act('purchaseShuttle', {
              shuttle: shuttle.ref,
            })
          }
          tooltip={
            budget < shuttle.creditCost
              ? `还需要 ${shuttle.creditCost - budget} ${displayed_currency_full_name}。`
              : shuttle.emagOnly
                ? EMAG_SHUTTLE_NOTICE
                : undefined
          }
          tooltipPosition="left"
        >
          {shuttle.emagOnly && !emagged
            ? '购买'
            : `${shuttle.creditCost} ${displayed_currency_name}`}
        </Button>
      }
    >
      <Box>{shuttle.description}</Box>
      <Box color="teal" fontSize="10px" italic>
        最大载员：{shuttle.occupancy_limit}
      </Box>
      <Box color="violet" fontSize="10px" bold>
        {shuttle.prerequisites && <b>前提条件：{shuttle.prerequisites}</b>}
      </Box>
    </Section>
  );
}
