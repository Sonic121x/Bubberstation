import { Section, Stack } from 'tgui-core/components';
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
};

// Takes [a, b, c] and returns "a, b, and c"
function formatCodes(text: string[]) {
  if (text.length === 0) return '';
  if (text.length === 1) return text[0];
  if (text.length === 2) return `${text[0]}和${text[1]}`;
  return `${text.slice(0, -1).join('、')}和${text[text.length - 1]}`;
}

export const AntagInfoRevolution = () => {
  const { data } = useBackend<Info>();
  const { leader, code_phrases, code_responses, heads, lone_wolf } = data;
  return (
    <Window width={400} height={400}>
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
            {code_phrases?.length && code_responses?.length && (
              <>
                <Stack.Divider />
                <Stack.Item>
                  <Stack vertical>
                    <Stack.Item italic>
                      使用以下暗号识别其他革命领袖：
                    </Stack.Item>
                    <Stack.Item textColor="blue">
                      暗号词：{formatCodes(code_phrases)}
                    </Stack.Item>
                    <Stack.Item textColor="red">
                      暗号回应：{formatCodes(code_responses)}
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
