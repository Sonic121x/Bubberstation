/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const THEMES = ['light', 'dark'] as const;

export const COLORS = {
  DARK: {
    BG_BASE: '#202020',
    BG_SECOND: '#151515',
    BUTTON: '#404040',
    TEXT: '#A6A6A6',
    TEXT_IMPORTANT: '#A6A6A6',
    BG_IMPORTANT: '#492020',
  },
  LIGHT: {
    BG_BASE: '#EEEEEE',
    BG_SECOND: '#FFFFFF',
    BUTTON: '#FFFFFF',
    TEXT: '#000000',
    TEXT_IMPORTANT: '#A6A6A6',
    BG_IMPORTANT: '#910707',
  },
} as const;

export const SETTINGS_TABS = [
  {
    id: 'general',
    name: '常规',
  },

  {
    id: 'textHighlight',
    name: '文本高亮',
  },
  {
    id: 'chatPage',
    name: '聊天标签页',
  },
  {
    id: 'statPanel',
    name: '状态面板',
  },
  {
    id: 'websocket',
    name: 'WebSocket',
  },
] as const;

export const FONTS_DISABLED = 'Default';

export const FONTS = [
  FONTS_DISABLED,
  'Verdana',
  'Arial',
  'Arial Black',
  'Comic Sans MS',
  'Impact',
  'Lucida Sans Unicode',
  'Tahoma',
  'Trebuchet MS',
  'Courier New',
  'Lucida Console',
] as const;

export const WARN_AFTER_HIGHLIGHT_AMT = 10;
