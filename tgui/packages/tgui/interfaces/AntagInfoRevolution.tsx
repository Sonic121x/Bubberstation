import { useEffect, useState } from 'react';
import { Input, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../backend';
import { Window } from '../layouts';
import type { Objective } from './common/Objectives';

type Head = {
  name: string;
  role: string;
};

type Info = {
  antag_name: string;
  objectives: Objective[];
  leader: BooleanLike;
  code_phrases?: string[];
  code_responses?: string[];
  heads: Head[];
  lone_wolf: BooleanLike;
  conversion_objective?: string | null;
  conversion_objective_max_length: number;
};

// Takes [a, b, c] and returns "a, b, and c"
function formatCodes(text: string[]) {
  if (text.length === 0) return '';
  if (text.length === 1) return text[0];
  if (text.length === 2) return `${text[0]}和${text[1]}`;
  return `${text.slice(0, -1).join('、')}和${text[text.length - 1]}`;
}

// These are just placeholders they don't actually get passed to the player
function randomObjectivePlaceholderText() {
  if (Math.random() <= 0.01) {
    const joke_objectives = [
      '在不伤害部门主管的前提下，尽可能惹恼他们。',
      '伪装成部门主管，迷惑船员。',
      '创作革命艺术，用它涂遍空间站。',
      '大量制作抗议标语牌，举着它们在站内示威。',
      '建立一个崇拜无产阶级的教派。',
    ];
    return joke_objectives[Math.floor(Math.random() * joke_objectives.length)];
  }

  const objectives = [
    '破坏空间站的电网。',
    '偷走人事主管的宠物狗。',
    '让安保部队转而反对安保主管。',
    '浪费空间站的资金和资源。',
    '用炸弹炸死科研主管。',
    '贿赂军需官，让其自我放逐。',
    '抓住安装了心智护盾的人，并通过手术取出护盾。',
    '组建机甲大军，向舰桥进军。',
    '切断禁闭区的空气供应。',
    '为领袖配备你能找到的最好装备。',
    '找到剩余的部门主管并消灭他们。',
    '尽可能紧跟领袖。',
    '收集武器和护甲。',
    '轰轰烈烈地战斗到底。',
    '保持低调，直到人数足够发动进攻。',
    '占领并坚守舰桥，直到部门主管投降。',
    '不惜一切代价保护领袖，哪怕牺牲自己。',
    '在舰桥前抗议。',
    '从禁闭区救出其他革命者。',
    '冲向船长，抢走他的帽子。',
    '颠覆 AI，让它背叛部门主管。',
    '挟持首席医疗官。',
    '把总工程师扔进超物质。',
    '诱骗部门主管自我放逐。',
    '等待紧急穿梭机到来，然后趁乱出击。',
  ];
  return objectives[Math.floor(Math.random() * objectives.length)];
}

export const AntagInfoRevolution = () => {
  const { act, data } = useBackend<Info>();
  const {
    leader,
    code_phrases,
    code_responses,
    heads,
    lone_wolf,
    conversion_objective,
    conversion_objective_max_length,
  } = data;

  const [objectivePlaceholder, setObjectivePlaceholder] = useState(
    randomObjectivePlaceholderText(),
  );

  useEffect(() => {
    if (!leader) return;
    const interval = setInterval(() => {
      setObjectivePlaceholder(randomObjectivePlaceholderText());
    }, 30000);
    return () => clearInterval(interval);
  }, []);

  return (
    <Window width={400} height={leader ? 500 : 400}>
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item textColor="red" fontSize="24px" textAlign="center">
              革命万岁！
            </Stack.Item>
            <Stack.Item>
              {leader ? (
                <Stack vertical>
                  {lone_wolf ? (
                    <Stack.Item>
                      - 你是革命唯一的领袖。建议
                      迅速果断地行动；当革命队伍
                      足够壮大时，将会提拔
                      更多领袖。
                    </Stack.Item>
                  ) : (
                    <Stack.Item>
                      - 革命有多名领袖。建议
                      在开始转化船员之前，先合作制定
                      计划；过早暴露身份
                      可能造成极大不利。
                    </Stack.Item>
                  )}
                  <Stack.Item>
                    - 使用闪光器让船员投身你的事业；任何闪光器
                    都可以。
                  </Stack.Item>
                  <Stack.Item>
                    - 思维护盾会阻止转化。你可以通过目标职位图标
                    周围闪烁的蓝色边框辨认。
                  </Stack.Item>
                  <Stack.Item>
                    - 如果你和其他领袖全被杀死或流放，
                    革命就会失败。不要让这种事发生！
                  </Stack.Item>
                </Stack>
              ) : (
                <Stack vertical>
                  <Stack.Item>
                    - 为革命事业出力。不要伤害一同争取自由的同志。
                  </Stack.Item>
                  <Stack.Item>
                    - 你可以通过红色“R”图标识别同志，
                    通过蓝色“R”图标识别领袖。
                  </Stack.Item>
                  <Stack.Item>
                    - 如果所有领袖都被杀死或流放，
                    革命就会失败。不要让这种事发生！
                  </Stack.Item>
                </Stack>
              )}
            </Stack.Item>
            {heads.length > 0 && (
              <>
                <Stack.Divider />
                <Stack.Item>
                  <Stack vertical>
                    <Stack.Item fontSize="16px" textAlign="center">
                      你必须杀死或流放部门主管：
                    </Stack.Item>
                    {heads.map((head, i) => (
                      <Stack.Item key={`head-${i}`}>
                        - {head.name}，{head.role}
                      </Stack.Item>
                    ))}
                  </Stack>
                </Stack.Item>
              </>
            )}
            {!!leader && (
              <>
                {!!code_phrases?.length && !!code_responses?.length && (
                  <>
                    <Stack.Divider />
                    <Stack.Item>
                      <Stack vertical>
                        <Stack.Item italic>
                          若要识别其他革命领袖，请使用以下
                          暗号：
                        </Stack.Item>
                        <Stack.Item textColor="blue">
                          暗号词：{formatCodes(code_phrases)}
                        </Stack.Item>
                        <Stack.Item textColor="red">
                          暗号回应：{formatCodes(code_responses)}
                        </Stack.Item>
                      </Stack>
                    </Stack.Item>
                    <Stack.Divider />
                  </>
                )}
                <Stack.Divider />
                <Stack.Item>
                  <Stack vertical>
                    <Stack.Item italic>
                      设置转化指引：此文本仅向
                      新转化的革命者显示。
                    </Stack.Item>
                    <Stack.Item>
                      <Input
                        placeholder={`例如：${objectivePlaceholder}`}
                        fluid
                        maxLength={conversion_objective_max_length}
                        value={conversion_objective ?? ''}
                        onEnter={(value) =>
                          act('set_conversion_objective', {
                            conversion_objective: value,
                          })
                        }
                      />
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
              </>
            )}
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
