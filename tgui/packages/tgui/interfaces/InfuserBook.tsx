import { chunk, range } from 'es-toolkit';
import { useState } from 'react';
import {
  BlockQuote,
  Box,
  Button,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { batchThreeDisplay } from '../localization/batchThreeDisplay';
type Entry = {
  name: string;
  infuse_mob_name: string;
  desc: string;
  threshold_desc: string;
  qualities: string[];
  tier: number;
};

type DnaInfuserData = {
  entries: Entry[];
};

type BookPosition = {
  chapter: number;
  pageInChapter: number;
};

type TierData = {
  desc: string;
  icon: string;
  name: string;
};

const PAGE_HEIGHT = 30;

const TIER2TIERDATA: TierData[] = [
  {
    name: '低等变种人',
    desc: `
      低等变种人的潜在突变种类通常较少，
      为多个器官注入 DNA 也不会获得额外加成。常见物种、外观变化
      等都属于此类。始终可用！
    `,
    icon: 'circle-o',
  },
  {
    name: '普通变种人',
    desc: `
      普通变种人都能通过注入 DNA 获得额外加成，
      所需生物较为常见，每个班次通常都能找到。始终可用！
    `,
    icon: 'circle-half-stroke',
  },
  {
    name: '高等变种人',
    desc: `
      高等变种人的优点、缺点和额外加成都更为显著，
      所需生物也更难找到。必须先解锁
      较低等级的 DNA 变种人加成，才能解锁此类。
    `,
    icon: 'circle',
  },
  {
    name: '畸变体',
    desc: `
      我们已成功从培养槽培育的样本中获得更强的变种体，
      将其命名为“畸变体”。畸变体或具有强大的实用
      功能，或具有异常特性，或具有致命能力。
    `,
    icon: 'teeth',
  },
];

export const InfuserBook = (props) => {
  const { data, act } = useBackend<DnaInfuserData>();
  const { entries } = data;

  const [bookPosition, setBookPosition] = useState({
    chapter: 0,
    pageInChapter: 0,
  });
  const { chapter, pageInChapter } = bookPosition;

  const paginatedEntries = paginateEntries(entries);

  const currentEntry = paginatedEntries[chapter][pageInChapter];

  const switchChapter = (newChapter) => {
    if (chapter === newChapter) {
      return;
    }
    setBookPosition({ chapter: newChapter, pageInChapter: 0 });
    act('play_flip_sound'); // just so we can play a sound fx on page turn
  };

  const setPage = (newPage) => {
    const newBookPosition: BookPosition = { ...bookPosition };
    if (newPage < 0) {
      if (newBookPosition.chapter === 0) {
        return;
      }
      newBookPosition.chapter = chapter - 1;
      newBookPosition.pageInChapter = paginatedEntries[chapter - 1].length - 1;
      if (newBookPosition.pageInChapter < 0) {
        newBookPosition.pageInChapter = 0;
      }
    } else if (newPage > paginatedEntries[chapter].length - 1) {
      if (newBookPosition.chapter === 3) {
        return;
      } else {
        newBookPosition.pageInChapter = 0;
        newBookPosition.chapter = chapter + 1;
      }
    } else {
      newBookPosition.pageInChapter = newPage;
    }
    setBookPosition(newBookPosition);
    act('play_flip_sound'); // just so we can play a sound fx on page turn
  };

  const tabs = [
    '简介',
    '0 级——低等变种人',
    '1 级——普通变种人',
    '2 级——高等变种人',
    '3 级——畸变体——限制访问',
  ];

  const paginatedTabs = chunk(tabs, 3);

  const restrictedNext = chapter === 3 && pageInChapter === 0;

  return (
    <Window title="DNA 注入手册" width={620} height={500}>
      <Window.Content>
        <Stack vertical>
          <Stack.Item mb={-1}>
            {paginatedTabs.map((tabRow, i) => (
              <Tabs height="30px" mb="0px" fill fluid key={i}>
                {tabRow.map((tab) => {
                  const tabIndex = tabs.indexOf(tab);
                  const tabIcon = TIER2TIERDATA[tabIndex - 1]
                    ? TIER2TIERDATA[tabIndex - 1].icon
                    : 'info';
                  return (
                    <Tabs.Tab
                      icon={tabIcon}
                      key={tabIndex}
                      selected={chapter === tabIndex}
                      onClick={
                        tabIndex === 4
                          ? undefined
                          : () => switchChapter(tabIndex)
                      }
                    >
                      <Box color={tabIndex === 4 && 'red'}>{tab}</Box>
                    </Tabs.Tab>
                  );
                })}
              </Tabs>
            ))}
          </Stack.Item>
          <Stack.Item>
            {chapter === 0 ? (
              <InfuserInstructions />
            ) : (
              <InfuserEntry entry={currentEntry} />
            )}
          </Stack.Item>
          <Stack.Item textAlign="center">
            <Stack fontSize="18px" fill>
              <Stack.Item grow={2}>
                <Button onClick={() => setPage(pageInChapter - 1)} fluid>
                  上一页
                </Button>
              </Stack.Item>
              <Stack.Item grow={1}>
                <Section fitted fill pt="3px">
                  页码 {pageInChapter + 1}/
                  {paginatedEntries[chapter].length + (chapter === 0 ? 1 : 0)}
                </Section>
              </Stack.Item>
              <Stack.Item grow={2}>
                <Button
                  color={restrictedNext && 'black'}
                  onClick={() => setPage(pageInChapter + 1)}
                  fluid
                >
                  {restrictedNext ? '限制访问' : '下一页'}
                </Button>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

export const InfuserInstructions = (props) => {
  return (
    <Section title="DNA 注入指南" height={PAGE_HEIGHT}>
      <Stack vertical>
        <Stack.Item fontSize="16px">它有什么作用？</Stack.Item>
        <Stack.Item color="label">
          DNA 注入是将死去生物的 DNA 融入
          自身的过程，使某个器官突变成介于
          你和该生物之间的基因混合体。虽然这会
          使你更加偏离人类形态，并带来一系列……
          不幸的副作用，但也会赋予你新的能力。{' '}
          <b>
            最重要的是，你必须理解，基因变种人通常
            在特定方面极为擅长，尤其是在获得阈值
            加成之后。
          </b>
        </Stack.Item>
        <Stack.Item fontSize="16px">我心动了！该怎么做？</Stack.Item>
        <Stack.Item color="label">
          1. 将死去的生物放入机器。它将作为
          注入的 DNA 来源。
          <br />
          2. 像进入 DNA 扫描仪一样进入机器。
          <br />
          3. 请其他人在外部启动机器。
          <br />
          <Box mt="10px" inline color="white">
            大功告成！请注意，DNA 来源生物会在
            此过程中被彻底摧毁。
          </Box>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

type InfuserEntryProps = {
  entry: Entry;
};

const InfuserEntry = (props: InfuserEntryProps) => {
  const { entry } = props;

  const tierData = TIER2TIERDATA[entry.tier];

  return (
    <Section
      fill
      title={`${batchThreeDisplay(entry.name)}变种人`}
      height={PAGE_HEIGHT}
      buttons={
        <Button tooltip={tierData.desc} icon={tierData.icon}>
          {tierData.name}
        </Button>
      }
    >
      <Stack vertical fill>
        <Stack.Item>
          <BlockQuote>
            {entry.desc}{' '}
            {entry.threshold_desc && (
              <>如果受试者注入了足够的 DNA，{entry.threshold_desc}</>
            )}
          </BlockQuote>
        </Stack.Item>
        <Stack.Item grow>
          特性：
          {entry.qualities.map((quality) => {
            return (
              <Box color="label" key={quality}>
                - {quality}
              </Box>
            );
          })}
        </Stack.Item>
        <Stack.Divider />
        <Stack.Item>
          通过向受试者注入{' '}
          <Box inline color={entry.name === 'Rejected' ? 'red' : 'green'}>
            {entry.infuse_mob_name}
          </Box>{' '}
          的 DNA 产生。
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const paginateEntries = (collection: Entry[]): Entry[][] => {
  const pages: Entry[][] = [];
  let maxTier = -1;
  // find highest tier entry
  collection.forEach((entry) => {
    if (entry.tier > maxTier) {
      maxTier = entry.tier;
    }
  });
  // negative 1 to account for introduction, which has no entries
  let tier = -1;
  for (const _ in range(tier, maxTier + 1)) {
    pages.push(collection.filter((entry) => entry.tier === tier));
    tier++;
  }
  return pages;
};
