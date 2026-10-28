import { useState } from 'react';
import { Button, Flex, Input, NoticeBox, Section } from 'tgui-core/components';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';

export const PortraitPicker = (props) => {
  const { act, data } = useBackend();
  const [listIndex, setListIndex] = useState(0);
  const { paintings, search_string, search_mode } = data;
  const got_paintings = !!paintings.length;
  const current_portrait_title = got_paintings && paintings[listIndex].title;
  const current_portrait_author =
    got_paintings && `作者：${paintings[listIndex].creator}`;
  const current_portrait_asset_name =
    got_paintings && `paintings_${paintings[listIndex].md5}`;

  return (
    <Window theme="ntos" title="肖像选择器" width={400} height={406}>
      <Window.Content>
        <Flex height="100%" direction="column">
          <Flex.Item mb={1}>
            <Section title="搜索">
              <Input
                fluid
                placeholder="搜索画作……"
                value={search_string}
                onBlur={(value) => {
                  act('search', {
                    to_search: value,
                  });
                  setListIndex(0);
                }}
              />
              <Button
                content={search_mode}
                onClick={() => {
                  act('change_search_mode');
                  if (search_string) {
                    setListIndex(0);
                  }
                }}
              />
            </Section>
          </Flex.Item>
          <Flex.Item mb={1} grow={2}>
            <Section fill>
              <Flex
                height="100%"
                align="center"
                justify="center"
                direction="column"
              >
                {got_paintings ? (
                  <>
                    <Flex.Item>
                      <img
                        src={resolveAsset(current_portrait_asset_name)}
                        height="128px"
                        width="128px"
                        style={{
                          verticalAlign: 'middle',
                        }}
                      />
                    </Flex.Item>
                    <Flex.Item className="Section__titleText">
                      {current_portrait_title}
                    </Flex.Item>
                    <Flex.Item>{current_portrait_author}</Flex.Item>
                  </>
                ) : (
                  <Flex.Item className="Section__titleText">
                    未找到画作。
                  </Flex.Item>
                )}
              </Flex>
            </Section>
          </Flex.Item>
          <Flex.Item>
            <Flex>
              <Flex.Item grow={3}>
                <Section height="100%">
                  <Flex justify="space-between">
                    <Flex.Item grow={1}>
                      <Button
                        icon="angle-double-left"
                        disabled={listIndex === 0}
                        onClick={() => setListIndex(0)}
                      />
                    </Flex.Item>
                    <Flex.Item grow={3}>
                      <Button
                        disabled={listIndex === 0}
                        icon="chevron-left"
                        onClick={() => setListIndex(listIndex - 1)}
                      />
                    </Flex.Item>
                    <Flex.Item grow={3}>
                      <Button
                        icon="check"
                        content="选择肖像"
                        disabled={!got_paintings}
                        onClick={() =>
                          act('select', {
                            selected: paintings[listIndex].ref,
                          })
                        }
                      />
                    </Flex.Item>
                    <Flex.Item grow={1}>
                      <Button
                        icon="chevron-right"
                        disabled={listIndex >= paintings.length - 1}
                        onClick={() => setListIndex(listIndex + 1)}
                      />
                    </Flex.Item>
                    <Flex.Item>
                      <Button
                        icon="angle-double-right"
                        disabled={listIndex >= paintings.length - 1}
                        onClick={() => setListIndex(paintings.length - 1)}
                      />
                    </Flex.Item>
                  </Flex>
                </Section>
              </Flex.Item>
            </Flex>
            <Flex.Item mt={1}>
              <NoticeBox info>
                仅可显示画布尺寸为 23×23 或 24×24 的作品。
                在拥抱广阔而美妙的艺术表达世界之前，
                请务必阅读下方警告！
              </NoticeBox>
            </Flex.Item>
            <Flex.Item>
              <NoticeBox danger>
                警告：中央指挥部和你一样热爱艺术，
                但选择色情作品会导致严重后果。
                此外，中央指挥部保留出于任何原因要求你
                更换展示肖像的权利。
              </NoticeBox>
            </Flex.Item>
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};
