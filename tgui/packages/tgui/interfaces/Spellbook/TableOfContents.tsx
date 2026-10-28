import { useAtom } from 'jotai';
import { Box, Button, Divider } from 'tgui-core/components';
import { tabAtom } from '.';
import { Tab } from './types';

export const lineHeightToc = '30.6px';

export function TableOfContents(props) {
  const [_tabIndex, setTabIndex] = useAtom(tabAtom);

  return (
    <Box textAlign="center">
      <Button lineHeight={lineHeightToc} fluid icon="pen" disabled>
        铭刻姓名
      </Button>

      <Button lineHeight={lineHeightToc} fluid icon="clipboard" disabled>
        目录
      </Button>

      <Divider />
      <Button
        lineHeight={lineHeightToc}
        fluid
        icon="fire"
        onClick={() => setTabIndex(Tab.Defensive)}
      >
        致命塑能术
      </Button>

      <Button
        lineHeight={lineHeightToc}
        fluid
        icon="shield-alt"
        onClick={() => setTabIndex(Tab.Defensive)}
      >
        防御塑能术
      </Button>
      <Divider />
      <Button
        lineHeight={lineHeightToc}
        fluid
        icon="globe-americas"
        onClick={() => setTabIndex(Tab.Assistance)}
      >
        魔法传送
      </Button>
      <Button
        lineHeight={lineHeightToc}
        fluid
        icon="users"
        onClick={() => setTabIndex(Tab.Assistance)}
      >
        援助与召唤
      </Button>
      <Divider />
      <Button
        lineHeight={lineHeightToc}
        fluid
        icon="crown"
        onClick={() => setTabIndex(Tab.Rituals)}
      >
        挑战
      </Button>
      <Button
        lineHeight={lineHeightToc}
        fluid
        icon="magic"
        onClick={() => setTabIndex(Tab.Rituals)}
      >
        仪式
      </Button>
      <Divider />
      <Button
        lineHeight={lineHeightToc}
        fluid
        icon="thumbs-up"
        onClick={() => setTabIndex(Tab.Randomize)}
      >
        巫师认可配装
      </Button>
      <Button
        lineHeight={lineHeightToc}
        fluid
        icon="dice"
        onClick={() => setTabIndex(Tab.Randomize)}
      >
        奥术随机配装
      </Button>
      <Divider />
      <Button
        lineHeight={lineHeightToc}
        fluid
        icon="cog"
        onClick={() => setTabIndex(Tab.TableOfContents2)}
      >
        特长
      </Button>
    </Box>
  );
}
