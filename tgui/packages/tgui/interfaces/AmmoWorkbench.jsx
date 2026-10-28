// THIS IS A SKYRAT UI FILE
import {
  Box,
  Button,
  Flex,
  Icon,
  NoticeBox,
  Section,
  Stack,
  Table,
  Tabs,
  Tooltip,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';
import { MaterialAccessBar } from './Fabrication/MaterialAccessBar';

export const AmmoWorkbench = (props) => {
  const [tab, setTab] = useSharedState('tab', 1);
  const { data, act } = useBackend();
  const { materials = [], SHEET_MATERIAL_AMOUNT, hacked, silo_connected } =
    data;

  return (
    <Window
      width={620}
      height={640}
      theme="ammoworkbench"
      title="弹药工作台"
    >
      <Window.Content>
        <Stack vertical fill>
          {/* Armadyne identity header (this is an Armadyne bench, not Nanotrasen). */}
          <Stack.Item>
            <Box className="AmmoWorkbench__header">
              <Box as="span" className="AmmoWorkbench__header-icon">
                ⌖
              </Box>
              <Box as="span" className="AmmoWorkbench__header-title">
                阿玛达因弹药工作台
              </Box>
              <Tooltip
                content={
                  silo_connected
                    ? '已连接矿物储仓。'
                    : '未连接矿物储仓；正在使用本地存储。使用多功能工具建立连接。'
                }
              >
                <Box
                  as="span"
                  className="AmmoWorkbench__header-silo"
                  color={silo_connected ? 'good' : 'bad'}
                >
                  <Icon name="wifi" mr={0.5} />
                  {silo_connected ? '已连接' : '本地'}
                </Box>
              </Tooltip>
              <Box
                as="span"
                className="AmmoWorkbench__header-status"
                color={hacked ? 'bad' : 'good'}
              >
                {hacked ? '安全协议：已停用' : '安全协议：已启用'}
              </Box>
            </Box>
          </Stack.Item>
          <Stack.Item>
            <Tabs fluid>
              <Tabs.Tab
                icon="gun"
                selected={tab === 1}
                onClick={() => setTab(1)}
              >
                弹药
              </Tabs.Tab>
              <Tabs.Tab
                icon="compact-disc"
                selected={tab === 3}
                onClick={() => setTab(3)}
              >
                数据盘
              </Tabs.Tab>
            </Tabs>
          </Stack.Item>
          <Stack.Item grow style={{ overflowY: 'auto' }}>
            {tab === 1 && <AmmunitionsTab />}
            {tab === 3 && <DatadiskTab />}
          </Stack.Item>
          {/* status strip + standard fabricator material dock */}
          <Stack.Item shrink={0}>
            <Section>
              <Flex
                className="AmmoWorkbench__statusline"
                align="center"
                mb={1}
              >
                <Flex.Item color="label" style={{ letterSpacing: '1px' }}>
                  库存
                </Flex.Item>
                <Flex.Item grow />
                <Flex.Item color="label">
                  回收率 {data.recyclePercent}% · 材料消耗 {Math.round(data.efficiency * 100)}%
                </Flex.Item>
              </Flex>
              <MaterialAccessBar
                availableMaterials={materials}
                SHEET_MATERIAL_AMOUNT={SHEET_MATERIAL_AMOUNT}
                onEjectRequested={(material, amount) =>
                  act('remove_mat', { ref: material.ref, amount })
                }
              />
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

export const AmmunitionsTab = (props) => {
  const { act, data } = useBackend();
  const {
    mag_loaded,
    system_busy,
    hacked,
    error,
    error_type,
    mag_name,
    turboBoost,
    current_rounds,
    max_rounds,
    efficiency,
    time,
    recyclePercent,
    partTier,
    bar_state,
    recycle_preview,
    available_rounds = [],
  } = data;

  const isFull = mag_loaded && current_rounds >= max_rounds;
  let barState = 'IDLE';
  if (system_busy) {
    barState = bar_state || 'FABRICATING';
  } else if (isFull) {
    barState = 'FULL';
  }

  return (
    <>
      {/* fixed-height notice slot so layout doesn't shift */}
      <Box height="2.5rem" mb={0.5}>
        {!!error && (
          <NoticeBox textAlign="center" color={error_type}>
            {error}
          </NoticeBox>
        )}
      </Box>

      <Section title="机器设置">
        <Flex align="center" justify="space-between">
          <Flex.Item>
            <Flex align="center">
              <Flex.Item mr={2}>
                <Tooltip content="组件质量。更高级的零件可降低材料消耗、加快制造速度并提高回收率。">
                  <Box>
                    <SignalBars level={partTier} />
                  </Box>
                </Tooltip>
              </Flex.Item>
              <Flex.Item color="label" mr={1}>
                材料消耗
              </Flex.Item>
              <Flex.Item bold mr={3}>
                {Math.round(efficiency * 100)}%
              </Flex.Item>
              <Flex.Item color="label" mr={1}>
                每发耗时
              </Flex.Item>
              <Flex.Item bold>{time}秒</Flex.Item>
            </Flex>
          </Flex.Item>
          <Flex.Item>
            <Button.Checkbox
              checked={turboBoost}
              onClick={() => act('turboBoost')}
            >
              涡轮加速
            </Button.Checkbox>
          </Flex.Item>
        </Flex>
      </Section>

      <Section
        title="已装入的容器"
        buttons={
          <>
            <Button
              icon="recycle"
              tooltip={
                `清空容器，并回收其中弹药基础材料的 ${recyclePercent}%` +
                (recycle_preview ? ` (${recycle_preview})` : '') +
                '。'
              }
              tooltipPosition="bottom-end"
              disabled={!mag_loaded || !current_rounds || system_busy}
              onClick={() => act('RecycleMag')}
            >
              回收
            </Button>
            <Button
              icon="eject"
              tooltip="弹出当前容器。"
              tooltipPosition="bottom-end"
              disabled={!mag_loaded || system_busy}
              onClick={() => act('EjectMag')}
            >
              弹出
            </Button>
          </>
        }
      >
        {/* fixed height so layout holds when no mag loaded */}
        <Box height="3.5rem">
          {!mag_loaded ? (
            <Flex height="100%" align="center" justify="center">
              <Flex.Item color="label" italic>
                <Icon name="inbox" mr={1} />
                未插入容器。插入容器以开始操作。
              </Flex.Item>
            </Flex>
          ) : (
            <>
              <Flex align="center" mb={0.5}>
                <Flex.Item grow color="label">
                  {mag_name}
                </Flex.Item>
                <Flex.Item bold mr={2} style={{ letterSpacing: '1px' }}>
                  {'// '}
                  {{ IDLE: '空闲', FABRICATING: '正在制造', FULL: '已满' }[barState] || barState}
                </Flex.Item>
                <Flex.Item bold>
                  {current_rounds} / {max_rounds}
                </Flex.Item>
              </Flex>
              <SegmentBar
                current={current_rounds}
                max={max_rounds}
                active={system_busy}
              />
              {/* inline cancel while busy */}
              {!!system_busy && (
                <Button
                  fluid
                  mt={0.5}
                  icon="xmark"
                  color="bad"
                  textAlign="center"
                  onClick={() => act('CancelFabrication')}
                >
                  取消操作
                </Button>
              )}
            </>
          )}
        </Box>
      </Section>

      <Section title="可用弹药类型">
        {!mag_loaded && (
          <Box color="label" italic>
            插入容器以列出兼容的弹药。
          </Box>
        )}
        {!!mag_loaded && !available_rounds.length && (
          <Box color="label" italic>
            没有适用于此容器的可制造弹药。
          </Box>
        )}
        {!!mag_loaded &&
          available_rounds.map((available_round) => (
            <Box key={available_round.typepath} mb={0.5}>
              <Tooltip
                content={available_round.mats_list}
                position="bottom-start"
              >
                <Button
                  fluid
                  textAlign="left"
                  disabled={system_busy}
                  onClick={() =>
                    act('FillMagazine', {
                      selected_type: available_round.typepath,
                    })
                  }
                >
                  <Box
                    inline
                    mr={1}
                    style={{
                      width: '0.6rem',
                      height: '0.6rem',
                      borderRadius: '50%',
                      verticalAlign: 'middle',
                      backgroundColor: available_round.tip_color || '#888780',
                      boxShadow: `0 0 3px ${available_round.tip_color || '#888780'}`,
                    }}
                  />
                  {available_round.name}
                </Button>
              </Tooltip>
            </Box>
          ))}
      </Section>

      {!!hacked && (
        <NoticeBox textAlign="center" color="bad">
          警告！阿玛达因安全协议未启用！因使用不当导致的损坏
          不在保修范围内。某些弹药类型在您所在地区可能涉及战争罪。
          请立即联系阿玛达因管理员。
        </NoticeBox>
      )}
    </>
  );
};

export const DatadiskTab = (props) => {
  const { act, data } = useBackend();
  const {
    loaded_datadisks = [],
    datadisk_loaded,
    datadisk_name,
    datadisk_desc,
    disk_error,
    disk_error_type,
  } = data;
  return (
    <>
      <Box height="2.5rem" mb={0.5}>
        {!!disk_error && (
          <NoticeBox textAlign="center" color={disk_error_type}>
            {disk_error}
          </NoticeBox>
        )}
      </Box>
      <Section
        title="数据盘"
        buttons={
          <>
            <Button
              icon="save"
              disabled={!datadisk_loaded}
              onClick={() => act('ReadDisk')}
            >
              读取磁盘
            </Button>
            <Button
              icon="eject"
              disabled={!datadisk_loaded}
              onClick={() => act('EjectDisk')}
            >
              弹出
            </Button>
          </>
        }
      >
        <Box minHeight="3rem">
          {datadisk_loaded ? (
            <Box>
              <Box bold mb={0.5}>
                {datadisk_name}
              </Box>
              <Box color="label">{datadisk_desc}</Box>
            </Box>
          ) : (
            <Flex height="3rem" align="center" justify="center">
              <Flex.Item color="label" italic>
                未插入数据盘。
              </Flex.Item>
            </Flex>
          )}
        </Box>
      </Section>
      <Section title="已安装的配方数据" mt={1}>
        {!loaded_datadisks.length && (
          <Box color="label" italic>
            未安装配方数据。
          </Box>
        )}
        <Table>
          {loaded_datadisks.map((loaded_datadisk) => (
            <Table.Row key={loaded_datadisk.loaded_disk_name} mb={0.5}>
              <Table.Cell bold>{loaded_datadisk.loaded_disk_name}</Table.Cell>
              <Table.Cell color="label">
                {loaded_datadisk.loaded_disk_desc}
              </Table.Cell>
            </Table.Row>
          ))}
        </Table>
      </Section>
    </>
  );
};

// Four-bar signal-strength gauge (one bar per part tier), lit to `level`.
const SignalBars = (props) => {
  const level = props.level || 0;
  const heights = [4, 7, 10, 13];
  return (
    <Box inline style={{ whiteSpace: 'nowrap', lineHeight: 0 }}>
      {heights.map((h, i) => (
        <Box
          key={i}
          inline
          style={{
            width: '4px',
            height: `${h}px`,
            marginRight: i < 3 ? '2px' : 0,
            verticalAlign: 'bottom',
            borderRadius: '1px',
            backgroundColor:
              i < level ? '#7bbd2a' : 'rgba(255, 255, 255, 0.15)',
          }}
        />
      ))}
    </Box>
  );
};

// Capacity gauge: continuous fill with per-round dividers (up to SEGMENT_CAP).
const SEGMENT_CAP = 40;

const SegmentBar = (props) => {
  const { current, max, active } = props;
  const litColor = '#7bbd2a';
  const frac = max > 0 ? current / max : 0;
  const bg = 'rgba(255, 255, 255, 0.06)';

  // single animated fill + gap-colored dividers = synced segmented look
  const showSegments = max > 1 && max <= SEGMENT_CAP;
  const dividers = [];
  if (showSegments) {
    for (let i = 1; i < max; i++) {
      dividers.push(
        <Box
          key={i}
          style={{
            position: 'absolute',
            top: 0,
            bottom: 0,
            left: `calc(${(i / max) * 100}% - 1px)`,
            width: '2px',
            backgroundColor: '#0b1109',
          }}
        />,
      );
    }
  }

  return (
    <Box
      style={{
        position: 'relative',
        height: '1.25rem',
        borderRadius: '2px',
        border: '1px solid rgba(255,255,255,0.15)',
        overflow: 'hidden',
        backgroundColor: bg,
      }}
    >
      <Box
        className={active ? 'AmmoWorkbench__barberpole' : undefined}
        style={{
          position: 'absolute',
          top: 0,
          bottom: 0,
          left: 0,
          width: `${frac * 100}%`,
          backgroundColor: active ? undefined : litColor,
        }}
      />
      {dividers}
    </Box>
  );
};
