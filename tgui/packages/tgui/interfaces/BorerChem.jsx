// THIS IS A SKYRAT UI FILE
import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const BorerChem = (props) => {
  const { act, data } = useBackend();
  const borerTransferAmounts = data.borerTransferAmounts || [];
  return (
    <Window width={565} height={400} title="注射器" theme="wizard">
      <Window.Content scrollable>
        <Section title="状态">
          <LabeledList>
            <LabeledList.Item label="储量">
              <ProgressBar value={data.energy / data.maxEnergy}>
                {`${toFixed(data.energy)} 单位`}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          title="注射"
          buttons={borerTransferAmounts.map((amount) => (
            <Button
              key={amount}
              icon="plus"
              selected={amount === data.amount}
              content={amount}
              onClick={() =>
                act('amount', {
                  target: amount,
                })
              }
            />
          ))}
        >
          <Box mr={-1}>
            {data.chemicals.map((chemical) => (
              <Button
                key={chemical.id}
                icon="tint"
                width="129.5px"
                lineHeight={1.75}
                content={chemical.title}
                disabled={data.onCooldown || data.notEnoughChemicals}
                onClick={() =>
                  act('inject', {
                    reagent: chemical.title,
                  })
                }
              />
            ))}
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
