import { useAtomValue } from 'jotai';
import { useMemo, useRef } from 'react';
import {
  Box,
  Button,
  ColorBox,
  Divider,
  Dropdown,
  Floating,
  Icon,
  Input,
  Knob,
  Section,
  Stack,
  TextArea,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';

import { chatRenderer } from '../chat/renderer';
import { characterProfilesAtom, currentCharacterAtom } from '../game/atoms';
import { WARN_AFTER_HIGHLIGHT_AMT } from './constants';
import { useHighlights } from './use-highlights';

export function TextHighlightSettings(props) {
  const {
    highlights: { highlightSettings },
    addHighlight,
  } = useHighlights();

  return (
    <Section fill scrollable height="250px">
      <Stack vertical>
        {highlightSettings.map((id, i) => (
          <TextHighlightSetting
            key={i}
            id={id}
            mb={i + 1 === highlightSettings.length ? 0 : '10px'}
          />
        ))}
        <Stack.Item>
          <Box>
            <Button
              color="transparent"
              icon="plus"
              onClick={() => addHighlight()}
            >
              添加高亮规则
            </Button>
            {highlightSettings.length >= WARN_AFTER_HIGHLIGHT_AMT && (
              <Box inline fontSize="0.9em" ml={1} color="red">
                <Icon mr={1} name="triangle-exclamation" />
                大量高亮规则可能导致
                性能问题！
              </Box>
            )}
          </Box>
        </Stack.Item>
      </Stack>
      <Divider />
      <Box>
        <Button icon="check" onClick={() => chatRenderer.rebuildChat()}>
          立即应用
        </Button>
        <Box inline fontSize="0.9em" ml={1} color="label">
          可能导致聊天界面暂时卡顿。
        </Box>
      </Box>
    </Section>
  );
}

const HIGHLIGHT_SOUND_OPTIONS = [
  { label: 'Beep', value: 'sound/misc/highlight_sounds/Beep.ogg' },
  { label: 'Pillow Hit', value: 'sound/items/pillow/pillow_hit.ogg' },
  { label: 'Coin Flip', value: 'sound/items/coinflip.ogg' },
  { label: 'Pen Click', value: 'sound/items/pen_click.ogg' },
  { label: 'Rattling Keys', value: 'sound/items/rattling_keys.ogg' },
  { label: 'Honk!', value: 'sound/items/bikehorn.ogg' },
];

const oneCharacterRegex = /^(\[.*\]|\\.|.)$/;

function extractRegex(highlight: string): string | null {
  if (
    highlight.charAt(0) !== '/' ||
    highlight.charAt(highlight.length - 1) !== '/'
  ) {
    return null;
  }
  const expr = highlight.substring(1, highlight.length - 1);
  if (oneCharacterRegex.test(expr)) {
    return null;
  }
  return expr;
}

function TextHighlightSetting(props) {
  const { id, ...rest } = props;
  const {
    highlights: { highlightSettingById },
    updateHighlight,
    removeHighlight,
  } = useHighlights();
  const {
    enabled,
    highlightColor,
    highlightText,
    highlightWholeMessage,
    matchWord,
    matchCase,
    playSound,
    soundFile,
    soundVolume,
    jobFilter,
    characterFilter,
  } = highlightSettingById[id];
  const currentCharacter = useAtomValue(currentCharacterAtom);
  const characterProfiles = useAtomValue(characterProfilesAtom);
  const jobsPopover = useRef<{ close: () => void }>(null);
  const jobCount = jobFilter.split(',').filter((str) => str.trim()).length;

  // Known characters plus any selected names no longer in the save slots,
  // so stale selections stay visible and can be unchecked
  const selectableCharacters = useMemo(() => {
    const known = new Set([...characterProfiles, ...characterFilter]);
    if (currentCharacter) {
      known.add(currentCharacter);
    }
    return [...known];
  }, [characterProfiles, characterFilter, currentCharacter]);

  function toggleCharacter(name: string): void {
    const draft = characterFilter.includes(name)
      ? characterFilter.filter((entry) => entry !== name)
      : [...characterFilter, name];
    updateHighlight({
      id,
      characterFilter: draft,
    });
  }

  const highlightRegex = useMemo(
    () => extractRegex(highlightText),
    [highlightText],
  );

  const isRegexValid = useMemo(() => {
    if (!highlightRegex) return true;
    try {
      new RegExp(highlightRegex, 'g');
      return true;
    } catch {
      return false;
    }
  }, [highlightRegex]);

  return (
    <Stack.Item {...rest}>
      <Stack mb={1} color="label" align="baseline">
        <Stack.Item grow>
          <Button.Checkbox
            checked={!!enabled}
            mr="5px"
            onClick={() =>
              updateHighlight({
                id,
                enabled: !enabled,
              })
            }
          >
            已启用
          </Button.Checkbox>
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            checked={highlightWholeMessage}
            tooltip="选中后，整条消息都会以黄色高亮显示。"
            onClick={() =>
              updateHighlight({
                id,
                highlightWholeMessage: !highlightWholeMessage,
              })
            }
          >
            整条消息
          </Button.Checkbox>
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            checked={matchWord}
            tooltipPosition="bottom-start"
            tooltip="选中后，仅完全匹配的词语（前后没有额外字母）才会触发高亮。不兼容标点符号；使用正则表达式时此选项无效。"
            disabled={!!highlightRegex}
            onClick={() =>
              updateHighlight({
                id,
                matchWord: !matchWord,
              })
            }
          >
            精确匹配
          </Button.Checkbox>
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            tooltip="选中后，高亮匹配会区分大小写。"
            checked={matchCase}
            onClick={() =>
              updateHighlight({
                id,
                matchCase: !matchCase,
              })
            }
          >
            区分大小写
          </Button.Checkbox>
        </Stack.Item>

        <Stack.Item>
          <Button.Checkbox
            checked={!!playSound}
            tooltip="If this option is selected, a sound will play when the highlight is triggered."
            onClick={() =>
              updateHighlight({
                id,
                playSound: !playSound,
              })
            }
          >
            Sound
          </Button.Checkbox>
        </Stack.Item>

        <Stack.Item>
          <Box>
            <Dropdown
              width="160px"
              options={HIGHLIGHT_SOUND_OPTIONS.map((option) => option.label)}
              selected={
                HIGHLIGHT_SOUND_OPTIONS.find(
                  (option) => option.value === soundFile,
                )?.label ?? 'Beep'
              }
              disabled={!playSound}
              onSelected={(label) => {
                const option = HIGHLIGHT_SOUND_OPTIONS.find(
                  (item) => item.label === label,
                );
                if (!option) {
                  return;
                }
                updateHighlight({
                  id,
                  soundFile: option.value,
                });
              }}
            />
          </Box>
        </Stack.Item>

        <Stack.Item>
          <Knob
            minValue={0}
            maxValue={1}
            value={soundVolume}
            step={0.01}
            stepPixelSize={1}
            style={{
              opacity: playSound ? 1 : 0.45,
              pointerEvents: playSound ? 'auto' : 'none',
            }}
            format={(value) => `${toFixed(value * 100)}%`}
            onChange={(_event, value) => {
              if (!playSound) {
                return;
              }
              updateHighlight({
                id,
                soundVolume: value,
              });
            }}
          />
        </Stack.Item>

        <Stack.Item>
          <ColorBox mr={1} color={highlightColor} />
          <Input
            width="5em"
            monospace
            placeholder="#ffffff"
            value={highlightColor}
            onBlur={(value) =>
              updateHighlight({
                id,
                highlightColor: value,
              })
            }
          />
        </Stack.Item>
      </Stack>
      <Stack mb={1} color="label" align="baseline">
        <Stack.Item grow>
          <Floating
            placement="bottom-start"
            contentClasses="Dropdown__menu--wrapper"
            content={
              <div className="Dropdown__menu">
                {selectableCharacters.map((name) => (
                  <div key={name}>
                    <Button.Checkbox
                      checked={characterFilter.includes(name)}
                      onClick={() => toggleCharacter(name)}
                    >
                      {name}
                    </Button.Checkbox>
                  </div>
                ))}
                {selectableCharacters.length === 0 && (
                  <Box p={0.5} fontSize="0.9em" color="label">
                    暂无已知角色。
                    <br />
                    加入游戏一次即可填充此列表。
                  </Box>
                )}
              </div>
            }
          >
            <Box inline>
              <Button color="transparent" icon="user">
                {characterFilter.length
                  ? `角色：${characterFilter.length}`
                  : '角色：全部'}
              </Button>
            </Box>
          </Floating>
          <Floating
            ref={jobsPopover}
            placement="bottom-start"
            contentClasses="Dropdown__menu--wrapper"
            contentStyles={{ width: '20em' }}
            content={
              <div className="Dropdown__menu">
                <Input
                  fluid
                  placeholder="职业原名，例如 Captain, Assistant"
                  value={jobFilter}
                  onBlur={(value) =>
                    updateHighlight({
                      id,
                      jobFilter: value,
                    })
                  }
                  onEnter={(value) => {
                    updateHighlight({
                      id,
                      jobFilter: value,
                    });
                    jobsPopover.current?.close();
                  }}
                />
              </div>
            }
          >
            <Box inline>
              <Button color="transparent" icon="user-tag">
                {jobCount ? `职业：${jobCount}` : '职业：全部'}
              </Button>
            </Box>
          </Floating>
        </Stack.Item>
        <Stack.Item>
          <Button
            color="transparent"
            icon="times"
            onClick={() => removeHighlight(id)}
          >
            删除
          </Button>
        </Stack.Item>
      </Stack>
      <TextArea
        fluid
        height="3em"
        value={highlightText}
        placeholder="在此输入要高亮的词语，用英文逗号分隔，例如：词语1, 词语2, 词语3"
        style={{ border: isRegexValid ? '' : '1px solid red' }}
        onBlur={(value) =>
          updateHighlight({
            id: id,
            highlightText: value,
          })
        }
      />
    </Stack.Item>
  );
}
