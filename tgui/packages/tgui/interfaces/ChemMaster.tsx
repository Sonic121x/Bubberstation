import { useState } from 'react';
import {
  AnimatedNumber,
  Box,
  Button,
  ColorBox,
  Divider,
  Icon,
  ImageButton,
  LabeledList,
  NumberInput,
  ProgressBar,
  Section,
  Stack,
  Table,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { capitalize } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import type { Beaker, BeakerReagent } from './common/BeakerDisplay';
import { chemPackagingDisplay } from '../localization/chemPackagingDisplay';
type Container = {
  icon: string;
  icon_state: string;
  ref: string;
  name: string;
  volume: number;
};

type Category = {
  name: string;
  containers: Container[];
};

type AnalyzableReagent = BeakerReagent & {
  ref: string;
  pH: number;
  color: string;
  description: string;
  purity: number;
  metaRate: number;
  overdose: number;
  addictionTypes: string[];
};

type AnalyzableBeaker = {
  contents: AnalyzableReagent[];
} & Beaker;

type Data = {
  categories: Category[];
  isPrinting: BooleanLike;
  customTransferAmount: number;
  printingProgress: number;
  printingTotal: number;
  selectedPillDuration: number;
  maxPrintable: number;
  maxPillDuration: number;
  beaker: AnalyzableBeaker;
  buffer: AnalyzableBeaker;
  isTransfering: BooleanLike;
  suggestedContainerRef: string;
  selectedContainerRef: string;
  selectedContainerVolume: number;
  selectedContainerCategory?: string;
  hasBeakerInHand: BooleanLike;
};

export const ChemMaster = (props) => {
  const [analyzedReagent, setAnalyzedReagent] = useState<AnalyzableReagent>();

  return (
    <Window width={450} height={620}>
      <Window.Content scrollable>
        {analyzedReagent ? (
          <AnalysisResults
            analysisData={analyzedReagent}
            onExit={() => setAnalyzedReagent(undefined)}
          />
        ) : (
          <ChemMasterContent
            analyze={(chemical: AnalyzableReagent) =>
              setAnalyzedReagent(chemical)
            }
          />
        )}
      </Window.Content>
    </Window>
  );
};

const ChemMasterContent = (props: {
  analyze: (chemical: AnalyzableReagent) => void;
}) => {
  const { act, data } = useBackend<Data>();
  const {
    isPrinting,
    customTransferAmount,
    printingProgress,
    printingTotal,
    selectedPillDuration,
    maxPrintable,
    maxPillDuration,
    isTransfering,
    beaker,
    buffer,
    categories,
    selectedContainerVolume,
    selectedContainerCategory,
    hasBeakerInHand,
  } = data;

  const [itemCount, setItemCount] = useState<number>(1);
  const [showPreferredContainer, setShowPreferredContainer] =
    useState<BooleanLike>(false);
  const buffer_contents = buffer.contents;

  return (
    <Box>
      <Section
        title="烧杯"
        buttons={
          beaker ? (
            <Box>
              <Box inline color="label" mr={2}>
                <AnimatedNumber value={beaker.currentVolume} initial={0} />
                {` / ${beaker.maxVolume} 单位`}
              </Box>
              <Box inline color="label" mr={2}>
                <NumberInput
                  width="55px"
                  unit="u"
                  step={5}
                  stepPixelSize={3}
                  value={customTransferAmount}
                  minValue={0}
                  maxValue={beaker.maxVolume}
                  onChange={(value) =>
                    act('setCustomTransfer', {
                      target: value,
                    })
                  }
                />
              </Box>
              <Button icon="eject" onClick={() => act('eject')}>
                弹出
              </Button>
            </Box>
          ) : (
            <Button
              icon="eject"
              onClick={() => act('insert')}
              style={{
                opacity: hasBeakerInHand ? 1 : 0.5,
              }}
              tooltip={
                !hasBeakerInHand && '你需要手持一个容器'
              }
              tooltipPosition="bottom-start"
            >
              插入
            </Button>
          )
        }
      >
        {!beaker ? (
          <Box color="label" my={'4px'}>
            未装入烧杯。
          </Box>
        ) : beaker.currentVolume === 0 ? (
          <Box color="label" my={'4px'}>
            烧杯为空。
          </Box>
        ) : (
          <Table>
            {beaker.contents.map((chemical) => (
              <ReagentEntry
                key={chemical.ref}
                chemical={chemical}
                transferTo="buffer"
                analyze={props.analyze}
              />
            ))}
          </Table>
        )}
      </Section>
      <Section
        title="缓冲槽"
        buttons={
          <>
            <Box inline color="label" mr={1}>
              <AnimatedNumber value={buffer.currentVolume} initial={0} />
              {` / ${buffer.maxVolume} 单位`}
            </Box>
            <Button
              color={isTransfering ? 'good' : 'bad'}
              icon={isTransfering ? 'exchange-alt' : 'trash'}
              onClick={() => act('toggleTransferMode')}
            >
              {isTransfering ? '转移试剂' : '销毁试剂'}
            </Button>
          </>
        }
      >
        {buffer_contents.length === 0 ? (
          <Box color="label" my={'4px'}>
            缓冲槽为空。
          </Box>
        ) : (
          <Table>
            {buffer_contents.map((chemical) => (
              <ReagentEntry
                key={chemical.ref}
                chemical={chemical}
                transferTo="beaker"
                analyze={props.analyze}
              />
            ))}
          </Table>
        )}
      </Section>
      {!isPrinting && (
        <Section
          title="分装"
          buttons={
            buffer_contents.length !== 0 && (
              <Box>
                <Button.Checkbox
                  checked={showPreferredContainer}
                  onClick={() =>
                    setShowPreferredContainer((currentValue) => !currentValue)
                  }
                >
                  推荐容器
                </Button.Checkbox>
                <NumberInput
                  unit={'件'}
                  step={1}
                  value={itemCount}
                  minValue={1}
                  maxValue={maxPrintable}
                  onChange={(value) => {
                    setItemCount(value);
                  }}
                />
                {selectedContainerCategory === 'pills' && (
                  <NumberInput
                    unit="s"
                    step={1}
                    value={selectedPillDuration}
                    minValue={0}
                    maxValue={maxPillDuration}
                    onChange={(value) => {
                      act('setPillDuration', {
                        duration: value,
                      });
                    }}
                  />
                )}
                <Box inline mx={1}>
                  {`${
                    Math.round(
                      Math.min(
                        selectedContainerVolume,
                        buffer.currentVolume / itemCount,
                      ) * 100,
                    ) / 100
                  } 单位/件`}
                </Box>
                <Button
                  icon="flask"
                  onClick={() =>
                    act('create', {
                      itemCount: itemCount,
                    })
                  }
                >
                  制作
                </Button>
              </Box>
            )
          }
        >
          {categories.map((category) => (
            <Box key={category.name}>
              <GroupTitle title={category.name} />
              {category.containers.map((container) => (
                <ContainerButton
                  key={container.ref}
                  category={category}
                  container={container}
                  showPreferredContainer={showPreferredContainer}
                />
              ))}
            </Box>
          ))}
        </Section>
      )}
      {!!isPrinting && (
        <Section
          title="制作中"
          buttons={
            <Button
              color="bad"
              icon="times"
              onClick={() => act('stopPrinting')}
            >
              停止
            </Button>
          }
        >
          <ProgressBar
            value={printingProgress}
            minValue={0}
            maxValue={printingTotal}
            color="good"
          >
            <Box
              lineHeight={1.9}
              style={{
                textShadow: '1px 1px 0 black',
              }}
            >
              {`制作进度：${printingProgress} / ${printingTotal}`}
            </Box>
          </ProgressBar>
        </Section>
      )}
    </Box>
  );
};

type ReagentProps = {
  chemical: AnalyzableReagent;
  transferTo: string;
  analyze: (chemical: AnalyzableReagent) => void;
};

const ReagentEntry = (props: ReagentProps) => {
  const { data, act } = useBackend<Data>();
  const { chemical, transferTo, analyze } = props;
  const { isPrinting, customTransferAmount } = data;
  return (
    <Table.Row key={chemical.ref}>
      <Table.Cell color="label">
        {`${chemical.name} `}
        <AnimatedNumber value={chemical.volume} initial={0} />
        {'u'}
      </Table.Cell>
      <Table.Cell collapsing>
        <Button
          disabled={isPrinting}
          onClick={() => {
            act('transfer', {
              reagentRef: chemical.ref,
              amount: 1,
              target: transferTo,
            });
          }}
        >
          1
        </Button>
        <Button
          disabled={isPrinting}
          onClick={() =>
            act('transfer', {
              reagentRef: chemical.ref,
              amount: 5,
              target: transferTo,
            })
          }
        >
          5
        </Button>
        <Button
          disabled={isPrinting}
          onClick={() =>
            act('transfer', {
              reagentRef: chemical.ref,
              amount: 10,
              target: transferTo,
            })
          }
        >
          10
        </Button>
        <Button
          disabled={isPrinting}
          onClick={() =>
            act('transfer', {
              reagentRef: chemical.ref,
              amount: customTransferAmount,
              target: transferTo,
            })
          }
        >
          {customTransferAmount}
        </Button>
        <Button
          disabled={isPrinting}
          onClick={() =>
            act('transfer', {
              reagentRef: chemical.ref,
              amount: 1000,
              target: transferTo,
            })
          }
        >
          全部
        </Button>
        <Button
          icon="ellipsis-h"
          tooltip="自定义用量"
          disabled={isPrinting}
          onClick={() =>
            act('transfer', {
              reagentRef: chemical.ref,
              amount: -1,
              target: transferTo,
            })
          }
        />
        <Button
          icon="question"
          tooltip="分析"
          onClick={() => analyze(chemical)}
        />
      </Table.Cell>
    </Table.Row>
  );
};

type CategoryButtonProps = {
  category: Category;
  container: Container;
  showPreferredContainer: BooleanLike;
};

const ContainerButton = (props: CategoryButtonProps) => {
  const { act, data } = useBackend<Data>();
  const { isPrinting, selectedContainerRef, suggestedContainerRef } = data;
  const { category, container, showPreferredContainer } = props;
  const isPillPatch = ['pills', 'patches'].includes(category.name);
  const fallback = <Icon m="18px" name="spinner" spin />;
  const fallbackPillPatch = <Icon m="10px" name="spinner" spin />;

  return (
    <Tooltip
      key={container.ref}
      content={`${capitalize(container.name)}\xa0(${container.volume}u)`}
    >
      <ImageButton
        dmIcon={container.icon}
        dmIconState={container.icon_state}
        dmFallback={isPillPatch ? fallbackPillPatch : fallback}
        imageSize={isPillPatch ? 48 : 64}
        color={
          showPreferredContainer &&
          selectedContainerRef !== suggestedContainerRef && // if we selected the same container as the suggested then don't override color
          container.ref === suggestedContainerRef
            ? 'blue'
            : 'transparent'
        }
        selected={container.ref === selectedContainerRef}
        disabled={isPrinting}
        m={isPillPatch ? '4px' : '2px'}
        p={0}
        onClick={() => {
          act('selectContainer', {
            ref: container.ref,
          });
        }}
      />
    </Tooltip>
  );
};

const AnalysisResults = (props: {
  analysisData: AnalyzableReagent;
  onExit: () => void;
}) => {
  const {
    name,
    pH,
    color,
    description,
    purity,
    metaRate,
    overdose,
    addictionTypes,
  } = props.analysisData;

  const purityLevel =
    purity <= 0.5 ? 'bad' : purity <= 0.75 ? 'average' : 'good'; // Color names

  return (
    <Section
      title="分析结果"
      buttons={
        <Button icon="arrow-left" onClick={() => props.onExit()}>
          返回
        </Button>
      }
    >
      <LabeledList>
        <LabeledList.Item label="名称">{name}</LabeledList.Item>
        <LabeledList.Item label="纯度">
          <Box
            style={{
              textTransform: 'capitalize',
            }}
            color={purityLevel}
          >
            {{ bad: '低', average: '中', good: '高' }[purityLevel]}
          </Box>
        </LabeledList.Item>
        <LabeledList.Item label="pH">{pH}</LabeledList.Item>
        <LabeledList.Item label="颜色">
          <ColorBox color={color} mr={1} />
          {color}
        </LabeledList.Item>
        <LabeledList.Item label="描述">{description}</LabeledList.Item>
        <LabeledList.Item label="代谢速率">
          {metaRate} 单位/秒
        </LabeledList.Item>
        <LabeledList.Item label="过量阈值">
          {overdose > 0 ? `${overdose} 单位` : '不适用'}
        </LabeledList.Item>
        <LabeledList.Item label="成瘾类型">
          {addictionTypes.length ? addictionTypes.toString() : '不适用'}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const GroupTitle = ({ title }) => {
  return (
    <Stack my={1}>
      <Stack.Item grow>
        <Divider />
      </Stack.Item>
      <Stack.Item
        style={{
          textTransform: 'capitalize',
        }}
        color={'gray'}
      >
        {chemPackagingDisplay(title)}
      </Stack.Item>
      <Stack.Item grow>
        <Divider />
      </Stack.Item>
    </Stack>
  );
};
