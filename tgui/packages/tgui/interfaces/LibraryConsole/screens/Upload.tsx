import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { sanitizeText } from 'tgui/sanitize';
import {
  Box,
  Button,
  Dropdown,
  Input,
  LabeledList,
  Modal,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';
import { chineseDisplay, chineseDropdownOptions } from 'tgui/localization/zhDisplay';
import type { LibraryConsoleData } from '../types';
import { useLibraryContext } from '../useLibraryContext';

export function Upload(props) {
  const { act, data } = useBackend<LibraryConsoleData>();
  const {
    active_newscaster_cooldown,
    cache_author,
    cache_content,
    cache_title,
    can_db_request,
    cooldown_string,
    has_cache,
    has_scanner,
  } = data;

  const { uploadToDBState } = useLibraryContext();
  const [uploadToDB, setUploadToDB] = uploadToDBState;

  if (!has_scanner) {
    return (
      <NoticeBox>
        未检测到附近的扫描仪，请建造一台后继续。
      </NoticeBox>
    );
  }

  if (!has_cache) {
    return <NoticeBox>请扫描要上传的书籍。</NoticeBox>;
  }

  const contentHtml = {
    __html: sanitizeText(cache_content),
  };

  return (
    <>
      <Stack vertical height="100%">
        <Stack.Item>
          <Box fontSize="20px" textAlign="center" pt="6px">
            当前扫描缓存
          </Box>
        </Stack.Item>
        <Stack.Item grow>
          <Stack vertical height="100%">
            <Stack.Item>
              <Stack justify="center">
                <Stack.Item>
                  <Box pt={1} fontSize={'20px'}>
                    书名：
                  </Box>
                </Stack.Item>
                <Stack.Item>
                  <Input
                    fontSize="20px"
                    value={cache_title}
                    placeholder={cache_title || '书名'}
                    mt={0.5}
                    width={22}
                    onBlur={(value) =>
                      act('set_cache_title', {
                        title: value,
                      })
                    }
                  />
                </Stack.Item>
                <Stack.Item>
                  <Box pt={1} fontSize="20px">
                    作者：
                  </Box>
                </Stack.Item>
                <Stack.Item>
                  <Input
                    fontSize="20px"
                    value={cache_author}
                    placeholder={cache_author || '作者'}
                    mt={0.5}
                    onBlur={(value) =>
                      act('set_cache_author', {
                        author: value,
                      })
                    }
                  />
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item grow>
              <Section
                fill
                scrollable
                preserveWhitespace
                fontSize="15px"
                title="内容："
              >
                <Box dangerouslySetInnerHTML={contentHtml} />
              </Section>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Stack>
            <Stack.Item grow>
              <Button
                disabled={!active_newscaster_cooldown}
                fluid
                tooltip={
                  active_newscaster_cooldown
                    ? '将你的书籍发送到空间站的新闻播报频道。'
                    : '请等待 ' +
                      cooldown_string +
                      ' 后再将书籍发送至新闻播报器！'
                }
                tooltipPosition="top"
                icon="newspaper"
                fontSize="30px"
                lineHeight={2}
                textAlign="center"
                onClick={() => act('news_post')}
              >
                新闻播报器
              </Button>
            </Stack.Item>
            <Stack.Item grow>
              <Button
                disabled={!can_db_request}
                fluid
                icon="server"
                fontSize="30px"
                lineHeight={2}
                textAlign="center"
                onClick={() => setUploadToDB(true)}
              >
                档案库
              </Button>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
      {!!uploadToDB && <UploadModal />}
    </>
  );
}

function UploadModal(props) {
  const { act, data } = useBackend<LibraryConsoleData>();
  const { upload_categories, default_category, can_db_request } = data;

  const { uploadToDBState } = useLibraryContext();
  const [uploadToDB, setUploadToDB] = uploadToDBState;

  const [uploadCategory, setUploadCategory] = useState('');

  const display_category = uploadCategory || default_category;

  return (
    <Modal width="650px">
      <Box fontSize="20px" pb={2}>
        确定要将这本书上传至数据库吗？
      </Box>
      <LabeledList>
        <LabeledList.Item label="类别">
          <Dropdown
            options={chineseDropdownOptions(upload_categories)}
            selected={display_category} displayText={chineseDisplay(display_category)}
            onSelected={(value) => setUploadCategory(value)}
          />
        </LabeledList.Item>
      </LabeledList>
      <Stack justify="center" align="center" pt={2}>
        <Stack.Item>
          <Button
            disabled={!can_db_request}
            icon="upload"
            fontSize="18px"
            color="good"
            onClick={() => {
              setUploadToDB(false);
              act('upload', {
                category: display_category,
              });
            }}
            lineHeight={2}
          >
            上传至数据库
          </Button>
        </Stack.Item>
        <Stack.Item>
          <Button
            icon="times"
            fontSize="18px"
            color="bad"
            onClick={() => setUploadToDB(false)}
            lineHeight={2}
          >
            返回
          </Button>
        </Stack.Item>
      </Stack>
    </Modal>
  );
}
