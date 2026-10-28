import {
  AnimatedNumber,
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import { round } from 'tgui-core/math';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { type Beaker, BeakerSectionDisplay } from './common/BeakerDisplay';

const damageTypes = [
  {
    label: '蛮力伤害',
    type: 'bruteLoss',
  },
  {
    label: '窒息伤害',
    type: 'oxyLoss',
  },
  {
    label: '毒素伤害',
    type: 'toxLoss',
  },
  {
    label: '烧伤',
    type: 'fireLoss',
  },
] as const;

const stat_to_color = {
  Dead: 'bad',
  Conscious: 'bad',
  Unconscious: 'good',
} as const;

type Occupant = {
  name: string;
  stat: string;
  bodyTemperature: number;
  health: number;
  maxHealth: number;
  bruteLoss: number;
  oxyLoss: number;
  toxLoss: number;
  fireLoss: number;
};

type Data = {
  isOperating: BooleanLike;
  isOpen: BooleanLike;
  autoEject: BooleanLike;
  occupant: Occupant;
  T0C: number;
  cellTemperature: number;
  beaker: Beaker;
};

export const Cryo = () => {
  const { act, data } = useBackend<Data>();
  const { occupant, isOperating, isOpen } = data;

  return (
    <Window width={400} height={550}>
      <Window.Content scrollable>
        <Section title="舱内人员">
          <LabeledList>
            <LabeledList.Item label="舱内人员">
              {occupant?.name || '无人'}
            </LabeledList.Item>
            {!!occupant && (
              <>
                <LabeledList.Item
                  label="状态"
                  color={stat_to_color[occupant.stat]}
                >
                  {{ Dead: '死亡', Conscious: '清醒', Unconscious: '昏迷' }[occupant.stat] || occupant.stat}
                </LabeledList.Item>
                <LabeledList.Item
                  label="体温"
                  color={occupant.bodyTemperature < data.T0C ? 'good' : 'bad'} // Green if the mob can actually be healed by cryoxadone.
                >
                  <AnimatedNumber value={round(occupant.bodyTemperature, 0)} />
                  {' K'}
                </LabeledList.Item>
                <LabeledList.Item label="健康">
                  <ProgressBar
                    value={round(occupant.health / occupant.maxHealth, 2)}
                    color={occupant.health > 0 ? 'good' : 'average'}
                  >
                    <AnimatedNumber value={round(occupant.health, 0)} />
                  </ProgressBar>
                </LabeledList.Item>
                {damageTypes.map((damageType) => (
                  <LabeledList.Item
                    key={damageType.type}
                    label={damageType.label}
                  >
                    <ProgressBar
                      value={round(data.occupant[damageType.type] / 100, 2)}
                    >
                      <AnimatedNumber
                        value={round(data.occupant[damageType.type], 0)}
                      />
                    </ProgressBar>
                  </LabeledList.Item>
                ))}
              </>
            )}
          </LabeledList>
        </Section>
        <Section title="舱室">
          <LabeledList>
            <LabeledList.Item label="电源">
              <Button
                icon={isOperating ? 'power-off' : 'times'}
                disabled={isOpen}
                onClick={() => act('power')}
                color={isOperating && 'green'}
              >
                {isOperating ? '开启' : '关闭'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="温度">
              <AnimatedNumber value={round(data.cellTemperature, 0)} /> K
            </LabeledList.Item>
            <LabeledList.Item label="舱门">
              <Button
                icon={isOpen ? 'unlock' : 'lock'}
                onClick={() => act('door')}
              >
                {isOpen ? '打开' : '关闭'}
              </Button>
              <Button
                icon={data.autoEject ? 'sign-out-alt' : 'sign-in-alt'}
                onClick={() => act('autoeject')}
              >
                {data.autoEject ? '自动' : '手动'}
              </Button>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <BeakerSectionDisplay beaker={data.beaker} showpH={false} />
      </Window.Content>
    </Window>
  );
};
