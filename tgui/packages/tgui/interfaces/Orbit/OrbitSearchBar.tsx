import { useContext } from 'react';
import { Button, Icon, Input, Section, Stack } from 'tgui-core/components';
import { orbitDisplay } from '../../localization/zhOrbitDisplay';
import { useBackend } from '../../backend';
import { OrbitContext } from '.';
import { VIEWMODE } from './constants';
import { isJobCkeyOrNameMatch, sortByOrbiters } from './helpers';
import type { OrbitData } from './types';

/** Search bar for the orbit ui. Has a few buttons to switch between view modes and auto-observe */
export function OrbitSearchBar(props) {
  const {
    autoObserve,
    bladeOpen,
    realNameDisplay,
    searchQuery,
    viewMode,
    setAutoObserve,
    setBladeOpen,
    setRealNameDisplay,
    setSearchQuery,
    setViewMode,
  } = useContext(OrbitContext);

  const { act, data } = useBackend<OrbitData>();

  /** Gets a list of Observables, then filters the most relevant to orbit */
  function orbitMostRelevant() {
    const mostRelevant = [
      data.alive,
      data.antagonists,
      data.critical,
      data.deadchat_controlled,
      data.dead,
      data.ghosts,
      data.misc,
      data.npcs,
    ]
      .flat()
      .filter((observable) => isJobCkeyOrNameMatch(observable, searchQuery))
      .sort(sortByOrbiters)[0];

    if (mostRelevant !== undefined) {
      act('orbit', {
        ref: mostRelevant.ref,
        auto_observe: autoObserve,
      });
    }
  }

  /** Iterates through the view modes and switches to the next one */
  function swapViewMode() {
    const thisIndex = Object.values(VIEWMODE).indexOf(viewMode);
    const nextIndex = (thisIndex + 1) % Object.values(VIEWMODE).length;

    setViewMode(Object.values(VIEWMODE)[nextIndex]);
  }

  const viewModeTitle = Object.entries(VIEWMODE).find(
    ([_key, value]) => value === viewMode,
  )?.[0];

  return (
    <Section>
      <Stack>
        <Stack.Item>
          <Icon name="search" />
        </Stack.Item>
        <Stack.Item grow>
          <Input
            autoFocus
            fluid
            onEnter={orbitMostRelevant}
            onChange={setSearchQuery}
            placeholder="搜索……"
            value={searchQuery}
            expensive
          />
        </Stack.Item>
        <Stack.Divider />
        <Stack.Item>
          <Button
            color="transparent"
            icon={viewMode}
            onClick={swapViewMode}
            tooltip={`配色方案：${orbitDisplay(viewModeTitle ?? '')}`}
            tooltipPosition="bottom-start"
          />
        </Stack.Item>
        {!!data.can_observe && (
          <Stack.Item>
            <Button
              color={autoObserve ? 'good' : 'transparent'}
              icon={autoObserve ? 'toggle-on' : 'toggle-off'}
              onClick={() => setAutoObserve(!autoObserve)}
              tooltip={`切换自动观察。启用后，你将能
            看到所跟随对象的界面及完整物品栏。真方便！`}
              tooltipPosition="bottom-start"
            />
          </Stack.Item>
        )}
        <Stack.Item>
          <Button
            color="transparent"
            icon="sync-alt"
            onClick={() => act('refresh')}
            tooltip="刷新"
            tooltipPosition="bottom-start"
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            color="transparent"
            icon="passport"
            onClick={() => setRealNameDisplay(!realNameDisplay)}
            selected={realNameDisplay}
            tooltip="切换真实姓名显示。启用后，跟随菜单将显示
            真实姓名，不显示伪装身份。"
            tooltipPosition="bottom-start"
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            color="transparent"
            icon="sliders-h"
            onClick={() => setBladeOpen(!bladeOpen)}
            selected={bladeOpen}
            tooltip="切换设置侧栏"
            tooltipPosition="left-end"
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
}
