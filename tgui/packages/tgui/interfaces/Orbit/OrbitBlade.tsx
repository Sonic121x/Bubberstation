import { useContext } from 'react';
import {
  Button,
  Icon,
  ProgressBar,
  Section,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import { toTitleCase } from 'tgui-core/string';
import { orbitDisplay } from '../../localization/zhOrbitDisplay';
import { useBackend } from '../../backend';
import { OrbitContext } from '.';
import { HEALTH, VIEWMODE } from './constants';
import { getDepartmentByJob, getDisplayName } from './helpers';
import { JobIcon } from './JobIcon';
import type { OrbitData } from './types';

/** Slide open menu with more info about the current observable */
export function OrbitBlade(props) {
  const { data } = useBackend<OrbitData>();
  const { orbiting } = data;

  const { setBladeOpen, realNameDisplay, setRealNameDisplay } =
    useContext(OrbitContext);

  return (
    <Stack vertical width="244px">
      <Stack.Item>
        <Section
          buttons={
            <Button
              color="bad"
              icon="times"
              onClick={() => setBladeOpen(false)}
            />
          }
          color="label"
          title="跟随设置"
        >
          请注意：跟随菜单不会自动更新。你需要
          点击“刷新”按钮查看最新数据。
        </Section>
      </Stack.Item>
      <Stack.Item>
        <ViewModeSelector />
      </Stack.Item>
      <Stack.Item>
        <Section
          buttons={
            <Button
              color="transparent"
              icon="passport"
              selected={realNameDisplay}
              onClick={() => setRealNameDisplay(!realNameDisplay)}
            />
          }
          color="label"
          title="显示真实姓名"
        >
          真实姓名模式显示角色的真实姓名和
          开局职业，不依据其佩戴的ID卡。如果角色
          没有开局职业，则仍显示其ID卡上的职业图标。
        </Section>
      </Stack.Item>
      {!!orbiting && (
        <Stack.Item>
          <OrbitInfo />
        </Stack.Item>
      )}
    </Stack>
  );
}

function ViewModeSelector(props) {
  const { viewMode, setViewMode } = useContext(OrbitContext);

  return (
    <Section title="视图模式">
      <Stack fill vertical>
        <Stack.Item color="label">
          修改可观察对象的配色和排序方式。
        </Stack.Item>

        {Object.entries(VIEWMODE).map(([key, value]) => (
          <Button
            align="center"
            color="transparent"
            fluid
            icon={value}
            key={key}
            onClick={() => setViewMode(value)}
            selected={value === viewMode}
          >
            {orbitDisplay(key)}
          </Button>
        ))}
      </Stack>
    </Section>
  );
}

function OrbitInfo(props) {
  const { data } = useBackend<OrbitData>();

  const { orbiting } = data;
  if (!orbiting) return;

  const { name, full_name, health, job } = orbiting;

  let department;
  if ('job' in orbiting && job) {
    department = getDepartmentByJob(job);
  }

  let showAFK;
  if ('client' in orbiting && !orbiting.client) {
    showAFK = true;
  }

  return (
    <Section title="正在跟随">
      <Stack fill vertical>
        <Stack.Item>
          {toTitleCase(getDisplayName(full_name, name))}
          {showAFK && (
            <Tooltip content="暂离键盘" position="bottom-start">
              <Icon ml={1} color="grey" name="bed" />
            </Tooltip>
          )}
        </Stack.Item>

        {!!job && (
          <Stack.Item>
            <Stack>
              <Stack.Item>
                <JobIcon item={orbiting} realNameDisplay={false} />
              </Stack.Item>
              <Stack.Item color="label" grow>
                {orbitDisplay(job)}
              </Stack.Item>
              {!!department && (
                <Stack.Item color="grey">
                  {orbitDisplay(department)}
                </Stack.Item>
              )}
            </Stack>
          </Stack.Item>
        )}
        {health !== undefined && (
          <Stack.Item>
            <HealthDisplay health={health} />
          </Stack.Item>
        )}

        <Stack.Item />
      </Stack>
    </Section>
  );
}

function HealthDisplay(props: { health: number }) {
  const { health } = props;

  let icon = 'heart';
  let howDead;
  switch (true) {
    case health <= HEALTH.Ruined:
      howDead = `死透了：${health}`;
      icon = 'skull';
      break;
    case health <= HEALTH.Dead:
      howDead = `死亡：${health}`;
      icon = 'heart-broken';
      break;
    case health <= HEALTH.Crit:
      howDead = `濒危：${health}`;
      icon = 'tired';
      break;
    case health <= HEALTH.Bad:
      howDead = `状态不佳：${health}`;
      icon = 'heartbeat';
      break;
  }

  return (
    <Stack align="center">
      <Stack.Item>
        <Icon color="grey" name={icon} />
      </Stack.Item>
      <Stack.Item color={howDead && 'bad'} grow>
        {howDead || (
          <ProgressBar
            maxValue={100}
            minValue={0}
            ranges={{
              good: [70, Infinity],
              average: [20, HEALTH.Good],
              bad: [0, HEALTH.Average],
            }}
            value={health}
          />
        )}
      </Stack.Item>
    </Stack>
  );
}
