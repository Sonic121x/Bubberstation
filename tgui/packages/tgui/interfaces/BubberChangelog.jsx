import dateformat from 'dateformat';
import yaml from 'js-yaml';
import { useEffect, useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  Icon,
  Image,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';

const icons = {
  add: { icon: 'check-circle', color: 'green' },
  admin: { icon: 'user-shield', color: 'purple' },
  balance: { icon: 'balance-scale-right', color: 'yellow' },
  bugfix: { icon: 'bug', color: 'green' },
  code_imp: { icon: 'code', color: 'green' },
  config: { icon: 'cogs', color: 'purple' },
  expansion: { icon: 'check-circle', color: 'green' },
  experiment: { icon: 'radiation', color: 'yellow' },
  image: { icon: 'image', color: 'green' },
  imageadd: { icon: 'tg-image-plus', color: 'green' },
  imagedel: { icon: 'tg-image-minus', color: 'red' },
  qol: { icon: 'hand-holding-heart', color: 'green' },
  refactor: { icon: 'tools', color: 'green' },
  rscadd: { icon: 'check-circle', color: 'green' },
  rscdel: { icon: 'times-circle', color: 'red' },
  server: { icon: 'server', color: 'purple' },
  sound: { icon: 'volume-high', color: 'green' },
  soundadd: { icon: 'tg-sound-plus', color: 'green' },
  sounddel: { icon: 'tg-sound-minus', color: 'red' },
  spellcheck: { icon: 'spell-check', color: 'green' },
  map: { icon: 'map', color: 'green' },
  tgs: { icon: 'toolbox', color: 'purple' },
  tweak: { icon: 'wrench', color: 'green' },
  unknown: { icon: 'info-circle', color: 'label' },
  wip: { icon: 'hammer', color: 'orange' },
};

const DateDropdown = (props) => {
  const {
    dates,
    selectedDate,
    setSelectedDate,
    selectedDateIndex,
    setSelectedDateIndex,
  } = props;

  return (
    dates.length > 0 && (
      <Stack mb={1}>
        <Stack.Item>
          <Button
            className="Changelog__Button"
            disabled={selectedDateIndex === 0}
            icon={'chevron-left'}
            onClick={() => {
              const index = selectedDateIndex - 1;

              setSelectedDateIndex(index);
              setSelectedDate(dates[index]);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Dropdown
            autoScroll={false}
            options={dates}
            onSelected={(value) => {
              const index = dates.indexOf(value);

              setSelectedDateIndex(index);
              setSelectedDate(value);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
            }}
            selected={selectedDate}
            width="150px"
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            className="Changelog__Button"
            disabled={selectedDateIndex === dates.length - 1}
            icon={'chevron-right'}
            onClick={() => {
              const index = selectedDateIndex + 1;

              setSelectedDateIndex(index);
              setSelectedDate(dates[index]);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
            }}
          />
        </Stack.Item>
      </Stack>
    )
  );
};

const ChangelogList = (props) => {
  const { contents, bubberContents } = props;

  const combinedDates = {};
  Object.assign(
    combinedDates,
    typeof contents === 'object' ? contents : {},
    typeof bubberContents === 'object' ? bubberContents : {},
  );

  if (Object.keys(combinedDates).length < 1) {
    return <p>{contents}</p>;
  }

  return Object.keys(combinedDates)
    .sort()
    .reverse()
    .map((date) => (
      <Section key={date} title={dateformat(date, 'yyyy-mm-dd', true)} pb={1}>
        <Box ml={3}>
          {bubberContents[date] && (
            <Section mb={-2}>
              {Object.entries(bubberContents[date]).map(([name, changes]) => (
                <BubberChangelogEntry
                  key={name}
                  author={name}
                  changes={changes}
                />
              ))}
            </Section>
          )}
          {contents[date] && (
            <Section mt={-1}>
              {Object.entries(contents[date]).map(([name, changes]) => (
                <ChangelogEntry key={name} author={name} changes={changes} />
              ))}
            </Section>
          )}
        </Box>
      </Section>
    ));
};

const BubberChangelogEntry = (props) => {
  const { author, changes } = props;

  return (
    <Stack.Item mb={-1} pb={1} key={author}>
      <Box>
        <h4>
          <Image verticalAlign="bottom" src={resolveAsset('bubber_16.png')} />{' '}
          {author} 的更改：
        </h4>
      </Box>
      <Box ml={3} mt={-0.2}>
        <Table>
          {changes.map((change) => {
            const changeType = Object.keys(change)[0];
            return (
              <Table.Row key={changeType + change[changeType]}>
                <Table.Cell
                  className={classes([
                    'Changelog__Cell',
                    'Changelog__Cell--Icon',
                  ])}
                >
                  <Icon
                    color={
                      icons[changeType]
                        ? icons[changeType].color
                        : icons.unknown.color
                    }
                    name={
                      icons[changeType]
                        ? icons[changeType].icon
                        : icons.unknown.icon
                    }
                    verticalAlign="middle"
                  />
                </Table.Cell>
                <Table.Cell className="Changelog__Cell">
                  {change[changeType]}
                </Table.Cell>
              </Table.Row>
            );
          })}
        </Table>
      </Box>
    </Stack.Item>
  );
};

const ChangelogEntry = (props) => {
  const { author, changes } = props;

  return (
    <Stack.Item mb={-1} pb={1} key={author}>
      <Box>
        <h4>
          <Image verticalAlign="bottom" src={resolveAsset('tg_16.png')} />{' '}
          {author} 的更改：
        </h4>
      </Box>
      <Box ml={3} mt={-0.2}>
        <Table>
          {changes.map((change) => {
            const changeType = Object.keys(change)[0];
            return (
              <Table.Row key={changeType + change[changeType]}>
                <Table.Cell
                  className={classes([
                    'Changelog__Cell',
                    'Changelog__Cell--Icon',
                  ])}
                >
                  <Icon
                    color={
                      icons[changeType]
                        ? icons[changeType].color
                        : icons.unknown.color
                    }
                    name={
                      icons[changeType]
                        ? icons[changeType].icon
                        : icons.unknown.icon
                    }
                    verticalAlign="middle"
                  />
                </Table.Cell>
                <Table.Cell className="Changelog__Cell">
                  {change[changeType]}
                </Table.Cell>
              </Table.Row>
            );
          })}
        </Table>
      </Box>
    </Stack.Item>
  );
};

export const BubberChangelog = (props) => {
  const { data } = useBackend();
  const { dates } = data;
  const [contents, setContents] = useState('');
  const [bubberContents, setBubberContents] = useState('');
  const [selectedDate, setSelectedDate] = useState(dates[0]);
  const [selectedDateIndex, setSelectedDateIndex] = useState(0);

  useEffect(() => {
    setContents('正在加载更新日志……');
    setBubberContents('正在加载更新日志……');
    getData(selectedDate);
  }, [selectedDate]);

  function getData(date, attemptNumber = 1) {
    const { act } = useBackend();
    const maxAttempts = 6;

    if (attemptNumber > maxAttempts) {
      setContents(`尝试 ${maxAttempts} 次后仍无法加载数据。`);
      return;
    }

    act('get_month', { date });

    Promise.all([
      fetch(resolveAsset(`${date}.yml`)),
      fetch(resolveAsset(`bubber_${date}.yml`)),
    ]).then(async (links) => {
      const result = await links[0].text();
      const bubberResult = await links[1].text();

      if (links[0].status !== 200 && links[1].status !== 200) {
        const timeout = 50 + attemptNumber * 50;

        setContents(`正在加载更新日志${'.'.repeat(attemptNumber + 3)}`);
        setBubberContents(
          `正在加载更新日志${'.'.repeat(attemptNumber + 3)}`,
        );
        setTimeout(() => {
          getData(date, attemptNumber + 1);
        }, timeout);
      } else {
        if (links[0].status === 200) {
          setContents(yaml.load(result, { schema: yaml.CORE_SCHEMA }));
        }
        if (links[1].status === 200) {
          setBubberContents(
            yaml.load(bubberResult, { schema: yaml.CORE_SCHEMA }),
          );
        }
      }
    });
  }

  const header = (
    <Section>
      <h1>巴伯站 13</h1>
      <p>
        <b>鸣谢：</b>
        /tg/station 13, Effigy, Stellar Haven, Baystation 12, /vg/station,
        NTstation、CDK Station 开发者、FacepunchStation、GoonStation 开发者、
        最初的 Space Station 13 开发者，以及无数其他
        为这款游戏作出贡献的人。
      </p>
      <p>
        {'当前组织成员可查看'}
        <a href="https://github.com/orgs/Bubberstation/people">此处</a>
        {'，近期 GitHub 贡献者可查看'}
        <a href="https://github.com/Bubberstation/Bubberstation/pulse/monthly">
          此处
        </a>
        .
      </p>
      <p>
        {'你也可以加入我们的 Discord，点击'}
        <a href="https://discord.com/invite/AvjrTqnqEx">此处</a>！
      </p>
      <DateDropdown
        dates={dates}
        selectedDate={selectedDate}
        setSelectedDate={setSelectedDate}
        selectedDateIndex={selectedDateIndex}
        setSelectedDateIndex={setSelectedDateIndex}
      />
    </Section>
  );

  const footer = (
    <Section>
      <DateDropdown
        dates={dates}
        selectedDate={selectedDate}
        setSelectedDate={setSelectedDate}
        selectedDateIndex={selectedDateIndex}
        setSelectedDateIndex={setSelectedDateIndex}
      />
      <h2>许可证</h2>
      <Section title="巴伯站 13">
        <p>
          {'所有代码均采用 '}
          <a href="https://www.gnu.org/licenses/agpl-3.0.html">GNU AGPL v3</a>.
          {' 许可证。请参阅 '}
          <a href="https://github.com/bubberstation/bubberstation/blob/master/LICENSE">
            LICENSE
          </a>{' '}
          了解详情。
        </p>
        <p>
          {'包括图标和声音在内的所有资源均采用 '}
          <a href="https://creativecommons.org/licenses/by-sa/3.0/">
            知识共享署名—相同方式共享 3.0 许可证
          </a>
          {'，另有说明的除外。'}
        </p>
      </Section>
      <Section title="TGS">
        <p>
          TGS DMAPI API 作为子项目采用 MIT 许可证。
        </p>
        <p>
          {' MIT 许可证见 '}
          <a
            href={
              'https://github.com/tgstation/tgstation/blob/master' +
              '/code/__DEFINES/tgs.dm'
            }
          >
            code/__DEFINES/tgs.dm
          </a>
          {' 文件底部及 '}
          <a
            href={
              'https://github.com/tgstation/tgstation/blob/master' +
              '/code/modules/tgs/LICENSE'
            }
          >
            code/modules/tgs/LICENSE
          </a>
          {'。'}
        </p>
      </Section>
      <Section title="/tg/station 13">
        <p>
          {'以下提交之后的所有代码：'}
          <a
            href={
              'https://github.com/tgstation/tgstation/commit/' +
              '333c566b88108de218d882840e61928a9b759d8f'
            }
          >
            333c566b88108de218d882840e61928a9b759d8f，提交于 2014 年 12 月 31 日
            太平洋标准时间下午 4:38
          </a>
          {'，均采用 '}
          <a href="https://www.gnu.org/licenses/agpl-3.0.html">GNU AGPL v3</a>.
        </p>
        <p>
          {'该提交之前的所有代码均采用 '}
          <a href="https://www.gnu.org/licenses/gpl-3.0.html">GNU GPL v3</a>
          {' 许可证，包括所有工具，除非其自述文件另有说明。请参阅 '}
          <a href="https://github.com/tgstation/tgstation/blob/master/LICENSE">
            LICENSE
          </a>
          {' 和 '}
          <a href="https://github.com/tgstation/tgstation/blob/master/GPLv3.txt">
            GPLv3.txt
          </a>
          {' 了解详情。'}
        </p>
        <p>
          {'包括图标和声音在内的所有资源均采用 '}
          <a href="https://creativecommons.org/licenses/by-sa/3.0/">
            知识共享署名—相同方式共享 3.0 许可证
          </a>
          {'，另有说明的除外。'}
        </p>
      </Section>
      <Section title="Goonstation SS13">
        <p>
          <b>程序开发：</b>
          Stuntwaffle, Showtime, Pantaloons, Nannek, Keelin, Exadv1, hobnob,
          Justicefries, 0staf, sniperchance, AngriestIBM, BrianOBlivion
        </p>
        <p>
          <b>像素美术：</b>
          Supernorn, Haruhi, Stuntwaffle, Pantaloons, Rho, SynthOrange, I Said
          No
        </p>
        <p>
          Bubberstation 和 /tg/station 13 感谢 GoonStation 13
          开发团队为这款游戏作出的贡献，截至
          {' r4407 版本。r4407 及之前版本的更新日志可查看'}
          <a href="https://wiki.ss13.co/Pre-2016_Changelog#April_2010">此处</a>。
        </p>
        <p>
          {'除另有说明外，Goon Station 13 采用 '}
          <a href="https://creativecommons.org/licenses/by-nc-sa/3.0/">
            知识共享署名—非商业性使用—相同方式共享 3.0 许可证
          </a>
          .
        </p>
        <p>
          {'目前相关权利仅授予 '}
          <a href="http://forums.somethingawful.com/">SomethingAwful Goons</a>
          {'。'}
        </p>
      </Section>
    </Section>
  );

  return (
    <Window title="更新日志" width={730} height={700}>
      <Window.Content scrollable>
        {header}
        <ChangelogList contents={contents} bubberContents={bubberContents} />
        {footer}
      </Window.Content>
    </Window>
  );
};
