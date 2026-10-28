import {
  AnimatedNumber,
  Button,
  LabeledList,
  NoticeBox,
  Section,
} from 'tgui-core/components';
import { formatMoney } from 'tgui-core/format';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  current_balance: number;
  siphoning: BooleanLike;
  station_name: string;
};

export const BankMachine = (props) => {
  const { act, data } = useBackend<Data>();
  const { current_balance, siphoning, station_name } = data;

  return (
    <Window width={350} height={155}>
      <Window.Content>
        <NoticeBox danger>仅限授权人员使用</NoticeBox>
        <Section title={`${station_name}金库`}>
          <LabeledList>
            <LabeledList.Item
              label="当前余额"
              buttons={
                <Button
                  icon={siphoning ? 'times' : 'sync'}
                  content={siphoning ? '停止抽取' : '抽取信用点'}
                  selected={siphoning}
                  onClick={() => act(siphoning ? 'halt' : 'siphon')}
                />
              }
            >
              <AnimatedNumber
                value={current_balance}
                format={(value) => formatMoney(value)}
              />
              {' 信用点'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
