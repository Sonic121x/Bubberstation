import { Box, Icon, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  help_text: string;
};

const DEFAULT_HELP = `没有可用信息！如有需要，请寻求帮助。`;

const boxHelp = [
  {
    color: 'purple',
    text: '调查此区域，完成必要任务以取回货箱。密切留意虚拟域信息和环境线索。',
    icon: 'search-location',
    title: '搜寻',
  },
  {
    color: 'green',
    text: '将货箱带到安全屋内指定的传送位置。那里可能显得格格不入。检查安全屋以找到它。',
    icon: 'boxes',
    title: '回收',
  },
  {
    color: 'blue',
    text: '在回收数据缓存前，梯子是最安全的断开连接方式。如果连接中断，网络舱只能提供有限的复苏机会。',
    icon: 'plug',
    title: '断开连接',
  },
  {
    color: 'yellow',
    text: '连接期间，你能在一定程度上免受环境危害和外来侵扰，但并非绝对安全。密切留意警报。',
    icon: 'id-badge',
    title: '安全',
  },
  {
    color: 'gold',
    text: '生成化身需要消耗大量带宽。不要浪费。',
    icon: 'coins',
    title: '尝试次数有限',
  },
  {
    color: 'red',
    text: '记住，你的肉体与此化身相连。你是敌对环境中的异物，它会试图强行将你驱逐。',
    icon: 'skull-crossbones',
    title: '现实危险',
  },
] as const;

export const AvatarHelp = (props) => {
  const { data } = useBackend<Data>();
  const { help_text = DEFAULT_HELP } = data;

  return (
    <Window title="虚拟域信息" width={600} height={600}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item grow>
            <Section
              color="good"
              fill
              scrollable
              title="欢迎来到虚拟域。"
            >
              {help_text}
            </Section>
          </Stack.Item>
          <Stack.Item grow={4}>
            <Stack fill vertical>
              <Stack.Item grow>
                <Stack fill>
                  {[0, 1].map((i) => (
                    <BoxHelp index={i} key={i} />
                  ))}
                </Stack>
              </Stack.Item>
              <Stack.Item grow>
                <Stack fill>
                  {[2, 3].map((i) => (
                    <BoxHelp index={i} key={i} />
                  ))}
                </Stack>
              </Stack.Item>
              <Stack.Item grow>
                <Stack fill>
                  {[4, 5].map((i) => (
                    <BoxHelp index={i} key={i} />
                  ))}
                </Stack>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

// I wish I had media queries
const BoxHelp = (props: { index: number }) => {
  const { index } = props;

  return (
    <Stack.Item grow>
      <Section
        color="label"
        fill
        minHeight={10}
        title={
          <Stack align="center">
            <Icon
              color={boxHelp[index].color}
              mr={1}
              name={boxHelp[index].icon}
            />
            <Box>{boxHelp[index].title}</Box>
          </Stack>
        }
      >
        {boxHelp[index].text}
      </Section>
    </Stack.Item>
  );
};
