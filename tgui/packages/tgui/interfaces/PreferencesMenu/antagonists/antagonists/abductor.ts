import { type Antagonist, Category } from '../base';

const Abductor: Antagonist = {
  key: 'abductor',
  name: '绑架者',
  description: [
    `
      绑架者来自科技先进的外星社会，致力于编目记录
      星系内的全部物种。不幸的是，他们的研究方法
      对实验对象颇具侵入性。
    `,

    `
      你和搭档将组成绑架者科学家与特工二人组。
      特工负责绑架毫无戒备的受害者，将其带回飞碟。
      科学家负责为特工物色目标、保障特工安全，
      并为带回的受害者进行手术。
    `,
  ],
  category: Category.Midround,
};

export default Abductor;
