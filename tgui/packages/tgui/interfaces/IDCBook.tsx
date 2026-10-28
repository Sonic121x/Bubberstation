import { useBackend } from 'tgui/backend';
import { Box, Section, Stack } from 'tgui-core/components';
import { type BookEntry, BookUI, type TOCEntry } from './common/PaginatedBook';
import '../styles/interfaces/DeForestLogo.scss';
import { idcCode, idcDisplay } from '../localization/idcDisplay';
type Disease = {
  name: string; // used by symptoms and diseases - name of the disease or symptom
  desc: string; // used by symptoms and diseases - description of the disease or symptom
  form: string; // used by symptoms and diseases - something like symptom, virus, bacteria, etc
  agent: string; // used by diseases - the agent that causes the disease, like a virus or bacteria name
  spread_by: string; // used by diseases - how the disease is spread, like "Airborne" or "Contact"
  cured_by: string | null; // used by symptoms and diseases - how the disease or symptom is cured, like a medicine name or "Unknown"
  illness: string; // used by symptoms - the common illness associated with the symptom, like "Flu" for "Fever"
  level: string; // used by symptoms - determines how to obtain the symptom
  id: string;
};

type DiseaseData = {
  diseases: Disease[];
};

function isSymptom(entry: BookEntry<Disease>) {
  return idcCode(entry.form) === 'symptom';
}

function formToColor(form: string) {
  switch (idcCode(form)) {
    case 'symptom':
      return 'lightgreen';
    case 'condition':
    case 'infection':
    case 'parasite':
      return 'lightsalmon';
    case 'virus':
    case 'bacteria':
    case 'fungus':
      return 'lightblue';
    default:
      return 'white';
  }
}

function formatSpreadBy(spread_by: string) {
  switch (idcCode(spread_by)) {
    case 'airborne':
      return (
        <Stack align="end">
          <Stack.Item>空气传播</Stack.Item>
          <Stack.Item fontSize="10px" pb={0.2}>
            （例如咳嗽、打喷嚏）
          </Stack.Item>
        </Stack>
      );
    case 'skin contact':
    case 'contact':
      return (
        <Stack align="end">
          <Stack.Item>接触传播</Stack.Item>
          <Stack.Item fontSize="10px" pb={0.2}>
            （例如触碰感染者）
          </Stack.Item>
        </Stack>
      );
    case 'fluid contact':
      return (
        <Stack align="end">
          <Stack.Item>液体传播</Stack.Item>
          <Stack.Item fontSize="10px" pb={0.2}>
            （例如接触受污染的液体）
          </Stack.Item>
        </Stack>
      );
    case 'blood':
      return (
        <Stack align="end">
          <Stack.Item>血液传播</Stack.Item>
          <Stack.Item fontSize="10px" pb={0.2}>
            （例如输入感染者的血液）
          </Stack.Item>
        </Stack>
      );
    case 'none':
      return (
        <Stack align="end">
          <Stack.Item>无</Stack.Item>
          <Stack.Item fontSize="10px" pb={0.2}>
            （不传染）
          </Stack.Item>
        </Stack>
      );
    default:
      return spread_by;
  }
}

function estimateHeight(entry: BookEntry<Disease>) {
  const title_height = 40;
  const extra_spacing = 40;
  if (isSymptom(entry)) {
    const desc_height = Math.ceil(entry.desc.length / 50) * 14;
    const illness_height = !['Unidentified', '未识别'].includes(entry.illness) ? 10 : 0;
    const cured_by_height = 10;
    const level_height = 10;

    return (
      title_height +
      desc_height +
      illness_height +
      cured_by_height +
      extra_spacing +
      level_height
    );
  }

  const desc_height = Math.ceil(entry.desc.length / 50) * 14;
  const agent_height = 15;
  const spread_by_height = 15;
  const cured_by_height = 15;

  return (
    title_height +
    desc_height +
    agent_height +
    spread_by_height +
    cured_by_height +
    extra_spacing
  );
}

function renderDSMEntry(entry: BookEntry<Disease>) {
  return (
    <Section
      width="100%"
      fitted
      pt={0.2}
      pl={1}
      title={
        <Stack align="end">
          <Stack.Item grow>{entry.name}</Stack.Item>
          <Stack.Item italic fontSize="10px" pb={0.2} pr={0.5}>
            （{idcDisplay(entry.form)}）
          </Stack.Item>
        </Stack>
      }
    >
      <Stack vertical backgroundColor={formToColor(entry.form)} p={1}>
        {isSymptom(entry) ? (
          <>
            <Stack.Item>
              <Box inline color="label">
                描述：
              </Box>{' '}
              {entry.desc}
            </Stack.Item>
            <Stack.Item>
              <Box inline color="label">
                等级：
              </Box>{' '}
              {entry.level}
            </Stack.Item>
            {!['Unidentified', '未识别'].includes(entry.illness) && (
              <Stack.Item>
                <Box inline color="label">
                  常见相关疾病：
                </Box>{' '}
                "{entry.illness}"
              </Stack.Item>
            )}
            {!!entry.cured_by && (
              <Stack.Item>
                <Box inline color="label">
                  常见治疗方法：
                </Box>{' '}
                {entry.cured_by}
              </Stack.Item>
            )}
          </>
        ) : (
          <>
            <Stack.Item>
              <Box inline color="label">
                病因：
              </Box>{' '}
              {entry.agent}
            </Stack.Item>
            <Stack.Item>
              <Box inline color="label">
                描述：
              </Box>{' '}
              {entry.desc}
            </Stack.Item>
            <Stack.Item>
              <Box inline color="label">
                传播途径：
              </Box>{' '}
              <Box inline>{formatSpreadBy(entry.spread_by)}</Box>
            </Stack.Item>
            <Stack.Item>
              <Box inline color="label">
                治疗方法：
              </Box>{' '}
              {entry.cured_by}
            </Stack.Item>
          </>
        )}
      </Stack>
    </Section>
  );
}

function renderTOCEntry(tocentry: TOCEntry<Disease>) {
  return (
    <Stack align="end">
      <Stack.Item>{tocentry.entry.name}</Stack.Item>
      <Stack.Item
        fontSize="10px"
        italic
        maxWidth={`${(50 - tocentry.entry.name.length) * 5}px`}
        style={{
          overflow: 'hidden',
          whiteSpace: 'nowrap',
          textOverflow: 'ellipsis',
        }}
        pb={0.2}
      >
        （{idcDisplay(tocentry.entry.form)}）
      </Stack.Item>
    </Stack>
  );
}

const blankIDCPage = (
  <Stack.Item textAlign="center" grow className="deforest_logo" />
);

export const IDCBook = () => {
  const { data } = useBackend<DiseaseData>();
  const { diseases } = data;

  const diseaseEntries: BookEntry<Disease>[] = diseases
    .map((disease) => ({
      id: disease.id,
      name: disease.name,
      desc: disease.desc,
      form: disease.form,
      agent: disease.agent,
      spread_by: disease.spread_by,
      cured_by: disease.cured_by,
      illness: disease.illness,
      level: disease.level,
    }))
    .sort((a, b) =>
      a.form > b.form ? 1 : a.form < b.form ? -1 : a.name > b.name ? 1 : -1,
    );

  return (
    <BookUI
      bookData={diseaseEntries}
      title="IDC-27"
      estimateHeight={estimateHeight}
      renderEntry={renderDSMEntry}
      renderTOCEntry={renderTOCEntry}
      blankPage={blankIDCPage}
    />
  );
};
