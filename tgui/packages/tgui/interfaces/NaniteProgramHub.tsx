import { map } from 'es-toolkit/compat';
import {
  Button,
  Flex,
  LabeledList,
  NoticeBox,
  Section,
  Tabs,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';
import { TechwebWarning } from './Nanites/NoTechwebWarning';
import type { NaniteProgram, Techweb } from './Nanites/types';
import { naniteControlsDisplay as zh } from '../localization/zhNaniteControlsDisplay';
interface NaniteProgramHubProps {
  detail_view: boolean;
  disk: {
    name: string;
    desc: string;
  };
  techweb: Techweb;
  has_disk: boolean;
  has_program: boolean;
  programs: Record<string, Array<NaniteProgram>>;
}

export const NaniteProgramHub = (props, context) => {
  const { act, data } = useBackend<NaniteProgramHubProps>();
  const {
    detail_view,
    disk,
    has_disk,
    has_program,
    programs = {},
    techweb,
  } = data;
  const [selectedCategory, setSelectedCategory] = useSharedState<string | null>(
    'category',
    null,
  );
  const programsInCategory =
    (programs && selectedCategory && programs[selectedCategory]) || [];

  return (
    <Window width={500} height={700}>
      <Window.Content scrollable>
        <TechwebWarning display={!techweb} />
        <Section
          title="程序磁盘"
          buttons={
            <>
              <Button
                disabled={!has_disk}
                icon="eject"
                onClick={() => act('eject')}
              >
                弹出
              </Button>
              <Button
                disabled={!has_disk}
                icon="minus-circle"
                onClick={() => act('clear')}
              >
                删除程序
              </Button>
            </>
          }
        >
          {has_disk ? (
            has_program ? (
              <LabeledList>
                <LabeledList.Item label="程序名称">
                  {disk.name}
                </LabeledList.Item>
                <LabeledList.Item label="描述">
                  {disk.desc}
                </LabeledList.Item>
              </LabeledList>
            ) : (
              <NoticeBox>未安装程序</NoticeBox>
            )
          ) : (
            <NoticeBox>请插入磁盘</NoticeBox>
          )}
        </Section>
        <Section
          title="程序"
          buttons={
            <>
              <Button
                icon={detail_view ? 'info' : 'list'}
                onClick={() => act('toggle_details')}
              >
                {detail_view ? '详细' : '简洁'}
              </Button>
              <Button icon="sync" onClick={() => act('refresh')}>
                同步研究
              </Button>
            </>
          }
        >
          {programs !== null ? (
            <Flex>
              <Flex.Item minWidth="110px" style={{ marginRight: '15px' }}>
                <Tabs vertical>
                  {map(programs, (cat_contents, category) => {
                    // Backend was sending stupid data that would have been
                    // annoying to fix
                    const tabLabel = category.substring(0, category.length - 8);
                    return (
                      <Tabs.Tab
                        key={category}
                        selected={category === selectedCategory}
                        onClick={() => setSelectedCategory(category)}
                      >
                        {zh(tabLabel)}
                      </Tabs.Tab>
                    );
                  })}
                </Tabs>
              </Flex.Item>
              <Flex.Item grow={1} basis={0}>
                {detail_view ? (
                  programsInCategory.map((program) => (
                    <Section
                      key={program.id}
                      title={program.name}
                      buttons={
                        <Button
                          icon="download"
                          disabled={!has_disk}
                          onClick={() =>
                            act('download', {
                              program_id: program.id,
                            })
                          }
                        >
                          下载
                        </Button>
                      }
                    >
                      {program.desc}
                    </Section>
                  ))
                ) : (
                  <LabeledList>
                    {programsInCategory.map((program) => (
                      <LabeledList.Item
                        key={program.id}
                        label={program.name}
                        buttons={
                          <Button
                            icon="download"
                            disabled={!has_disk}
                            onClick={() =>
                              act('download', {
                                program_id: program.id,
                              })
                            }
                          >
                            下载
                          </Button>
                        }
                      />
                    ))}
                  </LabeledList>
                )}
              </Flex.Item>
            </Flex>
          ) : (
            <NoticeBox>目前尚未研究任何纳米机器人程序。</NoticeBox>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
