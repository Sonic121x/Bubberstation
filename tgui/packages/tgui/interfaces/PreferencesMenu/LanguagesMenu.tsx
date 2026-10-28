import { Box, Button, Section, Stack, Tooltip } from 'tgui-core/components';
import { languageDisplay } from '../../localization/zhCharacterDisplay';
import { useBackend } from '../../backend';
import type { PreferencesMenuData } from './types';

export const KnownLanguage = (props) => {
  const { act } = useBackend<PreferencesMenuData>();
  return (
    <Stack.Item>
      <Section
        title={
          <Tooltip
            content={
              <>
                <div>能够说话：{props.language.can_speak ? '是' : '否'}</div>
                <div>
                  能够理解：{props.language.can_understand ? '是' : '否'}
                </div>
              </>
            }
          >
            <Box as="span">
              {languageDisplay(props.language.name)}{' '}
              <Button
                color="bad"
                onClick={() =>
                  act('remove_language', { language_name: props.language.name })
                }
              >
                遗忘{' '}
                <Box className={`languages16x16 ${props.language.icon}`} />
              </Button>
            </Box>
          </Tooltip>
        }
      >
        {props.language.description}
      </Section>
    </Stack.Item>
  );
};

export const UnknownLanguage = ({ language, isAtLimit, remaining }) => {
  const { act } = useBackend<PreferencesMenuData>();
  const tooltipContent = isAtLimit
    ? '你已达到可掌握语言的数量上限。'
    : `你还可学习 ${remaining} 种语言。`;

  return (
    <Stack.Item>
      <Section
        title={
          <>
            {languageDisplay(language.name)}{' '}
            <Tooltip content={tooltipContent}>
              <Button
                color="good"
                disabled={isAtLimit}
                onClick={() =>
                  !isAtLimit &&
                  act('give_language', { language_name: language.name })
                }
              >
                学习 <Box className={`languages16x16 ${language.icon}`} />
              </Button>
            </Tooltip>
          </>
        }
      >
        {language.description}
      </Section>
    </Stack.Item>
  );
};

export const LanguagesPage = (props) => {
  const { data } = useBackend<PreferencesMenuData>();

  const currentCount = data.selected_languages.length;
  const maxAllowed = data.total_language_points;
  const isAtLimit = currentCount >= maxAllowed;
  const remaining = Math.max(maxAllowed - currentCount, 0);

  const sortAvailableLanguages = [...data.unselected_languages].sort((a, b) => {
    // GalCom first
    if (a.name === 'Galactic Common') return -1;
    if (b.name === 'Galactic Common') return 1;
    // Then sort by description length descending
    return b.description.length - a.description.length;
  });

  return (
    <Box
      style={{
        maxHeight: '100%',
        display: 'flex',
        flexDirection: 'column',
        overflow: 'hidden',
        boxSizing: 'border-box',
      }}
    >
      {/* Headers */}
      <Box
        style={{
          padding: '0 1rem',
          flex: '0 0 auto',
        }}
      >
        <Stack>
          <Stack.Item minWidth="50%" style={{ marginRight: '2px' }}>
            <Box fontWeight="bold">
              可选语言（还可学习 {remaining} 种）
            </Box>
          </Stack.Item>
          <Stack.Item minWidth="50%">
            <Box fontWeight="bold">
              已掌握语言（{currentCount}／{maxAllowed}）
            </Box>
            {isAtLimit && (
              <Box color="bad" mt={1}>
                你已达到可掌握语言的数量上限。
              </Box>
            )}
          </Stack.Item>
        </Stack>
      </Box>
      <Box
        style={{
          flex: 1,
          display: 'flex',
          overflow: 'hidden',
        }}
      >
        {/* Available Languages */}
        <Box
          style={{
            width: '50%',
            overflowY: 'auto',
            maxHeight: '100%',
            marginRight: '2px',
            padding: '0 1rem',
            boxSizing: 'border-box',
          }}
        >
          <Stack vertical>
            {sortAvailableLanguages.map((val) => (
              <UnknownLanguage
                key={val.icon}
                language={val}
                isAtLimit={isAtLimit}
                remaining={remaining}
              />
            ))}
          </Stack>
        </Box>

        {/* Known Languages */}
        <Box
          style={{
            width: '50%',
            overflowY: 'auto',
            maxHeight: '100%',
            padding: '0 1rem',
            boxSizing: 'border-box',
          }}
        >
          <Stack vertical>
            {data.selected_languages.map((val) => (
              <KnownLanguage key={val.icon} language={val} />
            ))}
          </Stack>
        </Box>
      </Box>
    </Box>
  );
};
