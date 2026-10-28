import { Button, NoticeBox, Section, Table } from 'tgui-core/components';
import { formatMoney } from 'tgui-core/format';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../../backend';
import type { CargoData } from './types';

export function CargoRequests(props) {
  const { act, data } = useBackend<CargoData>();
  const { requests = [], requestonly, can_send, can_approve_requests, displayed_currency_name} = data;

  return (
    <Section fill scrollable>
      {requests.length === 0 && <NoticeBox success>暂无申请</NoticeBox>}
      {requests.length > 0 && (
        <Table>
          <Table.Row header color="gray">
            <Table.Cell>编号</Table.Cell>
            <Table.Cell>物品</Table.Cell>
            <Table.Cell>订购者</Table.Cell>
            <Table.Cell>理由</Table.Cell>
            <Table.Cell>账户</Table.Cell>
            <Table.Cell>费用</Table.Cell>
            {(!requestonly || !!can_send) && !!can_approve_requests && (
              <Table.Cell>操作</Table.Cell>
            )}
          </Table.Row>

          {requests.map((request) => (
            <Table.Row key={request.id} className="candystripe" color="label">
              <Table.Cell collapsing>#{request.id}</Table.Cell>
              <Table.Cell>{request.object}</Table.Cell>
              <Table.Cell>
                <b>{request.orderer}</b>
              </Table.Cell>
              <Table.Cell color="lightgray" width="25%">
                <i>{decodeHtmlEntities(request.reason)}</i>
              </Table.Cell>
              <Table.Cell collapsing>
                {request.account}
              </Table.Cell>
              <Table.Cell collapsing color="gold">
                {formatMoney(request.cost)}{displayed_currency_name}
              </Table.Cell>
              {(!requestonly || !!can_send) && !!can_approve_requests && (
                <Table.Cell collapsing>
                  <Button
                    icon="check"
                    color="good"
                    onClick={() =>
                      act('approve', {
                        id: request.id,
                      })
                    }
                  />
                  <Button
                    icon="times"
                    color="bad"
                    onClick={() =>
                      act('deny', {
                        id: request.id,
                      })
                    }
                  />
                </Table.Cell>
              )}
            </Table.Row>
          ))}
        </Table>
      )}
    </Section>
  );
}
