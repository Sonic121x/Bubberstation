import {
  Button,
  Collapsible,
  Divider,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  has_case: BooleanLike;
  has_implant: BooleanLike;
  case_information: string;
  case_lore: string;
  saved_deathrattle_group?: string;
  current_deathrattle_group?: string;
};

export const ImplantPad = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    has_case,
    has_implant,
    case_information,
    case_lore,
    saved_deathrattle_group,
    current_deathrattle_group,
  } = data;
  return (
    <Window width={300} height={350}>
      <Window.Content scrollable>
        <Stack bold>
          <Stack.Item grow color="good" align="center">
            植入物微型电脑
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="eject"
              disabled={!has_case}
              onClick={() => act('eject_implant')}
            >
              弹出收纳盒
            </Button>
          </Stack.Item>
        </Stack>
        <Divider />
        <Section>
          已保存的死亡通知组：{saved_deathrattle_group || '无'}
          <br />
          当前死亡通知组：{current_deathrattle_group || '无'}
        </Section>
        <Stack>
          <Stack.Item>
            <Button
              disabled={!current_deathrattle_group}
              onClick={() => act('save_deathrattle_group')}
            >
              保存分组
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button
              disabled={!!current_deathrattle_group || !has_case}
              onClick={() => act('set_deathrattle_group')}
            >
              设置分组
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button
              disabled={!!current_deathrattle_group || !has_case}
              // in case you want to start a new deathrattle group
              onClick={() => act('init_deathrattle_group')}
            >
              初始化分组
            </Button>
          </Stack.Item>
        </Stack>
        <Divider />
        <Collapsible open={true} title="植入物信息">
          {!has_case && (
            <Section>
              未检测到植入物收纳盒。请插入收纳盒以查看内容。
            </Section>
          )}
          {!!has_case && !has_implant && (
            <Section>
              收纳盒中没有植入物。请放入植入物
              以继续。
            </Section>
          )}
          {!!has_case && !!has_implant && <Section>{case_information}</Section>}
        </Collapsible>
        <Collapsible title="植入物详细信息">
          {!has_case && (
            <Section>
              未检测到植入物收纳盒。请插入收纳盒以查看内容。
            </Section>
          )}
          {!!has_case && !has_implant && (
            <Section>
              收纳盒中没有植入物。请放入植入物
              以继续。
            </Section>
          )}
          {!!has_case && !!has_implant && <Section>{case_lore}</Section>}
        </Collapsible>
      </Window.Content>
    </Window>
  );
};
