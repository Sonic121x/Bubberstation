/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const MAX_VISIBLE_MESSAGES = 2500;
export const MAX_PERSISTED_MESSAGES = 1000;
export const MESSAGE_SAVE_INTERVAL = 10000;
export const MESSAGE_PRUNE_INTERVAL = 60000;
export const COMBINE_MAX_MESSAGES = 5;
export const COMBINE_MAX_TIME_WINDOW = 5000;
export const IMAGE_RETRY_DELAY = 250;
export const IMAGE_RETRY_LIMIT = 10;
export const IMAGE_RETRY_MESSAGE_AGE = 60000;

// Default message type
export const MESSAGE_TYPE_UNKNOWN = 'unknown';

// Internal message type
export const MESSAGE_TYPE_INTERNAL = 'internal';

// Must match the set of defines in code/__DEFINES/chat.dm
export const MESSAGE_TYPE_SYSTEM = 'system';
export const MESSAGE_TYPE_LOCALCHAT = 'localchat';
export const MESSAGE_TYPE_RADIO = 'radio';
export const MESSAGE_TYPE_ENTERTAINMENT = 'entertainment';
export const MESSAGE_TYPE_INFO = 'info';
export const MESSAGE_TYPE_WARNING = 'warning';
export const MESSAGE_TYPE_DEADCHAT = 'deadchat';
export const MESSAGE_TYPE_OOC = 'ooc';
export const MESSAGE_TYPE_ADMINPM = 'adminpm';
export const MESSAGE_TYPE_COMBAT = 'combat';
export const MESSAGE_TYPE_ADMINCHAT = 'adminchat';
export const MESSAGE_TYPE_MODCHAT = 'modchat';
export const MESSAGE_TYPE_PRAYER = 'prayer';
export const MESSAGE_TYPE_EVENTCHAT = 'eventchat';
export const MESSAGE_TYPE_ADMINLOG = 'adminlog';
export const MESSAGE_TYPE_ATTACKLOG = 'attacklog';
export const MESSAGE_TYPE_DEBUG = 'debug';
// BUBBER EDIT ADDITION BEGIN
export const MESSAGE_TYPE_MENTOR = 'mentor';
export const MESSAGE_TYPE_LOOC = 'looc';
export const MESSAGE_TYPE_REMOTE_LOOC = 'rlooc';
export const MESSAGE_TYPE_SUBTLE = 'subtle';
// BUBBER EDIT ADDITION END

type MessageType = {
  type: string;
  name: string;
  description: string;
} & Partial<{
  selector: string;
  important: boolean;
  admin: boolean;
}>;

// Metadata for each message type
export const MESSAGE_TYPES: MessageType[] = [
  // Always-on types
  {
    type: MESSAGE_TYPE_SYSTEM,
    name: '系统消息',
    description: '来自客户端的消息，始终显示',
    selector: '.boldannounce',
    important: true,
  },
  // Basic types
  {
    type: MESSAGE_TYPE_LOCALCHAT,
    name: '本地',
    description: '本地角色内消息（说话、动作等）',
    selector: '.say, .emote',
  },
  {
    type: MESSAGE_TYPE_RADIO,
    name: '无线电',
    description: '所有部门的无线电消息',
    selector:
      '.alert, .minorannounce, .syndradio, .centcomradio, .aiprivradio, .comradio, .secradio, .gangradio, .engradio, .medradio, .sciradio, .suppradio, .servradio, .radio, .deptradio, .binarysay, .resonate, .abductor, .alien, .changeling',
  },
  {
    type: MESSAGE_TYPE_ENTERTAINMENT,
    name: '娱乐',
    description: '娱乐及新闻终端广播',
    selector: '.enteradio, .newscaster',
  },
  {
    type: MESSAGE_TYPE_INFO,
    name: '信息',
    description: '游戏和物品发出的非紧急消息',
    selector:
      '.notice:not(.pm), .adminnotice, .info, .sinister, .cult, .infoplain, .announce, .hear, .smallnotice, .holoparasite, .boldnotice',
  },
  {
    type: MESSAGE_TYPE_WARNING,
    name: '警告',
    description: '游戏和物品发出的紧急消息',
    selector:
      '.warning:not(.pm), .critical, .userdanger, .italics, .alertsyndie, .warningplain',
  },
  {
    type: MESSAGE_TYPE_DEADCHAT,
    name: '亡者频道',
    description: '所有亡者聊天消息',
    selector: '.deadsay, .ghostalert',
  },
  {
    type: MESSAGE_TYPE_OOC,
    name: 'OOC',
    description: '全局角色外聊天的蓝色消息墙',
    selector: '.ooc, .adminooc, .adminobserverooc, .oocplain',
  },
  // BUBBER EDIT ADDITION BEGIN
  {
    type: MESSAGE_TYPE_LOOC,
    name: 'LOOC',
    description: '本地角色外消息。',
    selector: '.looc',
  },
  {
    type: MESSAGE_TYPE_SUBTLE,
    name: '细微动作',
    description: '细微及更细微的动作。',
    selector: '.subtle, .subtler',
  },
  {
    type: MESSAGE_TYPE_MENTOR,
    name: '导师日志',
    description: '导师私信及其他导师相关消息。',
    selector: '.mentor, .mentornotice',
  },
  // BUBBER EDIT ADDITION END
  {
    type: MESSAGE_TYPE_ADMINPM,
    name: '管理员私信',
    description: '与管理员之间的消息（管理员求助）',
    selector: '.pm, .adminhelp',
  },
  {
    type: MESSAGE_TYPE_COMBAT,
    name: '战斗日志',
    description: '叛徒乌里斯特用刀刺中了你！',
    selector: '.danger',
  },
  {
    type: MESSAGE_TYPE_UNKNOWN,
    name: '未分类',
    description: '所有无法分类的消息，始终显示',
  },
  // Admin stuff
  {
    type: MESSAGE_TYPE_ADMINCHAT,
    name: '管理员聊天',
    description: 'ASAY 消息',
    selector: '.admin_channel, .adminsay',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_MODCHAT,
    name: '协管员聊天',
    description: 'MSAY 消息',
    selector: '.mod_channel',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_PRAYER,
    name: '祈祷',
    description: '玩家发出的祈祷',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_ADMINLOG,
    name: '管理员日志',
    description: '管理员日志：管理员乌里斯特跳转到了坐标 X、Y、Z',
    selector: '.log_message',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_ATTACKLOG,
    name: '攻击日志',
    description: '叛徒乌里斯特射击了张三',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_DEBUG,
    name: '调试日志',
    description: '调试：SSPlanets 子系统执行 Recover()。',
    admin: true,
  },
  // BUBBER EDIT ADDITION BEGIN
  {
    type: MESSAGE_TYPE_REMOTE_LOOC,
    name: '远程 LOOC',
    description: '没错，无论你在哪里，管理员都能阅读你的 LOOC 消息。',
    selector: '.rlooc',
    admin: true,
  },
  // BUBBER EDIT ADDITION END
];
