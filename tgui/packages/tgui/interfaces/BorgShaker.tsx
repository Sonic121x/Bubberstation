import { Button, NoticeBox, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type BorgShakerContext = {
  minVolume: number;
  theme: string;
  sodas: Reagent[];
  alcohols: Reagent[];
  selectedReagent: string;
  reagentSearchContainer: ContainerPreference;
  apparatusHasItem: boolean;
};

type Reagent = {
  name: string;
  volume: number;
  description: string;
};

enum ContainerPreference {
  BeverageApparatus = 'beverage_apparatus',
  InternalBeaker = 'internal_beaker',
}

export const BorgShaker = (props) => {
  const { act, data } = useBackend<BorgShakerContext>();
  const { theme, minVolume, sodas, alcohols, selectedReagent } = data;

  const dynamicHeight =
    Math.ceil(sodas.length / 4) * 23 +
    Math.ceil(alcohols.length / 4) * 23 +
    140;

  return (
    <Window width={650} height={dynamicHeight} theme={theme}>
      <Window.Content>
        <Section
          title={'无酒精饮品'}
          buttons={
            <>
              <Button
                icon="book"
                content={'反应查询'}
                disabled={
                  data.reagentSearchContainer !==
                    ContainerPreference.InternalBeaker && !data.apparatusHasItem
                }
                tooltip={
                  '查询配方和试剂！请选择作为查询来源的容器'
                }
                tooltipPosition="bottom-start"
                onClick={() => act('reaction_lookup')}
              />
              <Button
                icon="flask"
                width="23px"
                color={
                  data.reagentSearchContainer ===
                  ContainerPreference.InternalBeaker
                    ? 'green'
                    : 'default'
                }
                tooltip="查询来源：内置烧杯"
                onClick={() => {
                  act('set_preferred_container', {
                    value: ContainerPreference.InternalBeaker,
                  });
                }}
              />
              <Button
                icon="vial"
                width="24px"
                tooltip="查询来源：饮料操作装置"
                color={
                  data.reagentSearchContainer ===
                  ContainerPreference.BeverageApparatus
                    ? 'green'
                    : 'default'
                }
                onClick={() => {
                  act('set_preferred_container', {
                    value: ContainerPreference.BeverageApparatus,
                  });
                }}
              />
            </>
          }
        >
          <ReagentDisplay
            reagents={sodas}
            selected={selectedReagent}
            minimum={minVolume}
          />
        </Section>
        <Section title={'含酒精饮品'}>
          <ReagentDisplay
            reagents={alcohols}
            selected={selectedReagent}
            minimum={minVolume}
          />
        </Section>
      </Window.Content>
    </Window>
  );
};

const ReagentDisplay = (props) => {
  const { act } = useBackend();
  const { reagents, selected, minimum } = props;
  if (reagents.length === 0) {
    return <NoticeBox>没有可用试剂！</NoticeBox>;
  }
  return reagents.map((reagent) => (
    <Button
      key={reagent.id}
      icon="tint"
      width="150px"
      lineHeight={1.75}
      content={reagent.name}
      color={reagent.name === selected ? 'green' : 'default'}
      disabled={reagent.volume < minimum}
      onClick={() => act(reagent.name)}
    />
  ));
};
