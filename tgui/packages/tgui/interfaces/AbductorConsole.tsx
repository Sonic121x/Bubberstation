import {
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Tabs,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';
import { GenericUplink, type Item } from './Uplink/GenericUplink';

type AbductorConsoleData = {
  categories: { name: string; items: ConsoleItem[] }[];

  compactMode: BooleanLike;
  experiment: BooleanLike;
  points?: number;
  credits?: number;
  pad: BooleanLike;
  gizmo: BooleanLike;
  vest: BooleanLike;
  vest_mode?: number;
  vest_lock?: BooleanLike;
};

type ConsoleItem = {
  name: string;
  cost: number;
  desc: string;
  icon: string;
  icon_state: string;
};

export const AbductorConsole = (props) => {
  const [tab, setTab] = useSharedState('tab', 1);

  return (
    <Window theme="abductor" width={600} height={532}>
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 1}
            onClick={() => setTab(1)}
          >
            绑架软件 3000
          </Tabs.Tab>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 2}
            onClick={() => setTab(2)}
          >
            任务设置
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && <Abductsoft />}
        {tab === 2 && (
          <>
            <EmergencyTeleporter />
            <VestSettings />
          </>
        )}
      </Window.Content>
    </Window>
  );
};

const Abductsoft = (props) => {
  const { act, data } = useBackend<AbductorConsoleData>();
  const { experiment, points, credits, categories } = data;

  if (!experiment) {
    return <NoticeBox danger>未检测到实验机器</NoticeBox>;
  }

  const categoriesList: string[] = [];
  const items: Item[] = [];
  for (let i = 0; i < categories.length; i++) {
    const category = categories[i];
    categoriesList.push(category.name);
    for (let itemIndex = 0; itemIndex < category.items.length; itemIndex++) {
      const item = category.items[itemIndex];
      items.push({
        id: item.name,
        name: item.name,
        category: category.name,
        cost: `${item.cost} 信用点`,
        desc: item.desc,
        disabled: (credits || 0) < item.cost,
        icon: item.icon,
        icon_state: item.icon_state,
        population_tooltip: '',
        insufficient_population: false,
      });
    }
  }

  return (
    <>
      <Section>
        <LabeledList>
          <LabeledList.Item label="已收集样本">
            {points}
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <GenericUplink
        currency={`${credits} 信用点`}
        categories={categoriesList}
        items={items}
        handleBuy={(item) => act('buy', { name: item.name })}
      />
    </>
  );
};

const EmergencyTeleporter = (props) => {
  const { act, data } = useBackend<AbductorConsoleData>();
  const { pad, gizmo } = data;

  if (!pad) {
    return <NoticeBox danger>未检测到传送台</NoticeBox>;
  }

  return (
    <Section
      title="紧急传送"
      buttons={
        <Button
          icon="exclamation-circle"
          content="启动"
          color="bad"
          onClick={() => act('teleporter_send')}
        />
      }
    >
      <LabeledList>
        <LabeledList.Item label="回收标记目标">
          <Button
            icon={gizmo ? 'user-plus' : 'user-slash'}
            disabled={!gizmo}
            onClick={() => act('teleporter_retrieve')}
          >
            {gizmo ? '回收' : '无标记'}
          </Button>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const VestSettings = (props) => {
  const { act, data } = useBackend<AbductorConsoleData>();
  const { vest, vest_mode, vest_lock } = data;

  if (!vest) {
    return <NoticeBox danger>未检测到特工背心</NoticeBox>;
  }

  return (
    <Section
      title="特工背心设置"
      buttons={
        <Button
          icon={vest_lock ? 'lock' : 'unlock'}
          onClick={() => act('toggle_vest')}
        >
          {vest_lock ? '已锁定' : '已解锁'}
        </Button>
      }
    >
      <LabeledList>
        <LabeledList.Item label="模式">
          <Button
            icon={vest_mode === 1 ? 'eye-slash' : 'fist-raised'}
            onClick={() => act('flip_vest')}
          >
            {vest_mode === 1 ? '潜行' : '战斗'}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="伪装">
          <Button icon="user-secret" onClick={() => act('select_disguise')}>
            选择
          </Button>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
