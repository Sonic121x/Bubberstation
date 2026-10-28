import { useState } from 'react';
import { Box, Button, Input, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  comments: string;
  description: string;
  name: string;
};

const PAI_DESCRIPTION = `个人AI是能够进行细致交流的先进机型，
其设计目的是协助主人工作。
它们没有双手，因此无法操作设备或物品。
处于全息形态时，你不会被直接杀死，但可能丧失行动能力。`;

const PAI_RULES = `你应当进行一定程度的角色扮演。请注意：
不填写信息可能导致无人选择你。点击提交，
即可通知个人AI卡你已成为候选者。`;

export const PaiSubmit = (props) => {
  const { data } = useBackend<Data>();
  const { comments, description, name } = data;
  const [input, setInput] = useState({
    comments,
    description,
    name,
  });

  return (
    <Window width={400} height={460} title="个人AI候选菜单">
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item grow>
            <DetailsDisplay />
          </Stack.Item>
          <Stack.Item>
            <InputDisplay input={input} setInput={setInput} />
          </Stack.Item>
          <Stack.Item>
            <ButtonsDisplay input={input} />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

/** Displays basic info about playing pAI */
const DetailsDisplay = (props) => {
  return (
    <Section fill scrollable title="说明">
      <Box color="label">
        {PAI_DESCRIPTION}
        <br />
        <br />
        {PAI_RULES}
      </Box>
    </Section>
  );
};

/** Input boxes for submission details */
const InputDisplay = (props) => {
  const { input, setInput } = props;
  const { name, description, comments } = input;

  return (
    <Section fill title="填写信息">
      <Stack fill vertical>
        <Stack.Item>
          <Box bold color="label">
            名称
          </Box>
          <Input
            fluid
            maxLength={41}
            value={name}
            onChange={(value) => setInput({ ...input, name: value })}
          />
        </Stack.Item>
        <Stack.Item>
          <Box bold color="label">
            描述
          </Box>
          <Input
            fluid
            maxLength={500} /* SKYRAT EDIT: ORIGINAL 100 */
            value={description}
            onChange={(value) => setInput({ ...input, description: value })}
          />
        </Stack.Item>
        <Stack.Item>
          <Box bold color="label">
            OOC备注
          </Box>
          <Input
            fluid
            maxLength={100}
            value={comments}
            onChange={(value) => setInput({ ...input, comments: value })}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

/** Gives the user a submit button */
const ButtonsDisplay = (props) => {
  const { act } = useBackend<Data>();
  const { input } = props;
  const { comments, description, name } = input;

  return (
    <Section fill>
      <Stack>
        <Stack.Item>
          <Button
            onClick={() => act('save', { comments, description, name })}
            tooltip="将候选信息保存到本地。"
          >
            保存
          </Button>
        </Stack.Item>
        <Stack.Item>
          <Button
            onClick={() => act('load')}
            tooltip="读取已保存的候选信息（如有）。"
          >
            读取
          </Button>
        </Stack.Item>
        <Stack.Item>
          <Button
            onClick={() =>
              act('submit', {
                comments,
                description,
                name,
              })
            }
          >
            提交
          </Button>
        </Stack.Item>
        <Stack.Item>
          <Button
            onClick={() => act('withdraw')}
            tooltip="撤回你的个人AI候选申请（如有）。"
          >
            撤回
          </Button>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
