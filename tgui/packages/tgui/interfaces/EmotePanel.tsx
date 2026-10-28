import { useMemo, useState } from 'react';
import { Box, Button, Flex, Icon, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { capitalizeFirst } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { SearchBar } from './common/SearchBar';
import { emoteDisplay } from '../localization/emoteDisplay';
type Emote = {
  key: string;
  name: string;
  hands: BooleanLike;
  visible: BooleanLike;
  audible: BooleanLike;
  sound: BooleanLike;
  use_params: BooleanLike;
};

type EmotePanelData = {
  emotes: Emote[];
};

export const EmotePanelContent = (props) => {
  const { act, data } = useBackend<EmotePanelData>();
  const { emotes } = data;

  const [filterVisible, toggleVisualFilter] = useState(false);

  const [filterAudible, toggleAudibleFilter] = useState(false);

  const [filterSound, toggleSoundFilter] = useState(false);

  const [filterHands, toggleHandsFilter] = useState(false);

  const [filterUseParams, toggleUseParamsFilter] = useState(false);

  const [useParams, toggleUseParams] = useState(false);

  const [searchText, setSearchText] = useState<string>('');

  const [showNames, toggleShowNames] = useState(true);

  const [showIcons, toggleShowIcons] = useState(false);

  const filteredEmotes = useMemo(
    () =>
      emotes
        .filter(
          (emote) =>
            emote.key &&
            (searchText.length > 0
              ? emote.key.toLowerCase().includes(searchText.toLowerCase()) ||
                `${emote.name} ${emoteDisplay(emote.key)}`.toLowerCase().includes(searchText.toLowerCase())
              : true) &&
            (filterVisible ? emote.visible : true) &&
            (filterAudible ? emote.audible : true) &&
            (filterSound ? emote.sound : true) &&
            (filterHands ? emote.hands : true) &&
            (filterUseParams ? emote.use_params : true),
        )
        .sort((a, b) => (a.name > b.name ? 1 : -1)),
    [
      emotes,
      searchText,
      filterVisible,
      filterAudible,
      filterSound,
      filterHands,
      filterUseParams,
    ],
  );

  return (
    <Section>
      <Section
        title="筛选"
        buttons={
          <Flex>
            <Button
              icon="eye"
              width="100%"
              height="100%"
              align="center"
              tooltip="可见动作"
              selected={filterVisible}
              onClick={() => toggleVisualFilter(!filterVisible)}
            />
            <Button
              icon="comment"
              width="100%"
              height="100%"
              align="center"
              tooltip="可听动作"
              selected={filterAudible}
              onClick={() => toggleAudibleFilter(!filterAudible)}
            />
            <Button
              icon="volume-up"
              width="100%"
              height="100%"
              align="center"
              tooltip="带音效"
              selected={filterSound}
              onClick={() => toggleSoundFilter(!filterSound)}
            />
            <Button
              icon="hand-paper"
              width="100%"
              height="100%"
              align="center"
              tooltip="需要双手"
              selected={filterHands}
              onClick={() => toggleHandsFilter(!filterHands)}
            />
            <Button
              icon="crosshairs"
              width="100%"
              height="100%"
              align="center"
              tooltip="支持参数"
              selected={filterUseParams}
              onClick={() => toggleUseParamsFilter(!filterUseParams)}
            />
          </Flex>
        }
      >
        <SearchBar
          query={searchText}
          onSearch={setSearchText}
          placeholder="搜索所有表情动作……"
        />
      </Section>
      <Section
        title={
          searchText.length > 0
            ? `“${searchText}”的搜索结果`
            : `所有表情动作`
        }
        buttons={
          <Flex>
            <Flex.Item>
              <Button onClick={() => toggleShowNames(!showNames)}>
                {showNames ? '显示名称' : '显示命令键'}
              </Button>
              <Button
                selected={showIcons}
                onClick={() => toggleShowIcons(!showIcons)}
              >
                显示图标
              </Button>
            </Flex.Item>
            <Flex.Item>
              <Button
                icon="crosshairs"
                selected={useParams}
                onClick={() => toggleUseParams(!useParams)}
              >
                使用参数
              </Button>
            </Flex.Item>
          </Flex>
        }
      >
        <Flex>
          <Flex.Item>
            {filteredEmotes.map((emote) => (
              <EmoteButton
                emote={emote}
                key={emote.name}
                showIcons={showIcons}
                showNames={showNames}
                onPlay={() =>
                  act('play_emote', {
                    emote_key: emote.key,
                    use_params: useParams,
                  })
                }
                onPreview={() =>
                  act('preview_sound', {
                    emote_key: emote.key,
                  })
                }
              />
            ))}
          </Flex.Item>
        </Flex>
      </Section>
    </Section>
  );
};

type EmoteButtonProps = {
  emote: Emote;
  showIcons: boolean;
  showNames: boolean;
  onPlay: () => void;
  onPreview: () => void;
};

const EmoteButton = (props: EmoteButtonProps) => {
  const { emote, showIcons, showNames, onPlay, onPreview } = props;

  return (
    <Stack
      inlineFlex
      align="center"
      width={showIcons ? 16 : 8}
      mb={0.5}
      mr={0.5}
      style={{ gap: '0.25em' }}
    >
      <Stack.Item grow basis={0}>
        <Button
          fluid
          tooltip={
            showIcons ? undefined : (
              <EmoteIcons
                visible={emote.visible}
                audible={emote.audible}
                sound={emote.sound}
                hands={emote.hands}
                use_params={emote.use_params}
                margin={0.5}
              />
            )
          }
          onClick={onPlay}
        >
          <Box inline width="50%">
            {showNames ? (emoteDisplay(emote.key) !== emote.key ? emoteDisplay(emote.key) : capitalizeFirst(emote.name.toLowerCase())) : emote.key}
          </Box>
          {showIcons ? (
            <EmoteIcons
              visible={emote.visible}
              audible={emote.audible}
              sound={emote.sound}
              hands={emote.hands}
              use_params={emote.use_params}
              margin={0}
            />
          ) : (
            ''
          )}
        </Button>
      </Stack.Item>
      {emote.sound ? (
        <Stack.Item width={1.75}>
          <Button
            fluid
            icon="volume-up"
            tooltip="试听音效"
            onClick={onPreview}
          />
        </Stack.Item>
      ) : (
        ''
      )}
    </Stack>
  );
};

const EmoteIcons = (props) => {
  const { visible, audible, sound, hands, use_params, margin } = props;

  return (
    <Box inline align="right">
      <Icon
        name="eye"
        m={margin}
        color={!visible ? 'red' : ''}
        opacity={!visible ? 0.5 : 1}
      />
      <Icon
        name="comment"
        m={margin}
        color={!audible ? 'red' : ''}
        opacity={!audible ? 0.5 : 1}
      />
      <Icon
        name="volume-up"
        m={margin}
        color={!sound ? 'red' : ''}
        opacity={!sound ? 0.5 : 1}
      />
      <Icon
        name="hand-paper"
        m={margin}
        color={!hands ? 'red' : ''}
        opacity={!hands ? 0.5 : 1}
      />
      <Icon
        name="crosshairs"
        m={margin}
        color={!use_params ? 'red' : ''}
        opacity={!use_params ? 0.5 : 1}
      />
    </Box>
  );
};

export const EmotePanel = (props) => {
  return (
    <Window width={630} height={500}>
      <Window.Content scrollable>
        <EmotePanelContent />
      </Window.Content>
    </Window>
  );
};
