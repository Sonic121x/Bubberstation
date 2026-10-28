import {
  Button,
  Dropdown,
  Input,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { chineseDisplay, chineseDropdownOptions } from 'tgui/localization/zhDisplay';
import { useBackend } from '../../backend';
import { useModifyState } from './hooks';
import { type Book, type LibraryAdminData, ModifyTypes } from './types';

type AdminBook = Book & {
  author_ckey: string;
  deleted: BooleanLike;
};

type DisplayAdminBook = AdminBook & {
  key: number;
};

export function SearchAndDisplay(props) {
  const { act, data } = useBackend<LibraryAdminData>();

  const { modifyMethodState, modifyTargetState } = useModifyState();
  const [modifyMethod, setModifyMethod] = modifyMethodState;
  const [modifyTarget, setModifyTarget] = modifyTargetState;

  const {
    can_db_request,
    search_categories = [],
    book_id,
    title,
    category,
    author,
    author_ckey,
    pages,
    params_changed,
    view_raw,
    show_deleted,
  } = data;

  const books = pages
    .map((book, i) => ({
      ...book,
      // Generate a unique id
      key: i,
    }))
    .sort((a, b) => a.key - b.key) as DisplayAdminBook[];

  return (
    <Section>
      <Stack justify="space-between">
        <Stack.Item>
          <Stack>
            <Stack.Item>
              <Input
                value={book_id?.toString()}
                placeholder={book_id === null ? '编号' : String(book_id)}
                width="70px"
                onBlur={(value) =>
                  act('set_search_id', {
                    id: value,
                  })
                }
              />
            </Stack.Item>
            <Stack.Item>
              <Dropdown
                options={chineseDropdownOptions(search_categories)}
                selected={category} displayText={chineseDisplay(category)}
                onSelected={(value) =>
                  act('set_search_category', {
                    category: value,
                  })
                }
              />
            </Stack.Item>
            <Stack.Item>
              <Input
                value={title}
                placeholder={title || '书名'}
                mt={0.5}
                onBlur={(value) =>
                  act('set_search_title', {
                    title: value,
                  })
                }
              />
            </Stack.Item>
            <Stack.Item>
              <Input
                value={author}
                placeholder={author || '作者'}
                mt={0.5}
                onBlur={(value) =>
                  act('set_search_author', {
                    author: value,
                  })
                }
              />
            </Stack.Item>
            <Stack.Item>
              <Input
                value={author_ckey}
                placeholder={author_ckey || '账号'}
                mt={0.5}
                onBlur={(value) =>
                  act('set_search_ckey', {
                    ckey: value,
                  })
                }
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Stack vertical>
            <Stack.Item>
              <Button
                disabled={!can_db_request}
                textAlign="right"
                onClick={() => act('refresh')}
                color={params_changed ? 'good' : ''}
                icon="rotate-right"
              >
                刷新
              </Button>
              <Button
                disabled={!can_db_request}
                textAlign="right"
                onClick={() => act('clear_data')}
                color="bad"
                icon="fire"
              >
                重置搜索
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button
                textAlign="right"
                onClick={() => act('toggle_raw')}
                color={view_raw ? 'purple' : 'blue'}
                icon={view_raw ? 'theater-masks' : 'glasses'}
              >
                {view_raw ? '源文本' : '正常显示'}
              </Button>
              <Button
                textAlign="right"
                onClick={() => act('toggle_deleted')}
                color={show_deleted ? 'purple' : 'green'}
                icon={show_deleted ? 'trash' : 'mountain-sun'}
              >
                {show_deleted ? '全部' : '未删除'}
              </Button>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
      <Table>
        <Table.Row>
          <Table.Cell fontSize={1.5}>#</Table.Cell>
          <Table.Cell fontSize={1.5}>类别</Table.Cell>
          <Table.Cell fontSize={1.5}>书名</Table.Cell>
          <Table.Cell fontSize={1.5}>作者</Table.Cell>
          <Table.Cell fontSize={1.5}>账号</Table.Cell>
          <Table.Cell fontSize={1.5}>恢复／删除</Table.Cell>
        </Table.Row>
        {books.map((book) => (
          <Table.Row key={book.key}>
            <Table.Cell>
              <Button
                onClick={() =>
                  act('view_book', {
                    book_id: book.id,
                  })
                }
                icon="book-reader"
              >
                {book.id}
              </Button>
            </Table.Cell>
            <Table.Cell>{chineseDisplay(book.category)}</Table.Cell>
            <Table.Cell>{book.title}</Table.Cell>
            <Table.Cell>{book.author}</Table.Cell>
            <Table.Cell>{book.author_ckey}</Table.Cell>
            <Table.Cell>
              {book.deleted ? (
                <Button
                  onClick={() => {
                    setModifyTarget(book.id);
                    setModifyMethod(ModifyTypes.Restore);
                    act('get_history', {
                      book_id: book.id,
                    });
                  }}
                  icon="undo"
                  color="blue"
                >
                  恢复
                </Button>
              ) : (
                <Button
                  onClick={() => {
                    setModifyTarget(book.id);
                    setModifyMethod(ModifyTypes.Delete);
                    act('get_history', {
                      book_id: book.id,
                    });
                  }}
                  icon="hammer"
                  color="violet"
                >
                  删除
                </Button>
              )}
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
}
