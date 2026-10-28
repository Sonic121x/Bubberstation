import { useEffect, useMemo, useRef, useState } from 'react';
import { Blink, Box, Button, Section, Stack } from 'tgui-core/components';
import { formatMoney } from 'tgui-core/format';
import { classes } from 'tgui-core/react';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  symbols: SlotSymbol[];
  reels: Reel[];
  balance: number;
  working: number;
  winning: number;
  money: number;
  cost: number;
  plays: number;
  jackpots: number;
  jackpot: number;
  paymode: number;
  jackpot_id: string;
  trap_id: string;
};

type SlotSymbol = {
  id: string;
  icon_id: string;
};

type Reel = {
  symbols: string[];
};

const pluralS = (amount: number) => {
  return '';
};

const pickRandomMany = <T,>(items: T[], n: number) => {
  const result: T[] = [];
  for (let i = 0; i < n; i += 1) {
    result.push(pickRandom(items));
  }
  return result;
};

const pickRandom = <T,>(items: T[]) => {
  return items[Math.floor(Math.random() * items.length)];
};

export const SlotMachine = () => {
  const { act, data } = useBackend<Data>();
  const { symbols, cost, reels, balance } = data;
  const spinning = data.working === 1;

  const symbolsById = useMemo(() => {
    const map: Record<string, SlotSymbol> = {};
    for (const symbol of symbols) {
      map[symbol.id] = symbol;
    }
    return map;
  }, [symbols]);

  const jackpotSymbol = symbolsById[data.jackpot_id];
  const trapSymbol = data.trap_id ? symbolsById[data.trap_id] : null;

  return (
    <Window width={300} height={445}>
      <Window.Content>
        <Banner />
        <Section>
          <div className={'SlotMachine__Reels'}>
            {reels.map((reel, i) => (
              <div key={i} className={'SlotMachine__Reel'}>
                <IconStrip
                  symbols={symbols}
                  symbolsById={symbolsById}
                  symbolsNeeded={reel.symbols}
                  spinning={spinning}
                />
              </div>
            ))}
          </div>
        </Section>
        <Stack vertical fill>
          <Stack.Item>
            <Section fill align={'center'}>
              <Box inline textAlign={'center'} color="good" bold>
                头奖：
              </Box>
              {jackpotSymbol && (
                <Box
                  className={classes([
                    'slotmachines32x32',
                    jackpotSymbol.icon_id,
                  ])}
                  style={{ verticalAlign: 'middle' }}
                />
              )}

              {trapSymbol && (
                <>
                  <Box inline color="bad" bold ml={5} mr={1}>
                    陷阱：
                  </Box>
                  <Box
                    className={classes([
                      'slotmachines32x32',
                      trapSymbol.icon_id,
                    ])}
                    style={{ verticalAlign: 'middle' }}
                  />
                </>
              )}
            </Section>
          </Stack.Item>
          <Stack.Item grow={1}>
            <Stack align={'stretch'}>
              <Stack.Item grow={1}>
                <Section
                  fill
                  title="余额"
                  buttons={
                    <Button
                      onClick={() => act('payout')}
                      disabled={balance <= 0}
                    >
                      退还余额
                    </Button>
                  }
                >
                  <Box textAlign={'center'} fontSize={2}>
                    {formatMoney(balance)} 信用点
                  </Box>
                </Section>
              </Stack.Item>
              <Stack.Item grow={1}>
                <Section fill>
                  <Button
                    fluid
                    textAlign={'center'}
                    fontSize={3}
                    color={'green'}
                    onClick={() => act('spin')}
                    disabled={spinning || balance < cost}
                  >
                    转动！
                  </Button>
                </Section>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const getBannerPages = () => [
  BannerTitle,
  BannerOnlyFewCreds,
  BannerPrizeMoney,
  BannerTitle,
  BannerJackpot,
  BannerStats,
];

const BANNER_TEXTS = [
  '转！转！',
  '热身完毕！',
  '火热老虎机',
  '一转就赢！',
  '相信自己！',
  '从零到英雄！',
  '再来一次',
  '命运之转',
  '奖励时间！',
  '为转动而生！',
  '转得漂亮！',
  '不转怎能赢',
  '下注忘烦恼',
  '丑叫求好运',
  '负债一辈子',
  '转动奇点',
  '转盘之城',
  '烧钱来赚钱',
  '头奖就要来！',
  '今天大获全胜！',
  '财富在召唤',
  '马上发财！',
  '梦想再大点！',
  '赢家专属！',
  '转动即人生',
  '大奖马上到！',
  '幸运一转！',
  '提现？不！',
];

const WINNING_TEXTS = [
  null,
  '免费转动！',
  '中奖！',
  '大奖！',
  '头奖！！！',
];

const Banner = () => {
  const { data } = useBackend<Data>();
  const [page, setPage] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setPage((page) => (page + 1) % getBannerPages().length);
    }, 5000);
    return () => clearInterval(interval);
  }, []);

  const winningText = WINNING_TEXTS[data.winning];
  if (winningText) {
    return (
      <Section className={'SlotMachine__Banner SlotMachine__Banner--winning'}>
        <BannerTitle text={winningText} />
      </Section>
    );
  }

  const Component = getBannerPages()[page];

  return (
    <Section className={'SlotMachine__Banner'}>
      <Component />
    </Section>
  );
};

type BannerTitleProps = {
  text?: string;
};

const BannerTitle = (props: BannerTitleProps) => {
  const { data } = useBackend<Data>();
  const defaultText = useRef(pickRandom(BANNER_TEXTS));
  let text = props.text;
  if (!text) {
    if (data.balance <= 0) {
      text = '请投币';
    } else if (data.balance <= 5) {
      text = '最后再转一次';
    } else {
      text = defaultText.current;
    }
  }
  const letters = text.split('');
  return (
    <div className={'SlotMachine__BannerTitle'}>
      {letters.map((letter, i) => (
        <span key={i}>{letter}</span>
      ))}
    </div>
  );
};

const BannerOnlyFewCreds = () => {
  const { data } = useBackend<Data>();
  const variant = useRef(pickRandom([0, 1]));

  if (variant.current === 1) {
    return (
      <div>
        只需{' '}
        <Blink interval={200} time={200}>
          <b>{data.cost}</b>
        </Blink>{' '}
        信用点{pluralS(data.cost)}！
        <br />
        <Box inline fontSize={'12px'}>
          一次解决所有烦恼！
        </Box>
      </div>
    );
  }

  return (
    <div>
      只需{' '}
      <Blink interval={200} time={200}>
        <b>{data.cost}</b>
      </Blink>{' '}
      信用点{pluralS(data.cost)}就有机会
      <br />
      赢得<b>大奖</b>！
    </div>
  );
};

const BannerPrizeMoney = () => {
  const { data } = useBackend<Data>();
  return (
    <div>
      可赢取奖金：
      <br />
      <b>
        {data.money} 信用点{pluralS(data.money)}
      </b>
    </div>
  );
};

const BannerJackpot = () => {
  const { data } = useBackend<Data>();
  return (
    <div>
      当前头奖：
      <br />
      <b>
        {data.money + data.jackpot} 信用点{pluralS(data.money + data.jackpot)}！
      </b>
    </div>
  );
};

const BannerStats = () => {
  const { data } = useBackend<Data>();
  return (
    <div>
      <Box inline fontSize={'13px'}>
        迄今玩家已转动{' '}
        <b>
          {data.plays} 次{pluralS(data.plays)}
        </b>
      </Box>
      <br />
      并赢得{' '}
      <b>
        {data.jackpots} 次头奖{pluralS(data.jackpots)}！
      </b>
    </div>
  );
};

const ICON_STRIP_LENGTH = 30;

type IconStripProps = {
  symbols: SlotSymbol[];
  symbolsById: Record<string, SlotSymbol>;
  symbolsNeeded: string[];
  spinning?: boolean;
};

const IconStrip = (props: IconStripProps) => {
  const { symbols, symbolsById, symbolsNeeded, spinning } = props;
  const symbolIds = useMemo(() => symbols.map((s) => s.id), [symbols]);

  const [drawnSymbols, setDrawnSymbols] = useState<string[]>([
    ...pickRandomMany(symbolIds, ICON_STRIP_LENGTH - 3),
    ...symbolsNeeded,
  ]);

  useEffect(() => {
    if (spinning) {
      setDrawnSymbols((drawn) => [
        ...drawn.slice(-3),
        ...pickRandomMany(symbolIds, ICON_STRIP_LENGTH - 6),
        ...symbolsNeeded,
      ]);
    } else {
      setDrawnSymbols([
        ...pickRandomMany(symbolIds, ICON_STRIP_LENGTH - 3),
        ...symbolsNeeded,
      ]);
    }
  }, [spinning]);

  return (
    <div
      className={classes([
        'SlotMachine__IconStrip',
        spinning && 'SlotMachine__IconStrip--spinning',
      ])}
    >
      {drawnSymbols.map((symbolId, i) => {
        const symbol = symbolsById[symbolId];
        return (
          <div key={i} className="SlotMachine__Symbol">
            {symbol && (
              <Box className={classes(['slotmachines32x32', symbol.icon_id])} />
            )}
          </div>
        );
      })}
    </div>
  );
};
