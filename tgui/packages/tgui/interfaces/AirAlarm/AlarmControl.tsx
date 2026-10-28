import { useState } from 'react';
import { Button, Section } from 'tgui-core/components';

import { AirAlarmControlHome } from './screens/Home';
import { AirAlarmControlModes } from './screens/Modes';
import { AirAlarmControlScrubbers } from './screens/Scrubbers';
import { AirAlarmControlThresholds } from './screens/Thresholds';
import { AirAlarmControlVents } from './screens/Vents';
import type { AlarmScreen } from './types';

export const AIR_ALARM_ROUTES = {
  home: {
    title: '空气控制',
    component: AirAlarmControlHome,
  },
  vents: {
    title: '通风口控制',
    component: AirAlarmControlVents,
  },
  scrubbers: {
    title: '洗气器控制',
    component: AirAlarmControlScrubbers,
  },
  modes: {
    title: '运行模式',
    component: AirAlarmControlModes,
  },
  thresholds: {
    title: '报警阈值',
    component: AirAlarmControlThresholds,
  },
} as const;

export function AirAlarmControl(props) {
  const [screen, setScreen] = useState<AlarmScreen>('home');

  const route = AIR_ALARM_ROUTES[screen] || AIR_ALARM_ROUTES.home;
  const Component = route.component;
  const isHome = route === AIR_ALARM_ROUTES.home;

  return (
    <Section
      fill
      scrollable
      title={route.title}
      buttons={
        <Button
          icon="arrow-left"
          onClick={() => setScreen('home')}
          disabled={isHome}
        >
          返回
        </Button>
      }
    >
      <Component {...(isHome && { setScreen })} />
    </Section>
  );
}
