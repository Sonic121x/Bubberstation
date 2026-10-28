import { Button, Dropdown, LabeledList, Section } from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts'; import { tacVisorDisplay } from '../localization/tacVisorDisplay';

type Data = {
  friendlyFaction: string;
  hostileFaction: string;
  visorDisplay: string;
  threatFlags: number;

  validFriendlyFactions: string[];
  validHostileFactions: string[];
  visorOptions: string[];
  threatOptions: Record<string, number>;
};

export const TacVisorEyesMenu = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    friendlyFaction,
    hostileFaction,
    visorDisplay,
    threatFlags,
    validFriendlyFactions,
    validHostileFactions,
    visorOptions,
    threatOptions,
  } = data;
  return (
    <Window title="战术敌我识别目镜" width={320} height={264}>
      <Window.Content>
        <Section title="设置">
          <LabeledList>
            <LabeledList.Item label="友方阵营">
              <Dropdown
                options={validFriendlyFactions.map((value) => ({value, displayText: tacVisorDisplay(value)}))}
                selected={friendlyFaction} displayText={tacVisorDisplay(friendlyFaction)}
                onSelected={(value) => act('set_friendly', { faction: value })}
              />
            </LabeledList.Item>
            <LabeledList.Item label="敌对阵营">
              <Dropdown
                options={validHostileFactions.map((value) => ({value, displayText: tacVisorDisplay(value)}))}
                selected={hostileFaction} displayText={tacVisorDisplay(hostileFaction)}
                onSelected={(value) => act('set_hostile', { faction: value })}
              />
            </LabeledList.Item>
            <LabeledList.Item label="目镜图案">
              <Dropdown
                options={visorOptions.map((value) => ({value, displayText: tacVisorDisplay(value)}))}
                selected={visorDisplay} displayText={tacVisorDisplay(visorDisplay)}
                onSelected={(value) => act('set_display', { display: value })}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="威胁判定参数">
          {Object.keys(threatOptions).map((option) => (
            <Button.Checkbox
              key={option}
              checked={threatFlags & threatOptions[option]}
              onClick={() =>
                act('set_threat_flags', {
                  threat_flags: threatFlags ^ threatOptions[option],
                })
              }
            >
              {option}
            </Button.Checkbox>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
