import {
  Box,
  Button,
  LabeledList,
  NumberInput,
  Section,
} from 'tgui-core/components';
import { chineseDisplay } from 'tgui/localization/zhDisplay';
import { useBackend } from '../backend';
import { Window } from '../layouts';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';
import { machineChoiceDisplay } from './common/machineChoiceDisplay';
const DISEASE_THEASHOLD_LIST = [
  'Positive',
  'Harmless',
  'Minor',
  'Medium',
  'Harmful',
  'Dangerous',
  'BIOHAZARD',
];

// SKYRAT EDIT BEGIN - MORE SCANNER GATE OPTIONS
const TARGET_GENDER_LIST = [
  {
    name: 'Male',
    value: 'male',
  },
  {
    name: 'Female',
    value: 'female',
  },
];
//  SKYRAT EDIT END - MORE SCANNER GATE OPTIONS

const TARGET_NUTRITION_LIST = [
  {
    name: 'Starving',
    value: 150,
  },
  {
    name: 'Obese',
    value: 600,
  },
];

export const ScannerGate = (props) => {
  const { act, data } = useBackend();
  return (
    <Window width={400} height={300}>
      <Window.Content scrollable>
        <InterfaceLockNoticeBox
          onLockedStatusChange={() => act('toggle_lock')}
        />
        {!data.locked && <ScannerGateControl />}
      </Window.Content>
    </Window>
  );
};

const SCANNER_GATE_ROUTES = {
  Off: {
    title: '扫描模式：关闭',
    component: () => ScannerGateOff,
  },
  Wanted: {
    title: '扫描模式：通缉',
    component: () => ScannerGateWanted,
  },
  Guns: {
    title: '扫描模式：枪械',
    component: () => ScannerGateGuns,
  },
  Mindshield: {
    title: '扫描模式：心灵护盾',
    component: () => ScannerGateMindshield,
  },
  Disease: {
    title: '扫描模式：疾病',
    component: () => ScannerGateDisease,
  },
  Species: {
    title: '扫描模式：物种',
    component: () => ScannerGateSpecies,
  },
  Nutrition: {
    title: '扫描模式：营养',
    component: () => ScannerGateNutrition,
  },
  //  SKYRAT EDIT START - MORE SCANNER GATE OPTIONS
  Gender: {
    title: '扫描模式：性别',
    component: () => ScannerGateGender,
  },
  //  SKYRAT EDIT END - MORE SCANNER GATE OPTIONS
  // BUBBER EDIT START - NANITES
  Nanites: {
    title: '扫描模式：纳米机器人',
    component: () => ScannerGateNanites,
  },
  // BUBBER EDIT END - NANITES
};

const ScannerGateControl = (props) => {
  const { act, data } = useBackend();
  const { scan_mode } = data;
  const route = SCANNER_GATE_ROUTES[scan_mode] || SCANNER_GATE_ROUTES.off;
  const Component = route.component();
  return (
    <Section
      title={route.title}
      buttons={
        scan_mode !== 'Off' && (
          <Button
            icon="arrow-left"
            content="返回"
            onClick={() => act('set_mode', { new_mode: 'Off' })}
          />
        )
      }
    >
      <Component />
    </Section>
  );
};

const ScannerGateOff = (props) => {
  const { act, data } = useBackend();
  return (
    <>
      <Box mb={2}>请在下方选择扫描模式。</Box>
      <Box>
        <Button
          content="通缉"
          onClick={() => act('set_mode', { new_mode: 'Wanted' })}
        />
        <Button
          content="枪械"
          onClick={() => act('set_mode', { new_mode: 'Guns' })}
        />
        <Button
          content="心灵护盾"
          onClick={() => act('set_mode', { new_mode: 'Mindshield' })}
        />
        <Button
          content="疾病"
          onClick={() => act('set_mode', { new_mode: 'Disease' })}
        />
        <Button
          content="物种"
          onClick={() => act('set_mode', { new_mode: 'Species' })}
        />
        <Button //  SKYRAT EDIT START - MORE SCANNER GATE OPTIONS
          content="性别"
          onClick={() => act('set_mode', { new_mode: 'Gender' })} //  SKYRAT EDIT END - MORE SCANNER GATE OPTIONS
        />
        <Button
          content="营养"
          onClick={() => act('set_mode', { new_mode: 'Nutrition' })}
        />
        {/* BUBBER EDIT START - NANITES */}
        <Button
          content="纳米机器人"
          onClick={() => act('set_mode', { new_mode: 'Nanites' })}
        />
        {/* BUBBER EDIT END - NANITES */}
      </Box>
    </>
  );
};

const ScannerGateWanted = (props) => {
  const { data } = useBackend();
  const { reverse } = data;
  return (
    <>
      <Box mb={2}>
        当受扫描者{reverse ? '未被' : '被'}
        通缉时触发。
      </Box>
      <ScannerGateMode />
    </>
  );
};

const ScannerGateGuns = (props) => {
  const { data } = useBackend();
  const { reverse } = data;
  return (
    <>
      <Box mb={2}>
        当受扫描者{reverse ? '未携带' : '携带'}
        枪械时触发。
      </Box>
      <ScannerGateMode />
    </>
  );
};

const ScannerGateMindshield = (props) => {
  const { data } = useBackend();
  const { reverse } = data;
  return (
    <>
      <Box mb={2}>
        当受扫描者{reverse ? '没有' : '拥有'}
        心灵护盾时触发。
      </Box>
      <ScannerGateMode />
    </>
  );
};

const ScannerGateDisease = (props) => {
  const { act, data } = useBackend();
  const { reverse, disease_threshold } = data;
  return (
    <>
      <Box mb={2}>
        当受扫描者{reverse ? '未患有' : '患有'}
        严重程度达到或超过{chineseDisplay(disease_threshold)}的疾病时触发。
      </Box>
      <Box mb={2}>
        {DISEASE_THEASHOLD_LIST.map((threshold) => (
          <Button.Checkbox
            key={threshold}
            checked={threshold === disease_threshold}
            content={chineseDisplay(threshold)}
            onClick={() =>
              act('set_disease_threshold', {
                new_threshold: threshold,
              })
            }
          />
        ))}
      </Box>
      <ScannerGateMode />
    </>
  );
};

const ScannerGateSpecies = (props) => {
  const { act, data } = useBackend();
  const { reverse, target_species_id, available_species, target_zombie } = data;
  const species = available_species.find((species) => {
    return species.specie_id === target_species_id;
  });
  return (
    <>
      <Box mb={2}>
        当受扫描者{reverse ? '不属于' : '属于'}
        {species.specie_name}物种时触发。
        {target_zombie
          ? ' 将检测所有僵尸类型，包括休眠僵尸。'
          : null}
      </Box>
      <Box mb={2}>
        {available_species.map((species) => (
          <Button.Checkbox
            key={species.specie_id}
            checked={species.specie_id === target_species_id}
            onClick={() =>
              act('set_target_species', {
                new_species_id: species.specie_id,
              })
            }
          >
            {species.specie_name}
          </Button.Checkbox>
        ))}
      </Box>
      <ScannerGateMode />
    </>
  );
};

const ScannerGateNutrition = (props) => {
  const { act, data } = useBackend();
  const { reverse, target_nutrition } = data;
  const nutrition = TARGET_NUTRITION_LIST.find((nutrition) => {
    return nutrition.value === target_nutrition;
  });
  return (
    <>
      <Box mb={2}>
        当受扫描者{reverse ? '不处于' : '处于'}
        {machineChoiceDisplay(nutrition.name)}营养状态时触发。
      </Box>
      <Box mb={2}>
        {TARGET_NUTRITION_LIST.map((nutrition) => (
          <Button.Checkbox
            key={nutrition.name}
            checked={nutrition.value === target_nutrition}
            content={machineChoiceDisplay(nutrition.name)}
            onClick={() =>
              act('set_target_nutrition', {
                new_nutrition: nutrition.name,
              })
            }
          />
        ))}
      </Box>
      <ScannerGateMode />
    </>
  );
};
// BUBBER EDIT START - NANITES
const ScannerGateNanites = (props, context) => {
  const { act, data } = useBackend(context);
  const { reverse, nanite_cloud, min_cloud_id, max_cloud_id } = data;
  return (
    <>
      <Box mb={2}>
        当受扫描者{reverse ? '未连接' : '已连接'}纳米机器人云端
        {nanite_cloud}时触发。
      </Box>
      <Box mb={2}>
        <LabeledList>
          <LabeledList.Item label="云端 ID">
            <NumberInput
              value={nanite_cloud}
              width="65px"
              minValue={min_cloud_id + 1}
              maxValue={max_cloud_id}
              step={1}
              stepPixelSize={2}
              onChange={(value) =>
                act('set_nanite_cloud', {
                  new_cloud: value,
                })
              }
            />
          </LabeledList.Item>
        </LabeledList>
      </Box>
      <ScannerGateMode />
    </>
  );
};
// BUBBER EDIT END - NANITES

//  SKYRAT EDIT START - MORE SCANNER GATE OPTIONS
const ScannerGateGender = (props) => {
  const { act, data } = useBackend();
  const { reverse, target_gender } = data;
  const gender = TARGET_GENDER_LIST.find((gender) => {
    return gender.value === target_gender;
  });
  return (
    <>
      <Box mb={2}>
        当受扫描者{reverse ? '不是' : '是'}{machineChoiceDisplay(gender.name)}时触发。
      </Box>
      <Box mb={2}>
        {TARGET_GENDER_LIST.map((gender) => (
          <Button.Checkbox
            key={gender.name}
            checked={gender.value === target_gender}
            content={machineChoiceDisplay(gender.name)}
            onClick={() =>
              act('set_target_gender', {
                new_gender: gender.name,
              })
            }
          />
        ))}
      </Box>
      <ScannerGateMode />
    </>
  );
};
//  SKYRAT EDIT END - MORE SCANNER GATE OPTIONS
const ScannerGateMode = (props) => {
  const { act, data } = useBackend();
  const { reverse } = data;
  return (
    <LabeledList>
      <LabeledList.Item label="扫描模式">
        <Button
          content={reverse ? '反向' : '默认'}
          icon={reverse ? 'random' : 'long-arrow-alt-right'}
          onClick={() => act('toggle_reverse')}
          color={reverse ? 'bad' : 'good'}
        />
      </LabeledList.Item>
    </LabeledList>
  );
};
