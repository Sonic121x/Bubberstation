import { useState } from 'react';
import { Box, Button, LabeledList, Section, Table } from 'tgui-core/components';
import { decodeHtmlEntities } from 'tgui-core/string';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type PaintingAdminPanelData = {
  paintings: PaintingData[];
};

type PaintingData = {
  md5: string;
  title: string;
  creator_ckey: string;
  creator_name: string | null;
  creation_date: Date | null;
  creation_round_id: number | null;
  patron_ckey: string | null;
  patron_name: string | null;
  credit_value: number;
  width: number;
  height: number;
  ref: string;
  tags: string[] | null;
  medium: string | null;
};

export const PaintingAdminPanel = (props) => {
  const { act, data } = useBackend<PaintingAdminPanelData>();
  const [chosenPaintingRef, setChosenPaintingRef] = useState<
    string | undefined
  >();
  const { paintings } = data;
  const chosenPainting = paintings.find((p) => p.ref === chosenPaintingRef);

  return (
    <Window title="画作管理面板" width={800} height={600}>
      <Window.Content scrollable>
        {chosenPainting && (
          <Section
            title="画作信息"
            buttons={
              <Button onClick={() => setChosenPaintingRef(undefined)}>
                关闭
              </Button>
            }
          >
            <img
              src={resolveAsset(`paintings_${chosenPainting.md5}`)}
              height="96px"
              width="96px"
              style={{
                verticalAlign: 'middle',
              }}
            />
            <LabeledList>
              <LabeledList.Item label="md5" content={chosenPainting.md5} />
              <LabeledList.Item label="标题">
                <Box inline style={{ wordBreak: 'break-all' }}>
                  {decodeHtmlEntities(chosenPainting.title)}
                </Box>
                <Button
                  onClick={() => act('rename', { ref: chosenPainting.ref })}
                  icon="edit"
                />
              </LabeledList.Item>
              <LabeledList.Item
                label="作者账号"
                content={chosenPainting.creator_ckey}
              />
              <LabeledList.Item label="作者姓名">
                <Box inline>{chosenPainting.creator_name}</Box>
                <Button
                  onClick={() =>
                    act('rename_author', { ref: chosenPainting.ref })
                  }
                  icon="edit"
                />
              </LabeledList.Item>
              <LabeledList.Item
                label="创作日期"
                content={chosenPainting.creation_date}
              />
              <LabeledList.Item
                label="创作轮次编号"
                content={chosenPainting.creation_round_id}
              />
              <LabeledList.Item
                label="绘画媒介"
                content={chosenPainting.medium}
              />
              <LabeledList.Item label="标签">
                {chosenPainting.tags?.map((tag) => (
                  <Button
                    key={tag}
                    color="red"
                    icon="minus-circle"
                    iconPosition="right"
                    content={tag}
                    onClick={() =>
                      act('remove_tag', { tag, ref: chosenPainting.ref })
                    }
                  />
                ))}
                <Button
                  color="green"
                  icon="plus-circle"
                  onClick={() => act('add_tag', { ref: chosenPainting.ref })}
                />
              </LabeledList.Item>
              <LabeledList.Item
                label="赞助人账号"
                content={chosenPainting.patron_ckey}
              />
              <LabeledList.Item
                label="赞助人姓名"
                content={chosenPainting.patron_name}
              />
              <LabeledList.Item
                label="信用点价值"
                content={chosenPainting.credit_value}
              />
              <LabeledList.Item label="宽度" content={chosenPainting.width} />
              <LabeledList.Item
                label="高度"
                content={chosenPainting.height}
              />
            </LabeledList>
            <Section title="操作">
              <Button.Confirm
                onClick={() => {
                  setChosenPaintingRef(undefined);
                  act('delete', { ref: chosenPainting.ref });
                }}
                content="删除"
              />
              <Button
                onClick={() => act('dumpit', { ref: chosenPainting.ref })}
              >
                重置赞助信息
              </Button>
            </Section>
          </Section>
        )}
        {!chosenPainting && (
          <Table>
            <Table.Row>
              <Table.Cell color="label">标题</Table.Cell>
              <Table.Cell color="label">作者</Table.Cell>
              <Table.Cell color="label">预览</Table.Cell>
              <Table.Cell color="label">操作</Table.Cell>
            </Table.Row>
            {paintings.map((painting) => (
              <Table.Row key={painting.ref} className="candystripe">
                <Table.Cell style={{ wordBreak: 'break-all' }}>
                  {decodeHtmlEntities(painting.title)}
                </Table.Cell>
                <Table.Cell>{painting.creator_ckey}</Table.Cell>
                <Table.Cell>
                  <img
                    src={resolveAsset(`paintings_${painting.md5}`)}
                    height="36px"
                    width="36px"
                    style={{
                      verticalAlign: 'middle',
                    }}
                  />
                </Table.Cell>
                <Table.Cell>
                  <Button onClick={() => setChosenPaintingRef(painting.ref)}>
                    编辑
                  </Button>
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        )}
      </Window.Content>
    </Window>
  );
};
