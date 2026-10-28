import { type Antagonist, Category } from '../base';

const SpaceNinja: Antagonist = {
  key: 'spaceninja',
  name: '太空忍者',
  description: [
    `
      蜘蛛氏族通过改造人体来追求更加完美的存在，
      并恪守后现代太空武士道。
    `,

    `
      成为狡黠的太空忍者，配备武士刀、可入侵气闸和区域电力
      控制器的手套，以及能让你近乎隐形的忍者服，
      还拥有多种能力。入侵通缉控制台，
      将所有人标记为待逮捕，甚至入侵通讯控制台，
      召来更多威胁，让空间站陷入混乱！
    `,
  ],
  category: Category.Midround,
};

export default SpaceNinja;
