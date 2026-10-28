import { binaryInsertWith } from 'common/collections';
import type { ReactNode } from 'react';
import { useBackend } from 'tgui/backend';
import { Box, Dropdown, Flex } from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import type { PreferencesMenuData } from '../../../types';
import {
  CheckboxInput,
  type FeatureChoiced,
  type FeatureChoicedServerData,
  type FeatureToggle,
  type FeatureValueProps,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const ghost_accs: FeatureChoiced = {
  name: '幽灵配饰',
  category: 'GHOST',
  description: '决定你的幽灵使用哪些外观配饰。',
  component: FeatureDropdownInput,
};

type GhostForm = {
  displayText: ReactNode;
  value: string;
};

function insertGhostForm(collection: GhostForm[], value: GhostForm) {
  return binaryInsertWith(collection, value, ({ value }) => value);
}

function GhostFormInput(
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) {
  const { data } = useBackend<PreferencesMenuData>();

  const serverData = props.serverData;
  if (!serverData) {
    return;
  }

  const displayNames = serverData.display_names;
  if (!displayNames) {
    return <Box color="red">ghost_form 缺少显示名称！</Box>;
  }

  const displayTexts = {};
  let options: {
    displayText: ReactNode;
    value: string;
  }[] = [];

  for (const [name, displayName] of Object.entries(displayNames)) {
    const displayText = (
      <Flex key={name}>
        <Flex.Item>
          <Box
            className={classes([`preferences32x32`, serverData.icons![name]])}
          />
        </Flex.Item>

        <Flex.Item grow={1}>{displayName}</Flex.Item>
      </Flex>
    );

    displayTexts[name] = displayText;

    const optionEntry = {
      displayText,
      value: name,
    };

    // Put the default ghost on top
    if (name === 'ghost') {
      options.unshift(optionEntry);
    } else {
      options = insertGhostForm(options, optionEntry);
    }
  }

  return (
    <Dropdown
      autoScroll={false}
      disabled={!data.content_unlocked}
      selected={props.value}
      placeholder={displayTexts[props.value]}
      onSelected={props.handleSetValue}
      width="100%"
      options={options}
    />
  );
}

export const ghost_form: FeatureChoiced = {
  name: '幽灵形态',
  category: 'GHOST',
  description: '你的幽灵外观。需要 BYOND 会员。',
  component: GhostFormInput,
};

export const ghost_hud: FeatureToggle = {
  name: '幽灵 HUD',
  category: 'GHOST',
  description: '启用幽灵的 HUD 按钮。',
  component: CheckboxInput,
};

export const ghost_orbit: FeatureChoiced = {
  name: '幽灵环绕轨迹',
  category: 'GHOST',
  description: `
    你的幽灵环绕目标时的轨迹形状。
    需要 BYOND 会员。
  `,
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    const { data } = useBackend<PreferencesMenuData>();

    return (
      <FeatureDropdownInput {...props} disabled={!data.content_unlocked} />
    );
  },
};

export const ghost_others: FeatureChoiced = {
  name: '其他人的幽灵',
  category: 'GHOST',
  description: `
    其他人的幽灵应使用其自选外观、
    默认图像，还是始终显示为默认白色幽灵？
  `,
  component: FeatureDropdownInput,
};

export const inquisitive_ghost: FeatureToggle = {
  name: '幽灵点击查看',
  category: 'GHOST',
  description: '作为幽灵点击某个对象时会查看它。',
  component: CheckboxInput,
};

export const ghost_roles: FeatureToggle = {
  name: '接收幽灵角色通知',
  category: 'GHOST',
  description: `
    取消选择后，你将完全不再收到幽灵角色弹窗！
    变成幽灵后，所有此类弹窗
    都会被屏蔽。适合不想看到幽灵角色或
    相关弹窗的玩家，请自行权衡。
`,
  component: CheckboxInput,
};
