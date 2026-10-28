import { Box, Button, Divider, Section, Stack } from 'tgui-core/components';
import { useBackend } from '../../backend';
import { PointLocked } from './Locked';
import type { SpellbookData } from './types';

export function Loadouts(props) {
  const { data } = useBackend<SpellbookData>();
  const { points } = data;
  // Future todo : Make these datums on the DM side
  return (
    <Stack ml={0.5} mt={-0.5} vertical fill>
      {points < 10 && <PointLocked />}
      <Stack.Item>
        <Stack fill>
          <SingleLoadout
            loadoutId="loadout_classic"
            loadoutColor="purple"
            name="经典巫师"
            icon="fire"
            author="大法师院长格雷"
            blurb="
                这是在 2550 年代
                风靡一时的经典巫师配装，包含火球术、魔法飞弹、
                天罚和以太漫步。它最大的特点是
                每一项能力都非常容易上手使用。
              "
          />
          <SingleLoadout
            name="妙尔尼尔之力"
            icon="hammer"
            loadoutId="loadout_hammer"
            loadoutColor="green"
            author="撼世者耶古迪尔"
            blurb="
                感受强大妙尔尼尔的力量！最好别把它弄丢了。
                此配装包含召唤物品、变异、闪烁、力场墙、
                特斯拉冲击和妙尔尼尔。其中变异是你的实用工具：
                提供有限的远程火力，也能在闪烁失误后帮助脱困。
              "
          />
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <SingleLoadout
            name="奇幻大军"
            icon="pastafarianism"
            loadoutId="loadout_army"
            loadoutColor="yellow"
            author="咒石普洛斯佩罗"
            blurb="
                有人乐意代劳，又何必亲自动手？
                带上灵魂石碎片、变化法杖、死灵之石、
                传送和以太漫步，拥抱混沌！注意，此配装没有攻击法术！
             "
          />
          <SingleLoadout
            name="汲魂者"
            icon="skull"
            loadoutId="loadout_tap"
            loadoutColor="white"
            author="空虚者汤姆"
            blurb="
                拥抱黑暗，汲取自己的灵魂。
                你可以使用心智交换进入新的身体，
                再次施展汲魂，为天罚等
                冷却时间很长的法术重新充能。
              "
          />
        </Stack>
      </Stack.Item>
    </Stack>
  );
}

type Props = {
  author: string;
  blurb: string;
  icon: string;
  loadoutColor: string;
  loadoutId: string;
  name: string;
};

function SingleLoadout(props: Props) {
  const { act } = useBackend();
  const { author, name, blurb, icon, loadoutId, loadoutColor } = props;

  return (
    <Stack.Item grow>
      <Section width={19.17} title={name}>
        {blurb}
        <Divider />
        <Button.Confirm
          confirmContent="确认购买？"
          confirmIcon="dollar-sign"
          confirmColor="good"
          fluid
          icon={icon}
          onClick={() =>
            act('purchase_loadout', {
              id: loadoutId,
            })
          }
        >
          购买配装
        </Button.Confirm>
        <Divider />
        <Box color={loadoutColor}>提供者：{author}。</Box>
      </Section>
    </Stack.Item>
  );
}
