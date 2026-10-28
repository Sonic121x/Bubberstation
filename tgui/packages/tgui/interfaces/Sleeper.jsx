import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const damageTypes = [
  {
    label: '物理伤害',
    type: 'bruteLoss',
  },
  {
    label: '烧伤',
    type: 'fireLoss',
  },
  {
    label: '毒素伤害',
    type: 'toxLoss',
  },
  {
    label: '窒息伤害',
    type: 'oxyLoss',
  },
];

export const Sleeper = (props) => {
  const { act, data } = useBackend();
  const { open, occupant = {}, occupied } = data;
  const preSortChems = data.chems || [];
  const chems = preSortChems.sort((a, b) => {
    const descA = a.name.toLowerCase();
    const descB = b.name.toLowerCase();
    if (descA < descB) {
      return -1;
    }
    if (descA > descB) {
      return 1;
    }
    return 0;
  });
  return (
    <Window width={310} height={465}>
      <Window.Content>
        <Section
          title={occupant.name ? occupant.name : '舱内无人'}
          minHeight="210px"
          buttons={
            !!occupant.stat && (
              <Box inline bold color={occupant.statstate}>
                {occupant.stat}
              </Box>
            )
          }
        >
          {!!occupied && (
            <>
              <ProgressBar
                value={occupant.health}
                minValue={occupant.minHealth}
                maxValue={occupant.maxHealth}
                ranges={{
                  good: [50, Infinity],
                  average: [0, 50],
                  bad: [-Infinity, 0],
                }}
              />
              <Box mt={1} />
              <LabeledList>
                {damageTypes.map((type) => (
                  <LabeledList.Item key={type.type} label={type.label}>
                    <ProgressBar
                      value={occupant[type.type]}
                      minValue={0}
                      maxValue={occupant.maxHealth}
                      color="bad"
                    />
                  </LabeledList.Item>
                ))}
                <LabeledList.Item
                  label="大脑"
                  color={occupant.brainLoss ? 'bad' : 'good'}
                >
                  {occupant.brainLoss ? '异常' : '健康'}
                </LabeledList.Item>
              </LabeledList>
            </>
          )}
        </Section>
        <Section
          title="药物"
          minHeight="205px"
          buttons={
            <Button
              icon={open ? 'door-open' : 'door-closed'}
              content={open ? '已打开' : '已关闭'}
              onClick={() => act('door')}
            />
          }
        >
          {chems.map((chem) => (
            <Button
              key={chem.name}
              icon="flask"
              content={chem.name}
              disabled={!occupied || !chem.allowed}
              width="140px"
              onClick={() =>
                act('inject', {
                  chem: chem.id,
                })
              }
            />
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
