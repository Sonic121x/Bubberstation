import { useState } from 'react';
import {
  Box,
  Button,
  Collapsible,
  Divider,
  Icon,
  Input,
  NumberInput,
  Section,
  Stack,
  TextArea,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

type Data = {
  active_bets: ActiveBets[];
  bank_name: string;
  bank_money: number;
  can_create_bet: BooleanLike;
  max_title_length: number;
  max_description_length: number;
};

type ActiveBets = {
  name: string;
  description: string;
  owner: BooleanLike;
  creator: string;
  current_bets: CurrentBets[];
  locked: BooleanLike;
};

type CurrentBets = {
  option_name: string;
  total_amount: number;
  personally_invested: number;
};

export const NtosSpaceBetting = () => {
  const { act, data } = useBackend<Data>();
  const { bank_name, bank_money, can_create_bet } = data;
  return (
    <NtosWindow width={500} height={620}>
      <NtosWindow.Content scrollable>
        <Section title="用户信息">
          <Stack>
            <Stack.Item mr={1.5}>
              <Icon
                name="id-card"
                size={3}
                mr={1}
                color={bank_name ? 'green' : 'red'}
              />
            </Stack.Item>
            <Stack fill vertical>
              <Stack.Item>用户名：{bank_name}</Stack.Item>
              <Stack.Item>可用余额：{bank_money} 信用点</Stack.Item>
            </Stack>
          </Stack>
        </Section>
        <PollsSection />
        {!!can_create_bet && <BettingCreation />}
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const PollsSection = () => {
  const { act, data } = useBackend<Data>();
  const { active_bets = [] } = data;
  const [Winner, set_winner] = useState('');
  return (
    <Section>
      {!active_bets.length ? (
        <Box>
          目前没有可下注的竞猜，在下方创建一个吧！
        </Box>
      ) : (
        active_bets.map(
          (
            { name, description, owner, creator, current_bets = [], locked },
            index,
          ) => (
            <Section title={`${name} - 创建者：${creator}`} key={name}>
              <Stack>
                <Stack.Item grow>
                  <Stack.Item grow>{description}</Stack.Item>
                  <Divider />
                  {current_bets.map(
                    (
                      { option_name, total_amount, personally_invested },
                      index,
                    ) => (
                      <Stack.Item
                        grow
                        key={option_name}
                        className="candystripe"
                        my={1.5}
                      >
                        <Stack.Item>
                          <Stack.Item my={1}>
                            {option_name}（已下注 {total_amount || 0} 信用点）
                            {!owner ? (
                              <NumberInput
                                value={personally_invested}
                                unit="cr"
                                width="15px"
                                disabled={!!locked}
                                minValue={0}
                                maxValue={10000}
                                step={1}
                                onChange={(value) =>
                                  act('place_bet', {
                                    bet_selected: name,
                                    option_selected: option_name,
                                    money_betting: value,
                                  })
                                }
                              />
                            ) : (
                              <Button.Checkbox
                                tooltip="此选项是否为获胜结果。"
                                checked={Winner === option_name}
                                key={option_name}
                                onClick={() => set_winner(option_name)}
                              />
                            )}
                          </Stack.Item>
                        </Stack.Item>
                      </Stack.Item>
                    ),
                  )}
                  {!!owner &&
                    (!locked ? (
                      <Stack.Item>
                        <Button.Confirm
                          fluid
                          icon="minus"
                          tooltip="禁止继续下注或撤回赌注。此操作不可撤销！"
                          onClick={() =>
                            act('lock_betting', { bet_selected: name })
                          }
                        >
                          封盘
                        </Button.Confirm>
                      </Stack.Item>
                    ) : (
                      <Button.Confirm
                        fluid
                        icon="plus"
                        tooltip="结算竞猜，将勾选的选项设为获胜结果。"
                        onClick={() =>
                          act('select_winner', {
                            bet_selected: name,
                            winning_answer: Winner,
                          })
                        }
                      >
                        结算结果
                      </Button.Confirm>
                    ))}
                </Stack.Item>
                <Stack.Item>
                  <Button
                    fluid
                    icon="minus"
                    disabled={locked}
                    tooltip="撤回您在此竞猜中的全部赌注并退还金额。"
                    onClick={() => act('cancel_bet', { bet_selected: name })}
                  >
                    撤回赌注
                  </Button>
                </Stack.Item>
              </Stack>
            </Section>
          ),
        )
      )}
    </Section>
  );
};

export const BettingCreation = () => {
  const { act, data } = useBackend<Data>();
  const { max_title_length, max_description_length } = data;
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [option1, setOption1] = useState('');
  const [option2, setOption2] = useState('');
  const [option3, setOption3] = useState('');
  const [option4, setOption4] = useState('');

  return (
    <Collapsible title="创建竞猜">
      <Stack fill vertical>
        <Stack.Item grow>
          <Input
            fluid
            placeholder="标题"
            maxLength={max_title_length}
            onChange={setTitle}
          />
        </Stack.Item>
        <Stack.Item grow>
          <TextArea
            fluid
            placeholder="描述"
            height="100px"
            width="100%"
            maxLength={max_description_length}
            backgroundColor="black"
            textColor="white"
            onChange={setDescription}
          />
        </Stack.Item>
        <Input
          fluid
          placeholder="选项 1"
          maxLength={max_title_length}
          onChange={setOption1}
        />
        <Input
          fluid
          placeholder="选项 2"
          maxLength={max_title_length}
          onChange={setOption2}
        />
        <Input
          fluid
          placeholder="选项 3（可选）"
          maxLength={max_title_length}
          onChange={setOption3}
        />
        <Input
          fluid
          placeholder="选项 4（可选）"
          maxLength={max_title_length}
          onChange={setOption4}
        />
        <Stack.Item grow>
          <Button
            fluid
            onClick={() =>
              act('create_bet', {
                title,
                description,
                option1,
                option2,
                option3,
                option4,
              })
            }
          >
            创建竞猜！
          </Button>
        </Stack.Item>
      </Stack>
    </Collapsible>
  );
};
