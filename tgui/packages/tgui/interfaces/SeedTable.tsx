import { sortBy } from 'es-toolkit';
import { useState } from 'react';
import {
  Box,
  Button,
  Icon,
  Input,
  NoticeBox,
  ProgressBar,
  Section,
  Table,
  Tooltip,
  DmIcon,
} from 'tgui-core/components';
import { createSearch } from 'tgui-core/string';
import { formatTime } from 'tgui-core/format';

export type TraitData = {
  path: string;
  name: string;
  icon: string;
  description: string;
};

type ReagentData = {
  name: string;
  rate: number;
};

export type SeedData = {
  key: string;
  amount?: number;
  name: string;
  lifespan: number;
  endurance: number;
  maturation: number;
  production: number;
  yield: number;
  potency: number;
  instability: number;
  icon: string;
  icon_state: string;
  volume_mod: number;
  volume_units: number;
  traits: string[];
  reagents: ReagentData[];
  mutatelist: string[];
  grind_results: string[];
  distill_reagent: string;
  juice_name: string;
};

type SeedTableProps = {
  // Dynamic
  seeds: SeedData[];
  // Static
  trait_db: TraitData[];
  cycle_seconds: number;
  renderActions?: (item: SeedData) => React.ReactNode;
};

export const SeedTable = (props: SeedTableProps) => {
  const [searchText, setSearchText] = useState('');
  const [sortField, setSortField] = useState('name');
  const search = createSearch(searchText, (item: SeedData) => item.name);
  const seeds_filtered =
    searchText.length > 0 ? props.seeds.filter(search) : props.seeds;
  const seeds_sorted = sortBy(seeds_filtered || [], [
    (item: SeedData) => item[sortField as keyof SeedData],
  ]);
  sortField !== 'name' && seeds_sorted.reverse();

  return (
    <Section>
      <Table>
        <Table.Row header>
          <Table.Cell colSpan={3} px={1} py={2}>
            <Input
              autoFocus
              placeholder="搜索……"
              value={searchText}
              onChange={setSearchText}
              fluid
            />
          </Table.Cell>
          <Table.Cell collapsing p={1}>
            <Tooltip
              content={
                '效力：决定产物质量、试剂体积和效果强度。'
              }
            >
              <Box
                style={{ cursor: 'pointer', textAlign: "center" }}
                onClick={(e) => setSortField('potency')}
              >
                效力
              </Box>
            </Tooltip>
          </Table.Cell>
          <Table.Cell collapsing p={1}>
            <Tooltip
              content={
                '产量：每次收获获得的产物数量。'
              }
            >
              <Box
                style={{ cursor: 'pointer', textAlign: "center" }}
                onClick={(e) => setSortField('yield')}
              >
                产量
              </Box>
            </Tooltip>
          </Table.Cell>
          <Table.Cell collapsing p={1}>
            <Tooltip
              content={
                '不稳定性：植物属性随机变化或发生变异的概率。影响制成食品和饮品的品质。'
              }
            >
              <Box
                style={{ cursor: 'pointer', textAlign: "center" }}
                onClick={(e) => setSortField('instability')}
              >
                不稳定性
              </Box>
            </Tooltip>
          </Table.Cell>
          <Table.Cell collapsing p={1}>
            <Tooltip
              content={
                '耐久：植物的生命值，可延缓死亡。提高制成食品和饮品的品质。'
              }
            >
              <Box
                style={{ cursor: 'pointer', textAlign: "center" }}
                onClick={(e) => setSortField('endurance')}
              >
                耐久
              </Box>
            </Tooltip>
          </Table.Cell>
          <Table.Cell collapsing p={1}>
            <Tooltip
              content={`寿命：植物开始衰老的年龄。提高制成食品和饮品的品质。`}
            >
              <Box
                style={{ cursor: 'pointer', textAlign: "center" }}
                onClick={(e) => setSortField('lifespan')}
              >
                寿命
              </Box>
            </Tooltip>
          </Table.Cell>
          <Table.Cell collapsing p={1}>
            <Tooltip
              content={`成熟期：首次收获所需的生长时间。`}
            >
              <Box
                style={{ cursor: 'pointer', textAlign: "center" }}
                onClick={(e) => setSortField('maturation')}
              >
                成熟期
              </Box>
            </Tooltip>
          </Table.Cell>
          <Table.Cell collapsing p={1}>
            <Tooltip
              content={`生产周期：再次结出产物所需的时间。`}
            >
              <Box
                style={{ cursor: 'pointer', textAlign: "center" }}
                onClick={(e) => setSortField('production')}
              >
                生产周期
              </Box>
            </Tooltip>
          </Table.Cell>
          <Table.Cell collapsing p={1} textAlign="right">
            {sortField !== 'name' && (
              <Tooltip content="重置排序">
                <Button
                  color="transparent"
                  icon="refresh"
                  onClick={(e) => setSortField('name')}
                />
              </Tooltip>
            )}
            <Box align="right" />
          </Table.Cell>
        </Table.Row>
        {seeds_sorted.length > 0 &&
          seeds_sorted.map((item) => (
            <Table.Row
              key={item.key}
              style={{ borderTop: '2px solid #222' }}
            >
              <Table.Cell collapsing>
                <DmIcon
                  mb={-2}
                  icon={item.icon}
                  icon_state={item.icon_state}
                  width="32px"
                  height="32px"
                />
              </Table.Cell>
              <Table.Cell py={0.5} px={1}>
                {`${item.amount ? `${item.amount}x ` : ''}${item.name}`}
              </Table.Cell>
              <Table.Cell py={0.5} px={1} collapsing textAlign={'right'}>
                {item.traits?.map((trait) => (
                  <TraitTooltip
                    key=""
                    path={trait}
                    trait_db={props.trait_db}
                  />
                ))}
                {!!item.mutatelist.length && (
                  <Tooltip
                    content={`可变异为：${item.mutatelist.join('、')}`}
                  >
                    <Icon name="dna" m={0.5} />
                  </Tooltip>
                )}
                {item.reagents.length > 0 && (
                  <Tooltip
                    content={
                      <ReagentTooltip
                        reagents={item.reagents}
                        grind_results={item.grind_results}
                        potency={item.potency}
                        volume_mod={item.volume_mod}
                        volume_units={item.volume_units}
                      />
                    }
                  >
                    <Icon name="blender" m={0.5} />
                  </Tooltip>
                )}
                {!!item.juice_name && (
                  <Tooltip content={`榨汁产物：${item.juice_name}`}>
                    <Icon name="glass-water" m={0.5} />
                  </Tooltip>
                )}
                {!!item.distill_reagent && (
                  <Tooltip
                    content={`发酵产物：${item.distill_reagent}`}
                  >
                    <Icon name="wine-bottle" m={0.5} />
                  </Tooltip>
                )}
              </Table.Cell>
              <Table.Cell px={1} collapsing>
                <Level value={item.potency} max={100} />
              </Table.Cell>
              <Table.Cell py={0.5} px={1} collapsing>
                <Level value={item.yield} max={10} />
              </Table.Cell>
              <Table.Cell py={0.5} px={1} collapsing>
                <Level value={item.instability} max={100} reverse />
              </Table.Cell>
              <Table.Cell py={0.5} px={1} collapsing>
                <Level value={item.endurance} max={100} />
              </Table.Cell>
              <Table.Cell py={0.5} px={1} collapsing>
                <Box textAlign="center">{formatTime(item.lifespan * props.cycle_seconds * 10, 'short')}</Box>
              </Table.Cell>
              <Table.Cell py={0.5} px={1} collapsing>
                <Box textAlign="center">{formatTime(item.maturation * props.cycle_seconds * 10, 'short')}</Box>
              </Table.Cell>
              <Table.Cell py={0.5} px={1} collapsing>
                <Box textAlign="center">{formatTime(item.production * props.cycle_seconds * 10, 'short')}</Box>
              </Table.Cell>
              <Table.Cell
                py={0.5}
                px={1}
                collapsing
                colSpan={2}
                textAlign="right"
              >
                {props.renderActions?.(item)}
              </Table.Cell>
            </Table.Row>
          ))}
      </Table>
      {seeds_sorted.length === 0 && (
        <NoticeBox m={1} p={1}>
          未找到种子。
        </NoticeBox>
      )}
    </Section>
  )
}

export const Level = (props) => {
  return (
    <ProgressBar
      value={props.value}
      maxValue={props.max}
      ranges={
        props.reverse
          ? {
              good: [0, props.max * 0.2],
              average: [props.max * 0.2, props.max * 0.6],
              bad: [props.max * 0.6, props.max],
            }
          : {
              bad: [0, props.max * 0.2],
              good: [props.max * 0.8, props.max],
            }
      }
    >
      <span
        style={{
          textShadow: '1px 1px 0 black',
        }}
      >
        {props.value}
      </span>
    </ProgressBar>
  );
};

export const ReagentTooltip = (props) => {
  let rate_total = 0;
  props.reagents.forEach((reagent) => {
    rate_total += reagent.rate;
  });
  const reagent_volumes: number[] = [];
  const reagent_percentages: number[] = [];
  props.reagents.forEach((reagent) => {
    reagent_percentages.push(reagent.rate / Math.max(1, rate_total));
    reagent_volumes.push(
      Math.max(
        Math.round(
          props.volume_units *
            (props.potency / 100) *
            (reagent.rate / Math.max(1, rate_total)) *
            props.volume_mod,
        ),
        1,
      ),
    );
  });
  return (
    <Table>
      <Table.Row header>
        <Table.Cell colSpan={3}>研磨获得的试剂：</Table.Cell>
      </Table.Row>
      {props.reagents?.map((reagent, i) => (
        <Table.Row key={i}>
          <Table.Cell>{reagent.name}</Table.Cell>
          <Table.Cell py={0.5} pl={2} textAlign={'right'}>
            {reagent_volumes[i]}u
          </Table.Cell>
          <Table.Cell py={0.5} pl={2} textAlign={'right'}>
            {rate_total > 1 && '~'}
            {Math.round(reagent_percentages[i] * 100)}%
          </Table.Cell>
        </Table.Row>
      ))}
      <Table.Row>
        <Table.Cell colSpan={3} style={{ borderTop: '1px dotted gray' }} />
      </Table.Row>
      <Table.Row header>
        <Table.Cell pt={1.5}>合计</Table.Cell>
        <Table.Cell py={0.5} pl={2} textAlign={'right'}>
          {Math.round(reagent_volumes.reduce((a, b) => a + b))}u
        </Table.Cell>
        <Table.Cell py={0.5} pl={2} textAlign={'right'}>
          {Math.round(rate_total * 100)}%
        </Table.Cell>
      </Table.Row>
      <Table.Row header>
        <Table.Cell>容量</Table.Cell>
        <Table.Cell py={0.5} pl={2} textAlign={'right'}>
          {props.volume_units}u
        </Table.Cell>
        <Table.Cell />
      </Table.Row>
      {!!props.grind_results.length && (
        <>
          <Table.Row>
            <Table.Cell colSpan={3} style={{ borderTop: '1px dotted gray' }} />
          </Table.Row>
          <Table.Row header>
            <Table.Cell colSpan={3} pt={1}>
              营养物转化为：
            </Table.Cell>
          </Table.Row>
          {props.grind_results?.map((reagent, i) => (
            <Table.Row key={i}>
              <Table.Cell colSpan={3}>{reagent}</Table.Cell>
            </Table.Row>
          ))}
        </>
      )}
    </Table>
  );
};

export const TraitTooltip = (props) => {
  const trait = props.trait_db.find((t) => {
    return t.path === props.path;
  });
  if (!trait) {
    return;
  }
  return (
    <Tooltip
      content={
        <Table>
          {!!props.grafting && (
            <Table.Row>
              <Table.Cell pb={1}>嫁接后获得以下特征：</Table.Cell>
            </Table.Row>
          )}
          <Table.Row header>
            <Table.Cell>
              <Icon name={trait.icon} mr={1} />
              {trait.name}
            </Table.Cell>
          </Table.Row>
          {!!props.removable && (
            <Table.Row>
              <Table.Cell pb={1}>可移除的特征。</Table.Cell>
            </Table.Row>
          )}
          {!!trait.description && (
            <Table.Row>
              <Table.Cell>{trait.description}</Table.Cell>
            </Table.Row>
          )}
        </Table>
      }
    >
      <Icon name={props.grafting ? 'scissors' : trait.icon} m={0.5} />
    </Tooltip>
  );
};
