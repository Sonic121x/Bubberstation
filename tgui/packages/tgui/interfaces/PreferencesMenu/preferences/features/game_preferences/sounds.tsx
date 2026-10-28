import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  FeatureSliderInput,
  type FeatureToggle,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const sound_ambience_volume: Feature<number> = {
  name: '环境音量',
  category: 'SOUND',
  description: `环境音指偶尔播放、较为明显的环境声音。`,
  component: FeatureSliderInput,
};

export const sound_breathing: FeatureToggle = {
  name: '启用呼吸声',
  category: 'SOUND',
  description: '启用后，使用内置供气时会听见呼吸声。',
  component: CheckboxInput,
};

export const sound_announcements: FeatureToggle = {
  name: '启用公告音效',
  category: 'SOUND',
  description: '启用后，播放指挥报告、通知等消息的音效。',
  component: CheckboxInput,
};

export const sound_ghost_poll_prompt: FeatureChoiced = {
  name: '幽灵招募提示音',
  category: 'SOUND',
  description: '选择收到幽灵招募时播放的提示音。',
  component: FeatureDropdownInput,
};

export const sound_ghost_poll_prompt_volume: Feature<number> = {
  name: '幽灵招募提示音量',
  category: 'SOUND',
  description: '幽灵招募提示音的播放音量。',
  component: FeatureSliderInput,
};

export const sound_combatmode: FeatureToggle = {
  name: '启用战斗模式音效',
  category: 'SOUND',
  description: '启用后，切换战斗模式时播放音效。',
  component: CheckboxInput,
};

export const sound_instruments: Feature<number> = {
  name: '乐器音量',
  category: 'SOUND',
  description: '乐器的播放音量。',
  component: FeatureSliderInput,
};

export const sound_jukebox: Feature<number> = {
  name: '点唱机音量',
  category: 'SOUND',
  description: '点唱机曲目的播放音量。',
  component: FeatureSliderInput,
};

export const sound_tts: FeatureChoiced = {
  name: '启用语音合成',
  category: 'SOUND',
  description: `
    启用后，可以听到游戏中的文字转语音。
    设为“短音”时，会使用基于所选音色的短音代替语音。
  `,
  component: FeatureDropdownInput,
};

export const sound_tts_radio: FeatureChoiced = {
  name: '启用无线电语音合成',
  category: 'SOUND',
  description: `
    启用后，可以听到无线电频道中的文字转语音。
    设为“仅部门无线电”时，仅为公共频道以外的部门频道播放语音。
    关闭后，不播放来自无线电的文字转语音。
  `,
  component: FeatureDropdownInput,
};

export const sound_tts_hear_self_radio: FeatureToggle = {
  name: '在无线电中听见自己的合成语音',
  category: 'SOUND',
  description: '启用后，在文字转语音和无线电语音合成均开启时，可以听到自己的无线电语音。',
  component: CheckboxInput,
};

export const sound_tts_volume: Feature<number> = {
  name: '语音合成音量',
  category: 'SOUND',
  description: '文字转语音的播放音量。',
  component: FeatureSliderInput,
};

export const sound_tts_radio_volume: Feature<number> = {
  name: '无线电语音合成音量',
  category: 'SOUND',
  description: '无线电文字转语音的播放音量，独立于普通语音合成音量。',
  component: FeatureSliderInput,
};

export const sound_lobby_volume: Feature<number> = {
  name: '大厅音乐音量',
  category: 'SOUND',
  component: FeatureSliderInput,
};

export const sound_midi: Feature<number> = {
  name: '管理员音乐音量',
  category: 'SOUND',
  description: '管理员播放的音乐音量。',
  component: FeatureSliderInput,
};

export const sound_ship_ambience_volume: Feature<number> = {
  name: '飞船背景音量',
  category: 'SOUND',
  description: `飞船背景音指循环播放的低沉嗡鸣声。`,
  component: FeatureSliderInput,
};

export const sound_achievement: FeatureChoiced = {
  name: '成就解锁音效',
  category: 'SOUND',
  description: `
    解锁成就时播放的音效。
    关闭后不播放声音。
  `,
  component: FeatureDropdownInput,
};

export const sound_radio_noise: Feature<number> = {
  name: '无线电提示音量',
  category: 'SOUND',
  description: '发送或接收无线电消息时播放的提示音量。',
  component: FeatureSliderInput,
};

export const sound_ai_vox: Feature<number> = {
  name: 'AI VOX 公告音量',
  category: 'SOUND',
  description: 'AI 语音公告（也称为 VOX）的音量。',
  component: FeatureSliderInput,
};
