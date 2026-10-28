/**
 * @file
 * @copyright 2021 bobbahbrown (https://github.com/bobbahbrown)
 * @license MIT
 */
import { useState } from 'react';
import {
  Button,
  Floating,
  Input,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { createSearch, decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  requests: Request[];
  fax_autoprinting: BooleanLike;
};

type Request = {
  id: string;
  req_type: string;
  owner: string;
  owner_ckey: string;
  owner_name: string;
  message: string;
  additional_info: string;
  timestamp: number;
  timestamp_str: string;
};

const displayTypeMap = {
  request_prayer: '祈祷',
  request_centcom: '中央指挥部',
  request_syndicate: '辛迪加',
  request_nuke: '核弹密码',
  request_fax: '传真',
  request_internet_sound: '网络音频',
};

export const RequestManager = (props) => {
  const { act, data } = useBackend<Data>();
  const { requests = [] } = data;
  const [filteredTypes, setFilteredTypes] = useState(
    Object.fromEntries(
      Object.entries(displayTypeMap).map(([type, _]) => [type, true]),
    ),
  );
  const [searchText, setSearchText] = useState('');

  const updateFilter = (type) => {
    const newFilter = { ...filteredTypes };
    newFilter[type] = !newFilter[type];
    setFilteredTypes(newFilter);
  };

  // Handle filtering
  let displayedRequests = requests.filter(
    (request) => filteredTypes[request.req_type],
  );
  const search = createSearch(
    searchText,
    (requests: Request) =>
      requests.owner_name + decodeHtmlEntities(requests.message),
  );
  if (searchText.length > 0) {
    displayedRequests = displayedRequests.filter((request) => search(request));
  }

  return (
    <Window title="请求管理" width={575} height={600} theme="admin">
      <Window.Content scrollable>
        <Section
          title="请求"
          buttons={
            <Stack>
              <Stack.Item>
                <Button.Checkbox
                  checked={data.fax_autoprinting}
                  onClick={() => act('toggleprint')}
                  tooltip={
                    '自动将传真请求打印到管理员传真机。默认情况下，该传真机位于中央指挥部的简报室。'
                  }
                >
                  自动打印传真
                </Button.Checkbox>
                <Input
                  value={searchText}
                  onChange={setSearchText}
                  placeholder="搜索……"
                  mr={1}
                />
              </Stack.Item>
              <Stack.Item>
                <FilterPanel
                  typesList={filteredTypes}
                  updateFilter={updateFilter}
                />
              </Stack.Item>
            </Stack>
          }
        >
          {displayedRequests.map((request) => (
            <div className="RequestManager__row" key={request.id}>
              <div className="RequestManager__rowContents">
                <h2 className="RequestManager__header">
                  <span className="RequestManager__headerText">
                    {request.owner_name}
                    {request.owner === null && ' [已断线]'}
                  </span>
                  <span className="RequestManager__timestamp">
                    {request.timestamp_str}
                  </span>
                </h2>
                <div className="RequestManager__message">
                  <RequestType requestType={request.req_type} />
                  {decodeHtmlEntities(request.message)}
                </div>
              </div>
              {request.owner !== null && <RequestControls request={request} />}
            </div>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};

const RequestType = (props) => {
  const { requestType } = props;

  return (
    <b className={`RequestManager__${requestType}`}>
      {displayTypeMap[requestType]}:
    </b>
  );
};

const RequestControls = (props) => {
  const { act } = useBackend<Data>();
  const { request } = props;

  return (
    <div className="RequestManager__controlsContainer">
      <Button onClick={() => act('pp', { id: request.id })}>玩家面板</Button>
      <Button onClick={() => act('vv', { id: request.id })}>变量</Button>
      <Button onClick={() => act('sm', { id: request.id })}>隐秘消息</Button>
      <Button onClick={() => act('flw', { id: request.id })}>跟随</Button>
      <Button onClick={() => act('tp', { id: request.id })}>叛徒面板</Button>
      <Button onClick={() => act('logs', { id: request.id })}>日志</Button>
      <Button onClick={() => act('smite', { id: request.id })}>神罚</Button>
      {request.req_type !== 'request_prayer' && (
        <Button onClick={() => act('rply', { id: request.id })}>回复</Button>
      )}
      {request.req_type === 'request_nuke' && (
        <Button onClick={() => act('setcode', { id: request.id })}>
          设置密码
        </Button>
      )}
      {request.req_type === 'request_fax' && (
        <>
          <Button onClick={() => act('show', { id: request.id })}>查看</Button>
          <Button onClick={() => act('print', { id: request.id })}>
            打印
          </Button>
        </>
      )}
      {request.req_type === 'request_internet_sound' && (
        <Button onClick={() => act('play', { id: request.id })}>播放</Button>
      )}
    </div>
  );
};

const FilterPanel = (props) => {
  const [filterVisible, setFilterVisible] = useState(false);
  const { typesList, updateFilter } = props;

  return (
    <div>
      <Floating
        placement="bottom-end"
        onOpenChange={setFilterVisible}
        contentClasses="RequestManager__filterPanel"
        content={
          <Table width="0">
            {Object.keys(displayTypeMap).map((type) => {
              return (
                <Table.Row className="candystripe" key={type}>
                  <Table.Cell collapsing>
                    <RequestType requestType={type} />
                  </Table.Cell>
                  <Table.Cell collapsing>
                    <Button.Checkbox
                      checked={typesList[type]}
                      onClick={() => {
                        updateFilter(type);
                      }}
                      my={0.25}
                    />
                  </Table.Cell>
                </Table.Row>
              );
            })}
          </Table>
        }
      >
        <Button icon="cog" selected={filterVisible}>
          类型筛选
        </Button>
      </Floating>
    </div>
  );
};
