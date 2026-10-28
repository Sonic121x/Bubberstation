import type { BooleanLike } from 'tgui-core/react';

export type Prey = {
  name: string;
  ref: string;
  appearance: string;
  absorbed: BooleanLike;
};

export enum DigestMode {
  Safe = 'Safe',
  Digest = 'Digest',
  Absorb = 'Absorb',
  Unabsorbed = 'Unabsorb',
}

export type Belly = {
  index: number;
  name: string;
  desc: string;
  ref: string;
  contents: Prey[];
  digest_mode: DigestMode;
  burn_damage: number;
  brute_damage: number;
  can_taste: BooleanLike;
  insert_verb: string;
  release_verb: string;
  muffles_radio: BooleanLike;
  escape_chance: number;
  escape_time: number;
  overlay_path: string | null;
  overlay_color: string;
  fancy_sounds: BooleanLike;
  insert_sound: string;
  release_sound: string;
  is_wet: BooleanLike;
  wet_loop: BooleanLike;
  messages: { [key: string]: string[] };
};

export type PreyBellyView = Omit<Belly, 'index' | 'ref'> & {
  owner_name: string;
};

export type FullscreenOverlay = {
  path: string;
  name: string;
  icon: string;
  icon_state: string;
  recolorable: BooleanLike;
};

export type Data = {
  max_bellies: number;
  max_prey: number;
  max_verb_length: number;
  max_vore_message_length: number;
  min_vore_message_length: number;
  max_burn_damage: number;
  max_brute_damage: number;
  max_escape_time: number;
  min_escape_time: number;
  selected_belly: number;
  bellies: Belly[];
  preferences: { [key: string]: any };
  current_slot: string;
  inside: PreyBellyView | null;
  character_slots: string[] | null;
  vore_slots: { [key: string]: number } | null;
  lookup_table: { [key: string]: number } | null;
  available_overlays: FullscreenOverlay[];
  not_our_owner: BooleanLike;
};

export const digestModeToPreyMode = {
  [DigestMode.Safe]: { text: '被容纳着。', color: 'good' },
  [DigestMode.Digest]: { text: '被消化着。', color: 'bad' },
  [DigestMode.Absorb]: { text: '被吸收着。', color: 'purple' },
  [DigestMode.Unabsorbed]: { text: '在重塑身体。', color: 'good' },
};

export const bellyKeyToText = {
  digest_messages_pred: '消化消息（主人）',
  digest_messages_prey: '消化消息（猎物）',
  absorb_messages_owner: '吸收消息（主人）',
  absorb_messages_prey: '吸收消息（猎物）',
  unabsorb_messages_owner: '解除吸收消息（主人）',
  unabsorb_messages_prey: '解除吸收消息（猎物）',
  struggle_messages_outside: '挣扎消息（外部）',
  struggle_messages_inside: '挣扎消息（内部）',
  absorbed_struggle_messages_outside: '被吸收后的挣扎消息（外部）',
  absorbed_struggle_messages_inside: '被吸收后的挣扎消息（内部）',
  escape_attempt_messages_owner: '尝试逃脱消息（主人）',
  escape_attempt_messages_prey: '尝试逃脱消息（猎物）',
  escape_messages_owner: '逃脱消息（主人）',
  escape_messages_prey: '逃脱消息（猎物）',
  escape_messages_outside: '逃脱消息（外部）',
  escape_fail_messages_owner: '逃脱失败消息（主人）',
  escape_fail_messages_prey: '逃脱失败消息（猎物）',
};
