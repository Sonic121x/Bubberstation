import { useState } from 'react';
import {
  BlockQuote,
  Button,
  Dropdown,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const weaponlist = [
  '徒手搏斗',
  '仪式武器',
  '仅限近战',
  '任意武器',
];

const stakelist = ['无赌注', '神圣对决', '金钱对决', '你的灵魂'];

const weaponblurb = [
  '只能徒手战斗。使用任何武器都算违规。',
  '只能使用仪式武器战斗。没有武器会让你处于极大劣势！',
  '可以使用近战武器，没有武器也可以徒手。使用远程武器算违规。',
  '可以随意使用任何武器。尽量别杀死对方，好吗？',
];

const stakesblurb = [
  "没有赌注，纯粹娱乐。谁不喜欢轻松切磋一下呢？",
  "献给牧师所信奉神祇的对决。牧师战败会付出沉重代价，获胜则能壮大教派。",
  '以金钱为赌注的对决。胜者获得败者的全部金钱。',
  "生死对决，败者的灵魂将归胜者所有。",
];

type Info = {
  set_weapon: number;
  set_area: string;
  set_stakes: number;
  left_sign: string;
  right_sign: string;
  in_area: BooleanLike;
  no_chaplains: BooleanLike;
  stakes_holy_match: number;
  possible_areas: Array<string>;
};

export const SparringContract = (props) => {
  const { data, act } = useBackend<Info>();
  const {
    set_weapon,
    set_area,
    set_stakes,
    possible_areas,
    left_sign,
    right_sign,
    in_area,
    no_chaplains,
    stakes_holy_match,
  } = data;
  const [weapon, setWeapon] = useState(set_weapon);
  const [area, setArea] = useState(set_area);
  const [stakes, setStakes] = useState(set_stakes);

  return (
    <Window width={420} height={380}>
      <Window.Content>
        <Section fill>
          <Stack vertical fill>
            <Stack.Item>
              <Stack vertical>
                <Stack.Item>
                  <Stack fill>
                    <Stack.Item grow fontSize="16px">
                      武器：
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        tooltip={`
                        牧师的神祇希望战斗光明正大，
                        因此要求签订契约。签下姓名
                        即表示确定这场战斗的条款。
                        随后，你的切磋对象必须在另一侧签字。
                        如果已签署的契约条款发生变化，
                        所有签名都会被清除，双方必须
                        重新同意新的条款。
                        `}
                        icon="info"
                      >
                        契约说明
                      </Button>
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
                <Stack.Item>
                  <Dropdown
                    width="100%"
                    selected={weaponlist[weapon - 1]}
                    options={weaponlist}
                    onSelected={(value) =>
                      setWeapon(weaponlist.indexOf(value) + 1)
                    }
                  />
                </Stack.Item>
                <Stack.Item>
                  <BlockQuote>{weaponblurb[weapon - 1]}</BlockQuote>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <Stack vertical>
                <Stack.Item fontSize="16px">场地：</Stack.Item>
                <Stack.Item>
                  <Dropdown
                    width="100%"
                    selected={area}
                    options={possible_areas}
                    onSelected={(value) => setArea(value)}
                  />
                </Stack.Item>
                <Stack.Item>
                  <BlockQuote>
                    战斗将在{area}进行。
                    战斗中途离开场地属于违规。
                  </BlockQuote>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <Stack vertical>
                <Stack.Item fontSize="16px">赌注：</Stack.Item>
                <Stack.Item>
                  <Dropdown
                    width="100%"
                    selected={stakelist[stakes - 1]}
                    options={stakelist}
                    onSelected={(value) =>
                      setStakes(stakelist.indexOf(value) + 1)
                    }
                  />
                </Stack.Item>
                <Stack.Item>
                  <BlockQuote>{stakesblurb[stakes - 1]}</BlockQuote>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item grow>
              <Stack textAlign="center">
                <Stack.Item fontSize={left_sign !== 'none' && '14px'} grow>
                  {(left_sign === 'none' && (
                    <Button
                      icon="pen"
                      onClick={() =>
                        act('sign', {
                          weapon: weapon,
                          area: area,
                          stakes: stakes,
                          sign_position: 'left',
                        })
                      }
                    >
                      在此签名
                    </Button>
                  )) ||
                    left_sign}
                </Stack.Item>
                <Stack.Item fontSize="16px">对阵</Stack.Item>
                <Stack.Item fontSize={right_sign !== 'none' && '14px'} grow>
                  {(right_sign === 'none' && (
                    <Button
                      icon="pen"
                      onClick={() =>
                        act('sign', {
                          weapon: weapon,
                          area: area,
                          stakes: stakes,
                        })
                      }
                    >
                      在此签名
                    </Button>
                  )) ||
                    right_sign}
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item mb={-0.5}>
              <Stack fill>
                <Stack.Item grow>
                  <Button
                    disabled={
                      !in_area ||
                      (no_chaplains && set_stakes === stakes_holy_match)
                    }
                    icon="fist-raised"
                    onClick={() => act('fight')}
                  >
                    开战！
                  </Button>
                  <Button
                    tooltip={`
                      如果已经签字但想重新协商
                      条款，可以使用此按钮
                      清除所有签名。
                    `}
                    icon="door-open"
                    onClick={() => act('clear')}
                  >
                    清除
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    tooltip={
                      (in_area &&
                        `双方均已到达${area}。`) ||
                      '双方都必须位于场地内！'
                    }
                    color={(in_area && 'green') || 'red'}
                    icon="ring"
                  >
                    场地
                  </Button>
                  <Button
                    tooltip={
                      (left_sign !== 'none' &&
                        right_sign !== 'none' &&
                        '双方均已签名并同意条款。') ||
                      '双方都必须签名同意条款！'
                    }
                    color={
                      (left_sign !== 'none' &&
                        right_sign !== 'none' &&
                        'green') ||
                      'red'
                    }
                    icon="file-signature"
                  >
                    签名
                  </Button>
                  <Button
                    tooltip={
                      (!no_chaplains &&
                        '至少有一名牧师在场，允许进行神圣对决。') ||
                      '这场战斗没有牧师参与，无法进行神圣对决！'
                    }
                    color={(!no_chaplains && 'green') || 'yellow'}
                    icon="cross"
                  >
                    牧师
                  </Button>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
