import { Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const OutfitManager = (props) => {
  const { act, data } = useBackend();
  const { outfits } = data;
  return (
    <Window title="装备套装管理器" width={300} height={300} theme="admin">
      <Window.Content>
        <Section
          fill
          scrollable
          title="自定义装备套装管理器"
          buttons={
            <>
              <Button
                icon="file-upload"
                tooltip="从文件加载套装"
                tooltipPosition="left"
                onClick={() => act('load')}
              />
              <Button
                icon="copy"
                tooltip="复制现有套装"
                tooltipPosition="left"
                onClick={() => act('copy')}
              />
              <Button
                icon="plus"
                tooltip="创建新套装"
                tooltipPosition="left"
                onClick={() => act('new')}
              />
            </>
          }
        >
          <Stack vertical>
            {outfits?.map((outfit) => (
              <Stack.Item key={outfit.ref}>
                <Stack>
                  <Stack.Item
                    grow={1}
                    shrink={1}
                    style={{
                      overflow: 'hidden',
                      whiteSpace: 'nowrap',
                      textOverflow: 'ellipsis',
                    }}
                  >
                    <Button
                      fluid
                      style={{
                        overflow: 'hidden',
                        whiteSpace: 'nowrap',
                        textOverflow: 'ellipsis',
                      }}
                      content={outfit.name}
                      onClick={() => act('edit', { outfit: outfit.ref })}
                    />
                  </Stack.Item>
                  <Stack.Item ml={0.5}>
                    <Button
                      icon="save"
                      tooltip="将此套装保存到文件"
                      tooltipPosition="left"
                      onClick={() => act('save', { outfit: outfit.ref })}
                    />
                  </Stack.Item>
                  <Stack.Item ml={0.5}>
                    <Button
                      color="bad"
                      icon="trash-alt"
                      tooltip="删除此套装"
                      tooltipPosition="left"
                      onClick={() => act('delete', { outfit: outfit.ref })}
                    />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
