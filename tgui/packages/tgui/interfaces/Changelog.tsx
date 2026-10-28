import dateformat from 'dateformat';
import yaml from 'js-yaml';
import { Component, Fragment } from 'react';
import {
  Box,
  Button,
  Dropdown,
  Icon,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { sendAct as act } from '../events/act';
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

type Change = Record<string, string>;
type AuthorChanges = Record<string, Change[]>;
type ChangelogYaml = Record<string, AuthorChanges>;

type ChangelogState = {
  loaded_text: ChangelogYaml | string;
  selectedDate: string;
  selectedIndex: number;
};

type ChangelogData = {
  dates: string[];
};

export class ChangelogContent extends Component<any, ChangelogState> {
  dateChoices: string[];

  constructor(props) {
    super(props);
    this.dateChoices = [];
    this.state = {
      loaded_text: '正在加载更新日志……',
      selectedDate: '',
      selectedIndex: 0,
    };
  }

  setData(loaded_text) {
    this.setState({ loaded_text });
  }

  setSelectedDate(selectedDate) {
    this.setState({ selectedDate });
  }

  setSelectedIndex(selectedIndex) {
    this.setState({ selectedIndex });
  }

  getData = (date, attemptNumber = 1) => {
    const maxAttempts = 6;

    if (attemptNumber > maxAttempts) {
      return this.setData(`尝试 ${maxAttempts} 次后仍无法加载数据`);
    }

    act('get_month', { date });

    fetch(resolveAsset(`${date}.yml`)).then(async (changelogData) => {
      if (!changelogData.ok) {
        if (attemptNumber >= maxAttempts) {
          this.setData(`尝试 ${maxAttempts} 次后仍无法加载`);
          return;
        }

        const timeout = 50 + attemptNumber * 50;
        this.setData(`正在加载更新日志${'.'.repeat(attemptNumber + 3)}`);
        setTimeout(() => {
          this.getData(date, attemptNumber + 1);
        }, timeout);
        return;
      }

      const result = await changelogData.text();
      this.setData(
        yaml.load(result, { schema: yaml.CORE_SCHEMA }) as ChangelogYaml,
      );
    });
  };

  componentDidMount() {
    const { data } = useBackend<ChangelogData>();
    const { dates = [] } = data;

    if (dates) {
      dates.forEach((date) => {
        this.dateChoices.push(dateformat(date, 'yyyy-mm', true));
      });
      this.setSelectedDate(this.dateChoices[0]);
      this.getData(dates[0]);
    }
  }

  render() {
    const { data } = useBackend<ChangelogData>();
    const { dates = [] } = data;
    const { loaded_text, selectedIndex, selectedDate } = this
      .state as ChangelogState;
    const { dateChoices } = this;

    const dateDropdown = dateChoices.length > 0 && (
      <Stack>
        <Stack.Item>
          <Button
            className="Changelog__Button"
            disabled={selectedIndex === 0}
            icon={'chevron-left'}
            onClick={() => {
              const index = selectedIndex - 1;

              this.setData('正在加载更新日志……');
              this.setSelectedIndex(index);
              this.setSelectedDate(dateChoices[index]);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
              return this.getData(dates[index]);
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Dropdown
            autoScroll={false}
            options={dateChoices}
            onSelected={(value) => {
              const index = dateChoices.indexOf(value);

              this.setData('正在加载更新日志……');
              this.setSelectedIndex(index);
              this.setSelectedDate(value);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
              return this.getData(dates[index]);
            }}
            selected={selectedDate}
            width="150px"
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            className="Changelog__Button"
            disabled={selectedIndex === dateChoices.length - 1}
            icon={'chevron-right'}
            onClick={() => {
              const index = selectedIndex + 1;

              this.setData('正在加载更新日志……');
              this.setSelectedIndex(index);
              this.setSelectedDate(dateChoices[index]);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
              return this.getData(dates[index]);
            }}
          />
        </Stack.Item>
      </Stack>
    );

    const header = (
      <Section>
        <h1>巴伯站 13</h1>
        <p>
          <b>鸣谢：</b>
          /tg/ Station, Skyrat Space Station 13, Traditional Games 13,
          Baystation 12, /vg/station, NTstation, CDK Station
          开发者、FacepunchStation、GoonStation 开发者、最初的 Space Station 13
          开发者、提供标题画面的 Invisty，以及无数其他
          为这款游戏作出贡献的人。
        </p>
        <p>
          {'当前项目维护者可查看'}
          <a href="https://github.com/skyrat-ss13?tab=members">此处</a>
          {'，近期 GitHub 贡献者可查看'}
          <a href="https://github.com/Skyrat-SS13/Skyrat-tg/pulse/monthly">
            此处
          </a>
          .
        </p>
        <p>
          {'你也可以加入我们的论坛，点击'}
          <a href="https://forum.skyrat13.tk/">此处</a>。
        </p>
        {dateDropdown}
      </Section>
    );

    const footer = (
      <Section>
        {dateDropdown}
        <h3>GoonStation 13 开发团队</h3>
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
          Traditional Games Space Station 13 感谢 GoonStation 13
          开发团队为这款游戏作出的贡献，截至
          {' r4407 版本。r4407 及之前版本的更新日志可查看'}
          <a href="https://wiki.ss13.co/Pre-2016_Changelog#April_2010">此处</a>。
        </p>
        <p>
          {'除另有说明外，Goon Station 13 采用 '}
          <a href="https://creativecommons.org/licenses/by-nc-sa/3.0/">
            知识共享署名—非商业性使用—相同方式共享 3.0 许可证
          </a>
          {'。目前相关权利仅授予 '}
          <a href="http://forums.somethingawful.com/">SomethingAwful Goons</a>
          {'。'}
        </p>
        <h3>Traditional Games Space Station 13 许可证</h3>
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
          <a href="https://www.gnu.org/licenses/agpl-3.0.html">GNU AGPL v3</a>
          {' 许可证。该提交之前的所有代码均采用 '}
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
          TGS DMAPI API 作为子项目采用 MIT 许可证。
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
        <p>
          {'包括图标和声音在内的所有资源均采用 '}
          <a href="https://creativecommons.org/licenses/by-sa/3.0/">
            知识共享署名—相同方式共享 3.0 许可证
          </a>
          {'，另有说明的除外。'}
        </p>
      </Section>
    );

    const changes =
      typeof loaded_text === 'object' &&
      Object.keys(loaded_text).length > 0 &&
      Object.entries(loaded_text)
        .reverse()
        .map(([date, authors]) => (
          <Section key={date} title={dateformat(date, 'yyyy-mm-dd', true)}>
            <Box ml={3}>
              {Object.entries(authors).map(([name, changes]) => (
                <Fragment key={name}>
                  <h4>{name} 的更改：</h4>
                  <Box ml={3}>
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
                </Fragment>
              ))}
            </Box>
          </Section>
        ));

    return (
      <>
        {header}
        {changes}
        {typeof loaded_text === 'string' && <p>{loaded_text}</p>}
        {footer}
      </>
    );
  }
}

export const Changelog = () => {
  return (
    <Window title="更新日志" width={675} height={650}>
      <Window.Content scrollable>
        <ChangelogContent />
      </Window.Content>
    </Window>
  );
};
