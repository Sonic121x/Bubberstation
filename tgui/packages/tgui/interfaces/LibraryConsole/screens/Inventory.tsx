import { useBackend } from 'tgui/backend';
import { Button, NoticeBox, Stack, Table } from 'tgui-core/components';

import { PageSelect } from '../components/PageSelect';
import { ScrollableSection } from '../components/ScrollableSection';
import type { LibraryConsoleData } from '../types';

export function Inventory(props) {
  const { act, data } = useBackend<LibraryConsoleData>();
  const { inventory_page_count, inventory_page, has_inventory } = data;

  if (!has_inventory) {
    return (
      <NoticeBox>未检测到书籍记录。请更新馆藏清单！</NoticeBox>
    );
  }

  return (
    <Stack vertical justify="space-between" height="100%">
      <Stack.Item grow>
        <ScrollableSection
          header="图书馆馆藏"
          contents={<InventoryDetails />}
        />
      </Stack.Item>
      <Stack.Item align="center">
        <PageSelect
          minimum_page_count={1}
          page_count={inventory_page_count}
          current_page={inventory_page}
          call_on_change={(value) =>
            act('switch_inventory_page', {
              page: value,
            })
          }
        />
      </Stack.Item>
    </Stack>
  );
}

function InventoryDetails(props) {
  const { act, data } = useBackend<LibraryConsoleData>();
  const { inventory = [] } = data;

  const sorted = inventory
    .map((book, i) => ({
      ...book,
      // Generate a unique id
      key: i,
    }))
    .sort((a, b) => a.key - b.key);

  return (
    <Table>
      <Table.Row header className="candystripe">
        <Table.Cell>书名</Table.Cell>
        <Table.Cell>作者</Table.Cell>
        <Table.Cell textAlign="center">移除</Table.Cell>
      </Table.Row>
      {sorted.map((book) => (
        <Table.Row key={book.key} className="candystripe">
          <Table.Cell>{book.title}</Table.Cell>
          <Table.Cell>{book.author}</Table.Cell>
          <Table.Cell collapsing>
            <Button
              mb={1}
              color="bad"
              onClick={() =>
                act('inventory_remove', {
                  book_id: book.ref,
                })
              }
              icon="times"
            >
              清除记录
            </Button>
          </Table.Cell>
        </Table.Row>
      ))}
    </Table>
  );
}
