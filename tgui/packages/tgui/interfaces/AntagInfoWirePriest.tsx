import { BlockQuote, Section, Stack } from 'tgui-core/components';

import { Window } from '../layouts';

const tipstyle = {
  color: 'white',
};

const noticestyle = {
  color: 'lightblue',
};

export const AntagInfoWirePriest = (props) => {
  return (
    <Window width={660} height={660}>
      <Window.Content backgroundColor="#0d0d0d">
        <Stack fill>
          <Stack.Item width="50%">
            <Section fill>
              <Stack vertical fill>
                <Stack.Item fontSize="25px">你是线缆祭司</Stack.Item>
                <Stack.Item>
                  <BlockQuote>
                    你是血肉心智的一部分，这意味着所有血肉心智
                    实体、结构和生物都是你的盟友。你不得
                    攻击它们。你必须扮演血肉心智的一员。
                    你的首要目标是转化其他宿主，
                    并传播血肉。
                  </BlockQuote>
                </Stack.Item>
                <Stack.Divider />
                <Stack.Item textColor="label">
                  <span style={tipstyle}>创造：&ensp;</span>
                  创建科技结构、基础结构和线缆蔓，
                  帮助保卫并传播血肉心智。这些结构的可用性
                  取决于核心当前的等级。
                  <br />
                  <br />
                  <span style={tipstyle}>保卫：&ensp;</span>
                  呼叫血肉增援，使用你的刀保护
                  核心。记住，如果你死去，就不再忠于
                  你珍视的血肉心智。用生命保护它。
                  <br />
                  <br />
                  <span style={tipstyle}>转化：&ensp;</span>
                  使用机械转化者转化空间站居民，并通过
                  呼叫血肉增援能力集结他们。你独自一人或许弱小，
                  但人数众多时就能轻易压倒船员。
                  <br />
                  <br />
                  <span style={tipstyle}>交流：&ensp;</span>
                  使用血肉通讯能力，与同样受启迪的
                  同伴交流。毕竟，沟通至关重要。
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
