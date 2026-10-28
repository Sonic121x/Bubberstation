import { Icon, Section, Table, Tooltip } from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts'; import { displayRole } from '../localization/roleDisplay';

const commandJobs = [
  'Head of Personnel',
  'Head of Security',
  'Chief Engineer',
  'Research Director',
  'Chief Medical Officer',
  'Quartermaster',
  'Nanotrasen Consultant', // SKYRAT EDIT
];

// SKYRAT EDIT CHANGE BEGIN - ALTERNATIVE_JOB_TITLES
// Any instance of crewMember.trim was originally crewMember.rank
export const CrewManifest = (props) => {
  const {
    data: { manifest, positions },
  } = useBackend();

  return (
    <Window title="船员名单" width={350} height={500}>
      <Window.Content scrollable>
        {Object.entries(manifest).map(([dept, crew]) => (
          <Section
            className={`CrewManifest--Section`}
            key={dept}
            style={{'--department-color': positions[dept].color}}
            title={
              displayRole(dept) +
              (dept !== 'Misc'
                ? `（${positions[dept].open} 个职位空缺）`
                : '')
            }
          >
            <Table>
              {Object.entries(crew).map(([crewIndex, crewMember]) => (
                <Table.Row key={crewIndex}>
                  <Table.Cell
                    className={'CrewManifest__Cell'}
                    maxWidth="135px"
                    overflow="hidden"
                    width="50%"
                  >
                    {crewMember.name}
                  </Table.Cell>
                  <Table.Cell
                    className={classes([
                      'CrewManifest__Cell',
                      'CrewManifest__Icons',
                    ])}
                    collapsing
                    minWidth="40px"
                    width="40px"
                  >
                    {positions[dept].exceptions.includes(crewMember.rank) && (
                      <Tooltip content="无职位人数限制" position="bottom">
                        <Icon className="CrewManifest__Icon" name="infinity" />
                      </Tooltip>
                    )}
                    {crewMember.trim === 'Captain' && (
                      <Tooltip content="舰长" position="bottom">
                        <Icon
                          className={classes([
                            'CrewManifest__Icon',
                            'CrewManifest__Icon--Command',
                          ])}
                          name="star"
                        />
                      </Tooltip>
                    )}
                    {commandJobs.includes(crewMember.trim) && (
                      <Tooltip content="指挥部成员" position="bottom">
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
                    maxWidth="135px"
                    overflow="hidden"
                    width="50%"
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
// SKYRAT EDIT CHANGE END - ALTERNATIVE_JOB_TITLES
