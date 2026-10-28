// THIS IS A SKYRAT UI FILE
import { Button, Icon, Section, Table, Tooltip } from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts'; import { displayRole } from '../localization/roleDisplay'; import { chineseDisplay } from '../localization/zhDisplay';

const commandJobs = [
  'Head of Personnel',
  'Head of Security',
  'Chief Engineer',
  'Research Director',
  'Chief Medical Officer',
  'Quartermaster',
  'Nanotrasen Consultant',
];

export const RecordManifest = (props) => {
  const {
    data: { manifest, positions },
  } = useBackend();
  const { act } = useBackend();

  return (
    <Window title="全体船员情报" width={450} height={500}>
      <Window.Content scrollable>
        {Object.entries(manifest).map(([dept, crew]) => (
          <Section className={`CrewManifest--${dept}`} key={dept} title={chineseDisplay(dept)}>
            <Table>
              {Object.entries(crew).map(([crewIndex, crewMember]) => (
                <Table.Row key={crewIndex}>
                  <Table.Cell className={'CrewManifest__Cell'}>
                    {crewMember.name}
                  </Table.Cell>
                  <Table.Cell>
                    <Button
                      content="查看可利用情报"
                      onClick={() =>
                        act('show_exploitables', {
                          exploitable_id: crewMember.name,
                        })
                      }
                    />
                  </Table.Cell>
                  <Table.Cell
                    className={classes([
                      'CrewManifest__Cell',
                      'CrewManifest__Icons',
                    ])}
                    collapsing
                  >
                    {positions[dept].exceptions.includes(crewMember.rank) && (
                      <Tooltip content="无职位人数限制" position="bottom">
                        <Icon className="CrewManifest__Icon" name="infinity" />
                      </Tooltip>
                    )}
                    {crewMember.rank === 'Captain' && (
                      <Tooltip content="船长" position="bottom">
                        <Icon
                          className={classes([
                            'CrewManifest__Icon',
                            'CrewManifest__Icon--Command',
                          ])}
                          name="star"
                        />
                      </Tooltip>
                    )}
                    {commandJobs.includes(crewMember.rank) && (
                      <Tooltip content="指挥人员" position="bottom">
                        <Icon
                          className={classes([
                            'CrewManifest__Icon',
                            'CrewManifest__Icon--Command',
                            'CrewManifest__Icon--Chevron',
                          ])}
                          name="chevron-up"
                        />
                      </Tooltip>
                    )}
                  </Table.Cell>
                  <Table.Cell
                    className={classes([
                      'CrewManifest__Cell',
                      'CrewManifest__Cell--Rank',
                    ])}
                    collapsing
                  >
                    {displayRole(crewMember.rank)}
                  </Table.Cell>
                </Table.Row>
              ))}
            </Table>
          </Section>
        ))}
      </Window.Content>
    </Window>
  );
};
