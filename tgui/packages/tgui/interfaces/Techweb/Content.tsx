import { Button, Flex, LabeledList } from 'tgui-core/components';

import { useRemappedBackend } from './helpers';
import { useTechWebRoute } from './hooks';
import { TechwebRouter } from './Router';

export function TechwebContent(props) {
  const { act, data } = useRemappedBackend();
  const {
    d_disk,
    node_cache,
    points_last_tick,
    point_types_abbreviations = [],
    points,
    queue_nodes = [],
    sec_protocols,
    t_disk,
  } = data;
  const [techwebRoute, setTechwebRoute] = useTechWebRoute();

  return (
    <Flex direction="column" className="Techweb__Viewport" height="100%">
      <Flex.Item className="Techweb__HeaderSection">
        <Flex className="Techweb__HeaderContent">
          <Flex.Item>
            <LabeledList>
              <LabeledList.Item label="安全协议">
                <span
                  className={`Techweb__SecProtocol ${
                    !!sec_protocols && 'engaged'
                  }`}
                >
                  {sec_protocols ? '已启用' : '已停用'}
                </span>
              </LabeledList.Item>
              {Object.keys(points).map((k) => (
                <LabeledList.Item key={k} label={point_types_abbreviations[k]}>
                  <b>{points[k]}</b>
                  {!!points_last_tick[k] && `（+${points_last_tick[k]}/秒）`}
                </LabeledList.Item>
              ))}
              <LabeledList.Item label="队列">
                {queue_nodes.length !== 0
                  ? Object.keys(queue_nodes).map((node_id) => (
                      <Button
                        key={node_id}
                        tooltip={`添加者：${queue_nodes[node_id]}`}
                      >
                        {node_cache[node_id].name}
                      </Button>
                    ))
                  : '空'}
              </LabeledList.Item>
            </LabeledList>
          </Flex.Item>
          <Flex.Item grow />
          <Flex.Item>
            <Button fluid onClick={() => act('toggleLock')} icon="lock">
              锁定控制台
            </Button>
            {d_disk && (
              <Flex.Item>
                <Button
                  fluid
                  onClick={() =>
                    setTechwebRoute({ route: 'disk', diskType: 'design' })
                  }
                >
                  已插入设计磁盘
                </Button>
              </Flex.Item>
            )}
            {t_disk && (
              <Flex.Item>
                <Button
                  fluid
                  onClick={() =>
                    setTechwebRoute({ route: 'disk', diskType: 'tech' })
                  }
                >
                  已插入科技磁盘
                </Button>
              </Flex.Item>
            )}
          </Flex.Item>
        </Flex>
      </Flex.Item>
      <Flex.Item className="Techweb__RouterContent" height="100%">
        <TechwebRouter />
      </Flex.Item>
    </Flex>
  );
}
