import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import {
  Button,
  Dropdown,
  Input,
  LabeledList,
  Modal,
  NoticeBox,
  NumberInput,
  Stack,
  Table,
} from 'tgui-core/components';

import { PageSelect } from '../components/PageSelect';
import { ScrollableSection } from '../components/ScrollableSection';
import type { LibraryConsoleData } from '../types';
import { useLibraryContext } from '../useLibraryContext';

export function Checkout(props) {
  const { act, data } = useBackend<LibraryConsoleData>();
  const { checkout_page, checkout_page_count } = data;

  const { checkoutBookState } = useLibraryContext();
  const [checkoutBook, setCheckoutBook] = checkoutBookState;

  return (
    <Stack vertical height="100%" justify="space-between">
      <Stack.Item grow>
        <Stack vertical height="100%">
          <Stack.Item grow>
            <ScrollableSection
              header="已借出书籍"
              contents={<CheckoutEntries />}
            />
          </Stack.Item>
          <Stack.Item align="center">
            <PageSelect
              minimum_page_count={1}
              page_count={checkout_page_count}
              current_page={checkout_page}
              call_on_change={(value) =>
                act('switch_checkout_page', {
                  page: value,
                })
              }
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Button
          fluid
          icon="barcode"
          fontSize="20px"
          onClick={() => setCheckoutBook(true)}
        >
          借出书籍
        </Button>
      </Stack.Item>
      {!!checkoutBook && <CheckoutModal />}
    </Stack>
  );
}

function CheckoutModal(props) {
  const { act, data } = useBackend<LibraryConsoleData>();
  const { checkout_title } = data;

  const inventory = data.inventory
    .map((book, i) => ({
      ...book,
      // Generate a unique id
      key: i,
    }))
    .sort((a, b) => a.key - b.key);

  const { checkoutBookState } = useLibraryContext();
  const [checkoutBook, setCheckoutBook] = checkoutBookState;

  const [checkoutee, setCheckoutee] = useState('借阅人');
  const [checkoutPeriod, setCheckoutPeriod] = useState(5);

  return (
    <Modal width="500px" py={4}>
      <Stack fill vertical>
        <Stack.Item fontSize="20px">
          确定要借出这本书吗？
        </Stack.Item>
        <Stack.Item>
          <Dropdown
            over
            width="100%"
            selected={checkout_title}
            placeholder="输入书名……"
            displayText={checkout_title}
            options={inventory.map((book) => book.title)}
            onSelected={(e) => {
              act('set_checkout', {
                book_name: e,
              });
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <LabeledList>
            <LabeledList.Item label="借阅人">
              <Input
                width="160px"
                value={checkoutee}
                onChange={setCheckoutee}
              />
            </LabeledList.Item>
            <LabeledList.Item label="借阅期限">
              <NumberInput
                value={checkoutPeriod}
                unit=" 分钟"
                minValue={1}
                maxValue={120}
                step={1}
                stepPixelSize={10}
                onChange={(value) => setCheckoutPeriod(value)}
              />
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
        <Stack.Item>
          <Stack justify="center" align="center" pt={1}>
            <Stack.Item>
              <Button
                icon="upload"
                fontSize="16px"
                color="good"
                onClick={() => {
                  setCheckoutBook(false);
                  act('checkout', {
                    loaned_to: checkoutee,
                    checkout_time: checkoutPeriod,
                  });
                }}
                lineHeight={2}
              >
                借出
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="times"
                fontSize="16px"
                color="bad"
                onClick={() => setCheckoutBook(false)}
                lineHeight={2}
              >
                返回
              </Button>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Modal>
  );
}

export function CheckoutEntries(props) {
  const { act, data } = useBackend<LibraryConsoleData>();
  const { checkouts = [] } = data;

  return (
    <Table>
      <Table.Row header className="candystripe">
        <Table.Cell>书名</Table.Cell>
        <Table.Cell>作者</Table.Cell>
        <Table.Cell>借阅人</Table.Cell>
        <Table.Cell>剩余时间</Table.Cell>
        <Table.Cell>归还</Table.Cell>
      </Table.Row>
      {checkouts.length === 0 ? (
        <Table.Row>
          <Table.Cell textAlign="center" colSpan={5}>
            <NoticeBox>没有已借出的书籍。</NoticeBox>
          </Table.Cell>
        </Table.Row>
      ) : (
        checkouts.map((entry) => (
          <Table.Row key={entry.id} className="candystripe">
            <Table.Cell>{entry.title}</Table.Cell>
            <Table.Cell>{entry.author}</Table.Cell>
            <Table.Cell>{entry.borrower}</Table.Cell>
            <Table.Cell backgroundColor={entry.overdue ? 'bad' : 'good'}>
              {entry.overdue ? '已逾期' : `${entry.due_in_minutes} 分钟`}
            </Table.Cell>
            <Table.Cell width="70px" textAlign="center">
              <Button
                mb={1}
                onClick={() =>
                  act('checkin', {
                    checked_out_id: entry.ref,
                  })
                }
                icon="box-open"
              />
            </Table.Cell>
          </Table.Row>
        ))
      )}
    </Table>
  );
}
