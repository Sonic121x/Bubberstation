import { Box, Button, Image, NoticeBox, Section } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  server_connected: BooleanLike;
  loaded_item: string;
  item_icon: string;
  indestructible: BooleanLike;
  already_deconstructed: BooleanLike;
  recoverable_points: string;
  node_data: NodeData[];
  research_point_id: string;
};

type NodeData = {
  node_name: string;
  node_id: string;
  node_hidden: BooleanLike;
};

export const DestructiveAnalyzer = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    server_connected,
    indestructible,
    loaded_item,
    item_icon,
    already_deconstructed,
    recoverable_points,
    research_point_id,
    node_data = [],
  } = data;
  if (!server_connected) {
    return (
      <Window width={400} height={260} title="破坏性分析仪">
        <Window.Content>
          <NoticeBox textAlign="center" danger>
            未连接服务器。请使用多功能工具进行同步。
          </NoticeBox>
        </Window.Content>
      </Window>
    );
  }
  if (!loaded_item) {
    return (
      <Window width={400} height={260} title="破坏性分析仪">
        <Window.Content>
          <NoticeBox textAlign="center" danger>
            未装入物品！<br />
            放入物品，看看能从中发现什么！
          </NoticeBox>
        </Window.Content>
      </Window>
    );
  }
  return (
    <Window width={400} height={260} title="破坏性分析仪">
      <Window.Content scrollable>
        <Section
          title={loaded_item}
          buttons={
            <Button
              icon="eject"
              tooltip="弹出机器内的物品。"
              onClick={() => act('eject_item')}
            />
          }
        >
          <Image
            src={`data:image/jpeg;base64,${item_icon}`}
            height="64px"
            width="64px"
            verticalAlign="middle"
          />
        </Section>
        <Section title="拆解方式">
          {!indestructible && (
            <NoticeBox textAlign="center" danger>
              无法拆解此物品！
            </NoticeBox>
          )}
          {!!indestructible && (
            <>
              {!!recoverable_points && (
                <>
                  <Box fontSize="14px">拆解可获得的研究点数</Box>
                  <Box>{recoverable_points}</Box>
                </>
              )}
              <Button.Confirm
                content="拆解"
                icon="hammer"
                tooltip={
                  already_deconstructed
                    ? '此物品已被拆解研究过，不会提供额外信息。'
                    : '摧毁当前装在机器内的物品。'
                }
                onClick={() =>
                  act('deconstruct', { deconstruct_id: research_point_id })
                }
              />
            </>
          )}
          {node_data.map((node) => (
            <Button.Confirm
              icon="cash-register"
              mt={1}
              disabled={!node.node_hidden}
              key={node.node_id}
              tooltip={
                node.node_hidden
                  ? '拆解此物品以研究所选节点。'
                  : '此节点已经研究完毕。'
              }
              onClick={() =>
                act('deconstruct', { deconstruct_id: node.node_id })
              }
            >
              {node.node_name}
            </Button.Confirm>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
