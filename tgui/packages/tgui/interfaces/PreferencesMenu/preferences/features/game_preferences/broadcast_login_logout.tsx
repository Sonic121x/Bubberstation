import { CheckboxInput, type FeatureToggle } from '../base';

export const broadcast_login_logout: FeatureToggle = {
  name: '广播登录和退出',
  category: 'GAMEPLAY',
  description: `
    启用后，断线和重新连接时会向亡者频道发送公告。
  `,
  component: CheckboxInput,
};
