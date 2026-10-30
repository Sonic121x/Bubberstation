import {
  Box,
  Button,
  Dimmer,
  Icon,
  LabeledList,
  Section,
  Tabs,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';
import { batchThreeDisplay } from '../localization/batchThreeDisplay';
export const Limbgrower = (props) => {
  const { act, data } = useBackend();
  const {
    reagents = [],
    total_reagents,
    max_reagents,
    categories = [],
    busy,
  } = data;
  const [tab, setTab] = useSharedState('category', categories[0]?.name);
  const designList =
    categories.find((category) => category.name === tab)?.designs || [];

  return (
    <Window title="肢体培养器" width={500} height={550}>
      {!!busy && (
        <Dimmer fontSize="32px">
          <Icon name="cog" spin={1} />
          {' 正在制造……'}
        </Dimmer>
      )}
      <Window.Content scrollable>
        <Section title="试剂">
          <Box mb={1}>
            已用试剂容量：{total_reagents} / {max_reagents}。
          </Box>
          <LabeledList>
            {reagents.map((reagent) => (
              <LabeledList.Item
                key={reagent.reagent_name}
                label={reagent.reagent_name}
                buttons={
                  <Button.Confirm
                    textAlign="center"
                    width="120px"
                    content="移除试剂"
                    color="bad"
                    onClick={() =>
                      act('empty_reagent', {
                        reagent_type: reagent.reagent_type,
                      })
                    }
                  />
                }
              >
                {reagent.reagent_amount}u
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
        <Section title="设计图">
          <Tabs>
            {categories.map((category) => (
              <Tabs.Tab
                fluid
                key={category.name}
                selected={tab === category.name}
                onClick={() => setTab(category.name)}
              >
                {batchThreeDisplay(category.name)}
              </Tabs.Tab>
            ))}
          </Tabs>
          <LabeledList>
            {designList.map((design) => (
              <LabeledList.Item
                key={design.name}
                label={design.name}
                buttons={
                  <Button
                    content="制造"
                    color="good"
                    onClick={() =>
                      act('make_limb', {
                        design_path: design.path,
                        active_tab: design.parent_category,
                      })
                    }
                  />
                }
              >
                {design.needed_reagents.map((reagent) => (
                  <Box key={reagent.name}>
                    {reagent.name}: {reagent.amount}u
                  </Box>
                ))}
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
