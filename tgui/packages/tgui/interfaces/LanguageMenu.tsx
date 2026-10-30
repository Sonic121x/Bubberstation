import {
  Box,
  Button,
  DmIcon,
  Icon,
  Section,
  Stack,
  Table,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Language = {
  name: string;
  desc: string;
  key: string | null; // the key used to speak the language
  is_default: BooleanLike; // the user's selected default language
  can_speak: BooleanLike; // mentally, we know how to speak it
  could_speak: BooleanLike; // physically, we are capable of speaking it
  can_understand: BooleanLike; // we can understand it regardless
  partial_understanding: number; // how much of the language we understand
  icon: string;
  icon_state: string;
};

type Data = {
  is_living: BooleanLike;
  admin_mode: BooleanLike;
  omnitongue: BooleanLike;
  languages: Language[];
};

type LanguageProps = {
  language: Language;
};

type LanguagePropsPassRest = LanguageProps & {
  [key: string]: any;
};

const LangSpeakIcon = (props: LanguagePropsPassRest) => {
  const { language, ...rest } = props;
  return (
    <Icon
      name="comment"
      color={
        language.could_speak
          ? language.can_speak
            ? 'good' // could speak and can speak
            : 'bad' // could speak but cannot speak
          : language.can_speak
            ? 'average' // could not speak but can speak
            : 'grey' // could not speak and cannot speak
      }
      {...rest}
    />
  );
};

const LangUnderstandIcon = (props: LanguageProps) => {
  const { language } = props;
  if (!language.can_understand && language.partial_understanding > 0) {
    return (
      <Tooltip content={`你只能部分理解${language.name}。`}>
        <Box
          inline
          style={{
            borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
          }}
        >
          {language.partial_understanding}%
        </Box>
      </Tooltip>
    );
  }
  return <Icon name="brain" color={language.can_understand ? 'good' : 'bad'} />;
};

const LanguageNameAndDesc = (props: LanguageProps) => {
  const { language } = props;
  return language.desc ? (
    <Tooltip content={language.desc} position="bottom-start">
      <Box
        inline
        style={{
          borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
        }}
      >
        {language.name}
      </Box>
    </Tooltip>
  ) : (
    <Box>{language.name}</Box>
  );
};

const LanguageRow = (props: LanguageProps) => {
  const { act, data } = useBackend<Data>();
  const { is_living, admin_mode } = data;
  const { language } = props;

  return (
    <Table.Row className="candystripe">
      <Table.Cell verticalAlign="middle">
        {language.icon && language.icon_state ? (
          <Stack>
            <Stack.Item>
              <DmIcon icon={language.icon} icon_state={language.icon_state} />
            </Stack.Item>
            <Stack.Item>
              <LanguageNameAndDesc language={language} />
            </Stack.Item>
          </Stack>
        ) : (
          <LanguageNameAndDesc language={language} />
        )}
      </Table.Cell>
      <Table.Cell>
        {!language.could_speak ? (
          <Tooltip
            content={
              language.can_speak
                ? `尽管你懂得如何说${language.name}，
              但你的身体条件不允许你使用这种语言
              （通常是因为舌头）。`
                : `即使你学会了如何说${language.name}，
              你的身体条件也不允许你使用这种语言
              （通常是因为舌头）。`
            }
          >
            <LangSpeakIcon
              language={language}
              inline
              style={{
                borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
              }}
            />
          </Tooltip>
        ) : (
          <LangSpeakIcon language={language} />
        )}
      </Table.Cell>
      <Table.Cell>
        <LangUnderstandIcon language={language} />
      </Table.Cell>
      <Table.Cell>{language.key ? `,${language.key}` : 'N/A'}</Table.Cell>
      {!!is_living && (
        <Table.Cell>
          <Button.Checkbox
            checked={language.is_default}
            color={
              language.is_default
                ? 'good'
                : language.could_speak && language.can_speak
                  ? 'grey'
                  : 'transparent'
            }
            onClick={() =>
              act('select_default', {
                language_name: language.name,
              })
            }
          />
        </Table.Cell>
      )}
      {!!admin_mode && (
        <Table.Cell>
          <Button
            disabled={language.can_speak && language.can_understand}
            onClick={() =>
              act('grant_language', {
                language_name: language.name,
              })
            }
          >
            授予
          </Button>
          <Button
            disabled={!language.can_speak && !language.can_understand}
            onClick={() =>
              act('remove_language', {
                language_name: language.name,
              })
            }
          >
            移除
          </Button>
        </Table.Cell>
      )}
    </Table.Row>
  );
};

const OmnitongueToggle = (props) => {
  const { act, data } = useBackend<Data>();
  const { omnitongue } = data;
  return (
    <Button
      tooltip={`启用后，该生物将不再因舌头的构造限制，
        而无法使用某些语言。`}
      selected={omnitongue}
      onClick={() => act('toggle_omnitongue')}
    >
      {`万语之舌：${omnitongue ? '已启用' : '已禁用'}`}
    </Button>
  );
};

export const LanguageMenu = (props) => {
  const { data } = useBackend<Data>();
  const { admin_mode, is_living, languages } = data;

  // only show languages we can speak OR understand, UNLESS we're an admin
  // also, push all languages we can speak to the top, then all languagse we can only understand, then alphabetize
  const shown_languages = languages
    .filter(
      (language) =>
        admin_mode ||
        language.can_speak ||
        language.can_understand ||
        language.partial_understanding > 0,
    )
    .sort(
      (a, b) =>
        ((a.can_speak ? 1 : 0) - (b.can_speak ? 1 : 0)) * -2 +
        (a.name > b.name ? 1 : 0),
    );

  return (
    <Window
      title="语言菜单"
      width={admin_mode ? 700 : 500}
      height={Math.min(
        shown_languages.length * 25 + (admin_mode ? 100 : 70),
        500,
      )}
    >
      <Window.Content>
        <Section
          scrollable
          title={admin_mode ? <i>- 管理员模式 -</i> : null}
          buttons={admin_mode ? <OmnitongueToggle /> : null}
          fill
        >
          <Table>
            <Table.Row header>
              <Table.Cell>名称</Table.Cell>
              <Table.Cell>表达</Table.Cell>
              <Table.Cell>理解</Table.Cell>
              <Table.Cell>
                <Tooltip
                  content="在消息中使用此语言前缀，
                  即可使用该语言说话。"
                >
                  <Box
                    inline
                    style={{
                      borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
                    }}
                  >
                    前缀
                  </Box>
                </Tooltip>
              </Table.Cell>
              {!!is_living && (
                <Table.Cell>
                  <Tooltip
                    content="决定不输入语言前缀时，
                    默认使用哪种语言说话。"
                  >
                    <Box
                      inline
                      style={{
                        borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
                      }}
                    >
                      默认
                    </Box>
                  </Tooltip>
                </Table.Cell>
              )}
              {!!admin_mode && <Table.Cell />}
            </Table.Row>
            {shown_languages.map((language) => (
              <LanguageRow key={language.name} language={language} />
            ))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
