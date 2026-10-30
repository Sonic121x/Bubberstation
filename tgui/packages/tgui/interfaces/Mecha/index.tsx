import { useState } from 'react';
import {
  Button,
  ByondUi,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';
import { formatSiUnit } from 'tgui-core/format';

import { useBackend } from '../../backend';
import { useSharedState } from '../../backend';
import { Window } from '../../layouts';
import { logger } from '../../logging';
import { AccessConfig } from '../common/AccessConfig';
import { AlertPane } from './AlertPane';
import type { MainData } from './data';
import { ModulesPane } from './ModulesPane';

export const Mecha = (props) => {
  const { data } = useBackend<MainData>();
  const [showModuleList, setShowModuleList] = useSharedState(
    'showModuleList',
    true,
  );
  const mainWidth = 400;
  const equipmentWidth = 400;
  const windowWidth = mainWidth + (showModuleList ? equipmentWidth : 0);
  return (
    <Window theme={data.ui_theme} width={windowWidth} height={560}>
      <Window.Content>
        <Content />
      </Window.Content>
    </Window>
  );
};

export const Content = (props) => {
  const { act, data } = useBackend<MainData>();
  const [edit_access, editAccess] = useState(false);
  const {
    name,
    mecha_flags,
    mechflag_keys,
    mech_view,
    one_access,
    regions,
    accesses,
    diagnostic_status,
  } = data;
  logger.log(mechflag_keys);

  const id_lock = mecha_flags & mechflag_keys.ID_LOCK_ON;
  return (
    <Stack fill>
      <Stack.Item grow={1}>
        <Stack vertical fill minWidth='270px'>
          <Stack.Item grow overflow="hidden">
            <Section
              fill
              title={name}
              buttons={
                <>
                  <Button
                    icon="edit"
                    tooltip="重命名"
                    tooltipPosition="left"
                    onClick={() => act('changename')}
                  />
                  {!diagnostic_status && (
                    <Button
                      icon="tachograph-digital"
                      color="violet"
                      tooltip="诊断"
                      tooltipPosition="left"
                      onClick={() => act('diagnostic')}
                    />
                  )}
                </>
              }
            >
              <Stack fill vertical>
                <Stack.Item>
                  <ByondUi
                    height="170px"
                    params={{
                      id: mech_view,
                      zoom: 5,
                      type: 'map',
                    }}
                  />
                </Stack.Item>
                <Stack.Item>
                  <LabeledList>
                    <IntegrityBar />
                    <PowerBar />
                    <LightsBar />
                    <CabinSeal />
                    <DNALock />
                    <LabeledList.Item label="ID 锁">
                      <Button
                        icon={id_lock ? 'lock' : 'lock-open'}
                        content={id_lock ? '已启用' : '已禁用'}
                        tooltipPosition="top"
                        onClick={() => {
                          editAccess(false);
                          act('toggle_id_lock');
                        }}
                        selected={id_lock}
                      />
                      {!!id_lock && (
                        <>
                          <Button
                            tooltip="编辑权限"
                            tooltipPosition="top"
                            icon="id-card-o"
                            onClick={() => editAccess(!edit_access)}
                            selected={edit_access}
                          />
                          <Button
                            tooltip={one_access ? '满足任一权限' : '满足全部权限'}
                            tooltipPosition="top"
                            icon={one_access ? 'check' : 'check-double'}
                            onClick={() => act('one_access')}
                          />
                        </>
                      )}
                    </LabeledList.Item>
                  </LabeledList>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <AlertPane />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow={2}>
        {edit_access ? (
          <AccessConfig
            accesses={regions}
            selectedList={accesses}
            accessMod={(ref) =>
              act('set', {
                access: ref,
              })
            }
            grantAll={() => act('grant_all')}
            denyAll={() => act('clear_all')}
            grantDep={(ref) =>
              act('grant_region', {
                region: ref,
              })
            }
            denyDep={(ref) =>
              act('deny_region', {
                region: ref,
              })
            }
          />
        ) : (
          <ModulesPane />
        )}
      </Stack.Item>
    </Stack>
  );
};

const PowerBar = (props) => {
  const { act, data } = useBackend<MainData>();
  const { power_level, power_max } = data;
  return (
    <LabeledList.Item label="电量">
      <ProgressBar
        value={power_max ? power_level / power_max : 0}
        ranges={{
          good: [0.5, Infinity],
          average: [0.25, 0.5],
          bad: [-Infinity, 0.25],
        }}
        style={{
          textShadow: '1px 1px 0 black',
        }}
      >
        {power_max === null
          ? '缺少电池'
          : power_level === 1e31
            ? '无限'
            : `${formatSiUnit(power_level, 0, 'J')} / ${formatSiUnit(
                power_max,
                0,
                'J',
              )}`}
      </ProgressBar>
    </LabeledList.Item>
  );
};

const IntegrityBar = (props) => {
  const { act, data } = useBackend<MainData>();
  const { integrity, integrity_max, scanmod_rating } = data;
  return (
    <LabeledList.Item label="完整度">
      <ProgressBar
        value={scanmod_rating ? integrity / integrity_max : 0}
        ranges={{
          good: [0.5, Infinity],
          average: [0.25, 0.5],
          bad: [-Infinity, 0.25],
        }}
        style={{
          textShadow: '1px 1px 0 black',
        }}
      >
        {!scanmod_rating ? '未知' : `${integrity} / ${integrity_max}`}
      </ProgressBar>
    </LabeledList.Item>
  );
};

const LightsBar = (props) => {
  const { act, data } = useBackend<MainData>();
  const { power_level, power_max, mecha_flags, mechflag_keys } = data;
  const has_lights = mecha_flags & mechflag_keys.HAS_LIGHTS;
  const lights_on = mecha_flags & mechflag_keys.LIGHTS_ON;
  return (
    <LabeledList.Item label="照明">
      <Button
        icon="lightbulb"
        content={lights_on ? '开启' : '关闭'}
        selected={lights_on}
        disabled={!has_lights || !power_max || !power_level}
        onClick={() => act('toggle_lights')}
      />
    </LabeledList.Item>
  );
};

const CabinSeal = (props) => {
  const { act, data } = useBackend<MainData>();
  const {
    enclosed,
    cabin_sealed,
    cabin_temp,
    cabin_pressure,
    cabin_pressure_warning_min,
    cabin_pressure_hazard_min,
    cabin_pressure_warning_max,
    cabin_pressure_hazard_max,
    cabin_temp_warning_min,
    cabin_temp_hazard_min,
    cabin_temp_warning_max,
    cabin_temp_hazard_max,
  } = data;
  const temp_warning =
    cabin_temp < cabin_temp_warning_min || cabin_temp > cabin_temp_warning_max;
  const temp_hazard =
    cabin_temp < cabin_temp_hazard_min || cabin_temp > cabin_temp_hazard_max;
  const pressure_warning =
    cabin_pressure < cabin_pressure_warning_min ||
    cabin_pressure > cabin_pressure_warning_max;
  const pressure_hazard =
    cabin_pressure < cabin_pressure_hazard_min ||
    cabin_pressure > cabin_pressure_hazard_max;
  return (
    <LabeledList.Item
      label="舱内空气"
      buttons={
        !!cabin_sealed && (
          <>
            <Button
              color={
                temp_hazard
                  ? 'danger'
                  : temp_warning
                    ? 'average'
                    : 'transparent'
              }
              icon="temperature-low"
              tooltipPosition="top"
              tooltip={`空气温度：${cabin_temp}°C`}
            />
            <Button
              color={
                pressure_hazard
                  ? 'danger'
                  : pressure_warning
                    ? 'average'
                    : 'transparent'
              }
              icon="gauge-high"
              tooltipPosition="top"
              tooltip={`空气压力：${cabin_pressure} kPa`}
            />
          </>
        )
      }
    >
      <Button
        icon={cabin_sealed ? 'mask-ventilator' : 'wind'}
        content={cabin_sealed ? '已密封' : '开放'}
        disabled={!enclosed}
        onClick={() => act('toggle_cabin_seal')}
        selected={cabin_sealed}
      />
    </LabeledList.Item>
  );
};

const DNALock = (props) => {
  const { act, data } = useBackend<MainData>();
  const { dna_lock } = data;
  return (
    <LabeledList.Item label="DNA 锁">
      <Button
        onClick={() => act('dna_lock')}
        icon="syringe"
        content={dna_lock ? '已启用' : '未设置'}
        tooltip="设置新的 DNA 密钥"
        selected={!!dna_lock}
        tooltipPosition="top"
      />
      {!!dna_lock && (
        <>
          <Button
            icon="key"
            tooltip={`密钥酶：${dna_lock}`}
            tooltipPosition="top"
            disabled={!dna_lock}
          />
          <Button
            onClick={() => act('reset_dna')}
            icon="ban"
            tooltip="重置 DNA 锁"
            tooltipPosition="top"
            disabled={!dna_lock}
          />
        </>
      )}
    </LabeledList.Item>
  );
};
